Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1F4C43462
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7DF613BC
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7DF613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D853E4056A;
	Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HnpvQ0CJfwAh; Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 717BB40567;
	Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 551D5C000C;
	Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BDB4C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57DC484A4A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhYeJt20X5J6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 670E984A4B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrhrqD4QL438Q5HIHO6CbB4ghU/W0URGoHcft3eKIWy6PNB5m+ollAU4ysG3v/tIl2nxyJ6hyo6vOkHl7qhmlpeMSL3UjsYJPoDgp9l90g/glh+VSL6pJR6p8UyGwlBmQigKwiTLzR43zTFCZ4F2iY7PvNwzUBpC/rrz1Y8jmgAhi7uCOfkmITGADWGPCWUhv/jdiwwEH947QHko/W+tOm3YCSmK22Xfb7B/XITi+ppIh8Rt1hHBWfY25yMVk1Cn5lhOhdMk8xoZ8UeKu/ccI3m+behaV7xyLuFCB1Qbe4sUQaTz1y+N8KoJqIcJCW2B/D+/DKot86EymhIz5jJWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NelmZXb1Cf6Og6S1MkBnsfkoDpg/fZfEkEOR5EMEnEQ=;
 b=HVLkZ+RzdP82RowMwsZFzItEi2U0AmySSjmGMbVQNRtk0S2ZYX+wmaTU9wmOEwkShQuE4pDPsLx7end9BMCAHUvKGIEZLiK76Pdlu1r6Cym0DuPnunsXaA3W5UO8Pg/9BYJjlAJlXwz6jKakt4HDL9n+48FwQ9FjdvM+vricWNkH8q+UhnvHUy7I62XSYzCKGy/BhjxKxyWfshq4Tpi8cTUOEgV419/nLHYtPTPLg8glk2KceqGhA4bWWWZPgw7SPOD/NSd0AOwSg5WSHPBUg8k4vxBDbfKid16hPtzWHBTriEWK7GExHjAH3HxHglnmZ5lKMiQU8N/MdyYkB4QD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NelmZXb1Cf6Og6S1MkBnsfkoDpg/fZfEkEOR5EMEnEQ=;
 b=Sad4lhgWmNkaO2vunZA2jdE/zvSxbt2u7sZIhvB2+Qn2XS00NPuk+q+06bJuc/Zwiqm8FSjImdxLL1AvObZfGAnIn1fXb8eff2NI8JlhlVK+UDhYETDoFIzTUEVUwle3ALbORcS32eBYseEkZMpdeG8qgfd06QVDYxD2PT/DzNO8GIckyvJh8MXogcAMPo8nG56xhkoiIHz5x19S6aWyuL/FEOKZ0zyk2gbGAgo2Fm8A01TiUpx/MJyKxdcqk6TvKgVLRhuM0L/YBXj89DdLbxM6dZH+aqz0aJv6aUjrvBYyqtdwdwtpFr5++aXQW+bmXgMIMYWM+1XzBLrSoE/Fow==
Received: from MWHPR19CA0067.namprd19.prod.outlook.com (2603:10b6:300:94::29)
 by MN2PR12MB3038.namprd12.prod.outlook.com (2603:10b6:208:cb::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 17:05:19 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::ec) by MWHPR19CA0067.outlook.office365.com
 (2603:10b6:300:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:19 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:17 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 07/14] vdpa/mlx5: Use the correct dma device
 when registering memory
Date: Tue, 6 Apr 2021 20:04:50 +0300
Message-ID: <20210406170457.98481-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be830d37-9402-4f47-8aa2-08d8f91e286b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3038:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30385D4EA104D228686ECFE7DC769@MN2PR12MB3038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54wK3y2UFGpeHyVEm5sleiFqtxYkt1dmggII4Ehiz9Nqi6Y5CSdvvw3PsBjMKmx20qMgLxFliQqnjxs2zi8JysIRHEb/Qc0ut1kpx0M+EUB1YtG1OmwcomnOzDz0dctG6rkh7p1stgJCrhZpeiIdDS254Kddl4tAgUeYwWrlDzBnwyHgK1ArjrvJYaIADGmtB17EZ+YCb5uCeJXbD6iwdZvPRJNUU3fCF7V9ie6rg6o+KYv9ZWaHOyin5rxXhho31PMAk8x4QuE+3zVcFAfIBMUTJg3/skDl3+S1MF6UddwifqAgkQXFqJM4IF4R5Gcb35dJ2uuPjQ+UvYU9HHEAn399+1HliNTMneTBS8asq4kjJDC8hE4NdBN5Mo3A1tnWJCL68hkGmc1aiOr58sF1aBxk+2CYAT9RmC0lTbMnJTytAleXc8KFhQjoNH5xGlnQPmwGmaPF5STvV/s4FgoewCdFRvTIJJ2HO/0R8ojjp/k/C2SfQLObUwdAKODYEdsxCJBK/88rTGnqZJXtO5Vu0IrGldUm496adcf2ut/JMQBcEzmzUCe9PvpgmCz2MxtHgPVv68hQzjj6MoWvhEpqk59QI+ZgcmfurwzOWAcIRBjtd0d6d8yqJMKSBow28uKv5iccw/rFhWLKKh0KMYOE2xrRV8RsZED/eAHLk6whVCo=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(6916009)(1076003)(6666004)(86362001)(8676002)(186003)(36906005)(316002)(54906003)(8936002)(70586007)(36860700001)(36756003)(107886003)(426003)(5660300002)(2616005)(336012)(16526019)(7636003)(356005)(82310400003)(2906002)(70206006)(82740400003)(83380400001)(478600001)(4326008)(47076005)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:19.4267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be830d37-9402-4f47-8aa2-08d8f91e286b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3038
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

In cases where the vdpa instance uses a SF (sub function), the DMA
device is the parent device. Use a function to retrieve the correct DMA
device.

Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
 - new patch
---
 drivers/vdpa/mlx5/core/mr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index d300f799efcd..3908ff28eec0 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -219,6 +219,11 @@ static void destroy_indirect_key(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_m
 	mlx5_vdpa_destroy_mkey(mvdev, &mkey->mkey);
 }
 
+static struct device *get_dma_device(struct mlx5_vdpa_dev *mvdev)
+{
+	return &mvdev->mdev->pdev->dev;
+}
+
 static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr,
 			 struct vhost_iotlb *iotlb)
 {
@@ -234,7 +239,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
 	u64 pa;
 	u64 paend;
 	struct scatterlist *sg;
-	struct device *dma = mvdev->mdev->device;
+	struct device *dma = get_dma_device(mvdev);
 
 	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
 	     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
@@ -291,7 +296,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
 
 static void unmap_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr)
 {
-	struct device *dma = mvdev->mdev->device;
+	struct device *dma = get_dma_device(mvdev);
 
 	destroy_direct_mr(mvdev, mr);
 	dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
