Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B63CB571
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163107; cv=fail; b=pitMajsd2trzs/jKJaIxX7XM4IFL08XXwLKENh4KkvDnLRA2nYmLf477ACn/XJ5mvcH+m/ew4Nzz98/+YMyzI+dK49FXnjHqP+mnEbcHVcRqq0Scz85cjHS3BVRXbGi+/48daeMDYdm7aevxA6yP2W/QdOHFGS0rSSP/8whV0SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163107; c=relaxed/simple;
	bh=jezFkAvZ0XXShqH36RByNe1WInYD2kXtChIuWDYUx4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hR/4KwVFNjC/N2S1cBJR+3H5Q1dOQQEOTubAA9Pi/htZemFHPNXQO4VtOhK1rx3QQw/21EBCXF5Vh032JtCsPMG9Dioy4Qm8mtSP0bvSJ1Phfm94e8E5995UAstuFQXaRnPD8ivPcvVBajtIx50LSYDJBIi5esU6t/FOaUSWcnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IWXQZNol; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IWXQZNol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O++QBORQJVkuGHsGwGAdRar6M4BenuRVedqsPTm/yrP3n6GBzAK33lQtTS+HeqaTncVl0xXV9Vn9/f8Ogmj2EHxlhZ1ht3KuYMQsEKmDzjAh1E1Mi25iIgW5t/U2MtKqnko9oKWBeaQzkUOeK+nfwXMlBlgJxxWtfeoJV2E1j15d46M4GSpsHgl48G1t7Xeqkm3gSGN+AWOqllX0xG6Mm77SZJJpK+jFCmqEZMfw7b9/UJPNXcpGkO/qOpY2BqlcA8jWs0kRloGebi7TtAsboN5brWpEhIy3loILdjjsecIsxhgZxNqegmctzzLq9KXazrQkiEqZ1eUYEzUG7D5IPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgDgHOA+YN3jB9a34zyRKI7IzOR6U0tzfyhEyxt5iwI=;
 b=IZg4CvixjFjunYGLKdMSlcLX8waXzQEVZg61r38hnWVP3rbACtQk4nBid8IU7/kNdiACFpcr6g5u7DAe4A1P8VRG1CGLnD7/tsfJMqRM0frI2D9UuRhEvt6HRxLM9kGg5HoBxoL1jdlQ39WkmjgdejQYfdq36aU+v9yOF4w39Y1T9TqwmpmTXw/V4D/1Fmbk7RMcIm90sH3cu6XtAsDXyIaJ0xKOhwWCCZZDUFkF2W96YHryGyMgQMxgfdmPucDEm6c7oWbyw6E1NDtquT6lzVhW50E1wljlFLzMl2yFL5eYtG2nqtWmZ49GtK0sNXxvq440c01l3KGF72f6U1fFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgDgHOA+YN3jB9a34zyRKI7IzOR6U0tzfyhEyxt5iwI=;
 b=IWXQZNolvulqda6xBw/vNVChgcKrvSEuV6a7E91k3r26pSlYGYzETW6CFTOQOec5EuEPxoseJ1NJdBw/2lLmfen2qPUOLjn6T4Q2ORbvTtM6qN8Y3fGqYRZzFpC7SX7sFUsUUyuTkZoBUmCAXnk3L3hyPTTazCZ3b9+4L2l2pIG8iHNzqcJt6Tx+6bnzOpOq49LXpiSKCJ1QaoSEn6nLWrxDjPmE+WYhofZ6+n7kLMvJsNOom0Yh/DDoUsAh1NiNkNTUUjmMr947WIGta5qkVBsMekkX1EPv3NUfC4DoxtdETYNn1pH/4sJVlPHSk76bTbIti1ieka4EarQ674CtaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:23 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:23 +0000
From: Shahar Shitrit <shshitrit@nvidia.com>
To: netdev@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	parav@nvidia.com,
	shshitrit@nvidia.com,
	yohadt@nvidia.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	danielj@nvidia.com
