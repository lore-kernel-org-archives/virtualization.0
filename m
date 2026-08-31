Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3447DD4A
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192687; cv=fail; b=ALWg6B8DfrNQ166u85UHjsdrJkKsvGoWDhUAyJTy1PxJd9ircZ4TI9lOWdKjYaAV1IgCZF9t2wqZO9d6GJxA29tqrIQyIfj+rpRjfatjlqgpyGIm8ZSEPDCyliGxPzrlf3o/bTdiWhkezonxpRTgMDc7X9EFpw+wBXbma2LGrAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192687; c=relaxed/simple;
	bh=1ag/y+XRr68RqmiahlOQDw67gCwKkP67YShEAtpIea8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddsezdj5TMm8YAvpFeBTqlcepPqcgzi2L9jYUqBoxXXorDmDcKJZSNEBDK2HAeqr9XpnRE9rgfzbjdqrzOAZ3vhYE/jaOKePeoYkjzm5H6sXz+zQVtk0LlMTUytaziNUXp1DVw5amNTuz5SgOZlsqW2pCxeor6PqMTU+yXSaToY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X51PsThs; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X51PsThs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCZgrL1owu7PV4gDzVnljqxL5vyNMsAs38EGatke9soBOP3gQe3o7xo66SBDFhPULfrrcZEW7cZ/hvpW7cSWGdffu25vhYGPx6mJNW/np/cQcpvcl9x5A6lyhjIk+YeG9NhiGPu8IvkXL7P2e8xcmzKOPeUHHqVy5KLB07GYexiUy9G6nmAVgmwvMQtUEgbiDNM/tf1OYNL25A3WxmRNkAzq2tvtclylC/1UuYsnYeLZ2dS6SBA6TQWdiSIcAibHoZlxXxhQRUKVf0md78aoFDLRNUi5B8p7rFVpVk7HwPr3STd2eWv9LRebqHJRpDkNNJV18Dv3URrnmJufBZ/brg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AZhjunn/vWyF5d/Yn4WOl4CqKC5QqZCGQg8SFuwfuQ=;
 b=WrjxDTVvtP6tFP39fHpRp4aMo2j/NwYv6058ZUPIaJY9SFEDLk2GXJsWkcWMaKsZbYdTctL+xs2xMpr4++i1rhKFFGMJ87CIqMyHMECX1o7WFc2pMNs0FiWaxSKM8PdpLGP+3lPG5v2f+ENQ8rH9ggvFUMFCemLWrjuYsWyInjl5WTZi7al3wB5xwNbX5LeHhNQQCH5a+W8GmMM3qxqOZ7ZvCniDjI3+dfxCjcxNPOvGmAAK/vjnddSiGmQFzadNW/7j0K5fN+Q1VtYOGDV7uJe5y7XmDGfysJLY2R+B0YOSu8RM6DQ+1pvW9yM75gcKD1Puj5/jC+K8gPLgWlXkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AZhjunn/vWyF5d/Yn4WOl4CqKC5QqZCGQg8SFuwfuQ=;
 b=X51PsThsCv65cghfVVyDENwcq5TlA9AC67+ScIfBoUe46mQFrJMS4SJFlbhpz9mLwNDTXgi69RmSv//syIBDZHmz8Urku7INpzrBKoqP/+8bstk4uuFdq9eyfqrNaYZKOxpYup7kl8PmLePIXqGr3xyGvCUYJX6FH1vlmxpCS8Dhwpt3wwuRuxnUK6YRM2APfrLG7EUiA6ZBeHgq2XFzUyS6O+zWwiG+/0fJPOhMk443bxjvfOsF+Z6d+6ggSgLMWMK9ksxMXyLbe6d6G4GjpQelTtRVxXImDslGuU0zMSFSjXnB7tAfzmazA4UnrILm+1H+nkre9vaesEBeRMRI5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:18 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:18 +0000
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
Subject: [PATCH net-next v23 05/14] virtio: Expose object create and destroy API
Date: Mon, 31 Aug 2026 19:11:00 +0300
Message-ID: <20260831161109.2999926-6-shshitrit@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831161109.2999926-1-shshitrit@nvidia.com>
References: <20260831161109.2999926-1-shshitrit@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7ab0a1-59ae-48c5-72c9-08df077a7d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|3023799007|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Fk1swx/wZpQFF093qru9B8eYRAKi8+D7gPS3Yw/wCt2m/Da1y9ZTNE+rz9so3HBcnNY+qS4X5Ouo6UjSGvcfj2a2yBeNw/63NHyhNVhNdtlFNXGVTKP+d7ZDF4/uRWYTYjzOOnrseG00Rtcv5LrLOttrFQARgL5qdZFgkGiNOElv3QatpDwuOPcDl3jm6X5DU0EhUE8BA/BCUBlFlQw7IslssCSY3aXHGewxv6EsExEeHX7y9mLnQ5cmJLPXgtOo9onOsWvUsZYQBI9FYftGUpT+nIZMURc5xIhGJk0Tt+/5iexdVtj7kOI+7e4yOgJfbetIoVNaGs8VU6b0BShB8iVyiW6echHbeozgKU9hnLy1W/24kqWSIPC/yK2TKyeeGftk4TECqm7sMAp64VaLPpwvar4bz9aV9iu4wtCugPAT81jZz2R0OULAGXiDKOl2WiR6PjC3T1xAF/s8Nyfoc7ZmqFU/VcMa6gULd+tD8Y6c/vxzSnyIkwpJ9WYxqJr03qnN/1VC9qJuzhrkS88KvmtTz1iTvAmdPKvQnwLHdTCDXsuIrzCbr9RTOSwA69NkWkdZxaTG6l0EJdHaE6CK9IhJujewJofqbsRa68XRuKv7XB51U5ByqwVcBcbhtRWAzRRDt51c5iHUR4iLp9bN3BH9L33YpL/BRWQ0P2qCjtc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(3023799007)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kpz9n4S1nyhzGmRhcWTbadAHumapa527EVjN80W6B1jDOScMhERjH+K9x4vh?=
 =?us-ascii?Q?ksfK6ZLJzT+3C67w1cMBHjD18h/o0uDnL/alqilOonb02s0rdGwXPFZ4GujU?=
 =?us-ascii?Q?tHftqIobkLSaHkoRQCQz2CfeaRowwr8vrE/hy7EbD5uMd3r9avxbQDXSVZFL?=
 =?us-ascii?Q?mtxlK4q5p3fdVpS6jBUeZxPkTdbgf2fZaGqBw9w7uqrnJKMTfIjHfNCba544?=
 =?us-ascii?Q?Vr7Dh75+44uZd8m7qXsKS1/pSY4WH79lSmRbIP/sNyfQOlHtidM1ItbJ0Gze?=
 =?us-ascii?Q?zke2Ip+0UmZEegTF1qwD8acNn5dS4kZKlYWhvrrZ1YRJDAChTrAC34Q2uh32?=
 =?us-ascii?Q?HkJ6h6NdovQivbpmQ/2aEh7g5ayqM4HMhh0p8FB1IAsC3NbCHJSff3lTy3+W?=
 =?us-ascii?Q?/JVErIgcR9+mlceQNblg6pb+BE1jGIEpwaiajggK+9ERpaUWKSwAHRjq8IAg?=
 =?us-ascii?Q?I0i/trXVReIV+brosaqrz0Ee0PVW/eIbeH0KUPPHMHbwk8lOmqgD8Kl2Y0gp?=
 =?us-ascii?Q?e2K2+5UNBVCccvAYATJvKPUkudK6MdgDLj98larF7vxUxo4axsuPVIMYB1k0?=
 =?us-ascii?Q?MQT9z1ZjLXvQ7djMbZQStftIy6JAD/GHbbYVhaaaftl042jmnxKPOHeA9PXD?=
 =?us-ascii?Q?LZrYlfQqeUEtVZp3NfoiVokXzRI+3KT75liGn/USJE3u062gaF2+WiolWE6O?=
 =?us-ascii?Q?NiqZWl9qpzyKdkWpK4Y3G4yz0ag8dl2YRVOoz0VXuH4TybTJBjYZ341oFkB3?=
 =?us-ascii?Q?fc8N2LBBidsPO9t25axRakANxe5DSevI98aY6Wq0KR2NQ2rp/jf+Ah5X2loZ?=
 =?us-ascii?Q?hAHju7ABJXpYt5FnlvLUzGuaBbtcSsAtHrO5gWAW6sTy3e0QJsdp07WL9mD/?=
 =?us-ascii?Q?Q3fO8c0+ei5Vll7E5rna/9cG0C6YClPu7S6ndLgtgycpY5SGUiOTOd9jlPO4?=
 =?us-ascii?Q?eWWDPt1d7jvMOThYL25bcZx1oHHP1sGJc3RO80AD48Tei7yZITe5eHKQa60L?=
 =?us-ascii?Q?i/SvwmfGYdy/sxaP0kpCNyX96oRrJt5uZ6fTOkTYXJu22hN1mM+xlWDEOxdb?=
 =?us-ascii?Q?xKmFuTeFzSRTAgJYeUVIbQhEsoBBhyzOLKGHYn361sXOkV1js4IvQQwN5825?=
 =?us-ascii?Q?6qUi6V3f7VYkxYxPC6v/32IgBJMSitHyR59cPBTxrAnEaph3YGcb3+1JxXXk?=
 =?us-ascii?Q?HjYM6i/Yy4szTH2duTHD85plSIS/L9LsduGtSYpbbRXv0MMVt2YY1XKV/7gL?=
 =?us-ascii?Q?K0/cIyOJIhCuMofw8RaLomZg0qh7Df/q0A0Ik1yFKLYgtlb6kcCmirRkb+5R?=
 =?us-ascii?Q?rdP8T7AGQMjXZFQSj4CRcFbVoJieul5KI0pdcaYJNqxq1Vfox4GtIl8Peh4k?=
 =?us-ascii?Q?vXWqAe0b3cq1SRZWdT8mE8YGHl+9hD+gnKqZCfdi5CKte7j33k/m84/eYxmQ?=
 =?us-ascii?Q?QVnseYM45E5YfugOjx8gWBqvMgIDWhtGU6cY5ezfpLjETSv6hcGF1grkAh3z?=
 =?us-ascii?Q?VCDEe2Zqd/dkQSc+1ERBCtw8OKl7kvp2rs+DA8luIV6u4wkHKgPXusTJE6/b?=
 =?us-ascii?Q?reTUktnc+lxS3AzS8MBZ4cS5LEneiseiqyK/8kDJ7mj1bZR1GhXtHmjQcjA6?=
 =?us-ascii?Q?1E3LdBxTPlMnYZFAq1Fg1EGINDmJ+kz7Q/v2rQ9yeFTsK05HWlVcnmYPvWYS?=
 =?us-ascii?Q?50HSXwRxrcNh2ok083HWKlw9B4khDJD7EBmhqyHTb9vo72oaoBHyQivGpKPa?=
 =?us-ascii?Q?nJsUrvWKgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7ab0a1-59ae-48c5-72c9-08df077a7d8d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:18.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxlByvoDdFyHQBmBjqR5fNkfhElIxQbEfjYKhlDGubjLqVaM/9Zi2wPVZo0AHnlgRf9YFHN4y3pTTK/QP4W13A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

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
 include/linux/virtio_admin.h           | 44 +++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index 60d92875da23..24b06075d944 100644
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
+int virtio_admin_obj_destroy(struct virtio_device *vdev,
+			     u16 obj_type,
+			     u32 obj_id,
+			     u16 group_type,
+			     u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	data = kzalloc_obj(*data);
+	if (!data)
+		return -ENOMEM;
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
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 1177c4a20e53..ebd4106835d6 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -86,4 +86,48 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations, or a negative error code on other failures.
+ */
+int virtio_admin_obj_destroy(struct virtio_device *vdev,
+			     u16 obj_type,
+			     u32 obj_id,
+			     u16 group_type,
+			     u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.49.0

