Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1DA2E7186
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=140.211.166.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765204794; cv=fail; b=qcQClpX3uTqYsn2/u7Oghx6euZgp6lQOw/2zRkMUBCv9qOJDNfzgNjs7btv1N4mlkSLleozhxYHnsy8Eez4HpFmYl0l/NiNPRMAWJ7x2d8DZrGJpknFehb9y3aF4qA2NzfrmlAdepUgy6ssSdqJuoafWu1GObDjMGItU6ZYkxdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765204794; c=relaxed/simple;
	bh=vIRChMwWP/IuvMstyw0ikkA8dH7hD4dheH/oaMfgBGY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BhxTVNt8oMp2XQxXu/U+h+jUVSI17rx/XipdnwTqYemjcorfMYHvpCj13cnDLTzLyy7EVOYb8UB/y7820MtmPjtA9buxNwVghS6JsuPw2bMk9oWxeSBV0YbEdtHnyr39xzBOqu4vUlTde4lBYr5VHzBjrqvo3u6t8so/iRWlk3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kb/zRSRY; arc=fail smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kb/zRSRY"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5E2840234
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 14:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.103
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7wGREPTgV7UP for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Dec 2025 14:39:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=mgurtovoy@nvidia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E3EC940077
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3EC940077
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kb/zRSRY
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E3EC940077
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Dec 2025 14:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmqL81/0NaEk1wjMzMRAGRtbVFrKTuV7qWINBBOCnjzApAqvmrcZnbpzLt6PdNkjLtV81/aglHcCcOf7DOe6IvtEUvr0w/DIF8x9PnnmDgyZTTtFizxofa4JVHs6vL6s493YCOEskFPi53rbIuuVuutr9WIzWdtHod8CuS90iIaH0if5NEJ8iY8rI3AXYTl40nBtZTjlEN0ZAHzABeEwiTes5nLUBgRdBd26//ZINfay/RHFk6ci08WTE3uLmq7Ec3PHjFmdTUEORMIxdq/8uJt/uTeIs/IJhL0ZreQ2Zd7VHJqiZCFJq8PEvpeKQtOWF4Iyn/T5OCh4WDhLfCxqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEWkSacPU3oXI1u6ODQIsT4shA8v6ojGc7WqqX10SbA=;
 b=tVjLg4otUTPPm6O+oPOr3Hw8OPgkYDGAHaLCrVwPFmPyiw6iaG32DwEHviQUy4136Z791fCN1/NBTJXRR4K6fNOSPxjOINIXA6ty5UxNXdaRA837gO70DHZFKKOHvd+QTHwYwyvGSJymVOMIdH4J/rSkX6EXUSZzOAsWcKSXuZ/9FsD8Iv4SzYKCkxkDHzQ43fI9yqp8NXxGWqlA8aEezqwmLDyIkApR4sUMSWDlYODJdFsgewNDI96OxkwUU2enDOfKHLatm+UY1OjLaKmKM/rXW+R+Rt4avhtcYBKowrIJOo5FBsFFAmtVrSCrVEL740gYciN5Tpweh2MhoowZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEWkSacPU3oXI1u6ODQIsT4shA8v6ojGc7WqqX10SbA=;
 b=kb/zRSRYnm6iCILSAtIDD9CN6+nVrgnHId04/N23Prkupv5hZoG9cwHtGUR3I1YlS3iIwX4KoT3s5G1Ar7JM9iCPG6ToAbled77YSOZ9w3fVLhQ3XwDcBEW71ROUBOHr8vKW/7nVODIej34aJ9ENvUo3psxKZUphr6umsh9/v0O1LPN5JT60YcCJ9xwgOOVtaBBB41/06Ay1dKqsqcNDXxi9WjVfQY3rfTE5DvwVF6yRrE7YxTCnlMqziUN2a2qWuYu+TDDyY0wmJG9HdDwWfKf4fPLlpalbZv+x0i09QkEl1NtfQsFt8rBUh5aFkvXC/B6OXLSEO3URVWJdjGEPsw==
