Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF036B11
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424916; cv=none; b=semfyz75QBEvSPbDJsp0gr5YHqnPsK/XWbPzXXN75zTwpyIPW9yprLt8ytQ7Y94om+Da9OqWyTLxDMemETR1IqG5jpNW2fWeFoAjOSroAzNyxQZTVOZLlZ9UzrZbKmLWnXAmBNGWf6W3bqCuKnHZyeN9LRZHWLbhbnvLnVvZNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424916; c=relaxed/simple;
	bh=uuKSUKF6YK5KBwgpdgYI62HS3/as2P45CkLzlC9R7y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJSYCaUQEwuEu5uxvPqu8N/GcNOiCcsrcbw8SkUF8hdYA2k4vbzO0IDGmQZ5+vGI5dif4MeYGCno1btlpEGR95BqRkmqgLEoSbaBkPlePnX/dvnsG+RhFRD8IA+ZH+OTTfHplmKSDy2zFXxzf88um7pFQ+EOM2WhVtbxch1BWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O0EzCVfb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O0EzCVfb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266381bdf1so9797205e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424912; x=1721029712; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc4AIrJ45Fwqh09MNAPZO6vAv+NO5NA/fgHRrgAXyRw=;
        b=O0EzCVfbSefXS3550sIkNLf7oBr1PvdWfJVmkY84uQ5QEu6FxfLkRUBG3lmNxTCGbn
         +3KZiW/UEqlLPzSz/VipIKz1omHsErifNBURyjBMSPokFXjbPIR/Mm9KqPptoY7F5jV9
         dRLIiby/PkBjvi6vB3Bb1d55X2fK+Us3qdc1Wfr54c/uMZzNQ1WPdmwzH1YLjd7ALXPf
         wmAM4K5vIAoxAnFyBLM71kTqoe/kw8yI38uogLzjlnxcJa+5gRWAbq8+NZ0zSvy/oCz1
         L1ctNf1uxl+RAjND3vVowdz7cgWumT4yfGnGcPZM/2McE3qoZcyIWo0DE2yA+k5sdgC7
         UhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424912; x=1721029712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cc4AIrJ45Fwqh09MNAPZO6vAv+NO5NA/fgHRrgAXyRw=;
        b=rCAB2zHTnXr8NpiUv12FEs/a1a7I1m2qj5xolvRBLRXiID2kp4lYY/ayw3BWw7HWYm
         kL6yJYirwLoj1luT1ttte3j72VlD4ptutQJkUmUJKxZQNK5sg9D2WuNj4HTFlhQZpDAo
         0zPIgAn+JnPrYhXbh74mxVSI2OqniyYpjSVX1gVco5vJiAh8zDcuIn+Vuqc7CfrkLS3V
         KTR5AhbA3AXufX3rfWnBbJCd9sxUxEx1Drt7m+3Ju4zfRAFIIaIUCiid2Cr6hGbjDBLR
         xKFEgrk6KNNyjh5R6ZlIquKKkr9+yBsI4dCErFuc73Uu5NsFyTLHGaaiBov0LQM+Np5s
         SJGg==
X-Gm-Message-State: AOJu0Yw2BoOtItcxXmklRm6xwV+CYOniytMaG+ssfTiqun3MlMiSkS9M
	fthw/te/EadjaaxqJnsjpfD5YpZi3cUfgByrgZzJl8Crmeuxl4a4n+tRy8b9jXar9QQAeirkRb9
	3FY0=
X-Google-Smtp-Source: AGHT+IHO9i0vfyE4oOc9GkgnQQYks1UrYC1YhLbf49/kXXRqoMtidPntth0DL+9SUls4TKvpNrHxYw==
X-Received: by 2002:a05:600c:33a2:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-4265b442f08mr68123085e9.10.1720424912413;
        Mon, 08 Jul 2024 00:48:32 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f18c7sm154662895e9.23.2024.07.08.00.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:31 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 09/19] virtio: rename find_vqs_info() op to find_vqs()
