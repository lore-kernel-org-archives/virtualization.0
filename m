Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297B259C82
	for <virtualization@lists.linux.dev>; Tue,  4 Mar 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104924; cv=fail; b=GsT5uq90M8RHfe2HVSfuOVimtV1D3WHHldjl6zxGbPJPqgyj27lhETRlZ3gYS5QNjqbMMl/DMzo6rDa2uu/XbylNObvUh4eOY3ElTb0VAq9unPBk2zsUxatALQQrjIAIY8xM6DmMs+Mex0GLupU72mHO5fjwbEETJtQIKvnBQ7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104924; c=relaxed/simple;
	bh=O1DM8G/UiBQJzdwba67yPmaISSgbkxrFffeIxwNkO40=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XpfPwTzU+tO2bs7yUIqKj5ELIqN6UXTI3d6kj42VR7N8nqjAPH+3piDezg6pcwPcJ5zIXbwB5FHSrhGeHXXIZHSdoO+1MLe7hWDhT7h8qRG2f3k0Rwwkc3czDda7x2Wr+d9R6SRedLjn0a1hXsRWwN/NzTQcSBk0SmcEYvk98Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XENgnK2G; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XENgnK2G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+RaOjIg5QUChn7BAqJSzL0gBi1iouR3+21fBzHN8k31he8MnOjm735NcQaFT6/0Xdy991HIvPmQPB9eb0iYWmvk2shr8nxgtAdEJ1FNOu2b+y70FY/OyyINBSbh+Cp39JZFTulEWrm0yLE6kq7yPGCen4zTyRMd4QmDHRUZTb8mKjR0gh92a4raMybLUHXy+OqNkatgbdMOAGhuF0c2xnUhzJxzTuVWvezI9gAAqqtqKVw/tnEO8hT4BO9rm89FYy8lo5pDvv5CvX7PezEUep10hqEiaSz+fRr9L65YhSZxNn/D0R/h5f95K1tOWw8Q7RVqELHKmEK24C4YMgzEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re8R56dimUFClr+4NADw6Smx6S+m8B1DE5DY7TYNtxo=;
 b=lDN/Pd2wzkYEcPxAozaOU5i62FmYFh6/wMQMDdi6+A0xQItKskKz1nEKa0pLH2ecBRn3Y8+UQOcQzW/Ifoxmt0OYms8osAf3LvHnLNWVfjT8B+qj92Y8ZU3TP2EU1qlShpwFDSGm/EIGYvDYdm0oeqNS9FORjj+/tXzc78prTSwPl3MF9RaYX6EyM6FpZWRK6gBpCxkG8eFvdtq6KyTLMTPom3zcBh7aIzwXv1KcZ6puUPtw99IL928B5PnrcYhzgEgj08SadWF2RogTy3yTUBdiAISbdIGdGoEZpUlQ8DWFk6vgJSZAXtLlSk7taFgXqNBqnIoj0KZRyJVBrgleeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re8R56dimUFClr+4NADw6Smx6S+m8B1DE5DY7TYNtxo=;
 b=XENgnK2G+fuOzG+za6EMcmCN7P6u3d3gTquAZ1MDUojYAh5gh9A/tdhNWzED9kUMKTjojVErZbgLS7uaCYvtLaUND1vTdCHuMYdDGgnANFLpZxUeTtdk6FKnHgDttZvfoyHUDi9jzqo6vBx2CdfMukqr3ZOsMvM4bST8qydYE5v70rar/T69I49J+6cGpUvyYjTEulBFrobNKRZHO5ppap3fldLMF4s2NR9A0SXv/elUN5qsucgjp8S3veRDdQ4p/efV/XPqWbWPCHsiynJpmPPTUAnWWkqSe0F/ukXzd+ojnV4MBUoHfiNj2qCG77aG5baxV3Ix5SveMbsUym0Aqw==
Received: from SA9PR11CA0007.namprd11.prod.outlook.com (2603:10b6:806:6e::12)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:15:18 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::d9) by SA9PR11CA0007.outlook.office365.com
 (2603:10b6:806:6e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 16:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:15:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 08:14:54 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 08:14:54 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 4 Mar
 2025 08:14:53 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <eperezma@redhat.com>,
	<yishaih@nvidia.com>, <alex.williamson@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH] virtio_pci: Use self group type for cap commands
