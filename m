Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6A1A0AED
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075477; cv=none; b=G6+QmNlFC8y7Zssyy+GsZzMln+y8a+1NqT5+8yCApMXfKwQ5Y/pBi23Bkz6HzVNBR1FvVrc/1x4bc4QGzFa0RsTJxcstV1qZhX/f1icG+sPiLhiSzXYilxPwZKJ1oc3XcuuN83lRvZLwz6QmrVFcx90clhASc2tvunAgoEiWD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075477; c=relaxed/simple;
	bh=Snh3T63PWiFdBBUVMQ3/r4su8giJCLx4nenT7axj3kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=josDwYoVX8Z6DxW5Ux7z9PekRUuiRf1LVjaU4IVz+tU2r4aTZWwtDL34+buQx4txGL/4hBpda61o4rSX1SA2uleeYs1L3HXxHs5A2KLiwhjrx+r/j8z/6x30hsKtDlsq22Ufr8/KGbylNU+CauC/SAdKalqrRMT9cA702eD+yB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GBLlb4uF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GBLlb4uF"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3679aba6017so185441f8f.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075474; x=1720680274; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Z+RovMcvbXdwuAiRuq6oNpagcXYfZd6PQuK+RNf8o4=;
        b=GBLlb4uFr+bfJv+csMdB9n+94aG0vRqwXeU5Pmp5skX91EH8wNFWDNqOI5LNoTn8c7
         Qa41gxW0/NC90skseiZik4Crl+9tOl2+sVkW0mmbkStOgMd8kzXSGFjqkQPSZwd0Jj45
         CrcuzNOey9ejxULhvtqRqkSQx64vL/jO1Nskn1sBxyhjaQ6B+YfSdgJHr2FJ43STbg/Y
         LmhBBkqDESq30UDzbBPPcqPwcYPD3HaVj9eIjjpDlsxY9ZhBGT0Bl7kUvggJ3VOgQv8H
         wcZCR05kf3eEMJy5nIxWwozfoFiCSE/wTSLJsP7cYusadouRR8QfCWFzehhfcUnLgtJw
         wXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075474; x=1720680274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z+RovMcvbXdwuAiRuq6oNpagcXYfZd6PQuK+RNf8o4=;
        b=IkCjxiB78XM871+OJys7MZA8st7LbA6yaiG4gaq3hmaUOq27SuIX59Lb38JL/UmULI
         1uUoW6qp23Pnt6DOK3VduwIbSn/sbUlnd42pDtWDfCT9kSwYdoVZOjoyM5qz++KUc02z
         +JicqK3lm7Y++9YtCge+WYZ3N7R27tHwgymL9hoMzB2oUlKczoFBvnmKnN9ru+SF/dGV
         +G2foTzlZ8A79BaN3uskWQEm8ZhTennJAVmliP/ze0mmVnCrGqALvZnbqRpUs0oKS+FF
         m+ZMdxKS6OKrm96ZNPRy5blmq4QAaTfCAN1pB2C73k8M7DNvyfyhkRrYVjck5UPRmehz
         OlRA==
X-Gm-Message-State: AOJu0YxvZ+5RgX/0nQHN+mkrlc4M2lWWqbFHdrPWYCxvwg0P1k3yt+Oy
	ymgdD0Za1WpRQcDsVaOwhSvhVOe9fRNkxYUqk9cNCN0Oj4fttXLuS9zp2T/ZhC50Op6ZOrvSbff
	F
X-Google-Smtp-Source: AGHT+IHlyPwyAU7tox0yvos9VSf3c99/mFNXaVGAxNVsshh2Dro2F0mQWH4XKYBy5n5IZySxR3h9lw==
X-Received: by 2002:adf:ec84:0:b0:367:99fd:d7b8 with SMTP id ffacd0b85a97d-3679dd36841mr467996f8f.35.1720075474499;
        Wed, 03 Jul 2024 23:44:34 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36797e5d97bsm2029877f8f.92.2024.07.03.23.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:33 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 19/19] virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
