Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012004.outbound.protection.outlook.com [40.107.200.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62B47D922
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192681; cv=fail; b=HQ50V5c+N5hSR6mZeeFpLNspyby8P1/JRxfBceLFjWUtNdybSE0FwNHMPsAMyxi4FShy7OjpYbpbIWZDEq+xW6nl+s8l8q18FIryaVQLAdxW2ZjzuD/DYna8pyr7+2Xt+x5H05rZmV1B3a6KHNV1QJOHUn3BeJ044Yq9YR4rX4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192681; c=relaxed/simple;
	bh=DKLfNMta4kKWGUu6rXPFWWPHFHOgovt1vy9D2xDl2Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ePlySpCLczl3aJ9tzFgIWV6tb6C3Ut5jYTYyuxNsAb3ZwIQUA9U+3A8BpKz+oaFfOQk0DrGkbh7i8Io7/3ouwF2jH9e0oZGNd1MRWZzjOTbN5SHmfRL49qGe6R53+fHoeMMysKLTh+apraXQABKw03usndsaIA/eHMpyPVOQ80g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nJ1z3wUs; arc=fail smtp.client-ip=40.107.200.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nJ1z3wUs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFDR7fIoJpDfzxdwNMZd0J4ZZ8OWVk9V94hK5Vs5V/NS+D1zvZe2xvwXdJsX2k9AiFd+O3apDATseQm0PwrGci9sjdesWNgeLeAXvcnn+wTthtFS/9eFlJH59x7kaD30iZlzKYoXkSbbM9CDK+81WlccGZwJO1thjlCEphrP3+CxH4Szm5xNsTUgBbQyoPI856YvZBTw+1PpwLuKVH6ZkCuJD/NeviDuJCzz0Je6yu0Hu4ooNBiyzq05ltdlQxiRPDybbF9ztX3HqmLPQ4qYSsip+sfaUofFszHK9vXny/SkAYz/vb0PUAcrGTS8nU8XSTx1MnKDYnZqN40atXJIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDW/VcJGQtjAokYVf7Jn2IQdZfFUp1kvbQHE8N4tMkA=;
 b=GhxHYyfD2944k8/n6ccQpjgoCo4DQKP97Y5DW7RTarOCl8/g7lePI5WuIEdaxI8OHyrHS0Q5DPjLnQn+fWsUUM5fQEy4RWr32FBDzluUkl9HjH8R8s1069KAYfIIDZF4F5RqqMaaxRWC8KCLF7oT1jE+eIjs+Zam/0SYbsCCX6HBgWxnBpWfFCI/KtoE9zNZWOvDcP1g/787y3RSKAb9VfR/68NDnjsNiN1hyRa3pxlbZgbTxL0HI8K9HFrvodpzeaCqUzGQlTNEgyFIQCJTjZflfv4bqmiUK0l2NfIXn3tNhwtCmDprNhQhtd1UR/RjUsIj2ESdfLuLEHfzTW8LdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDW/VcJGQtjAokYVf7Jn2IQdZfFUp1kvbQHE8N4tMkA=;
 b=nJ1z3wUsk1ro17GHSZ89mP1EXbLZF1DRNkgQVHaObJfiePhy0VD7rox9fbzkFCkVx5JKp/KMOJuerj3JJBnFi0zzi4bFxQGRqTCsUA9O749B2jYS4meSXtaS9V8bR7PkaUOWH2lZicUXFIXfijapK+OMcwAc6QDrJWwvSZP75f0U5pBF73LPQLJK/zPf8Iqm3gt4MBja1DZYQxXs1KBfaaH/z+o2d/wc8iMawMmk7ZFGqNXwK2kJYggPHTXLF3XFqF4VsuJxNHKf49Jr6b+F+Hymc9PTA6raQSuIFDqoowfNXaHIW23b0LYZw7NkhjafBgBovujTID2dzbvgVt6ZJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:14 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:13 +0000
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
Subject: [PATCH net-next v23 03/14] virtio: Add config_op for admin commands
Date: Mon, 31 Aug 2026 19:10:58 +0300
Message-ID: <20260831161109.2999926-4-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52bf513e-9c8a-467e-9e09-08df077a7a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|3023799007|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uZ0vhVB8JTz+tx+K3Kfrqey/VL9kljSTLXDLzfcbpbmgtUU/kp6jGgLvSAuhPPUZBtGrfXIN6lM3hNxA67sGhzA8sVpoXX3QH1G9hxMP3xrpKiGmXsPUeb4mRoivoajfOvRMCuDZIQifeH/WaMIzPigm8D+7jBBAztdkro5b4n4AaXdbYjZmj03PHuaq+LuWVQJl1QjVYRU+awWv+u6UHzPPgsKuhzjfZuNZuxmGyr8qEYDkjrS55kXEDuUBUfhKyVkhY/IRiM//FvMFyGnX6okXxi158Zc0deCd1CB0Fn9BhdL54Cl+S6/OmquBJqbWMSR1/Ugl7KDt3fbCcTeo1EQCoYooHgDNn9G2+uJmcvZk7GJol1Yepql1t0/fO/pS782GOvOEksrFHUHh7It5+kv8b+M+VX76VBMMrSb/NZtdvFA4R/kSmpRyAh28ESIN+Us+m+bWh/YM7KXbWcvSnLPrIIiKjEm9VaVvnmLkJp65DksMtB3aSf6BZsccEZWfhxZ81H9/BZ7CnDqJJfQDg48Jl7mPRHV+DmJDHB/3a86DE2qlnMl+Qws73uFZgflolCu8JkS7o2DxTB5GSRitlmauiXwTW14p+YrOMIQlWBlPTPNoefG98pOYIyuetxkMr8Ao3XjtGpTFZ1GQD0dX1yh9rH/FV5IihAcRwt1FOg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(3023799007)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wSovL+GS66hQLCcVVGF6IQLqu6dhNYcnkpcnZLFR0pLUANWklDEuA5Cl2Geb?=
 =?us-ascii?Q?9feltRmw1BI07X0kolopfF++XfXfQZqFoVNpfgm/jxJuTkaUNt5HCbYVl4+R?=
 =?us-ascii?Q?+OSUqWGcm876eYI/NawDaLwlhUuoSwzROT+c414hYC2ncnHFwG1PkfdVm5ap?=
 =?us-ascii?Q?CCrFAuwHSdkQzH+xpQgiGJU+CAhN17MG2lgdOZUGMk4WX8qDITPb/8bEJlLb?=
 =?us-ascii?Q?VafqUCwYkuqqMhXzzBeFC8z/dQQ8eHoJMoV8o/ZNNNecCNI/OE1nv6tCMB+0?=
 =?us-ascii?Q?J2nMiBcmIPiPWtkpFoh212eSpNH0O9FTYLhtVl/kKW1wRxsGLDg0n7Dmxc02?=
 =?us-ascii?Q?ks9Kid8ruyHBCKdi5mvQDqqHm0JR8m1ttcZFBrS43R6rENF++xn7IXBsY5/y?=
 =?us-ascii?Q?vAcgBZxLO2qdlJZY9ozoLDCERkfox1XA7Jb1COsbbFFIFzE9XIaGBuPWVD/i?=
 =?us-ascii?Q?h+x7YgVOBW6KsWMtX8MFkn7tAQOjJmqoj7e89XaNdCOokNZF1jxxnnNzOdxv?=
 =?us-ascii?Q?L+298clmo1lCAsd0zNZpJ/WDlir2HKZBerJug+G2FY8cf0R5KftGsN+2QrDd?=
 =?us-ascii?Q?IjuaF1B9K01IjLnZwD0KNWIiG84hyYoQfWXuzLpNDi9B0JUhTJ6BbidQyBnY?=
 =?us-ascii?Q?vG2cRaKOqKdX2q3EuJzYgKPnY9xXIAjMXh2AkL8o4Mz+e975tRIRiiQHKH9e?=
 =?us-ascii?Q?Ok51UuKmZukNMbGxYwt/c64fb6IG4/+JGf0M3wXwY7uQH3l1QPf5B806/ZUl?=
 =?us-ascii?Q?rS1vF+bGOksJKRLlcNpYWdu53g6HC7fpRIqsGV4GY3M50usZnSudMldRgi4V?=
 =?us-ascii?Q?186Uk4mTtPQx3QcHdErkJGaZsgBsJSt85z1v0XlVxiJqwfWmIOtz4z99l7FT?=
 =?us-ascii?Q?+RuneNsEInBO+6amwy5qOuNSfWmGJEDmkqBns1JXN0pQZ4VTKCS1g3C2os31?=
 =?us-ascii?Q?R565r/eRA9LSm0Eo0b1WjIcVXVj3WrXIbbWiDOApm+XJq+5fJoLo5/sd7UfA?=
 =?us-ascii?Q?Hjct6qwyET9C/Zk70v77GTg9PkKx5TFYoxhEFDP61VZkedL/1I3CEb9coZ5W?=
 =?us-ascii?Q?PlPjYFhURXjYXBpOn6WX6IuXqWNHen/1V23emsX4lN8+8EsiK5DjOqub/EKb?=
 =?us-ascii?Q?x4oy3v8YMZNSJbtg4OyY4Ezd8dgo5bYjyTCBi/blCw+xu/RJYeKG3irh4vgN?=
 =?us-ascii?Q?9mLNkQuLYzC3tSJ9s01osJ6IbXbfFqukBql3KlxOmfEJrd2e79IuzY8tSj6e?=
 =?us-ascii?Q?WctC15MaMAsKSKEPCaPBiQRHxZW6PXkxlqqRZYUS5HXlsf+gqsNgbv7IXPvp?=
 =?us-ascii?Q?EC3XxulNeL9sgzJMlDQzMvowxtQOLefDhNfhdeME19RtpECDXp9mGEom0SXs?=
 =?us-ascii?Q?Fbrh/+knIpaevyWQzYg9b6Uiz8LKCPP6yp8lfgo4ruUhP+Z6lNT4xR70juYR?=
 =?us-ascii?Q?C9QdbK6ueFSItu4K3c6Yhi/FXd01LqPsLx0boE0hbIxcr8vd4fRYHDGevw4v?=
 =?us-ascii?Q?bEMXZoeeXUr1lvu6vZPTaDbaa/zpBeJYd9TEcqS92ukE65LiMoVTaNMEUgS7?=
 =?us-ascii?Q?YCp6p/0RTaNrfmHhCcb/Ksn/dD5LhUz+k69YyWYh7XnBcsk+qlvswpnuOnG3?=
 =?us-ascii?Q?CQfvHVXDKbeBE4VZlfK0hGrvZYF1vSrkjYnoeG8KtCWxF0tYj2HbbbqWwS8G?=
 =?us-ascii?Q?hXwHKFKwZGe+vFj91BC/EoY9R2LAXE725AldUu4JiMwF/sJc7ownAcMUrwRz?=
 =?us-ascii?Q?shnbP1Xw1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bf513e-9c8a-467e-9e09-08df077a7a7f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:13.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5yHPxuqOKcCxPF7fJj1Zoq+p+fZvuFDbaJihUOP3eaMftaHDLuww8PONvDJi/QCfOInmY7BoUT/3bMKFbPxTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

From: Daniel Jurgens <danielj@nvidia.com>

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
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

