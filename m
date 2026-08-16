Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26683DDDC1
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882900; cv=fail; b=rcYxkMehdMUs4uEy6l+JOZET/xF1tMS7SYZXM8+SQgtLGR1SPTX1fnSSRTie1y4A70Ai5eV5xtpV4P3sdcenNFrr7TcNbo6H9n23oHPf/T4imDJJzP1mhlF9/FvT9Bx1Qbl9SXetd8MByG2siZmWpI/fZbhjUKxCqFcXwPNpbTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882900; c=relaxed/simple;
	bh=9zaONXKCnZSM1bCaohwCb4ogozu/KuOxlvcQmi5bUM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F59syrXC/oDKHH8SQO99WYEnsuOgxuCAR1nvaR33tp0RWCnY8gcjdI2xCtr/C/Q/tRXrCpOovR9naXgu0SAGbbRCTqsfLdedxYFrssxwvSMm3qIgvgGdL+p6FJDahUOHPUvBcUOujtRiGkO0zXkoI8tYQ+Ytqj4AcS+0f9sym3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFxAueU9; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFxAueU9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aonvmDZVg7cgHFYFqg03NqpYzVjfiIdKko0jHISpvxhWWka5z2eYL5fRGemJYwnrmDRqeCAZ6/80oZa9xh5yPKlRUEJlFKVe7t1j3O3PfMFvcUMkmTpqj6DSgRZI1E/ynS00CtX1atQh/i5O2ksZWiPTgnvxc1JjGEWOImVGNBihzf5avlk7RpuTaOn34VxFRgj1cr2wWoMEySpZJ8CIMjayrHmGvew6A9fpDWLad0wDZjFULauiNWnYF6wzdkNjb3O+hxCj2oy1psGlaGadC/Op+CGRieBXGwF5draFZ6YvFFoLUuSLs4IZzUXuWk2eG5zhrEuHLochXtJMaR7Ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOb8KDaIYtWn+xngWBIZbu39FbL/f3S57QX/4MO62sI=;
 b=SmGFlvIpgyj8BtyP01fxWYtNwRCNesPtKmf5BrBYySqbXEY0me7HRA7S6aE0M8QiX8rt8cP9JOWkZSqazXPOEM665g13u3CtxwxZAAoHn6rM2SSgxygAmP8VH19aBxlCeerOfmLHMfQ/85gggNSyi4cwMTsQdTqRUciL5kIbUmhEfGbrgDMcBYHYT6MG9TxXghoBx6rAeVrYKXgTMKx7IJxLpI84mMPlcmaXvSJCJBVJFEsLoca31BwRIjTe6Y/HX/i3RLWnaXSk5g5TIO65Q+Ka7GDBMtU/Wo7X+v05AabxuT266wL+Fd1FZvdAIhvgpB2VkWg1JIbKkJM7O6LgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOb8KDaIYtWn+xngWBIZbu39FbL/f3S57QX/4MO62sI=;
 b=UFxAueU9vlbSoNb/yTOxuNCggqcOGLJfrz+cXoi4E4q198RUFwrK2STvQ+20X2vUG6/OmumzuX0gJ17/3YWWhGrEvNNFD11g1hGbVb/SIOglqbj8/TfbtlpPTWRZLIBUncN00OKpgenONYu1YiqTqQCFsx0RRyAQfDrJ8QKDcu8RIAr1Xc6c5xka5vdpAslvX+9guv3zx8YyXZD+XGklRhLvMi/YBBR9Qx6dA45RK2GuTYahlJk07znQAzgCxh+QTRkREuuC/50tMn/l+q22T2B8ohbw8Ngy0A04WbJBiSK6XdQvh7pWRtHFKyO9hwCOk48mNE3gumKaoxKD83ejig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:36 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:34 +0000
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
Subject: [PATCH net-next v22 03/14] virtio: Add config_op for admin commands
Date: Sun, 16 Aug 2026 15:21:00 +0300
Message-ID: <20260816122111.2495240-4-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 251b17f2-af82-49f7-0a59-08defb90e99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|3023799007|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fwYIhhpDrOnLIE/mv7Wr3pBVxPWwgG+L4PTulda6Gy8e+5DsDyUQAnxJqRdLjVhvcoPqPmjXdIf8hPOlAUGJdB+h6FRxJwz/5H3AyzfxHzak+UJbLaSJmsypitGJrlkB3bdjDkX3ioRqK9sPkoDDiJLLHjv4hP6KmryDtoTRsFasayvn63Xkq7BJFtUdGJSJoymVpVLL+20f/u/NBu+eOfMN5v5XDJm6vZ7BB/sU+ilBOSQJmIRbeIPtENIHX35pc0Bfh85at9yODlsfAxqB0G3xr6zqq4nJbs+e9Yoh1grQG/TI/RBIbGkbtztYifymaxzIvbnlCzeyRUcnPuFnnDYlMAH7cv91d/W6aDmACGNlLCTT2THkCLzdNms8LHkDZv0u7hnX9Ry/QcX5psQ/XNpnF+DxUSjzZ2tg85dxoPKffdAZDUc2PLImZFru4H2glXqn5/sze5Gvf7/yTHoOcU8nOT8E/vPm5UndvsjSLcZ+EBcRHXAkDXNI7m+btWRcgNFF66Ms6/uzKPW97VnPneTLUSR2eexQpgXmdtl7gNsWf2abupvd5rw7Vu/vk1s3QAQtSesK9hklgecK2aUScLP/ck5+V82lLk+wCotiP99xdyC3CeAAQ2gj5tEwIkU6OR97r3rJaq+7UDmaUttGX1twWO1ZrMkFqfh+rTRHTxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ll1inO9QZCFuudquPm+S8FcdX4HvVFXFGqrR4zoT3eg/soxfgKsBoO4cgyQ3?=
 =?us-ascii?Q?COOV/DYf6Zo3ATuV1DRTNQkii9+xtWl/Mq/vQgpzvvkFSw5zZUpysYvbyVhe?=
 =?us-ascii?Q?XO+GV0QNrpvSWz1OtXd+jLEZeqBWSAlsbqfSMpR5eVhBUlvLGUcZOZhY/yzc?=
 =?us-ascii?Q?YK0cC3ZYBLuDFIDX9C8WwADE0ZJJBPPpsY4DEx1gdC6fCugA5CfBK9SGhfox?=
 =?us-ascii?Q?m5M1qPVITUNom2/JxDYnfJWKhnN9+5Z456qdtWkyKSUxkaItmUZJAO1F+TO2?=
 =?us-ascii?Q?DdkEbuR4KO9hgTCvqC1RwLjJbRIX+px0hV58C+NoGr+LRhS8aaWjQkYCKCi6?=
 =?us-ascii?Q?7NiA3wEo6MZ5qlEtcL3ckKv9e0tvqSqSndlieKFJhys6OshnvuXikOpi16Sh?=
 =?us-ascii?Q?BMrOt+sRUuFZU9Y2SbO3f0drz+nT9QjTmrLCiecRCgubdf/PSZXunUhQhXRe?=
 =?us-ascii?Q?rXSqjsruDUBMsimwkc2+7raJa7yZZw32YE2yV01JmEnt756cMFY7pinlIX0o?=
 =?us-ascii?Q?WJlIA1lZg9mjrQ9sks1W/R0yQuguhoKrT2lPlh7xGHFQUpDZooH/12ny8l3N?=
 =?us-ascii?Q?fZq5rzdTrK1t1BAB5kA0qEAfzY4bKxaVUoDdP1Gt1B/mYEwQi6TfKUSQ3R/1?=
 =?us-ascii?Q?WwuWwb9QUyWES7OCs2vCRDSNnb6fQLRHAYdqiLnUoforqYtVA+CORtXuY8Ed?=
 =?us-ascii?Q?m/Axi9NF6CeHG85swPJZdIITI4xDDGXn74OdqWkKoBg9vQDM7DtLUNBjOcX2?=
 =?us-ascii?Q?dKWSYP7vAyzoptcPoFTvZgXOz9QOJ6D1J2/t3VhckKot8L/d7Dj4b6f0XqpO?=
 =?us-ascii?Q?N8+6/SVf5eYTjJVqK+roV0FbMpoy8JA5wp4/d3/nVIA6CLSicw3JpM7h250f?=
 =?us-ascii?Q?iZYsAwtPxqfMxRvVUbE+xbyIPNDgys33EVKolYp/6V69TMT2hzYxKodOsG20?=
 =?us-ascii?Q?8472zC6xhn4YAaofVyVpnY6Tf6jhbjM7Uc6I0PCo6ZY0jo8PliIfXhX0mr6J?=
 =?us-ascii?Q?C+/mlJ4t3M3Z4dgQGqzqhno2Bq/36K8HrYbLpHJlMGYVxLEhvPyXCB0pQl3f?=
 =?us-ascii?Q?dcrLrKM85LJQxOAvNJWGA6/6pVkyXQ8HoZUuI5vV0Lrt1vSssmYbrsxao/fe?=
 =?us-ascii?Q?cF1SOvPvkZkdgPP/A2mSbPlclG4200ibhrtNn89YrNhj+rL3yjGajArZZbot?=
 =?us-ascii?Q?Q9m+gbldd7OBVy/nVV8ULtwNtWR3C7bmFjAZ9QwN7+kCJusdsDkIPAq04MZy?=
 =?us-ascii?Q?W8Srn742OWdIsTDNlp+14Pvu5b6hBUXmWFXhDZW3B0sN08AFf6/6zKzwPsFV?=
 =?us-ascii?Q?TORUxGmUGZyla70D1DWcDuL2JzpHTuIXzXqTDwrdLPST5S10Ye2WYoqOavpp?=
 =?us-ascii?Q?VCTYOtnobLyCdwnHCnsRrpLjXBczsaL0eeVe+trKnMIclQ/Fi9JMvhZgnm5q?=
 =?us-ascii?Q?amr4Sa7zOfv8Huv2/szCyTN8XGnv0BzHh648yCCK8HwQTkGVmlTUjzMjdQFf?=
 =?us-ascii?Q?uZ2bnzp2mMjZyKMrJMz0uSXRX+lreMyL139mHpv7PtP06b7EUuc/Y1apnWYg?=
 =?us-ascii?Q?VzvL3PQwEKmiZsolFict5SzV4OjmcLRne3Re1vZdAQp8DsTEj6b6JYuvR4iu?=
 =?us-ascii?Q?aIYMAARClplPDPt0bU4SGSUYCBUbObzFS/j7JgLjZi5QlN6ua2yMxxIkPDZI?=
 =?us-ascii?Q?oJ1wP8Y8SbYQKX8ja11bQVsfGF8BZiFPrQgB0uFXA145dFAV+PtQmbB8Cb49?=
 =?us-ascii?Q?hmWQGcGjjA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251b17f2-af82-49f7-0a59-08defb90e99c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:34.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbaAMDH+jSXF+CNVi4GSaooPNA0hdPz22zLmYGdBTVNyyo9sOyd1tHc+R3Dpo0HZzUSK8WxOcMFQR/UivdkuUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index dab63b044a31..3b2515e29728 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1248,6 +1248,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1268,6 +1269,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 /* the PCI probing function */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..e36a32e0a20c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command (optional).
+ *	vdev: the virtio_device
+ *	cmd: the command to execute
+ *	Returns 0 on success or error status
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -137,6 +141,8 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	int (*admin_cmd_exec)(struct virtio_device *vdev,
+			      struct virtio_admin_cmd *cmd);
 };
 
 /**
-- 
2.49.0

