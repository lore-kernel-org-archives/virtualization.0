Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900AC48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF016128B
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 19:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF016128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F6F060BE8;
	Wed, 16 Jun 2021 19:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88PnGJGeWh0b; Wed, 16 Jun 2021 19:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5E0CE60BD6;
	Wed, 16 Jun 2021 19:12:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38CAEC0025;
	Wed, 16 Jun 2021 19:12:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21C58C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A30B4021B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LHW2l7bA4XXy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::601])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 600DF404EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 19:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOtAVKu3c1fSn6g70JG1pTk/uFRmvS8tq5FQIxdDj/LGMA+zLyflQlYcUviwb5G5He/ntYdWaGIQDksHm4GuoTxqOL00s03NI/DKBogeOPTAzslQkiq4WrUF3dd4Aogp3NHWbLQTRfge6foSZwopfdgjbvVYsqze7IdCmLKoPTpmmeXuMGF+svb3PvbhKTCRe03BT4CzBXY14hYyB58CMkG35COVevfRffrPpwGeiJH1Qa6F+RfbYtBBHTqRVr5bf0nf5AFm0OfV4QNI44jHU935+Rl2nMMHrVTrDLruwID/wAnh6A8tAYbsUFB7qCI9VFFyqRbxnRJhm3NxFQFVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8skW/ZNYMAFFfD4Bt65lhr2jB9ddxODj6yDVkCVtlg=;
 b=BZYpOgO9LYBTnNkfQ+fgDdGhllTAzPCyhnVcMaKK63ZQ+1RfaS/RKjCT1iL33ud99SIaLx+yr3AKVZYl5qP2DVCWotPHMJSRummwmzz7K1HKxnt2B7wnkZoczKAnSnZ3Ik7YWCEK3dlKqZ38VpYYjtcsfvfFIqCz3ARgUah9DtSsrQzk+hDo5F0uMt/uuJSGXaKg3z9pHDGdOoelmXqflJ2wSQAoWQurG2SXsorElLzfJsI22HIt0wzPKBG1kKjzgU0ofhPW7JHwnJZNyKECxQjmb6GDASgQfDUJhvPP3axCq19UD8/84NY0nqouP7Xlq9Ep+AHW7W70lqiUys+bPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8skW/ZNYMAFFfD4Bt65lhr2jB9ddxODj6yDVkCVtlg=;
 b=Dga1IzemIBHNQx37DTRx/5LkNUqpYMJ3J0iDAt95xPxTRKcK5HM4TSBnapvnh34DdDNcMO8vNgtUpPUZqc/0XLc22LbjTOOG8jmy361Mt+m1LWskPV4nHe0KJoF/y92/tarSYCWm3aLorUSOKr9XrovE52vQ0URaG7o09unyv0uqb2C4x60A+5kq3qo0n6UnCI+zI91MirAA5apxPOlUbCw6Jn+PRQAT6A3q84BDu15LFPpBi+kjfi7xRUe7LWfrWW5HILPDUWX1avLSJ8TmFdNTngaJ8QDLEytmCaL74iUm0UE4muSYGT8thjBBxi0curFtlXAW0Qd9q0g0IuJKkw==
Received: from MWHPR22CA0056.namprd22.prod.outlook.com (2603:10b6:300:12a::18)
 by DM5PR12MB2536.namprd12.prod.outlook.com (2603:10b6:4:b3::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Wed, 16 Jun
 2021 19:12:20 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::43) by MWHPR22CA0056.outlook.office365.com
 (2603:10b6:300:12a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 19:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 19:12:19 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 16 Jun 2021 19:12:16 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v3 6/6] vdpa/mlx5: Forward only packets with
 allowed MAC address
Date: Wed, 16 Jun 2021 22:11:55 +0300
Message-ID: <20210616191155.102303-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616191155.102303-1-parav@nvidia.com>
References: <20210616191155.102303-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f77a491-8e17-4578-bc41-08d930faa9ea
X-MS-TrafficTypeDiagnostic: DM5PR12MB2536:
X-Microsoft-Antispam-PRVS: <DM5PR12MB253679385DA133474342F9D4DC0F9@DM5PR12MB2536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFj4F3I3bPo0RUOK1PtyPCqV6aZOBL7145dDC/Fm9oLYWZ93non0qY6u/7OqxrWNWq7p6CN7edlQcj0zkGHmn9XqtDeZ9HqvJW1452a0PkIoKOqxuB8GL8LBWeVTDX+yGGc5FI/ymQGLDGHZYZq48pZe5fznhLWmU70xEznB72afCRvnAqRFCpWvmc4Y+Y+c1vCnAtxpmop51hBYaajOCmpCqPn+ndYEaRFldHmkn7tzRF7kZ9fbNAF5MvGGoUmge24djvZdRa2AwYhhdobOCNepRlkBwwDcNTdK8tj3LjOVS0GlMuqA9g6OYztHggebUWV3w2L52+S3BPdLkyxqaLLx3QysSja86qFCdt4/J50rRI3LIFsBkU3LXEo8QJKmSDeaklAYzz7xH+6sAtqN3wTSr/RuMAlCq3TXmhYDtYZWqHnFWeLFiZaosekFSFeqe6eiJeJbxDNZymYLGvEhEC735QsNl1vaVpHQ4zdVsBZnetuSIDiD/0ZT+VxSrKtpr+W/r+tXtKqykw6kvDk97qh6ZDD1XtCJ52VCJ0WtcTeuoyTpNQhL2cbxRXFAHwV8FKCO7f6Hceyvur8jpcOOShx9XeyYgXQOg+JK8tWlbZPti5G0YsPDeplZQn6Z3Lp6FbBsCeNKEG3UAtFP9loeGA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(2906002)(6916009)(2616005)(36906005)(16526019)(4326008)(5660300002)(8936002)(54906003)(8676002)(107886003)(70586007)(26005)(186003)(70206006)(47076005)(86362001)(83380400001)(82310400003)(36860700001)(356005)(498600001)(336012)(1076003)(426003)(36756003)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 19:12:19.9176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f77a491-8e17-4578-bc41-08d930faa9ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2536
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
index 7f3d09f201fc..f7c8c34e76e9 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -148,7 +148,8 @@ struct mlx5_vdpa_net {
 	struct mutex reslock;
 	struct mlx5_flow_table *rxft;
 	struct mlx5_fc *rx_counter;
-	struct mlx5_flow_handle *rx_rule;
+	struct mlx5_flow_handle *rx_rule_ucast;
+	struct mlx5_flow_handle *rx_rule_mcast;
 	bool setup;
 	u16 mtu;
 };
@@ -1296,21 +1297,33 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
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
@@ -1318,37 +1331,64 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
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
