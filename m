Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015E9C433FE
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF61461507
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF61461507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CED683CC9;
	Thu, 21 Oct 2021 16:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imG6Gg-MwUTo; Thu, 21 Oct 2021 16:35:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16077832C9;
	Thu, 21 Oct 2021 16:35:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7FD7C0033;
	Thu, 21 Oct 2021 16:35:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 894C6C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68EE660F3B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zGReZjnkhOBo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B2A060F2B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGTLnu+fMKD/u4y6ib0UJcifzEmABk2kAIRpQ5DSu9BcqM4njhoc6BTGpyK/EBSwSxlbVb3XXcfONaF+qPgWZDEhTiiVH5W1pdr1Mi2qYT+A9GevHpDSuavEiABtVseuXp2tdyTyGwZf/GMp56XFg+/r8runErkqe3U6OUd0b9eKLXlMNPpUK+4KgnwJUt5p4owxnPN7kUQyT3Pdt6MQiPT+xFHO1VmHcfAlvYirRHzKahqsHpKQm4xh5eRNgtIy969Oq2QNu1ceU+0HHRQzK9rY5x3dI+aWzamQP81jqahazKC3bUTQDvoPjA1hkSdlCq7mlqFo7LiMHQFSPYoo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8sUWZpWD0BC/aWuzO1oBJsJ69EBhHM7jMg4BRcYs74=;
 b=nCTgDC+9Z0YBi/StsHs6+j21pd9LA8sCb061UP+RO2YDDd8ecpDpJeX+dLkDxb6POHpZVhDy+3RZ2iS5cBINWiK3emSuSBa3y6yh7HuCBSSdlEwn/y0MIKSFUWRpCQIWVU0hZK34HF5fYCMoXAa+/XqrZ6ydas8eonYOIMyxOYo9V0JEq0FJIynzobgQ3cg6GdU0RqX696z1dP6YSCagkFG/TC681LAthTo9nRr81npBkq5Tge9P+Xel/ca7i647ZIGH1jfnX/ThjgvLuQuobXC2uISxab6+FNcRc2kS51OqcDplPwfbQ5dGqamxgslwsywYgbVMcLbsB/MluZNC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8sUWZpWD0BC/aWuzO1oBJsJ69EBhHM7jMg4BRcYs74=;
 b=okwZaC9jLnS0zLgr/UfRz42GNVzN+Ap3XMnsDDtpSWcZgLS3Ul6v1hnzRhUbwUgp7FmocWCxaQ5zdQRNF9Ap+hJcsgHkuGRYhc2gy1FxB8gIlhZKnaUCB+Dq5b6FDl6FxFSh2RY96nRIx04XgEcE5/ANz3pRW3Y/LX763Sv+tuqF240beL316uomg7HmkI+5uapw53R243D5NxDAlhpl6lDaaZstoHdSFgEgMCPTcjD0a+GNfrBAJ4IVnaNhk7MnF7jwYFy9s75kngmsARTE9Tezr9J3XU+ZkK1nfMptejaSY/KmtkT96ZFm8Zrga6mJr8RsxndxR7aAhQS4op3p8Q==
Received: from CO2PR06CA0056.namprd06.prod.outlook.com (2603:10b6:104:3::14)
 by CH0PR12MB5220.namprd12.prod.outlook.com (2603:10b6:610:d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 16:35:44 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::f3) by CO2PR06CA0056.outlook.office365.com
 (2603:10b6:104:3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 16:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:35:39 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 21 Oct 2021 16:35:26 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v4 8/8] vdpa/mlx5: Forward only packets with
 allowed MAC address
Date: Thu, 21 Oct 2021 19:35:09 +0300
Message-ID: <20211021163509.6978-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211021163509.6978-1-parav@nvidia.com>
References: <20211021163509.6978-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb9a7e0-62c8-468c-7d0e-08d994b0d278
X-MS-TrafficTypeDiagnostic: CH0PR12MB5220:
X-Microsoft-Antispam-PRVS: <CH0PR12MB52205D69EB132BDB536A3F91DCBF9@CH0PR12MB5220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12RQe7JObzy0YZWgOqKAbOhO+2o4gC2xx3rJ3U2lQFVgoJ9vSTFhMYR8J4hpW0+EX9jcIq/EP1LRGP0HLCNdBMwtKO2dac6Fycc78fO5GvvL0VEZPQ7y1I0Bm0wgz2s2G+7AeJoseUOajD0Q2bq0L6J7ukYa1Dk2J0e8vv/r4byOddZZ/72ENwBaJ6KPGgnLts00zuFczqW++OEp03i2gh0dGr85HLnh2pnkHn99Q3akXH19wraivaptEy6bO31FKNraB8yDwPtWtHlSzJ374Oprrwyk5Br9KASObkfHYpcLRy5S//FlPPZ7zcGEdGATgwVQFXvq9hqC6g+5qMoY8qqnHVXgxcW2Dy3xRRFP2/5z5o9Que3GN05JHNbn5go2ubdTHKH6hkDbHvTO5+5F4IZNybiEJRNw9BqCpMoGNrKdO6ex0iSN2082ZDce3tXrj+M2qEDsQVQh9L/hWM8d/IlH2b2xfpzx9980MtrLqcGBlu9fSEEIZZeIm4JRn8QyKs/an170J2+gf4tpiFWDebw3SJWcllc6Akxu1itMDivTk73ew0gZqyFTtAHFD/ln2G1Q/GSyEfypOR5OYUUnOFmeIaa8av8tWgr8Z9YnsShpK1nMYU0364JTBgpDMXEjN8MhsqNXd8ZP8GUnMJvqStKiqp0CxAuG4gCT124jdOUoPpHR1a5HYPSQCdqnOgm+8wWLV+Is0eR+Yc39IvFK2g==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(107886003)(54906003)(36860700001)(4326008)(186003)(508600001)(47076005)(1076003)(356005)(5660300002)(16526019)(7636003)(2906002)(316002)(426003)(86362001)(2616005)(70206006)(70586007)(82310400003)(8676002)(83380400001)(26005)(8936002)(36756003)(336012)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:39.8342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb9a7e0-62c8-468c-7d0e-08d994b0d278
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5220
Cc: elic@nvidia.com, mst@redhat.com
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
From: Parav Pandit via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Eli Cohen <elic@nvidia.com>

