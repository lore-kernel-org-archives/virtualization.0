Return-Path: <SRS0=rBDE=PJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD823C4332F
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F0761501
	for <virtualization@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70F0761501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4CD1C40735;
	Thu, 21 Oct 2021 16:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4dIqx8Y31Z8; Thu, 21 Oct 2021 16:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 820DE4073E;
	Thu, 21 Oct 2021 16:35:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A0F8C0036;
	Thu, 21 Oct 2021 16:35:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E969C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D55760F1C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kARtX5V9U2T8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A241A60F30
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 16:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+pIUwZnE3HBAFjAInmvO7gfkBfBcC2/OvwMQb17JMjIKc1Nwo5oQ4HP89UNEtit0s5UDQcM41WrQR+fkT1mobCiziYArMw/3s5HXHH6Tel4p+++svatDIP2KSEyZ4gb2gVi3G9CE4tIW0rCDpimMfmT1fm2i29ri5jzVVa+6gh9WVK4U3X/nEnK79CghBvmBCDUKHNh4vcYO0u+15NaGZD0STwIZ5aP6CxFQylUO0qMaxR+1ZiLXbndZhaI5ud7NxkcljPR6LEnRiRdsIqSZ8/m2leS0BifykaR6QaAhxzItQnR25QGDL783YKPMv5HOpFpDMNQjGnZcxN8c/N3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PkwD7FFPzdvDL+t6YfNN+5YyBYANN8v91pIjvJuouo=;
 b=VnuwGKvMwGpYCUk+/Z4Xq77w6nG7n5J+W0wkUWV7QzH0PH3b49VSKvkRQ3p0B7/sm//xywRsEycQ09peRPTFp9S0msy7YGtZNVXczNP6BjfQ6a/bJ1pSlftc2pyoWrfkUXEY7z7ZblsT/vYE8EbdJGAy6I6mul8tvFg1mlSmBV5uO7Ry5XAalTf17PsWXxCdTroQvEwzfb67TXNQ09jXCdiLlw4f5ZB9xeiFEGpTjGji/1HzHk9VFN4w8aohiTYafdFuBYbs6HAaTYKh9x9ekuSD4NV5kdowpH9bPsOzIavn79V2ejsVU3mT3n2sLJAOQ4CIjAH6mXKqscrWXRcrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PkwD7FFPzdvDL+t6YfNN+5YyBYANN8v91pIjvJuouo=;
 b=qzbN8r5TAz8XVu+ovlbR5+14axeOU7ZcRPQN1EJexwIgiNIaWVnuTriBIMa4Z4REhYFHmQ9CAVxddpbekkk2AKn7cwBiXttlWVtSU8etYZyQCjRwdV28HR6OLz6ujtP2Eskl3EEi5PFymCCglhEEOhxeFS6cO9jnhZfMW/d9MRsgyKUeQgQfvVLG8QY/d3GuxIF+KanfgL+XaEpfibo61gWzu+YeYAPJsnQnvgO95XxjWmorus4CKbtv4MwCcsedV79PrV4B4vbBa73npa2XKcfqPVsYit4AO4lt3hvKGCA9qQaYJRZIQKpI+l/lSKdua8BKfgFx4CHp/SLrlZAEfQ==
Received: from CO2PR06CA0065.namprd06.prod.outlook.com (2603:10b6:104:3::23)
 by BL0PR12MB2385.namprd12.prod.outlook.com (2603:10b6:207:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 16:35:35 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::ba) by CO2PR06CA0065.outlook.office365.com
 (2603:10b6:104:3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 16:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:35:34 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 21 Oct 2021 16:35:25 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v4 6/8] vdpa/mlx5: Fix clearing of VIRTIO_NET_F_MAC
 feature bit
Date: Thu, 21 Oct 2021 19:35:07 +0300
Message-ID: <20211021163509.6978-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211021163509.6978-1-parav@nvidia.com>
References: <20211021163509.6978-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ab5ca71-b484-41b9-7e42-08d994b0ceec
X-MS-TrafficTypeDiagnostic: BL0PR12MB2385:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2385BE3491B8F8EAB53FDBDBDCBF9@BL0PR12MB2385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99G9Qx4uy3V0nw+dW+u/1UzTho8OlBtQ+wSanA6NFpDOZGXe4BzSlExlZqhJ3lJ/fLtgFu/bQjgai0aAzZVjtHbI1EiQOYffR0DidY5sTNERZXBhbTUORMSID4NUOZC9NzlqWt6Bf+Px333NOnbhWqDLh28L2SW/Uo/28KW2HcqsTjhlvGWkXV7vnRhGUFQNsvk4esBvlLLzQnxOSLuc0+TqGo+EGa1KVaDOHzSJ8CTibfwwWuqNajqvR+1GpcaxDgP5hnehvW9T08usZvKmkjanpia5mlRj+rsKbrJ7HWV38vPckCbm6JJUzP2sDwKGH1EZRERFYYRmkXDjozX6LFfREyj81MR4NNzuIaT0GznUGuQoYMUixY9QQxrjWryvue7o0PALQzA+enJbmN6x7zSjrwlggyADszf+q7m/vvMRooHD39mlMl6OofE+ulObiDfgFyGD+GnmHm+aSszAvyDr4LCxLRDZQfJFbXOS0otfDJTZhJsWWbt5XydwUdwqMshyHYhtw1mnrc2TNkd4r5VVDiVQZorNMW0y6MwWGeupmD9x7He7sGJRHMYPUFKx2CQqsK04hAb9UysKq/rX7qwSOJR5aF6v40JMjqWZuyEIrdrHe91KOURWD2MnQDcEkdU3aBQqXIqdEbaNF+7X3silhpm5rvt/0zp+6yiXdVHjBV70zTATjHwWMLKWxYKcC6JASs7jLZamwYjn07goVA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(1076003)(54906003)(36906005)(70586007)(70206006)(83380400001)(2616005)(5660300002)(47076005)(107886003)(8936002)(356005)(7636003)(2906002)(508600001)(8676002)(6666004)(4326008)(36756003)(36860700001)(16526019)(26005)(336012)(6916009)(426003)(86362001)(186003)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:34.9869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab5ca71-b484-41b9-7e42-08d994b0ceec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2385
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
index ca05f69054b6..0a2b79887085 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2192,7 +2192,6 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
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
