Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6C1922C9
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383727; cv=none; b=QJpJ/pVAfgpL+yY2LzyvIcTWT/NkeDU8BGTizdoDCdDnTYC6NB8WR9DcFFgET8jR2U89a+7vm/z4TGOLTp/p3CGmz4wBGkmU/M4KWk8y2VEQnvmY/b/fU3xWJBOruPurPIiosaSNxYJnv8w+pXgQZfaujoJUpWA/W17ALiNK+A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383727; c=relaxed/simple;
	bh=aERogzXtJQn2Or0/3DmemlSZGKmoyU6sPMwDbN3yxas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+3LDON6PvB8EHEjK6XE0KkQUsjUS1wZogDRvVLIs1xC9alqrlgvffwkVYLqtLvwfqEK4fnc+2CZXFVHxbvAVchAf3CIhXz5yC3ggP9tPpZ8JAwLAF+gov47vep5iPQbKGBngdJHQa8Rzqj8oUbZmYMDt9mWNDOFWUHYL1aTQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y27PqMmH; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y27PqMmH"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5dca9cc71b2so3398126eaf.2
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725383721; x=1725988521; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuvsYRptGrqy3J1GxjNuAynZOsyxO34wvYOEmPK25yo=;
        b=Y27PqMmH6jeL/NbaFz7+sOBJGIDdrSk+rnrqBtWEv0v7YtFiC9GZ/KrctfPG6QffEm
         PkS2PE3QNksFDXdx+xHTgYPd5+ilQlYB/iAyVP6LpDXiC7qPDnK/8X8Eg61ybEI4bpXQ
         vahkSUgi+QylF+drbe3s9/S6vZeUnE7+5RKbaZkMIQ5S6kHLplHGGKmAfkR2BX1LMU+r
         PLsIz+cp9mvjIMzekJ8cRG2So4hf7A3SiGDXFazffmoQyev6JPtHGXPxH3TU4+XVb7lM
         jkjpo986p5tMY/02k/+bwpFD3x1JrFB6bUAKvyd079MuE5rl99FtA5U9VfU9pgU7whGQ
         muRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725383721; x=1725988521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuvsYRptGrqy3J1GxjNuAynZOsyxO34wvYOEmPK25yo=;
        b=IuFNoXFxesc7rXyw2UQM8wxOOw2ORwyphuQ1C23kkIVnO20nGGmP1UXr++tzUDPBjT
         T0VAjO3KoQ0u6XAS3NaKGSVfUFhr9+QerwIwAvBssE3osP8xNWsx6poRN4nhHbsAmMQQ
         jYMSOoXU5uerMzlPjh7MZa0MwXAAcHprVpHCmE/s2ByEiZTDD7sUOu8soRi3JC+LxgnL
         DpHy7EbLyDlGKxs9H4VJWSdKep8BlQoDBT8mjVrID06TpNrtKaFMj+1BNc6ME10L0phQ
         hbv9o9JUuN1pBdu/dKtKgM52DOb6XljW4nOOfW48SasdIo9C4AttiMCfuqBINSaeyqGv
         nHCw==
X-Forwarded-Encrypted: i=1; AJvYcCWc4isHZ2X9InuWPluHNM15pITiooXbZmIfoE5tdP2e6BiMkB0s0veYlsjgl9qEVrV8uRcscft502VSG2Hz5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx05HdhQ3Q67ON4QI+RRrsz85GkI0oR/e/Wk3QTJwV1pSWbPP+W
	pQZ7/uVp6mDj7990tUIWC7bN07sxxguaorS7xacKeyWdbAZGNsZ9