Date: Mon,  8 Jul 2024 09:48:04 +0200
Message-ID: <20240708074814.1739223-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708074814.1739223-1-jiri@resnulli.us>
References: <20240708074814.1739223-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since the original find_vqs() is no longer present, rename
find_vqs_info() back to find_vqs().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 arch/um/drivers/virtio_uml.c             |  2 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c |  2 +-
 drivers/remoteproc/remoteproc_virtio.c   |  2 +-
 drivers/s390/virtio/virtio_ccw.c         |  2 +-
 drivers/virtio/virtio_mmio.c             |  2 +-
 drivers/virtio/virtio_pci_legacy.c       |  2 +-
 drivers/virtio/virtio_pci_modern.c       |  4 ++--
 drivers/virtio/virtio_vdpa.c             |  2 +-
 include/linux/virtio_config.h            | 12 ++++++------
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 4cc393e903fc..2b6e701776b6 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1099,7 +1099,7 @@ static const struct virtio_config_ops virtio_uml_config_ops = {
 	.get_status = vu_get_status,
 	.set_status = vu_set_status,
 	.reset = vu_reset,
-	.find_vqs_info = vu_find_vqs,
+	.find_vqs = vu_find_vqs,
 	.del_vqs = vu_del_vqs,
 	.get_features = vu_get_features,
 	.finalize_features = vu_finalize_features,
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 3dc895cfdc4a..6c834e39352d 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1175,7 +1175,7 @@ static void tmfifo_virtio_dev_release(struct device *device)
 static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
 	.get_features = mlxbf_tmfifo_virtio_get_features,
 	.finalize_features = mlxbf_tmfifo_virtio_finalize_features,
-	.find_vqs_info = mlxbf_tmfifo_virtio_find_vqs,
+	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
 	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
 	.reset = mlxbf_tmfifo_virtio_reset,
 	.set_status = mlxbf_tmfifo_virtio_set_status,
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 870764c0ad9f..d3f39009b28e 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -327,7 +327,7 @@ static void rproc_virtio_set(struct virtio_device *vdev, unsigned int offset,
 static const struct virtio_config_ops rproc_virtio_config_ops = {
 	.get_features	= rproc_virtio_get_features,
 	.finalize_features = rproc_virtio_finalize_features,
-	.find_vqs_info	= rproc_virtio_find_vqs,
+	.find_vqs	= rproc_virtio_find_vqs,
 	.del_vqs	= rproc_virtio_del_vqs,
 	.reset		= rproc_virtio_reset,
 	.set_status	= rproc_virtio_set_status,
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index fa884afff777..62eca9419ad7 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1078,7 +1078,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.get_status = virtio_ccw_get_status,
 	.set_status = virtio_ccw_set_status,
 	.reset = virtio_ccw_reset,
-	.find_vqs_info = virtio_ccw_find_vqs,
+	.find_vqs = virtio_ccw_find_vqs,
 	.del_vqs = virtio_ccw_del_vqs,
 	.bus_name = virtio_ccw_bus_name,
 	.synchronize_cbs = virtio_ccw_synchronize_cbs,
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 57903685d505..90e784e7b721 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -570,7 +570,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.get_status	= vm_get_status,
 	.set_status	= vm_set_status,
 	.reset		= vm_reset,
-	.find_vqs_info	= vm_find_vqs,
+	.find_vqs	= vm_find_vqs,
 	.del_vqs	= vm_del_vqs,
 	.get_features	= vm_get_features,
 	.finalize_features = vm_finalize_features,
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index a9786e38d763..d9cbb02b35a1 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -192,7 +192,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
-	.find_vqs_info	= vp_find_vqs,
+	.find_vqs	= vp_find_vqs,
 	.del_vqs	= vp_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index adba4a29fdf4..3b5b9499a53a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -781,7 +781,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
-	.find_vqs_info	= vp_modern_find_vqs,
+	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
@@ -803,7 +803,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
-	.find_vqs_info	= vp_modern_find_vqs,
+	.find_vqs	= vp_modern_find_vqs,
 	.del_vqs	= vp_del_vqs,
 	.synchronize_cbs = vp_synchronize_vectors,
 	.get_features	= vp_get_features,
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index bc86d81c7cd2..7364bd53e38d 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -469,7 +469,7 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.get_status	= virtio_vdpa_get_status,
 	.set_status	= virtio_vdpa_set_status,
 	.reset		= virtio_vdpa_reset,
-	.find_vqs_info	= virtio_vdpa_find_vqs,
+	.find_vqs	= virtio_vdpa_find_vqs,
 	.del_vqs	= virtio_vdpa_del_vqs,
 	.get_features	= virtio_vdpa_get_features,
 	.finalize_features = virtio_vdpa_finalize_features,
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 1ae346bd2dbd..7848fba7f48a 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -63,7 +63,7 @@ struct virtqueue_info {
  *	After this, status and feature negotiation must be done again
  *	Device must not be reset from its vq/config callbacks, or in
  *	parallel with being added/removed.
- * @find_vqs_info: find virtqueues and instantiate them.
+ * @find_vqs: find virtqueues and instantiate them.
  *	vdev: the virtio_device
  *	nvqs: the number of virtqueues to find
  *	vqs: on success, includes new virtqueues
@@ -116,10 +116,10 @@ struct virtio_config_ops {
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
-	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
-			     struct virtqueue *vqs[],
-			     struct virtqueue_info vqs_info[],
-			     struct irq_affinity *desc);
+	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
+			struct virtqueue *vqs[],
+			struct virtqueue_info vqs_info[],
+			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
@@ -227,7 +227,7 @@ int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
 			 struct virtqueue_info vqs_info[],
 			 struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, vqs_info, desc);
 }
 
 static inline
-- 
2.45.2

