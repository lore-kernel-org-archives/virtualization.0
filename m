Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59370155A25
	for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745147972; cv=fail; b=SVSCCAwq4FdCD8Fe2b2z+4nacCvhLdgDKB+vuPkJv2nUJK9+r6QrObeXgxepYEjZKRzgHlbwgYiiiojTzrmPdKqXb2PGhkdwnBivRzYrDj+eTK2HK+QyZOBt4gOxPzojF43z7DlgVEuU1CtRdVntyf460PPKtTWC+Ni+Z/KqJA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745147972; c=relaxed/simple;
	bh=ZWF8yCtRnIpevOjAGneFJmFjxNI3XmJ4oKQhpKH3LzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGCq+mRCz515F98qJKrrF67jfrXkAr1GeI03/eVkvLfjjXZ3y2e0HjKUdnX+xp+V7EeYmI2RLCYUrPPMfu3TuGFohDV2OaegdRlVrpYRZ5o04tygrrUfke81v9taBeOkmZ4eK5+M+W9bGRlxYVr4VDwcUVl9XySdfIQMBFPsVm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y8staBbq; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y8staBbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNGcPsMELQlXp1zS6S8V0MOzC7UdAtwNNAgsvD/CMP9CfJkJClhWM8trLCLzIx00n73feAMjgLTvSI/Ykj0grNLigHdBHj+T+UCRY5nxMVghg291qrVyYlijPYTJl6DqWkNx82cG+XXN4cXuR/rwVA6JHxsCjD8iP4u4dCptY/krQzaWRLKPhWmjRg5ddhCwLT+q47TfMwboVuuIIrH8QHnWI7pUPpu+Eddo99JOefiGd/oEa9sd+nyd91/xHfOZHPat3ez5P7c6mXdSA2IFPypbsFGXO+i4orp0KJYCynqewnSRgKKm+gPXINjfaklQhsL4Z0r59SV0Bby3RcaFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/HOpaErmbsCpLU3S5HiH9mUgOdeCnWxRhJ7QvYq744=;
 b=csthQ+TdQMgmmI8QDCNAuKKDQsScrtw3ZEk7W02kbV7n7A5+QFzvaMaoinsP7XYtRNh4D8hDvfxfcZYPB9vtmh6C23502M/KoKJaB+Rtr5Tu1rRhQV3AgyDYofZkqzlB476YqxQpjUEuVf2UH5CepS/Dqi2KEclv90q1n9OznD8k69RqpDnTvQxex2c708TlIAfd+TM/TU9g59nN/+yPxXNppzvNn2d0gBfpYRt769Yr3kHnJZiUikcNlvVgd7u+boG1eevK+/nMbauPjlORBcSusLKUr8F1uJY9yPtGHbFsPf2XGpJOgBmZ4UvawG2iz7BUaFhwqLJYN8gYJNxXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/HOpaErmbsCpLU3S5HiH9mUgOdeCnWxRhJ7QvYq744=;
 b=Y8staBbqMWuSkP2wJTFC8H+SsEe7zjraUJKjXXPpM03IfjE5vPzhcKnzfXiXXLwJrXx+nSggExBqbV0wTEgR/qATKadAWDH7Tw0dMoxXqxIq7p4hg4vW6FiOj7+8i7cozr9VyLpKbd8TrVKq0wYeXw+4GhTsOTM2n2FwIXaX+1zo1zgFzQj/ADM0GCug6F8MXOVVhy65Xez8k58yfvg/yRgFdPBy2y7PhBijzSjFxRHuMv4O/FGIXgQpxeEwqjAE05PMAvSOxMHVcHog2IltB8dzoaCc0RVJhVG/1gVItSRXPNlEl6dCrrU1DgoBd4SRFgbBBeAAdAdAnRGg/jyJVw==
