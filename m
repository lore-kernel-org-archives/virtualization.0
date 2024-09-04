Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4A1DEFC1
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463104; cv=none; b=Nc3Nu3hQcs+m1i6hQoaNVgmGOAD56ZNbmzVM+b+wjkh6J3WzsBcHRYmUqLxTctv3vOeOSUJ3TpeQUdl2smJ+QT8dZPPF9igZCfUk6UMoGKD7/jviMTABGAhiffhVlC2aGzZgivCfQplMM5GzCWalSb1cIC4/UW2ncHXpB+rzpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463104; c=relaxed/simple;
	bh=n5b9G0+Y/RrgEQcdH2Hokzr9vzO3959ZC8lNAhQ3N+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0+icmv3I57R5IkiBRCAVOiq3fWpDAubvwfLbO7Qod8Ae+gC36s65kPxB3ZkP6GIaS25RGQjCtFYuNprg5PyldEOi8vfxDU3gj4AU3sq1y8pXJfBAF2uviRFnR8IYRbq2Rn5dsFLmd0HRVD/1xlNe2R9z4xoUSPWYgeVAXDvNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFMowkWw; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFMowkWw"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3df0c4a65baso4084748b6e.2
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463102; x=1726067902; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eNsui7Fa+rY/jtC8BKPiUjnxeoWmpi4+sMEvN8zPeo=;
        b=aFMowkWwA+2a04viaykgjF7BeApK1cL/twnI3If770MiK3c8q8DWUSxfEsjs+cFKIZ
         XlJnievvAjyEG2cW7uS44czV3OhVzvknpHqE537yNqhEeS8eJh1Vly5H6wBq6pZjaUHl
         eNzJHEgg/52D9VpkAsfvTDr1FYvzIvQSGZSTvFneBxH+TdsQaU78gDR4jvX90k3Ijm8K
         T+5XEiu6Is2N+YpE9dhQEzatS+mKVNjbYsloI0K3SPMKMO9kPZ18WyhSLsC/IJop9Gvy
         +S1vWtxh6QEg3jfy4CDIwYgTWOJ6A9VdDeAoU90CPtkL1+U/STtIfVrWKCsQqg+ITitS
         lIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463102; x=1726067902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eNsui7Fa+rY/jtC8BKPiUjnxeoWmpi4+sMEvN8zPeo=;
        b=UzbRuR2FmIhAyT5CN/+xLWJ5V7EEfLT4I46Eh87zOky6y8rrzHjB+D3NPeZbZi0rrs
         RItmumTSeaS1mcFpoDOY9mpn//apeh0of5ZeviAfsHPwlJf6WB7sn70+n6KzSurkuJxz
         q4DeWGldIo4+vsDWVXyGg/vWNHVOoOkG1DaQIpnNmc8FgtqDRIBWqpFijuTnh/lL6vyS
         nv9qpi7D3ZnIkR0FRTWR6qouSrUklWDHf7069uG/1Pc3D8hsKVcTrIF4kliGK4BXjqlE
         /0a987StyAPasNuACIb8kbWn++FziGOEbAs/CwQR2auE7weEcYkrLPIoDQShJ6kZ/oAF
         hUHA==
X-Forwarded-Encrypted: i=1; AJvYcCX45CU4BC/8P1q4EGjWPeGwjPOq7m6iun/myD/1Z24LhtBLrGt4us2Tt4c+kWtF4SNw/HuKgXKpEWzHJ++tmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbZNsLdi/SNpaRM7ylEEesq8w8meWLeqdlaeWnOCAdssB9jpA7
	fVAOaf1SznyX0yVkMyPprQZ/mrZciL1EJtTEfxgs6q6VT5oTZrPk
X-Google-Smtp-Source: AGHT+IGWyC05ZNcwaeJftczG4VpiVo1epiLVuHQFEmoF7Vd6MOOA9QqjlvdUWPPG4Xat19zdBaPCjg==
X-Received: by 2002:a05:6808:2393:b0:3d6:2e85:5c34 with SMTP id 5614622812f47-3df05e5eb49mr24377879b6e.38.1725463102022;
        Wed, 04 Sep 2024 08:18:22 -0700 (PDT)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117db1f2sm2831040b6e.32.2024.09.04.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:18:21 -0700 (PDT)
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
Subject: [PATCH v3 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
Date: Wed,  4 Sep 2024 10:11:15 -0500
Message-ID: <20240904151115.205622-3-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <cbilbao@digitalocean.com>

Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations with
vdpa_config_ops->set_config(). This is needed per virtio spec requirements:
virtio-spec v1.3 Sec 5.1.4 states that "All of the device configuration
fields are read-only for the driver.". This excludes legacy Alibaba's ENI
so make it use vda_config_ops->set_config_legacy() to avoid future
confusion.

Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c    |  2 +-
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
 include/linux/vdpa.h               |  7 ++++---
 include/uapi/linux/vhost.h         |  8 ++++----
 14 files changed, 9 insertions(+), 148 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index cce3d1837104..64b0c0be89ae 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -429,7 +429,7 @@ static const struct vdpa_config_ops eni_vdpa_ops = {
 	.get_vq_align	= eni_vdpa_get_vq_align,
 	.get_config_size = eni_vdpa_get_config_size,
 	.get_config	= eni_vdpa_get_config,
-	.set_config	= eni_vdpa_set_config,
+	.set_config_legacy = eni_vdpa_set_config,
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
index 41ca268d43ff..35ed46c65b4d 100644
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
index 0e652026b776..9346fa9e3d97 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -259,7 +259,8 @@ struct vdpa_map_file {
  *				@buf: buffer used to read to
  *				@len: the length to read from
  *				configuration space
- * @set_config:			Write to device specific configuration space
+ * @set_config_legacy:		Write to device specific configuration space
+ *				Legacy functionality for virtio-spec < v1.3
  *				@vdev: vdpa device
  *				@offset: offset from the beginning of
  *				configuration space
@@ -378,8 +379,8 @@ struct vdpa_config_ops {
 	size_t (*get_config_size)(struct vdpa_device *vdev);
 	void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
 			   void *buf, unsigned int len);
-	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
-			   const void *buf, unsigned int len);
+	void (*set_config_legacy)(struct vdpa_device *vdev,
+			unsigned int offset, const void *buf, unsigned int len);
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
+ * virtio-spec v1.3, all device configuration fields are read-only for the
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

