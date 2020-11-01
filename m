Return-Path: <SRS0=FNow=EH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76924C4742C
	for <virtualization@archiver.kernel.org>; Sun,  1 Nov 2020 20:15:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1425122253
	for <virtualization@archiver.kernel.org>; Sun,  1 Nov 2020 20:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="huv9rtKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1425122253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BB55B86BF3;
	Sun,  1 Nov 2020 20:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lkXDJ9r-Hi9v; Sun,  1 Nov 2020 20:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 082D386B22;
	Sun,  1 Nov 2020 20:15:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6B94C088B;
	Sun,  1 Nov 2020 20:15:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A296C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 20:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1DC7F86B2A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 20:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Up7-nGFot9s9
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 20:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7E22C86B22
 for <virtualization@lists.linux-foundation.org>;
 Sun,  1 Nov 2020 20:15:51 +0000 (UTC)
Received: from localhost (host-213-179-129-39.customer.m-online.net
 [213.179.129.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 75F4B208B6;
 Sun,  1 Nov 2020 20:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604261751;
 bh=bLA0ev2Kwh6uGquFheDvSSBq9w7KOIljOSNWPIWB5Ck=;
 h=From:To:Cc:Subject:Date:From;
 b=huv9rtKkUhey6AamSaXCXbtImWrQjVRiNn7errL5az2kng2obK+UpzHMgRoTggLer
 1dBBKOeF5LUNXfpJc8oH/xshEX5x5c1wRB20IYPUR9hZXO1LgTIPCJD8CZWVC6KF0K
 mklVx1CS0NWIH+Tn9mTb693ZRQ9UFxuyrKijadxs=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 gregkh <gregkh@linuxfoundation.org>
Subject: [PATCH mlx5-next v1 00/11] Convert mlx5 to use auxiliary bus
Date: Sun,  1 Nov 2020 22:15:31 +0200
Message-Id: <20201101201542.2027568-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
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

Changelog:
v1:
 * Renamed _mlx5_rescan_driver to be mlx5_rescan_driver_locked like in
   other parts of the mlx5 driver.
 * Renamed MLX5_INTERFACE_PROTOCOL_VDPA to tbe MLX5_INTERFACE_PROTOCOL_VNET as
   a preparation to coming series from Eli C.
 * Some small naming renames in mlx5_vdpa.
 * Refactored adev index code to make Parav's SF series to apply more easily.
 * Fixed devlink reload bug that caused to lost TCP connection.
v0:
https://lore.kernel.org/lkml/20201026111849.1035786-1-leon@kernel.org/

--------------------------------------------------------------

Hi,

This patch set converts mlx5 driver to use auxiliary bus [1].

In this series, we are connecting three subsystems (VDPA, netdev and
RDMA) through mlx5_core PCI driver. That driver is responsible to create
proper devices based on supported firmware.

First four patches are preparitions and fixes that were spotted during
code development, rest is the conversion itself.

Thanks

[1]
https://lore.kernel.org/lkml/20201023003338.1285642-1-david.m.ertman@intel.com

Leon Romanovsky (11):
  net/mlx5: Don't skip vport check
  net/mlx5: Properly convey driver version to firmware
  net/mlx5_core: Clean driver version and name
  vdpa/mlx5: Make hardware definitions visible to all mlx5 devices
  net/mlx5: Register mlx5 devices to auxiliary virtual bus
  vdpa/mlx5: Connect mlx5_vdpa to auxiliary bus
  net/mlx5e: Connect ethernet part to auxiliary bus
  RDMA/mlx5: Convert mlx5_ib to use auxiliary bus
  net/mlx5: Delete custom device management logic
  net/mlx5: Simplify eswitch mode check
  RDMA/mlx5: Remove IB representors dead code

 drivers/infiniband/hw/mlx5/counters.c         |   7 -
 drivers/infiniband/hw/mlx5/ib_rep.c           | 113 ++--
 drivers/infiniband/hw/mlx5/ib_rep.h           |  45 +-
 drivers/infiniband/hw/mlx5/main.c             | 148 +++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   4 +-
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 567 ++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   4 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 135 ++---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  42 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   8 +-
 .../mellanox/mlx5/core/esw/devlink_port.c     |   2 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  28 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   6 +
 .../mellanox/mlx5/core/ipoib/ethtool.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag.c |  58 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  50 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  33 +-
 drivers/vdpa/mlx5/Makefile                    |   2 +-
 drivers/vdpa/mlx5/net/main.c                  |  76 ---
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |  53 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.h             |  24 -
 include/linux/mlx5/driver.h                   |  34 +-
 include/linux/mlx5/eswitch.h                  |   8 +-
 .../linux/mlx5/mlx5_ifc_vdpa.h                |   6 +-
 27 files changed, 818 insertions(+), 648 deletions(-)
 delete mode 100644 drivers/vdpa/mlx5/net/main.c
 delete mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
 rename drivers/vdpa/mlx5/core/mlx5_vdpa_ifc.h => include/linux/mlx5/mlx5_ifc_vdpa.h (97%)

--
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