Date: Thu,  4 Jul 2024 08:43:50 +0200
Message-ID: <20240704064350.1097716-20-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704064350.1097716-1-jiri@resnulli.us>
References: <20240704064350.1097716-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since the original virtio_find_vqs() is no longer present, rename
virtio_find_vqs_info() back to virtio_find_vqs().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- rebased on top of virtqueue_info struct name change
---
 arch/um/drivers/virt-pci.c                    |  2 +-
 drivers/block/virtio_blk.c                    |  2 +-
 drivers/bluetooth/virtio_bt.c                 |  3 +--
 drivers/char/virtio_console.c                 |  3 +--
 drivers/crypto/virtio/virtio_crypto_core.c    |  2 +-
 drivers/firmware/arm_scmi/virtio.c            |  2 +-
 drivers/gpio/gpio-virtio.c                    |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_kms.c          |  2 +-
 drivers/iommu/virtio-iommu.c                  |  4 ++--
 drivers/net/virtio_net.c                      |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  4 ++--
 drivers/rpmsg/virtio_rpmsg_bus.c              |  2 +-
 drivers/scsi/virtio_scsi.c                    |  2 +-
 drivers/virtio/virtio_balloon.c               |  4 ++--
 drivers/virtio/virtio_input.c                 |  2 +-
 fs/fuse/virtio_fs.c                           |  2 +-
 include/linux/virtio_config.h                 | 10 +++++-----
 net/vmw_vsock/virtio_transport.c              |  3 +--
 sound/virtio/virtio_card.c                    |  2 +-
 19 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3a668241c0aa..b16a75c94b8b 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -574,7 +574,7 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
 	struct virtqueue *vqs[2];
 	int err, i;
 
-	err = virtio_find_vqs_info(dev->vdev, 2, vqs, vqs_info, NULL);
+	err = virtio_find_vqs(dev->vdev, 2, vqs, vqs_info, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index ca3446503e82..112a9e629ab5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1020,7 +1020,7 @@ static int init_vq(struct virtio_blk *vblk)
 	}
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs_info(vdev, num_vqs, vqs, vqs_info, &desc);
+	err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 79574855ed54..756f292df9e8 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -284,8 +284,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vbt->rx, virtbt_rx_work);
 
-	err = virtio_find_vqs_info(vdev, VIRTBT_NUM_VQS, vbt->vqs,
-				   vqs_info, NULL);
+	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 903d83a1ffe8..de7d720d99fa 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1849,8 +1849,7 @@ static int init_vqs(struct ports_device *portdev)
 		}
 	}
 	/* Find the queues. */
-	err = virtio_find_vqs_info(portdev->vdev, nr_queues, vqs,
-				   vqs_info, NULL);
+	err = virtio_find_vqs(portdev->vdev, nr_queues, vqs, vqs_info, NULL);
 	if (err)
 		goto free;
 
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index b8119d1f9931..d0278eb568b9 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -129,7 +129,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		vqs_info[i].name = vi->data_vq[i].name;
 	}
 
-	ret = virtio_find_vqs_info(vi->vdev, total_vqs, vqs, vqs_info, NULL);
+	ret = virtio_find_vqs(vi->vdev, total_vqs, vqs, vqs_info, NULL);
 	if (ret)
 		goto err_find;
 
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index d7cdefb6bd54..dd3459bdb9cb 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -829,7 +829,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	if (have_vq_rx)
 		channels[VIRTIO_SCMI_VQ_RX].is_rx = true;
 
-	ret = virtio_find_vqs_info(vdev, vq_cnt, vqs, scmi_vio_vqs_info, NULL);
+	ret = virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_vqs_info, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
 		return ret;
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index d11464420797..93544ff62513 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -464,8 +464,8 @@ static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
 	struct virtqueue *vqs[2] = { NULL, NULL };
 	int ret;
 
-	ret = virtio_find_vqs_info(vdev, vgpio->irq_lines ? 2 : 1, vqs,
-				   vqs_info, NULL);
+	ret = virtio_find_vqs(vdev, vgpio->irq_lines ? 2 : 1, vqs,
+			      vqs_info, NULL);
 	if (ret) {
 		dev_err(&vdev->dev, "failed to find vqs: %d\n", ret);
 		return ret;
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1590fc180c66..7dfb2006c561 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -206,7 +206,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	DRM_INFO("features: %ccontext_init\n",
 		 vgdev->has_context_init ? '+' : '-');
 
-	ret = virtio_find_vqs_info(vgdev->vdev, 2, vqs, vqs_info, NULL);
+	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, vqs_info, NULL);
 	if (ret) {
 		DRM_ERROR("failed to find virt queues\n");
 		goto err_vqs;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index d3c7877a3806..b85ce6310ddb 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1089,8 +1089,8 @@ static int viommu_init_vqs(struct viommu_dev *viommu)
 		{ "event", viommu_event_handler },
 	};
 
