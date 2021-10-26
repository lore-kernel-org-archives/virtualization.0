Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE292C433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC4160EFE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CC4160EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43915401BA;
	Tue, 26 Oct 2021 04:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aYXt3xi_A4iL; Tue, 26 Oct 2021 04:03:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AEAF640220;
	Tue, 26 Oct 2021 04:03:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F6BBC0023;
	Tue, 26 Oct 2021 04:03:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D116C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 726784032F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NF-LCkcPx3Wr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A16BC4015F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+ev2+RkIMP+PLgaGPhXLtNjYjMcIkLW4atbJKVEh//ijxQzkOFZ6ANDG79uiVL4NyIKGqVLST1okJdWEIOzZdplCmaR2HJNGL9gzX6TOyRY1AbCr64XxPeFUBIgf5Mp/NvHyrjYZ5ag0/fQGx9FdPk1OlZ3ejCEu1TGDHZH8+FQTaYcGg6fYyoukUhSAAD6b7lQQaF06HL2ZLqRXy3WijJO0DjXrs4SSLRT0Dc4+LgzZdZC9RZv5pmeZubkhmwzJ3kpz68UmdqWDTEFnHkB0LZ0lZN05U5eLkB46O3ahnBuFXLlfBectlUr7UwI7qTIMDmjFBu70YGIgQYB/avWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c13Db7eoqbsWiZ2UFK6oOKjRpYz57tnWhHnQ1bRWRY=;
 b=R6iU67bS2zzxmtThFL9Uyo87UzxBxPJOjXARr7eeXYqnp2XUZtfiCpc4Wl/8WPwsBvPzUzUj6rVvjDWkBYud+vqFjhA26dAkO4vS6bYOGIb1WdwTXhfNlt0XTOnFh0y2puC3Wc1ld00ZVabUNilBeJRnFVjggFukLC1iIZEsj7VfviZMHDBUphguuB+INw+VUvh33n2WUvK3pqXcbQUj8PPoHk5AAJ0FihSmNNs7cvMtABX9F5BbxhyPzfkVcVNX6ifef+BlRvUdKOPQXGfKg8xptRpoQe9cY86uF5FHbMtX+gty88Ma5rEsYiGPh1WNFHD9J4+4U6wqp2hPLPq5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c13Db7eoqbsWiZ2UFK6oOKjRpYz57tnWhHnQ1bRWRY=;
 b=ISdhkwLIC8ka5kgoB1tBwaCD1LLDFCrs7mexs9YPCwFhraVRDs/reqn2AZ6zxpIildzj5VjD6Kv/kOPpd2RMznHJ2UxYWjOBPNGSygGZV4cHu0y4yr0dfxvuCHEzAQg138DT9qQnQ1aNPs2oVsPxnSiQVndwCkWsZOsIRhJfdEOG9s9dgboich8pKCxk0kQ9xIUIbbY8Smo2v2RAfBV7fnRslbljW0GdgOPAFBPiVHwkhgwC4B5ETup4jQLG2/Evxk7A27Hcd10emTcP2OF43/P/jPD1kRhW25HlSIqz9uSsWxOLjw4WfSY1AEQDCfEGMIr/GzWlyIMRNCcXgI2DaQ==
Received: from MWHPR2201CA0039.namprd22.prod.outlook.com
 (2603:10b6:301:16::13) by DM6PR12MB3578.namprd12.prod.outlook.com
 (2603:10b6:5:3c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:03:05 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::f7) by MWHPR2201CA0039.outlook.office365.com
 (2603:10b6:301:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 04:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 04:03:05 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 04:03:00 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v6 6/8] vdpa/mlx5: Fix clearing of VIRTIO_NET_F_MAC
 feature bit
Date: Tue, 26 Oct 2021 07:02:41 +0300
Message-ID: <20211026040243.79005-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026040243.79005-1-parav@nvidia.com>
References: <20211026040243.79005-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27ad6909-1d40-44d8-1255-08d998358340
X-MS-TrafficTypeDiagnostic: DM6PR12MB3578:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3578C68FAB789E004CA37937DC849@DM6PR12MB3578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3XwD9dUtsZhhKygw8KGqcX9XJlI7s11RL8ayOQX/vws1o2AFaZevd1THITMceOqJUzy0yPOrJzNWKPqW5/g8uSw+AA2ee7JO6bDtvtrJrseEXEXYALd/530Bg5hjecygFTbbkUIJl5fRug8VYjKAvp3kVtiHJzqc7abJ5spVlr6XV0tD9OYW7DcOedhvTbXZBePFVSXe1TcZm7AN2gRMKNbEJyCCby9vDOElbzzpDKp/PvpDHnyaHkvUXtuto3/O7y3xI4sv6iH80U4B4zfVBDRdeCGujtO5dq4Pl/ZBtQQct/BmNROCjWpZx01xpsLjNkGDgyf/mERmodQpXCG5br5MTZuDB/swF3eHF2eu1R2DhQhGFE+5mQnBQ9q6TBg5j1zG+XH2SuSP/BzgeGwDFDlDbL9hXuxRTEHJubB7qlWEg6c87MMi61EJwpPqgueSgvTPC/T3jOhPGrgOafAW0F8iXZItWkuj1GDrBEzXwrf7/mBW02G4qFhvd6A4zJqk4oaveQYkn+urNagQ8ANV573hSPvESHTmpNf/PbJYuVBUsOUxpF92WiBFKsaYkNWxmdjEKdT89zyQ39OE1Zm5TbNERTq4+Mq9GlPPs1POx8XzjUaOCfd+f9JGvqcNcIp+VAkF6y6CL+RF0PP/CzSUcOJCuW5C4aGFq1OCTMXdBVzN1VSWo6++tFOAiQRjh1x++CJ0gZrkKADISt8s9HaAg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(6916009)(5660300002)(186003)(26005)(16526019)(83380400001)(6666004)(107886003)(508600001)(54906003)(2616005)(8936002)(7636003)(316002)(70206006)(2906002)(356005)(8676002)(70586007)(36756003)(82310400003)(1076003)(426003)(36860700001)(336012)(4326008)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:03:05.0669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ad6909-1d40-44d8-1255-08d998358340
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
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

Clearing features bit in reset callback cleared the VIRTIO_NET_F_MAC. Due to
this MAC address provided by the device is not honored.

Fix it by not clearing the static feature bits during reset.

Fixes: 0686082dbf7a ("vdpa: Add reset callback in vdpa_config_ops")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
changelog:
v5->v6:
 - expanded commit log description to indicate that feature bits are
   initialized during device addition

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
