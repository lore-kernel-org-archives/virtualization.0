Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565616FE16
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593371; cv=none; b=HEQP6NOGUnMWGftK69TdQxunAflx62Cx59WM+QVUtG7zaL5RQyAzl5jWwXD4STNtv60GKyxfyR3nk8I+5h+rYy1wXOLuqFQu7Ao4vu9npYC/QINerwCVWskTvk20O8+XO46ObUj3UsGR0jNIFYzzSUhWP3dVFVJBP7bt4vgX43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593371; c=relaxed/simple;
	bh=VMvzt0STg1hEcgswaVYvSlNInE21YIcDZBn1YU9g7fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrRozr/K+lejl79sbalTd5GU7geS2zw7GvXgL1zMBs2pPhzQQysz3/GLR1ZxIDYoFpTRN3ol5FzipgXuuxRWLefG8BSR5+p9RqCWF9/lMtwSpOdNFsiXNRaDA/mThPyUQzYMOvYYPSBlmsmo0pkIwyDoqPTWFmZOvZI/0Vkriuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dVLSgElP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dVLSgElP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4255fc43f1cso38738675e9.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593367; x=1721198167; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq0z7qDnKLcuG2bdgPVenX7I5loiNYf7yPy5HkHLATM=;
        b=dVLSgElPYvtdHuMJQt62AvlHiMC9MlVFKRHPkCRWUi5ggg9Q/XpfZrS5TXkFVnARwv
         pQEloKndxMXUt9YOsc14AEvrV3gdvE1qAjsmpvPZLWW6qp3oMK/LMbnmkNrmsAmOEc5k
         IXWC5WrtJeXHw6ubtD3HzgXxKVlZJZk2qsxrAKK5ri8fCiQMGpcJPd+k06JBkdJLJPrc
         5E8qb00M24Gnzjd6RgK5MBeBe5AgfKue/Np88gyq46JL0tKZPaLcdbdVLbJLLD7imylP
         vhDMnLTbi+xeBOj6LwtICpEZqH1sBxdGsbsfB83VPabp5xgP9WMUy61S/ec4GXmsJPDb
         fPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593367; x=1721198167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq0z7qDnKLcuG2bdgPVenX7I5loiNYf7yPy5HkHLATM=;
        b=K9NS/yhrcpqdT5Jneg/VxC+w9Sekev27KEoc7E1Rl9JGYyYcLMPsAbuyueoA+GHgTh
         f+l244c4CwCnuqHFDSX4uocqJcmtr1ko59a0jnSHL+7WyDmKFC4CFqJQF3efTQ18uigx
         FQUA0NWfaNnUebb0orcDGI73WYS6+hRHpjDW0JONKZSIQwrgeOPsgvRoQaoUb6dAF1XV
         bmlWJJ4K+vbFi37XatBETwf0EE/UAY4f4VePlPcXkL33+ouo1Tp6H2KVibwok9RMwnix
         egjrWdqKTBV8z69W43bo2A+WxMrWybudnww8CqidMBNAFbY9/WSAxAOrXCGpT6+FsiK5
         m/3w==
X-Gm-Message-State: AOJu0Yy5GxprB/PzMjTIFmcm1DxPyIJoSFDjRK/GUv1GdsVtKDuPda+l
	tbyNdgVwdlm8tKBIJ3zn0nlRMOSRQuehjofEfTij+vyu6iKLm2fLD/+qU3DBL96bMKJqXqC3+VG
	h
X-Google-Smtp-Source: AGHT+IGrO3MHx5C5D3yz5eL1xiJQCKYER7GbOZ1xyniuKhx/Mdyz2HwNQDHOW8UCTBIhgsGLWiczqA==
X-Received: by 2002:a05:600c:48a7:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-426707cea0bmr31698135e9.5.1720593366534;
        Tue, 09 Jul 2024 23:36:06 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427270238a6sm35397865e9.20.2024.07.09.23.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:06 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 02/13] virtio_pci: simplify vp_request_msix_vectors() call a bit
Date: Wed, 10 Jul 2024 08:35:50 +0200
Message-ID: <20240710063601.2000149-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710063601.2000149-1-jiri@resnulli.us>
References: <20240710063601.2000149-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Pass desc arg as it is always to vp_request_msix_vectors(). There rely
on per_vq_vectors arg and null desc in case it is false.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 277591a6ab96..cda0d35dd9e1 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -125,6 +125,9 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 					GFP_KERNEL))
 			goto error;
 
+	if (!per_vq_vectors)
+		desc = NULL;
+
 	if (desc) {
 		flags |= PCI_IRQ_AFFINITY;
 		desc->pre_vectors++; /* virtio config vector */
@@ -349,8 +352,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		nvectors = 2;
 	}
 
-	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors,
-				      per_vq_vectors ? desc : NULL);
+	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors, desc);
 	if (err)
 		goto error_find;
 
-- 
2.45.2

