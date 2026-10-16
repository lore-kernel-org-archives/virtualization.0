Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C191B381E8B
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118129; cv=none; b=Pju816BsjIOpwKR16Y677erQHsPBlhBpBAr4fewo2BOuo7w5GTX+AlrT4iuK+KMrj5jex6nS+DJ/KHxQWE/hPAqpPciDnyS/JcHSe2r/mfEQg8L3YwUm1U1JEXVKZZpHQySJ3Dztt6mzLhhohb4/ihyvXNB1PwbScrLgLIA9syU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118129; c=relaxed/simple;
	bh=e1pzx7iHT7y8LGbTJDidgYeAv6c7Ezsr9NaS2X13/Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4OfgkTJ7JEyhgY+adQq7287cUrJPncIafQn6g4Itm5+3/SXeOc8mOgOoAZmXZDUbeoYsa9h/dK0NWnNynzuH7UBp4V4oeazukAYAhTMgdzqldFAbgrTuEPQngPXOS0We6h+BvPGFZrnzxSZk5KSsxKR46zBTjy7NjU6xggfWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qti7S+jF; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qti7S+jF"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91054f537ccso70266126d6.1
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 19:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118127; x=1792722927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=03vOOfrUqgo7xXSCXx3l+3vM9t3JyBBNR2eJKIpJADU=;
        b=Qti7S+jFrxjMzS9lvz9jO7d7/b7qNDbGvD2FDYlr4xHo54nC5j69MhmLzzVpoqStkg
         Uz6PDVtOZGY0MqfsuxaJz0VXrfcJgkDVI3NgiYOopxDMvsh9osIc9KmjNN7YQnqZ7BNk
         bQ0y7RohxvVaMnh2S2ZqZfxV7m3Wp6t3NsopO1QiEcbx8h5GEhVRjLjLeROp3CdSEHQX
         r6D7p1BGnCePsaNuCwY1yiDmycVkbkp3p+X6IknrN+e4RyTzdCHKdrA9fb26IfeNaU5q
         MiuqhL4gt4pr6EzrXmg0C3WJYmE2r6L6xJbMLpIF+yyXnXAJTqek/pGqjgTyXL7XliAB
         fYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118127; x=1792722927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03vOOfrUqgo7xXSCXx3l+3vM9t3JyBBNR2eJKIpJADU=;
        b=rOxs2jVdR1DgeQ/rmFlGetBDARwyyQA0hShF09bQ14vdaWeiuDu6z0nDc/0tCvSRZx
         O6qYy0ZiNAjLGMB6H+brfXy8bmqbmC5IEXBRAgOCYds5lieM8ZXGx4q7oYQIuwrUcbv7
         PfXxrsQBjO13XV7y1zj7n8DleK8t0wY109ZiDGeDUlrtTQTR0jjdNZmKahZQQJ1Rmivx
         isF7K47byNTb5KX3C1cEgOtlP+EukrGB2ckyI8gHo12qiwlouewVAD0zGCiHQ93P6A9F
         jhEroMG8mkzLsfa2lZVdc7lePqSTOWmV8dnQ4DPvvXruzhYPIPZM1uqsawPkKFvM31k2
         fsHQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKSStME4XAqrKHUOkcQFh1z1YXZlg9R5zDT334C8mKv/HQuwj/gcnuCBv8dMWtoZiNJVn4vgBeyaIwN/9C1A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKzUwevpkMKg6hSHW9LvvVdaf1Msj0WaiNALynLi9P9eAViTd/u
	V1MDpUc2JZimZAOoOLeILQstr8RNOeY9MCriKf+vqQ0pKDHZHpsiKvmE
X-Gm-Gg: AYBFou0Jm4iPyWkibpgu6ml85KkklgJe2Rigxi3lNf8agEpLZD4hEoLmymu9VHMadwS
	UQadt2QhlrsivjE4f4bHZ/CxTZYh7mbjWXcd8+imIe5Uq9Me43xJ6vTob+0wcfKM4DOIfxaHZ0Z
	nDMnISrDN5O3tb7NarLAqcVI+wQ84gvQHQnV9OoHiO7DSwZs86c3jJVifUbBXuPzcNVOW7BTiQd
	Ia4oly/RXtXHUaKxsVh4Oz1nBeXB/rSQebZFZLzkpKX2j2jXTvi3N9FjhMwwvhtoCQQbuJSoN/P
	Mi92l1oN1klUWV5qahDJ6/HwW/tnz7Hr4nESc/ANO2Iu2RCmAxXqvImTK2Cp4DCzs6CF+nhFfri
	1c+OVtVP0mrQbFMUWjD+PcYfY57ah8PchFcCIaLoHJzvEFRqwRfRBmJQs4maphO4altHjwo4oxT
	LA01oHqqcPgAxQD+V1+9uYyj/JHrYib7eQvEuGauDWEP5Ammh9nzeBdkv3vy8HuKlCznHLieCIa
	csjuy5JAeOwwxZ3KbRYLQ==
X-Received: by 2002:a05:620a:6412:b0:93e:56c0:bea9 with SMTP id af79cd13be357-93ebd1e0039mr3550692085a.21.1792118127587;
        Thu, 15 Oct 2026 19:35:27 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1b765dcesm52558885a.30.2026.10.15.19.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:35:26 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] virtio-mem: only mark the device ready in kdump mode with vmcore support
Date: Thu, 15 Oct 2026 22:35:09 -0400
Message-ID: <20261016023521.747447-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_mem_init_kdump() marks the device DRIVER_OK before it checks for
CONFIG_PROC_VMCORE.  Without vmcore support it then fails with -EBUSY,
and virtio_mem_probe() deletes the virtqueue on that error path without
resetting the device first, so the device is left believing the driver
is ready while its queue points at memory that has been freed.

Before commit a9403425b3cf ("virtio-mem: mark device ready before
registering callbacks in kdump mode"), virtio_mem_probe() called
virtio_device_ready() only after virtio_mem_init() had succeeded, so this
path never exposed a ready device.

Move virtio_device_ready() into the CONFIG_PROC_VMCORE branch, right
before the vmcore callbacks that need it are registered, so the -EBUSY
path never sets DRIVER_OK.

Fixes: a9403425b3cf ("virtio-mem: mark device ready before registering callbacks in kdump mode")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/virtio/virtio_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index e18dd736f2ec..b28d2da7d5b6 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2817,9 +2817,9 @@ static int virtio_mem_vmcore_get_device_ram(struct vmcore_cb *cb,
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
 {
+#ifdef CONFIG_PROC_VMCORE
 	/* We must be prepared to receive a callback immediately. */
 	virtio_device_ready(vm->vdev);
-#ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
 #ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
-- 
2.43.0

