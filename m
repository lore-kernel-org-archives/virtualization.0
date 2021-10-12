Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AF8C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 10:26:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36D9610C7
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 10:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C36D9610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F3D8404B1;
	Tue, 12 Oct 2021 10:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5v7Iv4N6pplf; Tue, 12 Oct 2021 10:26:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 30251405DA;
	Tue, 12 Oct 2021 10:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 077A0C000F;
	Tue, 12 Oct 2021 10:26:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CBF2C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 008CD405DA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id snqAgTltW32P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:26:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4048404B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 10:26:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B41456101D;
 Tue, 12 Oct 2021 10:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634034400;
 bh=x150KESnW9y0NudUm0jVtADK6sh5MfPdAVLfbM/aWiY=;
 h=From:To:Cc:Subject:Date:From;
 b=LiGUI+8YNYfkLbwdBY8u/p79Jm/iQPdqUK5IhZv7LExcrQ6ATXfHT5iAAtYSGWynz
 kr5ND/0mGrvuK7ubilEw7i7aWoIVqsi7o4xaIrdCU77mwUCR+oVk55gGD5bpoX8l9Y
 PZqg3hvu0olFH0tKpScGwY9n7t1Fqn79fnOrK4He4wVzv+4ufyKy41khjlRq0SfhkA
 kv+PDlLFYDBOHqHT3XXL41SpY8S43G6B64yNy9uHy011iqU3YGD847SqJfaLHTbazb
 GKWW3k/5YOiTrGg3qK9ceGiJ77L0BTkrr2T4xXJnaPz3IsbjHrJANZZbIyzgoOcIqv
 5wIz1HDYSIOQA==
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH mlx5-next 0/7] Clean MR key use across mlx5_* modules
Date: Tue, 12 Oct 2021 13:26:28 +0300
Message-Id: <cover.1634033956.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
 Maor Gottlieb <maorg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Shay Drory <shayd@nvidia.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
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

Hi,

This is cleanup series of mlx5_* MR mkey management.

Thanks

Aharon Landau (7):
  RDMA/mlx5: Don't set esc_size in user mr
  RDMA/mlx5: Remove iova from struct mlx5_core_mkey
  RDMA/mlx5: Remove size from struct mlx5_core_mkey
  RDMA/mlx5: Remove pd from struct mlx5_core_mkey
  RDMA/mlx5: Replace struct mlx5_core_mkey by u32 key
  RDMA/mlx5: Move struct mlx5_core_mkey to mlx5_ib
  RDMA/mlx5: Attach ndescs to mlx5_ib_mkey

 drivers/infiniband/hw/mlx5/devx.c             | 13 +--
 drivers/infiniband/hw/mlx5/devx.h             |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          | 31 ++++---
 drivers/infiniband/hw/mlx5/mr.c               | 82 +++++++++----------
 drivers/infiniband/hw/mlx5/odp.c              | 38 +++------
 drivers/infiniband/hw/mlx5/wr.c               | 10 +--
 .../mellanox/mlx5/core/diag/fw_tracer.c       |  6 +-
 .../mellanox/mlx5/core/diag/fw_tracer.h       |  2 +-
 .../mellanox/mlx5/core/diag/rsc_dump.c        | 10 +--
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |  2 +-
 .../ethernet/mellanox/mlx5/core/en_common.c   |  6 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 13 ++-
 .../ethernet/mellanox/mlx5/core/fpga/conn.c   | 10 +--
 .../ethernet/mellanox/mlx5/core/fpga/core.h   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/mr.c  | 27 +++---
 .../mellanox/mlx5/core/steering/dr_icm_pool.c | 10 +--
 .../mellanox/mlx5/core/steering/dr_send.c     | 11 ++-
 .../mellanox/mlx5/core/steering/dr_types.h    |  2 +-
 drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  8 +-
 drivers/vdpa/mlx5/core/mr.c                   |  8 +-
 drivers/vdpa/mlx5/core/resources.c            | 13 +--
 drivers/vdpa/mlx5/net/mlx5_vnet.c             |  2 +-
 include/linux/mlx5/driver.h                   | 30 ++-----
 25 files changed, 147 insertions(+), 195 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
