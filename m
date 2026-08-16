Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E629A3E0C77
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882907; cv=fail; b=At/eN2ctD+6Txzq/DQNZS2mBdiot9kH1XM2XbJVFLmAssd47LsURzZdHCK+stiCA0EFdhEfx+qorlKJVLC54i/Q4JaYzmzYWKqjA+BnCtFL8K3L4TacQ9FDEJWDbFqy1tMJhvUQdlqBJu1uzgQ7cezHGTDTusFym1ks68Zqp0/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882907; c=relaxed/simple;
	bh=rpB8c9gwSJk6a3PAi8UGrZCe60a+D8C7kBeIRXdTowA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kZLY9wmqCF9YG3ajhb831wekxefq0EM2FAkhOnVnzohZYYAggBa0P8rvQqXHuTFGYv8e+zpl4XdKUhiboPI1ySH24NSQIe3oegOpE3cviWOYZZfp0yDjKufvstSC/5pIG/mw4QfySzSBSQXsRS8cHf1jKd6NcXcC5i2tBKiR0VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSgmRI2I; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSgmRI2I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skBhcGpcq+Zj6GbKF/ZgGSTYp3IUouU6YYXnRMkWnWrGGbs8HYvtsqmL0Nb53BMxfET4sFk9gdJLmpEG0mFM7gO61PMifm/kjolVV7h7jjLIH3Cw4BZx7rDYhyKg2UuoB4EG5tkMOTO9ZBXnGKp7p8Zow3EaiTuvyyz3D0aqH7/APe36/XSrxd7IzSUkU8AwtexSEXReQRPeXY1aQZy47eU7jc1xa8Q+gN/OOZTTiysJqqV4uuM5fGH162UVKdY8wP7G4mCGwsaQUlcv1KsIxYwTAnpM4Zcfj6SYyU1v5+8Zd7uLhdSDcSaXZrQAtFCjLdj4+oWideDPGzyLUlLT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbkd0YTLMW4hwv+sL8Vrlkv9NQa34wh9hKGGAZJye8Q=;
 b=r39eX0PXQvupJbTZl5mgtaOCiKCNGeB5JulfnY1EMUw6oPxuemnwRYyVWWgLajzdvsApupwTdx1TjMHHFtbhksByxWhBKgSxul7mTyBMbSieBfCHc7cMD1dDqjO0cjJ81b+NNgY38mq3OECjNDInDpzZRGuU4dl45WNkwtUuVwZCAPNNzypb2bUC0yc5RNavlJdeQG/c+eprKY2SpjyPGhgKh9xYmUz8zbhsly47mbnSD/4wSD+cP/5a8cCU3W7ZUyVBkCkOOmD/o9Db1PngSWgp+iWnq2EmTqOePwQwK3oPoahfr70omtryxhvPGa9yEib1ZaQ/jtWgI7Ysd6FxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbkd0YTLMW4hwv+sL8Vrlkv9NQa34wh9hKGGAZJye8Q=;
 b=DSgmRI2ILPyYHUzPApM2owOxCV7sHA+KvsB+6eWoyxpJ0kQI0pMiB3mxlAkh8geRAR77QVv9v/lNxzOMyZK6ignKGFjo/B4ZInVJEy9TGSootk+WJmicm6DS7qni8f9a5Uun5tVeUAFOqFiMDwWLM4YnMoGn+yn46k3RdGS4Pv8UUujLdgcDhlOjblMleJZgiCxcNj9XBBeTAQbH3g1iFZ7WGoL7dWOZcs7T+hmLx+5cmlIKUqPoHTm9EK8MF01n1wCV/LIQ6k7+r9SL91p0NiO9TgjUnm2XR9MosHUCklMIKXQ0MeU4rq3vt1C0YutfHbxAlrk4RuzN5Q0rPhB1AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:41 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:41 +0000
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
	danielj@nvidia.com,
	gal@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH net-next v22 05/14] virtio: Expose object create and destroy API
