Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A05142911
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129792; cv=none; b=LBiQhthpiOOPWkR2sUPmHXXOJQWo5iYphaexIJamgdXQ+NDidL6fRE5X3l4DEiA5wFbC/mSwjDJt8/z4GQ2Zp+2Fsj4LuUTt+ufgaM3XC3oA7Vvm/W/lHidt4ZVhM8d8dJxVt2iZInKj4yKaGEVVh6nCv1QtpG+7+v0IA64SxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129792; c=relaxed/simple;
	bh=djPYujy1E/hduS5LCMH2Mje4Fa6u/ltjfe4RoDuvMBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE5RkRJUYl6Jfwg4ygzfovempn63hZxUI1kEj2ekbP0HUg2M0o8fmByF2GAv5fhi+ZsK85BQj4v/suTPMyiEbAVZrKDaBayJaiQRfU3Cuh6hDNry5kyz9Xis1xjowq2TwEsFXaixPOZofGpMOBlk/1l/vOS9sVEO+mbO8DsHXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wnwLiANM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wnwLiANM"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so69654321fa.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129788; x=1721734588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foP13wjYNn+8mS2mwVvqlbiJR8471Edmx7/YrXjMAKA=;
        b=wnwLiANMmiM09UGUb5BKoKPzdGFUuwsGYyBTepEXXGQ9NFCi9euwZ54vPVm1GSL40G
         TeHrHp72j9KnIqN0W96IZ3T9TUNifix2r0T7768eFXWNyUPQVl7kSV7NT0kU/s0nSks1
         dw3ISbUiQG+JWz4izbb2LUQIe+U+nU8bEJpCcQ9hixXN2tupA//pIcpR3VtAvjkTXYsH
         td/YP2Iex1eX1RMUIgl1Edl7IECcYQAS8L7ElIDcL4SD9BwrEHaIQ09jv0wFEMeSfN0Y
         7F3RQrkl0vde3UWrC3CITQGkRFlGsnwMpFm5KuMVJOxuNJ/iF7V0uT6dDjPT0W0OKtC0
         lORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129788; x=1721734588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foP13wjYNn+8mS2mwVvqlbiJR8471Edmx7/YrXjMAKA=;
        b=vNKjPg6rJajHoN0KWltK4Qy3akKUdAVaOUWirV7daz12p0bPxBt2ZBqXd1UykyRd6P
         rfXCy/AbToXc4gxltIfucP59lgBRRjfQtZcrWS+NkNipcd+V/PM11+310uYv/C4UmDbQ
         +68yWZU3oK0CKgasGi3WRflEjB43NjIVnSMQLEwqEvyO2+Eyd4Ae0qYN/1XNOKcz8K7X
         kNvsNQqHXS9De7/Evab2BOs3MRKl/6dkmxv3fhPDZCF3NSp/Ghg9ivUQ1wqftJiZB+Vu
         BT7zSn2W35sjKEhvA0pPaj9yI+RX9+5wnlI/WoMwUprMC8TtJ/8K5C4ggCk1axQqAm3+
         kyuw==
X-Gm-Message-State: AOJu0Yyfmn8uSqTEHg5xwRuXUNvZ8I1Gnk0lGmVSB71PnPSbQTmHOs2q
	G0Ci4CSU4Lo90VMkv9McbKwOKscCVWEgqkNZCRDKAIzu1xWc1444+QNvZAE1iJh2jyWx3FI4Qmg
	R2DE=
X-Google-Smtp-Source: AGHT+IHnMA5gxaczUNnWomgkoDmAV5tjf9nO2oN5GMvk1JEt9PNmi8joTYTqofVNWfM+MmXF5u3v8A==
X-Received: by 2002:a2e:be08:0:b0:2ee:dde7:899c with SMTP id 38308e7fff4ca-2eef418ef02mr16191671fa.17.1721129787794;
        Tue, 16 Jul 2024 04:36:27 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f276c52sm157587055e9.22.2024.07.16.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:27 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 08/13] virtio_pci: pass vq info as an argument to vp_setup_vq()
Date: Tue, 16 Jul 2024 13:35:47 +0200
Message-ID: <20240716113552.80599-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716113552.80599-1-jiri@resnulli.us>
References: <20240716113552.80599-1-jiri@resnulli.us>
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

