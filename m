Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF5C433ED
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8AB611EE
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8AB611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5AE760B99;
	Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4XJ_Sh3h5UV3; Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D548D60B9C;
	Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0EC6C0018;
	Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73A03C0014
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52EED84A4F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xfgSTfTLv2Vt
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C07884A4D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgscaEnAFGGhDUZmZAtLLKGyHcuDe8xhuNzia8rEwdZENtvxPswU8DtHNaNnm3YqlA4ITkMw7Ya9njcLe4s09ED6sTFdMmSmzMkAYnhvtHoRePQZRznK1nyhmB7KJOjjkRkLl/06Zi8RFs9IeCD/u0sUBWyzgQT3pvYS0TosdZQmxL4AJKjA9IN8rTklNCJMip53x9A6XZDfhaXJwuBZU4cE7MTjONNFa/qA50boKg2/oTYodJ/timDFWJ/fGycfMV0tYp/8Oynk5zjdzVeT6PRme56NgwXunzK0Gwl2YSgbPfLE5OIskBJCTz6898F8fmF6B2d6qKq7LuVv6U5rAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBJweLN9mBk09XGy2yvPai8x/D2+TJyEJC+P+LaEU0A=;
 b=gAjawqKxhGlYfhslc/eQelgYhAXLyVs6km9qSnAsqBSyLv8HJhCAZttirP+1AB40rNQzwKrQxVzfEAZG+gRSkoj/46QCiXi1Fxqa+6Xq7HqBsUOsStIiv51VqWi4DhjwFw1OE76QdSgRLHEBvoH1SNsqBcUo8ACrvEQhf44TVy1VrfDQw0L9AETHra83A58Jp5qxrzh86sFkDviMmEXsSYXMp0yViaRxpyDsN468hsgBsbbvoGzTqaFxk6d0xjaMuPV48UUTBtElhwBeSeMLT0Lleso1Wluvjj9sT1Nj/TiWhYk3azBgKz91ilnKCsb32hAkc9AgGhN8gYt/xbn0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBJweLN9mBk09XGy2yvPai8x/D2+TJyEJC+P+LaEU0A=;
 b=TlGkFeH6d1fssSbatRG9BEWZpbmixr0mjSEEtbsv4OVH+Hbfz1ogbza8s4c/loFPII4Za1qfPuLp5asm7EtBfDtXYeOMaMVZwbUEw6Fm3FUSATGBSuKapSgOnb5xqjOhEg7AjzieDl7zQahSrOrvaYXNzUxYPTU4HThsvOmgYjNvnPRKpu7A3pMYPD1SfaikrpACCAlFYbGDR8azX+eB1dspDRaavEeLqOKG3EcWt1pUhXfga4tabbm3evMViDt5nO5Nv2NtkTokNGZOf1ekkxAkxLLeVbvejlJ+3195APgfBplp4A6bvByQIFkNN83MUXvYyxNG758BRSXPIIBZTg==
Received: from MWHPR19CA0049.namprd19.prod.outlook.com (2603:10b6:300:94::11)
 by BN8PR12MB3172.namprd12.prod.outlook.com (2603:10b6:408:68::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 17:05:22 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::13) by MWHPR19CA0049.outlook.office365.com
 (2603:10b6:300:94::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:22 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:19 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 11/14] vdpa/mlx5: Forward only packets with
 allowed MAC address
Date: Tue, 6 Apr 2021 20:04:54 +0300
Message-ID: <20210406170457.98481-12-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de56f960-1847-42b8-2d31-08d8f91e2a03
X-MS-TrafficTypeDiagnostic: BN8PR12MB3172:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3172E6C4981281276A4ADFE9DC769@BN8PR12MB3172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LYVr1KBGi0d27gesPm5bmZWbqqoqdB4SPBvTNDD03p20oRQHtBvStRWHSGOUgSRTagM3echWV1VAfBpb2ljKvEomzlLInqtAJlgSqDNvzNWCKvU4PeTTxT7SGTGeMVb5V8Idc7zF+Vicj38x0V8R3IunlfDmRKdkyNRj3zBGXE3ur4AQzkllC0DmZ9OchOymCkE18oxV/B51NSjgkWEvdJeVfHGeHwi12jlQ/uUc0XLE9ZnHxbii69ZB3tRbaq5r0C2cYXu9h5wq5aMbwNZ8e/NCFhS5tWBJelj4o8zenePIAu/o6qfIOHQA37mTj77RqJV/167k7WP4QLB8q+ZHaod4IOXC62wOofbNPAhLDudFRYi5wRqLf0N7oSsWJnMTHRvGatuZG6mqlBC14DjMm14rNQvBDVcIABLLBJ77KGde4r5/eMeieuTHLfZgWSYqRhVjEMISjGvaFVdFpE/0eBQTJm23N3Nqm6XQONnv2JNErZHKztQZ5zqTJ2YtPGjfbTE2y+Fh7oXmTOJJPphW0vowBG1SoLNf+81F1nNEEZkOIBL63Rv9EdkSg6NCV83+6MrCsQsSssC5/t3+LtQY+gid9TZqeFd7z3KndlGDYzlQ0rg5ypglGlgw3AMJyCh0v4SO1XqcTw0qhbQdAtoFA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(36906005)(6916009)(8676002)(426003)(36756003)(16526019)(7636003)(70206006)(356005)(70586007)(47076005)(316002)(54906003)(6666004)(5660300002)(107886003)(4326008)(26005)(478600001)(83380400001)(36860700001)(82740400003)(1076003)(2616005)(8936002)(186003)(82310400003)(86362001)(2906002)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:22.0972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de56f960-1847-42b8-2d31-08d8f91e2a03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3172
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
index 949084aac102..c342cc9355e8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -147,7 +147,8 @@ struct mlx5_vdpa_net {
 	struct mutex reslock;
 	struct mlx5_flow_table *rxft;
 	struct mlx5_fc *rx_counter;
-	struct mlx5_flow_handle *rx_rule;
+	struct mlx5_flow_handle *rx_rule_ucast;
+	struct mlx5_flow_handle *rx_rule_mcast;
 	bool setup;
 	u16 mtu;
 };
@@ -1294,21 +1295,33 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
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
@@ -1316,37 +1329,64 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
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
 
 static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
