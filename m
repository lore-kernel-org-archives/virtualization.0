Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23923CAA31
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163102; cv=fail; b=Fl8ogPCJVtBZYY96XcwKuMeirTHgZ5169BATQxvFqIBHIyv1ro4V3+q92pfoxXAQSJh1RDLgoRiqVo0Z2+JrgYbnhHlcKgQWP5i59wx2186ZUZ5eXwKPuHt1k28P6Aqvsk7nHBCfBokAEEVaP63+G545JNjEQyfYGddBUzGGN2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163102; c=relaxed/simple;
	bh=9zaONXKCnZSM1bCaohwCb4ogozu/KuOxlvcQmi5bUM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jN23ZYbXyh6P8tVdkaeyNw5Tz/eluW4SjynDCe1bsFklUIWlzDULuwa1pYvE1As510nAn+mYVA0G/v5j6zf+2D+tpThzBamo8PxIdyduEkdGzcxG+oGENLzK88Xi6qHo9UucXmkZGvV/JMqgH8VSVBeGBhJqj9xCc6Vrmzdrlac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EhwSaJtM; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EhwSaJtM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/jHFggjsdXguLCuR3ZM87J4YyApgh10nVIMKPodi6L2JC8fqW4WxCq9fU4YFwNNJKsQDyUh/EK4KfEzAWqQRLSWlDKVPxcYSC8aQUgPxk4nzPvQhdXVg7dHTVq81wT2JdydRF9XONvUh/oLh/ZiudW8sAqTMhsXKV+17Em0l//U1Z9YHCwuh6VCovqfgccSOnLzL5mPS9QeCz8lQWeArbKDwy82WyD/ViLFzR2wg1JTFitRRBLpFjEkSs5E7TQnZrvM0FANtN/G0Av/JHix6SVObS7cttuFR3bIzcP5in+mhcuUk7q99IzVNDnLC7Qdk3ms1PV0GC2NpT7Rb07kbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOb8KDaIYtWn+xngWBIZbu39FbL/f3S57QX/4MO62sI=;
 b=oP7iS2QAVCiItzhVGrEyONN4d6QoCgvCx17IeTHClOkv7WOh9axwZVVS1S4Eir1fnCR0uDoMnULLwo1/OM7XPpdfXGYyEIlxGQaVHZ3WoRD+YT/WCu46m58zwXObuUmk9I11GQ7VZ4NDm0PonCjzNy59V/KNgBQVLhb82RRk49P+eBXjp53JOGIwo++yWCDXotx+5BGVO3DcMuqahD7Pt+RgU+xPzdcdRw1yfYZ81HN6WQrCdSJTAFB3y90VvBTrMXtn36+2UsD9nA5CD8ake9UzDNRjW8MhO0C2Iq3bzfhvR8O3KRb8kUnP4ikOQSBZ1kI03WzHZyx+T7P29lB9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOb8KDaIYtWn+xngWBIZbu39FbL/f3S57QX/4MO62sI=;
 b=EhwSaJtM1pbXCEusWjbUo5flX2wdgVs4A462bgav63zM5gm3x77ywFtYL2ZP2QiwG/JKk8AaMK/lAsrEJiqqkR6tANO8LLM3Nr0K8tCnkTXLeA3hByuo4ivwUo8fmQ5vlrIbLYRoDsyjDY6gf09dlH+Ql/l3awMs3pTqvyc21R3MYcuUMxuhk7lY6SHTzDzZr9PVG5hWI8FlB1gT7TvfGi/gV7kkV7UdkQqYFPbmGk/IUzYoQTjG+lGpVmEcdBQNEEKkh3r6kVNeb1xWPhXt7gbtmVPB+XUyGEBldh8KKOejnvC5a5wYBS3/C6LudfSM2d+uiHgH96kIJLxcj2dhOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:17 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:17 +0000
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
Subject: [PATCH net-next v22 03/14] virtio: Add config_op for admin commands
Date: Mon, 31 Aug 2026 10:57:56 +0300
Message-ID: <20260831075807.2891426-4-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 967a063a-cbc5-41ce-e35b-08df07359dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|6133799003|22082099003|18002099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	aumyvr/sSl9vtUflvuenyXIw6lBQj/DhqTTKh260/VhSlcCWAQK+RTHCNVbA2kjwJHLwdi7/rrEw/18alNEqDlFPsXB9UGV63+0pXLmLHs+TB4MxGztbuc+N0L/KkIRN5ssHsWVEFGzRwqmArMixmQuEFLvBkJIC0aCtR9215LmFR3WaePNDnn1XMS/8d/LJwxmB46p6Ca4901UUe2kfGi+VxEwoUdCJ1TAJV+4R9OntbFXlV4UXBoDyxFZEJh8cGM0aY3Tq/9EjZLVamlZS3o2XWIRQyHH5/m3n65st3HBKWnE3xD4LSVzsHGyskjDo0YgcwgptZ1cRL7uy3wfShawc5ASki2319ITiYCvk/PyF5xh4OXdCpCYEiXBSLn4JODMVEKETpReRpCPk0BxlY5STXdMICq0qMkyyFPjTgTNSOijYFjmW1kuqHGhtGW/jPY1cWpaDhRrPmqplcFpGau1DlIwSj3sqsSi0K4QEDoJaj0lpFzPWabXlGcL0IxCJtxaRC9sBXObxNgMTxbjBjFZCRaYybsjM4kdsTX09Cf5q69ZE/XfHdyfqnLxQ+2HQhIrudeTfmGbNiqXclLan48cBpfRhGFrXzU1zUulQl+k9/zIIKUcqHfvdLEUl9rDJf1eqPk5rCsBO1qFJuf8xtUYBzh5WkIxXicf4wHKe/Ig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0aeCy1+ZZj4bXrHaq1S44DIEhV96EWvf9NyNbDSa28+2pUwmEIVFpAku4Oau?=
 =?us-ascii?Q?PaYwxJkuK6wtwWFuYS9Gfc//yMwJyIGDUn/q9bJvQApt7h/H0teVeKmBgWXw?=
 =?us-ascii?Q?ieYxqrlj6Vpw7qe58oyZoI0a6bGFZ3+fPXmhBguggAbmCYgVvOXnB8C4uEuK?=
 =?us-ascii?Q?+ODOFWGKbUN4NmOkEqUDCKkwiXBipit2MAOH75Bnx8YeMFny6gW6kPXCY+Nd?=
 =?us-ascii?Q?2EJ2D/H+9PsuBlbSLRdO/UpTXcbtNE+lOtIA28/ZPohhFK7w7mXkvlgCkfd4?=
 =?us-ascii?Q?YfvieBQXkI8SMTiP2F8CW1UNDTytqEzDGBZxivaJYfpzXvmK9P40bv3vOCsR?=
 =?us-ascii?Q?bHlb7+k9p9KdL7l81TblbdVwyfb3fCnFt/aIzHbjiXMYlvmHRAPl+ps+yPv0?=
 =?us-ascii?Q?PxMeIbYKaD5Sp4FgJJXp01FWB7qYe7CHHiXtTvptROjUX+b8uAkhh3rzCckO?=
 =?us-ascii?Q?DEQj/IH2DHNk8o3Ey56batqCDektxx5DgjOEEjcgQypUMpceWVudVelsMxV1?=
 =?us-ascii?Q?44xtJ/nTVftEIUGAutb0s0KLYq5yJYydgrXxsRhjpRxR0YLg7aZESe5WZhlj?=
 =?us-ascii?Q?+aOB7c/JJlfGkDllLoQRAON95NH34aCrYCL1FZq/Civp0rxKcLxDmk2IH2rJ?=
 =?us-ascii?Q?BwPi7F5CK1nW8Nhah8mRmmEs3ghdaJMgJcwq/CJvTOL4Te85d6pmI2VKEZSk?=
 =?us-ascii?Q?G0dcYau/3fwZNz959bM0JUU6rMtWCHK3qbIdbjLlHRMHG48xfau3dagboR2X?=
 =?us-ascii?Q?rVWUKPNNTvsHapcGDJzZDFmCAAbI8yYDTF5iI+ieFBGT+MtAvw0kYwMNbvnl?=
 =?us-ascii?Q?Y1Xe2vy4ZGw4aIQA6Tk7FZGZk1Z23Uz43zLNnIdOuggCdnbtlKd8APtI2Nsl?=
 =?us-ascii?Q?DLJhF+mZXmZhfGDWPHF2Evc9meWzfCzlzR2P/paOF9Ukq1dc75qx6el5o7ln?=
 =?us-ascii?Q?4wuKso7eyF6vYdphGDeWlLH1ofb9hj1aY/THR8vT4hq5jghpWn6aTX2cMCaH?=
 =?us-ascii?Q?YTsNfvgL6qgmh8h07JRS95KDHDK2ZmtSHFCBKcPEXMhJX9XuJgGTpdxRQ0c5?=
 =?us-ascii?Q?L1p2c+SI7CSXY2mFGunkt6Q6VOR+NdLgrZiAvKkQ7fv+J1uQI4Ux+d2zEvAH?=
 =?us-ascii?Q?1m+2m3XqTbsahjF0ODPqICUZTpQUrzfr3hbwx0vGOtwiLMbYeefhoA+Htk0Y?=
 =?us-ascii?Q?1wexkbvGTJDZUBxL1GIJP/8yudysMEUf+eHMxfWZEI5WZqOLY/gst8BY1dQO?=
 =?us-ascii?Q?+R5PTNQZAVRCfD/sjmqUHFqS+DlWcfXTF+cywR3wnrIBExMmie3pbgxr1J41?=
 =?us-ascii?Q?5mLrA0eTTrPHy9Rrj+462wGiEYWVgYyyJAv9OlMhNicDGH4c3i4u7cSZbyRL?=
 =?us-ascii?Q?aJ+iwLqQgKhPpOi7hgbB63wvq/RWt+8NBToigrFjzDGwGfeREuJziIfHflao?=
 =?us-ascii?Q?SzC9QdlccqFGlx3oIf/gyCBbyJKlLWVgDU3H9kVRUTo0jS51PO9MCCGMa97M?=
 =?us-ascii?Q?RatcL4KE8TKnpA58yFyW7LlsnVwis02PSjGuecIlugmJDIE3+ldnp/AobMqh?=
 =?us-ascii?Q?Yr/xNwkkJ4i/QSUi3mpxummEF0CYJ4iFtPtb45mFhV9+GYH/xtEP0bgTQvz5?=
 =?us-ascii?Q?5DNi+JRc/VTuLUO30feYpI5crUsxcSRhMDBod8yap6a1dkNp0lhs6PT2ZILW?=
 =?us-ascii?Q?bKJddjfxhD5PXZ96zh3IC8Y4+cAe/F6SwedldIHczVH78XiM4ZJWnR7D+LjE?=
 =?us-ascii?Q?DK65OD7DQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967a063a-cbc5-41ce-e35b-08df07359dbc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:17.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbuJrqIzdj/qK+vTRXnhBe2EPXAejyNiI4LkbAaMDS8kFT+S+sg0eAV0JM3O+8n5zy+RxigESadyIDCEN8dNqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

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