Date: Tue, 4 Mar 2025 10:14:42 -0600
Message-ID: <20250304161442.90700-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: f9622924-fb57-458a-d60c-08dd5b37bdd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cf7dKlcYTfvoM8t361cxBE6xOCJ2fjO8nhHwlaUPirAvLCNdQyEgF3pAj8Um?=
 =?us-ascii?Q?t5y3+4ECNsfjnJMAMsT3Chn7oi0kBV2akdEHNog8rThhDfVQbjMzEc69gJfN?=
 =?us-ascii?Q?BwOdzhq/egqOaFl0DNZZ7XA82OmnQeC2xMH8Av9eplyI7qu33eOZ+pgLZ24M?=
 =?us-ascii?Q?QagVZkfoQqXKhkGmwTCxef285HzvO3vyAbPi52WPugZ0j9oCDQJoNG8DMYRb?=
 =?us-ascii?Q?ykx4qUNk/aXweTVv63J5DWGWJ5cA1mxjd2zSnYDcuA0KsPyfI4bN0gCrrZIs?=
 =?us-ascii?Q?Sie5Ia7OPHbWVEbhqnXIB2rYRTT131FWQn7q9I6lrRC9HUbAAjAZaNBk6X0E?=
 =?us-ascii?Q?htHT6uwZyJ1nQEGtoMeDNMU41LeItu+OR1ZTXUT7e5lc/m//6hwgE5S2NM7L?=
 =?us-ascii?Q?KWJ678HwX4e68bkG2OVWXL9ZARd/D+opvN9lm4tWptaxykoyV+HmFEGUsa+c?=
 =?us-ascii?Q?z9xEt5WKgESAN0zDGZyKeTuaA2BceNp1+xma57u8AU8GuStkgwJLVTUywvoI?=
 =?us-ascii?Q?+F7pZ0tYWfZvG5n85Jmh+YhHyfODT9p3P4eT7Z7HM+aYlAe7EVpvWXBVmFe/?=
 =?us-ascii?Q?qBQJqqn4vAIJoVWG99/YrChlWQqWKHVRuAmfJErEZhe3geejy5P6lIKNsGDx?=
 =?us-ascii?Q?pCZkm/GxHel9pC+247FKrcpEg17NyeArjCCk3oS8CdEdkp9QoCaZuCkqWMYx?=
 =?us-ascii?Q?R35TSpXxACW7msU2934ImSKsuDjtRbbJFOa7xysx2lh/rstPNTbMNCwS65YW?=
 =?us-ascii?Q?lBClltcqYPeRnS/uh9bm3oc6FzqkGgzWPUxu4/CE1WWbvhmNtOuoo8fnmVKX?=
 =?us-ascii?Q?B0C13Whd2sNbMW1EBbpHUWTbcy2mjbgoklFG7Rf4Cl4J0O6yZ3o0km+UyKUP?=
 =?us-ascii?Q?SeiYQnhvlwqTCM6r3NHUs3uQ6c/4BreNlYlgBJkqtVtFT0MvzJeBVzY7xsWa?=
 =?us-ascii?Q?N8Iy3QCVD3+3BmyEjPocrCKMIRo9F7IqvRhnAviV9oYqcE7IrRSQN6iumuCz?=
 =?us-ascii?Q?MLcjgexp4EHsgxGJS6GDzK5In+z0SWxO5vyN6bXh6er7bL18TkCLi5t/oqPe?=
 =?us-ascii?Q?Le895mXWGN0rNoJ+66hKbw0GiSs8u4KLwailAUX8BFLnOTw984rtuVnB7GTq?=
 =?us-ascii?Q?OrNMEWCrHaj9rx+au3J9xz9P/zj2Z5VX/QNODD5UAQur6Vuvf/hwk9s3Ecxk?=
 =?us-ascii?Q?XCtWtq1dDDNGsdSp+8ELZ8o/Hq/dCYbYUSEy9R0Ofenvxg0bpHWEz8Pz0inU?=
 =?us-ascii?Q?honmSG1/tCcLT4Ydp1Ts8khtrLDS6dlg/KnHuUriQd2r3efyJWBRNXzA6kd6?=
 =?us-ascii?Q?Nj6e86w0P7/uq4fSxElPuVUaBrZrRjPZpYlt/W0W2RV3OKLRUrDF1vJhgNZ0?=
 =?us-ascii?Q?9zueR7c70QYX7MSYlm/d/YPQjaTDiGyS7t4YPAPdXo4eMjWRn/vIQSGC1bsR?=
 =?us-ascii?Q?RV3aKFGUxNEQ1d3cN9Ru9FLlds6V3cQbWzxY3MijtWa6HsXQYm+UxWbAjefL?=
 =?us-ascii?Q?9XT0gU0r6rClh60=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:15:12.1308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9622924-fb57-458a-d60c-08dd5b37bdd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263

Section 2.12.1.2 of v1.4 of the VirtIO spec states:

The device and driver capabilities commands are currently defined for
self group type.
1. VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY
2. VIRTIO_ADMIN_CMD_DEVICE_CAP_GET
3. VIRTIO_ADMIN_CMD_DRIVER_CAP_SET

Fixes: bfcad518605d ("virtio: Manage device and driver capabilities via the admin commands")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 4 ++--
 include/uapi/linux/virtio_pci.h    | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5eaade757860..d50fe030d825 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -247,7 +247,7 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
 	sg_init_one(&data_sg, get_data, sizeof(*get_data));
 	sg_init_one(&result_sg, result, sizeof(*result));
 	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
-	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
 	cmd.data_sg = &data_sg;
 	cmd.result_sg = &result_sg;
 	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
@@ -305,7 +305,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 
 	sg_init_one(&result_sg, data, sizeof(*data));
 	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
-	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
 	cmd.result_sg = &result_sg;
 
 	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index 8549d4571257..c691ac210ce2 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -246,6 +246,7 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_ADMIN_CMD_LIST_USE	0x1
 
 /* Admin command group type. */
+#define VIRTIO_ADMIN_GROUP_TYPE_SELF	0x0
 #define VIRTIO_ADMIN_GROUP_TYPE_SRIOV	0x1
 
 /* Transitional device admin command. */
-- 
2.48.1

