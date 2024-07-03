Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69FF176AA4
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010409; cv=none; b=j40AJaXYScvKTMwNHITg7r+fYE7rfWwNL8JfrnPbLOdNrgZ7dvyVAkMJQCSnvX4SRzRhOLstdV4Ct45G1QKQXd5yJmYYEbWkKUlrvAloaSgxUsbVqbDrkWLVkv7FadaOgwW0tlVSO772XmwCV0HPlt2yA8cJPP9j8PvvEe2NwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010409; c=relaxed/simple;
	bh=Utmg50c3ec4m5iU6emrGLYSkt1LXJI6rpyU81W5DPAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcZzJXK8YzUWasjtnw9kBei89d+wwuwwl+K9sl5ir0sLraIQywTY56zEwoU3vChKphVOdaIrZs2QX+byLUjnuBmivsgAe6HNacoVQc6xD/DwIJZleVAo1fhqFC50/GKOCqxq6r5pt9ciozqvTNk9XWzlwvFzWF+xvxtVyKOzGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0vpbJGVP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0vpbJGVP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so3974135e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010406; x=1720615206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w6lgepLWT77w153tZ1btNUZqRPKxC8pjWvB5HB2WQ4=;
        b=0vpbJGVPXzi6jMJT6y5EMvHv5wv/G2Fzae5tTyG0woZxCqbR8epEpOy3cLqEo7do48
         93unxPaXSgJRec9zY+BNz+ySqJLEMI0n0LYJOkHZ82JEafsTlpzc3HkbasQodYgA+t22
         d2cNH5jasZbGiRCdWk+VEfT4Nsmx6NODz9KGlguYxi3empeiGwBV3Fz2JyA4h6/4ko40
         Po6zgDtHEf9g81ERylhJEFchMAye27sPo1Hckau9Nx0m4J2ZH3Vr5igw2kJSrv7+7aUI
         GQzrigwYkVEwnzlvB/4pLr9RC9J1PvfS+tXHzZEGzzFLwAw4gF4u568TiBAp421wp/QE
         v/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010406; x=1720615206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w6lgepLWT77w153tZ1btNUZqRPKxC8pjWvB5HB2WQ4=;
        b=f4ZEeq2Z86g7sJ0tvZtUuRKTbX6a3MM4sgSX0HcFk98kAvcvCotkdcbmLm8SdSkLW3
         +q+OSTCNqOJ3ZMlK6BTVvLtru9DYSy1Aj73MadPsSzv5xqhuvhUBkTbGlbEELqN9OGLE
         SLaix1jor75NM+QUmrPTXX+hcb9pxEbztYKdbBSMk3hcNShao8fyrZMVIAwb3owtea6t
         gJIeanXKzSRYBJeOQU3ijBIBasbXo/Me46Al6UIiYgoYXILD7nA2R0QHpMD3bE4qNc/K
         hxOxZcHBWyscsH3NFETtJ5GKtv4gH/ZLW2N5rKqA8eKh3JCbZpthqsu7qG7aGrE2Yevk
         VOKg==
X-Gm-Message-State: AOJu0Yx3GeWx5XUmYca+TTXbjkwCHErjkHVshqQRHS85PR6ssrVzM0hf
	2ugDe9Jk8O2z+WfsaK6roRVGYxUKHMWNJbG5kBUD8PiTdiTn6bCHfpK1uafydO5GS2asLAIIYfx
	o
X-Google-Smtp-Source: AGHT+IE9ShZ54zZRfk5JYfiGPluEM5g2CD1qvfpfbzmp1JpqgK9UA+i7CUMd8HpNaDHTXnXmg/j37A==
X-Received: by 2002:a05:600c:5118:b0:424:acbf:c068 with SMTP id 5b1f17b1804b1-4264093afefmr16288865e9.16.1720010406230;
        Wed, 03 Jul 2024 05:40:06 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36788e37b53sm4300639f8f.45.2024.07.03.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:40:05 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 19/19] virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
