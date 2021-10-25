Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E019CC433FE
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9FC60F02
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 12:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E9FC60F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57AC360873;
	Mon, 25 Oct 2021 12:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MviFSCVVUh45; Mon, 25 Oct 2021 12:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E4EA86080D;
	Mon, 25 Oct 2021 12:53:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6BCBC0039;
	Mon, 25 Oct 2021 12:53:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB20C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFDE440393
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8gVWrf_QBIV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFC3840388
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 12:53:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpEex58WHmbjBWLtojbCLQTiMggykCv087faSpXZ5WmFepjBIdCQgKos/0hL6cm28fi22JLh7V6cOExxluL4qJ+Cm3hf0/4m2qy2N0SCXYUXcb5KHAWbbxDtJHEBI0JfhrghdID5EI9FWmK5WUZVOfRcHsLXUFw+l8NDE2+NXHHaQKM94LIL5xfgPAdp1REHkzJN5yF+FdU4jUgMdDSNkc6EdnlnaP5jq7noCZH7P1BGAOB2nFCwejHKgmS1cloWPsBq27D8CpCy34dPZst6pVPaF38gzo5dam+L5zTUQkwsU76cr6nYsSEbrYPqfAbTgRbVykXt3F/jwQQzbPmvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0pm62LHBdv5gzvkZ8xaczpUCHXgUA7n1uyQAluxMOE=;
 b=h8nZ7PRRBPbs+sWn4gOJWsU82pKq8kJ4fISrw70H91PAQDJLpoG6b0Z4AZZwTu6+qRdmf+/cv/BHYDk2xhSiRiMaX/7tcjpogPL6hKXZrpWVGkE62/RC+PNckuVMGdTN8jfQ/bgv+D/baE0lmarr9qoaXUaNustJg2EJnXdLBr2YNbazrJC1ybiOG8rFKskQsiM19IbNrKrg4ou6CRjd+SziEOWbemliqcLRi3d0i+u+bQ+AeQt1UsJ+iXEAlXK3EZ+BkVvVsz512sr6auC+K4Y2TN+pCzzVnvbAY2wmF/qgfTcN59bL/mgj9iIOdDEqV94H3Mx/kt07UZcmjVGNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0pm62LHBdv5gzvkZ8xaczpUCHXgUA7n1uyQAluxMOE=;
 b=rGf4/Amhtf3Xmk0VgwUlj8I9jnVzV2MzW45UxkeT+LgJj9bSc9n9W32VNQ11ZPgYCQFae5kw08YDmKJ9ge+3VdccOaLRUP86gvy4WEa7Oz6iW+N5y37SA+ypaJIBLK/eWmC5mK6wsCmeufVlo+htJgimYd1TUd4bnZq5QCEaNvhada0fOOvKr29PR42F0njAlGxEV0uByjL+15eaKhUv+5/8W+pKPWUNUt/8OvxrDXDHa3ve5jccQnSOB7ZkKZkQp94duuLodr/aaKol2rbv446tt8L1L/I5QHN+U8qdViXF/nm7OY6SM9vYf3T7+9H9zYeEiX5LwwTy+JuCA4UvHw==
Received: from MWHPR1701CA0002.namprd17.prod.outlook.com
 (2603:10b6:301:14::12) by BN8PR12MB2916.namprd12.prod.outlook.com
 (2603:10b6:408:6a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 12:53:38 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::3f) by MWHPR1701CA0002.outlook.office365.com
 (2603:10b6:301:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Mon, 25 Oct 2021 12:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 12:53:37 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 25 Oct 2021 12:53:33 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v5 6/8] vdpa/mlx5: Fix clearing of VIRTIO_NET_F_MAC
 feature bit
Date: Mon, 25 Oct 2021 15:53:14 +0300
Message-ID: <20211025125316.67664-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025125316.67664-1-parav@nvidia.com>
References: <20211025125316.67664-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25708ded-4a2e-4bcc-6eda-08d997b6765d
X-MS-TrafficTypeDiagnostic: BN8PR12MB2916:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2916B11DB6B719662FEB56BFDC839@BN8PR12MB2916.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX1Lv6hfKGFo2Nmj2L3js7142wJF4ANckxl5l2KXmZ/MMa3VxFxHt2wx3sGyIHUJSblKMIm5B2/53fF03T+KnKTRSsPCOFIRKj1ARDGAyeOiJ10mdnRoRC9nNj2Wgz3JShRvh9KiXRIc4I6xahVV1DYx/eiNuOCYWbCAzOo/g4wKQfAQZaH2qFzrCmrCyNQDOLskbdMLUSqZcNufuxWQk/wqJ+He4KfMeNHoV1cXHdVql+LKEi5mWRFBZInT+X5o7l98SJWfyyStediVJCce68iK1zlT3JsGU+Tq2eFyxqU4Gd877FEvwKSwd/YA5cIdYHUJOiFjTWBcDXyWG0WqVmIxwbWlXUIFL1YCC9uGKrogYqxB4j+hfIa9CiG6GfsxFCkShrHZYr4AXNfPd+32qcszwD9UEtfisX4lSM4r9cPxmecsj7WJZCGkrY87W6cYBtpTEs/6Mv6jHkVIecBsPIcQK6fN53bDgSakIzHjT5mFyRcfkLxdH1iidxHXPWvQhEenVfE1MxUr1tJ00N+BnZOLmAZXq4Ll9M8h/P62n5XF5XIu7YrzraVU6No0E0SHE379LTdgWc7F8LJC2+AgH9y+/+KunqZmHhM5g+7JhymcWgk9BMXhoETqi0jw/JMdYH/5BtgvgdDBlm/c38tDxUu/X2YfCXel88U6YbZVB59SLZkbuqitmiIaQMEwnIU9SJuKWChPgFTMwtwDw8B70w==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(54906003)(1076003)(70206006)(82310400003)(426003)(8936002)(16526019)(186003)(26005)(86362001)(4326008)(107886003)(5660300002)(47076005)(7636003)(8676002)(36860700001)(36756003)(356005)(6916009)(83380400001)(6666004)(2616005)(316002)(2906002)(508600001)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:53:37.2963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25708ded-4a2e-4bcc-6eda-08d997b6765d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2916
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

Clearing features bit cleared the VIRTIO_NET_F_MAC. Due to this MAC address
provided by the device is not honored.

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
