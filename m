Return-Path: <SRS0=RIAz=EB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE60BC2D0A3
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 11:19:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393B522404
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 11:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4PTgtc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393B522404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC51F8718A;
	Mon, 26 Oct 2020 11:19:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Un2BkINb-tbG; Mon, 26 Oct 2020 11:19:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C60DD8721E;
	Mon, 26 Oct 2020 11:19:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC493C088B;
	Mon, 26 Oct 2020 11:19:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39993C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 11:19:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 35AB1867B6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 11:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q+An-ccSaCHo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 11:19:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4254986256
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 11:19:18 +0000 (UTC)
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1F15922284;
 Mon, 26 Oct 2020 11:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603711158;
 bh=p/8LjURGxbgfxGjqZnzp03kNS6UcszzCDdsxjft9TVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E4PTgtc05FZClhnQW9/ku7zh9qFOr21Cf1X7vsq76FB7E9QAPJhpcDSXsVuTFpaV9
 4Gqm/j8gfr9sQBNXINho8vMVgAwicWIsZ4C6ffXwxNPMJ46Eyfkangy2ThPqkvvBPP
 guECJ5mS8uOLisqoFJWcrICJfljApkLfC2ZPMwsI=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH mlx5-next 06/11] vdpa/mlx5: Connect mlx5_vdpa to auxiliary bus
Date: Mon, 26 Oct 2020 13:18:44 +0200
Message-Id: <20201026111849.1035786-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026111849.1035786-1-leon@kernel.org>
References: <20201026111849.1035786-1-leon@kernel.org>
MIME-Version: 1.0
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kiran.patil@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, virtualization@lists.linux-foundation.org,
 fred.oh@linux.intel.com, tiwai@suse.de, broonie@kernel.org,
 Parav Pandit <parav@nvidia.com>, Roi Dayan <roid@nvidia.com>,
 shiraz.saleem@intel.com, Jakub Kicinski <kuba@kernel.org>,
 dan.j.williams@intel.com, Leon Romanovsky <leonro@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, linux-kernel@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
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

From: Leon Romanovsky <leonro@nvidia.com>

Change module registration logic to use auxiliary bus instead of custom
made mlx5 register interface.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 28 ++++++-
 drivers/vdpa/mlx5/Makefile                    |  2 +-
 drivers/vdpa/mlx5/net/main.c                  | 76 -------------------
 drivers/vdpa/mlx5/net/mlx5_vnet.c             | 53 +++++++++++--
 drivers/vdpa/mlx5/net/mlx5_vnet.h             | 24 ------
 5 files changed, 73 insertions(+), 110 deletions(-)
 delete mode 100644 drivers/vdpa/mlx5/net/main.c
 delete mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index d57b549a358c..aa4f30bd7bb5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -31,6 +31,7 @@
  */

 #include <linux/mlx5/driver.h>
+#include <linux/mlx5/mlx5_ifc_vdpa.h>
 #include "mlx5_core.h"

 static LIST_HEAD(intf_list);
@@ -51,10 +52,35 @@ enum {
 	MLX5_INTERFACE_ATTACHED,
 };

+static bool is_vnet_supported(struct mlx5_core_dev *dev)
+{
+	if (!IS_ENABLED(CONFIG_MLX5_VDPA_NET))
+		return false;
+
+	if (mlx5_core_is_pf(dev))
+		return false;
+
+	if (!(MLX5_CAP_GEN_64(dev, general_obj_types) &
+	      MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q))
+		return false;
+
+	if (!(MLX5_CAP_DEV_VDPA_EMULATION(dev, event_mode) &
+	      MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE))
+		return false;
+
+	if (!MLX5_CAP_DEV_VDPA_EMULATION(dev, eth_frame_offload_type))
+		return false;
+
+	return true;
+}
+
 static const struct mlx5_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx5_core_dev *dev);
