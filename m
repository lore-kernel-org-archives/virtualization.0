Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5FF1805E
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219906; cv=none; b=Xa1TCto63iaWxSgNTFt5cGaXjiNSju8onP71T2DqU8ckl2o2RJQeTTV6WLJUaXau9t6CqF+cyUSyiyqP9R3DvpRMWZpvrBY1UrDMiwvzhc6APSYqtGGDTeUFMOBLVvWrpXTEQlj/Il1p/qkuS8Min+OklrQH0pAs9Xxg6KL4+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219906; c=relaxed/simple;
	bh=gT1HqD3gLxbBoHB9bIfltGKiB+KGsr6aRAZSUQx59YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP/6ZFaycAadN5GNcmf4orzRvCVjfh8Kn3LEWmtNwUHkmn5GPDTyQn0u91PtXzY6k/J56vtdVdBYZDoaXwyXEtKMatcSmx9M/5qzSMluS+NDzRr0NDcxELIprSo9MqG1hO9Seu9KZwIg4NRBxfRhROuwrBfiIruhzxp3uI4TIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pTQmjSAT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pTQmjSAT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso29659185e9.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219902; x=1719824702; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AHFQR+OL8JQXayYFF5OCLem9pp/mDCSlE/eUh7uql8=;
        b=pTQmjSATSSbMad0VNB7e02GDTSHZFXmkj4nUeHQtMfKO018Lc83J6zBT9DCiCKpcOF
         BUMP1d04IwPTixCXCbvVgRR1ac5d3HnAXVu+rVPAty457yIe2gltWo7kgujtiF6b8vbL
         F/oFc99Q8ba1sghymkqO2XM+3LsVLCBLAbN4pcSVLQddMIYHCAJZMIxRLDlLm9Y/kLNk
         CdeH8HxpxSoVLBsTOgWT18szBDx2881AuVWINyn11QivnZ1XUoCZChu7GLefQG3ul9JW
         fZrds/XFkxsNS/e63Tthan6JitieNXs4KXPvJnPeRkN0oC1Oj0fRub3zkm6LkVDod/ki
         3o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219902; x=1719824702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AHFQR+OL8JQXayYFF5OCLem9pp/mDCSlE/eUh7uql8=;
        b=XvunweppGHQ+DXBuz8n2PemUuNjhgnhh5fdejE177Hdzl1N5xYl232IoB+W1juiY0c
         vFkWjPmmziS7f8XGCTkpTHaJisUl1rxLq7FX9JdL+YpfFtsOtYhYkES28KcA8wUc8aJ5
         IH+Q0bEHYp8UojJx3MAXMnAymIk6hY1lHtrD4L1YDjDSnKg08KGcau60aTZNVdqhCyuv
         6/1muSQZQolTbX+NlXfZdv5bcaJL2Aiclv/HgSq2CG6QdGR1ef/swH4znY81uiD8BsPb
         zcwM68glcKjR9BLRj5+bi9J8LD+O+Xc+vSI8xQHiCCxG98LEW3/BbpvASCfFZMEOHX2E
         SHKQ==
X-Gm-Message-State: AOJu0Yy6b6lvSvl+suuufgO5Xs3j1amU1z40eDH85mjqsloDLwlh0aqZ
	yo7Z8loBGHvtBtewgN+0Zcr3k3sjeV+6CjjfZxW1dgl2N6RpPY+LYpyDuyHi9t3iuPufUyvMaXS
	aEdA=
X-Google-Smtp-Source: AGHT+IEvc+1wyZ9oL25VGI7bob+pB9Dh5e4r7obv36RR62o4gk9pkwiaB/NDnUtn+xcYaAwxBseDZw==
X-Received: by 2002:a5d:6448:0:b0:364:8f54:e0ec with SMTP id ffacd0b85a97d-366e3295821mr3942531f8f.19.1719219902017;
        Mon, 24 Jun 2024 02:05:02 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b861bsm9380274f8f.29.2024.06.24.02.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:01 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 2/8] virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
Date: Mon, 24 Jun 2024 11:04:45 +0200
Message-ID: <20240624090451.2683976-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
References: <20240624090451.2683976-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

It is guaranteed by the virtio_pci and PCI layers that none of the VFs
is probed before setup_vq() is called for admin queue and after del_vq()
is called for admin queue. Therefore treat vp_dev->admin_vq.info.vq as
static, don't null it and don't take cmd lock during assign.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.h |  2 +-
 drivers/virtio/virtio_pci_modern.c | 11 +----------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 7fef52bee455..148d1ab01a69 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -45,7 +45,7 @@ struct virtio_pci_vq_info {
 struct virtio_pci_admin_vq {
 	/* Virtqueue info associated with this admin queue. */
 	struct virtio_pci_vq_info info;
-	/* serializing admin commands execution and virtqueue deletion */
+	/* serializing admin commands execution. */
 	struct mutex cmd_lock;
 	u64 supported_cmds;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f62b530aa3b5..925166498e2e 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -580,11 +580,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		goto err;
 	}
 
-	if (is_avq) {
-		mutex_lock(&vp_dev->admin_vq.cmd_lock);
+	if (is_avq)
 		vp_dev->admin_vq.info.vq = vq;
-		mutex_unlock(&vp_dev->admin_vq.cmd_lock);
-	}
 
 	return vq;
 
@@ -621,12 +618,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 
-	if (vp_is_avq(&vp_dev->vdev, vq->index)) {
-		mutex_lock(&vp_dev->admin_vq.cmd_lock);
-		vp_dev->admin_vq.info.vq = NULL;
-		mutex_unlock(&vp_dev->admin_vq.cmd_lock);
-	}
-
 	if (vp_dev->msix_enabled)
 		vp_modern_queue_vector(mdev, vq->index,
 				       VIRTIO_MSI_NO_VECTOR);
-- 
2.45.1

