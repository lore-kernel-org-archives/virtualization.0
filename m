Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7322FC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C13610A4
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 17:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20C13610A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EED3E60A3B;
	Tue, 26 Oct 2021 17:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eX2GSDPz7jaZ; Tue, 26 Oct 2021 17:56:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1894608C6;
	Tue, 26 Oct 2021 17:56:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98195C0019;
	Tue, 26 Oct 2021 17:56:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DBFFC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00FB781751
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0Tw5tr3VPNi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 503E88174C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 17:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF/+tDoROER6D4nc+Y/OS+2XrzqixSweNwmaY7oy0X3ONLkO770L0HMrWePSjk0FYBAxboWkij8/VGKJhaYRRarg03HQjwsDyE8n3vG4ls7FKX481G1sto1rcQV1XdDF7d+L1cbQiEpqOUzztGzhefkyQ1eWbyxH9PUCy8rPc+mEm0fhdbin0lQo9Yu+As/5PHICL06OhfYkYOYtcpyhDKrBFuWfQuJ2i/hhhoo3hpIEuMAOz1iKoEuDV5nFL23HgxCG99wMORyzkZP5oIb6hr/ADpF0sX13l+q9apbnkSNUq37UbwjlIhuJIY/GjdeVYgzV4Co330UBwzWDuLUVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVNPtT52d8l5qGACCR62hiTHppPAf/x1WsWAiWG3fgY=;
 b=LcuYV0hrqsL6ACR3KF3MpKYiXvFE1pY3sBBN6z7QR7+9lw6yqbivTrAE3v+7yaxLJck7ffZrccWypzQugttCPdjK33lX2lIkvYNU6KXPnFAFTi0p66HXuf1S2ai9nMdlt+uFk+F/tSt6FR/G2bVFsUax81Aa5afb+7Pzuq2tre73IJl0DveL2mYnETpyzbQZ5T+C/yYdzMvmLTwHLK2guCtSnzvihqRh6ZlJP/kSqEAPH60xPvxKZ/etRIZYbGAL5BZzAMKdgPRE8V8fZ7Dfz2jFIN5dJUddRq8udixQfEMR1N91NFLSaqmomoBtVjk5Junjoq1XpOfH5GMAX8+VAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVNPtT52d8l5qGACCR62hiTHppPAf/x1WsWAiWG3fgY=;
 b=m9ckiOWgQz+BljpMUsBQGjaV2UBiDDjaf62amuMuyz/Y6hwW7xlDW/I8vQ/EdlExCOe10a6F5MW7sS7Q0APw7lGcYyafhCF2mhojaDpX/vp5kYzRBk+pRijjpNdClHZnSE0XoEU01a3HWnmKc505RHxTUzqXU9I3zlVFMbri3JbrGFtuPEAYdpTdRmvf1wfDqkkVc/GxuNatzcGw1Lv92/T20DxAJODHXoYl+k4Aq4afHGIXK0NgrfumXJY99q8TRkk5z01/ACr6iByZlye7HvcImrLjcu7qWELh/hB0ikEyM+Z6xEst8fbyItRLna4yXQsNqTV++JJE+eJTeerXbQ==
Received: from MW4PR03CA0351.namprd03.prod.outlook.com (2603:10b6:303:dc::26)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Tue, 26 Oct
 2021 17:56:07 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::54) by MW4PR03CA0351.outlook.office365.com
 (2603:10b6:303:dc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 17:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 17:56:06 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 17:55:56 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v7 6/8] vdpa/mlx5: Fix clearing of VIRTIO_NET_F_MAC
 feature bit
Date: Tue, 26 Oct 2021 20:55:17 +0300
Message-ID: <20211026175519.87795-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026175519.87795-1-parav@nvidia.com>
References: <20211026175519.87795-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5491de0c-57c6-4fb2-59c4-08d998a9e28b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160C4E1E8DB27D2692307A2DC849@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfwHUxngriyhM6YeaGZLmgNlKkzY6whoeX09FcMiFh2fyslBOxmqWLJZU0Eae734i3cJLFAXR1y00AYw+I+anw0Dw9lYcHihrx7lsSsQ8AMq3ErNIz+HBhxJwEQxQ/3qXctYWRW/290Q6GrAEQFSSM96pLUmqBKSGZR4H+FMM/H3r3240HnZHqhkbNIEmQC5vCNnQz7cU4S9qDuCIGwDyDqB5sdF39d8tjYc5e7+ga/RJYUzXZX9968JF9rpJtjCnY0hgGga7iFKOF03KaVo6ueqpMlhjEj9oDuFkQc17OYq5D4SvwjktZ66No0Z9L2nWJrK+uAIdbkhn+eqKC1uZ/ouBhjcZnZZZCpv1xaHJL5JxFEkoK7L4iT+uVtXkgxSIWBY0UzE9E0pYDqSQmtYoDth7EDaZiIK53AJF/rgLlPZummUYQsLewZU9eoSwxOw2z7yS9rhK0WXV71qYeIfm51NTdR11VPfOG1vSpPC3DYqrjslsDWMl0lncZJI4Og5HhkgcvNEy7Cgju/hp5TpTKCDAPZxv21TpPwnWbbvu3jkLwW5L3lKRVe0HZYy0MhGNlQegJmuRbS1GsamU8ljMSz/ADlvkToE1RyW12B0T/Sw9Q//fsTKAm7AOE+6RRIbxu1nL4D0mFyFz9Qq5hvIh1BbmS5prvwuLqf/66vxjDD94EVJPlvMAdrZaIYtPCnxDFpaotrT20a381Aq9LdI9Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(16526019)(336012)(83380400001)(186003)(82310400003)(107886003)(1076003)(70206006)(70586007)(356005)(36860700001)(86362001)(36756003)(508600001)(7636003)(6916009)(8676002)(5660300002)(316002)(2616005)(54906003)(4326008)(6666004)(426003)(47076005)(8936002)(2906002)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 17:56:06.1427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5491de0c-57c6-4fb2-59c4-08d998a9e28b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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

Cited patch in the fixes tag clears the features bit during reset.
mlx5 vdpa device feature bits are static decided by device capabilities.
These feature bits (including VIRTIO_NET_F_MAC) are initialized during
device addition time.

Clearing features bit in reset callback cleared the VIRTIO_NET_F_MAC. Due
to this, MAC address provided by the device is not honored.

Fix it by not clearing the static feature bits during reset.

Fixes: 0686082dbf7a ("vdpa: Add reset callback in vdpa_config_ops")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6bbdc0ece707..8d1539728a59 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2194,7 +2194,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	clear_vqs_ready(ndev);
 	mlx5_vdpa_destroy_mr(&ndev->mvdev);
 	ndev->mvdev.status = 0;
-	ndev->mvdev.mlx_features = 0;
 	memset(ndev->event_cbs, 0, sizeof(ndev->event_cbs));
 	ndev->mvdev.actual_features = 0;
 	++mvdev->generation;
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
