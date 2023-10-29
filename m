Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84E8C4167D
	for <virtualization@archiver.kernel.org>; Sun, 29 Oct 2023 16:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75B8385039;
	Sun, 29 Oct 2023 16:01:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75B8385039
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cA5aPtiY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wTYgEeKory2L; Sun, 29 Oct 2023 16:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A38BA84F05;
	Sun, 29 Oct 2023 16:01:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A38BA84F05
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDEF9C0DD2;
	Sun, 29 Oct 2023 16:00:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76F35C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5B0543411
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5B0543411
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=cA5aPtiY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yleqGY2esQPU
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A81F4341F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Oct 2023 16:00:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A81F4341F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+fLEJ1saORZ8rCg+/cAFjLnvsWB43LuzVT21isLOgmSoQqMArZYxNn0u4644zoAInTd6BNeMdlqYyyow3mclOaqZLyc1uYOEBE7F8Ow98jq2nejw0qW1dugom6S2XnPshdh0gD+rNYGkiYA5sDOAY5wyalnqk0vPtkslCVNhOnRuvZDePQHKmFH8LRcRNaCbFQccXdnhmyan5qD8wd/0YK/wk6jfEH+NpJLnQfhciPmP2FsDAcCT6Ui9/EQqBAA7Gldart9Xvos7qIxYdLsUGoRYdlWkm00HDX8rYjOXUW+HeszF5lev/Y6IA0GnK1A2VCOgbsBW+kxvpHfMDazoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQgtRhF9nwY4OCM4TqXlToBYKLhPSI0T2PByC8kLY30=;
 b=OLf22xAYNWsy7nFc+Gwv7iDF8UIj3+1YKcGfzwCYavUw2whrN5UNudYEQB1iF8UXskx8lmHO/LZPv564YI3LLriznY1WcPMMcrnG4e5/Ymhjct4E05V11Vc+HgBAq2JrpZCyksB9SAffDu0VaNKIRTDHqGRL0WJd2GnLcFAGBPXGc2/fhSU6E49TGC+M4FPu+SPuTVNbsk2UEssC3zGW9V7ci8rCsoQBXne9lWme3QETwg+P/Rm6gLljtV8p7gX6rvs+qhgGzM8FS8NjMXYaoWEPlFqYYHe7vxcZE2GQAesPqcl77UzqydLt9EX0DKnAtGNg+RclBQ522bRfvs9o+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQgtRhF9nwY4OCM4TqXlToBYKLhPSI0T2PByC8kLY30=;
 b=cA5aPtiY1Tt6Cm3iVWgc3ggZiRhNuktoK09PeBw+/lMUSrrs9yIESpGyTVZ1b56PFCyIT3bSCLPjZRLzFp8zSjI5CCkUAYf5b3RKeQoTyMFq55X/H/Vo4y5cR148xnsP1TjybgcVaWnCRJIEcBvfJfMW+eNvIVWAlWmessUzccg6JId264ivOl8GTAYd1KritwpNY6iEtptiDaEXiXSniMd7cFt4u1vpwcqYu+kCAMj0rxVDQj3xUKWBC2Ng5D6U5y0/b6lwWmAWGyrdMVg59rpSEhnikVkyOs6QC0c5yjodwRekCXvHY7qdG3vll+q5L6OfP7IbUjCl8cjUFN461g==