X-Google-Smtp-Source: AGHT+IEwNCR1vD+92U640kHqcZuZcA/MDBgrEh5snvTf6Q+p/aBPqfQmAwK5nA9dOhTZpmEBxngtcg==
X-Received: by 2002:a05:6808:10cd:b0:3d9:27f5:5251 with SMTP id 5614622812f47-3df05c3187cmr19737830b6e.5.1725383721545;
        Tue, 03 Sep 2024 10:15:21 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117a5f91sm2398059b6e.2.2024.09.03.10.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:15:21 -0700 (PDT)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	shannon.nelson@amd.com,
	sashal@kernel.org,
	alvaro.karsz@solid-run.com,
	christophe.jaillet@wanadoo.fr,
	steven.sistare@oracle.com
Cc: bilbao@vt.edu,
	xuanzhuo@linux.alibaba.com,
	johnah.palmer@oracle.com,
	eperezma@redhat.com,
	cratiu@nvidia.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
Date: Tue,  3 Sep 2024 12:15:14 -0500
Message-ID: <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
with vdpa_config_ops->set_config(). This is needed per virtio spec
requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the device
configuration fields are read-only for the driver."

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c    | 17 -----------------
 drivers/vdpa/ifcvf/ifcvf_main.c    | 10 ----------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  7 -------
 drivers/vdpa/pds/vdpa_dev.c        | 16 ----------------
 drivers/vdpa/solidrun/snet_main.c  | 18 ------------------
 drivers/vdpa/vdpa.c                | 16 ----------------
 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 16 ----------------
 drivers/vdpa/vdpa_sim/vdpa_sim.h   |  1 -
 drivers/vdpa/vdpa_user/vduse_dev.c |  7 -------
 drivers/vdpa/virtio_pci/vp_vdpa.c  | 14 --------------
 drivers/vhost/vdpa.c               | 26 --------------------------
 drivers/virtio/virtio_vdpa.c       |  9 ---------
 include/linux/vdpa.h               |  9 ---------
 include/uapi/linux/vhost.h         |  8 ++++----
 14 files changed, 4 insertions(+), 170 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index cce3d1837104..d8f70b385661 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -383,22 +383,6 @@ static void eni_vdpa_get_config(struct vdpa_device *vdpa,
 		*p++ = ioread8(ioaddr + i);
 }
 
-static void eni_vdpa_set_config(struct vdpa_device *vdpa,
-				unsigned int offset, const void *buf,
-				unsigned int len)
-{
-	struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
-	struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
-	void __iomem *ioaddr = ldev->ioaddr +
-		VIRTIO_PCI_CONFIG_OFF(eni_vdpa->vectors) +
-		offset;
-	const u8 *p = buf;
-	int i;
-
-	for (i = 0; i < len; i++)
-		iowrite8(*p++, ioaddr + i);
-}
-
 static void eni_vdpa_set_config_cb(struct vdpa_device *vdpa,
 				   struct vdpa_callback *cb)
 {
@@ -429,7 +413,6 @@ static const struct vdpa_config_ops eni_vdpa_ops = {
 	.get_vq_align	= eni_vdpa_get_vq_align,
 	.get_config_size = eni_vdpa_get_config_size,
 	.get_config	= eni_vdpa_get_config,
-	.set_config	= eni_vdpa_set_config,
 	.set_config_cb  = eni_vdpa_set_config_cb,
 	.get_vq_irq	= eni_vdpa_get_vq_irq,
 };
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index e98fa8100f3c..7cbac787ad5f 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -568,15 +568,6 @@ static void ifcvf_vdpa_get_config(struct vdpa_device *vdpa_dev,
 	ifcvf_read_dev_config(vf, offset, buf, len);
 }
 
-static void ifcvf_vdpa_set_config(struct vdpa_device *vdpa_dev,
-				  unsigned int offset, const void *buf,
-				  unsigned int len)
-{
-	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
-
-	ifcvf_write_dev_config(vf, offset, buf, len);
-}
-
 static void ifcvf_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
 				     struct vdpa_callback *cb)
 {
@@ -640,7 +631,6 @@ static const struct vdpa_config_ops ifc_vdpa_ops = {
 	.get_vq_group	= ifcvf_vdpa_get_vq_group,
 	.get_config_size	= ifcvf_vdpa_get_config_size,
 	.get_config	= ifcvf_vdpa_get_config,
-	.set_config	= ifcvf_vdpa_set_config,
 	.set_config_cb  = ifcvf_vdpa_set_config_cb,
 	.get_vq_notification = ifcvf_get_vq_notification,
 };
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 5fce6d62af4f..fd0db86ba2cf 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2918,12 +2918,6 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 		memcpy(buf, (u8 *)&ndev->config + offset, len);
 }
 