Date: Sun, 16 Aug 2026 15:21:02 +0300
Message-ID: <20260816122111.2495240-6-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260816122111.2495240-1-shshitrit@nvidia.com>
References: <20260816122111.2495240-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6001ac43-8b7d-43f0-6322-08defb90ed96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|3023799007|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FKsRGXJBZt6y1CYIUlpFhMYmmaWk2DcTNXNDBuSiPr3Bb5tabUEwXp12AosdqUb/uyM8FZG+ZZT1pnHaz+1EKAPLd4taZWLm5qWc2UFHXJkNvNubLryf3drnXGjxvp1cVhZ7O4GrtObVFX2qsmyrAFL8pDcSNZk8xayIdKLf02lOrZxQRXJApXREPrDSHP22C9wwtrFKweIPmg9Q8hTPrmr69lHv5Knfd1TgMkAB3+jnSq987vb7vFmfG7MLTv/a6NPc3IudvVffA5SoYUocThzX7uNELrbznfv6uu/Dr76bDuIwE5yud1NdS7AObTZIwQwErunZzvOa45qF6VaH81932mQxxYqNFfxfaeQOosmLI+QM33kGHKrqN0hHyGK2TwEe8sORkFLB7pBbmzptX/2JL0js6DBifc4L0WLjIiwXOkMyZohJNK4UwRO+7+zL8GId6/yoS246aYsAdm+3EC+6JWzbctkwE2bXpfHDLhBjrmlL4MOfjCVUiv45U1DW+p723OviC13D24mPGrRylGuqDuT7sfjhlDSc3qZXHQh5fjbl7dZO6uwbRI+THwnzioD4NZSnm6XzPG+d4IEPbTzUjNO8e0XKdPg34HGV1a91yxJjEbv45HJv77Y3whLdmo0cMSF5SNVySffinVAZB7NHawdN/oT7MixfeyTC9TM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6lUOGtPV3jYDtvl1SdGQC3ofXD9J4MwgNv3K3/VxWFWw8d+fbcbVkPRDCw0Q?=
 =?us-ascii?Q?R18VJaXWQz6JWY3hIIsl5xrKSrEHNT/2fYSjtSna6FLV1oP0afVPV6xvXjGz?=
 =?us-ascii?Q?Dvc6OS5sPTMgVZXo/UWMuFf8cyE5O8f3jgvjN98WfOoxZPxn8L9UX/ePbKrL?=
 =?us-ascii?Q?kUSx3g3P2FfHmmFZAHHCBtqyFy2F89oOMlO51IgIzUu9cG1Y/o+u3WHZso8C?=
 =?us-ascii?Q?iSmgSr600WFwXhXVjuUEHST7XavVsq0WAQAHZi10UHQ2Vww6AZG/aQxac9BJ?=
 =?us-ascii?Q?x8Wa7g5MDlNJSWEj1IVS6raLIrZWi9Em9iTBJ1XNtQ8YYLgjFroygvsqdIA7?=
 =?us-ascii?Q?E9KDFH981oH04seNw02DRjkfuJZA6cYdcOX+9yc2d9DzIJpvCoZLpz0kKErp?=
 =?us-ascii?Q?ktT/9U1CmRy4yWXvJ71z75p+unwbz6CZYjaXC5ziHuKyO1jv80xGpNSXF0Z/?=
 =?us-ascii?Q?VgQPY1GpEbYg7NEN6t2qeisE3+h3Obhe+PolNqsCHmGf4YoFTY+iNlMsLoei?=
 =?us-ascii?Q?loUmDE4nBSRBhKrnaL+tJnq6ryU+58uhc5mUcQmLmiyuKA3MuduRPAF1S+XV?=
 =?us-ascii?Q?k6Ot66fS2ICwxPAq0eZSRdoBywl+ugj4/3rRBwBmfzbDYfw/qNSt9cLFquqC?=
 =?us-ascii?Q?Bjp3kTqmf5WiWAwf3Qh/TlYoNzxNjucrV+x1Va1cKaY/mHHfQkBnhvF5HlxD?=
 =?us-ascii?Q?PsT380vh1Pq1yhkePhy6ik557kwQbpFhoW5uqKahhuMmN55LKmeB5h7V4aKA?=
 =?us-ascii?Q?JFy37OQ5MMFXONIh6Gu9KEO3kRB8UFx1p6GCd6jLGaand+x648zHiCC0LIJ1?=
 =?us-ascii?Q?OZZr6u/nuYBm6hYFEI98REttBSb7bRXyRyGBx92Kn/mmdDlh66ed7yVtMT0e?=
 =?us-ascii?Q?xSk8jiWm5ZuzI1HV3t0zzUZsrr4zu0o7OA9ndjZbQMnjsQxz2SRUW6dK5Tua?=
 =?us-ascii?Q?CkcN5b9QUn2CFmMZ7PDMOj8NCOusZUGqIasnIwNDCCeNkd2hMA4NNJ7cqj8I?=
 =?us-ascii?Q?H/nBO54nw4sgk0kbDBhR/Ph0T/2Qoa0DFC2PrywuykSIgzxfeQr6MxCkWkto?=
 =?us-ascii?Q?5JOj350bwx8vQmTJpAgz+mCLUq8da3B4pnxS4x6MAziaVpdpV7i4LFsBFTzD?=
 =?us-ascii?Q?iyIEkBfJWf3OhSqX2Db4ckKIUEFwidDzMy0AFdRlRnjKiJ6CeeI/vYlSdHAm?=
 =?us-ascii?Q?Uk+fvdc4N6KMeQldVfY7N9QpagIfuOGdPiYGQvrEf26FB5lLKNqLBxen0Cji?=
 =?us-ascii?Q?EaS12yIFkW6DeTpeH2X0i8DhN+m9C/anRnnGs6W+AunNiBNPw29x6/X6D3Bo?=
 =?us-ascii?Q?Tw6rPXayGbMuEEHgZeKL+5sI8l80OV2kwu7ywLf5W0Ukgv0oaaXpw/e2sBzb?=
 =?us-ascii?Q?kpokS15MTg/fEBi2sZaDvpzy5NVPvWIpDALkvGz0+FcpI6k6dsjuXxMpn3Lh?=
 =?us-ascii?Q?feahZMQ9D/3p+eGKiA3dw+937hGGHo08dZPL0Sszl1pnYBcu1XsNZ8XoKEWo?=
 =?us-ascii?Q?vVGcGc7nDcFj6x4IxXsgqz1hSFAxu2VnBI37+AoY/mUUNxgbxSd2oUF7EnUX?=
 =?us-ascii?Q?86MCnbbCrBVkaLodfr9dQdBSIBEAxJ9GbFPAdas1bquOLfSCvaaQtF+Ydif0?=
 =?us-ascii?Q?XEPeH+EHk3F7wU0t8M830spMK1Kz5aq7J1IM3npEqFXVE/ar9jEF7YUsSMOB?=
 =?us-ascii?Q?V35nkqQHy7Vqy49jBfcFZbvewWuoeQ2oBAHwkSmpmJcNQIVWJ1iqEk9Uni6S?=
 =?us-ascii?Q?awB6g1w1Vg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6001ac43-8b7d-43f0-6322-08defb90ed96
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:41.4454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kv7S7WTwWLsS5kLbtUbCR1/rHhdWWdVwqfsQ7y3fYDNEtIVOWD0dBZQ12U/ZyhMF1mrWX2eskzLbxU02LL9vxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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

