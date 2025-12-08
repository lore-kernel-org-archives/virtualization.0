Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35882E4258
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765231782; cv=fail; b=TcJktLpWw4Exp9Zg/++2AMivhqFBpiLX1/jEgeLSx3hrhYzNgk0SVL8leuDBBQVOVp8/clSwq3B7w+2q0sqU58Ffln0LHjuHkrqZnCFsVGpGEqtepTNVrzLPC4Gdj6hUixiB9mCObbrHt2ti5HTa0FCyIk9h8jje2YQNoWOjHZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765231782; c=relaxed/simple;
	bh=MEbBxmUoXNnj8I+fkEsS1E6h5/op8IAm4vue6CGZRc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ffGNjaFJ7y/1vzWLUa2evdJMZn6Qv2trD4yArmdSXdn3MDtKSd0GriFfHNTf4eAuk7gsqCK+ADU0UEBeiKN9/BZRV/S3ccJWAN175v+QLHMS7ZSoH1N7mHcRcMEimFAEMqWuH1J9Oii9Uxoa46G78NtJyDk2Jls4i9ybpX1Y1UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZTf5L65X; arc=fail smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZTf5L65X"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 606D160DB2
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 22:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9iNYN0zd9Rv for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Dec 2025 22:09:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=mgurtovoy@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4C95260D90
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C95260D90
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZTf5L65X
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C95260D90
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 22:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlWIUdvfH50B5wdHijKV9smkr8Dki005p9OB3peGkPa8BlYg6Zvmev6oTf+t54C0xGXstEyuWMHlFpXEj4+nxCcNTCAN+BtsNM/KBJw95xhVyG89vOAutJmCG04QjJ7sBjtrtVyy9HqZbcUaU9g68JTZy9BqwDOPzx8+lum7ou8KWbBVQIVB3/xWk/MQ9+373iyR8FkEVwnjRoAgrNmAlpquPkCZyW7C4Wn7hQvht1UndgrlT392o2Q440os/8DTGb6UZHzEEFfEpCNuXE0up1jdeMlRhJcum8N/NbB3aZfB+eU9MXtP7TIm99KcDKGpuya1+EiLaTmqEA9EelJ/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1Kk+0GWk1XzyEPpxyQZUVTiWRp2++zF0+PW1XUHpRs=;
 b=AIqriOhLTtlu0q7aHhFH+fDIdFyH3BFAopjsIFLg0LMAVhNc6cNI/llmIjNrMnN1Eytp0BU6K7Bj9dYtJrDgjcETAUVr6xUkqpHBvCCvpL7inccfhVz9pI7O2ttwVtGEatA3oopwnktNokoCn0rMcxP5AvlgvilCb7WQPl8tyQt5L40GkvOeQz0hhe0hexLe2CviAz2ZkCtUGYjSwnvpwsD63qHgp7uXJxdT6Y5KcCU/cM7x+700Qb3nQoDdYjtnEbSiTGUOunBY8Sw2M9M0/+xo8UOZCx2hDgEewjMOmm4UKQPS4cxIy4Qlih+u5uqcZZ9drjLcpVVgGPr26G5gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1Kk+0GWk1XzyEPpxyQZUVTiWRp2++zF0+PW1XUHpRs=;
 b=ZTf5L65X7KaLOooI/hfN81o+h9Hld1kW1o59ugclTrpqvKmuW9VTs8CXdlywGc9p+EYBT1w0gca/Zn7YJqKkIyOzoDWcYuKEZe77Z3Fjj36LDKoP26d/zVzlocPSr5M8Wd0PvAUTBFpLpzJEYTXJEXnDE35JiZm/hBpjSXap5hG1GpvU6LfNsgQL6N7F1kXRlIOA+iHIJXwuAhw38+ZpfkVFgwojS88BFFEoitcvJb23NP7xcTOeUHGaQCX4iq7HRwksZ72Q/M3hVrJS9S15nSKoe7YkXiN4UZ2JT42/vM6/DUiWoDTAYTvyaM8rekzogM9LEpMXcbb13ABbRc2xYg==
