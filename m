Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83493C43461
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B16A613CC
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B16A613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22F0C40578;
	Tue,  6 Apr 2021 17:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xKmcjb9ulstq; Tue,  6 Apr 2021 17:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF47440575;
	Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2347C0014;
	Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 671E8C0018
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5460D84A68
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NgG68a_wNY-d
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8763484A6C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f63sLL1XzbyCEw7TcxEFQs/4QRb08HTFltBe4AxOeQVAvsrbz5/Gyvc6cHfRv2KW4+rkS6T+RBKcIHwD4d9aJTxQAZTzqFWLlTxzHuboLyAZ0nNTZNhOu9M38Oz+MnbdG9Jf0YygrHFLCO+0YDQpgYxkIX+B7gcfsOQSl1fdlddIMIhEhYRn2potyLHU+pls/sTmZm560E6UEq/a51RBru3RR4ac/z5bCMMmlKLlGRcgd+Fa8njadRhujVvLyHR6OdluuzUpAwTRmTHUVzK1r0+XMka3z9LJ33N7Elie2ncXzdOs6pm3h184fa4SUz6XOABbL+dPZxNw0ww665waaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stIP9XUL5wsvBd9b62MaiF6+ChYA9rdyPcttKunGzyY=;
 b=FMknKh21RTldCcAhr0UXjbb5abktXLhjevVSuJ3cg0jkjbke7c4hDSUaBJNY+k5Qyd6XQIYS3C9qPAXIvNsLkJHkHYHPZOwsKk84EEc0vSFjTro/Ev3E+OTlo/YQyGi9A/NiZLAYerzbTHvzBdwQbzJnmWIF2Tj+tiZKKQ1KHmJAVEDLZQkF3SPFusczcrx4ty7uLVSlVXYYyD78Hlv/ROFEBH+S6YG9bhYjS2HJQ8d3cM2XSK3kPNeZdcz4hHaTsZgXyvwU6muiP1nE3/RYy5b+LD51/JalJVyxMHN64CXV2jqyEK9JiiC1vTU1+zjMexh9wdArI5TzqV+S492iNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stIP9XUL5wsvBd9b62MaiF6+ChYA9rdyPcttKunGzyY=;
 b=s7eqaQnciAdm5HBabIt3x/Zm5/o83XY9UWNKtEZm8xRadLoM3eyGill0GsTJvXi3MiXdi0vOKXBLg8YO15msLZB0vKwPzUIaQ/C6aywa4MloVovOjyAzMpBXO/HGsIMPyHMMF6A4XJ5ugxv5t50aFjTMKbDwx/77rF9nfGmMysI4P6z47gH8nMIEU1y09W18AdFGDGa5yioXGYPx/+uAS0J71GX0HUy9JDRnfW3oS2+GZgeDn/uc8NPP9RBpIT4UBcPhDg3kNjmrxlLOgQ+aqhBlyxygiR69PA1R1Gdbl43riW6G1Jj8HB3zBBvFWX+vQK8mW8LWLp/STk6m2KjAqA==
Received: from MWHPR19CA0067.namprd19.prod.outlook.com (2603:10b6:300:94::29)
 by MN2PR12MB3038.namprd12.prod.outlook.com (2603:10b6:208:cb::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 17:05:24 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::7) by MWHPR19CA0067.outlook.office365.com
 (2603:10b6:300:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:24 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:21 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 14/14] vdpa/mlx5: Fix wrong use of bit numbers
Date: Tue, 6 Apr 2021 20:04:57 +0300
Message-ID: <20210406170457.98481-15-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7983da9c-3152-4490-0b1b-08d8f91e2b32
X-MS-TrafficTypeDiagnostic: MN2PR12MB3038:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3038B0DBCE741C7E709A3C57DC769@MN2PR12MB3038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/WGYEbvd6nFAiPTQ5MOgHRE2vOCVH/3AESxdaotxkKkDabfqhUAt+khbtjfUTw/ocbI9vmiXLtjQ9Z0SwCJjFTu1p/cc5k6px+fEfDrj7oKTCnDNQm7utPaaUDnpStzDhU79xdfPJfUuGcDWV0+Fn7a0u4MbwbO9vAldUoCvzZNS4gbQVF0BriOK8SStML6PoCU3CqjWDYQXR9O5j+zBzDNvhM96TXChRMf3KPj7OqZkLG01cDEapuK6LD2TWrXRnS7zXQpNy7PuyCf+93e441HCE4fom/yUF/OV3jlCCzXpOZxK4oHk4o90d9FboVGEi2cSiUCB+bqxXJeyEhW10X3mWjAEaLqmwzxxE+syuuVR+eYQbUPcOhVOj197YBWEE9i4mtA2wdoPRwAIBQeOQ0ESGkWgcERxo4GuTtUgSMqeS8a/FznHBtuCFJnAm/2u0qB7wnEVJUBn4bjEiEoWsPFeQXRc/RWeywWJut6YX7sP1JUSdQOHTq2yPqmZ0gAusm0u/BWnEQDY0gyjEFWWWWCsYWVoX607Ryv2XUqYHaE+c8W5vXP6i5PVMVX+/8n487vVhkVoSerSFGlJf1vydBae05CY0t7kLz85+xkwoIKTyz2s0CO2jeVupOAoMKVHY7bzPFPVuS3zOb6wWvG0CW6Vn0R8PhOE7gr5mIJaow=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(6916009)(1076003)(6666004)(86362001)(8676002)(186003)(36906005)(316002)(54906003)(8936002)(70586007)(36860700001)(36756003)(107886003)(426003)(5660300002)(2616005)(336012)(16526019)(7636003)(356005)(82310400003)(2906002)(70206006)(82740400003)(83380400001)(478600001)(4326008)(47076005)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:24.0960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7983da9c-3152-4490-0b1b-08d8f91e2b32
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

VIRTIO_F_VERSION_1 is a bit number. Use BIT_ULL() with mask
conditionals.

Also, in mlx5_vdpa_is_little_endian() use BIT_ULL for consistency with
the rest of the code.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index a6e6d44b9ca5..3b79b5939c7c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -821,7 +821,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.mqp.qpn);
 	MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
 	MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
-		 !!(ndev->mvdev.actual_features & VIRTIO_F_VERSION_1));
+		 !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSION_1)));
 	MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
 	MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
 	MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
@@ -1578,7 +1578,7 @@ static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
 static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev *mvdev)
 {
 	return virtio_legacy_is_little_endian() ||
-		(mvdev->actual_features & (1ULL << VIRTIO_F_VERSION_1));
+		(mvdev->actual_features & BIT_ULL(VIRTIO_F_VERSION_1));
 }
 
 static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
@@ -1985,6 +1985,8 @@ static void query_virtio_features(struct mlx5_vdpa_net *ndev)
 	print_features(mvdev, mvdev->mlx_features, false);
 }
 
+#define MIN_MTU 68
+
 static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
 {
 	u16 hw_mtu;
@@ -1995,6 +1997,9 @@ static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
 		return err;
 
 	*mtu = hw_mtu - MLX5V_ETH_HARD_MTU;
+	if (*mtu < MIN_MTU)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
