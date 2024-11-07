Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89511F4294
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976234; cv=fail; b=Mm/3ZcwQMjgcdvm7lTNSzm4R8s5yBbFtheKdvX9cDbS39x7eQy1E4ddvIwcjFIWXaUYjKGAQ00/UljyGYGmzPYcyU9q3lkotmo5i3c40jKDC1QsayxpUQC87dcucYs4LEx0/q3Yh9/n+w9pexhIUwFeyoX5omhS49/pSkSf04Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976234; c=relaxed/simple;
	bh=pMkwXEPLCwf5KphA+q3ojGPVOrIiaY9y4Iu18bVfFj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZR6t3fcpR5Y93EQu/WdTzl1PCK8YzTGmg68Qo4hcrVgKDi4bKvF8LbfPmsO+/GbYE0oWe4zD7zQjUc4JRj2ekS/T06egu1YM4grh+ani9LXBf9ZqutQBj+JNDLn2BKpGra7+NAEZdEgqj8AVCpSig0tmz+CTA1fi9bJB0uuRSec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Il4bYYt2; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Il4bYYt2"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CA7D408AF
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:43:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JGbDdnBLpriP for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Nov 2024 10:43:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2413::606; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=mgurtovoy@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9F59C408A3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F59C408A3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Il4bYYt2
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20606.outbound.protection.outlook.com [IPv6:2a01:111:f403:2413::606])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F59C408A3
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 10:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zsor7UX0red6MDAPiPGlU1VXGoWkgiADOMOmhdSY4v9rR7WgxnsV/+boGjY/wLQ38HHWqLCEnX3gF+4EGaAxIAshSkmcbDpJL8Yjj6d+OTPipoj7+Uu4Io8aL6lx2vQSe9QPjK+2dLb0b50oEQapEbSu/eg0Iddpf9B39GzUTjiB+0JJsHqUPJ88Ln4+TPGf2dmHT33W7BV8TROC1LCjNThPoHsUmJXUPBA2aTa9YT5/nUjGm/uOzuckjD9ZMQ0SdauCaFbTwBVqcYEGxCBI8bqO9HXFbjXVwk8SGK1AFQsO8YmtHQlS7vjPL/W5Y1DvAKW4hdvoyXDCcfto0PqtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0jK5jiKMPvDKWm2KSJCplThClMbyvt6feKcJU3CQKQ=;
 b=wHMKM6LrXSjF3nE2eSmgGE83cIduyreFA4CY+DfGxcJfoTdOm/Meg7Hp4rHc89HwCbE1HOLfLJpn3XZMIugWq5SazURWCDLXc540OfsfL53b2GIeIBN5AVFeEeFrSZKljkbuYPoLp/e8ctO2az1vK61wkgnj1tVdtBXonjZ3o5ZpeRQW+JZjPFc34aE7BZbsWrMQKWko75RMJ9/SrmjLlX9+FNp8/b2VFQZAnfNt6OmRNJF4H2lTFplI/pq9bvfnhQHi3UahRjh+3YFiqpmjKWhRxQjy4GwQGwpa1qR9f4dpOgyfldMXEdu85cI8m8zTOm/dfbrnljq1rdWR7ZP8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0jK5jiKMPvDKWm2KSJCplThClMbyvt6feKcJU3CQKQ=;
 b=Il4bYYt2yTmkZAiLRDhX6ubVRPB4DGKmCRyQrNQPvDQVGb8S0rNadczJG6G7gcDINPjZLwX1sEkbq6L1pGc0Q/QCQR1fGV2g9JMiTNs8SBoaM2Q2551wDav8+iqDourxSXgsCpSCtGoav3FSdcL8BB3jxfodGXGwvF8psflxc4QKDwMKMqfMfRoerBRRWA7ta1ZeejuCZJjBOtp9CdGEihCYIw1xv53EsFGv3CcVB1APgK3Np153HPiAOwdiiLCkXRQfJKiZoD0/dcDRY1wRR+VWX/hRNxnsHaMAB5I0wNNT/eJ7vjeoUKGwzSeSvXfbaLY8jtCJ536kIUI+A/WIDA==
