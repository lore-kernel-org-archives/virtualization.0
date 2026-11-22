Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795360638;
	b=ccDbmdfkclwXdug8e9BcXCQ98jFD4Qz2Zc4RHQH6UP0iWJer4woY5LxZhVLxfIzyz6+J
	 xxQo8lPa5nLavdyh/vunf3/QrgrPijoOBSPU4YASVjJdLt227r5HMtiYZsTMKEjDH1LFh
	 Ww9BDZqGDchLtOlkg+8MGJIzzMSOoXVaOox9FXCwCp6q9U9f1UGSjLIim4gFj8vNeSC6/
	 lmh+tCdWw3rWcwNerry8+Iil3t2ouDrw5iK0rN8EC/G+gzQEc0F1ajSERNk+W/LxT/UCi
	 aJ3+Aod/mzSkOGtRdqsKgbsF0z94Jlm66xajNjdRpgpLwwuWYpXxfZFkp9nojVZmKAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795360638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Ug5mbNx//jfk7IJQqQS2kOB5UthZWxihtQTk0CboWU=;
	b=SjNpqeDaEGIXEGQSYNJKGVte30yVwLNeDO8zm0J3lVPsa2rRaGbG8VKO7VTi3Z4wRkrl
	 NTwtxLMiTLk39a+E2llUeNy4lncJMWTc8uyNwRw7uU6A+QjZwmdCF3MSlb/nYGY20lMNB
	 tjEigi9k6AYjxHnlGA2OiUJEv9JsQ3n2HlBvECI/14UvrhiMQPRoSRKP3FdGcr2VRadf0
	 b+YS/rFePRAV0htCxDWlQo18uWhrFyVHwQzi83W7k4rTaV92NySQsfG6nH+Uv2zyxaAmy
	 kZEQbebI/VTOseiVM/jTzH0XEbC5g43yuH9DLa3Sf88luu1CqXO/BEomiecePP4ArUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dkAB2HVP;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4D606A32C
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 15:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F4D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dkAB2HVP
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so14893365e9.0
        for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 07:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795360636; x=1795965436; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Ug5mbNx//jfk7IJQqQS2kOB5UthZWxihtQTk0CboWU=;
        b=dkAB2HVPFs9xuDeAtYcKz4kF14MFdU4fLwBqVYxpVTUja8Xj86uVREda1L2UQuj8U+
         5iXzEcxa3xC2+EqTaMvEZB30P42qBGYzJ7oMkzXhStXALPWwrlK7DK8G8xwz7SpWozfZ
         lfFYNq+ZGB5aR/AKEgc3BuTbcItKHc6R7UFDaKZG+ntNGqp7ciP6NaElnlrqxBDhsr+A
         e2vOod1puZPsLIp4qOAjGekDgb44wUca6/hKSg8av8QQolqEuG4y2ernSHkxoqN9P00m
         n0Agqd9rtVDD8MsHljjTQaKp8O0Xr1Y3TYojU23zs+kGoINuv7R9IXTrFpeEYHvHh2DH
         c2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795360636; x=1795965436;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Ug5mbNx//jfk7IJQqQS2kOB5UthZWxihtQTk0CboWU=;
        b=gD9XXpd98Qh8MPFP51QWQVNP4V1vlc8OGxWHHhPA4nMT33l+bF/ebXGbEll9PX82Cj
         02DlIEGWTl+nmFdg0Jv4WPi15GnrPHVg0V8MUSYSdyddmTRHNre+BIn5cFy0VkwsgDjI
         vaI8jx36RXPBYrJo0GgdwSti4tX81K1TbxO90JHD4/CY9iQ3GkK8H9oEkQJ/bzzVWNxF
         ey3KocZFNBri/qP3/cNYjrxgYTUmAJ8fuNug/C+VlfBEs/UW1uaxVnjqxPYGqbt7+ht9
         BKtM6ZSZty71utsOiZKGioJ/VDTyfN5Sn/nro3jslnavAtCdY9RPC31ZNbzaqGkF3scx
         /fXQ==
X-Forwarded-Encrypted: i=1; AL+hErFGZz3YxOBpFTmU190qPAYokemQOe5ab8jmjUmeX/N52WLhL2P6zDX9O6z4m7wdBxzZLv7kf4ArEflX0Amytw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+/YnFR/ywyMVL784EnjCus1y5NCm2oGGEo8pA+Sv7puRxD6Kjp
	Zu1+xPHnPHJUeD4ozZBVM7bHhZ0YwgVn3hZA7AOkdnhTv9MkUOuu4IDF
