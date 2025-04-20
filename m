Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF91B4243
	for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745147973; cv=fail; b=hmUTlEK55gzA1g+WqQ/d4D9OIE1vyqB6IkF0EQhRrtPzbM0byRxAupFlgy6XosW2U0XEnlBqGNigOvcJjOb6/Ts9fXVx6GUgtSHBq71yTr0yj1FRLi6ty+h51eMBELCoSs8bA8rZrZNXarhKuKwrxoWZOuT6c8F846aithWw97g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745147973; c=relaxed/simple;
	bh=FGYWJSBstwXy4UkKxB45zmCU0xM5stsaWDTKemYd8tc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QajoVtK7pL+KBgw4sWwykEPZtmNXnKSf9ldiz2fDpxZImYLhIR1wut+xXKMWxM7LyFFtt1pWiipR0T/qZCHO01QFqwnN7oF5b8bvbMJNF760mRbYy3DCdHA5wSv3E3UhIIwipPC2sttEVGvDihi2HZFIQEDREFKgmlC5cXkgd+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p3+cpCHZ; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p3+cpCHZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDP8hElaM+Qumnhg4JqW6iq9i/OJF3sn8GyaZAs42xgNHmSHSJMpJlxKCapf6twB6QSZVoGAREcTMOavFxtGQ9V2lfpqy0j67f26RYCV076sQ9f1UbhOG2fgpFPfXA4pwW3hLMrsAtfp64Ht6qrAj326DfngdH0ygVTEHpcBC45daUX59Al+RamzQ83itMiN/G+Kv5CM/EOPMTo0lTXi53QLOrFEEcInS88yLJI56N+ZkKJ2uHdc7A+GlkYqZ7JHB3EfoN7wRLe08MR20tP2zs1GUMxX0zv8B7KlHBG84XwlRK3rAXUjjKquz+uACUHolsjk95cNX4cy9wSpTGSqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQag8QO1YELCIL3Wzwh0EKKQVhBtub/DRNDya9qzZKU=;
 b=tykyiMhkul4pNbelluWS7wUoKIRZ6FlGimDuY7cYlMnvhfDqSg35qu6wIKrOg9UBB5e+3VCBq+1BM6MsXlrjfNhP9AOObDItRDBUPtMhMnAi/yJfXhQGo8a0tzIGql9RoJOlBKA7IKw49gKvrkZryNJ2rkDbXhzj8FtXDwhBDbFIFss13QfR/WYAM3xTjFX0MaCyIJUcyXnEq+OHQh6dEX0UJPkeZ+gMK6jDFDxrXtcjWgeY1vEQR6kE2mtxDCOCX9jr2xumXuoKsfb8egHElJw+gxgszL+8DCFmvUxiDyn2V9lCIxDrMFrAewzOfKMauMETRospwD5PGYQ1uIPZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQag8QO1YELCIL3Wzwh0EKKQVhBtub/DRNDya9qzZKU=;
 b=p3+cpCHZ4DwQER+DefMzXHLOdPKxOOf6kgoE3aujuOlWrSAPeXDSxuSmMyxlVUSKpL8koNmOz4wXZ+MNVIzo3MwVg+vVHKkGeeCwo3aGT+5HXbxrpYVCPf1Tzudc6i+oQSBzbMwn/O4N9WeASSNKIxhiALy5NH3CpN+xGVde3QJhVHMNX//guIjas+8rkYNFQeUcbCX/TLyelt3bscUepodkkC0WcYeMInR1IXZ8M6EipIGvKSVPk2cJQoJjsEOnZXYCosdRb7m02KV+iyNDC5FiPe6ZZvr4D9Jpt4eyfHZXRAORPiI5O0nKDc1b1r4zWGrYQrW2b9JR2j6vF5Rwsg==
