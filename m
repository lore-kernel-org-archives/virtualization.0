Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352A6C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E4C60EFE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8E4C60EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97DF280FFF;
	Tue, 26 Oct 2021 04:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AnwAgyRKVige; Tue, 26 Oct 2021 04:03:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4050380F75;
	Tue, 26 Oct 2021 04:03:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26C49C0012;
	Tue, 26 Oct 2021 04:03:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AFBFC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B1C06075E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6aaV6HbrZiIS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48183608AC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAYmO6IppKcnn65w+1dTXOl5qV1PNlydYsfIQpAAaDQTNlP6tXRBwb7CHeqe8mngVPGFx0ey8W/g3QXzEgjOn5cGHcn0Unzzg5uxiBQPFiqzZ2ZfdD1z8MWjkUUiU/4RmMyVvs+WaOclv1CrqtvlypbU6s6j5uL814rYzea7D6W8DDsTA+FLcOnT3IeJcLXo3AokvvmeRXiJK6Cd9unIvAtgG2lDkHqAZJv/CWK8Lt9LJD9AU7i86R6Rb5iTpmsGIGTJnQ+JDkD8U+tK1vyUgcmBc1nZTCjMjyqMwo6e2+RMPvfmB9cZo2HV/sbIiGWFhCkIU2L4XZObw9gslUTbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tt/R3RezyvOiksjt8Lm2md7AiBgobdBTwilsIs7ml0g=;
 b=RGzXsGPw5MPcKOeUG1Hhs1DkcIwSc9szUSIDDwWhzrcFceig5fnDEjsajLAD789nCpR28dlCgK2R0xlrK0A+UUQ4Qs3TOF2UZ7aHlL2c1Bx7YoG/7VzSuk0KOPmgvJgs8uHI3U35FS2YC6UIUIBome30M/zZ6l5k++h+J6S9wdnUQaI4+5eq8a16LwPRfi3nj6LK/6OvLn++0sD3mmaSgNb9UarO8ym6UGUeJltn6TXzL21+/gEs978/93wynqouAcrVUHTJjQKh36qbBy7pCDvaXzubIgKFqKP2eD+A4dcwUCCIiMbp54Q3s7TncF+w2unLqhlq/su27Y/CmlgmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tt/R3RezyvOiksjt8Lm2md7AiBgobdBTwilsIs7ml0g=;
 b=jyh4fQsmwf1USKplwsuvBK0X5sibhMsBF2gGKHRkILp/D4gTlxnMToIOHlBPWHmQNs0sCUslJUG2GaZE9bHyNx+AjbXI7Y0sj0Oicw2qD1NGgVBp2pgcv/qEgy2Sf+I/B8V//xH1JD8usXwDsRe5bArSD43i0STqA26Nkw/5gv642nhOBeY91h2UmkGBIxQbM4BNO0cB7cQOuwj65b48dIKI2bu033rZvtS6TLhQaGStvrLT938jSdIYjEAVFoZOb5jVLy8LwgihM9yLm47VgCE85vMUBMAeb2YpOCGHP1FyREiKlqN3VY9EHocjhnWd3KkXkg4VHR57IOmP5nVdjg==
Received: from MWHPR2201CA0039.namprd22.prod.outlook.com
 (2603:10b6:301:16::13) by BYAPR12MB3094.namprd12.prod.outlook.com
 (2603:10b6:a03:db::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 04:03:01 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::ad) by MWHPR2201CA0039.outlook.office365.com
 (2603:10b6:301:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 04:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 04:03:00 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 26 Oct 2021 04:02:58 +0000
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v6 3/8] vdpa: Use kernel coding style for structure
 comments
Date: Tue, 26 Oct 2021 07:02:38 +0300
Message-ID: <20211026040243.79005-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211026040243.79005-1-parav@nvidia.com>
References: <20211026040243.79005-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d92ac24-9ede-4877-62d9-08d9983580d3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:
X-Microsoft-Antispam-PRVS: <BYAPR12MB30949EAE6C4DFA4DBA26E730DC849@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDYrctS6yylu6uGOB1IRKeFV7UzhlKzgYFI3wBF+ze7328GmVvyWHUb/EyzjFFK/GgGsoNhVx97u7cE5VHzTBf5XdJkBeFCJEyRdYqtDTLK2ExWGccxg2EryqsX9dzZ78BviyEPrtDkRlKvnmsttXkD21nwBmOdi7wMyF7x1c3XVfZAB95fIV+mpT0MueM4I1TCNLeR1+RqnFlQ5httZ9QWuWjw/CKKcL+j2p/U/TgytPGxVfJ9zjfi4FKU8BS/jRJ/E2pBalleAWR8NwTMgGZHDIbpP86O3ay5nA9iJ+fZkGXAGN8C83dq9hKUhJDxOPUGNxoug9K6pLWuD4UQNIzwhfwf82tJuyi7ANUNLYx08v0XoaPkSPQZwFViMFsxpL5DBNjgRtfOdYjWtN6S7z8+e9fnpBT/d0uaaz/kBDRk/Ioss/xo7Y3crpo0Ytbb6IcCfdyVdmk/1vvOOm9kullGs0i08F+D/i6uvkP2A9y+vJIjAdgtdVtqqrV2TnBU2ckgdNXjV6QD2CGt5jxU6pVkm5+lFXe7p1mh+dXLx9HjuhhxUnIoM3iQbSLi9+DQD8bvKo5FnX2EVk0gUCXVFf06U+Ow3MMDfowFRCUP2R10rLgvpGyWT9/ZdUiKnFAzqf+VOXJ6D12Q77AIaD+9/V5S1nkpFCVbCfptlnj+D1YPk2wbdCxAgKpRGKQRtK8oxmrS4CjJfEzBNxpF7Hay3hg==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(107886003)(336012)(2906002)(8936002)(4326008)(2616005)(7636003)(6916009)(86362001)(356005)(83380400001)(82310400003)(36860700001)(16526019)(6666004)(26005)(5660300002)(36756003)(508600001)(186003)(316002)(47076005)(70206006)(54906003)(1076003)(426003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 04:03:00.9752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d92ac24-9ede-4877-62d9-08d9983580d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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

As subsequent patch adds new structure field with comment, move the
structure comment to follow kernel coding style.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 5cc5e501397f..fafb7202482c 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -411,10 +411,17 @@ struct vdpa_mgmtdev_ops {
 	void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
 };
 
+/**
+ * struct vdpa_mgmt_dev - vdpa management device
+ * @device: Management parent device
+ * @ops: operations supported by management device
+ * @id_table: Pointer to device id table of supported ids
+ * @list: list entry
+ */
 struct vdpa_mgmt_dev {
 	struct device *device;
 	const struct vdpa_mgmtdev_ops *ops;
-	const struct virtio_device_id *id_table; /* supported ids */
+	const struct virtio_device_id *id_table;
 	struct list_head list;
 };
 
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
