Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D233062
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318048; cv=fail; b=S2HpvMYPxr4/E6njky1GajkDLJsJnGL2BMbnAQGAGMeygjtN1oQAFRP2gSgOKIgVMJZpC60j/IbfxXXu18UszndkO86m+nAVuqxSSCKJKXUOAL2DeV8BPRXdg09N2pHbxPX+ahF++hnYmggKbu1s256WO/oltYgbfn33vmzO9fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318048; c=relaxed/simple;
	bh=9tS9rCZJGAvvfe7EgucBJhkjBb1JyDrqEtNOFlKDhF0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z+06OdBeD8gLRnzy1Ice9TiO1wYPwF/092nkqYVA/k6nA9JBwZHFt44+pS4tMWKsHlTX2UCVHxujIff9yWsN/BroNu0BTrX1WAwfqKCS71Ky1lsRQQKnESfuB7eSc0Jz72lLNvnAoarlKToTnHY23tzSFCVxy+anBLZjLn0R/S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZxO7rf8i; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZxO7rf8i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbh9zp/PkfFcMXCzJF49Xa74wAPXJX8PgFp0heNipHLnUGcZA5VJ6vVNi6j0DXngxwX58+QL4cwCK7VYLWvS2z/p9cJ002P87qZKHi95BGerPbgbJOIz6fZRLCDRZ785Q3xBvixrq1KL8Fbd0dTGDdEZVB6Pe+e0Ar7o8WDHsjFLEuvU6F+PNGxyAJ0TMxIK9rmSNCm9Zsdg1c27y21prpslvj1eTIqXLZ1w+CoSzEzW+gZY892qBrplPPWWIRT0pz0fuAxmjr8xg5n/rhBzMPkNbOWALeQ7hTxRNO8tjzjobWml0GQJ1Qtbuj83aD3Y742ETvZdbDp/keW/+vFssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNDTs16KIMJf4f4U/RssiXcvliubWmnnyr2+rSy4gmo=;
 b=l/Wc600eYtwT2l4TUxrMUu8A7sZbm2Bn4HBXCgrqUMkgY7ZpZISUqoojrzhYOvWZ+fm2xQHqn5cZxALXBI5HHhabVIsWAd0H8p7LqZBhzpHhYNmHKxUP0HCooTZIUUOc4oRvc1MiOky5xl6XQTDfLQBUrjE1mBjTHVWUCJwKf+r1QAFoBLeTOSIx/cDpOSnZve8iDw2XnYJf8ZyfzEf/klDm0m/fhlzT9NRbhbVMvQZ/i4qJBx4UTiLiZ4QjzTuO4+INYgRSYMnLzX6UJLG7ipbfQ99vce2XQ2A1yIdVANeKN4zJMSNwvoCnD63aqcPdFCaX0MZXbFFUL0C0Vsbc4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNDTs16KIMJf4f4U/RssiXcvliubWmnnyr2+rSy4gmo=;
 b=ZxO7rf8iXg+ivl5rBfDiwETWtC4SgYR9tGNVRwlqjfOz6E6lFoe7EnecUdRraF5z6BvJcL+vzv2C+D6q8ihCD4BnxeZW6RRCxjUTlNzzYOb1b8YKiNSLE3EYDyljlBmkdBKWr5ou+NviQ9A3WfdHvgpuPES7VIs10az5VOKQqI6RFUQK0uJOBs+C0pyKTM8tULSpTpKn1s+VKYNP3egfT7ZqcUhyWlkLy5/aLMz0hId1S6uZfHCsnklOtw/uRRuz9HOmAA393EG43HsBOX+lkmkvL8G3OtRy7OGlyQbr2jssowR0z8kZrVvu/r/9Snv6/Lf2YnKD0U475zW16R1vrg==
