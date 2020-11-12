Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF54C56202
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 06:40:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F646208FE
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 06:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cEorBUDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F646208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 633FB86D64;
	Thu, 12 Nov 2020 06:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQWAxinQuMt1; Thu, 12 Nov 2020 06:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A655686D63;
	Thu, 12 Nov 2020 06:40:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CD02C08A1;
	Thu, 12 Nov 2020 06:40:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55FFDC016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 06:40:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 511F986D5F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 06:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AoF9OJrAczJ6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 06:40:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7376686B83
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 06:40:32 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5facd8da0001>; Wed, 11 Nov 2020 22:40:26 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 06:40:31 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH 3/7] vdpa: Extend routine to accept vdpa device name
Date: Thu, 12 Nov 2020 08:40:01 +0200
Message-ID: <20201112064005.349268-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201112064005.349268-1-parav@nvidia.com>
References: <20201112064005.349268-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1605163226; bh=1Lj3uhvlUAqek+U0OdG3uZU0WHYgkHYKA+te4VxyX1E=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=cEorBUDR3PYSlNlGuqprm/ZQA+sNHw6jvxe2MPOXD8048lm87mGGTavVjF84lwzVP
 E05iOwzIWDbutAuK6qR5rlmBdcmai5D3kBd+k9jeaeeHHiALHG5iiiA3l9cDEuOoWL
 LG/zYST3ul1ErB6tn9VBZGqysBT5ONPH5ieA9ZQ8Rnwz7ZIyLyZNy5ksdmCoe5kz5h
 AikyuODijgWo7jVhCEJ8FNKkkjq67vaGSnFmSF85PTjInBkXt88vESuZ2jJhoZWMwG
 9SB2OBcUmO6Slzjbf7huP+E6wxEfwYfWlj1r9vD/VGoDIfcb3m9oJyeQyoMc41yJ/5
 yCcnI6d0TyBiw==
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com
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

In a subsequent patch, when user initiated command creates a vdpa device,
the user chooses the name of the vdpa device.
To support it, extend the device allocation API to consider this name
specified by the caller driver.

Split the device unregistration to device delete and device put so that
device can be removed from the list after its deleted.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c   |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  2 +-
 drivers/vdpa/vdpa.c               | 36 +++++++++++++++++++++++++++----
 drivers/vdpa/vdpa_sim/vdpa_sim.c  |  2 +-
 include/linux/vdpa.h              |  7 +++---
 5 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 8b4028556cb6..23474af7da40 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -439,7 +439,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
 				    dev, &ifc_vdpa_ops,
-				    IFCVF_MAX_QUEUE_PAIRS * 2);
+				    IFCVF_MAX_QUEUE_PAIRS * 2, NULL);
 	if (adapter == NULL) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return -ENOMEM;
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 5316e51e72d4..cf9fc51071c8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1958,7 +1958,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 2 * mlx5_vdpa_max_qps(max_vqs));
+				 2 * mlx5_vdpa_max_qps(max_vqs), NULL);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index c0825650c055..3c9cade05233 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/vdpa.h>
 
+/* A global mutex that protects vdpa parent and device level operations. */
+static DEFINE_MUTEX(vdpa_dev_mutex);
 static DEFINE_IDA(vdpa_index_ida);
 
 static int vdpa_dev_probe(struct device *d)
@@ -63,6 +65,7 @@ static void vdpa_release_dev(struct device *d)
  * @config: the bus operations that is supported by this device
  * @nvqs: number of virtqueues supported by this device
  * @size: size of the parent structure that contains private data
+ * @name: name of the vdpa device; optional.
  *
  * Driver should use vdpa_alloc_device() wrapper macro instead of
  * using this directly.
@@ -72,8 +75,7 @@ static void vdpa_release_dev(struct device *d)
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					int nvqs,
-					size_t size)
+					int nvqs, size_t size, const char *name)
 {
 	struct vdpa_device *vdev;
 	int err = -EINVAL;
@@ -101,7 +103,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->features_valid = false;
 	vdev->nvqs = nvqs;
 
-	err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
+	if (name)
+		err = dev_set_name(&vdev->dev, "%s", name);
+	else
+		err = dev_set_name(&vdev->dev, "vdpa%u", vdev->index);
 	if (err)
 		goto err_name;
 
@@ -118,6 +123,13 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
 
+static int vdpa_name_match(struct device *dev, const void *data)
+{
+	struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
+
+	return (strcmp(dev_name(&vdev->dev), data) == 0);
+}
+
 /**
  * vdpa_register_device - register a vDPA device
  * Callers must have a succeed call of vdpa_alloc_device() before.
@@ -127,7 +139,21 @@ EXPORT_SYMBOL_GPL(__vdpa_alloc_device);
  */
 int vdpa_register_device(struct vdpa_device *vdev)
 {
-	return device_add(&vdev->dev);
+	struct device *dev;
+	int err;
+
+	mutex_lock(&vdpa_dev_mutex);
+	dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
+	if (dev) {
+		put_device(dev);
+		err = -EEXIST;
+		goto name_err;
+	}
+
+	err = device_add(&vdev->dev);
+name_err:
+	mutex_unlock(&vdpa_dev_mutex);
+	return err;
 }
 EXPORT_SYMBOL_GPL(vdpa_register_device);
 
@@ -137,7 +163,9 @@ EXPORT_SYMBOL_GPL(vdpa_register_device);
  */
 void vdpa_unregister_device(struct vdpa_device *vdev)
 {
+	mutex_lock(&vdpa_dev_mutex);
 	device_unregister(&vdev->dev);
+	mutex_unlock(&vdpa_dev_mutex);
 }
 EXPORT_SYMBOL_GPL(vdpa_unregister_device);
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..aed1bb7770ab 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -357,7 +357,7 @@ static struct vdpasim *vdpasim_create(void)
 	else
 		ops = &vdpasim_net_config_ops;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM, NULL);
 	if (!vdpasim)
 		goto err_alloc;
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 0fefeb976877..5700baa22356 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -245,15 +245,14 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
-					int nvqs,
-					size_t size);
+					int nvqs, size_t size, const char *name);
 
-#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs)   \
+#define vdpa_alloc_device(dev_struct, member, parent, config, nvqs, name)   \
 			  container_of(__vdpa_alloc_device( \
 				       parent, config, nvqs, \
 				       sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
-				       dev_struct, member))), \
+				       dev_struct, member)), name), \
 				       dev_struct, member)
 
 int vdpa_register_device(struct vdpa_device *vdev);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