Received: from BYAPR08CA0004.namprd08.prod.outlook.com (2603:10b6:a03:100::17)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 10:43:46 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:100:cafe::f4) by BYAPR08CA0004.outlook.office365.com
 (2603:10b6:a03:100::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Thu, 7 Nov 2024 10:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 10:43:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 02:43:37 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 02:43:37 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 02:43:34 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dverkamp@chromium.org>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <mvaralar@redhat.com>,
	<stefanha@redhat.com>, <virtio-comment@lists.linux.dev>
CC: <oren@nvidia.com>, <parav@nvidia.com>, <nitzanc@nvidia.com>,
	<benwalker@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v6 1/1] virtio-blk: Add description for blk_size field
Date: Thu, 7 Nov 2024 12:43:34 +0200
Message-ID: <20241107104334.16158-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: fd027bd9-8f85-41a4-1011-08dcff190e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0AclD5G81UUzo6px1riH2cn8NF80QZwl/TCpFP7+ibDncUUx8UsuYQCTySow?=
 =?us-ascii?Q?28Ie9EWAPgWYgACZ3aT1VeM0jwTnqtKowl0rk54I/S1ZEYd0eBlmSFF1w8lZ?=
 =?us-ascii?Q?Cvz/ZompPVYb5GZqZ7iyV29ZNeeRdfdIDwk514UUjj11JcZYH/tQXQY8QjRo?=
 =?us-ascii?Q?H+RLHZEGJ2DnJopUAUEaUvjkjB+88MIh2IdTgEJ4qSWDeF7oQSpiC/xnuhbx?=
 =?us-ascii?Q?ngoNuazisOr4nBpsfhTHbHp95XEstJJEM2eiX6V7jpEoqxIB/wNG7ZvR5K7U?=
 =?us-ascii?Q?SDW79Eg8970G5Lw6zyGki5ZRqANptqc+CWjdTOjQUM6GWGQKd3RUafMQ3Xyl?=
 =?us-ascii?Q?FDmGG1Am0rF7PxnnUvhZtkM6vUIfAfzezKgQV0R4CDbVJNFGv0Gq90JNyCmB?=
 =?us-ascii?Q?+2LQm/QAnsZS14COpKh5t/D78YmSV4HzuQglu4FNPBazdqHLXdOWnfNy/Q57?=
 =?us-ascii?Q?+7iOSFJag1pRDWAxTTsL0B3Za62qpFVM/AvP1pit+NT2qX97smCNuwr0jSdk?=
 =?us-ascii?Q?/v5hhrmyTB18sBfZwfddAnkUdOmAHwmhmut9icp71Rb9GQUeoYOZ+rQYGY9g?=
 =?us-ascii?Q?lN3jatRUsTFD6g5ynazM6SNmIFoLVCMpbjR3101xNQv8DGj9+sAAsJ2LoRgn?=
 =?us-ascii?Q?V8eR0UGwJvXP6/rUtUsTPoAb5ln3El2QcSD4fLkAQx2T1a+Yd4M7wa5b5BBD?=
 =?us-ascii?Q?ImoNoFBSvbGCjH0iMVn6uZMapna/a9fGb1zoGBS0yoEKmTERteHI3Ugxptb3?=
 =?us-ascii?Q?u0+LJQe9DT5jt/nJkTcvNLYRw50kA5KZfn00OF+uk2q8o42ap3XQlStYMt4u?=
 =?us-ascii?Q?Ewmfy96F8Mr2elCHNs453Ufxso2Lw9dJl5Vs46L0JdtSk3rJnc7Cpg1XUVSm?=
 =?us-ascii?Q?phChGzfrbZZ2RP1QhZdOmbBDZf1KJIncsD3gqnU0TSnW/5+Rm0sqOeEcTsG8?=
 =?us-ascii?Q?IYC5qdfjQ5rTh8BabrwnfFL1aLiyloC6AD7nkPsLoZmrDPrT+H36zfZQ3xX0?=
 =?us-ascii?Q?UkW1mXOF6ROPlhRg1gbRP8kIW/CEquVF+ECh06gEtmfjo/n4KRr548SdCpcT?=
 =?us-ascii?Q?FP+vD2OUQeGdSbINgiBfges+uqFNgT/AT6pV2Ert1yVrLjpFIvhyrAusSRW1?=
 =?us-ascii?Q?wrZF4CFuVj4uyLzkicjsr2WE09YGrxyJUOTwfCgTvffS1/1g2VcUhJW9XNtp?=
 =?us-ascii?Q?vnj2/bMTkvDe1eIn1jqHU/3we437CyIn1TDKrSiE15PYjNiPNIK/dxH54fuy?=
 =?us-ascii?Q?bkwbzXZx5qh+MnFO34Y3vicm+9RyhejlLC7MvTS6iyAR34rqsxJBq5bTsm+q?=
 =?us-ascii?Q?cQuSm4MrDfW4DgPVpb88toX5of5hxqFaT3eJmKGQeuqF9a1uMKSn6+QEUzjC?=
 =?us-ascii?Q?KJN6lE5AFFuqV821BvuwYza/pJ9m2zeqXjlMllFKeFMS+g7AKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:43:45.4029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd027bd9-8f85-41a4-1011-08dcff190e10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318