-static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
-				 unsigned int len)
-{
-	/* not supported */
-}
-
 static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
@@ -3218,7 +3212,6 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.reset = mlx5_vdpa_reset,
 	.get_config_size = mlx5_vdpa_get_config_size,
 	.get_config = mlx5_vdpa_get_config,
-	.set_config = mlx5_vdpa_set_config,
 	.get_generation = mlx5_vdpa_get_generation,
 	.set_map = mlx5_vdpa_set_map,
 	.set_group_asid = mlx5_set_group_asid,
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 25c0fe5ec3d5..553dcd2aa065 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -553,21 +553,6 @@ static void pds_vdpa_get_config(struct vdpa_device *vdpa_dev,
 	memcpy_fromio(buf, device + offset, len);
 }
 
-static void pds_vdpa_set_config(struct vdpa_device *vdpa_dev,
-				unsigned int offset, const void *buf,
-				unsigned int len)
-{
-	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
-	void __iomem *device;
-
-	if (offset + len > sizeof(struct virtio_net_config)) {
-		WARN(true, "%s: bad read, offset %d len %d\n", __func__, offset, len);
-		return;
-	}
-
-	device = pdsv->vdpa_aux->vd_mdev.device;
-	memcpy_toio(device + offset, buf, len);
-}
 
 static const struct vdpa_config_ops pds_vdpa_ops = {
 	.set_vq_address		= pds_vdpa_set_vq_address,
@@ -595,7 +580,6 @@ static const struct vdpa_config_ops pds_vdpa_ops = {
 	.reset			= pds_vdpa_reset,
 	.get_config_size	= pds_vdpa_get_config_size,
 	.get_config		= pds_vdpa_get_config,
-	.set_config		= pds_vdpa_set_config,
 };
 static struct virtio_device_id pds_vdpa_id_table[] = {
 	{VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID},
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..141740269b6c 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -478,23 +478,6 @@ static void snet_get_config(struct vdpa_device *vdev, unsigned int offset,
 		*buf_ptr++ = ioread8(cfg_ptr + i);
 }
 
-static void snet_set_config(struct vdpa_device *vdev, unsigned int offset,
-			    const void *buf, unsigned int len)
-{
-	struct snet *snet = vdpa_to_snet(vdev);
-	void __iomem *cfg_ptr = snet->cfg->virtio_cfg + offset;
-	const u8 *buf_ptr = buf;
-	u32 i;
-
-	/* check for offset error */
-	if (offset + len > snet->cfg->cfg_size)
-		return;
-
-	/* Write into PCI BAR */
-	for (i = 0; i < len; i++)
-		iowrite8(*buf_ptr++, cfg_ptr + i);
-}
-
 static int snet_suspend(struct vdpa_device *vdev)
 {
 	struct snet *snet = vdpa_to_snet(vdev);
@@ -548,7 +531,6 @@ static const struct vdpa_config_ops snet_config_ops = {
 	.get_status             = snet_get_status,
 	.set_status             = snet_set_status,
 	.get_config             = snet_get_config,
-	.set_config             = snet_set_config,
 	.suspend		= snet_suspend,
 	.resume			= snet_resume,
 };
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index a7612e0783b3..a9eac31f3757 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -401,22 +401,6 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(vdpa_get_config);
 
-/**
- * vdpa_set_config - Set one or more device configuration fields.
- * @vdev: vdpa device to operate on
- * @offset: starting byte offset of the field
- * @buf: buffer pointer to read from
- * @length: length of the configuration fields in bytes
- */
-void vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
-		     const void *buf, unsigned int length)
-{
-	down_write(&vdev->cf_lock);
-	vdev->config->set_config(vdev, offset, buf, length);
-	up_write(&vdev->cf_lock);
-}
-EXPORT_SYMBOL_GPL(vdpa_set_config);
-
 static bool mgmtdev_handle_match(const struct vdpa_mgmt_dev *mdev,
 				 const char *busname, const char *devname)
 {
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 421ab01ef06b..c2e14bcc01f6 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -546,20 +546,6 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 	memcpy(buf, vdpasim->config + offset, len);
 }
 
-static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
-			     const void *buf, unsigned int len)
-{
-	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
-
-	if (offset + len > vdpasim->dev_attr.config_size)
-		return;
-
-	memcpy(vdpasim->config + offset, buf, len);
-
-	if (vdpasim->dev_attr.set_config)
-		vdpasim->dev_attr.set_config(vdpasim, vdpasim->config);
-}
-
 static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -754,7 +740,6 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
-	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
 	.get_iova_range         = vdpasim_get_iova_range,
 	.set_group_asid         = vdpasim_set_group_asid,
@@ -792,7 +777,6 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.resume			= vdpasim_resume,
 	.get_config_size        = vdpasim_get_config_size,
 	.get_config             = vdpasim_get_config,
-	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
 	.get_iova_range         = vdpasim_get_iova_range,
 	.set_group_asid         = vdpasim_set_group_asid,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index bb137e479763..b48bf954a3bb 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -46,7 +46,6 @@ struct vdpasim_dev_attr {
 
 	void (*work_fn)(struct vdpasim *vdpasim);
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
-	void (*set_config)(struct vdpasim *vdpasim, const void *config);
 	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
 			 struct sk_buff *msg,
 			 struct netlink_ext_ack *extack);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index df7869537ef1..4fe69cb5b156 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -698,12 +698,6 @@ static void vduse_vdpa_get_config(struct vdpa_device *vdpa, unsigned int offset,
 	memcpy(buf, dev->config + offset, len);
 }
 
-static void vduse_vdpa_set_config(struct vdpa_device *vdpa, unsigned int offset,
-			const void *buf, unsigned int len)
-{
-	/* Now we only support read-only configuration space */
-}
-
 static int vduse_vdpa_reset(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
@@ -790,7 +784,6 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_status		= vduse_vdpa_set_status,
 	.get_config_size	= vduse_vdpa_get_config_size,
 	.get_config		= vduse_vdpa_get_config,
-	.set_config		= vduse_vdpa_set_config,
 	.get_generation		= vduse_vdpa_get_generation,
 	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..5e8ff91475e3 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -400,19 +400,6 @@ static void vp_vdpa_get_config(struct vdpa_device *vdpa,
 	} while (old != new);
 }
 
-static void vp_vdpa_set_config(struct vdpa_device *vdpa,
-			       unsigned int offset, const void *buf,
-			       unsigned int len)
-{
-	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
-	struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
-	const u8 *p = buf;
-	int i;
-
-	for (i = 0; i < len; i++)
-		vp_iowrite8(*p++, mdev->device + offset + i);
-}
-
 static void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
 				  struct vdpa_callback *cb)
 {
@@ -457,7 +444,6 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.get_vq_align	= vp_vdpa_get_vq_align,
 	.get_config_size = vp_vdpa_get_config_size,
 	.get_config	= vp_vdpa_get_config,
-	.set_config	= vp_vdpa_set_config,
 	.set_config_cb  = vp_vdpa_set_config_cb,
 	.get_vq_irq	= vp_vdpa_get_vq_irq,
 };
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index fb590e346e43..c6fcd54f59be 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -350,29 +350,6 @@ static long vhost_vdpa_get_config(struct vhost_vdpa *v,
 	return 0;
 }
 
