Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2276FE16
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593373; cv=none; b=Fa+BJ3GfsPxoXU1ErDl7vxL4jojJuL36RiOp4+8dClPeVyGl3k35VPfd06P2O/mK17CuOm9bVc+BhqXx7Taw8Vzm/56g8qjDKfsroMlkunVy0nlMmyg1974ZqYEsSdegINmGSZVbYTJC1DnyWNWPe3QxADWk2TZdKEaBQtlbtp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593373; c=relaxed/simple;
	bh=xfESLWVKj95G96uaAieKMvyJp4d0F0ZRMpVQaXbeIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFM3zwFEZ/CL4lhiNBkwe6yJyMWsPG7lNqLB1UsCc4d3pzmKQgbav2TQ/HdrYXGap/0WV5ueKNjnoHjZ28Obz+bs6yVAPAKLZxJCAkVcY43pb3FbW06DAIHBPraiNvrrcJpDx+yuJljfJ/oxd77hjbg1+ysPeg2JlVIgZT+cjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DmGpT5A3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DmGpT5A3"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee910d6aaeso66217401fa.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593370; x=1721198170; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg60V582lLlfGb1TAvAizxNMtINX79Zd8VO01rpHzTQ=;
        b=DmGpT5A3/SNL9eATQtSdBtBjpEV4b/uSqiWZqyQlLvT2/g98edIknLM6NXxB3Xin6C
         mqLVCnvAsgShgyiuT33/yyBvPUYs35+FQPfc8VQfdfvy7YW303NEj1X4Bn9QE0oVTneq
         TvhuxjnK1OE/tT05qfIPF5dMcAx/4+qEnVIWxfm/luZygC6lNRH/INnffLgMlDdb65ok
         GOSH1Q0TLvahuij8vmOFKrJW2LJb+1vfORRi93yYPm8H8lHmLt2Fz24dcBumVUfqXMOC
         Mf03CzmLBgFmR0N0LZ4BCfGJWVp1/R8EtETtjAJzoHV6SnQkdvn1migVEKGBFX+iM6ym
         Mfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593370; x=1721198170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg60V582lLlfGb1TAvAizxNMtINX79Zd8VO01rpHzTQ=;
        b=huzoYjN8Qn4jzNyTyX4Xp20bLnY0cmLxKwIcFtF7UV7vJLaT6TgA7RigVxyhy/SeE7
         iDp0RZBdRPRGLeRbBOJCpaLtgIW8bqv9EJjCMMztNxOUlgmA/51U40jEt2/MI49kLkP8
         6zPyJLv+FYVKvHytM+87Og8sSBbPQDjPBDANyNfERKuLELAsH0cdCeOvNhm29MmARvGs
         yvrifRK+ezNhCnAsQlnqjlvUVv4uGsm6gcd0BKpJAfRuv9stouJ/irr6TSd7G56g09Mp
         YSIwMyfjLu1N0ExzY+xzZWlvXFXoYNQsfdcTtg3JTiZPLegbtPjcQVEDBxsJxo3z87ol
         KXUQ==
X-Gm-Message-State: AOJu0YykkU7CEQoJ4rdVMlclxwLalaUmWqH3fzzyNTwJOHB5UJxDoRgA
	Dhxo+S+J9iDF6omFjPQ9F39tNBD6gLG+KwpVC3oSRYZyNzeD8kCUk4sq6NMcYG/oxMyX1Suj/7t
	S
X-Google-Smtp-Source: AGHT+IHVKknlVAyPCdOk7EnHj2LL6z6JdbDxyhFOCoZpcGNX5ppopF5U308woX+2mJh9WFIb7wswIA==
X-Received: by 2002:a05:6512:688:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-52eb99942b2mr2935164e87.16.1720593370080;
        Tue, 09 Jul 2024 23:36:10 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0666sm4364386f8f.73.2024.07.09.23.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:09 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 04/13] virtio_pci: pass vector policy enum to vp_find_one_vq_msix()
Date: Wed, 10 Jul 2024 08:35:52 +0200
Message-ID: <20240710063601.2000149-5-jiri@resnulli.us>
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

Instead of accessing vp_dev->per_vq_vectors, pass vector policy enum
as an argument of vp_find_one_vq_msix() in preparation for another irq
allocation policy.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 drivers/virtio/virtio_pci_common.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 7fec2258d125..628f003db79b 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -292,11 +292,11 @@ enum vp_vq_vector_policy {
 	VP_VQ_VECTOR_POLICY_SHARED,
 };
 
-static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
-					     int queue_idx,
-					     vq_callback_t *callback,
-					     const char *name, bool ctx,
-					     int *allocated_vectors)
+static struct virtqueue *
+vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
+		    vq_callback_t *callback, const char *name, bool ctx,
+		    int *allocated_vectors,
+		    enum vp_vq_vector_policy vector_policy)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq;
@@ -305,7 +305,7 @@ static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
 
 	if (!callback)
 		msix_vec = VIRTIO_MSI_NO_VECTOR;
-	else if (vp_dev->per_vq_vectors)
+	else if (vector_policy == VP_VQ_VECTOR_POLICY_EACH)
 		msix_vec = (*allocated_vectors)++;
 	else
 		msix_vec = VP_MSIX_VQ_VECTOR;
@@ -313,7 +313,8 @@ static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
 	if (IS_ERR(vq))
 		return vq;
 
-	if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
+	if (vector_policy == VP_VQ_VECTOR_POLICY_SHARED ||
+	    msix_vec == VIRTIO_MSI_NO_VECTOR)
 		return vq;
 
 	/* allocate per-vq irq if available and necessary */
@@ -374,7 +375,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		}
 		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
 					     vqi->name, vqi->ctx,
-					     &allocated_vectors);
+					     &allocated_vectors, vector_policy);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
-- 
2.45.2