-} mlx5_adev_devices[1] = {};
+} mlx5_adev_devices[] = {
+	[MLX5_INTERFACE_PROTOCOL_VDPA] = { .suffix = "vnet",
+					   .is_supported = &is_vnet_supported },
+};

 int mlx5_adev_init(struct mlx5_core_dev *dev)
 {
diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
index 89a5bededc9f..f717978c83bf 100644
--- a/drivers/vdpa/mlx5/Makefile
+++ b/drivers/vdpa/mlx5/Makefile
@@ -1,4 +1,4 @@
 subdir-ccflags-y += -I$(srctree)/drivers/vdpa/mlx5/core

 obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa.o
-mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/main.o net/mlx5_vnet.o core/resources.o core/mr.o
+mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/mlx5_vnet.o core/resources.o core/mr.o
diff --git a/drivers/vdpa/mlx5/net/main.c b/drivers/vdpa/mlx5/net/main.c
deleted file mode 100644
index 4dd3f00f2306..000000000000
--- a/drivers/vdpa/mlx5/net/main.c
+++ /dev/null
@@ -1,76 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
-/* Copyright (c) 2020 Mellanox Technologies Ltd. */
-
-#include <linux/module.h>
-#include <linux/mlx5/driver.h>
-#include <linux/mlx5/device.h>
-#include <linux/mlx5/mlx5_ifc_vdpa.h>
-#include "mlx5_vnet.h"
-
-MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
-MODULE_DESCRIPTION("Mellanox VDPA driver");
-MODULE_LICENSE("Dual BSD/GPL");
-
-static bool required_caps_supported(struct mlx5_core_dev *mdev)
-{
-	u8 event_mode;
-	u64 got;
-
-	got = MLX5_CAP_GEN_64(mdev, general_obj_types);
-
-	if (!(got & MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q))
-		return false;
-
-	event_mode = MLX5_CAP_DEV_VDPA_EMULATION(mdev, event_mode);
-	if (!(event_mode & MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE))
-		return false;
-
-	if (!MLX5_CAP_DEV_VDPA_EMULATION(mdev, eth_frame_offload_type))
-		return false;
-
-	return true;
-}
-
-static void *mlx5_vdpa_add(struct mlx5_core_dev *mdev)
-{
-	struct mlx5_vdpa_dev *vdev;
-
-	if (mlx5_core_is_pf(mdev))
-		return NULL;
-
-	if (!required_caps_supported(mdev)) {
-		dev_info(mdev->device, "virtio net emulation not supported\n");
-		return NULL;
-	}
-	vdev = mlx5_vdpa_add_dev(mdev);
-	if (IS_ERR(vdev))
-		return NULL;
-
-	return vdev;
-}
-
-static void mlx5_vdpa_remove(struct mlx5_core_dev *mdev, void *context)
-{
-	struct mlx5_vdpa_dev *vdev = context;
-
-	mlx5_vdpa_remove_dev(vdev);
-}
-
-static struct mlx5_interface mlx5_vdpa_interface = {
-	.add = mlx5_vdpa_add,
-	.remove = mlx5_vdpa_remove,
-	.protocol = MLX5_INTERFACE_PROTOCOL_VDPA,
-};
-
-static int __init mlx5_vdpa_init(void)
-{
-	return mlx5_register_interface(&mlx5_vdpa_interface);
-}
-
-static void __exit mlx5_vdpa_exit(void)
-{
-	mlx5_unregister_interface(&mlx5_vdpa_interface);
-}
-
-module_init(mlx5_vdpa_init);
-module_exit(mlx5_vdpa_exit);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6c218b47b9f1..07216e9736ce 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1,18 +1,27 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2020 Mellanox Technologies Ltd. */

+#include <linux/module.h>
 #include <linux/vdpa.h>
+#include <linux/vringh.h>
+#include <uapi/linux/virtio_net.h>
 #include <uapi/linux/virtio_ids.h>
 #include <linux/virtio_config.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/mlx5/cq.h>
 #include <linux/mlx5/qp.h>
 #include <linux/mlx5/device.h>
+#include <linux/mlx5/driver.h>
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
-#include <linux/mlx5/device.h>
 #include <linux/mlx5/mlx5_ifc_vdpa.h>
-#include "mlx5_vnet.h"
 #include "mlx5_vdpa.h"

+MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
+MODULE_DESCRIPTION("Mellanox VDPA driver");
+MODULE_LICENSE("Dual BSD/GPL");
+
+#define to_mlx5_vdpa_ndev(__mvdev) container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
 #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)

 #define VALID_FEATURES_MASK                                                                        \
@@ -159,6 +168,11 @@ static bool mlx5_vdpa_debug;
 			mlx5_vdpa_info(mvdev, "%s\n", #_status);                                   \
 	} while (0)

+static inline u32 mlx5_vdpa_max_qps(int max_vqs)
+{
+	return max_vqs / 2;
+}
+
 static void print_status(struct mlx5_vdpa_dev *mvdev, u8 status, bool set)
 {
 	if (status & ~VALID_STATUS_MASK)
@@ -1928,8 +1942,11 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 	}
 }

