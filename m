Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197DDC0015E
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 18:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B76BD612BE;
	Wed, 26 Jul 2023 18:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B76BD612BE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=f1v8oxq1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k7zkrPTIBRfS; Wed, 26 Jul 2023 18:31:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37D5C612B0;
	Wed, 26 Jul 2023 18:31:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37D5C612B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 057F0C0071;
	Wed, 26 Jul 2023 18:31:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBD4AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:31:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97098837A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:31:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97098837A4
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=f1v8oxq1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m5kEmmDacJis
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:31:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::624])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CD888366E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 18:31:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CD888366E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuWbCBEICagEYih4IbQrz0GbK7HJWSjrYf8U61sUvjL7GN0xUXXZNxA8YgiYz4HYCxhMeC8X/EGQNR7RrPGW8NncmleSBbNnjOdudexLYntuI5Yw1OjlESjbAEIG3jzDMXK919HhbAfyZp/H8g/TIj8lHPEwPLwgFsvLyDuH/Z0DMa73o3GgPpvLjotnoGDowE/W54b1Aj9LYje2WWK/jO2zTzsQs/x5sTLp+4iGH9P4wIB4MN8tDX18BzaWJRdfgopnhLTHWRuPe+uka6KrN7ejEioYUXPEz2yPC5s+Yz3eQ+lRodf+sv+Ei5ZuRNO7JrAMx2/TNykkmjim2p6yAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NesKOVXikCLA4XF5mUs58QdvbPAAsWL7QAypABjWcLU=;
 b=V658FXZA4rHhwpT498KDJZk5Vb3uR35Ei87tRfjWxbY/IbhR/b3qixqE4PpC9mIPHFDXvD5WUnxELOOShWw6scyY1+ibxtS19sw/R3FskrjUnEkRBvYBqVoRgbYOU59EhNafhP8MDFYju6wMsMa4Gq72E/VBJKR/ZyApCEjZfLXuPZ5tbzAQ74WS0Nwe7PAJHo8NFJ5SawavWBiz91Nv9uKsGVSTCdatDxDsKLUOGN4mV/rG5u2YrprllRowfbXrl736o7wKaGO9d89ASPawF+svSSzlzvuQH/ln0GcivtJ5dBd45gDHkkL1dzJBBq8+SrAWhvPYux/FTqF74CUTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NesKOVXikCLA4XF5mUs58QdvbPAAsWL7QAypABjWcLU=;
 b=f1v8oxq1si6gAlRukmx3TPD6nJZaOLnntbSrh0QS2NXeOZjBxNsK091lHMdxeQ8TCQT4zNk3imRnRdY3HmJYRwbi1UWhJXrdZ8sXv/mX3T+6yVozq9AQnP0HsY5cEIP9EHn0JGfnD3gNP+/+ikYfkC2RQr3FGfeUVwtDW+V570BVjXOg8n3ulYDT3iVEFNCziUx1rlFQ+xFBFSW7a3FJoehOyWXhscDFoSzWRUAoBLX24eLzvRLxF9kh9GmejRdaCGEmxEP/IRy007IDJHQOBdQIg73vSAUed1shgTJkp6Rbk34GI9AfW+An5gKWAvMyHLSzxqBg6L2S4lJ92cVGBQ==
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:31:34 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::67) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 18:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 18:31:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 11:31:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 26 Jul 2023 11:31:22 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Wed, 26 Jul 2023 11:31:20 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>, "Jason
 Wang" <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH 2/2] vdpa: Enable strict validation for netlinks ops
Date: Wed, 26 Jul 2023 21:30:52 +0300
Message-ID: <20230726183054.10761-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726183054.10761-1-dtatulea@nvidia.com>
References: <20230726183054.10761-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|BL1PR12MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: afd3126e-f57b-4e1b-4b11-08db8e068a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zikaesuyqw75V3iMAARzEIIU/sQFcTIDf4n/9vwLzfIU/HEsBLG3ulWRg1WHrum1CTCKR7aXsPNmxb9wIVkIIxy2bn/2OXJ0SLGEdFfu2wlQ0Brs7krJtiFxq/gR9FYVam7uVC5c5wzwIrMAmkEkTtEt/tN/Vu8bO+pMC1PkIjEXQclVoNjoTvRDTSWk+bRUW2XySU5XDQ/8UUs1W5sqCEiwzrMQlw6Ckt4s7Iw66tyI+8xvMfGVebftNZVeuRL7cPv/nozPbNGiPz0P0GaPRRk+OYVlAk3R7CpB/b6waTlabp8UG7Yw89ul6G27Z/g445iMwt5WxhTV1dLoO7wSDJjbIcR+Iao0wqx0XMY0aSMhNFUPQlZJ9CgQmUMAwC1Q8FK9XE+3LInU+KfjzqjR8hFYp7bnal9j9Fy509N3FUXfUx+5/c2tsPnVS23Utg3YH9TcP5ZxXZgwwMCeM2IL0mCjsvrHRlPNZMi2vltKB1Lyyx1zx9FJ0iaRqYa+WFyc3ZlvQD1jmUguMFoBPUjj53Sz50KR6v4FOojUF0drs4pqcMqVyYhiVREC7uE49P4tWoYAbz2pyJ4qqqJsSP4pfEqezaD88E70xfs2Wjll2I+JJvsnhzVlY1fhSAySrJrbcIUyrPmZvBH3fAxAXSYyEEtsD3uq42+6EaOWdXElmoeQNvtiG2ObEY061ADnnK5vkyOTSeRQ9guQ5gRu+MTLubyrB9QsabIpyEMe1jvgA4RDbBfP1eC4zWQt1N9bVHNw
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(110136005)(54906003)(478600001)(47076005)(2616005)(8676002)(8936002)(5660300002)(36756003)(41300700001)(426003)(2906002)(40480700001)(7636003)(70586007)(70206006)(86362001)(316002)(356005)(4326008)(6636002)(40460700003)(336012)(107886003)(82740400003)(6666004)(26005)(186003)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:31:33.9381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afd3126e-f57b-4e1b-4b11-08db8e068a17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The previous patch added the missing nla policies that were required for
validation to work.

Now strict validation on netlink ops can be enabled. This patch does it.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/vdpa.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index f2f654fd84e5..a7612e0783b3 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1257,37 +1257,31 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 static const struct genl_ops vdpa_nl_ops[] = {
 	{
 		.cmd = VDPA_CMD_MGMTDEV_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_mgmtdev_get_doit,
 		.dumpit = vdpa_nl_cmd_mgmtdev_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_NEW,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_add_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_DEL,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_del_set_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_CONFIG_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_config_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
 	},
 	{
 		.cmd = VDPA_CMD_DEV_VSTATS_GET,
-		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = vdpa_nl_cmd_dev_stats_get_doit,
 		.flags = GENL_ADMIN_PERM,
 	},
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
