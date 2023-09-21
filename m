Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAFAE71060
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 12:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50B4B420DF;
	Thu, 21 Sep 2023 12:41:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 50B4B420DF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rkO5UX95
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Hiynwa_x4T7; Thu, 21 Sep 2023 12:41:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B373A42029;
	Thu, 21 Sep 2023 12:41:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B373A42029
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CBC4C0088;
	Thu, 21 Sep 2023 12:41:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCAD9C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8939E42029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:41:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8939E42029
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NeABLe55AX4M
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:41:48 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A3DC842033
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:41:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3DC842033
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leUTKgPmd/NGH2faN8OGhj6BSrZsKZa1zMBYG/Z9cvCml25lUIZtyDd8ViAT0tbOxqdNGP4UQbLIXbLfTaFs42nLm2UXdpvWSdzIRTPumk/fVx1Sm2AWWKYQAMWb5JY/mENgwCCBSlnlma6kBq6/TcsBXyxDfS4qMThcKQV3H6Dh+/eVz6F9l8dAThBoqaMTWmVhIdFvKcPpDPFAu1RXMOJKX/7s+sK4EMAZf/m6qRK9T3SRCb0g68whXSLEE6B0Id0PDuymL7LqSmR3E2T1ZM9enxH7Yr98ZeQpO/IcKNYz+5GDGvIjIJZ0k6byrED/7n6MZdczxk+1mdQc+2mIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK8oVP00vpc6UQUa3hMRt2UjQkZntth7M63FfSSA9Po=;
 b=gOU7tT+BIblKzGey+GuFQn/TqBfgNtQ8IpoG+jQYX+a2tSwDCSi7XsoPne0qS+ej0JDQwLazQP8r5gF5ZrKL07atNr6311eLo30JNqXHlXyIAaUrHdSy2zNVbgCzWY50reOFdPySMHuKfBlyN00yx55cS8IVO9XkrIzlBocoO7VOXSk8vLe4O59rVvnO8o3uTxzAI5xJXn/Rctlxy0sE+v9+KLrtHfllS1dxuCjsXbACDsNatc7znjOyxK75wKLeGtYf1GUfqVguuQmzFxD6yjImAg5h0X/7uWAr9Vrn7nGvXa0+Eoc8BMXtTaYbb8tNwVmINtdt3hSnn5SsShDwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK8oVP00vpc6UQUa3hMRt2UjQkZntth7M63FfSSA9Po=;
 b=rkO5UX950UB17sJeJ7AJ08FXQ/MIc9+eLT1nmqFz0rLZqbxJuH1shOb9N8q+oxBFebHgnMHBDGU6n5i00u/BKQiigM/Uz6k7Hg4aCs06V09D06FimiTjiAP02iVFRhuAK6f+HlmjKOZAZ7EoSCW8BqsluI12Ryf92SMd9AmjaubRnvhjuqItw6wSDRh2sRGr0qzW0IOU/koUvh6LQGlNLd4ov9Y64vh4QnbOX4n0wjEfh1hmD1T3VRfNPlVEe3UY0NKu05S4k8awG2CRdRDLtKKdfr2OjOzlbvalcUS7eey2OMKhzPwiZwUqhhzR/JNYlhlzXORvmUt0H9+jjFRfzw==
Received: from DM6PR07CA0094.namprd07.prod.outlook.com (2603:10b6:5:337::27)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Thu, 21 Sep
 2023 12:41:44 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::11) by DM6PR07CA0094.outlook.office365.com
 (2603:10b6:5:337::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 12:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 12:41:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Sep
 2023 05:41:31 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 21 Sep
 2023 05:41:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Thu, 21 Sep
 2023 05:41:27 -0700
To: <alex.williamson@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>
Subject: [PATCH vfio 02/11] virtio: Define feature bit for administration
 virtqueue
Date: Thu, 21 Sep 2023 15:40:31 +0300
Message-ID: <20230921124040.145386-3-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230921124040.145386-1-yishaih@nvidia.com>
References: <20230921124040.145386-1-yishaih@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cd67ab-82a6-4857-d536-08dbbaa01cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uQMAaRT65k8HW2Xn6W7ojGMvBkxIJ4C473ybO0I5bA6khl1N8cPQUJCxomhbLHubWZzAVVUggsZqk7V2RAWcSGJHNnz5vGPwhkN8LpVECC5Iin5dFUj2aX53h7IwD+o1AKDS+G1KOkFG+Z/UvcxntnZ79iSrQNLNbUrumxMsvbmZtWsEF5yRxvY1azZ7loymYyyJ1MpjmXIqqhd0E94fquNoKxDY3tmF2HDdXFORF1bcinNMvsC+7QgsXZPzMcfPA1afBXGTitJjzcziJiLMX16TRkXnFnLIIjlvZrAgeQvRe60o8i84QyxBalVTY2BfD7XoiGU/ay/aYWYsX0K3x8GZYls1C4ljOfULojSq3ojpzEZC67YOTKRYalmDZGSLBNXm+xknX+p/WSEmtHGBqYb3X77ZAgT04bxn4ZGCI+1SUsnjov/HCZsAl2/ofbaGsLzgyGh8R4SGV0q//dIf2iBAHQd63QykNuZbcJ0TsbWQSEZzzmSG4PEn+ECufr6dy5v0mPn19wgBSHCCgkWn1Zti0owMJq2SbrUvjbnSdrujRzwvHIKLKmiTsHwwz936FWnNboY8P2lpW2wSSHU7XAQpCeFkvlCq72UcD5+4dbUhsgqZB+hMAcaR177QDdD1K8rVp3vwSpjKVhdO779s9hmxRklXTrtglc5otgkPUgkp02zY7jkkoLf6o2UAfS035thfzP0GGQDZelN0fb8CR7KF4wX1wA0l9CwAjYWBbvLr0GDf+qcdQ710wpcrBFT30afRhmcJJBltnxEFP6/yQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(7636003)(356005)(82740400003)(8936002)(8676002)(36860700001)(26005)(2616005)(336012)(40460700003)(1076003)(4326008)(83380400001)(107886003)(2906002)(426003)(36756003)(47076005)(40480700001)(86362001)(7696005)(478600001)(6666004)(5660300002)(6636002)(54906003)(316002)(110136005)(41300700001)(70586007)(70206006)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 12:41:43.9960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cd67ab-82a6-4857-d536-08dbbaa01cac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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
From: Yishai Hadas via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Feng Liu <feliu@nvidia.com>

Introduce VIRTIO_F_ADMIN_VQ which is used for administration virtqueue
support.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 include/uapi/linux/virtio_config.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2c712c654165..09d694968b14 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -52,7 +52,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		41
+#define VIRTIO_TRANSPORT_F_END		42
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -109,4 +109,10 @@
  * This feature indicates that the driver can reset a queue individually.
  */
 #define VIRTIO_F_RING_RESET		40
+
+/*
+ * This feature indicates that the device support administration virtqueues.
+ */
+#define VIRTIO_F_ADMIN_VQ		41
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
