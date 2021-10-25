Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BAC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E2B60F9B
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98E2B60F9B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73A334038C;
	Mon, 25 Oct 2021 12:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXLxuzE1B-Rf; Mon, 25 Oct 2021 12:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6FA96402A2;
	Mon, 25 Oct 2021 12:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 496ECC0019;
	Mon, 25 Oct 2021 12:53:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDEECC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA770403F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kCb_6eqHvJWc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::600])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0D9C40283
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwtrjcku+ARRT61ZIFbdZgEpgpetjZ/0Lm0xNjRh3CP2YP5gNCA7ynh5ZFc6D0zH9ieztVlhOteivEhkIvtby1A3bKSYuT7pd4SmFe0nRVD6eCQBF4Yuse/+e34cOCoNhjWc+N5UCs/ds2jN7Fp85qvRj0Vlu+N+TRjJHnZQfhWuwBZCj5FOnaJ1jTlxXZXb2j5SMBS10ojlbV+cbSZcTKPsSQp0egqnQo+M3BFRJKPk6vN2T8RAhydpl2i6Yh5V8AVclNiiRzfqzK3du1aahmDoL0W2gfofvgO08nDAxGsJ/RBQhA329V5WUiTfiF1rAQW965AYbXO/+nLUrhuZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6QfwbxDV2M9itl84VQtwWgAyRrBFY0IfH8I8IV4kCc=;
 b=PxO/p+2rIn6tdRcw/PczaCirn5vtgDs7WE3CqK+/zqG6SKVGAuj+zWmuyuwUhObZTCWHbGprOZeR327NyIrV1BmJzLnWS0mBUu4N5+HlFFt5FynUrKg/CBrUAqIKRAvDQEmo5NhNLFPKXJomXHkWSbtrWKxZWZesep/PmrRqAxLotlmps7eiVbSowTgu9lXXi9/iAGAZgvx1hQEhZf9pkB1i4rUyEXY9HOBlRAXzJyyZKSfw/uOcd6h//1m9rUl2AJeFgfyurNB1utyxpIROxBRGs4Bi0NKlwwC71aiBkgcsncNWAPYKZCkilN7Nw4D48SCwJouK9M9gAXl51Avd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6QfwbxDV2M9itl84VQtwWgAyRrBFY0IfH8I8IV4kCc=;
 b=QnFf1SMeHDIIHacy1vjq4Iej4XIeq+L1l6Kv1odtSm8yv/IgdHS1yV6GfWjcTPQbExNJkuTe1SqhUNtFALbFoK+DtgoCVAS1H4KW4T2XZqJvc7CZ/RtJfpTiPdYA3AKy0oZgq6EGibClniz7yDRlcbuLthKO8osubJMS3bPE0DpW++Mge6q/Q6DCwC0ynzu2PlxzH/Ww7Ak+4OImRAo3hcgP7tYdSdE1zjluepX1XsajuRsNleRA5EhKRpmyYNK995Nt0N7stjhlBizJbg4/oiUMWFXol5yscT/5Y1QK4olYu2JjoYD3zgco1AqvF7lI5KMr6YGrIxLi7J3H0uZdow==
Received: from MWHPR1701CA0008.namprd17.prod.outlook.com
 (2603:10b6:301:14::18) by MWHPR12MB1856.namprd12.prod.outlook.com
 (2603:10b6:300:108::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 12:53:42 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::66) by MWHPR1701CA0008.outlook.office365.com
 (2603:10b6:301:14::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Mon, 25 Oct 2021 12:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 12:53:41 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 25 Oct 2021 12:53:34 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v5 8/8] vdpa/mlx5: Forward only packets with
 allowed MAC address
Date: Mon, 25 Oct 2021 15:53:16 +0300
Message-ID: <20211025125316.67664-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025125316.67664-1-parav@nvidia.com>
References: <20211025125316.67664-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d58d2587-5a92-44bc-fa6c-08d997b67918
X-MS-TrafficTypeDiagnostic: MWHPR12MB1856:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18564B19FB957CB7424C0057DC839@MWHPR12MB1856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuZ2Pgvjhf4iWLqoSP0NA4aaqZMXKUygLFGrtT5Z7x74HqFLd30JsA6BZzX9QB5Yz/2sbbnIKKpgmNnwgXpTF8BljLaR5Bph/Nx5jhcRdUp1+iKCbHabj1275yj2WeuKSFhJsQTk2VwhsTP4BIGNyvcQ3Sc9sPKuP0KaFGfjtojuNwyvPauTNMRPC5VQn1ebahcNwj8SiwP411aSW9OPlSSPQTMnbSDyPEq4Qsvrw9vySo26LFlK9vbdo53d45q0I/OqF0djJr6G89dorEwNN+sQdGgU+0NyH1fC+HFMDZBWePLMRSEEvx7iQHgn07RA815+RxeybKv8ubMk5SJebt7B2aRzFn87wEbscuA0zrh3KRyZXLW+JPp0tir7SUuJkw9n4KnLaid77tzeTQp3o8ofMytIrDAyB8+Hqi+bSpSzCUK9u9iTef+Tjn7EyIos+05TE9mr11DwKyC8oKnWZngnBWCqN0tsFKKQwJ/7slPwwcfenfrsohzFAia49mtlElcJdQKRc2YciOXh0JkvicGa4OMm3Itjb32kLs5o2eZqOQO4C+EbLHy/3vrStlFD6Zj2Dpq560TQWC2Ch4feKLiZTnRaEQRO2NvKyZIe1eqzhihyptJOlTE0KP/12b4XFqIn9a23yjVe2pPwaWWMGWodP0U7QSY02IH4NbEW9aM6LU6FBcFSVyIzKlF5J2kKbYKiQvyC35t0yIZ7SilcgQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(83380400001)(316002)(70586007)(26005)(8936002)(356005)(6916009)(2906002)(82310400003)(6666004)(36906005)(54906003)(508600001)(16526019)(70206006)(8676002)(2616005)(5660300002)(1076003)(47076005)(7636003)(336012)(86362001)(107886003)(36756003)(4326008)(426003)(36860700001)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:53:41.9588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d58d2587-5a92-44bc-fa6c-08d997b67918
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1856
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
index 860d80efa5d1..fb06c69c79db 100644
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
