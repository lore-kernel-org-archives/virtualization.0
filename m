Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B541687C
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766061; cv=fail; b=Bb8PIQBoctGlQGrqrtx/Sxpc4eqTciBGswBVZeFzlY/g9ao4CUNCbhPHZHp7F0Gh/IxxdYOxFfk/ASv0lPHUi1DHr0p6cuJ5W+aXvMT7vUz/QKQURyiiXBZFUBHpqu2G5NDiV5qtNAFMToXfRPU1Q0TLPCGpGb3YZJI2p8ip974=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766061; c=relaxed/simple;
	bh=YMmJW09NkIpo+yvAuqlRpwFk5H+VonnRCrHTI5HH0UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccbUovTPmswV24ldptXmBxcr/8QCaKETaYlH9PEiqbkMkg9BtmucFyI57KvY7Yr0YqLFAGFeDtK+OTIUN/UzgN/sHDMUY5Kq0ZqvNllko/BtoNlm5IamcEVb7umA5nwhhtopyvthx6GJi1vFqjR9TvILRkL1CvnEfNmoMF3MUXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AMhCJBoc; arc=fail smtp.client-ip=52.101.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AMhCJBoc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSXDnIr5QzWC3hyqfJ1Z/uKK7UHHrmVW0Z/agx/21kEa/LZ2EG0haxMXwIjBVtX87kljh2kaTl40T+IAkbctM9yn/JxluaFL0G6StTRNRXu9JIL0OD5436wjgLBQFwA+x5rUlpoPHszMlM2Mv3OjaDOQvZ7yS7aa7wrWDhoU5Xde5HXlVnBywv381N7hYUTHBvtBIzaCFvEEze0j9B/YO1L4doTz1A0SVvpQTA9G/SetklrXm48SeHf4MptCMTNcdJu5L96YvaO8QPrID5bkijSLX9xUVsQaV7F7Pbdlw3bTQUC9+mzbPrGrSlIOVE75XNAE0q4P3OihFk8M4PcUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Es1cyIaAeJDYd7qpPeKpul3Z9XqZGvxgKJdvm/D0M0=;
 b=s4dvL2CowyAJI4171YXu8q6xLJraWOJ43wEPj5nCLY8MN1lvAmyXeGzMwk2OJlf2uK3pRfQiglsVXgOnsrUPExH8+rTjj2Ew+26DptcLHoq6MWaMGIOMlR176StjfaOUhlkONvauoruM0Is2Mvpx56wOC+p2BnGAkr0zMr8p/zk9jzpJP3u1fUP3z1Cn66ZngB63cEkW2SPqycanPmsEp6M5iSkiSRNmKJyJaRny2YvNhX9bqZ++LUNqcCkT1oQ46odHR9xwn3pGv8WiG6eNfbKHQK/CbG3uq5+NaId594EriLZV4ezWBIRpAcIKPPOly/4kiJiidQzg5Xp8AguOoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Es1cyIaAeJDYd7qpPeKpul3Z9XqZGvxgKJdvm/D0M0=;
 b=AMhCJBocOHRNQO/QE+eDsRLQShqAfgksikl21Ovl0WxGP0Jya+xJasJjMITrJje91EfQKa2lwudYMMliafKgtnFwDRcbMJfsFcy7oaNW4UbiAnoe5ZiJVPIj462Ed5VKBY5QuNFJ337Nwnm+W1Je4YS+HiOYl7k22qUlpS+yzC388iNX8SmlUrJr10YXgMdFjZmpoQgbwXPLYAyJvrDOxR6LKhabBEpSgRpgZYZEAkgetVaGawrWMegHuq/OENhbnmwsiqDxW0g2PDXabA11AdZ7GK8OZTUoyZCrj/meLO9AnZxHPFJVGa//WFmRs0ykFVQME/U6IQuUwdQOtDKifA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:36 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:35 +0000
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
Subject: [PATCH net-next v21 04/13] virtio: Expose object create and destroy API
Date: Mon,  3 Aug 2026 17:07:12 +0300
Message-ID: <20260803140721.1871678-5-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260803140721.1871678-1-shshitrit@nvidia.com>
References: <20260803140721.1871678-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd83a59-f9df-4346-ac06-08def168918f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lREFH6HRGG5veS4imNJehjMMgMWEDBNMx6ncuT9pvFskFGXoZyj/E/GhLvfvAOaCYBWIwjoglpZkA8JeF99JLDb8DRhQNJ3ntS1VLPm3aXfQtg47ck5lCX136j42K5pzTrinrZsD6uul+GUL0Xrr6r4K0cYzDtorNRpoBvlHPaOX36MhQPsBG1ob1t9XjPXgssb7Y5GqyJttO4QK6zivSF2/4kaE/Q6uQ7IUyT15e0FI/Rv/oSSilj/DLGEOW1lGuTRQfdTCCHjhOKk7fUL+kN7cbAL+Oz5tJSjdxU07c4qv1Jq4ErajcFtHn0eDz6jd9q8ZisVd9mzzoIQFW/g5g4eQOTaNMAeeKZGQKR1C3FzU39x1xVxyAb8cAbXM3LTpfr1n5qLRVJ91OA1tou/kL6btY2BsoA6s5S++18hEC/PewGaPMevqcGHCRPefsW4JV6EGUP6jwh0Uz2Er/Jn8HLKbvlh3MERc9SQUpLpCZqP9EiXIIzMw79cQuKXrZgMiF6eWx8rFlV9I2RW6IUc9hGy9VvLTqKmgH/SW2yVjzh+uc5L7CwdfAbLIyw2B43ZamYTe0i0m/oLdrbJhVw/gx4/z/fk3M6CTyUyYuE3b5lNYdN70aaAMPVAWVbQQYwBd8UrYDLLK3TV0eVAkDC55MQcmDmSVH9vEIoO6B4NBwds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9QtVCpQ/ZFqJmKd40sLchePEJTlWKAWpbPkl9mCVMSzqHmPNyyVGX7ZreZE?=
 =?us-ascii?Q?GbpvWD2LNxe9fL/yWji9Sb5jq/Y+G9VL06rYhjvbB6FI+JtIEmr2JcsYucxN?=
 =?us-ascii?Q?K6yjQNFaie0Sj7j0m4Pyfdu2SPxomcUW54+J/wTtpEaSANaHE7/HPWhTVfvb?=
 =?us-ascii?Q?jy9mEVZICapnua7L6v51sUV7IpOLsIhxYuOG+Sa8Bp9qQ5t4l2esm3wcPbJb?=
 =?us-ascii?Q?SHcd1oDkJ6V1xQMsJDmEgdZWZojdyFeBVdIuJib1r500KUU0wgoARIux4ynb?=
 =?us-ascii?Q?uY++rgeY2NuLITtHc4k8p9IdIpepQh8a+VZwQ8tCsszK4iwWTi8dJ9h06MFN?=
 =?us-ascii?Q?NwqQXuzBm6Mlue8KxVWQbue9i+RWWA8GHV95Rv1W4oulJcgNfWtdTsejQ+8N?=
 =?us-ascii?Q?RRAVjLIOeCQZMLyqrGLll8jOiMf/w05CYDJmQQmd9ghK5psgayeKF4vNqp25?=
 =?us-ascii?Q?VM3FQT17LwMezgj/YgKGiKV2HEB8LXDMM6Tuw8NRt1KmazjP5s6waYhC8mJx?=
 =?us-ascii?Q?rP/Kx40+WxGrp55nONS3mGDN2BPWeI18M6iXgcuZ/NXOtvr85sm2k5Qscf7F?=
 =?us-ascii?Q?ezFv3pSmaoOK7Co778aquj/Z7CpMWSSo0Sbe/dt/LX4R3tYoFZmQ5KtHhESA?=
 =?us-ascii?Q?i9X1rHkCIOQefCqH8L4B089WbXmWaTT4zo7LVOimjjR7Gre5FOfXnRqwStCa?=
 =?us-ascii?Q?OE4YY86Vl5qnzb0+krVG6tsWN9BvSfC8k7UiKiRSk6hg7LROYg6uSUwMCHAd?=
 =?us-ascii?Q?P6Vql0Ave0aOkLxGeVPgIAu9KAbueHmrMq/PDa62JtOt0rPWAe97PDj7rLH6?=
 =?us-ascii?Q?DTQRtpJ+SQGZlyoABXEgIrgfV+67dEvelkr5P1T4q6Ns+FhNbsLBiOuIbAON?=
 =?us-ascii?Q?6rdyV9MxVepYMae5+gJDEKkJbJdk16mmetHCcT0k0Ye1m0cGAwynTf4c2P0s?=
 =?us-ascii?Q?l+Qbo8xsIIGZ3647fTf7B3/IODR/Tpc9cRgY7C7ekrDmMCvcQTedvL2zVNXy?=
 =?us-ascii?Q?dNVv0P14qL5tgromwy2d2e773z+zjaqTM6lvZ7Sm3hzu5xcLPOCllcUSobPG?=
 =?us-ascii?Q?ZTEbnBoU8w9TdRRw09oDp+ubYgNZHP8ajl9RW5JdozNNRI+7hCytK5JhRF85?=
 =?us-ascii?Q?iTv2o8XnrRLMW2TA6l/S473mqPtQD2S5JBMXIWe+wF/V4ytwi5Pw9G5iUxql?=
 =?us-ascii?Q?0FVWT1HeK0yOY016mKXhgl8RIfVeps7mqugt/9p0imlVHoynjGRZdJ0HvboL?=
 =?us-ascii?Q?UUJ/OBzkpVKPROfnQ5++uuD9DfsHs7HaprQvEftm1Lpf4SYH8j6djuqta+MY?=
 =?us-ascii?Q?rqPdR9XluEmFYGy3OlxnI3ZRQpBWUvgESePryKcMSlLQgcXbKTVulvWcGvvR?=
 =?us-ascii?Q?IWF6vTuoZF3FwqOs6IHtGhtffb9h64vvLMa7oTwYhiG/7zZ2dfdngK7Kcjws?=
 =?us-ascii?Q?d+deeUXRqY4utiqy1mq6mFeHGhk/PT5NpaPUs8eHvAY+IsFcazxXIPho6UF1?=
 =?us-ascii?Q?qC/gFWumYUXBc2/0Xhm7f9emOVogY0Y30wpW2APx29bXVmr6jD1kBKw7ZrU7?=
 =?us-ascii?Q?COTit4CdIV5BiiOdlB+ZK69WE+yvq+hVYFB8i0PvdhdghxgE+cabOrjeY1Ta?=
 =?us-ascii?Q?CdknUW1mj1ZGK9IrLMY4KdARYTDCRxqanzOc6JNWM6ucPReuGen9pNCpnCGF?=
 =?us-ascii?Q?RwO1US3H57kLqqpsoHW8RWXTQbLZ+vZIZObTVVrerU9PHiyFrJNG1LcXKLKO?=
 =?us-ascii?Q?CPCOhLOTHQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd83a59-f9df-4346-ac06-08def168918f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:35.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxR6OziZ6i60qte7ctFAYPlJMR7N+7hpuJNy8zQMUpl/9HjnT3JaHpG1qqUSY1HPlMzz9+n8x2qXave9sBZCKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

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
index 0caeb6314a77..81bbe88694f2 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -80,4 +80,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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

