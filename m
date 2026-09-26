Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3F4A2A7F
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790457315; cv=none; b=FWiWI5/UDPc4tm9qlW4W0A6oi10n6JNolJk9rKKVmF+N1CY9U6+4toOwquIZSyuAu3csUL4kB23Gn1a3h0lBzH8AOKKJ47dIEz7jMV70O40xLb9rICnOUXWICY1uCM1UVl9MMWMptj6WTXW0gRubO5IG0wRukvqMBFWyO/VPDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790457315; c=relaxed/simple;
	bh=BEKnQcWR1iKPrgl176vsQ44f+WBOQr4meQx+EM3enr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOvuyW3y65nLNEl3LQKLlIaCPYoxcZ/HwdYEVEaZShX7528ojKrsRJrHiDGZ02G8N1rgP72MXSz8+SlAPeXVGjDdJ1k7yxPO3Fl0WEXU0jo7TwKhP4p1f+fmihK04n0bShhXDJ9lD01J9j6wOpve8N3qgdnz/SnwVtUAq/eGA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft+mbevH; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft+mbevH"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532e91a3687so6959991cf.1
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 14:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790457312; x=1791062112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X/dPF6IGoI8atwdjHAe3xl51teTDZCZxaac38N/HPbA=;
        b=Ft+mbevH2t7S3kMZ+9UIs0AjpeiAU/x6D59EPVWg2Uqt6DdVPksw5Ju81EZvy3dPlO
         axwfcc5znr/Y7/9F0xYWf4KAilyywFY24f3LID/KJSl3VmkpW95XDWyFC9xK0LvjGqEz
         1ft6ZvwsqGSuNTqPs8S/Y4+7pn8drDwRbjvMp5JYTyJaseJGDBLO2Etfu+WiGLHDimEp
         1TyjGjmU0d3y5s/6OzBzoqgm1YdXN72oGhTXh/yP6XdJqjoT1AFC9lMSvvEup+ZQmeb6
         jsRo45iqid8XJh66P36GVjhbgCAoRcypLgYOobI0Y27ehcBJ9q7ckTUihSdnY3mJPJv+
         dW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790457312; x=1791062112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X/dPF6IGoI8atwdjHAe3xl51teTDZCZxaac38N/HPbA=;
        b=vKc3Ez6CpIkMTgd43/SQnNqUwNrYNViYQ0WYegmKsz/zlzQ7UiYya+RNKV4SbprsIr
         rs0QJwJKyvj1Im7ejN41tKtWS+BFVzw+F2NdteDYtXg1R1efxDM4hV8tM2Z/3nqsT88K
         kRfWYWREvCJGfDNsbsDY+wKJt/jWrD8TyhwUJ8r/XVdroy0HMFmvdGo8eS2lae5HlwUo
         eFzxLzoFwubPnhzNxn9G1uKNK+tMRgf4LqwUKMEJF8yPm4dIK6T8UBrAY38t8DJnYqM4
         fWUo5Q9AANa4B5MsH1al0ukeYbEpLlmGGo2N40/TpAKIHzsZ4X+57oyDArj/R/c3PLl8
         2YyA==
X-Forwarded-Encrypted: i=1; AKwUvByQQIQ+Ib8EizHEeIbmhcxpE2KnLTHsm5QQ5zlNL/7WqONImWfp1TxPbknfXqL/BN22+oMRYpNkgJSYqyYtPQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kpB78ahXeFON6m6CGR6X/gbm/nEmKHEjgfQrQqX22M5ZBByEeF
	ydneJBFCbFxVqJYtvcJhiiPyXNdm5ToRW1lvvp1Baz+GLqAs5h8segJ6
X-Gm-Gg: AYBFou3aYM37fBX29kTBRHUoMS9vKkCBWQJf0GaZv25TYH6Vxc0bB2FOxYXr0VZgolM
	SW3Dr5D9e7gEBaXD/R8BLTot7FUexS9j4k8MP/NvH9AQD4UBnBbxsIsN29gfa94MzoHggwhACBm
	dm365hE52wWEKbtOqRshDnI286yz/mxqHSCKoX+V9fDTzDmnYFaiJnjNuS3L453XehcDwFlveTc
	ZXlU/PzwZ38RUbGselQ3vIy/moFu3+yyMaNJGu8WVex5zmAUIE//LxwjgKTHEz8EwzvaBS+kn/l
	tmlXMVbPeoAfUwy7W+rDtiNviXevtLBmWDPPzX0GHI25j/+14CShS5ju/d+D3YGHItNZf3PVFJn
	KNC7eApSZRJ7odXsZ2QIKIhkznVyF+TBzprO8U18Vd7zwHwJAcKajDus1eMopu3VCCMpeOHe8qB
	ehyO2vuKI+9xJv9mU9fRKkJD3qkP6dxtS8QNVB7gGJsh3uOIi87OsNjC8ASvohRwQPRAk27F5lm
	MlSc3pzEJf1kl4OCNFBUGc=
X-Received: by 2002:a05:622a:1341:b0:533:36d3:1c81 with SMTP id d75a77b69052e-53336d31efcmr4682591cf.2.1790457311626;
        Sat, 26 Sep 2026 14:15:11 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53322020e91sm26060701cf.1.2026.09.26.14.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:15:11 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] vdpa/vp_vdpa: Wait for device reset to complete
Date: Sat, 26 Sep 2026 17:14:52 -0400
Message-ID: <20260926211507.1330179-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vp_vdpa_reset() writes 0 to device_status and returns success right
away. The virtio specification requires the driver to wait until a read
of device_status returns 0 before reinitializing the device, and
virtio_pci_modern's vp_reset() does exactly that: the read-back flushes
the posted status write and any in-flight device writes, including
MSI-X messages.

Without it, vhost-vdpa (or virtio-vdpa) can go on to tear down the
IOTLB/IOMMU mappings or reprogram the queues while the device has not
yet finished its reset, and may still be DMAing to the old virtqueue
addresses. The MSI-X vectors are also freed while an interrupt from
the old configuration may still be in flight.

Poll device_status after writing 0, in the same way as vp_reset(),
before freeing the IRQs and returning.

Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (x86_64 defconfig + VP_VDPA, W=1).

 drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index f2eb654b1665..4285cb968479 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -8,6 +8,7 @@
  * Based on virtio_pci_modern.c.
  */
 
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -236,6 +237,9 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
 	u8 s = vp_vdpa_get_status(vdpa);
 
 	vp_modern_set_status(mdev, 0);
+	/* Wait for the reset to complete */
+	while (vp_modern_get_status(mdev))
+		fsleep(1000);
 
 	if (s & VIRTIO_CONFIG_S_DRIVER_OK)
 		vp_vdpa_free_irq(vp_vdpa);

base-commit: aa98230e410f0ed212b6788c46b1e4d49e0ff7ca
-- 
2.43.0

