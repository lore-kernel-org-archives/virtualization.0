Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88428374E7
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XK0Ej9Ov"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3912E83112
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 10:29:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3912E83112
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XK0Ej9Ov
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2eiWFAdFAGhB
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 10:29:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2416::600])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 056A8837B6
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 10:29:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 056A8837B6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8TjKlLRcs3co8+00FMFEoqTn7gwsEnCacYwMPL6XJda5wI0GAb3yU+VLc8lXu6Uaqb9j3kvT3zU4UK/sCj0KM+JcuOEvMbjHiZKRpo61Va0pry2yjCrY0FFf3TccG9V5vqt1Unf2rwuO4qhkgBFynb3NtWD24vGoyLG3/tfNiRFDdH69/x3HDDExE+OvzXERTkYTaHomV3T/ECN5VYcA/zA+vYrwykN6lONgk3X/lLu9refvktlDl0nLdrWG/wLR/Hk+qjCAV45z6bfxBaxxfb+91qBw4skfvE0NrpPjfeYYcaXrR+XC7KLHXj4BN9YT4F+y7nosiuZ9tT03KKV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ixQtpvTNaYyDToUTw43Dlrc0d/yTizWm3gUpC5jls0=;
 b=k2gzYb9mP2m8oMoCPaT/QpLHoVUT0qXylcOp1XYB18+Od9LdsyJ2lIxc1u7hsnyjmAXCVoPjnoDBWrgeSDQxSuMKxnDKEn1sqpzImsYOgydl3EqEtFc2CXhHDRQFAWff2Lv0wYLxhrUfW0G6pmSJJrNIyoT/bVCBI//IezTX8yGoH3Jm5puDJ0K3T0rrjGNd7XAwKzbCduhfWg4TzGWvK4cnXlvDtMN7Ph0qwQVKGtZzrvGbOpml7o09B9tLOflpsIVZDHyJkQ0+c9c0diAHc1hEV4YXMjtZ+U5IWgwdtufXv8Yq161R4wX5WtFPeaMN+Tj0OSh5c4mqVweodmZpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ixQtpvTNaYyDToUTw43Dlrc0d/yTizWm3gUpC5jls0=;
 b=XK0Ej9OvDCF8PMl2BPy1TU8fHxj45Tj25bu74ilvqLK+xtVt0Y/RpPj6dKDdWorzVbekWWiPVvns6gCM0MUo4SRxz118HPZCpE2xwRxD8lHtQyiqxIZycIOBqbJ3NT+aSJ5yI9ZOWSzTAJ3E7xTv0pL9lk/9vektMFvVTfG1RGQqdYghEZuCLCYw9IBw8E+8LoKkkHzLcrl2eqLXTDcCZ5mSwbV9LvAr7nSR+pquHxOx9jSefSOiiXq/6S5XcIp36HS+lEffdzBA4n4/+6+4osyYt50jDEkOtGTi8S/E/taSRBw5myRv2oSjZt19pVCruQQGPRU0pqZrQkirSHkyaA==
Received: from SA9PR13CA0052.namprd13.prod.outlook.com (2603:10b6:806:22::27)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 10:29:12 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::63) by SA9PR13CA0052.outlook.office365.com
 (2603:10b6:806:22::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Thu, 7 Dec 2023 10:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 10:29:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Dec 2023
 02:29:03 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Dec 2023
 02:29:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Thu, 7 Dec
 2023 02:28:59 -0800
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex.williamson@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
	<jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
	<parav@nvidia.com>, <feliu@nvidia.com>, <jiri@nvidia.com>,
	<kevin.tian@intel.com>, <joao.m.martins@oracle.com>, <si-wei.liu@oracle.com>,
	<leonro@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>
Subject: [PATCH V7 vfio 1/9] virtio: Define feature bit for administration virtqueue
Date: Thu, 7 Dec 2023 12:28:12 +0200
Message-ID: <20231207102820.74820-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231207102820.74820-1-yishaih@nvidia.com>
References: <20231207102820.74820-1-yishaih@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0e8526-5b13-41fa-34b4-08dbf70f5afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gESKLtPY77H6oRbfBiXgbGOWE+HJVh1/c6Vy6a0pRQavK0T8rHvTO3qJr83DcbsAlKeiAmRplgToFZBO5aBycBf8/mnqOxZ8qIJeJw4FmUDjGD+INkaWv+m4FdXULdD3h2oD+PDoIcVN3Cdc0uj0VlvEqJDSDOAVrxMFdOMhNag2tnoIqRSEDSe3k6WO7j+EDMFyZRkdrvZUh26VwEr7XixtY+KL0AIWf96BHbKUYvfMI0QaX9DgB3Uu+Lw01EK2iEhnytdCJcf/nV4WWI6Na44NNniTndQlccbMu03H7sgHeK3uy0amff7ubBDM/QAhX5dEgWCQP8sGWGnh8A7vzlwx1gG1LzJyeyFoN/hXznKW3hTpozwPpFLFz2uxGIBmH5dvKV+Dt4pbTfy3m6M+ljgPw0pwy8rTg7LogVHt7y1QlVhepVg2Vv7+eaa7OREbFM/JwMGtyU3fAYGd4sTkD2OqnH9qxae50gsj+IW02UD64Zmv1Znu7yW/YGqA7eC4JwHQk5o4sjyCX65WEd3FYas9EBw3/+cgnCsMXEGj6w4ln4FAX2WyhgNBAXKGsNSCyXhikqF2Q0cV6t9mEZN5zQFnPRWtEmSGolXhmyPQwZxXj2NKkoMrcm7IfmCxxxIapHzzIuegBUShaosk5lum4VhegpyKblABkCdZ6Mn1TLb2CwywhB6QWo/asiYvI01REuckyJFpGmBK39YZFfuaP3xfCw7eqDLcsKZu9iNhHL+GVK9MiZC1BUfVN1MbbKsHSHePA9ckfbYW1sHIEf5Xow==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(41300700001)(36756003)(5660300002)(40460700003)(2906002)(7696005)(6666004)(54906003)(70206006)(6636002)(70586007)(36860700001)(82740400003)(356005)(83380400001)(478600001)(47076005)(1076003)(107886003)(8936002)(40480700001)(8676002)(2616005)(4326008)(86362001)(26005)(336012)(7636003)(110136005)(316002)(426003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 10:29:12.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0e8526-5b13-41fa-34b4-08dbf70f5afa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916

From: Feng Liu <feliu@nvidia.com>

Introduce VIRTIO_F_ADMIN_VQ which is used for administration virtqueue
support.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 include/uapi/linux/virtio_config.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 8881aea60f6f..2445f365bce7 100644
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
@@ -114,4 +114,10 @@
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