-	return virtio_find_vqs_info(vdev, VIOMMU_NR_VQS, viommu->vqs,
-				    vqs_info, NULL);
+	return virtio_find_vqs(vdev, VIOMMU_NR_VQS, viommu->vqs,
+			       vqs_info, NULL);
 }
 
 static int viommu_fill_evtq(struct viommu_dev *viommu)
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 686ecd819fec..a42331d89da2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5343,7 +5343,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 			vqs_info[rxq2vq(i)].ctx = true;
 	}
 
-	ret = virtio_find_vqs_info(vi->vdev, total_vqs, vqs, vqs_info, NULL);
+	ret = virtio_find_vqs(vi->vdev, total_vqs, vqs, vqs_info, NULL);
 	if (ret)
 		goto err_find;
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 7bda786631ba..f2e58d246284 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6579,8 +6579,8 @@ static int init_vqs(struct virtio_device *vdev)
 		[HWSIM_VQ_RX] = { "rx", hwsim_virtio_rx_done },
 	};
 
-	return virtio_find_vqs_info(vdev, HWSIM_NUM_VQS,
-				    hwsim_vqs, vqs_info, NULL);
+	return virtio_find_vqs(vdev, HWSIM_NUM_VQS,
+			       hwsim_vqs, vqs_info, NULL);
 }
 
 static int fill_vq(struct virtqueue *vq)
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index fb466ef20f07..89d7a3b8c48b 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -893,7 +893,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	init_waitqueue_head(&vrp->sendq);
 
 	/* We expect two virtqueues, rx and tx (and in this order) */
-	err = virtio_find_vqs_info(vdev, 2, vqs, vqs_info, NULL);
+	err = virtio_find_vqs(vdev, 2, vqs, vqs_info, NULL);
 	if (err)
 		goto free_vrp;
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index bf9346a66df2..8471f38b730e 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -879,7 +879,7 @@ static int virtscsi_init(struct virtio_device *vdev,
 		vqs_info[i].name = "request_poll";
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs_info(vdev, num_vqs, vqs, vqs_info, &desc);
+	err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index cfa710abf441..54469277ca30 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -587,8 +587,8 @@ static int init_vqs(struct virtio_balloon *vb)
 		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].callback = balloon_ack;
 	}
 
-	err = virtio_find_vqs_info(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
-				   vqs_info, NULL);
+	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
+			      vqs_info, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 6f803dc3d0f9..a5d63269f20b 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -192,7 +192,7 @@ static int virtinput_init_vqs(struct virtio_input *vi)
 	struct virtqueue *vqs[2];
 	int err;
 
-	err = virtio_find_vqs_info(vi->vdev, 2, vqs, vqs_info, NULL);
+	err = virtio_find_vqs(vi->vdev, 2, vqs, vqs_info, NULL);
 	if (err)
 		return err;
 	vi->evt = vqs[0];
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a335b421f196..dd5260141615 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -836,7 +836,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		vqs_info[i].name = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs_info(vdev, fs->nvqs, vqs, vqs_info, &desc);
+	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, vqs_info, &desc);
 	if (ret < 0)
 		goto out;
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 939c8dc909a5..8efba71615a4 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -218,10 +218,10 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 }
 
 static inline
-int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
-			 struct virtqueue *vqs[],
-			 struct virtqueue_info vqs_info[],
-			 struct irq_affinity *desc)
+int virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
+		    struct virtqueue *vqs[],
+		    struct virtqueue_info vqs_info[],
+		    struct irq_affinity *desc)
 {
 	return vdev->config->find_vqs(vdev, nvqs, vqs, vqs_info, desc);
 }
@@ -234,7 +234,7 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 		{ n, c },
 	};
 	struct virtqueue *vq;
-	int err = virtio_find_vqs_info(vdev, 1, &vq, vqs_info, NULL);
+	int err = virtio_find_vqs(vdev, 1, &vq, vqs_info, NULL);
 
 	if (err < 0)
 		return ERR_PTR(err);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 3033680fcc98..64a07acfef12 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -624,8 +624,7 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 	};
 	int ret;
 
-	ret = virtio_find_vqs_info(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info,
-				   NULL);
+	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 109a0008b69e..965209e1d872 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -125,7 +125,7 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
 	unsigned int n;
 	int rc;
 
-	rc = virtio_find_vqs_info(vdev, VIRTIO_SND_VQ_MAX, vqs, vqs_info, NULL);
+	rc = virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, vqs_info, NULL);
 	if (rc) {
 		dev_err(&vdev->dev, "failed to initialize virtqueues\n");
 		return rc;
-- 
2.45.2

