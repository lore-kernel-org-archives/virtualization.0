Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CA41E6DB
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209029; cv=none; b=W+Cobs/H/173erVjRogQkQQLy/sLKPC73W57cyARtj68B6nRw3ROPwUCfgJ2dtWN/abr6vhTqPZmFSB5nSX9h/SkGZxXWJ+eUH31Me9nb0CAm6rGeCVJRijXXaU72XztBD85FkdX8ilearFztpMOW+Be+/CmeClElnmwNvC2Knc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209029; c=relaxed/simple;
	bh=zhOWEamuPNzIa7ywZJbECDtA1y6/KiIZvm4TxhOofpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=N3zfpG5iyGX8DQ8napdNmV0j4VZqAC0U75GDWvbnhI6mF0G+2tOS/5NAbcAUsN8xgIncc4ix2CIGzUtomRDC1ZmSQZWi7ofXdIJcG+//R49iDfOCEas2gUdiQfoZO3mV+nZOP/s6w5fBeH/rnYl3y19nJ4xTXdVnmoun6GpSvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=db+MZqWX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="db+MZqWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789209027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnOxC74F2mkf00TAH+G2Hhd/RtqM8EKHsqZjkYjYcVU=;
	b=db+MZqWXbodNoXTcO3Ds1c05nOPH4Iy1UTb/8UMaCnQS354F8ouhI0Uz4CC6HlVDDemsiq
	yQ+FYigTue7QLnIuIUKQxQCoRbcuPQLJuZfO/uPaIFSEZTEBfwRo5u/mjEmRAnmRDSaQMW
	GmBeMH7I8bTQrkyGnTCzsb32+zo4sr4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-DHZo6UjzMiyrM5-orKjSdw-1; Sat, 12 Sep 2026 06:30:25 -0400
X-MC-Unique: DHZo6UjzMiyrM5-orKjSdw-1
X-Mimecast-MFC-AGG-ID: DHZo6UjzMiyrM5-orKjSdw_1789209024
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e635a6002so15614455e9.0
        for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 03:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789209024; x=1789813824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnOxC74F2mkf00TAH+G2Hhd/RtqM8EKHsqZjkYjYcVU=;
        b=BY2nrBYCnHs14TsCfaMrfZ/GQPRB6ALv6ZvjmYYe604jje3xwByXM3f4TvU1FfazuC
         Nk6zu/l7zEfuimvpuzPcCmDjSu9q6Pn/YFD9T6CuWBlsPdcSwuD0kNWVRe879ozIJfcp
         WSIucCe1zdS+Kb6bTIOHC+LaJ0oMw1nOX2A6bDlE6PETHYEXFjqsopee4/Qa4T4N/06F
         hMevtkjqNXAATDxGNV4jW/KlKXzmmDihTgEFgIFjDMEHwDu1ydywRucwH0fr6Ows07M4
         vGiG8s38rPO/+xGQ2yx4NDLgKMXCYaysQbwWdvgcKpNnJ6tFLhZmAHGNuUCLzCy9tXg6
         lv9w==
X-Gm-Message-State: AFuF++m/BFrmFV5jYGvGnE8NF0/JN29zX5gkg1ABmADnRLpWrq3V5Pkp
	mP72uOieAd2QWkBr9F4vxSUreOGuXlb5OvB3blSBkVi5rJCbygKX0dgH/6a2DDeL4T1Mv3OsPdq
	4BacjtIm64sAzCfBt78dxH5OhT9Ozo1PHSm8IZDwvQ1G4oEgruSwZdIObcho2INaSklEPBCF3Hq
	+B8ErltzNZS4MpuS+M++JtWu6RMc92YeJrRnRtvpFQsx7WUw==
X-Gm-Gg: AYBFou0cHQAjMEKRnCX011WTb2VH761moRGDWXsWIbxf9IKuw3MwX/GK/ttW/+08ShR
	nE+sj3edJ6wQRnUCxz5ajU2obSpmNdC4Zh+UFg9Hh4U6tZHQbUEHfI0R2alXSO37WJ6q/lwCGOX
	XWmvjrjBtWUzsGz0ni+qv70TLWwX3msxUlt//fFIyJrDGhlbx8Nen9aXdxe0TvgTQ2V7joR7Si4
	ayHFNLDGKzQ/qxVPddrKeW9FIor2nk9S5vdK1osRvgzfuo5rJ8gTMTiAVLGwQWYJu36rE0g3XyV
	AxTPMc+UI+CyNMIWCEXYKZ1tFgOsmrI/x2WTfKnN2q/40iXZfbK0rvzvwpxs1oR99JI=
X-Received: by 2002:a05:600c:a03:b0:49c:dada:f57f with SMTP id 5b1f17b1804b1-49e6197f78dmr95008695e9.7.1789209024021;
        Sat, 12 Sep 2026 03:30:24 -0700 (PDT)
X-Received: by 2002:a05:600c:a03:b0:49c:dada:f57f with SMTP id 5b1f17b1804b1-49e6197f78dmr95008195e9.7.1789209023459;
        Sat, 12 Sep 2026 03:30:23 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm251334355e9.15.2026.09.12.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:30:22 -0700 (PDT)
Date: Sat, 12 Sep 2026 06:30:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtualization@lists.linux.dev
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	jiri@resnulli.us, kmehltretter@gmail.com, sashiko-bot@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] virtio_pci: drop callback sync on reset
Message-ID: <64421afa76075c2e0b66ef5c2ea18948b861ab73.1789204858.git.mst@redhat.com>
References: <cover.1789204858.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1789204858.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gHrfY0eOOMw0QqeVzgKxaDEelv0tv6kSRUuRlNshX0M_1789209024
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The virtio core now synchronizes callbacks after reset,
so the PCI transports no longer need to do it themselves.

Assisted-by: LLM
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v3->v4:
        now includes modern transport (previously only legacy
        in patch 2, modern was in patch 3)
    
    v2->v3:
        split from v2 patch 2 - legacy part only

 drivers/virtio/virtio_pci_legacy.c | 2 --
 drivers/virtio/virtio_pci_modern.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..8115aa39e01e 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
 	/* Flush out the status write, and flush in device writes,
 	 * including MSi-X interrupts, if any. */
 	vp_legacy_get_status(&vp_dev->ldev);
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index b4249afd7f58..922e2df027de 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -563,9 +563,6 @@ static void vp_reset(struct virtio_device *vdev)
 	 */
 	while (vp_modern_get_status(mdev))
 		msleep(1);
-
-	/* Flush pending VQ/configuration callbacks. */
-	vp_synchronize_vectors(vdev);
 }
 
 static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)
-- 
MST

