Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0871400A
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vto9vu4r"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E37560F00
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 09:33:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E37560F00
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vto9vu4r
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LeOlsNUthO4e
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Dec 2023 09:33:55 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f403:2416::601])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 973A460AC6
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 09:33:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 973A460AC6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXyW0l9NfK/c56mBr9lLbhFVdvUqB7rbaFXU/No0M285YcIEhQEu7iwmTvrFuGHJGbAWQtOflNQUz5+0CU4kTQSODoipcZCZ2IGnwUciZQffd8oRu96w3kQ1g2IwNL/pE/2CgMmU953e/N/7rD/Uw637rB6JgJAWtdx82xzHKbGiDt3Lkh0nzu6naCYUrUHcDnmHnB7g2KueAvAaSoq1jSit608KtYocwqpSz6mYImKirWrpg7D9/vCQwYmpPr8Pu5qo3kKjyFyaYJXcxBx1wrr/IqHlQcQQSgyQAd89LZ8jbMcp45g6Ym2EFFTR7eDL7LOqMPTg6IND8+fLxjaVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ixQtpvTNaYyDToUTw43Dlrc0d/yTizWm3gUpC5jls0=;
 b=FBl7tJfLvs6zng5k9bF3vCUsdxQIpnTy0ib0OXUVgN4lAoDq25CVBvEJZyKccQXpgaHcUj8OXN/ueqpl733q1TRE+0i1Rd6WAA2Gt6tgTH2Oz9qxj4dzlKyMJtl6nXHp7pn+Tu4nAgJcXGMj9PIQOdYYCus64Lm4xSUETn12RrxU0JLA349C0+zJmsijsyknrHX/NHdqhp3mD+EyjpBRhkD8VMWz10kPu3ViSHqytQs/meqwATGVLSogVSiw6Jo8pvNcNV2buCZONs2he5/t0bOJdHg5hJDl4HsghcUV4I/HxdQF61CElGDQLhB/MFqq3N2qIGOeM8k++FWpWQnung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ixQtpvTNaYyDToUTw43Dlrc0d/yTizWm3gUpC5jls0=;
 b=Vto9vu4rgvt29qQbCYdLVO+kCzvlzsp8aUa8GLpkcbKlpuqJJ5sbZhfkos2x+L0BKn7Krx6xguqJ2JZ7VnxyAmCPGWNY+JAIGxqj+WHHJAKOPC0OgHvUCYdkQ7zBoFK5nMlzGIGS2+WjbSzjiSvxm/wgP1CGE+2vGPt4MDgzQc9iKg4UfZWLwN4zibSshCk6Q9Wknbo6sn50d8t3DIsejkDTxGUmzhO/KVOZyWh9GviNvdFkx0WeRTsA0MBaeE3akm2sYlMDt84AQUSLcM3ESdm5Y4JUhAYycONg1HTIR5Fi8quvcKvAX3socNV6XVGWPysxC4120Vx7UAV8MUYUjg==
Received: from CY5PR03CA0026.namprd03.prod.outlook.com (2603:10b6:930:8::21)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 09:33:52 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:8:cafe::cd) by CY5PR03CA0026.outlook.office365.com
 (2603:10b6:930:8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 09:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 09:33:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Dec
 2023 01:33:50 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 19 Dec 2023 01:33:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Dec 2023 01:33:46 -0800
From: Yishai Hadas <yishaih@nvidia.com>
To: <alex.williamson@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
	<jgg@nvidia.com>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
	<parav@nvidia.com>, <feliu@nvidia.com>, <jiri@nvidia.com>,
	<kevin.tian@intel.com>, <joao.m.martins@oracle.com>, <si-wei.liu@oracle.com>,
	<leonro@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>
Subject: [PATCH V10 vfio 1/9] virtio: Define feature bit for administration virtqueue
Date: Tue, 19 Dec 2023 11:32:39 +0200
Message-ID: <20231219093247.170936-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231219093247.170936-1-yishaih@nvidia.com>
References: <20231219093247.170936-1-yishaih@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DM4PR12MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d344be-413d-4257-3dff-08dc00759d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/ymn/pHGbaCs6iOiACSbdyW/Lg7DDvFpSb+hJAEPBueTF3xFGeCO3FU0tRHADO0di9aqKwwFYpWd4+aAR5oZfMpTceRra82R72xrTgEP7iVAG3reKky78lFAz1pM3wVrMaT15S9pBx6zmKgKMG7R6/vRSQrpn1+2uzcMkCDwMz2SKY1nkJfFLcAAfdjUZPja+JwBOwF4JFwiBEB27B/4k9EPorXdXQkVP6eHns0idiB+CpdyzUWDcMJeoOHTcV9/caIRMmlY/mvyCCrFihRzSUdqOKD2S/6lD6WsBED9n4rQNWmDd4splzHVL+njn1WDZEPa2ajk1xB4BBDHX2SZrSzTfn1lz8VKULnxfpZ8LrksfOVP3zQddS1dr0lMKvxflGP3RAgOqkgh68u7fboSdt81/9s3kPbyEKFF3K+H427rdUo8Nm8M9tpuEJBIO6Kcz0i7cG2+Ha5Yz+45yj9SoIFyvZEIKeEoyESAFNdO8oLNGOZ2MQUNo4beqAwxt/NX5hzxubtgtEYpSLFpQ8vDeM/58Pw4DWTOXKtGVN2nnExw7kiMFtoux8EbERoHge71jvj4ZAnRLPMTp/FF2iuIX3ZbpOSdj16w8/00jl2E6ILUY7kA/tjwYpMfph1dqh3qe9NIGmTCslTOleIgC2C0Y2gWYRhRfgLnN46q0r7etYN0MPbN0JEO4da+4AsxbLFz60zkruWDvz3eaxfGxSk599TEJHKqEuj/A54XzZzTs3YvTKeanxo5ZIZd4NRd9Ia6ZVPn3KOXmxSHuhiKtx4UAw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(426003)(83380400001)(2616005)(107886003)(26005)(336012)(7636003)(47076005)(1076003)(5660300002)(36860700001)(8936002)(8676002)(4326008)(316002)(110136005)(2906002)(478600001)(41300700001)(70586007)(6666004)(7696005)(70206006)(6636002)(54906003)(356005)(36756003)(86362001)(40480700001)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:33:52.4173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d344be-413d-4257-3dff-08dc00759d02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182

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

