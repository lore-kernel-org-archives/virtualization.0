Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBD8C6FD1B
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 03:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83B6660F85;
	Tue,  7 Mar 2023 03:57:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83B6660F85
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oQTj1Qk1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X58gUeYjZbaq; Tue,  7 Mar 2023 03:57:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5086960F98;
	Tue,  7 Mar 2023 03:57:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5086960F98
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2786CC0035;
	Tue,  7 Mar 2023 03:57:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89756C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBBD1402F3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBBD1402F3
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=oQTj1Qk1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PbnxTBdCrMAY
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C3FD400C6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C3FD400C6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 03:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5ZW9Td7iFkJTBuiDXugx7vcGZ6gsw6taJvqRTTdGQGr7SvtTF0Xe1wMzpvZ3krCzlrlF+xnwaT0Xu2mCpk/stOn5ZdajCYJbVR9vySfyGJnm2EE+bBn3Fn+RzQFIl5IeObAIylbTbcY2s0O1v1zcSRHy3m8C2bEW2UEfzqYE9M95A3mjKWzGHXHOfwZdXfPBengedcHXfqaAlx0MYV0VxXLW1u3s7GClKM5rJ1yOw43SyKWmqExT8RdU42CG6uaPk1s1e/ZBeInjgItOsgi/R8FGFWH1IDfSb0zF9u2mx7/k93TI3huUtuVG0KAMiACwT3eQtiVA0eszUwLtHTjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFtuuf9g1tS7qM3M285WM/EsB0PI3K2yM5On35CgzRc=;
 b=a4tB4fYG6OzO+uRBoFa6UzRf7ewcQVg5+kMEmEgwQniRMxG4y5Ff0O6t1sBEauWAVl1TirXKscujYdx3HNMkbcCkRIF6w3ReA8rWhMsYyE6PF19QKGMH5wUe1DGiA2KpHcXJ9ci0rWdS8fKY3e7DHPqWEcCg8Bicflm4NoxPg/lqOVI6kpIyyaHbHhYps33afB/aB3Qa5Giw1/oWqYsB/4F0z0l1F3gOUAmJXw8bFp3D8i+GW0C9/L/nqjR9PA5yu/N+pgp0aQ9f2OUwaSolISjmFlU3lR2D703He8eg7n8c95xoflY2DpOz7Dr825laMedce8/CdqQ5Cj6shA+ZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFtuuf9g1tS7qM3M285WM/EsB0PI3K2yM5On35CgzRc=;
 b=oQTj1Qk17r1ACx7bR/VVc9cWZWCKIz6OmIA8e31uCTze2Hn+O0Hdk8OktTYgaWCiSvo9Ymc9tJFfnXU6W7n7Aqk8ew9IgQZnxV8BYnJFLg/w93LiLFjRi5/D4UeRZWk9JWUxHSZcOxfanB/0e1Dp/jGBqjwfmd2Yd3djdRJKVeLrnbBC1yHWCQwgpheXBSYDdtem2S2XO+yAAF9FHElMT4JBd6N2dvRZNkKCWexmYvFCr92jRPtMjbmJrfj79u1umrfPWuZC205JBXgA4Iukb2p1NzoLsqNxBBxAoANQzAHuhJoaIrp0R1x6fwhL5eqpPmdRNvTyxuhrhl6cL5WXRQ==
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 03:57:25 +0000
Received: from BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::b3) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 03:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT108.mail.protection.outlook.com (10.13.176.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 03:57:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 19:57:13 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 6 Mar 2023
 19:57:12 -0800
Received: from mtl123.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 6 Mar 2023 19:57:12 -0800
Received: from sw-mtx-012-001.mtx.labs.mlnx (sw-mtx-012-001.mtx.labs.mlnx
 [10.9.150.40])
 by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 3273v7Po019487;
 Tue, 7 Mar 2023 05:57:09 +0200
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH 1/3] virtio_pci_modern: Remove unnecessary num zero check
Date: Tue, 7 Mar 2023 05:57:03 +0200
Message-ID: <20230307035705.4479-2-feliu@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307035705.4479-1-feliu@nvidia.com>
References: <20230307035705.4479-1-feliu@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT108:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 633cb896-e5dd-4b51-3c7c-08db1ec00fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdmK5ijHCRv5kseBnKhxeobBgCZw4mg0qX3heehqoZdSm3I+M/wogLDmUJfTlYTP/42UyLDOVT71U1aQ2ULPClLHW6hj5bb4nr5xPRqags9XXFRvsYJWX8O6Becb2oeCJoQZ2OicDwNjA50ZjK91AooCERuG1jHsp/dftxE908vMuBTNiP/OYkVXEO9dPw3QDtZY6brq3bYNRxBeLnbnQTbwngJhsySK1rGRuu72auN4G0kiSLnDR8csmClDundR9EDrGCx74X9TjCj5XulZhpRu7cnOY2G9ApvMK+RY0iIIgUa5fbYZrFMrCMOmusZbZfi24mW62c5Qru7XfTbyMEC4FVZ1rondey+Iscxbthy4E3GcJbtNHnWyNixfP5c/1bzSKOgAI8itI3Hh9hIyUqbim8kCUU3Tsm9B6KqXcnxh+51EGYDdgTRWZiyBAwhro1K5p0fEB8spyq+TOBwMzQRXYR2MuuEqCfWDdidbYeTT3fpI6VgDqwmB1H1VKvmfHRT4klfwIXe8YBCzHyAsfD1FnOPnnAckkZDjoTcCVnq2dCUElcjP/w24fh5u5OEj1vUZWi67mTUaeTCKjnAVoQX7Nfl4zHUw+29fWjSXjqo5JkB3u97joQ8HK257SDi5nwR/6/IYVWZz7AweOfwYU2XIlaXzn+ugrcEI1NulAIisDsBGGJcVIvdkL9Ejq3pOQlCSHD7wRmraC2w1Nzvf3Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(186003)(70206006)(7636003)(356005)(8936002)(8676002)(2906002)(36860700001)(41300700001)(4326008)(478600001)(82740400003)(5660300002)(70586007)(26005)(47076005)(6916009)(1076003)(2616005)(107886003)(6666004)(336012)(54906003)(36756003)(316002)(40480700001)(86362001)(82310400005)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 03:57:24.9868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633cb896-e5dd-4b51-3c7c-08db1ec00fdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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
From: Feng Liu via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Feng Liu <feliu@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

is_power_of_2() already performs the zero check. Hence avoid duplicate
check. While at it, move the query of size check also adjacent to where
its used for the disabled vq.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Bodong Wang <bodong@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 9e496e288cfa..3d7144f8f959 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -306,10 +306,10 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		return ERR_PTR(-EINVAL);
 
 	/* Check if queue is either not available or already active. */
-	num = vp_modern_get_queue_size(mdev, index);
-	if (!num || vp_modern_get_queue_enable(mdev, index))
+	if (vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
+	num = vp_modern_get_queue_size(mdev, index);
 	if (!is_power_of_2(num)) {
 		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
 		return ERR_PTR(-EINVAL);
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