X-Gm-Gg: AZFdTZcJjOII56HeWW+LOKpRmpgmTokZU2pm9956ehgXG/sFb1jSGqliaeVJxep7SwV
	dA5kD9bJLMf1QuIuvrEd8nRSmblfJgwTpYvmDe3Ol/8kiwmneTgwyPFFCw0YbUx2zzqmjJxE4xE
	8//mkE3YKHH6Q1gg6Zc7teBV8+ezTFtkewBWqkYx4FezLa/Y+wuQOulDhc/p5VFsSpa/L6Wrl1y
	icW+yT+GiuKKpHKEdc2l5FV41Czzx0G2R2cHckrAnp5jNmQSVnyeRRQOiwcljLl59op2kPmxTRr
	OiwZow/F9922HlepKXWBYM7CMvvK9hSczViGenA/oILgkWiB1e5WgF6jZaPYyTFKULCoHrnmkQU
	hwsg/JN33vQZpDqU5ygDYTBfV1Zzr+9Z+kW5aGEJfjQzoTli57H7d0scyYTvSFVQDMrVcq/crHM
	X5Vy+qbqF5q9Vd7+dKFTagko1Hak3W+a2TU5ti+RsPaUXGWMQcvZYfaC3YI8Rei8FeWzmOTNX+Q
	6QfkCD9BAglnc6R8u8BTnD2GPk2uVSgRZMo+YJyXYgJ4lw6anU0e9EP1zwHmK2BXhjCywnPpW0G
	+MMA+0FeHqkDsoJHdrq2ilFIloS/b/ISQCmxDYIdcmAc9ugNP6equd1XQCO8p8TyXlQdlMlqm34
	INXGiXFKQuX0/5NJg
X-Received: by 2002:a05:600c:12cb:b0:4a2:1104:7ca7 with SMTP id 5b1f17b1804b1-4bb861576bemr155677955e9.11.1795360636349;
        Sun, 22 Nov 2026 07:17:16 -0800 (PST)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2 (212.pool95-21-2.static.orange.es. [95.21.2.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm16470775f8f.40.2026.11.22.07.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:17:15 -0800 (PST)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/qxl: zero-initialize struct qxl_release
Date: Sun, 22 Nov 2026 16:16:10 +0100
Message-ID: <20261122151629.223013-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

qxl_release_free() used to check release->base.ops to find out whether
the embedded dma_fence had been initialized. Since commit 2bcbc706dfa0
("dma-buf: add dma_fence_was_initialized function v2") it uses a flag
in fence->flags instead, but qxl_release_alloc() allocates the release
with kmalloc(), so the flags contain stale data.

Cursor releases never go through dma_fence_init(), so with a stale flag
qxl_release_free() takes the initialized-fence path and calls
dma_fence_signal() on a garbage fence->lock, triggering:

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x7b/0xe0
  Write of size 4 at addr ffff888010462700 by task kworker/3:1/91

  CPU: 3 UID: 0 PID: 91 Comm: kworker/3:1
    Not tainted 7.3.0-00341-gf47d223627f8-dirty #556 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
    BIOS Arch Linux 1.17.0-2-2 04/01/2014
  Workqueue: events qxl_gc_work
  Call Trace:
  <TASK>
  dump_stack_lvl+0x4d/0x70
  print_report+0x14b/0x4b0
  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  kasan_report+0xfa/0x120
  ? _raw_spin_lock_irqsave+0x7b/0xe0
  ? _raw_spin_lock_irqsave+0x7b/0xe0
  kasan_check_range+0x134/0x220
  _raw_spin_lock_irqsave+0x7b/0xe0
  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  ? __kasan_slab_free+0x47/0x70
  ? kfree+0x21b/0x450
  dma_fence_signal+0x72/0x130
  qxl_release_free+0x2cf/0x600
  qxl_garbage_collect+0x25c/0x500
  ? __pfx_qxl_garbage_collect+0x10/0x10
  ? __pfx__raw_spin_lock+0x10/0x10
  process_one_work+0x696/0xf90
  ? __pfx___schedule+0x10/0x10
  ? __pfx_process_one_work+0x10/0x10
  ? _raw_spin_lock_irq+0x85/0xe0
  ? __pfx__raw_spin_lock_irq+0x10/0x10
  worker_thread+0x4bd/0xd00
  ? __kthread_parkme+0x8d/0x170
  ? __pfx_worker_thread+0x10/0x10
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x32e/0x420
  ? recalc_sigpending+0x162/0x210
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x362/0x5a0
  ? __pfx_ret_from_fork+0x10/0x10
  ? __switch_to+0xaf9/0xf30
  ? __switch_to_asm+0x33/0x70
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Allocate with kzalloc() so an uninitialized fence is always seen as such.

Fixes: 2bcbc706dfa0 ("dma-buf: add dma_fence_was_initialized function v2")
Assisted-by: claude-Sonnet 5.5
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8a9f..ffc9e8f0a4c2 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -91,7 +91,7 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 	int handle;
 	size_t size = sizeof(*release);
 
-	release = kmalloc(size, GFP_KERNEL);
+	release = kzalloc(size, GFP_KERNEL);
 	if (!release) {
 		DRM_ERROR("Out of memory\n");
 		return -ENOMEM;
-- 
2.56.1

