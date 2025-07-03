Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D52D94AC
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534807; cv=none; b=p04gK6Jh4Wy8P8XmDUlzL47qEBiXihm2I+d8NnC1I63kSaAEm4j43oVEJBdtTISGZUpsBYNg61coE8vXJDdnSMRS6FbqB2zxR8EqZP4zNh+fgBOHaer78bMzX92PAIk60ntHGngBzzLJG7YRs7Wr9h28esNAfosag0N2wAO7fLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534807; c=relaxed/simple;
	bh=tkgblbTFuQnMgah+b3qVfqQkZaZdA6aVb5an/8MM4jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AO78HS1pF9B8BMMrxPQSWZTJC07HFLmhtXsskLidW+37P4X2mqRnBZjsaD20npg13YZ3VYbfGelJzO8pH5UhpPruPntmeTgqnaYv4E5xBycSDZ+KsexzvFwC/MWqPfOO1pRT3ejofgcmG7YbzrPqyiVBKr2Yd3Tr+zmyxgoCVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wlykz36O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wlykz36O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MdKqwpmU7OaPUd1S1vImlbly2qp2E4LikNix66Cy2A=;
	b=Wlykz36ODJArCMH48cISMSNhhrkxJ0BFdF1mAIcK7OyXaaimvodGLLIrwfus2Oh3ETg8+S
	gWePi11bjoFk+Lp4W6D2GfjxoKv/FuNJHVi4Hkt0tfsuTnBdkoJg0ECOjD0Y+t627KHrRI
	kaOoqsa+AML8x4YrL00e2RJ5P1zedUc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-EKkL77dvNkqv5eaD7rOgUA-1; Thu, 03 Jul 2025 05:26:42 -0400
X-MC-Unique: EKkL77dvNkqv5eaD7rOgUA-1
X-Mimecast-MFC-AGG-ID: EKkL77dvNkqv5eaD7rOgUA_1751534801
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so3547599f8f.3
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 02:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534801; x=1752139601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MdKqwpmU7OaPUd1S1vImlbly2qp2E4LikNix66Cy2A=;
        b=skX9LpMVD+Bk9eIYGX5ZY/kAwQYHqWLWmJH+ARnv8CVlvl3/59/GKoJcdiZAglSch1
         94sVt6zscumlnzuOMYHvvYLUUka1vXvZ3MK/RXwyJ+/DupShIciFkblvNDh8uvrs60FJ
         FSVWWC7e1UTfCHZ/HHiEU/Imhfr30km/hqiVfrQ6HxkYYawDCKSimJhGbswAdIwnvnHd
         mwxpWeSS08PzUjKHtaJiQiqcaaPlHPB5lKU0CJws1eC+T7tKOp6ROzJjjmt8DuAJarf6
         PdBg2U8rzcd7N6WULZPW3b85YnRn0PInYXf9WLBikdUe3DvkFhwGBac+JiV+Ie1DM1rC
         11kA==
X-Forwarded-Encrypted: i=1; AJvYcCVy2/1K/nyh7Rs6aGFUrEuiIl0hjlqG2MpXvVy6sJbrJLuTPueDXmKjbgGwbW20EFMn3MyEhyXTRxVXf8MEKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqcDCVdT9bhiZZ1V2adJiZMm9MwEQg+ZOULN4mHzbntjebVuH9
	pbsjWvQDbJprj7wVqWbWBcgegQTGM2fKkOk88UUf2hJT5tD8S1R+coGpUCEd1FkzNyOFAwWIfb8
	W8yC79jzmdfNOXcrfNJL1m5NCe5CXP6zZEtxPFxxxmJtATiN+u5VhQsbKGxJSoahQghox
X-Gm-Gg: ASbGncuqoZuyCmeFTrdx2pzRqkdACvXR1vVIDmk2y1WOMg7R8WD8jJLaZhmlvTtzcpw
	NT4IKVMHdC6NgUa6c+vkbsDydP0qz958mV5jRF/QwrqOTXmcIUFPSuhoeIG+OQUGj5Ee1v4vPA+
	rFkEWHbAPSSdzu3RmLfExwELgT0wZtwuRpi/eKwChvhpKh1bxEW/dkfWiXIbgdQT1bgWExdRS3c
	+MCwOeBprvUVUlVt3y6qJBVFcIfkOS1taiYCjMT4NzI2Dq5CzXrlT92vMleWWWrnwx6gEBIl6Uk
	bzSwWwcBAFZbLfk+
X-Received: by 2002:a05:6000:2c01:b0:3b3:a6e1:135c with SMTP id ffacd0b85a97d-3b3a6e113afmr893717f8f.42.1751534800637;
        Thu, 03 Jul 2025 02:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkQtx6dTZNMo9PhkqNuSJxJCajqjzjsNPok7wcdjiw76P3Vf7cyfZYrozQCIx+rHWOI+RfQg==
X-Received: by 2002:a05:6000:2c01:b0:3b3:a6e1:135c with SMTP id ffacd0b85a97d-3b3a6e113afmr893677f8f.42.1751534800113;
        Thu, 03 Jul 2025 02:26:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab6esm18489438f8f.31.2025.07.03.02.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 02:26:39 -0700 (PDT)
Date: Thu, 3 Jul 2025 05:26:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v4 5/5] virtio: support device disconnect
Message-ID: <1854be16aefc3c0f033472099c909c442d3bc555.1751534711.git.mst@redhat.com>
References: <cover.1751534711.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1751534711.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gbRFx0Hq1gdbTyBqq7Gz1rS6ZZqIUomdUIoZzNmk1e4_1751534801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This adds support for device disconnect:
upon device surprise removal, virtio core makes sure
to no callbacks are running, and then notifies the driver.

