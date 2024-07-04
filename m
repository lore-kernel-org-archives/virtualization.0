Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395361A070D
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103697; cv=none; b=kUpDWeHSwKMy2DSq/UNAesCk3qUjjkhfGteNRqqVEAm4fucNl19wu8cRc1ZjS3w39PC1sep+tj2NPzioOaKluRi4hAgokxHRv783xMH1Fx1ZNt6e6jT0l8M1ieq8Msbwc91JnNmPORTHIrFhWyip6mS2TbiigcC/3u2/P4+x2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103697; c=relaxed/simple;
	bh=oWm9c2Mo9u3iPIUM7gcDTnf5xZKbw/VxF58fgKzzOFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kderVLJJtiULquvfSG0mz0bcZT/vJI4PN2qD1YeX5Z4DVQvrpEpOzrCwLXhbnIG9W/MNL+ozQ6Dc8pg8BF6VHJl30B2Q6JwiXDRvBL0jSuY/dmguJWxjMcJxDsiALe8pTyxmmfyXZKdsVy/bV7uq8cd3ZW8O5kc4Gq0pbGlq6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CUqN/sgA; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CUqN/sgA"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so9163791fa.0
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103693; x=1720708493; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ta66Aj+ejEfFtd9Ma2d3WseS5dEIZYEOg17w4eh/7JU=;
        b=CUqN/sgAQHrhSQYQf6sfYplRQEL6p4rkQba8EVv0X2E/iAEb0EFa3Rh1zkWuOdcMT4
         6LtlFF6OrZJVEYNRYmwVeuciVVFJWR6tA5IsY3bOEiEv/KcRyl/LINm8dgjx9ap4/laW
         OaiKqenzd5foHNqZBvczguI3NbvCmPxxXZ0/gNdpyKgdP8SWyTkWXVsi5QVRrmnU3FGD
         EmwK2JRxuOHXPZQVwin495RXdlK0GyWM2OBX35Gueyfp9Nmjs0ifUm0Vlj+G/2w0dK7J
         srN9f7SK1z5UNwcYhxl850NplGiI7C84o4+OYV+ijLyBASWvep24YkxZOLIDAJczZjN0
         p3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103693; x=1720708493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ta66Aj+ejEfFtd9Ma2d3WseS5dEIZYEOg17w4eh/7JU=;
        b=P9NF8DQklL4arkrbxpPpjfZbaKUTPwf0uyFr9PDAIpxe6CewReq60wfgT5huSzYXiZ
         1rfmh7bsdbFA5bQUNhpudUGa5qXSqi+KYW5EAwQ7qgYzDaepDCU4xAXxbIuln8RtN+8q
         j5zT0J/flHSagTiAJtf1TSQ8GAIGkzEPZ3ouQIXsdc6M2ejeKdHo6GA21RRfAwPT5YIg
         ZaWiELqbT0aZZDnqHsKxnHZEoLRboC6V51h09bFsXUBRNpWA876wF3LuUK9BYe+sBZ3L
         4FS6IusTKUgfzxoQrkqIIMUQ3tL2Gc+bFGaq8e+fAf8d9/zq7Rcc2RuIcsnoHy3fUTP4
         rLBQ==
X-Gm-Message-State: AOJu0YxwgP09c4J6wS9DlbJzXxGs8KMiMNtt/qALmieCMvE1NJzgOzxD
	B/QSow29KJXPLR4RzjoT81wAQknT1cnkFFSGbfxBIAO+09aXgVCz5FSsV4sNtj6REg8LAN/9JK7
	mI9g=
X-Google-Smtp-Source: AGHT+IEd6QZv9qLgX6X3lBSv7b8hgAw4rXQKyJlM62YyvZrcAInOZTUsQ8fYcxjdt0nPTiNMufdc7A==
X-Received: by 2002:a2e:a58a:0:b0:2ec:5a13:e19c with SMTP id 38308e7fff4ca-2ee8ed933e0mr17981451fa.17.1720103693118;
        Thu, 04 Jul 2024 07:34:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367947ddebfsm4254454f8f.34.2024.07.04.07.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 17/19] virtio: convert the rest virtio_find_vqs() users to virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 16:33:05 +0200
