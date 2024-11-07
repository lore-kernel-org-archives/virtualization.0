Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFD20ADC8
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980103; cv=fail; b=NXn6ehdSSeXQ7ANAlIY6yPgdHbnl0jywKAMqc9IRRyn75eej1jDHqo+afVzASTNZh2fvwRryN8dwmjh/sekV4fx8NMCYHZIJfXNJz64dl6SAFsEtqOBGIZqbi/ozdu3vmrJP0dqUP8aMnoSsIjWVIweWYlT15Tsx6KvfV5Ub4Dc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980103; c=relaxed/simple;
	bh=pMkwXEPLCwf5KphA+q3ojGPVOrIiaY9y4Iu18bVfFj0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pL1kdg6x0o3FWpEn5D3GVUqTMDIVGs3eRr36tG5huq2yeOEEV5Gjjwsl6+bv8lBJs+12THMvxSEOuPUwZoPnik/Ml+nwWRJ032RhCKpS51vIpXnKOYqimPJDM8SqCeXGvOSaDgQNa3g5EynGZBNdd7JeUhWFYQ/I5UDNsiqyj0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T58lwXZ8; arc=fail smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T58lwXZ8"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 455BC4093F
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OTVZkSWEogFU for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Nov 2024 11:48:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:2413::62e; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=mgurtovoy@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2B9DE4095E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B9DE4095E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T58lwXZ8
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f403:2413::62e])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B9DE4095E
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Nov 2024 11:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1UlIb657boa6kbNnQIEEtBdVLsxGGiD2OLKsrPoQgzfk0PjPc67VzdnwuTzxzZUcHKp+tjFRyt/KtkOqHIiA7ojmTfxpYwywaHjC+myrl2Pxt265jmDwQBLPCi/OT3d76KoIF4gFXAg3nNMCUAVZZRuS6wTOPJj0cg7jxr178I7Cgm/F+PquHw/MXQmOfsxsIby3AznOc54TviWGbUtZzqK9iFUvuP/sQ1s4X0tmljvmQYe2wjlKbmEm5Y8qdGDcNVPsHXh71ZS/zhouWUGOA6i7Ux34kZDsW8SW6ZRpWhY6g+kpq3jJ48FwiG4cWHNCVfQyVPPmCU48XRCK8H7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0jK5jiKMPvDKWm2KSJCplThClMbyvt6feKcJU3CQKQ=;
 b=G9AGBKFDBFq7RfKlmjVX6/j/SQJyoRyLndba96RNnpkhSj2FkNPCFsBqIL15hpOhZkBsa5D9o9E8ooA9PfZu/gGx9H3qWyRHZ9QbNYwaCxSSZZUbyrTYwIsbBtNOV7/0R7kJMVCQhalGIrotnquuGEeHo7VG5W601aC1ph0lQd2v64ekDV1tP2OCmcoN5BmN0I/moZznecRJQxlOYalHQ7qvCp0eE8rmAguN3elXGx9wMHucN4juLNB9956eaKVq2RKWeVs3k7aLKbQ9SZB0wovxvmHuLGmHGynbhYk4t++4KoZiK2+K2P8Mg9zOcxILgiCgVOlhieyVQZGiuuAfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0jK5jiKMPvDKWm2KSJCplThClMbyvt6feKcJU3CQKQ=;
 b=T58lwXZ8reuGGKZ6IfKSBYb1y5owB+uSwWSIm/Y7vZ1iQtnIbwAc0vQyezF6zV2Rc9CyPX3NAtannACmfNXddBkcaM1KBWJZC1LYiRNp7eADiP6aF7a0fzuZ5NKAYuQrmO9uprK0OdONYWyiVWdGonlhg4mNAmnqhIzrqx3S1BzGN3xcMftoah8BN9XqfzTFkeze7vDcP40o6Mrbx0miI8zPkDAKOswmX3U4jcXxJaLBK04I0UFDkFxFAmlM7u+B/pBd99Qjkg+xmP4qAaYO9tJe5swuCJIgF2/HtPMf808d8oi2oL9Fbu6M2rawGoC1EQEUGrSxSgElLaLElIh1ig==
Received: from SN7PR04CA0197.namprd04.prod.outlook.com (2603:10b6:806:126::22)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 11:48:14 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::d4) by SN7PR04CA0197.outlook.office365.com
 (2603:10b6:806:126::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 11:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 11:48:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 03:48:03 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 03:48:02 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 03:48:00 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <dverkamp@chromium.org>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <mvaralar@redhat.com>,
	<stefanha@redhat.com>, <virtio-comment@lists.linux.dev>
CC: <oren@nvidia.com>, <parav@nvidia.com>, <nitzanc@nvidia.com>,
	<benwalker@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v6 1/1] virtio-blk: Add description for blk_size field
