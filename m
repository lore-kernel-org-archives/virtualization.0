Return-Path: <SRS0=Dilt=KZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B0BC47092
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 14:22:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D53611EE
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 14:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D53611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2C7783A9D;
	Sun, 30 May 2021 14:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 51_WE945oJSZ; Sun, 30 May 2021 14:22:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C4BF83883;
	Sun, 30 May 2021 14:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04C08C000D;
	Sun, 30 May 2021 14:22:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25B43C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 14:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04BD3403BA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 14:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ubHf-6jyuCX
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 14:22:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4D2D403AE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 14:22:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A33C260FDB;
 Sun, 30 May 2021 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1622384537;
 bh=lg9oi8XSg2SEd60XxCO5oczaE9sCr4YeOLWScbo2VcQ=;
 h=Subject:To:Cc:From:Date:From;
 b=I7q02FXDIT7VY4aQ6CtFGs+Ke+3HH971M0MHofNSkHR7uL60db00EcgyqmaESTUYH
 9faiOBEErKORZ3h3kr1CVR+vgdgXwhx7opC8B3pKB4r8yThtZ/xBTPUKRAtEJgq0HU
 9DHJFpGaWz2Wb10m7hXlG27BzQkepz0o7SUuUb6o=
Subject: Patch "{net,
 vdpa}/mlx5: Configure interface MAC into mpfs L2 table" has been
 added to the 5.10-stable tree
To: elic@nvidia.com, gregkh@linuxfoundation.org, jasowang@redhat.com,
 mst@redhat.com, saeedm@nvidia.com, virtualization@lists.linux-foundation.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 30 May 2021 16:20:51 +0200
Message-ID: <16223844514771@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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


This is a note to let you know that I've just added the patch titled

    {net,vdpa}/mlx5: Configure interface MAC into mpfs L2 table

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     net-vdpa-mlx5-configure-interface-mac-into-mpfs-l2-table.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 7c9f131f366ab414691907fa0407124ea2b2f3bc Mon Sep 17 00:00:00 2001
From: Eli Cohen <elic@nvidia.com>
Date: Thu, 22 Apr 2021 15:48:10 +0300
Subject: {net,vdpa}/mlx5: Configure interface MAC into mpfs L2 table

From: Eli Cohen <elic@nvidia.com>

commit 7c9f131f366ab414691907fa0407124ea2b2f3bc upstream.

net/mlx5: Expose MPFS configuration API

MPFS is the multi physical function switch that bridges traffic between
the physical port and any physical functions associated with it. The
driver is required to add or remove MAC entries to properly forward
incoming traffic to the correct physical function.

We export the API to control MPFS so that other drivers, such as
mlx5_vdpa are able to add MAC addresses of their network interfaces.

The MAC address of the vdpa interface must be configured into the MPFS L2
address. Failing to do so could cause, in some NIC configurations, failure
to forward packets to the vdpa network device instance.

Fix this by adding calls to update the MPFS table.

CC: <mst@redhat.com>
CC: <jasowang@redhat.com>
CC: <virtualization@lists.linux-foundation.org>
Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c |    3 +++
 drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h |    5 +----
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   19 ++++++++++++++++++-
 include/linux/mlx5/mpfs.h                          |   18 ++++++++++++++++++
 6 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/mlx5/mpfs.h

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -35,6 +35,7 @@
 #include <linux/ipv6.h>
 #include <linux/tcp.h>
 #include <linux/mlx5/fs.h>
+#include <linux/mlx5/mpfs.h>
 #include "en.h"
 #include "lib/mpfs.h"
 
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -35,6 +35,7 @@
 #include <linux/mlx5/mlx5_ifc.h>
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
+#include <linux/mlx5/mpfs.h>
 #include "esw/acl/lgcy.h"
 #include "mlx5_core.h"
 #include "lib/eq.h"
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.c
@@ -33,6 +33,7 @@
 #include <linux/etherdevice.h>
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/mlx5_ifc.h>
+#include <linux/mlx5/mpfs.h>
 #include <linux/mlx5/eswitch.h>
 #include "mlx5_core.h"
 #include "lib/mpfs.h"