Received: from SA1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::6)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Sun, 20 Apr
 2025 11:19:26 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::7b) by SA1P222CA0030.outlook.office365.com
 (2603:10b6:806:22c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.25 via Frontend Transport; Sun,
 20 Apr 2025 11:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Sun, 20 Apr 2025 11:19:25 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 20 Apr
 2025 04:19:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 20 Apr 2025 04:19:22 -0700
Received: from rsws30.mtr.labs.mlnx (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 20 Apr 2025 04:19:19 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: [PATCH 2/2] virtio-pci: Add admin command length check for device writable portions
Date: Sun, 20 Apr 2025 14:19:05 +0300
Message-ID: <1745147945-194225-3-git-send-email-israelr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: ce45fdd7-a337-462a-9f7e-08dd7ffd35a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7OVL0mLC+R5rCzCnI3inaV5Z5fAYLDh96c48Fgwhlhsw3DY29pzAxYAHloO?=
 =?us-ascii?Q?hvdySfeSwXVoDkFZGfCwddjDKkzK1b82ZdRsZnP29iKUQcyZm2qewrxZuLH2?=
 =?us-ascii?Q?VsRxO59wUbxbDTI1XTq7kmfCUhL7I59fWxVRgocOC/Jn3FKkBDS3PRqNFWEW?=
 =?us-ascii?Q?5gdugVe0sCCY7lPldka9ebxrdLEZst4UWg0GzbKWsymDc/TXKvhnh1otTOmd?=
 =?us-ascii?Q?bQ7z/bAa2J5YLRptQclXHucxGUoMHE8aeIzC8+zZt/5wbjEOFcqPpjpyClB7?=
 =?us-ascii?Q?wCeLdwxdSWiLMSF9c3rAvXWa41MxqNmbAN1xjrbL3rENGLb3II3qaz6jm6bk?=
 =?us-ascii?Q?NwdGpL8e1VG39oguE+wU85r35py1cjdetMe0P+d4lTrv+PhK5zdJFcLCy19E?=
 =?us-ascii?Q?qCV04NDWNs1xsw6cO/Pj4EPg9aoXrJu9C9vP2sWI9l462Ct/LfOIvT9D342Z?=
 =?us-ascii?Q?ewJratsubyl42JOcxcdRaes9tuI9ZLeJbAec3Zyv1Q5962jXe+lEkj/aYE0A?=
 =?us-ascii?Q?akXeFhD7zgB6hSwEEnV/x0UsQ9J3ZFHqKy7cxL3QIUi9Aif0r9CAmqFgqEx2?=
 =?us-ascii?Q?KIoF5UF7iL73vLMc2gfy3u6vipo/lRyxaHEmTfDD7Lp9VUdUj4ir+/nJCIKi?=
 =?us-ascii?Q?C/guOVeZhoOmTRzRr+2GU1PMBGK09bv6F0MIAt4foGFCG8P2C5vYbJBk1p/6?=
 =?us-ascii?Q?MZi5bGdDKMbDvWr3fd6A1yX7z8GdniIVELFVN4+gaFwAK/YCwPkBN6PwA1ky?=
 =?us-ascii?Q?Jq7ngTRTPs1pu54vkP7HcZKJ95Xj6817yi7zPfVa3LzJtsHDA2bFkXscaizx?=
 =?us-ascii?Q?OakWprrA3elGvICI588w9RHcgsiHUQagE2lbBWsVozcPYJPhkDwxShFyuX6W?=
 =?us-ascii?Q?Sf+Wx3tX4+tidxrINjm6mUQdB56qkEs4BaFJfoQWOPUl8qg5/RVIg6UU8K0Q?=
 =?us-ascii?Q?B8/h5OsoB7miKig7sIZCrZ0lhcBvxGWf0FoyVvuRrsgmmI/8bWtV4S3VK4hO?=
 =?us-ascii?Q?ardgEk2n+8j16XA5uCvRh0amdptCzp+OqjS6NO1JmoOrSt/G8lFEH5rGtxWX?=
 =?us-ascii?Q?8fUvswyTuvyGFHWeedrCqlHRbXzp2veU7+fyX4+HUHNYwADzLQFESgoyZXEG?=
 =?us-ascii?Q?6JqHkfSWPUwEX1+EhogSlI00M4dRmL1AZu1SXmUo+SLBP3SnKimPfjSsaZun?=
 =?us-ascii?Q?rOc70GTQZ9hkXIf3Q5KT63MNCP3PPN/H7iQeNz+yvHUCl+pKTAtcq2sKxcWD?=
 =?us-ascii?Q?zqu9vCIaJx8iykvmtj36JgZa9ayCqP29HtwwBIkpdr6LmEYH0OH1gMHIRJuB?=
 =?us-ascii?Q?4lx2YzDCvEHX9NYZmbQep6lwaH+Qc8g0yvNH6OMuuKVIeyB2J1El+u64u4eR?=
 =?us-ascii?Q?4VHz2R5Oc2etuQXfbldxDCVyhw1MG6rlYEp9Ba19KKtnFCOVPXhCdD/uHcpq?=
 =?us-ascii?Q?Mzar4PhLJM0ObM2ayKFyH61zqNOg8ooatyPX8LsKz3ejHA6+VYCkSRSZBi+T?=
 =?us-ascii?Q?0W5OKa0/rgReh+H9GJLZa6Cp7ei7A5+jP24g?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2025 11:19:25.9147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce45fdd7-a337-462a-9f7e-08dd7ffd35a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856

Add a safety check to ensure that the length of data written by the
device is at least as large as the status length. If this condition is
not met, it indicates a potential error in the device's response.

This change aligns with the virtio specification, which states:
"The driver MUST NOT make assumptions about data in device-writable
buffers beyond the first len bytes, and SHOULD ignore this data."

By failing the admin command when len is insufficient, we ensure
that the driver does not process potentially invalid or incomplete
status from the device.

Signed-off-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7209390a5cbf..0374e86aece3 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
+	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
 	struct virtio_admin_cmd *cmd;
 	unsigned long flags;
 	unsigned int len;
@@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
 	do {
 		virtqueue_disable_cb(vq);
 		while ((cmd = virtqueue_get_buf(vq, &len))) {
-			cmd->result_sg_size =
-				len - sizeof(struct virtio_admin_cmd_status);
+			if (len < status_size)
+				cmd->ret = -EIO;
+			else
+				cmd->result_sg_size = len - status_size;
 			complete(&cmd->completion);
 		}
 	} while (!virtqueue_enable_cb(vq));
-- 
2.34.1

