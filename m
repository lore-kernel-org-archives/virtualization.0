Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981B1991BB
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129776; cv=none; b=AjZW5NYGsb7YyRGZiG7wHdIdKan1dX9Kdgg9JfbRAfkNNH85QZauA5DCAmlzlrwmNg7FuLYp9jhFqScOrTs1gbfiPQmEkMTv0vyDibUZ+aFf0wHiTgJLnF3nFs0fKec1EPxpb1p94OUyKSKLWpMgM8CArn7pUtctCqxT0O92pmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129776; c=relaxed/simple;
	bh=xfESLWVKj95G96uaAieKMvyJp4d0F0ZRMpVQaXbeIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRrXbMWGiZn8wS+JZEBQMdW05WMvptWs+Gm08n2EAUc/CiHg2cYfPsTbtFqaTGx6kKPXTCJNEdmj3tVBfnvd7tHAYR7kaF9daEs0p3HFdWtbX62lyqjFKRu8la+oV854zInaOLHRzRi2oDrr52pbRLTqCu7RRtv0xltmN16CDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ytJbvkir; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ytJbvkir"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42726d6eca5so39057715e9.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129772; x=1721734572; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg60V582lLlfGb1TAvAizxNMtINX79Zd8VO01rpHzTQ=;
        b=ytJbvkirbdRaQvxt9jTWfipaVI3niWbxMm5hoky5HeBSjMgZf5u280uhXO6gOF4Orf
         3BQy0KK3NurFkVEt7lfUpoNeqaqnLMdqLyXgvPSQR3OSADcoC2+54w80hRYlantX0W6O
         WWWa4geLP7awc0Yfp9asy4+gbAzRqvATSaqFRdqweP1ik7xIqZVDN0iE1BpvC0Dnpccd
         j3ZCe//0hoZFNmCCuZwusUF+WZ+7d0xGstqzwdwdnnnXzxH1rFPdnVsXPxB/kJf7nocg
         DpvgK9k5hL2iS1cNtQ8AdFmNpuCZBhfZOst44uyORgwHs2jsP44vyrwDWITfRJ3cSppa
         sJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129772; x=1721734572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg60V582lLlfGb1TAvAizxNMtINX79Zd8VO01rpHzTQ=;
        b=poPVr70In61WkkVXSP+XVJ+pOkWh7goS3BFMtF5wejl8T4zTq8TC+ySFP6ndv00Ydw
         8daBEizGAxF1NcZ5+X9Hl8Bui3c8iyXXTzi1N5Eazxy/JfUpOg4CnrrbkQtH30DRoM/R
         4vx8cXt4uwrR3VXsU9TRwFp5ulXa9WV3ly3J87hYwDgVTgzuiT1rVN3QuOItk7Y8ZMB7
         0kQAB2XcCaLZW0SEtBzipvbHonV+NcsccLd2FKricD35U8Id1lTJ9XgWj/hJjwaIsr+F
         hWeL006ODmDuaJUwLFTTTw45gz2+btLdcipq4Rl2tTfVk0IJPj95BynZROYMTrTI/skS
         zpXw==
X-Gm-Message-State: AOJu0YzPvbqC9dhiqEOCZB9IS+/CwJQtEyphwRevVjI29jX8fNxjVNIP
	BVzu2d0mfB6wpOP/fTbdWXvRWNKvWPhEyPam3Opy0x1A70+e/dd2HXwUI69IQF+1iQfRNUZdW3N
	t6lU=
X-Google-Smtp-Source: AGHT+IHRWb5xh9TCz5UY30AnodCc2101sTPR7Sz7nuLInMQidjD15kt1xcz35nNNjr0d8JEUql/TYg==
X-Received: by 2002:a05:600c:1f89:b0:426:5ef5:bcb1 with SMTP id 5b1f17b1804b1-427ba5ead42mr12205955e9.6.1721129772178;
        Tue, 16 Jul 2024 04:36:12 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e983e7sm121479495e9.23.2024.07.16.04.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 04/13] virtio_pci: pass vector policy enum to vp_find_one_vq_msix()
Date: Tue, 16 Jul 2024 13:35:43 +0200
Message-ID: <20240716113552.80599-5-jiri@resnulli.us>
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

