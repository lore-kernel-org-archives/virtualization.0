Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6571A0B0E
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075456; cv=none; b=n0N3Ro0bJzJ2LBwMIzL7y6+d3ozHLXgnoF9NFdDX2KkOaMte3Q1ClnOkLCjoP08xckfRuqENXEVLTmYmxyfUuD2I0FP6MLhZF/BNUgQtAeoTL9hFMJw1sI4ht2mwmzZOgHgu0s8q+ur06FgoOSWomuRga+qlsxaEqJShAQoHSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075456; c=relaxed/simple;
	bh=wBcO2MuAQt3m6IfSxB4Eb7UDPkWHhRXAMX4L7X9044M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeA1ZQak+sc3Wej3H9BBlpcdGCB75eNaDKqNHgWRXiezHwnoG7mrmC7pE89y2nTWwmcBNkZEQNjFL6wsXnK1LqjPQQe5OLKVbQKpuu3kWmUktKbK2CWye2CB84Ngldpqj+0HKmhjqhNC/fRgTzFtja6kk8BIDeCzOuzgaWa89D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mGVyvwsb; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mGVyvwsb"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so3365861fa.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075453; x=1720680253; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PZqQXEx6O8nf0TC4HCdrLvFouZlsUiEOkY3N4VoOhQ=;
        b=mGVyvwsbKPrBdBpqC0JpkDqmkXfPy+uHOJ7XoOVygKPNQQ5VFCaHoLU7RE+YN/V6ia
         nDvzLSYPqbb6xRNOj6R7DrEzwNn08/2xmPNulFabKNIavTI9FoLabuOeBplJL6jUIxNT
         JR2jn7r7BqWKfzpm8e2T5plN8bqeW1pYFx6++8jJA728CffMzt7ThLIz8rSqY55c8VHs
         oaRnM7zPw9Y+UicIoWv23r8WGaOa6BhRQeTOytQ/8xA8uk+EQID4psR9JfyUnJW9+Tbs
         whdIxOn8cAIXCgh3yGL0ctPZXTIz6NtN81iCLS1Wlt7zBBt8hmm0evCcNKeSUKorms+q
         7wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075453; x=1720680253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PZqQXEx6O8nf0TC4HCdrLvFouZlsUiEOkY3N4VoOhQ=;
        b=RiOeSVQYMPAwQKjN521tLaP9GA/2NNl7Ho0lYcHSGlFmXRfzUDy2j4w4fWdNrWF0we
         LWSlOSkLEUGvz779mkFU4Klp/Pw4+dHtGoLjgz8qLxzaiqWhoxruccm682rmt2HqL0KQ
         doP7qN1tt4wvwZQLOCR2QB0ZarFiFpdruxsjAfcGRBXX4Zlp1SgVVBKUJ6uhsuUSxYPg
         9laYdgUGI7Kv1SyAZ4MEreb1ac+cNwgKLFHletAcJHnTiUJ+gxp2sKKENIt7uC0iAUSQ
         MFQxO+F84TiGgkpYzxtu0SO+zNDeIEiT3MZdZkndAZOSTB3YTJqzvu/Kmf1fDktxV7EE
         FYjQ==
X-Gm-Message-State: AOJu0YwKAi3aJ7vqULFyqBGm5Ao+l0Cr2T0bTbeHAvQXmMx/oaN6GAtl
	Z7kuXzn/bSeUURyckRe1QPlV63LStKtJNgfwcdbse9zD2Tld+TvbXbrgthIKxnls6DbvQ2rR2Pz
	m
X-Google-Smtp-Source: AGHT+IF8w0tjo89ybs89oUMCSS/acBF6TlbXcQtGeZmCopEPFInBzgxrtvdq5oVShXhDnSJKEhD7QQ==
X-Received: by 2002:a2e:a58a:0:b0:2ee:7d37:498b with SMTP id 38308e7fff4ca-2ee8ed8cf11mr5303911fa.14.1720075452635;
        Wed, 03 Jul 2024 23:44:12 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21cbc6sm11034415e9.24.2024.07.03.23.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:12 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 09/19] virtio: rename find_vqs_info() op to find_vqs()
Date: Thu,  4 Jul 2024 08:43:40 +0200
Message-ID: <20240704064350.1097716-10-jiri@resnulli.us>
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
index c32a51017f9f..35cc31928bb0 100644
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
index 1497a5a0a68f..05a68b36ff50 100644
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
index a82a7c13bdc5..346888ca1732 100644
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
index 1f1fa70cf09d..ec0ecdce4808 100644
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
index 533aca85b745..54abd3722296 100644
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
index dcf0c2b19a44..138bcc56d156 100644
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
index ad6ac5cf4bd7..d325af057d1a 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -59,7 +59,7 @@ struct virtqueue_info {
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
-			     struct virtqueue_info vqs_info[],
-			     struct irq_affinity *desc);
+	int (*find_vqs)(struct virtio_device *vdev, unsigned int nvqs,
+			struct virtqueue *vqs[],
+			struct virtqueue_info vqs_info[],
+			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
@@ -223,7 +223,7 @@ int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
 			 struct virtqueue_info vqs_info[],
 			 struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, vqs_info, desc);
 }
 
 static inline
-- 
2.45.2