Message-ID: <20240704143307.1212454-18-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704143307.1212454-1-jiri@resnulli.us>
References: <20240704143307.1212454-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of passing separate names and callbacks arrays
to virtio_find_vqs(), have one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- added forgotten VIRTIO_SND_VQ_MAX for array size in virtio_card.c
- s/virtio_queue_info/virtqueue_info/
---
 arch/um/drivers/virt-pci.c                    |  8 ++++---
 drivers/bluetooth/virtio_bt.c                 | 14 ++++-------
 drivers/firmware/arm_scmi/virtio.c            | 11 ++++-----
 drivers/gpio/gpio-virtio.c                    | 10 ++++----
 drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++++----
 drivers/iommu/virtio-iommu.c                  | 11 ++++-----
 drivers/net/wireless/virtual/mac80211_hwsim.c | 14 ++++-------
 drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++++---
 drivers/virtio/virtio_input.c                 |  9 ++++----
 net/vmw_vsock/virtio_transport.c              | 17 +++++---------
 sound/virtio/virtio_card.c                    | 23 ++++++++-----------
 11 files changed, 59 insertions(+), 75 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7cb503469bbd..3a668241c0aa 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -567,12 +567,14 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 
 static int um_pci_init_vqs(struct um_pci_device *dev)
 {
+	struct virtqueue_info vqs_info[] = {
+		{ "cmd", um_pci_cmd_vq_cb },
+		{ "irq", um_pci_irq_vq_cb },
+	};
 	struct virtqueue *vqs[2];
-	static const char *const names[2] = { "cmd", "irq" };
-	vq_callback_t *cbs[2] = { um_pci_cmd_vq_cb, um_pci_irq_vq_cb };
 	int err, i;
 
-	err = virtio_find_vqs(dev->vdev, 2, vqs, cbs, names, NULL);
+	err = virtio_find_vqs_info(dev->vdev, 2, vqs, vqs_info, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 40bd83825c29..79574855ed54 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -254,13 +254,9 @@ static void virtbt_rx_done(struct virtqueue *vq)
 
 static int virtbt_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *callbacks[VIRTBT_NUM_VQS] = {
-		[VIRTBT_VQ_TX] = virtbt_tx_done,
-		[VIRTBT_VQ_RX] = virtbt_rx_done,
-	};
-	const char *names[VIRTBT_NUM_VQS] = {
-		[VIRTBT_VQ_TX] = "tx",
-		[VIRTBT_VQ_RX] = "rx",
+	struct virtqueue_info vqs_info[VIRTBT_NUM_VQS] = {
+		[VIRTBT_VQ_TX] = { "tx", virtbt_tx_done },
+		[VIRTBT_VQ_RX] = { "rx", virtbt_rx_done },
 	};
 	struct virtio_bluetooth *vbt;
 	struct hci_dev *hdev;
@@ -288,8 +284,8 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vbt->rx, virtbt_rx_work);
 
-	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, callbacks,
-			      names, NULL);
+	err = virtio_find_vqs_info(vdev, VIRTBT_NUM_VQS, vbt->vqs,
+				   vqs_info, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 4892058445ce..d7cdefb6bd54 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -354,11 +354,9 @@ static void scmi_vio_deferred_tx_worker(struct work_struct *work)
 	scmi_vio_channel_release(vioch);
 }
 
-static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
-
-static vq_callback_t *scmi_vio_complete_callbacks[] = {
-	scmi_vio_complete_cb,
-	scmi_vio_complete_cb
+static struct virtqueue_info scmi_vio_vqs_info[] = {
+	{ "tx", scmi_vio_complete_cb },
+	{ "rx", scmi_vio_complete_cb },
 };
 
 static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo)
@@ -831,8 +829,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	if (have_vq_rx)
 		channels[VIRTIO_SCMI_VQ_RX].is_rx = true;
 
-	ret = virtio_find_vqs(vdev, vq_cnt, vqs, scmi_vio_complete_callbacks,
-			      scmi_vio_vqueue_names, NULL);
+	ret = virtio_find_vqs_info(vdev, vq_cnt, vqs, scmi_vio_vqs_info, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to get %d virtqueue(s)\n", vq_cnt);
 		return ret;
diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 9fae8e396c58..d11464420797 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -457,15 +457,15 @@ static void virtio_gpio_free_vqs(struct virtio_device *vdev)
 static int virtio_gpio_alloc_vqs(struct virtio_gpio *vgpio,
 				 struct virtio_device *vdev)
 {
-	const char * const names[] = { "requestq", "eventq" };
-	vq_callback_t *cbs[] = {
-		virtio_gpio_request_vq,
-		virtio_gpio_event_vq,
+	struct virtqueue_info vqs_info[] = {
+		{ "requestq", virtio_gpio_request_vq },
+		{ "eventq", virtio_gpio_event_vq },
 	};
 	struct virtqueue *vqs[2] = { NULL, NULL };
 	int ret;
 
-	ret = virtio_find_vqs(vdev, vgpio->irq_lines ? 2 : 1, vqs, cbs, names, NULL);
+	ret = virtio_find_vqs_info(vdev, vgpio->irq_lines ? 2 : 1, vqs,
+				   vqs_info, NULL);
 	if (ret) {
 		dev_err(&vdev->dev, "failed to find vqs: %d\n", ret);
 		return ret;
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 5a3b5aaed1f3..1590fc180c66 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -116,11 +116,10 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
 
 int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 {
-	static vq_callback_t *callbacks[] = {
-		virtio_gpu_ctrl_ack, virtio_gpu_cursor_ack
+	struct virtqueue_info vqs_info[] = {
+		{ "control", virtio_gpu_ctrl_ack },
+		{ "cursor", virtio_gpu_cursor_ack },
 	};
-	static const char * const names[] = { "control", "cursor" };
-
 	struct virtio_gpu_device *vgdev;
 	/* this will expand later */
 	struct virtqueue *vqs[2];
@@ -207,7 +206,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	DRM_INFO("features: %ccontext_init\n",
 		 vgdev->has_context_init ? '+' : '-');
 
-	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
+	ret = virtio_find_vqs_info(vgdev->vdev, 2, vqs, vqs_info, NULL);
 	if (ret) {
 		DRM_ERROR("failed to find virt queues\n");
 		goto err_vqs;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 36d680826b57..d3c7877a3806 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1084,14 +1084,13 @@ static struct iommu_ops viommu_ops = {
 static int viommu_init_vqs(struct viommu_dev *viommu)
 {
 	struct virtio_device *vdev = dev_to_virtio(viommu->dev);
-	const char *names[] = { "request", "event" };
-	vq_callback_t *callbacks[] = {
-		NULL, /* No async requests */
-		viommu_event_handler,
+	struct virtqueue_info vqs_info[] = {
+		{ "request" },
+		{ "event", viommu_event_handler },
 	};
 
-	return virtio_find_vqs(vdev, VIOMMU_NR_VQS, viommu->vqs, callbacks,
-			       names, NULL);
+	return virtio_find_vqs_info(vdev, VIOMMU_NR_VQS, viommu->vqs,
+				    vqs_info, NULL);
 }
 
 static int viommu_fill_evtq(struct viommu_dev *viommu)
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index c5d896994e70..7bda786631ba 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -6574,17 +6574,13 @@ static void hwsim_virtio_rx_done(struct virtqueue *vq)
 
 static int init_vqs(struct virtio_device *vdev)
 {
-	vq_callback_t *callbacks[HWSIM_NUM_VQS] = {
-		[HWSIM_VQ_TX] = hwsim_virtio_tx_done,
-		[HWSIM_VQ_RX] = hwsim_virtio_rx_done,
-	};
-	const char *names[HWSIM_NUM_VQS] = {
-		[HWSIM_VQ_TX] = "tx",
-		[HWSIM_VQ_RX] = "rx",
+	struct virtqueue_info vqs_info[HWSIM_NUM_VQS] = {
+		[HWSIM_VQ_TX] = { "tx", hwsim_virtio_tx_done },
+		[HWSIM_VQ_RX] = { "rx", hwsim_virtio_rx_done },
 	};
 
-	return virtio_find_vqs(vdev, HWSIM_NUM_VQS,
-			       hwsim_vqs, callbacks, names, NULL);
+	return virtio_find_vqs_info(vdev, HWSIM_NUM_VQS,
+				    hwsim_vqs, vqs_info, NULL);
 }
 
 static int fill_vq(struct virtqueue *vq)
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index e9e8c1f7829f..fb466ef20f07 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -868,8 +868,10 @@ static void rpmsg_virtio_del_ctrl_dev(struct rpmsg_device *rpdev_ctrl)
 
 static int rpmsg_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *vq_cbs[] = { rpmsg_recv_done, rpmsg_xmit_done };
-	static const char * const names[] = { "input", "output" };
+	struct virtqueue_info vqs_info[] = {
+		{ "input", rpmsg_recv_done },
+		{ "output", rpmsg_xmit_done },
+	};
 	struct virtqueue *vqs[2];
 	struct virtproc_info *vrp;
 	struct virtio_rpmsg_channel *vch = NULL;
@@ -891,7 +893,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	init_waitqueue_head(&vrp->sendq);
 
 	/* We expect two virtqueues, rx and tx (and in this order) */
-	err = virtio_find_vqs(vdev, 2, vqs, vq_cbs, names, NULL);
+	err = virtio_find_vqs_info(vdev, 2, vqs, vqs_info, NULL);
 	if (err)
 		goto free_vrp;
 
diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 1a730d6c0b55..6f803dc3d0f9 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -185,13 +185,14 @@ static void virtinput_cfg_abs(struct virtio_input *vi, int abs)
 
 static int virtinput_init_vqs(struct virtio_input *vi)
 {
+	struct virtqueue_info vqs_info[] = {
+		{ "events", virtinput_recv_events },
+		{ "status", virtinput_recv_status },
+	};
 	struct virtqueue *vqs[2];
-	vq_callback_t *cbs[] = { virtinput_recv_events,
-				 virtinput_recv_status };
-	static const char * const names[] = { "events", "status" };
 	int err;
 
-	err = virtio_find_vqs(vi->vdev, 2, vqs, cbs, names, NULL);
+	err = virtio_find_vqs_info(vi->vdev, 2, vqs, vqs_info, NULL);
 	if (err)
 		return err;
 	vi->evt = vqs[0];
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 43d405298857..3033680fcc98 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -617,20 +617,15 @@ static void virtio_transport_rx_work(struct work_struct *work)
 static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 {
 	struct virtio_device *vdev = vsock->vdev;
-	static const char * const names[] = {
-		"rx",
-		"tx",
-		"event",
-	};
-	vq_callback_t *callbacks[] = {
-		virtio_vsock_rx_done,
-		virtio_vsock_tx_done,
-		virtio_vsock_event_done,
+	struct virtqueue_info vqs_info[] = {
+		{ "rx", virtio_vsock_rx_done },
+		{ "tx", virtio_vsock_tx_done },
+		{ "event", virtio_vsock_event_done },
 	};
 	int ret;
 
-	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, callbacks, names,
-			      NULL);
+	ret = virtio_find_vqs_info(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info,
+				   NULL);
 	if (ret < 0)
 		return ret;
 
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 7805daea0102..109a0008b69e 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -110,25 +110,22 @@ static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
 static int virtsnd_find_vqs(struct virtio_snd *snd)
 {
 	struct virtio_device *vdev = snd->vdev;
-	static vq_callback_t *callbacks[VIRTIO_SND_VQ_MAX] = {
-		[VIRTIO_SND_VQ_CONTROL] = virtsnd_ctl_notify_cb,
-		[VIRTIO_SND_VQ_EVENT] = virtsnd_event_notify_cb,
-		[VIRTIO_SND_VQ_TX] = virtsnd_pcm_tx_notify_cb,
-		[VIRTIO_SND_VQ_RX] = virtsnd_pcm_rx_notify_cb
-	};
-	static const char *names[VIRTIO_SND_VQ_MAX] = {
-		[VIRTIO_SND_VQ_CONTROL] = "virtsnd-ctl",
-		[VIRTIO_SND_VQ_EVENT] = "virtsnd-event",
-		[VIRTIO_SND_VQ_TX] = "virtsnd-tx",
-		[VIRTIO_SND_VQ_RX] = "virtsnd-rx"
+	struct virtqueue_info vqs_info[VIRTIO_SND_VQ_MAX] = {
+		[VIRTIO_SND_VQ_CONTROL] = { "virtsnd-ctl",
+					    virtsnd_ctl_notify_cb },
+		[VIRTIO_SND_VQ_EVENT] = { "virtsnd-event",
+					  virtsnd_event_notify_cb },
+		[VIRTIO_SND_VQ_TX] = { "virtsnd-tx",
+				       virtsnd_pcm_tx_notify_cb },
+		[VIRTIO_SND_VQ_RX] = { "virtsnd-rx",
+				       virtsnd_pcm_rx_notify_cb },
 	};
 	struct virtqueue *vqs[VIRTIO_SND_VQ_MAX] = { 0 };
 	unsigned int i;
 	unsigned int n;
 	int rc;
 
-	rc = virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
-			     NULL);
+	rc = virtio_find_vqs_info(vdev, VIRTIO_SND_VQ_MAX, vqs, vqs_info, NULL);
 	if (rc) {
 		dev_err(&vdev->dev, "failed to initialize virtqueues\n");
 		return rc;
-- 
2.45.2