Subject: [PATCH net-next v22 05/14] virtio: Expose object create and destroy API
Date: Mon, 31 Aug 2026 10:57:58 +0300
Message-ID: <20260831075807.2891426-6-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831075807.2891426-1-shshitrit@nvidia.com>
References: <20260831075807.2891426-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::12) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fcb129-0b8c-41ba-d331-08df0735a157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZT5qQIjef7x48fNMDrnHkhTW3Byk7rRJlPIIK+HfJhFVLfjxvYahWUVxgdQTfCUydCHkH/7BLhS6YVA4fuDTwX5ljFjGlBSN4tdT6uNS/sJs5V/n/SDJRgTBSYFJ6l1AowBcTvmdyvZkZmqE8i60jrA1oPScFIb023l9A4JrvJXlJsc4w8jUdLwLHjM5BpfcfZB8FzjyP2T3pnDSRRdQfgU8Pcjy//tFJspw10odYviHqGEDfXrGsJ+yaLEPjBcmeUEUffz2TmW4GoPGP71RPIdsxlYS7E0t119dgEf3iXs9HlKx/Gga2Stlsy9PUkHil3VObV87u8bhfygX/UbhvHSndx/ou9uyC15p9xfBDosKZhC71PLClRdKl19Ygbk07tNpJUULZVRxE2SqZGu4dWB1QEQg0/opGFY2aY920yVtPvpWrin5y9iw6ZlZbZuDWVA1nUzMc7d/xr0JQUoFm07D56FNCRDX8XT1TBqs+ORoMTez7XJ+it4aWHdqGGyAuGSw2c8VzkgeTqZwQoHL6/pWsO9D1Wq1fbfwPmpZ0cVqMkol1rFIxT3zeX3t6S9G1Px3ltXXpEqKbbhfYd8DKbXWszCaXsyzzTAbMfeXBXO7Le582nIbX4XDdTxdgPemb6w4/SSzHX5NjKw8wcB8bEkG537lwwdL4Kd2BAwa52g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3JCDrOqHwopvbe18SzEsMyXlor36VOMf2IO4elmShAu2Fi4ifT3p7c7FL54H?=
 =?us-ascii?Q?5QaXz2bi9LAFxahhScSLKsAG8n8nAVxiLOYp+knOsjEXXsp/fTDfd1PtbD3O?=
 =?us-ascii?Q?u44VDgtvUfkYJmJncaSqPr7MpTuFW80rsEZPuNjD18oxZXGjjwyuxhSHv8n7?=
 =?us-ascii?Q?VY+l3kx1NdKyvvbf5WB8zN3U/RSYG+1Rrv85uZUYceV/e6H2fFRvNfpAd8Rb?=
 =?us-ascii?Q?ycMklyaglxsWpVpwpjUunpPD5SUjurqhOzfsLF/3BsqSgbnNgBci2rU7B3gf?=
 =?us-ascii?Q?wuYiW6ogTalJb0Xda8ltgAIGAOpRVtTA+LVl3QZGUBHfaxu1ljGTjg3AUYqu?=
 =?us-ascii?Q?cQRpSsv7RstiA/LIfkn2PyIFmc6x28+stWLcPChWaZLVhnlq/TKJtl+4uuf5?=
 =?us-ascii?Q?lYo+RpndCP/OyBf4fihxHS+JY7G8AMiwqVCm3qX+0EgPJJrt9GF3yvDn0+gG?=
 =?us-ascii?Q?mabSJLGX1/nKYVy+SuwzhmBcw5DtP80UUNW0ZRQrUQrBYQs/X9py6uFINavC?=
 =?us-ascii?Q?Xh8G1b8Ii1VVGJlO/DIpo4AQe0HY2V60DELx3Gz0f0DRlAzplSX2KOUNNzgR?=
 =?us-ascii?Q?4U8fak02wpg+z8Ywgok2L2JC7EVvssy8IKueEO2cjiznwZjxyQrN+atFsxKr?=
 =?us-ascii?Q?7PipkKDZylSNSOAriJpxX08olWNmO4gGm9SuH1+lZuFX1j2+Yn7zRjUw+ITw?=
 =?us-ascii?Q?Pr6CXaCDEPj/LCXef+WV93sQqVJV/iOdtclxdAjK0EcX3AX+c6TO6IYn44jx?=
 =?us-ascii?Q?bxRI2gjiSTPXNMiWuHGTn9cjeuy2xCNYpnmTV02Holb7AgM6xuRnHxbUEafH?=
 =?us-ascii?Q?l9iVa3WsZlgDXU/oTydiUqvnRtlk7HdeoSCYz0XUW+qLL0qBDK+H4EozysNU?=
 =?us-ascii?Q?babTBt1FcQuilE7kBG55nro6fUEBVBUD6g+IDd4PXoJ9QjeDLeSHkhpD8EtY?=
 =?us-ascii?Q?F1Mf7KSLec2lpbDWZTkmREWSoN3kaqZQvoBrOfhqXvsENX3/kp+8xj2UzbBv?=
 =?us-ascii?Q?0OrwjyGDSLqTGY54AfbJvDA+yTBVGqzc1RZGpGiUoIkfn8OOCTA3MeMtZgDj?=
 =?us-ascii?Q?U6dCIYyhAEpJMhNU4HMfqShbe21bSj9mDV2dlsbPZSFbrL7bIM1ZPIEn/D/O?=
 =?us-ascii?Q?9FbjhVwNQwCNSp3v5Leeum3+D5EwEVGzUyfVRtfPZsxdl/Ia9l/UMT0LwMoF?=
 =?us-ascii?Q?6D8Y7/XxKKK7LplpLTQ4v26aoS4MzCcNdJ0VsIIwR4itNqAKkTiX3aWxvye2?=
 =?us-ascii?Q?/NxytpncznfhbSVT+blqdjMKbI790h0LzalrWr54eUgNkgoHbogtPW/DB9jT?=
 =?us-ascii?Q?ryDkqi1It1CGEApEFoafT1kPynOz0M15uPR937BI2H3ExaTZokeN9Dhw04Ss?=
 =?us-ascii?Q?sjNm19wGLcbL1X3B32zf2grwpjb3Co/FYeOlAjOvmy6lU0LFPSYK9P45dmtR?=
 =?us-ascii?Q?Clrs9lMWAMPFMBONjj6xRuDB7vYuudmI3iTGDpcWPwYekZrOadIXEDwrSvp4?=
 =?us-ascii?Q?94eeTPV7EkN/laImJGxF70vJc/0mrwP3ArtigsnyYD34jjeWZjpCGR8CXpJ1?=
 =?us-ascii?Q?4XLt9NVlqBbdEnnP1oiiYVvrPZJzEjeJtYasa/+cljJnMAQHnC5M7fMwftHZ?=
 =?us-ascii?Q?0tl1Ulx6R3Pjhr4v6o6KeO5Aa2/KNDEx1DkHKm+YWRdi3jjnoF2Qnma6WoVi?=
 =?us-ascii?Q?c7S8CpL+qFB2Me33HakYa2ce+DcI0m95rapARAu8gLa/wud1FHsTjkJJX+B1?=
 =?us-ascii?Q?RhKsuiyYPA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fcb129-0b8c-41ba-d331-08df0735a157
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:23.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLTtigUDgv4zU3hxVcnN3yA2yVtccg6hNvqks8PvL9dmJDkTr2Kac2lHLE8cdnexkrrz6hDs2KNO9PKmcGArTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

From: Daniel Jurgens <danielj@nvidia.com>

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 41 ++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index 60d92875da23..08b41f38baea 100644
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
+	data = kzalloc_obj(*data);
+	if (WARN_ON(!data))
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
index 1177c4a20e53..9095a0481495 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -86,4 +86,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
2.49.0

