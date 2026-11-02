Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651724;
	b=nEHUZgzaVuFzptuDUeztqwpl+ReoxC5noO2uF5JmL5oCOROQDFxigq46JyE2onE+8qQn
	 CyC6pSwpOJogTvqs23Fqm8jp9Qxrn80FAXqZzrO0uDK2QqIwVspZpVf8j6weon4R2q7De
	 0lhdZjDu4yzuBEos/Gjc/la0pbPxG6rvkIQvccmY5wr2yTupg53LcDvb+yMBETyixM4Fn
	 f6fza7QX24fX1kWLMy75AtCuZAGT20alJ9Pw4Dl+PYXIRe1s6KcL6Zd3c9LbpmcBdx2sn
	 fSY2KY2QF2gnithrXsfjgXTA8maZoRyVqPVLhpkXShTE4AtIZZ2ZtunbS0uzDiPWC3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xHb4BMKUD2DiMuu6B4zoIeu1Wmb9749M+/aid4F1J+4=;
	b=ef1/AUjGtVFi0JPMMj7eqlFgZlrxYuus89MK3d8nFjk5GNsFQAqRCVhBo0wFMpCwIgpt
	 s8s19tBbbMDvMpau5gNx8Qf8BqkHzeyIYPCElPHLtCembsuvlORfTAlxf99me7ZAW8PNI
	 vz64YOoDlHSRj2qZHMMmdyg89O5YGz3F/DYiNotqGcMAhophppadWJHCrhUPy4GT1Vgbq
	 vCx5y7j+Lj9zFYRLmCxKZPJ8kvIIzY5n1VUOv+NnyYzz/sWooRvJ02Jk8LL9VexWAuO1Z
	 tBY+vx9Rzr4DJgvGSOvPCh6nq2PjrSREdaHoH9GRCTxpLzQ2O9hwvtP9A8Fzg0IUTgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLC+5e1Q;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A21606A326
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 20:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61A21606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLC+5e1Q
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-945ae2daa68so4001385a.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 12:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793651722; x=1794256522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xHb4BMKUD2DiMuu6B4zoIeu1Wmb9749M+/aid4F1J+4=;
        b=YLC+5e1Qt4KYHTzLl+T9SH4JYBTe39okmWJXq+0DsRhCGt+41+L7hvWvbxONrjPBZh
         fLZdkltblHK7L/TOkwcIhjBTgimMm89H6F2YJcGp7OnyuvKWjOVuPNGWbc+bjmnLrwqi
         CiZCeLfFHLrJW6jkfKcrwMTcSje/tO/FF1lUlikvJYkhIF3/0YBP3IriSEmu4X4UrtRN
         nLaWktHkcWj/2aKolU42GS7AsTzSGPTj1zPKHg4kXIXiaqya/QwXIfcVv1yxRDuHvxMz
         erlaHtZlDtqUpZTaG+KOkiof47YvltL7/CuBcrYlJFuhTlBonPZagVjGKT5gb4hadQlI
         4yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793651722; x=1794256522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHb4BMKUD2DiMuu6B4zoIeu1Wmb9749M+/aid4F1J+4=;
        b=ENvHhN+Tw8s5QlgXnWRUmhAHN9B/aeLL+yEA1gIM2WLCF7ASGFbCoXrZ8ioAJnTVB7
         vxkB9bjLbYRQmDsjzB18hz9LSRDypH+hT4NjucuI7ykh8szCJErURwf0vmezdZ6+z0qg
         E7lcFNBYcysF2Vl/SvZKUvfIQAbEoETzse2OzHnimr7XiD610q+yEouT51mPgQUzVVJ/
         RWh6zZM+Mqv+hU/EHprSTUiLHAEqA/Xb2+eCKzgdhySlo3rP2L78fasirrkaC7pTXZoQ
         BHpnzude+jnmw0zcffRGHEzQcGrheOYj/renyeRGL4ol3AqqiyD0VMSXJI7g8/KIRiXb
         4Cag==