Received: from SJ0PR05CA0142.namprd05.prod.outlook.com (2603:10b6:a03:33d::27)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 14:39:45 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c9) by SJ0PR05CA0142.outlook.office365.com
 (2603:10b6:a03:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Mon, 8
 Dec 2025 14:39:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 14:39:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 06:39:28 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 06:39:28 -0800
Received: from r-arch-stor03.mtr.nbulabs.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 8 Dec 2025 06:39:25 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <mst@redhat.com>, <stefanha@redhat.com>, <sgarzare@redhat.com>,
	<virtualization@lists.linux-foundation.org>
CC: <oren@nvidia.com>, <aevdaev@nvidia.com>, <aaptel@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] virtio: add driver_override support
Date: Mon, 8 Dec 2025 16:39:25 +0200
Message-ID: <20251208143925.32246-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 514ef725-8410-4d0e-b28b-08de3667a149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gfc060MnbZYPhPdAZtzV6sGfm+NYFahNNXIR4QknpjYo93k/9/ZLCMCgmhko?=
 =?us-ascii?Q?D0o2WrleP3zMTEIv5WbSRtAFZ/q4Ms5yK2Cci+hYCdQJ74FXYnVd6aNYi8NA?=
 =?us-ascii?Q?WlaVhtYcu4KCMMuRJiouhJ3TtTpszWZU8dQh/Ne5dgtKpHEcuTBEbWSPA8g6?=
 =?us-ascii?Q?/XgN/FdtKeiYdojw2FPXiXMk2+yX3Mb5ZsxgCQ47+nLJUeLLOhSqVmx8daM7?=
 =?us-ascii?Q?UT36UB2lPXbgvbO+VpyyFT5dop8LnvVKt1wOjxGAJa86V0hZtTdoxD8TnQ4U?=
 =?us-ascii?Q?+/eCwFODwI/7o+7JkpTD/Mkn4Y6D+Q0VQUGOmiY6xiQ1G1P6xECudYfSvtT7?=
 =?us-ascii?Q?Xxo+7V9LtPF86TGIktdAxg7SCTGsa7WxXlt1uITthrnxRDmiA2Lv7wa+Y7/H?=
 =?us-ascii?Q?YhtkqpmQ+V/VL1c2D9fjPCU8lJ+ypminsoOGNEa1UTHay1Wk/v7ypcuJZ5Xg?=
 =?us-ascii?Q?PgPT2CfHpLaFppSAQQ4Y3i5UdL/hAgHD7q6YZL1YtULPouRhLfDZ7NdyrM6f?=
 =?us-ascii?Q?ZCR76QMaeTYlJ+4Fdgqt5pykQOOpmaw4CvzKV/Qt2iXJbxb7OBFkuH7bLJP5?=
 =?us-ascii?Q?7xhag9dwkP5juGGGCpTtoR1KMDDZW52PUiA4q/dRreOjA7Z/Rk8/uIkX9qE7?=
 =?us-ascii?Q?RqYYjvVTCZDSa4W7rEXOL51GXSbwznfVg0Vygxn4486TA8QBPTkDi0zQORDs?=
 =?us-ascii?Q?8mHSxnzFYB+StSnA2WYWeLlA9Gxzv7Zql7HtG9BVj14oIwuKEqOzolcv0jE9?=
 =?us-ascii?Q?K6901ZzklWEtzc9DFVFGhxMQGAMJX+hoF4ipcnKu0ERLoP3ocr8wGWEDkzDp?=
 =?us-ascii?Q?NOojfVPnWzweeC6mf2/kTyVhOk1B2df6IbYvZ3/Qj8htK9YroCc+sOsYiQTJ?=
 =?us-ascii?Q?joEgpJXvFQUUE83zvBR22LN/bxd2H2gJdVY4r5QpjPCQCMoyG5MbNNzYqIsU?=
 =?us-ascii?Q?ozrEWQv3A7gGn42K3faT0iSzUc00Wpp1zJAGoaeAMsvshCwB8UaANK+DgBrX?=
 =?us-ascii?Q?Yu/yeoQo9kGyls/8EoilmRD2egINXChPalU9HS/Dp3GYB1NhcZSpgYWvDRJy?=
 =?us-ascii?Q?sP7YWUL98BTH8I5OE5q/kiwh0MKSvbXP+bhkW8zXiPS7m5uAtdgsUbJxMNcM?=
 =?us-ascii?Q?UatLbmVJT80dgyLTMUGdleyGPItYA89A8fgwGmYY5qi86bpyLeAGR3VYQKyz?=
 =?us-ascii?Q?cdDkCZHjmh96Wn9J1ppszjtGa+VRoPZL7RAW5Kk8x9Vd90binT8CepI8chQg?=
 =?us-ascii?Q?g2Fa2pgRQ8KjjSH8gENt/h2XcoXuRUnIYaiUXm6cyLaGXIJ+mq5nilctGYuo?=
 =?us-ascii?Q?aQMUKqkrR0PPfugzW0CjH9Hcb9fuMcsqyNHUUXsK8HMC7fsC6V//YqErC9tZ?=
 =?us-ascii?Q?zpOw97T9vZ8Tp2m343Ta+cVRnlr8MHeCUG6lmd08gK/LmWS4/nE1B3PS4qq8?=
 =?us-ascii?Q?te45xXb1lA7A8zYprb7Ir9oi+L4oGqudU2yH1CYToCOkDXECTQXnCgJiPJI6?=
 =?us-ascii?Q?MpBWKph/AUCauEushCy30qbibTShGYJjUyzzyVtgA4aX6QFobRz+ftAP3gI9?=
 =?us-ascii?Q?lYeIuYfxg1WiLye2jqo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 14:39:44.8091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514ef725-8410-4d0e-b28b-08de3667a149
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

Add support for the 'driver_override' attribute to Virtio devices. This
allows users to control which Virtio bus driver binds to a given Virtio
device.

If 'driver_override' is not set, the existing behavior is preserved and
devices will continue to auto-bind to the first matching Virtio bus
driver.

Signed-off-by: Avraham Evdaev <aevdaev@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/virtio/virtio.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/virtio.h  |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a09eb4d62f82..f3ce12ee1fb5 100644
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
+		return strcmp(dev->driver_override, _dr->name) == 0;
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

