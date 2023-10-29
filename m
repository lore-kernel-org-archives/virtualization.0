Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02FFC4167D
	for <virtualization@archiver.kernel.org>; Sun, 29 Oct 2023 16:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A9627074E;
	Sun, 29 Oct 2023 16:00:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A9627074E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hh2/0Gdu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wfpR8N1ToZdA; Sun, 29 Oct 2023 16:00:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07FA270740;
	Sun, 29 Oct 2023 16:00:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07FA270740
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D73A4C0DD8;
	Sun, 29 Oct 2023 16:00:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12824C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED7F24341D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED7F24341D
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=hh2/0Gdu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gS1FTKs_-vu7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B07AC43411
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B07AC43411
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAvVJqQOMJGn+FXDBHvHA+r6Yer/L06IpjbvwG0x6YWFl0bYPvvQlN5OKd48v3IRDSBq4oFX85NNR67rDIuq7EmfH2ba67buIyU4DKtIF0ImsdsJ9uSKLnG9bRwz8s5a2q0x1EuZLvQGLnhXnUtRq7m52kHS3/umqfQ2dqvweOZAWTqUlGe4ZvcAKoltqhW2z+ezx9DvXT3eVwS3Jo8jmmqXBw27K1tPMXOtUcYUtZy2kZpDcq0B7WL/3QaWrNM4isV0Tfdd+zod2o6rh/8x9odU9hcSPZ+/upUapCUTDHRKuF/qRSz0pPW7NZhdEz67mQ3iF170qO7kuchmDft8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK8oVP00vpc6UQUa3hMRt2UjQkZntth7M63FfSSA9Po=;
 b=JVEQCH/lEDie8z46snkksnkY7Ba8HqpyKp+5Wezl7+kJYGDeIiRuVwY9IcYzrQ6LOkoIr7RHNAibYEevIc8UIdgkogVo0zeGJp0U2PiHqMD88gHjvA/56DqWq6Wjaw2JBbPytSo2bEeap1oSSmCbRTYfywTp4Y85RbGbZA07gw3O4TVIMf6pANA1MqAD8++9as4UcMaETzfcNJ7lRVlCXQ/cyTjdA6N0YV9DWPkjs0K8AqxW7t8rzWij+VPGHQaNvN5By9kN9TPRFC5jmztzFLLi2BZvUqEnTnaE5bdxza8OE2vDJF7ZFrrztMZfQx6NpjH0ilRlRpVGlCB53UE/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK8oVP00vpc6UQUa3hMRt2UjQkZntth7M63FfSSA9Po=;
 b=hh2/0GduWmoJRG75/x9UDCjkOYMjPfX6ts12NgbYPvQHKhRkE69Xn96mXvBVrOzjjJY8XcusFFjNUHNezmWyVEDLxjaPjGpfKj7ERSrIwIZhAJEQ4myUppI3nzbiA5YjXUZl4U+2ZEn6D1noVi6USmO5jiofHIf4EBlLOXrugd5riZ1rrsucdI+Hp7gQr7pFIETXu0rrbmXeIYshfmfNRtXTyZ8DjG6f756Rx95U1KZUYX4mITO0N+6C+HAlboV1ELDxVkpa0MPjGz/lnzBz3DcfoG7pjkE2uyKaXaspbpeQIEvJswMivYhU+9+aLxUD3IFMdePH4N6YbUAwtK/y7w==
Received: from MN2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:c0::29)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Sun, 29 Oct
 2023 16:00:33 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::2e) by MN2PR05CA0016.outlook.office365.com
 (2603:10b6:208:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14 via Frontend
 Transport; Sun, 29 Oct 2023 16:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Sun, 29 Oct 2023 16:00:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 29 Oct
 2023 09:00:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 29 Oct 2023 09:00:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 29 Oct 2023 09:00:13 -0700
To: <alex.williamson@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>
Subject: [PATCH V2 vfio 1/9] virtio: Define feature bit for administration
 virtqueue
Date: Sun, 29 Oct 2023 17:59:44 +0200
Message-ID: <20231029155952.67686-2-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231029155952.67686-1-yishaih@nvidia.com>
References: <20231029155952.67686-1-yishaih@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: b0481a8f-355f-4df8-e677-08dbd8982ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21GOhv1b/ruBF1plqOUuViSzqTdU1Fk4v8iecK/PrkfCm1CJWcVs1d76WnWnPyoUoR+o0jV6PIfmPYuyNeordhLU9czv+A01IMVwJYtugmWCnqnNCAU0vwzgW+raFsfVYF0LfY/dCoxiVXOjqzJVHWo2YdRUtl/gWKI+Uqr/QXvF1Z+vPn0j9hkDfCKj+g8xOeMTX2WApC1B1CW3/amA/lawB2aPVGz0Tp/oXHBMgMaR9UEujExZlxEIZyr+VnNl51uYLmTt4E6Ut1aEGeCPsSafCG9+XrMwsTP/DYw6umfEspxZiW8fLpInyL39LwsRodA0J2ABeRW+oVSpmK1IZKXc1/OU7DqGZ17SGLnwi1RvFqp7EyLZpa8fYtZNLlj3CfMeJzJXg5+ljKSsMUWwyshwG0dbbYXI7PkJ6Q03opZuFWqzSN2Vg0onWKgwm5OGWZIg9YE7ZsUcQtxFpj0ZNs9T0HysVX48IqoNGSi2W1XLd26Mfk9EtTKabGAvojL2dv/6cBO231FK+8eYQPDN6Ns1eWfvRQz8mYrDy6uCV+7eoYmmatNS3YWs7QFBpk32yLofP9achOqbmhCW/YdhCv+VtOGB+wgpdCsCnno0jgCy3ZJiYiOuNzPrDiQh3I6sZVir1ZoK+nxo1AyTRrFt1YGnJ+aBodyaI5O/9cm0zq/ChhSSENm6iBx9/C0weIZ6lg0cJdCPsiGAkK/lYGEwtKYM0moRCJy9lYCWMRC/9yYzRd4rgGQv8mm7tYxdfVwU7tgtsrwHGinm/i2h3cItfg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(478600001)(7696005)(6666004)(70206006)(70586007)(110136005)(336012)(426003)(26005)(107886003)(1076003)(2616005)(41300700001)(2906002)(4326008)(8676002)(8936002)(316002)(6636002)(54906003)(5660300002)(86362001)(36756003)(36860700001)(83380400001)(47076005)(82740400003)(356005)(7636003)(40460700003)(40480700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 16:00:33.3842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0481a8f-355f-4df8-e677-08dbd8982ed9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
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