Received: from BL1P223CA0038.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::7)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Tue, 22 Apr
 2025 10:34:02 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::41) by BL1P223CA0038.outlook.office365.com
 (2603:10b6:208:5b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 10:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 10:34:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Apr
 2025 03:33:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 03:33:50 -0700
Received: from rsws30.mtr.labs.mlnx (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Apr 2025 03:33:48 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: <virtualization@lists.linux.dev>, <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Israel Rukshin
	<israelr@nvidia.com>
Subject: [PATCH V2] virtio-pci: Fix result size returned for the admin command completion
Date: Tue, 22 Apr 2025 13:33:45 +0300
Message-ID: <1745318025-23103-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 562a1f5f-b489-43e4-3628-08dd818932fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?InGUQ36rKNjuk8GNDO8UQ4GSP4o2Kk1IiEB/Wd6MtRr3Td/u+1rRrwx3/WdE?=
 =?us-ascii?Q?muvbEy5OEgt/NZt1AIS3N9CUBYJDsydnp3hyozvZ2G81/Rr6oPsTY00phUJi?=
 =?us-ascii?Q?xlfvO5Q9JXHENFmnMGz/34H3/ZHbbyMQrVWoyVv/FutQTefmf9QCDvjJ0GPe?=
 =?us-ascii?Q?S9Uh1xhwUtBxOTrMZeKj3zms5XCCKMPEQaLdZVonxg4Cm8B1VoxLj0l5wPCo?=
 =?us-ascii?Q?PgTwEjjem3xOUB/r03SzHP7Icsa4j7M4IOJhcHJta9GdkrvZ96A5F1YtGSQy?=
 =?us-ascii?Q?OiJCshhGnP+LfKVTZc5cfsHevnT/DHo+UYbotCjgmn7FwjZYYlImywoVrkaa?=
 =?us-ascii?Q?YXiPrs/aFEYy3Wu9V9gWldxiwMs8iUmuHRhTiF9Ptj+zlzAu5tzmJ1B1cSwC?=
 =?us-ascii?Q?2Pr3nHlhvNwO5h8i94m4dHoP1qgJbD3xS90KPUAlOekyxCLevNP7lzpjvWZp?=
 =?us-ascii?Q?emXTqs91OqWZK/gpqcu12Mkm8NcfU3eQ84CWSnH0BwUaj2SVTter9urkKZrK?=
 =?us-ascii?Q?wbyTXQm4gEe88pqzXeyPP3yHnPzgAJaww/hooOw5SZZ+Q/1/8HI6BRhIO1qF?=
 =?us-ascii?Q?syd3fGLX2KimgMuyUjmYA+i4aH9rYttSlDG5/6noA6qU+bhuSYpE9nRwi8GG?=
 =?us-ascii?Q?ckXPITaj8rJ96KkFUk6AjlJ71Tn406BIvz+dH6Rkg/9rPp5Olp/N7b/CzgOW?=
 =?us-ascii?Q?g/R7bslP6e06+bRMnGOkjcEPR/Uzcqnld9HQ6mvU3RvSw19lBsBs5f/SCmP0?=
 =?us-ascii?Q?VR4GNPtXWS7LqtdjwKDPln3HiGcQYyvc30+3dsKDm/6XFzefGW4rsOxfDn8T?=
 =?us-ascii?Q?8wD4Zfd/2Ar09x7UvH0oy+Og2K3/ghp3Cd1VoZh5PfMmi4LS4EcK6KeukX19?=
 =?us-ascii?Q?sa7N7NylMWwW070iunaEmVqso5TP1sjhVtJugr6NgbZUmF5Jri537JGEqr5/?=
 =?us-ascii?Q?YYjGxCs+wKee//Iazi23G30LwMYlQRBoL8igqgFxrIFUnbU5GAZfPrMZ6zTm?=
 =?us-ascii?Q?oVQZ83y56EgqsRMxieSp9mL07aFkWpmMz0nVaMI9lpQFfc0cmNm1tA2pqlxK?=
 =?us-ascii?Q?ecLCiFKCGT/HUF9UEsaJgv4xAvYKLvOkjoLWWq95kLP+1/zXGBoAucnoDGgM?=
 =?us-ascii?Q?/SiGQTS5vIK8Jm/aHtGLh8//OVAl8nY0/o7GqXBnmB4E0kk+avoqnBSqv280?=
 =?us-ascii?Q?oh1C4fvbIkEflONBqL9Mb1KrED+f7bToxWeW9wGYrBkIy9qFzea5k+SCgClZ?=
 =?us-ascii?Q?lH6mktYt5j/zVO8/X9ZglvFQTzTFr/wh0mvrWbsAjLipo5YHbWiKp23DJEAB?=
 =?us-ascii?Q?+41n3vAa370wmWfAUVliTFReoAb52r1cBCNupheTJlVsKaS2A97ZV9RtP+I1?=
 =?us-ascii?Q?HhbgsR38v+H94LKRUJnrzCLZ3wEGLGGJ9oYfsfeq3bl219ZJUCw5jwFaNVRj?=
 =?us-ascii?Q?oODGMoLzYP/FdawG9+6SZJFh6uOw7BPXCg+ulBe6+5e4ZRdysIrYQAY9mhcg?=
 =?us-ascii?Q?4rJ+GXaTUOaqS4jeBjc4U93NX1VFaSA1BChn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 10:34:02.0536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a1f5f-b489-43e4-3628-08dd818932fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

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
Changes since v1:
 - Set result_sg_size to 0 when len is smaller than status size.
---
 drivers/virtio/virtio_pci_modern.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5eaade757860..b2279c758d11 100644
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
@@ -56,7 +57,17 @@ void vp_modern_avq_done(struct virtqueue *vq)
 	do {
 		virtqueue_disable_cb(vq);
 		while ((cmd = virtqueue_get_buf(vq, &len))) {
-			cmd->result_sg_size = len;
+			/* If the number of bytes written by the device is less
+			 * than the size of struct virtio_admin_cmd_status, the
+			 * remaining status bytes will remain zero-initialized,
+			 * since the buffer was zeroed during allocation.
+			 * In this case, set the size of command_specific_result
+			 * to 0.
+			 */
+			if (len < status_size)
+				cmd->result_sg_size = 0;
+			else
+				cmd->result_sg_size = len - status_size;
 			complete(&cmd->completion);
 		}
 	} while (!virtqueue_enable_cb(vq));
-- 
2.34.1

