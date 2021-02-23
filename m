Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF5EC433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 06:19:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F6361606
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 06:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F6361606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EDBA18592F;
	Tue, 23 Feb 2021 06:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xIInBkpC0838; Tue, 23 Feb 2021 06:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 30CF28487B;
	Tue, 23 Feb 2021 06:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 185C9C000B;
	Tue, 23 Feb 2021 06:19:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52133C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4173D8487B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O_iJG-JNInl7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:29 +0000 (UTC)
X-Greylist: delayed 20:48:41 by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5280A85010
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614061168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyqhNhxMxa4aRH2mxd+pII6u/aPvzKnA7rbE+xCXp5E=;
 b=LRjLpXJ2mjavE7pSVK+i38y+rqqabZTAH74NQ19HKkYUd6F6BDrakZ6Pu0XQIGrAp9R3bj
 vIrGCS1MBthn+8Ax7B7rLnxX3YYLL8x7qTlUUG1f5CjWLW1MQGoqRCdIerhFIJueI+gJHE
 hc6dA4RCYyatyrDgbXrW4VoxLVCa/vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-AsQbNYqeMaOe9V6OE0Ecmw-1; Tue, 23 Feb 2021 01:19:25 -0500
X-MC-Unique: AsQbNYqeMaOe9V6OE0Ecmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2DAB107ACE6;
 Tue, 23 Feb 2021 06:19:23 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-6.pek2.redhat.com [10.72.13.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6647E5D9D3;
 Tue, 23 Feb 2021 06:19:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V4 2/3] vdpa: set the virtqueue num during register
Date: Tue, 23 Feb 2021 14:19:04 +0800
Message-Id: <20210223061905.422659-3-jasowang@redhat.com>
In-Reply-To: <20210223061905.422659-1-jasowang@redhat.com>
References: <20210223061905.422659-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: shahafs@mellanox.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This patch delay the queue number setting to vDPA device
registering. This allows us to probe the virtqueue numbers between
device allocation and registering.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c      |  5 ++---
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  4 ++--
 drivers/vdpa/vdpa.c                  | 18 ++++++++++--------
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
 include/linux/vdpa.h                 | 10 +++++-----
 6 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 7c8bbfcf6c3e..d555a6a5d1ba 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -431,8 +431,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
-				    dev, &ifc_vdpa_ops,
-				    IFCVF_MAX_QUEUE_PAIRS * 2, NULL);
+				    dev, &ifc_vdpa_ops, NULL);
 	if (adapter == NULL) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return -ENOMEM;
@@ -456,7 +455,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++)
 		vf->vring[i].irq = -EINVAL;
 
-	ret = vdpa_register_device(&adapter->vdpa);
+	ret = vdpa_register_device(&adapter->vdpa, IFCVF_MAX_QUEUE_PAIRS * 2);
 	if (ret) {
 		IFCVF_ERR(pdev, "Failed to register ifcvf to vdpa bus");
 		goto err;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 10e9b09932eb..71397fdafa6a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1982,7 +1982,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 2 * mlx5_vdpa_max_qps(max_vqs), NULL);
+				 NULL);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
@@ -2009,7 +2009,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	if (err)
 		goto err_res;
 
-	err = vdpa_register_device(&mvdev->vdev);
+	err = vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
 	if (err)
 		goto err_reg;
 
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 3d997b389345..55a15c51e243 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -69,7 +69,6 @@ static void vdpa_release_dev(struct device *d)
  * initialized but before registered.
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
- * @nvqs: number of virtqueues supported by this device
  * @size: size of the parent structure that contains private data
  * @name: name of the vdpa device; optional.
  *
@@ -81,7 +80,7 @@ static void vdpa_release_dev(struct device *d)
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					int nvqs, size_t size, const char *name)
+					size_t size, const char *name)
 {
 	struct vdpa_device *vdev;
 	int err = -EINVAL;
@@ -107,7 +106,6 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->index = err;
 	vdev->config = config;
 	vdev->features_valid = false;
-	vdev->nvqs = nvqs;
 
 	if (name)
 		err = dev_set_name(&vdev->dev, "%s", name);
@@ -136,10 +134,12 @@ static int vdpa_name_match(struct device *dev, const void *data)
 	return (strcmp(dev_name(&vdev->dev), data) == 0);
 }
 
-static int __vdpa_register_device(struct vdpa_device *vdev)
+static int __vdpa_register_device(struct vdpa_device *vdev, int nvqs)
 {
 	struct device *dev;
 
+	vdev->nvqs = nvqs;
+
 	lockdep_assert_held(&vdpa_dev_mutex);
 	dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
 	if (dev) {
@@ -155,15 +155,16 @@ static int __vdpa_register_device(struct vdpa_device *vdev)
  * Caller must invoke this routine in the management device dev_add()
  * callback after setting up valid mgmtdev for this vdpa device.
  * @vdev: the vdpa device to be registered to vDPA bus
+ * @nvqs: number of virtqueues supported by this device
  *
  * Returns an error when fail to add device to vDPA bus
  */
-int _vdpa_register_device(struct vdpa_device *vdev)
+int _vdpa_register_device(struct vdpa_device *vdev, int nvqs)
 {
 	if (!vdev->mdev)
 		return -EINVAL;
 
-	return __vdpa_register_device(vdev);
+	return __vdpa_register_device(vdev, nvqs);
 }
 EXPORT_SYMBOL_GPL(_vdpa_register_device);
 
@@ -171,15 +172,16 @@ EXPORT_SYMBOL_GPL(_vdpa_register_device);
  * vdpa_register_device - register a vDPA device
  * Callers must have a succeed call of vdpa_alloc_device() before.
  * @vdev: the vdpa device to be registered to vDPA bus
+ * @nvqs: number of virtqueues supported by this device
  *
  * Returns an error when fail to add to vDPA bus
  */
-int vdpa_register_device(struct vdpa_device *vdev)
+int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
 {
 	int err;
 
 	mutex_lock(&vdpa_dev_mutex);
-	err = __vdpa_register_device(vdev);
+	err = __vdpa_register_device(vdev, nvqs);
 	mutex_unlock(&vdpa_dev_mutex);
 	return err;
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index d5942842432d..5b6b2f87d40c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -235,7 +235,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		ops = &vdpasim_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
-				    dev_attr->nvqs, dev_attr->name);
+				    dev_attr->name);
 	if (!vdpasim)
 		goto err_alloc;
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index d344c5b7c914..702be74877d2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -147,7 +147,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
-	ret = _vdpa_register_device(&simdev->vdpa);
+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
 	if (ret)
 		goto reg_err;
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 4ab5494503a8..15fa085fab05 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -250,20 +250,20 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					int nvqs, size_t size, const char *name);
+					size_t size, const char *name);
 
-#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs, name)   \
+#define vdpa_alloc_device(dev_struct, member, parent, config, name)   \
 			  container_of(__vdpa_alloc_device( \
-				       parent, config, nvqs, \
+				       parent, config, \
 				       sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
 				       dev_struct, member)), name), \
 				       dev_struct, member)
 
-int vdpa_register_device(struct vdpa_device *vdev);
+int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
 void vdpa_unregister_device(struct vdpa_device *vdev);
 
-int _vdpa_register_device(struct vdpa_device *vdev);
+int _vdpa_register_device(struct vdpa_device *vdev, int nvqs);
 void _vdpa_unregister_device(struct vdpa_device *vdev);
 
 /**
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
