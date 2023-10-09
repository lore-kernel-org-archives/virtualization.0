Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95350E95A96
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 11:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 068DA414D5;
	Mon,  9 Oct 2023 11:24:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 068DA414D5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E5Fdl+S5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87Lsa5k-SG_J; Mon,  9 Oct 2023 11:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5D22B40190;
	Mon,  9 Oct 2023 11:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D22B40190
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44FC1C0039;
	Mon,  9 Oct 2023 11:24:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35979C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA77B60C34
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA77B60C34
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=E5Fdl+S5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M5n5_qMwO0mt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::624])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01C8D60BD5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 11:24:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01C8D60BD5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl/oZ7/fLgTecJO74VEcKKb9DoY2t/tEzoC1/F8J/OqdrKuRYBOx5RPdJq2+Uucy8DW/EFN22xttmmEkca6/v256vdcVZ6kHocgVZ22oyoqxzkMf8Mq5eMopmcR1R1Z/sXhP1cuhDrDOD1yERCsGzGc7qI+D8P0tfqOm15H1Nt+IGkdjxnOUu3j8zHgW6GquzF+Vl2yFSywjXff9RXsylDi6aaD1+iHogO7naoU2QVNIlI9LRd+BTKPzL/MOULey7pRyM91B+EX4UXMay+ktxtdT2Iyoa69VT49fxPujrf64QVw88H446Tys3MgZRj48fDLqsQeN6EDAZvORE211dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ks0yqKFa9s2l5F9bXQdb3gSn8cxS7t2k+S80slwQQFY=;
 b=mLXjL5ApuVmO7pBuA0qZmyockV9qT70VRNLBiSFi+DSl1813Xpc4HEAIkM727u2QOyeM2F+tR//5tZO2FNp0jYUD5OnTYKNwmD2KGXotlWGNs5agivLd4kx2wpLOYqGpfv56u9UHBSxO7skFcrlBSsbnQJfp/TL6O6FsfO2ZLRoCnPQpjysNxyv2xZa78qqDqr5kzfhlHLuetfrRNJBbX0bkzPfRuqZVcG2fDT0Ii4syKn3rfKUIlj47mcKfN4tH2e2fheCad2DI6sIsj7SWrX1BC4NVoQiHzFUTN1mhORz6XyfHQVh8p0k8VZGKE7r8DBZ89D1omuDvXjva7KR0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ks0yqKFa9s2l5F9bXQdb3gSn8cxS7t2k+S80slwQQFY=;
 b=E5Fdl+S54A5JB3fXMBXrNVsX5kI/FW4stDAsa4q1IOF0eLpuotXWViAv0TS/oRHTAJV2UOlo6exLeLrVdyH/PPSexgOaFOJrPx0C7Tx98umcIr8C6U/oFdqJej5Lu0zgY2QT7glOit3wUmumrKXnO7OshXomOnRGXCDZ7+v7E3LSuDbn0cX9AlCTieQzDRhSOpPusvEBfojRZov7Q0914UOYwJwBLCAuXHed8WOIKPE/JbgHFoHX9ORv1YRU3EhmxcO3x+OJYsidkscHpDzeVw1fCK5z+wZ03c08Ms+q4qLGJhzj2s3sc8sVkupMfO9TOJcaY9LA7hCVOfnSyE3a+w==
Received: from BL1PR13CA0100.namprd13.prod.outlook.com (2603:10b6:208:2b9::15)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Mon, 9 Oct
 2023 11:24:35 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::5d) by BL1PR13CA0100.outlook.office365.com
 (2603:10b6:208:2b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Mon, 9 Oct 2023 11:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 11:24:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 9 Oct 2023
 04:24:19 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via
 Frontend Transport; Mon, 9 Oct 2023 04:24:16 -0700
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu
 <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <virtualization@lists.linux-foundation.org>
Subject: [PATCH mlx5-vhost v3 01/16] vdpa/mlx5: Expose descriptor group mkey
 hw capability
Date: Mon, 9 Oct 2023 14:23:46 +0300
Message-ID: <20231009112401.1060447-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009112401.1060447-1-dtatulea@nvidia.com>
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac7d9d3-7c63-4cb1-ae2a-08dbc8ba50d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyeIsLVFGFhg1JtmwvSbzR+KaaobtyhrXYfrQAIMxy2FsYcVEsx6ZWcAbX65FEVJbTO1FqGaOpnuKGmAT/tAI/DEEcwca0y5qSyCx0Qib84EkXme7k3qMGMmmqPIIUHh+c7V5MObecCAbPWpVKFf2SE/wpbgFiP12akqaWQhGGAA88eEIwDTEuGex8WXno6xj2MMjzHFkwR74Vh4dQtFZO/FuhEW6ETUI3Et5jasr6yZ6J+mAQhdkP7sDKsukiCtFPb6IfXNKGYJ3Rv9TS0fhIpR98Hj5ygSzY2CSSIx1McbT0cQXMyVm2aai3qi5lV+6qCYcFyTMGU9JM+6LVxSWfWp90AEhabeivdU/c8+WIWjPjJKH4m1hcnQBmipXWyXDF+QtyXkRalWsc0HEP6U34cMi0Tc5UK5mpu1b9m+Bj7vbPbxOEyKkljGVUxu3b5t18C+VCaMHzSTO2OBqb7ubVC3QXmZczShPNS3VAkm93i/I267KGm6xof5+YxGZbYGQUqd6j1tPdWhqJH0yXv+p+7YFUVPmJdrFV+XtsGDgxxiNU2AvzdHJJMacFLOW5Iq7YmrCpPWlwrSfQbOrYSA40GY29yk7S2uHgoLvjHe6w81OyGsANfkoCa+hU9dY6c00bxZkck/d4f2URzJdsogKWEGLxQ9SZDrPzqJGtSfj4liAVhtQEU1QFS7CZBK77HCdBkC5p4OphF3EU0M6pXFjXZ66Grg1zoUJT6f5wfHsOCtM5ESum/0eC10QDomVUxj
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(83380400001)(2616005)(107886003)(1076003)(336012)(426003)(26005)(47076005)(36860700001)(54906003)(110136005)(70586007)(316002)(70206006)(8936002)(8676002)(4326008)(41300700001)(5660300002)(6666004)(2906002)(4744005)(478600001)(82740400003)(36756003)(356005)(7636003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 11:24:34.6901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac7d9d3-7c63-4cb1-ae2a-08dbc8ba50d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, linux-kernel@vger.kernel.org
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

Necessary for improved live migration flow. Actual support will be added
in a downstream patch.

Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index dd8421d021cf..ec15330b970d 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1231,7 +1231,13 @@ struct mlx5_ifc_virtio_emulation_cap_bits {
 	u8         max_emulated_devices[0x8];
 	u8         max_num_virtio_queues[0x18];
 
-	u8         reserved_at_a0[0x60];
+	u8         reserved_at_a0[0x20];
+
+	u8	   reserved_at_c0[0x13];
+	u8         desc_group_mkey_supported[0x1];
+	u8         reserved_at_d4[0xc];
+
+	u8         reserved_at_e0[0x20];
 
 	u8         umem_1_buffer_param_a[0x20];
 
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