Date: Thu, 7 Nov 2024 13:47:59 +0200
Message-ID: <20241107114759.1152-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fb5d9e-a9f0-48b6-0017-08dcff220ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvxCEm68gDFHOYrYRAohEdmjnGdXgwtD9+u0YjWLQyIxeEAi9l+HHDeoF+f9?=
 =?us-ascii?Q?rTDwkAxoEljxYb455jeNkdeIbhDrs+n7L0quhKBHsneND7NucIN0b3yo0rVs?=
 =?us-ascii?Q?dOfiumiGyf2ogbAM2u/83tOyoKFr3bwIlq89BwpK5VpjJi6BdHKJAiukUJup?=
 =?us-ascii?Q?BRG6G4o2/bzQWqaeg6VEU+oEzB3GxDbUYPTjiziKZGjWWMFtmLh9uTwhjote?=
 =?us-ascii?Q?8kMnGZpQdcek74hPcwhyvJuKduWtRxDv5AKJWp72xGfNVPdqxqYbEdFaPrAO?=
 =?us-ascii?Q?BNhUskxZYGUgKhc1SZ3CCgPf1YqDXv+dVJxXwooL33g+nnVJShoh8+63Iy7p?=
 =?us-ascii?Q?lkq2AEq+dAl+O73HXyP1W9AaAV1UnSH6uui+3sroQHm1RKghpdgjh2FgucAi?=
 =?us-ascii?Q?1joU0MrcQm67DPR9/JgdAy+gysLilkb0xQ2ogBrxX8lfdT5FSewz+73htJoZ?=
 =?us-ascii?Q?SPv17IlU23V2YW2QpDk5KbaAWX8ua38lBYMgpR6tYk4H9ffNDVHgVrsXj21T?=
 =?us-ascii?Q?lihTJv12m6ykCKCQWb8iEg+JDix4hZQGOti7dfTCd3bMHRwpEeBbCfkzO719?=
 =?us-ascii?Q?FEhh/OGt0FJrZ2JakxRbQrnlH+N4zUWt+3AHhD12Ir7i1iocjhJ1870WyeDL?=
 =?us-ascii?Q?3VCBj4a6wC30yQ65vKGswXuegcD8sFPkT1pgVJx910dIJvasxjuuQlbh74bc?=
 =?us-ascii?Q?ROI9511nSs09S43PDGauoNT7snCJklIoNiIWNQ550ZLUGho4sW/9cFsKKOtu?=
 =?us-ascii?Q?Fvrxu375O5GXW+6YuaCBjmmW5MdG8/pAVnohj4ugeFNOQTJnGPZZESKG/pd0?=
 =?us-ascii?Q?ZZQVQR9MCDYub1wXcHZ60MJXTrfNnWwqwxfgD/2pemwh2nbdxnRYpTIfspIK?=
 =?us-ascii?Q?l/mnrF9txXixRhtTqUUFr+E1ORi3IMsvZmHnurLdab8txF2kgI/LCZbqX+bO?=
 =?us-ascii?Q?2NXq6OUZRpCf6e3WiKua6W6lYpZuFrIxVXSWVNtQwbO+Wvy73fFQqz+o9jf2?=
 =?us-ascii?Q?au3AexBBe6fmeSZpYk7KtZfHpvtcTXJ4o9BOI6RUHrU24QnyRe39vrta43lQ?=
 =?us-ascii?Q?Oh1HBjIDgfvCOsHxCGaBjfaHqhF2FqeR5CO8KwYsjmiwdyPYlrl+bM3wjB6z?=
 =?us-ascii?Q?1EF/NcWW7EuiLHRkTJCy1uye4DDTigKKSjlHnUZQmSNRNbcjao1G92l6aEIZ?=
 =?us-ascii?Q?xyMbDo7Bd7Ef4eMWuh9gFfwOR4GdYdrMfE21TPZ73kNX/kLgqQKavD46jMcN?=
 =?us-ascii?Q?a7BMwWG4ruMVHaPfK9y2a2hDLokI4m+EChPo4erownVVuuzvAcSY8oaQx7Hj?=
 =?us-ascii?Q?UgyIwTO8/55f/qqFBhrJ+oJrMM0LKYB+coZL43MDoW7N2uHUDpW58jBdeMLm?=
 =?us-ascii?Q?xCElicPjCMemC0BFqRi/yt4m1o+ty9rsJBfBAq7FuqUpjfKlGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:48:14.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fb5d9e-a9f0-48b6-0017-08dcff220ff7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254

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