Received: from BLAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:32b::25)
 by PH7PR12MB6786.namprd12.prod.outlook.com (2603:10b6:510:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Sun, 20 Apr
 2025 11:19:25 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::2c) by BLAPR03CA0020.outlook.office365.com
 (2603:10b6:208:32b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Sun,
 20 Apr 2025 11:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sun, 20 Apr 2025 11:19:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Apr
 2025 04:19:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 04:19:19 -0700
Received: from rsws30.mtr.labs.mlnx (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 20 Apr 2025 04:19:16 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: [PATCH 1/2] virtio-pci: Fix result size returned for the admin command completion
Date: Sun, 20 Apr 2025 14:19:04 +0300
Message-ID: <1745147945-194225-2-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH7PR12MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b569bf-1d22-49e5-7d28-08dd7ffd34ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7RP+9MZWfWQQKWkqw+A54Qi0JayC7TOlsENUd2densznsviCp+Fpi2ZZmDa?=
 =?us-ascii?Q?0/L+un6LRlzlrs1Qm+/ymCOrCQyOvoDSExduOZ0FyxT4cQICT6ea8srLAzeG?=
 =?us-ascii?Q?gyj2KtbgvSXQrjtxEfDQNKULbldKdJm7oYGjc/eFQfHZMkQcljdXGm1raeMi?=
 =?us-ascii?Q?WPYVwo/CRcr0U4/LXIthnmgHjklDs7DGboXo7ZsS2uapnDRyKpk2vIRkSCwy?=
 =?us-ascii?Q?MtrRBcP6NnycUdQu95E0pHYprK+WB3mcdW9Ok2Ymc7PR30LaNM9cXZNjfPxb?=
 =?us-ascii?Q?sYCq7B1ogW1fthSxZa4i4qEofDPhw+r1hMO8xLkkQGpo4uCraXbYwDp2m3uY?=
 =?us-ascii?Q?odyNxeQpBhnxcW6vFekKbGyhxoS/2txrFiI1QB+lnrIO/nD2X1EXd1n/3SHl?=
 =?us-ascii?Q?635pntaa+6Gvawn4Hy6pKVNLODhkpMbyXOvFGs6RX6DqzRLJqVYccxj7iyet?=
 =?us-ascii?Q?XG7pDedHkPKsbMcnJJ2NK+gr1VAQMBydee6u3fptFaY92EQcCDe55+zl8WWG?=
 =?us-ascii?Q?sEGPt4rlIWf/nHQwAhpT+Mey479T0rUTdhRDdVG5xr/HY7f2MeXSDzkgxAHU?=
 =?us-ascii?Q?bI/WYllFRSROHUilEpGM8xZ+TG7IXQjwHiRzVW7qGzEQDiT7MexdWDQ225pi?=
 =?us-ascii?Q?eiJ6+9HsFR0pLLiDtzjKLLiGc0MM2w+5RdStq0LM7AC2CvIoNyQpk9ivj7nM?=
 =?us-ascii?Q?NSb4e5/Jx+9wSYSLAjHNYR2unnjRosHnwdNKeT5UnmVwtxHvyjvt2OerAGDa?=
 =?us-ascii?Q?/ZldicaRqsKS0Ez++ESwFzsDO2yFNRT1snDIBL8ZUB5cPh7acxoctT7sdFWs?=
 =?us-ascii?Q?VXlm2yWRyVkA/GW107R8MlyCGQEtY2AQsp+RZyYE8XJZJ6lmp8JwPGLkjO5r?=
 =?us-ascii?Q?vC/woLdzjW1XJRYu4UoWqAcgM9F1K6+x6b1OHgEjhCW1bwUrH63d9LJNli49?=
 =?us-ascii?Q?Q7iwb5jlvLoSnRWuQ+O8ii250qUq6b1h08L94qnXHPBH3x5bJfjZ0tqBcS5F?=
 =?us-ascii?Q?GRLoW91pDuCYh3IOjF4Pfnv0ZPiaCI9ZKU81XVNS0Y3GjXKIULrb10wtNftj?=
 =?us-ascii?Q?1m0eGhzveAqD6NX/cX9V0P7rD67WexFP7uMFslVvtT2vs2esUJI8P84UoW/2?=
 =?us-ascii?Q?aCY0Z8HxcsNo+sFk00SHSQYJz7Mye4oEuEsI4wxZ73mqPW384TAQLHd4NCM9?=
 =?us-ascii?Q?AmiXyv32w0ZW0Z2+o6O6wzeIO8h1UMBOm3Ns2b6BYEOkM2q77Gn7fEK4EA/Z?=
 =?us-ascii?Q?Nwb/jO/XdjCo+sbwQiZY3k7H/BrFfCfa7s8UsSHuMhYesN8j7NPvPshT/DNM?=
 =?us-ascii?Q?LX9cFOEH5mZExepVv25Jhv+Zz/AHUL0ZKKI28IJg4FrKUMkojvokeDZdEyMZ?=
 =?us-ascii?Q?XwQwXA1CtfRc2fVl/8MahKdmsoyB4+AzOK/6Afu6jkzItpVYfdM4fSoksU44?=
 =?us-ascii?Q?Jm/iom+AZ6yiCENj5DZjz9YsU7iM5hvb4yhKmYfdr5NT1gX79GWrsBUMWDkY?=
 =?us-ascii?Q?oyH16iwnIknNTdYJTzRw/WuY+cMIyOjyVW7K?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 11:19:24.1867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b569bf-1d22-49e5-7d28-08dd7ffd34ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6786

The result size returned by virtio_pci_admin_dev_parts_get() is 8 bytes
larger than the actual result data size. This occurs because the
result_sg_size field of the command is filled with the result length
from virtqueue_get_buf(), which includes both the data size and an
additional 8 bytes of status.

This oversized result size causes two issues:
1. The state transferred to the destination includes 8 bytes of extra
   data at the end.
2. The allocated buffer in the kernel may be smaller than the returned
   size, leading to failures when reading beyond the allocated size.

The commit fixes this by subtracting the status size from the result of
virtqueue_get_buf().

This fix has been tested through live migrations with virtio-net,
virtio-net-transitional, and virtio-blk devices.

Fixes: 704806ca400e ("virtio: Extend the admin command to include the result size")
Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5eaade757860..7209390a5cbf 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -56,7 +56,8 @@ void vp_modern_avq_done(struct virtqueue *vq)
 	do {
 		virtqueue_disable_cb(vq);
 		while ((cmd = virtqueue_get_buf(vq, &len))) {
-			cmd->result_sg_size = len;
+			cmd->result_sg_size =
+				len - sizeof(struct virtio_admin_cmd_status);
 			complete(&cmd->completion);
 		}
 	} while (!virtqueue_enable_cb(vq));
-- 
2.34.1