This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
offered by the device.

The blk_size field actually represents the logical block size of the
device. It is always a power of two and typically ranges from 512 bytes
to larger values such as 4 KB.

Add description for this field to provide clarity on its constraints.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/208
Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v5:
 - plural vs. non-plural fixes (Parav)

changes from v4:
 - reorder paragraphs (MST, Matias)
---
 device-types/blk/description.tex | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/device-types/blk/description.tex b/device-types/blk/description.tex
index 2712ada..47713ab 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -135,6 +135,10 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 present. The availability of the others all depend on various feature
 bits as indicated above.
 
+The field \field{blk_size} reports the block size of the device, expressed in
+bytes. This field exists only if VIRTIO_BLK_F_BLK_SIZE is offered by the
+device.
+
 The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
 the number of queues.
 
@@ -282,6 +286,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+The driver SHOULD negotiate VIRTIO_BLK_F_BLK_SIZE if the feature is offered by
+the device. When negotiated, the driver SHOULD interpret the \field{blk_size}
+as the logical block size.
+
+If the VIRTIO_BLK_F_BLK_SIZE feature is not offered by the device, then the
+driver MAY assume that the logical block size is 512 bytes.
+
 Drivers SHOULD NOT negotiate VIRTIO_BLK_F_FLUSH if they are incapable of
 sending VIRTIO_BLK_T_FLUSH commands.
 
@@ -319,6 +330,10 @@ \subsection{Device Initialization}\label{sec:Device Types / Block Device / Devic
 
 \devicenormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
 
+The device SHOULD offer VIRTIO_BLK_F_BLK_SIZE. When this feature is offered,
+the device MUST initialize \field{blk_size} to a power of two greater than or
+equal to 512.
+
 Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
 if they offer VIRTIO_BLK_F_CONFIG_WCE.
 
@@ -879,6 +894,14 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
 and VIRTIO_BLK_T_OUT requests.
 
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the length of
+\field{data} SHOULD be a multiple of \field{blk_size} for VIRTIO_BLK_T_IN and
+VIRTIO_BLK_T_OUT requests.
+
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, the value of
+\field{sector} (multiplied by 512) SHOULD be a multiple of \field{blk_size} for
+VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
+
 The length of \field{data} MUST be a multiple of the size of struct
 virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
 VIRTIO_BLK_T_SECURE_ERASE and VIRTIO_BLK_T_WRITE_ZEROES requests.
@@ -966,6 +989,16 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
 for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
 write any data.
 
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, and the
+requested \field{sector} (multiplied by 512) is not an integer multiple of the
+device's \field{blk_size}, the device MAY set the \field{status} to
+VIRTIO_BLK_S_IOERR for both VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
+
+When the VIRTIO_BLK_F_BLK_SIZE feature is offered by the device, and the
+length of the requested \field{data} is not an integer multiple of the device's
+\field{blk_size}, the device MAY set the \field{status} to VIRTIO_BLK_S_IOERR
+for both VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests.
+
 The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
 discard, secure erase and write zeroes commands if any unknown flag is set.
 Furthermore, the device MUST set the \field{status} byte to
-- 
2.18.1