Received: from PH0PR07CA0075.namprd07.prod.outlook.com (2603:10b6:510:f::20)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 22:09:31 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::63) by PH0PR07CA0075.outlook.office365.com
 (2603:10b6:510:f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 22:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 22:09:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 14:09:12 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 14:09:12 -0800
Received: from r-arch-stor03.mtr.nbulabs.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 8 Dec 2025 14:09:09 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <mst@redhat.com>, <stefanha@redhat.com>, <sgarzare@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <kvm@vger.kernel.org>
CC: <oren@nvidia.com>, <aevdaev@nvidia.com>, <aaptel@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/1] virtio: add driver_override support
Date: Tue, 9 Dec 2025 00:09:08 +0200
Message-ID: <20251208220908.9250-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 22045151-f8c3-4e6f-7d98-08de36a6764e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtK2El3EoEL9tw5FhVi5LBOmzA25GgQGy0AUkO5lU8iOjRgbxfWP8WSzHnzU?=
 =?us-ascii?Q?zojySzGn72p0EkSSrGtROpgh0s7waz6voRp2vHewKvqfXi9uwmtYR/cwP4cI?=
 =?us-ascii?Q?5Kw5vxE6eUzbrIjaZs7uv6PibWsMsHCfSizc2CJlALfcB6+faSGWjx3BbaMx?=
 =?us-ascii?Q?r2vn5SFsWvXl6RLhOyWb/PCTYk9b8viLWEYM8vveiD9SYmwPREUMdOMOrawJ?=
 =?us-ascii?Q?s25rYMhoTdw1dsG11AY4efcr8sQzvZN3MTjDohmZKN/3f72k9PmDu52HAx05?=
 =?us-ascii?Q?+uivYgQV4DMB3QVvIGyUE3+RX1+Rzh7A02IqvMc7jfwIRNdSZgX9AxoNGeGH?=
 =?us-ascii?Q?/0m2R/nXz9yvuS+H6uRqWsQc/NlDV1Vavf9ZthUpoirm4OWIoS0MpDURstGK?=
 =?us-ascii?Q?d6wirvZ1EnKQ6vBxEzE3nMlakJ7xDHcfbIeMs99zcBP19H9eBMdNklWgK4K+?=
 =?us-ascii?Q?8Ytf/VrIPVKmsvok5Qo5bmzezTAfRn2QSA6izyYQS/XtJqpheTvV9xqJUl1u?=
 =?us-ascii?Q?fRWlL/aK76Mf1ZuISKjOhVzHYtgU6AFv2tN3tuI33A1BUgl2kf+kneQcB4NU?=
 =?us-ascii?Q?A79G2ld6zsLPqpkPo7ZhkOwnTXCbhhx7ORs4bGBmG2+KVwa5XZTsxo/CGIqb?=
 =?us-ascii?Q?btrv6OnbdMFRlvrWiBAglEolpjGPtbnk7ZHsFM//3GadJ7eWS2bGE1lRnnph?=
 =?us-ascii?Q?49EkldhhJUGhYPFa8peqkASQFUpA8PCodQj4KMQhTWVkNGZHQGfb3P3UtFfq?=
 =?us-ascii?Q?IVQZpc3A0wOinjuZwXgtUGUK17xVaRI3FK4EL0LKB4HkRVrdT+5nnalZXQ/9?=
 =?us-ascii?Q?icVjBZEsYW6re367xRJP1TdUiAAD+DgAGgOE9JejqwSo08BbcNpg82dQ0KrW?=
 =?us-ascii?Q?ijBHNLg2jQTaz98UNCpu4m2jph1s/5nq513qskEo8T9a8Q8zIvsakLoGNWdB?=
 =?us-ascii?Q?HTdYeek7uoqKWiE5A4Yu4KYgHcXhk+2KFsP0275E5gHgzVc1M3QKrE34nUqk?=
 =?us-ascii?Q?EkzuDKQRb2v8EsVuox5tTQ9hkvvlCIyqNYuVQFtJ4ofj9lUMdWTHKR50SIUA?=
 =?us-ascii?Q?2phcJNwN+ikpaQC/c+UgD48FwjLTSShi79QfIJLHXKYX37wigrsIhYF9e72A?=
 =?us-ascii?Q?6Y+/dHHY3jJcL40Zgvewsk+pCCARIkISveTJqC3bJX6C1oUHOs4ozUzcGGWm?=
 =?us-ascii?Q?MVRzXiAMaQgL1wj+VmmxuV6XoGyHV/nWxi8DE9ZXC0RiqHB+sNWJuy2/4u8R?=
 =?us-ascii?Q?3+ICVI3cn6eof7ALwB6zZYmgPFjiWfa69xvkqYhbuBS9murByVs13HjAIWmC?=
 =?us-ascii?Q?gnvFW7G1zq8B9nf9mL/bi4g6vles/m5VAT3T40ncetGMbDPKDMfUX4IwMO8R?=
 =?us-ascii?Q?3vFGvdSFZIkAcxgfPkxOI4M6WlpxAGN4hLrJbVVjpNxd2eye8+wPkBPXm5t3?=
 =?us-ascii?Q?kKqm9j8xNrFx0r69v2qN4H5PL+mox6i1Iex9ltCq1dXisDMazzE0SiDFXzQS?=
 =?us-ascii?Q?yg/J0VlP7/+lBs6PPoh2beK6J8j6PORpDqlmMLh6EzpAtMf2NcSkx3lBvZuh?=
 =?us-ascii?Q?SKkD6ELOoADFQf/odgU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 22:09:30.9358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22045151-f8c3-4e6f-7d98-08de36a6764e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

