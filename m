Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF608C00528
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 17:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AE5860EF4;
	Thu, 27 Jul 2023 17:58:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5AE5860EF4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K4XML+kP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uOBirMthcv9P; Thu, 27 Jul 2023 17:58:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CCCAE60E6D;
	Thu, 27 Jul 2023 17:58:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CCCAE60E6D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B768EC0071;
	Thu, 27 Jul 2023 17:58:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E905C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 17:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F073E60EF4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 17:58:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F073E60EF4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P1Ug0QX6l3u8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 17:58:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 35E5860E6D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 17:58:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35E5860E6D
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiThJ1vRvDMeHmVlw0DeuwOgbZKieItlOTegxbaCuK5h8yggj0xmoBnmzuN9bRDk5WgSxj5qwNtySOt5lBjV9iJfBOJ5wMoPtIDz/1anWKE7vdDyJdUr2NtIwEwy25JlSQKnEkS4BfcnL+dWky8UQ46mgYGXTRpEQAayd4vFV0XaMeMVCJsQk/oxflPRVRZ2NyhaEG7hrV8MwlXH48RQ6CFgCQzfvQ4in3BZdQx/ROcLW1A2mge3ANfVzqtucFyDOCemS5ONQVWDC4Dkon0ZoINhXF9ifAJiiSgGVSbppOUctDGWtZREhfy4e+oYuKnOoCc8DMC2J1ZcAZHmFhLefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8UMif7Br05o4sgfEuqtA2qO+wkMcJ6NxdPG1E1yAJo=;
 b=c7T5h/KvOz1wZ6kkcHMcV+714FWjL4LWxn3FoATA4F0iZAvVk3F8cxUDsCME0VD3FDEjm+tPz4aKeh2Xww2oBmjT54dOlCXXwADQWou2j9XChtiYlCNsdGlost6wQTK/NFHXSAvnRm67gf0Y4l/8zOfYUQiTeV9GzaU56KA7Hbr4M/uXi1YnE1Egcu4zs1dyd+MZqccK7kaCDR1ruItCwR/bGYkKjJMsvzqbiPtbxCwPJKtmkYKQsY64i5R2tAmWuEGx7f0OJkd2/xfFxigNAIEpDzstQ/obXJWFcpE47rssIV97jlq1iNnzfJJFIdKp5Jl41s5vdzp2+B8Cu/b3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8UMif7Br05o4sgfEuqtA2qO+wkMcJ6NxdPG1E1yAJo=;
 b=K4XML+kPm1OYYXRpa28eCCJCVw8+pYucKEzuWd16YPv8rD7im8+o0qMgB2DAZP2LSpTCCUWaYKb40Q4xxERkut++JA3sGtX+s4QiumHhDY6B2Whcs4z2bywD1bWbfeMGzAFVRqCbZCkYY9Ky8G1ltaaAWsmcptMCkjKI5lTGzdNFCNZdPLily4/G4VhTDdmAMislnwSdN3pfZDe59cOLljCa7LTamKOF3eglMCibcyx1wfLtf8KJ6AZ4RRvX8RxgYV1gfmBcEC40PwLZ8u6pvQ3vFGy08MWYPNDjTSPjxAdmd+vEdYllzIPreG924HF2+zBI2fVIvwwhNRWRXZ6KuA==
Received: from DS7PR03CA0211.namprd03.prod.outlook.com (2603:10b6:5:3ba::6) by
 SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 17:58:33 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::6b) by DS7PR03CA0211.outlook.office365.com
 (2603:10b6:5:3ba::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 17:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 17:58:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 10:58:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 10:58:22 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37
 via Frontend Transport; Thu, 27 Jul 2023 10:58:20 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Lin Ma <linma@zju.edu.cn>, "Jason
 Wang" <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH 2/4] vdpa: Add queue index attr to vdpa_nl_policy for nlattr
 length check
Date: Thu, 27 Jul 2023 20:57:50 +0300
Message-ID: <20230727175757.73988-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727175757.73988-1-dtatulea@nvidia.com>
References: <20230727175757.73988-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: d9616b4d-734c-4920-5bfb-08db8ecb17d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlp644XSkCNUaICQJ1K/cpwc1e4ysjXHlhQ/dkuuvK7JgRjeaYLpfTIKO3N9R4G4aVN5izwrDIAGh1aGRpEO0QsPNaFlBJ5UyHSzHqLoHHu4wwluod75tw6j7Gk2SYr3gWXByVquVeb3vZukvBc3Np9ipSt/4z1L+7NxDQqSLw0dG3AlTusUYYr/vkGXPQN6pQaFnSPdkDbiudB5Va4mXDO7FVI7nyT84qBx1o63md98IHngLuwPXA1nPCTR40C9rg1OG7y9/PnCKeZhnBehGmduNeddim69r2fRfmagCw1k3y6yrfMItmw69kQkC6UrmafJrMOStv37j4iX7Qgo6fLmPC5TObWNBEIgLXNzg4fcWo0WeWim92Z0ApIGIs2/ahM5c4f31YpR/fD6IA+D0nNVIGSMvzNc+XEVof3GWY2+Khrp/WXLpM/dypHzS390HKR03VES5Yu1SKK35r/bHSUDeIXwVAMFBg4qJVL0Wj7wTDvs3KHR5xKSpkH/jf+8AloVy++YqJ9KhhRxm3mYgzZZwcp9Dm4OlvtSRD49uPiTCcTKlu7swEj5nW9QUa1/vy/XVpBL4wDTxZb12H5rmIVRDXUpPlRQiaiV40qGxbziXKUS9oe3ERyQ6xls2N2+7cvU47fD5J3HTErbIz9kKBrRfLhZsm0xvRhdRzBqoRln/Kzb/FhQA/e4x0SkRzPOGGnv5bXt9XkrVBxs8luczKGrVwlRysSVmx5zSRavDReVd149ZOjrMQ07+1iC2qWH
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(47076005)(478600001)(110136005)(54906003)(86362001)(70586007)(6636002)(4326008)(1076003)(316002)(70206006)(356005)(7636003)(40480700001)(186003)(6666004)(8676002)(336012)(26005)(82740400003)(40460700003)(8936002)(2906002)(426003)(41300700001)(5660300002)(2616005)(36756003)(83380400001)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 17:58:33.0949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9616b4d-734c-4920-5bfb-08db8ecb17d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
Cc: stable@vger.kernelorg, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

From: Lin Ma <linma@zju.edu.cn>

The vdpa_nl_policy structure is used to validate the nlattr when parsing
the incoming nlmsg. It will ensure the attribute being described produces
a valid nlattr pointer in info->attrs before entering into each handler
in vdpa_nl_ops.

That is to say, the missing part in vdpa_nl_policy may lead to illegal
nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.

This patch adds the missing nla_policy for vdpa queue index attr to avoid
such bugs.

Fixes: 13b00b135665 ("vdpa: Add support for querying vendor statistics")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Cc: stable@vger.kernelorg
---
 drivers/vdpa/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 3ad355a2208a..75f1df2b9d2a 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1249,6 +1249,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
 	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
+	[VDPA_ATTR_DEV_QUEUE_INDEX] = { .type = NLA_U32 },
 	[VDPA_ATTR_DEV_FEATURES] = { .type = NLA_U64 },
 };
 
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