Date: Wed,  3 Jul 2024 14:39:13 +0200
Message-ID: <20240703123913.969202-20-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703123913.969202-1-jiri@resnulli.us>
References: <20240703123913.969202-1-jiri@resnulli.us>
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
index 3df2ea53471a..643b52d957d9 100644
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
index 574498280dee..96f5fffee4b9 100644
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
index 6481f9fe24c4..a9a82c358cb9 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -285,8 +285,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vbt->rx, virtbt_rx_work);
 
-	err = virtio_find_vqs_info(vdev, VIRTBT_NUM_VQS, vbt->vqs,
-				   vqs_info, NULL);
+	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 23dbf1c18c90..b69fb675883c 100644
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
index 800d5c2a688c..fb7853fdad3a 100644
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
index a6ae59c03308..0ee745762a43 100644
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
index a45b392358c4..c0a0913d62c7 100644
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
index 938c08a707eb..ebb6ece2aec3 100644
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
index ef77c1efc767..9f713789cd4a 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1099,8 +1099,8 @@ static int viommu_init_vqs(struct viommu_dev *viommu)
 		{ "event", viommu_event_handler },
 	};
 
-	return virtio_find_vqs_info(vdev, VIOMMU_NR_VQS, viommu->vqs,
-				    vqs_info, NULL);
+	return virtio_find_vqs(vdev, VIOMMU_NR_VQS, viommu->vqs,
+			       vqs_info, NULL);
 }
 
 static int viommu_fill_evtq(struct viommu_dev *viommu)
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e367c7b88a0..981703972483 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4397,7 +4397,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 			vqs_info[rxq2vq(i)].ctx = true;
 	}
 
-	ret = virtio_find_vqs_info(vi->vdev, total_vqs, vqs, vqs_info, NULL);
+	ret = virtio_find_vqs(vi->vdev, total_vqs, vqs, vqs_info, NULL);
 	if (ret)
 		goto err_find;
 
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 565c091f1ba5..7782fc59701a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6563,8 +6563,8 @@ static int init_vqs(struct virtio_device *vdev)
 		[HWSIM_VQ_RX] = { "rx", hwsim_virtio_rx_done },
 	};
 
-	return virtio_find_vqs_info(vdev, HWSIM_NUM_VQS,
-				    hwsim_vqs, vqs_info, NULL);
+	return virtio_find_vqs(vdev, HWSIM_NUM_VQS,
+			       hwsim_vqs, vqs_info, NULL);
 }
 
 static int fill_vq(struct virtqueue *vq)
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 440f1cc9157d..32e8a546edf3 100644
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
index 416c6820b537..25db62f01be9 100644
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
index 02ae30cc96ec..49719d74449b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -572,8 +572,8 @@ static int init_vqs(struct virtio_balloon *vb)
 		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].callback = balloon_ack;
 	}
 
-	err = virtio_find_vqs_info(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
-				   vqs_info, NULL);
+	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
+			      vqs_info, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index e1491ad9eced..2cd1df0b6533 100644
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
index 466d4888d664..0424eb15867c 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -777,7 +777,7 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 		vqs_info[i].name = fs->vqs[i].name;
 	}
 
-	ret = virtio_find_vqs_info(vdev, fs->nvqs, vqs, vqs_info, NULL);
+	ret = virtio_find_vqs(vdev, fs->nvqs, vqs, vqs_info, NULL);
 	if (ret < 0)
 		goto out;
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 639d68e95580..3c48f1ff6efc 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -218,10 +218,10 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 }
 
 static inline
-int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
-			 struct virtqueue *vqs[],
-			 struct virtio_queue_info vqs_info[],
-			 struct irq_affinity *desc)
+int virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
+		    struct virtqueue *vqs[],
+		    struct virtio_queue_info vqs_info[],
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
index d303ef4d9898..3e957cf65412 100644
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
index a6b0da6790dc..ae560365439b 100644
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

