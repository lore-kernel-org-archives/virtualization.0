Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05F3C43461
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F4B61074
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F4B61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FF8E4057F;
	Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqDQQFus-Jml; Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EECFF40575;
	Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23D5DC001C;
	Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D590CC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85FD04145D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B8DNUNFE0E9a
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0CF840FB0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKwxOuxUvvPBC4NpdtJCJqOp/E8FBXXTXeXjlBsmHuOm7xgVswq3y7StUnW4EvX3t9xBFB80VeiVi0qhAmUp2x2fk8JbGTLSvZPRmJ8zqThJBJFekv8+GLtfPU7qrps3dmUP6kMnrIrWRTN8NdF4kFISjcxbimzSMn1X1W37VHiaWt+Mear4iKmQbNXOWv0OWvD7Zn6LX1hDUvHyMDJDLSjgFVs2eCzxXbBMwhl6OEYrUepz96e0vjteCgUFWQ4IZqeCLZUVq2orEJuteq3RnrTiTIYOfVN9wq9dU824h/LUTAVCVV0xJR/Eu2ttfIpu7UgphsVUdfs/qsgYi4ucSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObZoYnnvCvx6+xTVVmrRDyPoS5nsrazevA7+jpWz5J0=;
 b=Lmo8abZ2mLVjeTTG4n6c6sf+rpVpLIFhzpULxF9HasYpD/pMDLBsq7LGPrtTtmVKeQb3OSGMicUWZEOqEIxROmacRNNYvE4X+MJ2QT06row2AWBQHGyaGC4oBaqzZ59ZbQIHP2ehvsUgqxWNwyxwjGxbaYc7beM9WOAlEyx3RTFPVEdc2+mDDmzKPtm7UO5L2JLqVbU3iczdsvnArqLDDkWV0VDDXYqDEYNbpnzWVReo4XVHT/QVjoDnxRcxXazeU00JpNm7+wd5URuYGqyS8btNhEjZNxdiZeYzNIFJSA4O4YVG5fqX1FPElahHsc4YuYzJUuwPeGmcifHXMFvc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObZoYnnvCvx6+xTVVmrRDyPoS5nsrazevA7+jpWz5J0=;
 b=Yvm1v4K7Xoys2SrOhQZllCr8+L5O2AXT8tCBVu44Bg1uEONWnCccwfKOdEzLu/cvQ7c5oYYVFiG9K2WPpZziGE0q17XmGBB5KK1DPCoVVRYlHKooj4sIrTLA1+OOx6dhpygGFU6iOS9VBBQ6RZ26o3ulgVkkradKORWaxY2P5UtD/jMYS9g8osHgcdRLa7dp92BZWa7D0JXYt14Kb5CMbH630yAdTgZLCwwf65lrUrKmv4DHGI9MoZHxR2lNkSxQJLiqAbBWBjDUtD8Pjy1Qja3SSYmnvRhGVcpRtlwrp2+DJ/xqd/Ky0/xGUU2IfZcn22gAkWhYlfmXtzQblMckhg==
Received: from MWHPR19CA0059.namprd19.prod.outlook.com (2603:10b6:300:94::21)
 by DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 17:05:20 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::ad) by MWHPR19CA0059.outlook.office365.com
 (2603:10b6:300:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:20 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:17 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 08/14] vdpa/mlx5: Retrieve BAR address suitable
 any function
Date: Tue, 6 Apr 2021 20:04:51 +0300
Message-ID: <20210406170457.98481-9-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30074c7c-6eb7-4b99-509d-08d8f91e28ff
X-MS-TrafficTypeDiagnostic: DM4PR12MB5341:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53418CBFD7C8861D4D0F2F96DC769@DM4PR12MB5341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snEvoHrYJqlpUWyMSUDgi2eCJ6xU/1eX8TrleGiABOZGiC0o1dX3AiMwBXXljUYE0tdclffd/dbpk9WFW2vBctAOBSOblIsIHgniMVGqPWM7S96g2De6BrZE+6QOrsdq3rUpWfXh2liaFttLTfxWI7B+RhlT5MR5y4AAN3RTIhdOGK5Xl0Nd9iszFpjNRHRAO9/IpgACKPX18FXepHZU9V1J5BxETFzZJyK70lcH8QwWOvR87JUihphr/PapldmsoZ/CNPS/sp1WEhRT0VEyTExNCoDmjzfM9Y2jFv8HGEh2Q/AU3vHVzJDE0e7cVjEF3BMtTWYWZMomN2vaWhvvBRxoT3JTvbAQU92tLZ9sMjO0W3vi/KOGPphwUjFNngIdWgYoqeNs/w3ly1tPSIaFFzqfK56PmKgLpBeXwT9LSClyuMgtp4A1PQEJrTapX4FgEyG0haKkXoqdjzMtK6Bk6/l/NFDbgThLCNwqZ6DCBc+dYZmU3rjEEypLr6PZGQUeHqdwUvR68syG+KfGe4RcE0gcrrRAyO4iWQE8z795BYWBh4GOpOeOI8xtUM1xQftLFJHJ8l5mTM7u51IF9dCxFQJ+rXyuSV6WZITDFAOHODn/tH3Ps3sZXRCFn13exdQa4YATZmAuZGuCPT66cAkDaY1urIis8qOMapIFGdzzs+o=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(7636003)(70206006)(4744005)(107886003)(6666004)(36860700001)(70586007)(5660300002)(478600001)(36756003)(82740400003)(26005)(8676002)(2616005)(8936002)(6916009)(1076003)(426003)(82310400003)(186003)(47076005)(16526019)(36906005)(336012)(316002)(4326008)(83380400001)(86362001)(54906003)(2906002)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:20.3861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30074c7c-6eb7-4b99-509d-08d8f91e28ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
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

struct mlx5_core_dev has a bar_addr field that contains the correct bar
address for the function regardless of whether it is pci function or sub
function. Use it.

Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
 - new patch
---
 drivers/vdpa/mlx5/core/resources.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index 96e6421c5d1c..6521cbd0f5c2 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -246,7 +246,8 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
 	if (err)
 		goto err_key;
 
-	kick_addr = pci_resource_start(mdev->pdev, 0) + offset;
+	kick_addr = mdev->bar_addr + offset;
+
 	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
 	if (!res->kick_addr) {
 		err = -ENOMEM;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
