Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F08AC433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1316E60EFE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1316E60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8219608BB;
	Tue, 26 Oct 2021 04:03:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wCyZn-d2ZaG2; Tue, 26 Oct 2021 04:03:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5521F608C1;
	Tue, 26 Oct 2021 04:03:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDFDFC000E;
	Tue, 26 Oct 2021 04:03:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B994C0039
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EC2181011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Omvp6nIWcINM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8381D80F7B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmFUkAx6f+zKtEnLJWUUb6Cd1cOY+OeG2j8wCRTjA5RNo4i5qVy9gIvozO8d7iZUOpb7VdlFNIX8JABY0z3MVtT3ZoZXGHjpNILt92M7L2lpPRxa0cCNBTRuVSI+NVltz2ZrvpAOnkZW+XbC5gNY+FJeuxRIzek7+jn2gWpYkEV8z3rDrt/cEGO59PD3xM0dso57j8XnSbkXV0cZcmRFTaKSbJbzKY5QTvAFiKj+6yf8aQQixOr+jBQjvqQeVuJ34aZ/ETiu+p/3FGV/GoS87Miw1vZhs5SoGdAC9ivKHVR0d/IsrvbiBM1dcc8711vHxAVjXxQZ/dQogcRsPPcg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlBxR+BYSj/HJlYjC6gWEkAX0U27nZbF726scjYM+5Y=;
 b=GAjyIstU7i72VHHRwaJGQw97NyDmNKF7ca0WF2yP9mUMBiyJRz+Eo1fHxf2g83bG3g+in8ea5KSQwIuve1+7unNT44JFRROaaAVqZLLjQaVOvQ5lDnkLbANJyUGJ/mcF/Cy7OKUmT75qGWDbj2CzoUd9pP6mBIbiUgoFKSFng4FFAQiK/Q5dcf63IBMcXym423TdgU5caIBU1ppd69xnmekckDJmquJNEw9xE3A3QVNhARMC+QR5M0ECSK276EZEiPTciH2G7nGhwLakcB85b2WG5JREIKmgW5wP5o6tvLIniqfsGKS1IUhCXJ7tyBT1u9XTj4JR5qwzwp+EK0n/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlBxR+BYSj/HJlYjC6gWEkAX0U27nZbF726scjYM+5Y=;
 b=HCaGEC+DRwn0aNJnIVcHxTZF68xjJrL5f1fvkwUb/dpRl7QSdEzg0KG/oEGa4fwoaxxIRa6lpmMCQapy595FgUliJ2i3Vqrj+l+jYHAyPAhsZqbP6Jfy9SLRQDoaaCNxhoZvmDy1Z9VEyHv3d+qeczxilbCvlH3JcBsgDNPe6MbbKf67DFMg6ESdaQrqmeFLDiECG8uZT+l1BnaQfI2VUuL0EGIB6ZVYV+7H1bGeXvMWr31lRykrcjJ9AXjC2kEVORnqldoQcHFZ/QvLCSzEC/cue9tUYPnX9qVWTvoqilUc3zPndLX4Xu0SrV2g/zIs6wtxf6n80qInPrklHdpOxQ==
Received: from MWHPR2201CA0048.namprd22.prod.outlook.com
 (2603:10b6:301:16::22) by CY4PR12MB1173.namprd12.prod.outlook.com
 (2603:10b6:903:41::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 04:03:09 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::d5) by MWHPR2201CA0048.outlook.office365.com
 (2603:10b6:301:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 04:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 04:03:08 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 04:03:01 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v6 8/8] vdpa/mlx5: Forward only packets with
 allowed MAC address
Date: Tue, 26 Oct 2021 07:02:43 +0300
Message-ID: <20211026040243.79005-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026040243.79005-1-parav@nvidia.com>
References: <20211026040243.79005-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e371bf30-470e-495d-dada-08d998358538
X-MS-TrafficTypeDiagnostic: CY4PR12MB1173:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1173B1EC9D994ADC720E5591DC849@CY4PR12MB1173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: br6L8DSVPPrf2aStzsAtqry2PBHGgNVbV2OWGLJeG5Gu0LHGzqrlwUkyRbSl5f1mm/UvDARcD9bdoBFkmb2vsm7wTCD2G6DAERAVU3Hg7GN4OWhake+s6mdGlLcJ20bNd2vamSX+C5Z5iB4d2YclynDobhb0RQB1I+VK7G1XuGbRnLPkljd/PNbPY+vHoOQ6kSiiy9xsXrt1v3mE65NUmfiU7aFpJtEAthVCP4S//cMPovfh0zuei7xXoFwFyGWcG0G60ZVnCcB5ZATaoh3L5B0S4FdLVUP2+lOzYZF8aIhbVXj9vLA4IMRXb65o0a21z37iSHpN77oEgtkNLESB93teeqx6AYMH8jS3kGcg0KF40qxN7tVurgHVOwat0OKB+0iREtndI6Gn1vy63EfnPX7symJR0s+bkoaabYnfkv3h4629RbUWjyD7eqNbl+b2qItQaV5fVFLJF8Z0hhyxVWZfACGl4JJbGBxT5msJBpvT68WIkklvSTu3yaV3qT86YmoHPo5KUcBei+5RRtP05+ychOkwkCw/vXyYOsGT5cvQWs+B3rB2M+e9nlJAz86CJ8L3d0MH+BbdLxpCkPjCdnHtjUVTydDD28fmeSU0VJaOJCxIpUb+b0Ex6gRogC3r+m6ZWXSW4U1ZT69xqlFJsWPcQpQ89Xhf3CTrnFLCVtYBCluO2AXF87aYsTqlsS4HeQxrhTGebUevbkopDuwBeg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(4326008)(107886003)(26005)(47076005)(6666004)(5660300002)(186003)(36756003)(1076003)(82310400003)(16526019)(54906003)(316002)(86362001)(6916009)(336012)(508600001)(2906002)(70586007)(83380400001)(8676002)(2616005)(426003)(356005)(36860700001)(7636003)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:03:08.4350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e371bf30-470e-495d-dada-08d998358538
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1173
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
index cc027499c4d3..9b7d8c721354 100644
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
 	u32 cur_num_vqs;
 	struct notifier_block nb;
@@ -1383,21 +1384,33 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
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
@@ -1405,37 +1418,64 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
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
