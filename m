Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FB252904
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094545; cv=none; b=HPDUL0Q4MRGWZQkXQygwlkeO4xjQJNbuhexb7pp2UA8BjtZOPEs44H2/xEBzUrIH+W40pAR6WFSXuDc/r5m8U3PLctcTakTQaoNj+RaRBTpZYkMLvk5KARf6YdgW5DNmdwYx7J5ruCqi74DVNIs2khHIGI6Jj1i98zlZBFbC0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094545; c=relaxed/simple;
	bh=tkgblbTFuQnMgah+b3qVfqQkZaZdA6aVb5an/8MM4jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qlYytPawIbfKnnavz1opR6eG8xjx5h3Z+1pgBtl+jzp6sRlVZY9SbdhY9qtNduUX1eagCUyVGQ8HZxWo3mgLBqpO9Q6NjbuDGiAaISlDei9cxJ3NLIMYcJYJ8iOG2iEcmNpim7kHW00utNp9cq3pNTYpcJrHOGxw8dXx+m1b18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IlWP0NXf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlWP0NXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MdKqwpmU7OaPUd1S1vImlbly2qp2E4LikNix66Cy2A=;
	b=IlWP0NXfH2F6oOUh4gq0wt5TXd8y8PBJ1j44b5xwQu04RC63UF+6RDFkB0ntHLDZoeRGdG
	iriYW831UZ9zqi+sNGtYjGpYuu31CUgKpwNq3vEaqQpg6ako2CROLj6t3T8u3rQ5cYzQIh
	b5fYvg9x+HDb4phJJtfKyjG/5+FY6nY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-3B5VktfLMxielM_DLh25SA-1; Wed, 09 Jul 2025 16:55:40 -0400
X-MC-Unique: 3B5VktfLMxielM_DLh25SA-1
X-Mimecast-MFC-AGG-ID: 3B5VktfLMxielM_DLh25SA_1752094539
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4532ff43376so2418485e9.3
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 13:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094539; x=1752699339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MdKqwpmU7OaPUd1S1vImlbly2qp2E4LikNix66Cy2A=;
        b=n8QTxa5Nj2PXm5r80RfLNXTTF+TNBV+6iFnPRqGksJ1+j9Jv5X1Eb72fZ4vJ0ahPoH
         OMa7AnvMzZToFzHj3e3uNm1TRf3pqjPNT3x3rVcCqamQHJj1iKmGcmwOseEdBF+j3XsX
         CxzzyW0LgrR8b4YsUXOm+uMn97UlMTGvj8SybqSP8skDEO8IhzUouERGEhgs5XjFWWkt
         CQvnI5FWrWTjCXrDawzJ/Gfs4outJdpjPiSjnyQ0oZ9LgFlvfX/VQFHLUHkAP8W/RdkO
         o/aaiBvlWQrKwPjW2pG65ZyeLzEOUJQ7m60KkEoJFbYdhACIWeOEgLHHfpRBwoCiQ/86
         i+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXTKh6f9HdVRXiLC7pxUfXaEAOKMNarrQTa/DQupdXHhqmxPjt4VAi1JHmxKwyHQtjyEaheA80uqwzJuPlt9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh/kd86zK9hR0nhd14ZDyT/xObHq7qXDVxWKqAzZSEleqGWwtq
	/FWCrU3bGsQTc+oHYDl6F5KpWb5EKzwnKZZRK9SazRzXNruxOdysY3OYU321wmH0ohBFldbHFbs
	OsGo4+QB7Sy2NxiW9CGV3gftj2KsajzXYzdPBpCUXSaFfj9lsUiaQwSLb2E6NkeZrYecc
X-Gm-Gg: ASbGnctLFCXkWhEv/mSo1bIyziJhknp/WYzTUBM+lw3bJLVjCvb+5OmsnOqgI3p/VjW
	9og6xXPTy4ww2V1BPkUXIPMS6vUqSjETauSGSv5FbDLLHfAZGzO/ktAi9Fvepmg3E897Jf32Fw3
	AgQ3oFhf7vySCMxWI3Q4fBRqkgXWyqY5gHyyCX/xPtY4P4x/KDXOWCcjafZ6v85Oqa+4GEZxwi3
	lVHkkWEzSN+3YWAS/S5jWUQLQTd2V4GoOqfICDJ0ix17vJdiGhbMKbIFb6XSiRNNW+QIncvVJF0
	Ux9br+VchIWHLgg=
X-Received: by 2002:a5d:6f12:0:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b5e866b02bmr183398f8f.9.1752094538621;
        Wed, 09 Jul 2025 13:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ4OTW3qeDU0VFbFiSP2ZORT0sgD3mqD8ErTstfRPkAX+VrNK2OCpVJElnxX5MKjetOlmwww==
X-Received: by 2002:a5d:6f12:0:b0:3a5:541c:b40f with SMTP id ffacd0b85a97d-3b5e866b02bmr183376f8f.9.1752094538214;
        Wed, 09 Jul 2025 13:55:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50328b9sm39543455e9.4.2025.07.09.13.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:37 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v5 5/5] virtio: support device disconnect
Message-ID: <8fc65f847b898c0e179e42f24defadc79590e7cf.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jGbFfzBvhBB-sAbeJRUUUG7eCMgWlcFHPmZo58cMZJo_1752094539
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

