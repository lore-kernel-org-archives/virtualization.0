Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A32223705
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051977; cv=fail; b=qf4a7D0tVxHKzyDg/aqcvyrc4JQF2qxBsSwYTjUY440xS2g3v2Lvev2zsHrzpJoizcBLkusq6y+CE8o38120F+aGzXxe5cgbk8LNjp4cDbtuJckNNmU152LDyWEbqF6S41dSp0raNj7wCN3GDabM9nBCLvkrcxZJYdXjO5Kv+BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051977; c=relaxed/simple;
	bh=Q7jwogH4HAzXhwKXwOSVgPWx+XlBKLc8CMjdy0U5OTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/NhHFnOqij7A0LY9Obs++rupFoZ2FXhmddBJ4DN7uUgfa1FDQ42vG9bo2+CvomHzJ3A25+wWT0Xf2opeydEiHpU9dKYqe7AHPHT/+Kc9N/UEWSRl9M+KpaS4N4Hm8eyDn5j2JPPmwGS+mW94GNfuPt2DnBJefkWAD3LJLG9o70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IU5SlcM+; arc=fail smtp.client-ip=52.101.62.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IU5SlcM+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spCu0IgpgXfmKvfDswA4fz0RmMdSYlhTfkmhUwxUK3zvDuSjCbDBk60jhyV8pvFTKr4gkR8DouU+ehfm0oz25HNjHBS3vuuMIjh1s8Nehdxe+DKKrXhqux/Ab25E4kdSh1rZOzaLFDalws77OFJoGUUe+NCNAEJjnDkYaheRcV2uyqdTTZsrHJbae4yzB749hcXcu8nzi5FWA0XnbQ3rlMLG0HrCCF0o78ylB56iZqvPuPDXQV5dLJVn68CmB532RHpPbuMYAILhCfp38GDlfNF6tUjWe/Ut96dOq7PKMZDnqS50/lvUEhNLR2C3RDYkZuDLGHhSWuzzoOF8RjVuEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlbW643wCuvJ/L7F36TTH8biSEXn73nfPLD5W/3ThCA=;
 b=k0bMKy2sx5DN9G1OHuTHvE40HujnRSvwG6jAStrX/hczD49ZuaguOdY7AeLTg39gG0zjMt0ZdYDUAEL1UuUj7e5XQ/tHZTQHVzUc9nAFGitEY6mlSASulz9sU6rSsNbBpc9GZ7VQNWfbkQnEun+dQ18c6saG7DZ61fEzbz2Ymk2DXPbGXpYY0xxEnur0yNwTK75oItVuXWYj5cNGuWnDo0QbM3uCWL1lTnVgG0ys6lUvkUJ0LgLTGWLrNhwCOBOgDAqMq8DkUt0aeQpREvr1Ip0NbDmCDYZzFW19s9pUZGkEGbRll6nKEeaeCVlfVJyO5YlZQpdJwFGKzg4ddah2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlbW643wCuvJ/L7F36TTH8biSEXn73nfPLD5W/3ThCA=;
 b=IU5SlcM+IO0dyPtu7bvLUxredINoXuWEM7spV0DdylxEZWmy99KLbQn967XkM8FtBNWrT2usga8UcCkJyAh5UPhSDZv+FN35GuHoldksgkdcMN53pIg7S6Bv3xYcSdEjKh0znrrOE0aZJeTjSpTIOBw5hQqhVQWa0Psj7giZEy6XCioMxyuHMgYEkg/AN9JPjYTymr7HlK0/r+u2TEIiSpe+gHd56NfkSBks4hqJCgYmypgbqIzTyX5ufX9v+nrOk9EPN03qivQ0FBvxuOG5FpvqjipKqjmhQ9r3/SdIRabwgR6tyEGNZXr6G2ZbgpalKA8PQBzVzvtbYHH2d7zhFQ==
Received: from BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:06:10 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::83) by BYAPR04CA0034.outlook.office365.com
 (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:32 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:32 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:30 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 04/12] virtio: Expose object create and destroy API