Received: from BL1PR13CA0442.namprd13.prod.outlook.com (2603:10b6:208:2c3::27)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Sun, 29 Oct
 2023 16:00:47 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::5a) by BL1PR13CA0442.outlook.office365.com
 (2603:10b6:208:2c3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15 via Frontend
 Transport; Sun, 29 Oct 2023 16:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Sun, 29 Oct 2023 16:00:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 29 Oct
 2023 09:00:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Sun, 29 Oct 2023 09:00:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sun, 29 Oct 2023 09:00:24 -0700
To: <alex.williamson@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>
Subject: [PATCH V2 vfio 4/9] virtio-pci: Introduce admin commands
Date: Sun, 29 Oct 2023 17:59:47 +0200
Message-ID: <20231029155952.67686-5-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231029155952.67686-1-yishaih@nvidia.com>
References: <20231029155952.67686-1-yishaih@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DM4PR12MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 60185ac0-f44a-453f-3879-08dbd8983706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgnEeOc9sMqPym20w0VmPgDKTJq3R+a+hknWhkCJ+YThIZiMoq1cxAwpHQqqtruG2B7euudcq5SkpfacO3IhhBP7asG6DYxnpNvFXyV7VRRJpMyw6riRHv10ht/7qmoolbox59KtmBgODTlveHtcANsZyTRV6NsU9tbC7pf1oy/g2ruucOaxt1x3xot2fX1WndiIKCuxwdd8VqIcwYycQ1bxn5CNuv4NcJ9BulFtrOp+e7yfBrjWNIDG9/04hdeUVD2H/2ccyYyyTK1vwnI6YTsRYAm4hsQ1Fr1IhSLdp+i2mAebuxP4d3fmO+6hPaHwwnZuEsPv8oqWz6vBVpA6ysNeA7YYcV/pXjjA4stKSqnv61m3EbY6xv80Lbqt2N5v8w8iwaWZjksP/UMAG6/SV5nB3hJAdYjWEl/4t52QF5inj7i7VZRfvUekvXCkWsLYr/cF0usMwnQmiDeR4KammuGs3NG6Ux9gXaHpCQ6VIvE6uY5H1/hqmwVZu+udSvGFmJV2ODeo/NWfEHsXltCQI3LMrLq6GiGFL/ZkKWrskxfZjJ75EWwrR12bas7Yw9vmMYQk0MEeQGtfghDJ2HLZZTT2Cq9OrZd/CCGangfAGxdfwTCGEz8qRM4BYjPkptiRga8Zrg7ADOCX1NFCh6KC8gPSAFpFJuMcfrJUAzmWpzSxeJW+96Y1qyvEh+LyNCGDU7FCuVmasGXTG5HgIl7NElrPxidACKX0jruxldJjv3IfO9TomaLAg6x6zu7wrBbF
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(8936002)(8676002)(6666004)(54906003)(70586007)(36860700001)(70206006)(110136005)(478600001)(86362001)(356005)(4326008)(41300700001)(5660300002)(2906002)(316002)(6636002)(40460700003)(40480700001)(426003)(36756003)(1076003)(2616005)(336012)(107886003)(7636003)(26005)(7696005)(82740400003)(47076005)(83380400001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 16:00:47.0965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60185ac0-f44a-453f-3879-08dbd8983706
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
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

Introduces admin commands, as follow:

The "list query" command can be used by the driver to query the
set of admin commands supported by the virtio device.
The "list use" command is used to inform the virtio device which
admin commands the driver will use.
The "legacy common cfg rd/wr" commands are used to read from/write
into the legacy common configuration structure.
The "legacy dev cfg rd/wr" commands are used to read from/write
into the legacy device configuration structure.
The "notify info" command is used to query the notification region
information.

Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 include/uapi/linux/virtio_pci.h | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 68eacc9676dc..6e42c211fc08 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -210,6 +210,23 @@ struct virtio_pci_cfg_cap {
 /* Admin command status. */
 #define VIRTIO_ADMIN_STATUS_OK		0
 
+/* Admin command opcode. */
+#define VIRTIO_ADMIN_CMD_LIST_QUERY	0x0
+#define VIRTIO_ADMIN_CMD_LIST_USE	0x1
+
+/* Admin command group type. */
+#define VIRTIO_ADMIN_GROUP_TYPE_SRIOV	0x1
+
+/* Transitional device admin command. */
+#define VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE	0x2
+#define VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ		0x3
+#define VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE		0x4
+#define VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ		0x5
+#define VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO		0x6
+
+/* Increment MAX_OPCODE to next value when new opcode is added */
+#define VIRTIO_ADMIN_MAX_CMD_OPCODE			0x6
+
 struct __packed virtio_admin_cmd_hdr {
 	__le16 opcode;
 	/*
@@ -229,4 +246,31 @@ struct __packed virtio_admin_cmd_status {
 	__u8 reserved2[4];
 };
 
+struct __packed virtio_admin_cmd_legacy_wr_data {
+	__u8 offset; /* Starting offset of the register(s) to write. */
+	__u8 reserved[7];
+	__u8 registers[];
+};
+
+struct __packed virtio_admin_cmd_legacy_rd_data {
+	__u8 offset; /* Starting offset of the register(s) to read. */
+};
+
+#define VIRTIO_ADMIN_CMD_NOTIFY_INFO_FLAGS_END 0
+#define VIRTIO_ADMIN_CMD_NOTIFY_INFO_FLAGS_OWNER_DEV 0x1
+#define VIRTIO_ADMIN_CMD_NOTIFY_INFO_FLAGS_OWNER_MEM 0x2
+
+#define VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO 4
+
+struct __packed virtio_admin_cmd_notify_info_data {
+	__u8 flags; /* 0 = end of list, 1 = owner device, 2 = member device */
+	__u8 bar; /* BAR of the member or the owner device */
+	__u8 padding[6];
+	__le64 offset; /* Offset within bar. */
+};
+
+struct virtio_admin_cmd_notify_info_result {
+	struct virtio_admin_cmd_notify_info_data entries[VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO];
+};
+
 #endif
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
