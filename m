Return-Path: <SRS0=RIAz=EB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A0C2D0A3
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 11:19:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658AF22284
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 11:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZmwVYsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658AF22284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F088586092;
	Mon, 26 Oct 2020 11:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o-MYM2Q57aPV; Mon, 26 Oct 2020 11:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DBDE485B5D;
	Mon, 26 Oct 2020 11:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C588EC1AD7;
	Mon, 26 Oct 2020 11:19:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE4BC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 11:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5EE58860C1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 11:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y0iaoEJM5WM9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 11:19:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CA39B8605E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 11:19:04 +0000 (UTC)
Received: from localhost (unknown [213.57.247.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7FE9222265;
 Mon, 26 Oct 2020 11:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603711144;
 bh=I3M3alcIz9H62nKqMPZr4skNCtxKtg9JX4DaomofIPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kZmwVYsb0PMiAitTOnAk+gQSFVNOxKPj2csjRMtKacaCDngsES89hD6KjGYNNu8r/
 qtV/qagdBdnzSXq4Fpy5jsJ20gp9qMk0bw4HuMrj+MIll3ZGWxW1pEX8rUZhhN7jd/
 TVM+awtVZp95gyCNFzxACE7/VNRI79n6K5+gb69A=
From: Leon Romanovsky <leon@kernel.org>
To: Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH mlx5-next 01/11] net/mlx5: Don't skip vport check
Date: Mon, 26 Oct 2020 13:18:39 +0200
Message-Id: <20201026111849.1035786-2-leon@kernel.org>
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

Users of mlx5_eswitch_get_vport() are required to check return value
prior to passing mlx5_vport further. Fix all the places to do not skip
that check.

Fixes: c7eddc6092b4 ("net/mlx5: E-switch, Move devlink eswitch ports closer to eswitch")
Fixes: 5d9986a3947a ("net/mlx5: E-Switch, Fix the check of legal vport")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          | 7 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index ffff11baa3d0..88688b84513b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -120,5 +120,5 @@ struct devlink_port *mlx5_esw_offloads_devlink_port(struct mlx5_eswitch *esw, u1
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	return vport->dl_port;
+	return IS_ERR(vport) ? ERR_CAST(vport) : vport->dl_port;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 6e6a9a563992..2e14bf238588 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1142,6 +1142,9 @@ int mlx5_esw_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num,
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
 	MLX5_SET(scheduling_context, ctx, max_average_bw, rate_mbps);

 	return mlx5_modify_scheduling_element_cmd(esw->dev,
@@ -1276,6 +1279,8 @@ static int esw_enable_vport(struct mlx5_eswitch *esw, u16 vport_num,
 	int ret;

 	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);

 	mutex_lock(&esw->state_lock);
 	WARN_ON(vport->enabled);
@@ -1311,6 +1316,8 @@ static void esw_disable_vport(struct mlx5_eswitch *esw, u16 vport_num)
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, vport_num);
+	if (IS_ERR(vport))
+		return;

 	mutex_lock(&esw->state_lock);
 	if (!vport->enabled)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index c9c2962ad49f..429dc613530b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2159,6 +2159,9 @@ static int esw_create_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+	if (IS_ERR(vport))
+		return PTR_ERR(vport);
+
 	return esw_vport_create_offloads_acl_tables(esw, vport);
 }

@@ -2167,6 +2170,9 @@ static void esw_destroy_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
 	struct mlx5_vport *vport;

 	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+	if (IS_ERR(vport))
+		return;
+
 	esw_vport_destroy_offloads_acl_tables(esw, vport);
 }

--
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
