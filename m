Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5E17838C
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010388; cv=none; b=sxaA867Lst/pP7OntgtiCcVof7KPGNfw8iqvTTg+WbRxA+5AkF0wqvRqa49T4sc/9SXfT2b/wtWK6VQL2S7lIApTRXhy9radV85fCoeoAgwhJZRfMHzUVNzHfwNsUEbc9DVkLnUOCILOlaYEMgqb7hGedBKeU2V38FOLv3DB7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010388; c=relaxed/simple;
	bh=NCaB7aB1wXOrQZJdOjfZN9O1H/3T0nzEs9PKw9NT9iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxjhukErOAiAiAThQDyUCvCS3a7U3fMXecoW0HxyJIM1A7jEJ2q2HeRDIrZ5CMKJk4nXTHm4PJzWN/4DuWh8JbfzKyADMlXHBTQx2afbkwVaQMFPCo2HAbM509f71fxjDa/+z8dYwvU8RrFJFFKbN9x2dQDmBkN3TtHivMouY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1ca1pgXc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1ca1pgXc"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36743a79dceso397591f8f.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010385; x=1720615185; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPc87CRLBVw0ZHh93QVJho4m97GrCBI5zQS5tWmS+fY=;
        b=1ca1pgXcvQW7otqcni1I+lTzjs+QQndc82cuq4OF1DxWIxgb1x/K2vkJaAxIfbN5Xt
         K+zeB0cj+mXmBcCI9Nuqv36zYzn8WObW4WdOm45H5+FWHaWOpyOl6PKzQfcgW4kg7LDW
         cgm/+QYuwGGMnlovA0J98O1kP1FZ98ahidPyd3cAJEVnwspuxuHOFTQ5t0IFXtufKY+b
         DRqV+4Lx4rND+NqMhL8+76L5YaTuOyQtX8yOihGxqLslE1PFTVPgvYL7vLeyG8/xxrCT
         yaCRrEBEoDlEcJMOB362mGpJTYOtlWm60w16wkF+DR49rhCyDdIvY2yWZlcS9dc3f+DF
         XKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010385; x=1720615185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPc87CRLBVw0ZHh93QVJho4m97GrCBI5zQS5tWmS+fY=;
        b=KPjNkFXIW9R35DmzVcRwaUftYtKw/ldsaA/mSUUU3+wyAmDpETPqP8bl3iEmIYJf6O
         FChGNbSjtxy1PfZGv/A3nz0O12yGXgp2olXKoo8HPJH3u9eYQ4GwTWk/YrD9AibiA/rH
         ecQl+BiNsJxn7Eu5VJTGygeUifH06Q0sPlbDlx0mUxhvJ+umLPaQZFClrag12iv7+t4t
         Peunj+fchwANjIvkQYQHaDnmFp6fBqvwEjehFchlhNtQ4BBZCAdpNt4pEI89vcI70ynp
         ZPF+xoo7awpLttVwEWevdd36RQmZuSbhovzoEQ2tslK12YI76qBVdC0y4huyuof/VkGS
         K3bw==
X-Gm-Message-State: AOJu0YxZpP7tso8HgVnpzFFEEbT065ILErdy9nGVartewvIc4EDuHUFg
	yyQQ4qB7ynAe1kmOn1g+Q8bRmqcooG6q0AfoEchHwCtGj0hQ9BZzLtGo7aS87rHCS1psjL4IuKv
	Y
X-Google-Smtp-Source: AGHT+IH8ki/1+JX3gtZhhCPskGbJPygzUjbfjO083sBstWrIKDe5vLA3cfQXNb7MDi8iUMAx4xB8gg==
X-Received: by 2002:a5d:4111:0:b0:366:e9f7:4e73 with SMTP id ffacd0b85a97d-36794780ae9mr1354300f8f.5.1720010384752;
        Wed, 03 Jul 2024 05:39:44 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36795e3fe31sm1115756f8f.21.2024.07.03.05.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:44 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 09/19] virtio: rename find_vqs_info() op to find_vqs()
Date: Wed,  3 Jul 2024 14:39:03 +0200
Message-ID: <20240703123913.969202-10-jiri@resnulli.us>
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

Since the original find_vqs() is no longer present, rename
find_vqs_info() back to find_vqs().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
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
index a87f0bcd36b5..99cded70ecfb 100644
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
index 825116bd2db9..d8f7773875f9 100644
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
index 85a678e99bfb..dde5fb173e54 100644
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
index f92303f92c0c..9d111b5992e5 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1076,7 +1076,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.get_status = virtio_ccw_get_status,
 	.set_status = virtio_ccw_set_status,
 	.reset = virtio_ccw_reset,
-	.find_vqs_info = virtio_ccw_find_vqs,
+	.find_vqs = virtio_ccw_find_vqs,
 	.del_vqs = virtio_ccw_del_vqs,
 	.bus_name = virtio_ccw_bus_name,
 	.synchronize_cbs = virtio_ccw_synchronize_cbs,
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1aa7988b5f31..c1951fff8212 100644
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
index 20933b9f2568..787bc534b05c 100644
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
index 39db3b8ac85b..f90ecf587ce2 100644
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
index 48edb88a998d..24bbb1805b80 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -59,7 +59,7 @@ struct virtio_queue_info {
  *	After this, status and feature negotiation must be done again
  *	Device must not be reset from its vq/config callbacks, or in
  *	parallel with being added/removed.
- * @find_vqs_info: find virtqueues and instantiate them.
+ * @find_vqs: find virtqueues and instantiate them.
  *	vdev: the virtio_device
  *	nvqs: the number of virtqueues to find
  *	vqs: on success, includes new virtqueues
@@ -112,10 +112,10 @@ struct virtio_config_ops {
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
-	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
-			     struct virtqueue *vqs[],
-			     struct virtio_queue_info vqs_info[],
-			     struct irq_affinity *desc);
+	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
+			struct virtqueue *vqs[],
+			struct virtio_queue_info vqs_info[],
+			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
@@ -223,7 +223,7 @@ int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
 			 struct virtio_queue_info vqs_info[],
 			 struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, vqs_info, desc);
 }
 
 static inline
-- 
2.45.2