At the moment, virtio pci is the only transport with this
functionality enabled, it does nothing for other transports.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 45 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.h |  3 ++
 drivers/virtio/virtio_pci_legacy.c |  2 ++
 drivers/virtio/virtio_pci_modern.c |  2 ++
 include/linux/virtio.h             |  3 ++
 include/linux/virtio_config.h      | 32 +++++++++++++++++++++
 6 files changed, 87 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d6d79af44569..a475f47052eb 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -594,6 +594,51 @@ const struct cpumask *vp_get_vq_affinity(struct virtio_device *vdev, int index)
 				    vp_dev->vqs[index]->msix_vector);
 }
 
+/* Report disconnect to the driver. */
+static void virtio_pci_disconnect_work(struct work_struct *work)
+{
+	struct pci_dev *pci_dev = container_of(work, struct pci_dev,
+					       disconnect_work);
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct virtio_device *vdev = &vp_dev->vdev;
+	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
+
+	if (!pci_test_and_clear_disconnect_enable(pci_dev))
+		return;
+
+        virtio_config_transport_disable(vdev);
+	virtio_break_device(vdev);
+
+	vp_synchronize_vectors(vdev);
+
+	drv->disconnect(&vp_dev->vdev);
+}
+
+void virtio_pci_enable_disconnect(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
+
+	if (!drv->disconnect)
+		return;
+
+	INIT_WORK(&pci_dev->disconnect_work, virtio_pci_disconnect_work);
+	pci_set_disconnect_work(pci_dev);
+}
+
+void virtio_pci_disable_disconnect(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
+
+	if (!drv->disconnect)
+		return;
+
+	pci_clear_disconnect_work(pci_dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int virtio_pci_freeze(struct device *dev)
 {
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..982c4c8aabc8 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -161,6 +161,9 @@ static inline void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
 int virtio_pci_modern_probe(struct virtio_pci_device *);
 void virtio_pci_modern_remove(struct virtio_pci_device *);
 
+void virtio_pci_enable_disconnect(struct virtio_device *);
+void virtio_pci_disable_disconnect(struct virtio_device *);
+
 struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
 
 #define VIRTIO_LEGACY_ADMIN_CMD_BITMAP \
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d9cbb02b35a1..cd424f619b47 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -191,6 +191,8 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.set		= vp_set,
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
+	.enable_disconnect = virtio_pci_enable_disconnect,
+	.disable_disconnect = virtio_pci_disable_disconnect,
 	.reset		= vp_reset,
 	.find_vqs	= vp_find_vqs,
 	.del_vqs	= vp_del_vqs,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7182f43ed055..b3dfb403913f 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1230,6 +1230,8 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.generation	= vp_generation,
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
+	.enable_disconnect = virtio_pci_enable_disconnect,
+	.disable_disconnect = virtio_pci_disable_disconnect,
 	.reset		= vp_reset,
 	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 072a25f6622c..a091651e3144 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -214,6 +214,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  * @scan: optional function to call after successful probe; intended
  *    for virtio-scsi to invoke a scan.
  * @remove: the function to call when a device is removed.
+ * @disconnect: the function to call on disconnect (surprise removal),
+ *    before remove.
  * @config_changed: optional function to call when the device configuration
  *    changes; may be called in interrupt context.
  * @freeze: optional function to call during suspend/hibernation.
@@ -235,6 +237,7 @@ struct virtio_driver {
 	int (*validate)(struct virtio_device *dev);
 	int (*probe)(struct virtio_device *dev);
 	void (*scan)(struct virtio_device *dev);
+	void (*disconnect)(struct virtio_device *dev);
 	void (*remove)(struct virtio_device *dev);
 	void (*config_changed)(struct virtio_device *dev);
 	int (*freeze)(struct virtio_device *dev);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b3e1d30c765b..861198a74be2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -58,6 +58,10 @@ struct virtqueue_info {
  * @set_status: write the status byte
  *	vdev: the virtio_device
  *	status: the new status byte
+ * @enable_disconnect: driver will get disconnect callbacks
+ *	vdev: the virtio_device
+ * @disable_disconnect: driver will not get disconnect callbacks
+ *	vdev: the virtio_device
  * @reset: reset the device
  *	vdev: the virtio device
  *	After this, status and feature negotiation must be done again
@@ -113,6 +117,8 @@ struct virtio_config_ops {
 	u32 (*generation)(struct virtio_device *vdev);
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
+	void (*enable_disconnect)(struct virtio_device *vdev);
+	void (*disable_disconnect)(struct virtio_device *vdev);
 	void (*reset)(struct virtio_device *vdev);
 	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
 			struct virtqueue *vqs[],
@@ -299,6 +305,32 @@ void virtio_device_ready(struct virtio_device *dev)
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
+/**
+ * virtio_device_enable_disconnect - enable disconnect callback
+ * @dev: the virtio device
+ *
+ * Driver must call this in the probe function.
+ */
+static inline
+void virtio_device_enable_disconnect(struct virtio_device *dev)
+{
+	if (dev->config->enable_disconnect)
+		dev->config->enable_disconnect(dev);
+}
+
+/**
+ * virtio_device_disable_disconnect - enable disconnect callback
+ * @dev: the virtio device
+ *
+ * Driver must call this in the remove function.
+ */
+static inline
+void virtio_device_disable_disconnect(struct virtio_device *dev)
+{
+	if (dev->config->disable_disconnect)
+		dev->config->disable_disconnect(dev);
+}
+
 static inline
 const char *virtio_bus_name(struct virtio_device *vdev)
 {
-- 
MST