Add support for the 'driver_override' attribute to Virtio devices. This
allows users to control which Virtio bus driver binds to a given Virtio
device.

If 'driver_override' is not set, the existing behavior is preserved and
devices will continue to auto-bind to the first matching Virtio bus
driver.

Tested with virtio blk device (virtio core and pci drivers are loaded):

  $ modprobe my_virtio_blk

  # automatically unbind from virtio_blk driver and override + bind to
  # my_virtio_blk driver.
  $ driverctl -v -b virtio set-override virtio0 my_virtio_blk

In addition, driverctl saves the configuration persistently under
/etc/driverctl.d/.

Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---

changes from v1:
 - use !strcmp() to compare strings (MST)
 - extend commit msg with example (MST)

---
 drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/virtio.h  |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a09eb4d62f82..993dc928be49 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -61,12 +61,41 @@ static ssize_t features_show(struct device *_d,
 }
 static DEVICE_ATTR_RO(features);
 
+static ssize_t driver_override_store(struct device *_d,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	int ret;
+
+	ret = driver_set_override(_d, &dev->driver_override, buf, count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *_d,
+				    struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	ssize_t len;
+
+	device_lock(_d);
+	len = sysfs_emit(buf, "%s\n", dev->driver_override);
+	device_unlock(_d);
+
+	return len;
+}
+static DEVICE_ATTR_RW(driver_override);
+
 static struct attribute *virtio_dev_attrs[] = {
 	&dev_attr_device.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_status.attr,
 	&dev_attr_modalias.attr,
 	&dev_attr_features.attr,
+	&dev_attr_driver_override.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(virtio_dev);
@@ -88,6 +117,10 @@ static int virtio_dev_match(struct device *_dv, const struct device_driver *_dr)
 	struct virtio_device *dev = dev_to_virtio(_dv);
 	const struct virtio_device_id *ids;
 
+	/* Check override first, and if set, only use the named driver */
+	if (dev->driver_override)
+		return !strcmp(dev->driver_override, _dr->name);
+
 	ids = drv_to_virtio(_dr)->id_table;
 	for (i = 0; ids[i].device; i++)
 		if (virtio_id_match(dev, &ids[i]))
@@ -582,6 +615,7 @@ void unregister_virtio_device(struct virtio_device *dev)
 {
 	int index = dev->index; /* save for after device release */
 
+	kfree(dev->driver_override);
 	device_unregister(&dev->dev);
 	virtio_debug_device_exit(dev);
 	ida_free(&virtio_index_ida, index);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index db31fc6f4f1f..418bb490bdc6 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -138,6 +138,9 @@ struct virtio_admin_cmd {
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
  * @dev: underlying device.
+ * @driver_override: driver name to force a match; do not set directly,
+ *                   because core frees it; use driver_set_override() to
+ *                   set or clear it.
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
@@ -158,6 +161,7 @@ struct virtio_device {
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
 	struct device dev;
+	const char *driver_override;
 	struct virtio_device_id id;
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
-- 
2.18.1