-static long vhost_vdpa_set_config(struct vhost_vdpa *v,
-				  struct vhost_vdpa_config __user *c)
-{
-	struct vdpa_device *vdpa = v->vdpa;
-	struct vhost_vdpa_config config;
-	unsigned long size = offsetof(struct vhost_vdpa_config, buf);
-	u8 *buf;
-
-	if (copy_from_user(&config, c, size))
-		return -EFAULT;
-	if (vhost_vdpa_config_validate(v, &config))
-		return -EINVAL;
-
-	buf = vmemdup_user(c->buf, config.len);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	vdpa_set_config(vdpa, config.off, buf, config.len);
-
-	kvfree(buf);
-	return 0;
-}
-
 static bool vhost_vdpa_can_suspend(const struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -719,9 +696,6 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_GET_CONFIG:
 		r = vhost_vdpa_get_config(v, argp);
 		break;
-	case VHOST_VDPA_SET_CONFIG:
-		r = vhost_vdpa_set_config(v, argp);
-		break;
 	case VHOST_GET_FEATURES:
 		r = vhost_vdpa_get_features(v, argp);
 		break;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 06ce6d8c2e00..481ded50c916 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -62,14 +62,6 @@ static void virtio_vdpa_get(struct virtio_device *vdev, unsigned int offset,
 	vdpa_get_config(vdpa, offset, buf, len);
 }
 
-static void virtio_vdpa_set(struct virtio_device *vdev, unsigned int offset,
-			    const void *buf, unsigned int len)
-{
-	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-
-	vdpa_set_config(vdpa, offset, buf, len);
-}
-
 static u32 virtio_vdpa_generation(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
@@ -462,7 +454,6 @@ virtio_vdpa_get_vq_affinity(struct virtio_device *vdev, int index)
 
 static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.get		= virtio_vdpa_get,
-	.set		= virtio_vdpa_set,
 	.generation	= virtio_vdpa_generation,
 	.get_status	= virtio_vdpa_get_status,
 	.set_status	= virtio_vdpa_set_status,
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 0e652026b776..13e7ce0cea80 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -259,13 +259,6 @@ struct vdpa_map_file {
  *				@buf: buffer used to read to
  *				@len: the length to read from
  *				configuration space
- * @set_config:			Write to device specific configuration space
- *				@vdev: vdpa device
- *				@offset: offset from the beginning of
- *				configuration space
- *				@buf: buffer used to write from
- *				@len: the length to write to
- *				configuration space
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
@@ -378,8 +371,6 @@ struct vdpa_config_ops {
 	size_t (*get_config_size)(struct vdpa_device *vdev);
 	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
 			   void *buf, unsigned int len);
-	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
-			   const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
 	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 	int (*set_vq_affinity)(struct vdpa_device *vdev, u16 idx,
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index f5c48b61ab62..b7977f9ae596 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -157,13 +157,13 @@
  */
 #define VHOST_VDPA_GET_STATUS		_IOR(VHOST_VIRTIO, 0x71, __u8)
 #define VHOST_VDPA_SET_STATUS		_IOW(VHOST_VIRTIO, 0x72, __u8)
-/* Get and set the device config. The device config follows the same
- * definition of the device config defined in virtio-spec.
+/* Get the device config. The device config follows the same
+ * definition of the device config defined in virtio-spec. According to
+ * virtio-spec v3.1, all device configuration fields are read-only for the
+ * driver, and thus we do not have VHOST_VDPA_SET_CONFIG.
  */
 #define VHOST_VDPA_GET_CONFIG		_IOR(VHOST_VIRTIO, 0x73, \
 					     struct vhost_vdpa_config)
-#define VHOST_VDPA_SET_CONFIG		_IOW(VHOST_VIRTIO, 0x74, \
-					     struct vhost_vdpa_config)
 /* Enable/disable the ring. */
 #define VHOST_VDPA_SET_VRING_ENABLE	_IOW(VHOST_VIRTIO, 0x75, \
 					     struct vhost_vring_state)
-- 
2.34.1