X-Forwarded-Encrypted: i=1; AKwUvBzKvQXDPKzObqKe0SVPmA9IvcXPq+ym4tCCyTXtpJPpMConC9JtxqxAgenKup/VXCptdtMSFmBWxRNpFne68A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJtbkpjT4r5qovIcJ4BW7WOSoqQFBFZzVUK70uVRPL9UCWpcClF
	4xZ6ruegEUCjai+W2HZBDUFbFYYD/9ioSr4p335pD8yLAhXdQvKezh9V
X-Gm-Gg: AYBFou16W92Adj+LSnzy9fCvc5+RZK9tFdgbNezAgczivlrPv3CGxll460giVTg95au
	4Rz61EX2YxpRgixjjazv+sGYK7DFJkQb5QkpsvY6TVPZpOdUEQr01gl5e8vYHDVvqDsdUF7MjCm
	QLwyzkPYuwbR7D/Cyw1b0iFpVgjjlXfSWzVjLagKO0N2CxlL7+oOT1kb4j9JCr9mccuib3C6zcN
	zGxda0WG0RXdOHF92sWRXDr5D59vLWi0MnIyw8AvvSlFCSH42EFIuODDZSVV6CCq4zi6AgFMXtt
	lQrOCRDSKxGHornb3NRhZSS5dsaVkGdaB98aMC9g4+ypw/3jaBe7hUI5BNcvEXdTwSwoLyOVzzQ
	Xb6+yEsf7pm5FeV2d8Z6g4kfr2PFueBl6qMBOAiullPqT3skmZCgCD2gfe1RTKHRQyxMnp+qOjK
	3xF3ujSwcffC2MsosfHmsL63pVUR2qyorXlClmnnLeRSOFhXLNbGMmTJ8O/iXkeqpgqVujcGRh5
	rcdq079oKpzcO//pgCjuK+4wExsA2NcwBooHFhnrWXafdcv4Xh8a3+MIUpSFaPLykCbCL7UqhEH
	k+v9tJ3Jg+uGtm6m/Dk0/rQJyDToesxzRqInXrMydrx5T+ymp2/T
X-Received: by 2002:a05:620a:4724:b0:93f:58dd:4c34 with SMTP id af79cd13be357-9442171e0e9mr1845990685a.34.1793651722215;
        Mon, 02 Nov 2026 12:35:22 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944252e5162sm916242185a.5.2026.11.02.12.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 12:35:21 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] virtio-mem: only mark the device ready in kdump mode with vmcore support
Date: Mon,  2 Nov 2026 15:35:16 -0500
Message-ID: <20261102203518.436327-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_mem_init_kdump() marks the device DRIVER_OK before it checks for
CONFIG_PROC_VMCORE. Without vmcore support it then fails with -EBUSY,
and virtio_mem_probe() deletes the virtqueue on that error path without
resetting the device first. The device is left with DRIVER_OK set and a
queue that points at freed memory. Nothing has been queued at that
point, so the device has nothing to process, but the driver should not
leave a device it is giving up on marked ready.

Before commit a9403425b3cf ("virtio-mem: mark device ready before
registering callbacks in kdump mode"), virtio_mem_probe() called
virtio_device_ready() only after virtio_mem_init() had succeeded, so this
path never exposed a ready device.

Move virtio_device_ready() into the CONFIG_PROC_VMCORE branch, right
before the vmcore callbacks that need it are registered, so the -EBUSY
path never sets DRIVER_OK.

Fixes: a9403425b3cf ("virtio-mem: mark device ready before registering callbacks in kdump mode")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Drop Cc: stable, as no practical kdump kernel disables PROC_VMCORE
  (David).
- Say in the changelog that nothing is queued on this path.
- Rebased on v7.4-rc1.

v1: https://lore.kernel.org/r/20261016023521.747447-1-oss.patchbox@gmail.com

Compile-tested with W=1, with and without CONFIG_PROC_VMCORE.

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