@@ -175,6 +176,7 @@ out:
 	mutex_unlock(&mpfs->lock);
 	return err;
 }
+EXPORT_SYMBOL(mlx5_mpfs_add_mac);
 
 int mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac)
 {
@@ -206,3 +208,4 @@ unlock:
 	mutex_unlock(&mpfs->lock);
 	return err;
 }
+EXPORT_SYMBOL(mlx5_mpfs_del_mac);
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mpfs.h
@@ -84,12 +84,9 @@ struct l2addr_node {
 #ifdef CONFIG_MLX5_MPFS
 int  mlx5_mpfs_init(struct mlx5_core_dev *dev);
 void mlx5_mpfs_cleanup(struct mlx5_core_dev *dev);
-int  mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac);
-int  mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac);
 #else /* #ifndef CONFIG_MLX5_MPFS */
 static inline int  mlx5_mpfs_init(struct mlx5_core_dev *dev) { return 0; }
 static inline void mlx5_mpfs_cleanup(struct mlx5_core_dev *dev) {}
-static inline int  mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac) { return 0; }
-static inline int  mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac) { return 0; }
 #endif
+
 #endif
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -9,6 +9,7 @@
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/device.h>
+#include <linux/mlx5/mpfs.h>
 #include "mlx5_vnet.h"
 #include "mlx5_vdpa_ifc.h"
 #include "mlx5_vdpa.h"
@@ -1839,11 +1840,16 @@ static int mlx5_vdpa_set_map(struct vdpa
 static void mlx5_vdpa_free(struct vdpa_device *vdev)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	struct mlx5_core_dev *pfmdev;
 	struct mlx5_vdpa_net *ndev;
 
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
 	free_resources(ndev);
+	if (!is_zero_ether_addr(ndev->config.mac)) {
+		pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
+		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
+	}
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 	mutex_destroy(&ndev->reslock);
 }
@@ -1962,6 +1968,7 @@ static void init_mvqs(struct mlx5_vdpa_n
 void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
 {
 	struct virtio_net_config *config;
+	struct mlx5_core_dev *pfmdev;
 	struct mlx5_vdpa_dev *mvdev;
 	struct mlx5_vdpa_net *ndev;
 	u32 max_vqs;
@@ -1990,10 +1997,17 @@ void *mlx5_vdpa_add_dev(struct mlx5_core
 	if (err)
 		goto err_mtu;
 
+	if (!is_zero_ether_addr(config->mac)) {
+		pfmdev = pci_get_drvdata(pci_physfn(mdev->pdev));
+		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
+		if (err)
+			goto err_mtu;
+	}
+
 	mvdev->vdev.dma_dev = mdev->device;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
 	if (err)
-		goto err_mtu;
+		goto err_mpfs;
 
 	err = alloc_resources(ndev);
 	if (err)
@@ -2009,6 +2023,9 @@ err_reg:
 	free_resources(ndev);
 err_res:
 	mlx5_vdpa_free_resources(&ndev->mvdev);
+err_mpfs:
+	if (!is_zero_ether_addr(config->mac))
+		mlx5_mpfs_del_mac(pfmdev, config->mac);
 err_mtu:
 	mutex_destroy(&ndev->reslock);
 	put_device(&mvdev->vdev.dev);
--- /dev/null
+++ b/include/linux/mlx5/mpfs.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+ * Copyright (c) 2021 Mellanox Technologies Ltd.
+ */
+
+#ifndef _MLX5_MPFS_
+#define _MLX5_MPFS_
+
+struct mlx5_core_dev;
+
+#ifdef CONFIG_MLX5_MPFS
+int  mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac);
+int  mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac);
+#else /* #ifndef CONFIG_MLX5_MPFS */
+static inline int  mlx5_mpfs_add_mac(struct mlx5_core_dev *dev, u8 *mac) { return 0; }
+static inline int  mlx5_mpfs_del_mac(struct mlx5_core_dev *dev, u8 *mac) { return 0; }
+#endif
+
+#endif


Patches currently in stable-queue which might be from elic@nvidia.com are

queue-5.10/net-vdpa-mlx5-configure-interface-mac-into-mpfs-l2-table.patch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
