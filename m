Return-Path: <SRS0=FNow=EH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D1CC4742C
	for <virtualization@archiver.kernel.org>; Sun,  1 Nov 2020 20:16:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A83521556
	for <virtualization@archiver.kernel.org>; Sun,  1 Nov 2020 20:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZLdKkma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A83521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3098A8781F;
	Sun,  1 Nov 2020 20:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bECRkwJoVM8q; Sun,  1 Nov 2020 20:16:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A058287811;
	Sun,  1 Nov 2020 20:16:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A7D5C088B;
	Sun,  1 Nov 2020 20:16:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 378C6C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 20:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 265F1872FF
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 20:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGCbsOl7SacU
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 20:16:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A5BE6872CB
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 20:16:00 +0000 (UTC)
Received: from localhost (host-213-179-129-39.customer.m-online.net
 [213.179.129.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C9EFE21527;
 Sun,  1 Nov 2020 20:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604261760;
 bh=82mzLcsfZ3S5B5q/81xAXJUgqhFrk8AhGLZ3FiZPDFQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bZLdKkmaw4RwWW3u7h0CAfcpdRvLyCYwBkGa8PDgnS8bBe3f/zHRSDMOIIcmB1l3R
 hNCXOJzCPwIxLoo0CuAz6jb9P1LIoqRVCRlQacz9Gq1rVxy127Q5rF6cmefPp32GOp
 zaoA3r2c5MixfYtgczplMzH1XbN2uIz9VsAv+WzI=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 gregkh <gregkh@linuxfoundation.org>
Subject: [PATCH mlx5-next v1 04/11] vdpa/mlx5: Make hardware definitions
 visible to all mlx5 devices
Date: Sun,  1 Nov 2020 22:15:35 +0200
Message-Id: <20201101201542.2027568-5-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101201542.2027568-1-leon@kernel.org>
References: <20201101201542.2027568-1-leon@kernel.org>
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

Move mlx5_vdpa IFC header file to the general include folder, so
mlx5_core will be able to reuse it to check if VDPA is supported
prior to creating an auxiliary device.

As part of this move, update the header file name to mlx5 general
naming scheme.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/vdpa/mlx5/net/main.c                                | 2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                           | 2 +-
 .../mlx5_vdpa_ifc.h => include/linux/mlx5/mlx5_ifc_vdpa.h   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h => include/linux/mlx5/mlx5_ifc_vdpa.h (97%)

diff --git a/drivers/vdpa/mlx5/net/main.c b/drivers/vdpa/mlx5/net/main.c
index 838cd98386ff..4dd3f00f2306 100644
--- a/drivers/vdpa/mlx5/net/main.c
+++ b/drivers/vdpa/mlx5/net/main.c
@@ -4,7 +4,7 @@
 #include <linux/module.h>
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/device.h>
-#include "mlx5_vdpa_ifc.h"
+#include <linux/mlx5/mlx5_ifc_vdpa.h>
 #include "mlx5_vnet.h"

 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1fa6fcac8299..6c218b47b9f1 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -9,8 +9,8 @@
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/device.h>
+#include <linux/mlx5/mlx5_ifc_vdpa.h>
 #include "mlx5_vnet.h"
-#include "mlx5_vdpa_ifc.h"
 #include "mlx5_vdpa.h"

 #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h b/include/linux/mlx5/mlx5_ifc_vdpa.h
similarity index 97%
rename from drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
rename to include/linux/mlx5/mlx5_ifc_vdpa.h
index f6f57a29b38e..97784098a992 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2020 Mellanox Technologies Ltd. */

-#ifndef __MLX5_VDPA_IFC_H_
-#define __MLX5_VDPA_IFC_H_
+#ifndef __MLX5_IFC_VDPA_H_
+#define __MLX5_IFC_VDPA_H_

 #include <linux/mlx5/mlx5_ifc.h>

@@ -165,4 +165,4 @@ struct mlx5_ifc_modify_virtio_net_q_out_bits {
 	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
 };

-#endif /* __MLX5_VDPA_IFC_H_ */
+#endif /* __MLX5_IFC_VDPA_H_ */
--
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