Date: Mon, 2 Feb 2026 11:05:10 -0600
Message-ID: <20260202170518.9076-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202170518.9076-1-danielj@nvidia.com>
References: <20260202170518.9076-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8667d233-ab9b-4f16-2efa-08de627d5cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5d3YoCIYHOwcaQMOTzjl4O2dghMIPplmfp9xeohwSxDUc9P7bKZUaPm/lLi?=
 =?us-ascii?Q?24Glh59JYdaJ0z5HNPasUK2c82efw6ckLakbFd8F4tKtGYexzMeMwwi8HBjH?=
 =?us-ascii?Q?RyNf+tHwY+tMGxb2VDf/9oa+ywdaJhMYfG5GXLZmKWxfopz+18ROA8clyTkh?=
 =?us-ascii?Q?MV8aojyEm/RO8Ib8dRWTrJ1GZUIy3cysgDfmeG+ez0xNaagLnMu1ZFpy7qEm?=
 =?us-ascii?Q?QDXaZA44J7trstkkzwOkrBaTAy08N54xOODKNJ+6JnzRhVM03YEer76DI7It?=
 =?us-ascii?Q?84gua8hK9pJsTMw+5zSXUqdGs//NRXB1UJBaJJNPTkBw/1j3l0FnyoXV4Eif?=
 =?us-ascii?Q?bUDzGi7D90oZ5G1JZrCKGA6W72K+YNBn8/Z+PqSHLjeOXczmL0uhv8cD3SzU?=
 =?us-ascii?Q?Nzqxk2f3QgeJlbHNwdfh6jpUmO1x1rLAVaMUzoTCV6UVJ8exyK6CBlzIT6IC?=
 =?us-ascii?Q?6OSLWbkYi5h9Y2dt2gPvx3OPcIbkuZh9vBeYA5fLnfLahe/30W7H2KBgku08?=
 =?us-ascii?Q?Lv3uYEC0n+PD56tiUJpZyhOOyXL/QK9RCdchfdlOwJPdh843was6T0wFfecj?=
 =?us-ascii?Q?dwMyiEK9RxHo1Z8CWQNoT1G+FJffYAODCo2drz/JMLnjce2rkRIkMBgSrpF+?=
 =?us-ascii?Q?QFu5kpVzMeWQm9FMWc7jgNcB2tA6KOi04/s4ybEiukllzWSmsJ96LKmfzcGL?=
 =?us-ascii?Q?IBrDK4dQtsn9LYmuc58lZsRZDF7sjJ+DzV68D2b6mbfP4DQ0h65WJLCNJ+BL?=
 =?us-ascii?Q?f28KIUXEOFcZrCzDesuntb0zXb+4uq8kcNJMB07mYOczdiuY+sizdyNccTx6?=
 =?us-ascii?Q?oModxDcpokLy0on0ZAG2ah6h+OIzofrNgvq0SeAiCjzUyDz4Amyi/UDKV8ww?=
 =?us-ascii?Q?ZkRZIsp+bcggPyVij6M7rF7puJVvyG8b9wMkhxem73t+ZF62bsb80Zy+VHdY?=
 =?us-ascii?Q?JWk+yto47mO5qyr35AVfDPyYK6JsffNVTr4Poz6sKivYI6kzemgDVADu6DYs?=
 =?us-ascii?Q?ffVIy7qvIii7E5uS021IHNlicK1kMj+O9ljkC+7AXTDi3UKr6N/3miTObczJ?=
 =?us-ascii?Q?PB6dAl9vyjRsH+TujdMzpFILDKfLHf+W7dxuIQz7jcwvrqUuCTkGw7f5eMa5?=
 =?us-ascii?Q?h7FGlpG763EwcRtYn5bDw5DsKiN2Jh6QT0uFY6hpAHpHJTeKFO8beRQvn+7q?=
 =?us-ascii?Q?BZu18Jkpd65gIoCPekTCOFvjUnjAKgX9ATLfk/XkscGHzkS2UwgHvo0M+Ct8?=
 =?us-ascii?Q?ydyOJD61wW/+4pW8ODy1yDdnTHZgPkxURbCo40B090/sbehOljTygwb0XxOG?=
 =?us-ascii?Q?jnbP8SFno4VWLNv/+V0tCP1HVL4HN6FI7zbuiux8FkjxdAo3KYeZKkd/A6pE?=
 =?us-ascii?Q?Bg5o9/mzhM2i+rPOftDcKQMHKIrl0WTqG3WkuEpvZZT0yVPS4xFOBFspNNJu?=
 =?us-ascii?Q?fbW754PJhFPlnSgKA2mJikc5guk/sAXy3dEfJHPETHALDRZHMKC749xd0GHD?=
 =?us-ascii?Q?795zjldPzIZ1AOhJOsKUh54q2Clus3H89OeIyghCx3Tk3ybZCCl/pp/dmbxI?=
 =?us-ascii?Q?sJHixDoswPnwxXQACPxESdV2L34Pa2iYmlKTRN+2VtA9pa+tUHQ0lFQLc3iA?=
 =?us-ascii?Q?crU7tsc4cLMkOOxOd5r6m5vvjzjdK/0mqLX57U1YiU+HbiTuBoY9t4YCa3qS?=
 =?us-ascii?Q?S+4Akw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mhPfjPpODlo9VAR1YVbgaS64/NmMN2TDoyLCilwoY7yvKkYeepA1722FaxnrqipwghqDsvZajJKeNRklhjMOvaY64YXxkNFLDZgbiqyjmIixGodxK6iECTtk5A4XUDQ1o2RZ8dn+s31iQZlDaEuKockHxmdGHiYI1/miaTwOACAefkkB2pXVECXgMNDBt232pCKys5fWEV21m7XQTgOdWZOix9v6Cn45/Z1A6Krf294iEYWHDWc6BWwIZwV6Z4x+KfCKVcviKZzVpLHatQGeJMPaEWVkwyQDxYkWt6uWnotHkZvrRp2tKNSpihRzyaUnyIz7VITp0hQFTM0KqAuIZqH6kjv6GWD++dPsv77oxFNpunu5M5VDNhrDRmmjpxGe2vs/HorzzKRsU2bwRkxnYSuGY0dkJWlOc6CjyiAgghrp6XpBjERKb2np2sknYIwT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:10.3072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8667d233-ab9b-4f16-2efa-08de627d5cfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
