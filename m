Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F938DC58
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096878; cv=none; b=Gs2wukBoQMT9TBJZKn5XFcvmeBRv8hCpIXSdT5A9D/2QqFfFw2f0y3LSKew5X/TYev15AUkDrFNG310P0D2ng33f//xhIXEqhcXth/BjRE6vfCxA0CDotZTKtoOB3FVHGuPc5hbvLLAkjS9vieHSILXVgrz7hXbvEQjf8Z0WQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096878; c=relaxed/simple;
	bh=WRblBsIe9oNVkt2I3kyXT3rZMZlv0teuEBRSGedeze4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4/iLewYS3FhZOctmZaFAQDD6DiGGXUnxpxbkzK2TgCyg6wLfq83UHWaG9MOn12et7uHcu/FQcJumq2rUwStahEr+W3IUXQwVtLqW6Fw0IF95q5sTt4t/jNQ8edb1+aGWPYGlZzZP9zlvZNbYF+BWael4BHU34BMMEv8pslvPhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLbdA0yw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLbdA0yw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf452def93so15114065ad.1
        for <virtualization@lists.linux.dev>; Fri, 07 Aug 2026 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096876; x=1786701676; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHf8GCKQo1jv7HW3zO9fz6VriXYAKorx9FGJYJOkndc=;
        b=CLbdA0yw3SEtd0MU3B/fL1YR3rqe93yZgdP99cti03QB2BygU/dJOPaDPWZAyMTmns
         Sdn7xkU4ogazffazAnoATWEy9IU1X5yWqGd0zYLmrRj96FIMMUSz30KZLGq7OnVRihqf
         uln3GcWKooOL1Vgtq6aS7JUD7+l2tFZuw9Z6d+fpPE7b/8UE/kg1Uv1FLIroT6NaqThn
         78mU6ZM64evB/4XE0l8RH70R26aT9oaRPoHCf8IHv1jTK8O3OYRmRJpuMPo/KgOVArmk
         sWg/TkhAXilptQWJQWj+/sYG8NMGPx859T6Wc/WbyOC1gWNU9q56IoHranU4rLUgboCd
         R8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096876; x=1786701676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHf8GCKQo1jv7HW3zO9fz6VriXYAKorx9FGJYJOkndc=;
        b=OAdwbQmnbmULOuRwew/TcNCxyd1xOUUW84nz1wiLl7sFQeOo0STyUNFctkTA128a3b
         z3HzkbzevDAmuhOPf2F+eb9qVqs4T/9icQdrCM9x1kqyT+ig+7esIXjnotNCOflcVjrw
         hihBMPbjyQJ0vZM7Uk+vVowZjc6UpcGAlcCKkIDt5jyUeZklvPU68azoVnXE4DdXeg8g
         ySxZA8jzhXEsRofc69lcl4vmT+BgfeBEACA9dcUj7+8+CslPHxG4rNUqjqN+QhrbqWip
         XRZ7Bh2aoUQMzL+0T/cOFjZi/QsfzdLR0saTUwzRYoh/PVa4mVcupLB500f/0y68ybBe
         W6+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr/cdUmx99EkyBf82xY5V42EldSuovMEdKF8gNVr4fkj46y7xNMNuVaR+XgTMQ0YIVRQmHDeKjreESo2fMajw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRKSj4s/Waxxl8c3yVjG8iG1+70KoepSP6Apz1Xm29Xd93jl0o
	3sCA2aUTkqos0JZqbM99YjMHnonT1Iv5ky6uoOhSSvox71vRyS+eEzDV
X-Gm-Gg: AR+sD114vZW21m3egBhAXG0YXvFaPIB60LtPiq0evrrLB2NpcLMpjSxPSXvRAUDDLnq
	mqMbJxrcT9wCoOh8JYilDNwf+Z5MvvBPGCgpqwh0hXihM5cgj2QDfVgxWE9j1lMi3WczkNrmMBm
	AZ2owhj/VgUeCZGxQs86IjM2QZsBWddo97ctDLrctlJ5FtSuF6IlWci97PLvSXOgbBdJ7b10bZz
	i0IQBB50kNtsEBLjuuYPzoYp5uhlxX0ciGBSIjD8JwS4YflzLv+d4DBERzRZDQZbJ7gFeO3QzzP
	cggUPVMdPmOATB0UbPGoSEuDxeDILJxaF6tngqa2bOaPOdsdg4RUSm9/tuCBVeq3WrsISOs0Stc
	pr0MdrxGZR8uZxNw8FqMSyaAtEJeIbESJ/v/vHx1kGvh1vz2KbQqnMZeII5BKUmnbBeqxnFKpXL
	PrlzrevDrwpu++d83YO8TvKCE2pm3Jx0daW0XbycjvVBacTYGqOgJeUnu1/t+h4YOxirW4txxNO
	prgW7fK+WUcjguo3fJg+sOIsnhSgSxEsX69oKlYX1AqaEDoaT1rSwyhcQeO1AqRSw==
X-Received: by 2002:a17:903:1847:b0:2bf:13af:b077 with SMTP id d9443c01a7336-2d0f70f54bfmr62139835ad.14.1786096875757;
        Fri, 07 Aug 2026 03:01:15 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a9f0fsm6500035ad.68.2026.08.07.03.01.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Aug 2026 03:01:14 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH 2/2] vhost-vdpa: protect config_ctx from being freed under the config callback