-void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
+static int mlx5v_probe(struct auxiliary_device *adev,
+		       const struct auxiliary_device_id *id)
 {
+	struct mlx5_adev *vdev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = vdev->mdev;
 	struct virtio_net_config *config;
 	struct mlx5_vdpa_dev *mvdev;
 	struct mlx5_vdpa_net *ndev;
@@ -1943,7 +1960,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
 				 2 * mlx5_vdpa_max_qps(max_vqs));
 	if (IS_ERR(ndev))
-		return ndev;
+		return PTR_ERR(ndev);

 	ndev->mvdev.max_vqs = max_vqs;
 	mvdev = &ndev->mvdev;
@@ -1972,7 +1989,8 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 	if (err)
 		goto err_reg;

-	return ndev;
+	dev_set_drvdata(&adev->dev, ndev);
+	return 0;

 err_reg:
 	free_resources(ndev);
@@ -1981,10 +1999,29 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 err_mtu:
 	mutex_destroy(&ndev->reslock);
 	put_device(&mvdev->vdev.dev);
-	return ERR_PTR(err);
+	return err;
 }

-void mlx5_vdpa_remove_dev(struct mlx5_vdpa_dev *mvdev)
+static int mlx5v_remove(struct auxiliary_device *adev)
 {
-	vdpa_unregister_device(&mvdev->vdev);
+	struct mlx5_vdpa_dev *vdev = dev_get_drvdata(&adev->dev);
+
+	vdpa_unregister_device(&vdev->vdev);
+	return 0;
 }
+
+static const struct auxiliary_device_id mlx5v_id_table[] = {
+	{ .name = MLX5_ADEV_NAME ".vnet", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, mlx5v_id_table);
+
+static struct auxiliary_driver mlx5v_driver = {
+	.name = "vnet",
+	.probe = mlx5v_probe,
+	.remove = mlx5v_remove,
+	.id_table = mlx5v_id_table,
+};
+
+module_auxiliary_driver(mlx5v_driver);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
deleted file mode 100644
index f2d6d68b020e..000000000000
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
-/* Copyright (c) 2020 Mellanox Technologies Ltd. */
-
-#ifndef __MLX5_VNET_H_
-#define __MLX5_VNET_H_
-
-#include <linux/vdpa.h>
-#include <linux/virtio_net.h>
-#include <linux/vringh.h>
-#include <linux/mlx5/driver.h>
-#include <linux/mlx5/cq.h>
-#include <linux/mlx5/qp.h>
-#include "mlx5_vdpa.h"
-
-static inline u32 mlx5_vdpa_max_qps(int max_vqs)
-{
-	return max_vqs / 2;
-}
-
-#define to_mlx5_vdpa_ndev(__mvdev) container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
-void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev);
-void mlx5_vdpa_remove_dev(struct mlx5_vdpa_dev *mvdev);
-
-#endif /* __MLX5_VNET_H_ */
--
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