v5: Added missing params, and synced names in comments (Alok Tiwari)

v13
  - Makek obj_destroy return void. MST
  - Move WARN_ON_ONCE in obj_destroy here, from next patch.
  - check_add_overflow in obj_create MST
---
 drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 41 ++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index be9144b25d84..d9b65be2d09b 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -94,3 +94,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
+
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size)
+{
+	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
+	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	void *data;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(data_size, obj_specific_data_size, &data_size))
+		return -EOVERFLOW;
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	obj_create_data = data;
+	obj_create_data->hdr.type = cpu_to_le16(obj_type);
+	obj_create_data->hdr.id = cpu_to_le32(obj_id);
+	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
+	       obj_specific_data_size);
+	sg_init_one(&data_sg, data, data_size);
+
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
+
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->type = cpu_to_le16(obj_type);
+	data->id = cpu_to_le32(obj_id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	WARN_ON_ONCE(err);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 4ab84d53c924..1ccdd36299d0 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 			 const void *caps,
 			 size_t cap_size);
 
+/**
+ * virtio_admin_obj_create - Create an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to create
+ * @obj_id: ID for the new object
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ * @obj_specific_data: object-specific data for creation
+ * @obj_specific_data_size: size of the object-specific data in bytes
+ *
+ * Creates a new object on the virtio device with the specified type and ID.
+ * The object may require object-specific data for proper initialization.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object creation, or a negative error code on other failures.
+ */
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size);
+
+/**
+ * virtio_admin_obj_destroy - Destroy an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to destroy
+ * @obj_id: ID of the object to destroy
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ *
+ * Destroys an existing object on the virtio device with the specified type
+ * and ID.
+ */
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1