Date: Fri,  7 Aug 2026 20:00:25 +1000
Message-ID: <20260807100025.19750-3-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807100025.19750-1-yuz08559@gmail.com>
References: <20260807100025.19750-1-yuz08559@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vdpa_config_cb() loads v->config_ctx and signals it without taking
a reference and without holding any lock:

	struct eventfd_ctx *config_ctx = v->config_ctx;

	if (config_ctx)
		eventfd_signal(config_ctx);

VHOST_VDPA_SET_CONFIG_CALL replaces that field and drops what is normally
the last reference to the old context:

	swap(ctx, v->config_ctx);

	if (ctx)
		eventfd_ctx_put(ctx);

eventfd_ctx_put() drops the last kref and frees the context immediately,
with no RCU grace period, so a callback that has already loaded the
pointer goes on to dereference freed memory.  The two sides share no
lock: the ioctl runs under vhost_dev.mutex, while the parent invokes the
callback from its own interrupt or workqueue context.

This is not the reopen refcount underflow fixed by commit f6bbf0010ba0
("vhost-vdpa: fix use-after-free of v->config_ctx"), which was about
vhost_vdpa_config_put() leaving a stale pointer behind.  Here the pointer
is maintained correctly and it is the read side that is unprotected.

With VDUSE as the parent this is reachable from userspace with access to
/dev/vduse (root by default).  VDUSE_DEV_INJECT_CONFIG_IRQ queues
dev->inject, and vduse_dev_irq_inject() runs the callback under VDUSE's
own dev->irq_lock, which vhost does not hold.  vduse_dev_reset() does
flush_work(&dev->inject), but VHOST_VDPA_SET_CONFIG_CALL never goes
through reset, so an inject already in flight is not waited for.  A
process that injects config interrupts on the VDUSE fd while another
thread swaps the call fd on the vhost-vdpa fd hits it in seconds:

  BUG: KASAN: slab-use-after-free in native_queued_spin_lock_slowpath
  Read of size 4 at addr ffff888107d21808 by task kworker/u17:1/2993
  Workqueue: vduse-irq vduse_dev_irq_inject
  Call Trace:
   native_queued_spin_lock_slowpath+0x97/0x5b0
   _raw_spin_lock_irqsave+0xd4/0xe0
   eventfd_signal_mask+0x69/0x120
   vhost_vdpa_config_cb+0x34/0x50
   vduse_dev_irq_inject+0x46/0x60
   process_one_work+0x468/0x950

  Allocated by task 2992:
   do_eventfd+0x50/0x200
   __x64_sys_eventfd2+0x2e/0x40

  Freed by task 2992:
   eventfd_ctx_put+0xb9/0xc0
   vhost_vdpa_unlocked_ioctl+0x116c/0x2190

Add a spinlock covering every access to config_ctx, so the callback
either signals a context that is still alive or observes NULL, and the
put happens only once no callback can reach the old value.

Clearing the parent's callback before the put would not be enough: of the
in-tree set_config_cb() implementations only VDUSE takes a lock, the rest
store the pointer unlocked, so that would not order against an in-flight
invocation.

Fixes: 776f395004d8 ("vhost_vdpa: Support config interrupt in vdpa")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/vhost/vdpa.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e5e47f6..272d506 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -56,6 +56,8 @@ struct vhost_vdpa {
 	int virtio_id;
 	int minor;
 	struct eventfd_ctx *config_ctx;
+	/* Serialises vhost_vdpa_config_cb() against config_ctx being replaced. */
+	spinlock_t config_lock;
 	int in_batch;
 	struct vdpa_iova_range range;
 	u32 batch_asid;
@@ -187,10 +189,12 @@ static irqreturn_t vhost_vdpa_virtqueue_cb(void *private)
 static irqreturn_t vhost_vdpa_config_cb(void *private)
 {
 	struct vhost_vdpa *v = private;
-	struct eventfd_ctx *config_ctx = v->config_ctx;
+	unsigned long flags;
 
-	if (config_ctx)
-		eventfd_signal(config_ctx);
+	spin_lock_irqsave(&v->config_lock, flags);
+	if (v->config_ctx)
+		eventfd_signal(v->config_ctx);
+	spin_unlock_irqrestore(&v->config_lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -511,15 +515,22 @@ static long vhost_vdpa_get_vring_num(struct vhost_vdpa *v, u16 __user *argp)
 
 static void vhost_vdpa_config_put(struct vhost_vdpa *v)
 {
-	if (v->config_ctx) {
-		eventfd_ctx_put(v->config_ctx);
-		v->config_ctx = NULL;
-	}
+	struct eventfd_ctx *ctx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&v->config_lock, flags);
+	ctx = v->config_ctx;
+	v->config_ctx = NULL;
+	spin_unlock_irqrestore(&v->config_lock, flags);
+
+	if (ctx)
+		eventfd_ctx_put(ctx);
 }
 
 static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 {
 	struct vdpa_callback cb;
+	unsigned long flags;
 	int fd;
 	struct eventfd_ctx *ctx;
 
@@ -532,8 +543,14 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	spin_lock_irqsave(&v->config_lock, flags);
 	swap(ctx, v->config_ctx);
+	spin_unlock_irqrestore(&v->config_lock, flags);
 
+	/*
+	 * The callback can no longer reach the old context, so this is the
+	 * last reference to it.
+	 */
 	if (ctx)
 		eventfd_ctx_put(ctx);
 
@@ -1595,6 +1612,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 	}
 
 	atomic_set(&v->opened, 0);
+	spin_lock_init(&v->config_lock);
 	v->minor = minor;
 	v->vdpa = vdpa;
 	v->nvqs = vdpa->nvqs;
-- 
2.43.0