Add rules to forward packets to the net device's TIR only if the
destination MAC is equal to the configured MAC. This is required to
prevent the netdevice from receiving traffic not destined to its
configured MAC.

Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 76 +++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 61f17ce0892e..e15c7f639490 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -158,7 +158,8 @@ struct mlx5_vdpa_net {
 	struct mutex reslock;
 	struct mlx5_flow_table *rxft;
 	struct mlx5_fc *rx_counter;
-	struct mlx5_flow_handle *rx_rule;
+	struct mlx5_flow_handle *rx_rule_ucast;
+	struct mlx5_flow_handle *rx_rule_mcast;
 	bool setup;
 	u16 mtu;
 	u32 cur_num_vqs;
@@ -1382,21 +1383,33 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_namespace *ns;
+	struct mlx5_flow_spec *spec;
+	void *headers_c;
+	void *headers_v;
+	u8 *dmac_c;
+	u8 *dmac_v;
 	int err;
 
-	/* for now, one entry, match all, forward to tir */
-	ft_attr.max_fte = 1;
-	ft_attr.autogroup.max_num_groups = 1;
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
+	ft_attr.max_fte = 2;
+	ft_attr.autogroup.max_num_groups = 2;
 
 	ns = mlx5_get_flow_namespace(ndev->mvdev.mdev, MLX5_FLOW_NAMESPACE_BYPASS);
 	if (!ns) {
-		mlx5_vdpa_warn(&ndev->mvdev, "get flow namespace\n");
-		return -EOPNOTSUPP;
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to get flow namespace\n");
+		err = -EOPNOTSUPP;
+		goto err_ns;
 	}
 
 	ndev->rxft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
-	if (IS_ERR(ndev->rxft))
-		return PTR_ERR(ndev->rxft);
+	if (IS_ERR(ndev->rxft)) {
+		err = PTR_ERR(ndev->rxft);
+		goto err_ns;
+	}
 
 	ndev->rx_counter = mlx5_fc_create(ndev->mvdev.mdev, false);
 	if (IS_ERR(ndev->rx_counter)) {
@@ -1404,37 +1417,64 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 		goto err_fc;
 	}
 
+	headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
+	dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
+	memset(dmac_c, 0xff, ETH_ALEN);
+	headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
+	dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
+	ether_addr_copy(dmac_v, ndev->config.mac);
+
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST | MLX5_FLOW_CONTEXT_ACTION_COUNT;
 	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 	dest[0].tir_num = ndev->res.tirn;
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
 	dest[1].counter_id = mlx5_fc_id(ndev->rx_counter);
-	ndev->rx_rule = mlx5_add_flow_rules(ndev->rxft, NULL, &flow_act, dest, 2);
-	if (IS_ERR(ndev->rx_rule)) {
-		err = PTR_ERR(ndev->rx_rule);
-		ndev->rx_rule = NULL;
-		goto err_rule;
+	ndev->rx_rule_ucast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dest, 2);
+
+	if (IS_ERR(ndev->rx_rule_ucast)) {
+		err = PTR_ERR(ndev->rx_rule_ucast);
+		ndev->rx_rule_ucast = NULL;
+		goto err_rule_ucast;
+	}
+
+	memset(dmac_c, 0, ETH_ALEN);
+	memset(dmac_v, 0, ETH_ALEN);
+	dmac_c[0] = 1;
+	dmac_v[0] = 1;
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	ndev->rx_rule_mcast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, dest, 1);
+	if (IS_ERR(ndev->rx_rule_mcast)) {
+		err = PTR_ERR(ndev->rx_rule_mcast);
+		ndev->rx_rule_mcast = NULL;
+		goto err_rule_mcast;
 	}
 
+	kvfree(spec);
 	return 0;
 
-err_rule:
+err_rule_mcast:
+	mlx5_del_flow_rules(ndev->rx_rule_ucast);
+	ndev->rx_rule_ucast = NULL;
+err_rule_ucast:
 	mlx5_fc_destroy(ndev->mvdev.mdev, ndev->rx_counter);
 err_fc:
 	mlx5_destroy_flow_table(ndev->rxft);
+err_ns:
+	kvfree(spec);
 	return err;
 }
 
 static void remove_fwd_to_tir(struct mlx5_vdpa_net *ndev)
 {
-	if (!ndev->rx_rule)
+	if (!ndev->rx_rule_ucast)
 		return;
 
-	mlx5_del_flow_rules(ndev->rx_rule);
+	mlx5_del_flow_rules(ndev->rx_rule_mcast);
+	ndev->rx_rule_mcast = NULL;
+	mlx5_del_flow_rules(ndev->rx_rule_ucast);
+	ndev->rx_rule_ucast = NULL;
 	mlx5_fc_destroy(ndev->mvdev.mdev, ndev->rx_counter);
 	mlx5_destroy_flow_table(ndev->rxft);
-
-	ndev->rx_rule = NULL;
 }
 
 static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
