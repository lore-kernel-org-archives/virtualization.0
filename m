Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FF04F602
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593380; cv=none; b=WtxtMp6xRJDY3n/BcU3CaFexyuSv7ooPuI5JaS22zd7JGfxOPwxvcUxNSM9SYgQbbnp9BgPP4BP4p3bIUXlnfuaqWciegAT/2PWQg5y/RYnBntgSMMbjMpBdsOwGsVdd5C2KtrrLB/DRoiilZVXN64s91Gbac38YrlgMn5a7boM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593380; c=relaxed/simple;
	bh=djPYujy1E/hduS5LCMH2Mje4Fa6u/ltjfe4RoDuvMBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFdaKHLBaD3mJo4SQ3vL4GyEBbzl3qJYBEPc4Lxl5TbdXW0qZHb4Zil0mfzHR7LY90D/OdN8a2QDL0oBKJSq+3tHZ+94NyPrnVTfRjO1THlDMX+Dph7QyrIUHCFiUwojIOtu6VtUrj2+dHc93UZfhabiVvLmYwjUe25lGd4XfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0CdLMio4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0CdLMio4"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so71637161fa.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593377; x=1721198177; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foP13wjYNn+8mS2mwVvqlbiJR8471Edmx7/YrXjMAKA=;
        b=0CdLMio4PmMDGaMhlzxcPd4bTKMkOIB6oneBLu8pnKiK+WjUxLDEyWC4j5P/TlMUlY
         jgLABlFRUddnIRQm7gqj5nrWvSpHx616R4BXeZOjoV5gwgvS1uCVrtIzeZipgKzTDxrN
         m9BEOEpYJetmpzCDdtiF36ZCtl+RnfR8e/56vhEoZPq1x1K5d8ig/E1/wu37K96A4PI5
         DUVWlTPZTOSIyJRBOwSuebBCsDP7POEnS5PUXLbdashvqaNdSAGYhTG5LANNlyqIvov5
         LQt1RKSrl0zZokle3VZmwMvo7wBizin9zxPkBQJwvk/5rDINuFnfpNcfK3eoXP+pHaVP
         LRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593377; x=1721198177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foP13wjYNn+8mS2mwVvqlbiJR8471Edmx7/YrXjMAKA=;
        b=KL5uzccDtf5C5LoAEPQZwGRKRhqc4AhiCxbne9ujOsktQM6soKiOiZJgTIcXxbl9CI
         YxJap7FXDkYqA/Vn4d8ehhKXqYjphYEPMSKTJi9pAN1kPqPcpjLNIOkybfe2IDY0UKE4
         AfEIqlTbMVlAUjC2mcYpT237iDrB/WDEJtQWAIyfpG3J9J26eyMGhNSPJsevoKhJXiFH
         8y8mVO+XR3M+pX7GUHf+Ahw5kuMbcMaJoilZV4gccc4gL8Ci8hsjiTlctHddVfUuxr1s
         JHkWHbZ6dJWJ+K2RubCMpzt+YNB0sR531pkGcU56OfxlQqntMZ9LuupM0ygIQq/Tns/r
         BIUQ==
X-Gm-Message-State: AOJu0Yz/EkFgxQMwSjo9jTNW7D/FSfxBn6KYb4stvDPBPZBlCpjHPTx8
	bre/nIM+bo73G2koMhkp1EHgRQzHGV9F4B2AQP9JBlLN+knz4znRUBiMTrNqdPpTjfQrWCUoNZF
	q
X-Google-Smtp-Source: AGHT+IHusrz5CF7hIVE9Gk0/8EztMR75InZ5rN7NEcx2hWpUz2Cl3EVb3j1slG24jtRvp/pB9bkEfQ==
X-Received: by 2002:a2e:a36c:0:b0:2ec:51b5:27be with SMTP id 38308e7fff4ca-2eeb30e3c73mr33140671fa.12.1720593377129;
        Tue, 09 Jul 2024 23:36:17 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc942sm234205475e9.42.2024.07.09.23.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:16 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 08/13] virtio_pci: pass vq info as an argument to vp_setup_vq()
Date: Wed, 10 Jul 2024 08:35:56 +0200
Message-ID: <20240710063601.2000149-9-jiri@resnulli.us>
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

Instead vp_setup_vq() storing vq info directly to vp_dev->vqs, let the
caller provide a pointer to store the info to. This prepares
vp_setup_vq() to be able to store admin queue info as well.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 drivers/virtio/virtio_pci_common.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index cb8bbe6c1a9f..7c5516ae1f8a 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -197,7 +197,8 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
 				     void (*callback)(struct virtqueue *vq),
 				     const char *name,
 				     bool ctx,
-				     u16 msix_vec)
+				     u16 msix_vec,
+				     struct virtio_pci_vq_info **p_info)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info = kmalloc(sizeof *info, GFP_KERNEL);
@@ -225,7 +226,7 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
 		INIT_LIST_HEAD(&info->node);
 	}
 
-	vp_dev->vqs[index] = info;
+	*p_info = info;
 	return vq;
 
 out_info:
@@ -320,7 +321,8 @@ static struct virtqueue *
 vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
 		    vq_callback_t *callback, const char *name, bool ctx,
 		    bool slow_path, int *allocated_vectors,
-		    enum vp_vq_vector_policy vector_policy)
+		    enum vp_vq_vector_policy vector_policy,
+		    struct virtio_pci_vq_info **p_info)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq;
@@ -338,7 +340,8 @@ vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
 		msix_vec = VP_MSIX_CONFIG_VECTOR;
 	else
 		msix_vec = VP_MSIX_VQ_VECTOR;
-	vq = vp_setup_vq(vdev, queue_idx, callback, name, ctx, msix_vec);
+	vq = vp_setup_vq(vdev, queue_idx, callback, name, ctx, msix_vec,
+			 p_info);
 	if (IS_ERR(vq))
 		return vq;
 
@@ -405,7 +408,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		}
 		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
 					     vqi->name, vqi->ctx, false,
-					     &allocated_vectors, vector_policy);
+					     &allocated_vectors, vector_policy,
+					     &vp_dev->vqs[i]);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -445,7 +449,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 		}
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
 				     vqi->name, vqi->ctx,
-				     VIRTIO_MSI_NO_VECTOR);
+				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[i]);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_del_vqs;
-- 
2.45.2

