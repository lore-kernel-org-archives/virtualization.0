Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022097.outbound.protection.outlook.com [52.101.126.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2E222580;
	Fri, 31 Jul 2026 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785462727; cv=fail; b=QqK65VIJJNGm6tlk2oXvRBiVd1QBO9ISOrko3xYYeI37c5uJTeOgNLbtMwmebuJjYh9NkeWxxITwNj4YDK3YQLLX/HuQZXUBG0iFPUN3w+5W8gTnMvPTXf/ZANoI0x9Gam5/Z7097gbx4Hvk3SI7NUFYzfA+9ViBy66UsI8Ol1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785462727; c=relaxed/simple;
	bh=voO1PxT7RcO36PMo4QwZsU+4YSk5RTJC7Oj2zj8UZmU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ma6esnBcjEkjcnpoWzusEkREaA3Wbcf/dUdwtjHBDQWKfbiJryNh/oi2MT7GkuN0PXuAb6JQLfXu7l5BilSyoBvTUejV4/htuhHQJVFxBEs8fbqiSG66IKr3Btl2H9QHpd+hivH9YEL4a1Kvl1saBGL6gziRm0Mq6FDqDUiz3Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=D1GRgwH3; arc=fail smtp.client-ip=52.101.126.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="D1GRgwH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5uNkyHFmdq+4sclOXvFKV4ruhyv8Ubdub7QRCRjxSexg3K/uoWqoes4qZ5Z8XYebJbl0aaA1FwOF2zImooEXMNaMLDHq5NWIHj2whW96FblKzsZV5d9YvIqnDk9iOVbe6rhxEy36HHfaFlKqHanik3MpLl3/CAWu5V/0SruR7FRK67qV1NUTstVlp9YBo62QeJHDOzc+UEKpF+v8B/CX2lkh3/QzCPfxeqHyFB91eyoLT6XOhhTU3GGFpjnIMRnmp06MDMCSYlMrzyGi7qdB1ytlCMX5quRMFVqMYX5BJlX1RkQ7l5ox1yLzjj80Q7reN3d706EHCsPkBt01HSiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQCDlRbCQANbswfhIXs/b1GESoiw2Fp+ZI8gXYxOjMw=;
 b=xem+nd8SZmugRo14laNBmmGBy2uoo5vxh6C1JVtG23P7MUNtT9drq1WqXeRQUbeQoTBeKz/oVE2eiJJD32+4wy1rhZVeELlWU5G5xmeUiXdXsLgPP2xGhaTptyL3qAD4cDIcdxP1P39udtcK01+Z09E1p3jxCrOYQl7/oH2qnoToAh3xxDgre4wVFxKu4dGE/IkPYzdFAWJ+kj59yMHz4s2qjHuWLvBMlVISbbYLv5hqsARkWNgHufxs234/ILd85TEBLM82aqLsWvm++OxEumODWYY8SOJ2updGHZZU4NzROzB4c9f9kDp85gv1jPt6PjTzedlI3PJpUahHzAniIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQCDlRbCQANbswfhIXs/b1GESoiw2Fp+ZI8gXYxOjMw=;
 b=D1GRgwH3ktWF26jyjQQOddE4e215P6acZP+YOnz7hOJoBbC51oTKbt0iUIDt7rtnaS2YhAj2aDBza7xk6He+HGroQZWz1Hg2B9sSF7tlWanouQj7wG52rDCSbH/tIvoi8Qi4asNdmwy3wulQ2z4xvTcpUIBWSFVKMo5zFp5ZP4ioFEt+YQkU51NrmGNmeF1yolHcvHWWfRIHov+Uxmpq3fJ0aqUhcLMl7BnW3kgNjvo7fAXJJfTwEOjYWVm3ttrDQWJvMCKZI7k9Z9M4iY7FFTNMbg1vPWoWWoGeRw5PWTFScYUEtq6vL6TpBrK9Q1L8cUUkYqGgqrUJA9zkx01ZaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by JH0PR06MB6656.apcprd06.prod.outlook.com (2603:1096:990:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 01:51:55 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::3dd6:8bad:93db:74a3]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::3dd6:8bad:93db:74a3%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 01:51:55 +0000
From: LiMing Wu <liming.wu@jaguarmicro.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	angus.chen@jaguarmicro.com,
	Liming Wu <liming.wu@jaguarmicro.com>
Subject: [PATCH] iommu/virtio: Add debugfs state dump
Date: Fri, 31 Jul 2026 09:48:38 +0800
Message-ID: <20260731014838.31187-1-liming.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.49.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To PSAPR06MB3942.apcprd06.prod.outlook.com
 (2603:1096:301:2b::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB3942:EE_|JH0PR06MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d52bc19-fdb6-436c-bd04-08deeea64c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|10067099003|6133799003|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	tGGoxzgtNiKtnVo6yuMtg5CLU0VM14JbOicTKISJQmICMPAluIdgwRp1iKkLZegI6n1kXatZ2WoA6M0/Q0EnQ4NxDGzGVNMbZbz8GRgCdaUtxhMXEpLspeTE/qfI8l2+/QpZ8orGK+R0QZEkq0IyPqm4V+Gzcwuuhkj6KK5Q9J9xVl4LM3GF0U2fN9z3IOC3wIgzA1JTwxNs1O3ugDC3+Q1OTjue6QiJ/d5LToZBYxPRnEGBEBltiXd9WZt+0KDCE12qvwERHncbiVGJ/GaKLqyU7FjZ3S/Dq5Wo7ht3Nl2cVGI5BD7rwKYxH5nuIRFBQSuyi/uO6JHTXmRkSJDITPAA+obscM0KZ2+z2FMLKZo7tvOVQt6IW+v+3vAPxoL7wO3MvlP+7hzj9OFXQ94NSsSLMI59p6mRwlE42EsRa7H8T8T8VnVYLWY78JFs41W7l6ZdTdgFM+R+sIvNuoz1kxawqHe3o5SkHpebER1gpN+QpXWYCtUab9fAPGBhn85qV7ME/JGh+USvTw+pHiTNhGjq7JT0exuBwmkN3szcWm+5Buft6pOBJANmDXLRQrn+c87aBs0xgQyVLmD4KODMpMCGbMCZuBW7V3OARmSHGVZCZdWT8uG26PUuC19RKyBXq4iqqDvWphPO3qy6Y/LqaVHLdKUg4hPUndCcjCRq4nbWwP9Z7s4R5lVAECddKVj2EcCfLMfjq2Xrr2K63aOGkC2xMtUvNJAT8RZvp2NoGNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(10067099003)(6133799003)(56012099006)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8IMsCl6mX3Hre2MaxfaLYM712T02vJkJH+8nn9Q934YwYP8gP5VPcUr/djKk?=
 =?us-ascii?Q?W7wvmT/XyHvI9XNRA80aHPFYZ8pgAml/whElRpSyEH97Oo9LUKlZ9/ALpia7?=
 =?us-ascii?Q?sai4zoWeyuDbnwEO65ekAcEfCkH8MWDSAGSTyJeDqAgnZjPHk8iJNBohlvRw?=
 =?us-ascii?Q?9sKFoLI4QlzbpmYw0TtgiSJc1Vw2VNh1y+8bVyJSvS5GgtKweE/ewvAUd6E/?=
 =?us-ascii?Q?MzrvW1B/OWakqlenh0K2VItlG/n4g4NAen7TS7HwB4pPOQmyK1L0/QxGpIAV?=
 =?us-ascii?Q?6/uA0n6KedRjoCu6O50qD/SzF6ajIJvbnA6jFup5wiHyTz6M2xP6FRAIPHXt?=
 =?us-ascii?Q?M39tp7Ii5rBUZXe2MUjWCJkxk46kGCaQKDYxfOT8TN/AuUZqzQ8T4bMDOp7V?=
 =?us-ascii?Q?36m22bJevVFRZanpZcMN/pq933fHMiTM7ObeR1XrZ4LKSQSkXe+3pjcLLGD5?=
 =?us-ascii?Q?FvJlcTIUS2TVwLu8jS1EgOCZubVpH7uh4OYaSmlIiUmWw0ijFqYBRh+ktr78?=
 =?us-ascii?Q?m/xqX7Z3M83cc2DbBt6M4u0ECDTFv7v8KAjSDa1fvnXGFNWOX61XfgyyS6kX?=
 =?us-ascii?Q?+521u+5hxvydnY2iS1HbaKowdQsJaQSbrWxdkkPVwbfGqr5f+Nw3kG6q/Ngi?=
 =?us-ascii?Q?FERMODX85jT1+jacKnnehLlgY+N8zkWPstb6DgVqTdDL2KK/RAiDEhlVSJaJ?=
 =?us-ascii?Q?1IFV6KN1K7y+ZpQw+mr1xDrlHiZN+tx/tBy9raJBdLHo8N4tv9a99cSs9hG8?=
 =?us-ascii?Q?gR0r4Oyy/Ihi3ch8A39luOOKxDYphYrGkVJgn1dT7YE9PEASkfdA+LBgWtFg?=
 =?us-ascii?Q?aiYO2wo9BMKWmF7+2li7o/Ip/zCEA+SA2RvhnKTy1FBiaiLxBdly/+8EFZq6?=
 =?us-ascii?Q?XjYopBlQKa71pBzYcqB22ZZGBBBwKplHSIrXmR9HxmJadWoNOsKZTW6cC1LK?=
 =?us-ascii?Q?kX6gID5SYjjrE7MiUp5PxWQZM3N8BmFuYi0oEl8kqeansRWFjEnzB0tjskeX?=
 =?us-ascii?Q?3YvukqQD6GRzZZjSOab8q6YVeEWugjWQ1rmTwyA9b2PswB9kFppp/CQuK73u?=
 =?us-ascii?Q?bCKmykdt09Qpi4ZxKbJeJ3UG9OqMg4aQq+JZMBCcC+omwdsMKujqz+bwtJIJ?=
 =?us-ascii?Q?yQJc0izDmoLNDJTOSVVupaWFXUX1dk0cf4EMRjC2QV0ttnGUGSCblbqMi1F0?=
 =?us-ascii?Q?ce0FCOc2HSTfNS7lntNzgT6WOfaX4YNXxXfRSVhShEw7xh36e+XUSqGO+dCy?=
 =?us-ascii?Q?6iSetrkWnb6rE41T+0uQNyiutfH5e6pauN5XGkne31B95/1E3NmIfjD3kvaP?=
 =?us-ascii?Q?mQ/YV9xWv7vpDN8Miub80Xw3tuStX8TMeOVKdOQKu2wZCGcUlPx9ZRBQ7IC6?=
 =?us-ascii?Q?/l9ZCSjzEFLbP79LPMCEWtC1rMbx7owX7Jr0+2IiQtW+jgiFtZADK2ukPgy5?=
 =?us-ascii?Q?p4MmKPIp241i9l7rB0kX/54aMH+diEhzJjACXPXPPMukLDiecQSEXt9MirsN?=
 =?us-ascii?Q?wyXwFO0Kfem36KrKHtYZNrpjo0zjHRfKp9j0rREfYxjKn1CMJRlGSYJ5fzQ5?=
 =?us-ascii?Q?D5RzVvzUWFkU0faK43tcdTHPWrhx4ZjaCjBGLkMmemHgkODC4a99gcPoZaDG?=
 =?us-ascii?Q?PMvYjw9yUdTgRJhv9etbDjn79sYkvRA3n24PvcE21zUHrDhMOJsD3WVI7a5A?=
 =?us-ascii?Q?M9c1xjogJriKl8FCxAWNLsMiSTVDDEDVKEnzYHqjI77qIV1kMfhN2BLOqjZ5?=
 =?us-ascii?Q?7peIusYO4Q=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d52bc19-fdb6-436c-bd04-08deeea64c74
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 01:51:55.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVuZ4JYC5ljpXfK8RR57klLAtGgMrW8gl1ObDGxTktmoHH9qTcDGfT29GAbLsmW5ZLpBbX//EvYV9u5Wa0xJfvmoS5e9Yx+TGnCV2NPeGM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6656

From: Liming Wu <liming.wu@jaguarmicro.com>

Expose basic virtio-iommu runtime state through debugfs so that the
relationship between endpoints, IOMMU groups, domains and active mappings
can be inspected from a running guest.

Create per-device files under /sys/kernel/debug/iommu/virtio/:

  status    - negotiated virtio-iommu features and geometry
  endpoints - endpoint, group and attached domain information
  domains   - domain type, endpoint count and mapping count
  mappings  - active IOVA mappings tracked by the driver

Assisted-by: Codex:gpt-5.5
Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
---
 drivers/iommu/virtio-iommu.c | 317 ++++++++++++++++++++++++++++++++++-
 1 file changed, 316 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..9f2355bcf144 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -8,13 +8,16 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/delay.h>
+#include <linux/debugfs.h>
 #include <linux/dma-map-ops.h>
 #include <linux/freezer.h>
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/pci.h>
+#include <linux/seq_file.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ids.h>
@@ -52,6 +55,14 @@ struct viommu_dev {
 	/* Supported MAP flags */
 	u32				map_flags;
 	u32				probe_size;
+
+#ifdef CONFIG_IOMMU_DEBUGFS
+	struct dentry			*debugfs_dir;
+	/* Protects debugfs_domains and debugfs_endpoints. */
+	struct mutex			debugfs_lock;
+	struct list_head		debugfs_domains;
+	struct list_head		debugfs_endpoints;
+#endif
 };
 
 struct viommu_mapping {
@@ -70,6 +81,10 @@ struct viommu_domain {
 	struct rb_root_cached		mappings;
 
 	unsigned long			nr_endpoints;
+
+#ifdef CONFIG_IOMMU_DEBUGFS
+	struct list_head		debugfs_node;
+#endif
 };
 
 struct viommu_endpoint {
@@ -77,6 +92,10 @@ struct viommu_endpoint {
 	struct viommu_dev		*viommu;
 	struct viommu_domain		*vdomain;
 	struct list_head		resv_regions;
+
+#ifdef CONFIG_IOMMU_DEBUGFS
+	struct list_head		debugfs_node;
+#endif
 };
 
 struct viommu_request {
@@ -101,6 +120,283 @@ static struct viommu_domain viommu_identity_domain;
 #define to_viommu_domain(domain)	\
 	container_of(domain, struct viommu_domain, domain)
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+static struct dentry *viommu_debugfs_root;
+
+static const char *viommu_domain_type_name(unsigned int type)
+{
+	switch (type) {
+	case IOMMU_DOMAIN_BLOCKED:
+		return "blocked";
+	case IOMMU_DOMAIN_IDENTITY:
+		return "identity";
+	case IOMMU_DOMAIN_UNMANAGED:
+		return "unmanaged";
+	case IOMMU_DOMAIN_DMA:
+		return "dma";
+	case IOMMU_DOMAIN_DMA_FQ:
+		return "dma-fq";
+	case IOMMU_DOMAIN_SVA:
+		return "sva";
+	case IOMMU_DOMAIN_PLATFORM:
+		return "platform";
+	case IOMMU_DOMAIN_NESTED:
+		return "nested";
+	default:
+		return "unknown";
+	}
+}
+
+static void viommu_debugfs_feature(struct seq_file *s,
+				   struct viommu_dev *viommu,
+				   unsigned int feature,
+				   const char *name)
+{
+	seq_printf(s, "  %-24s %s\n", name,
+		   virtio_has_feature(viommu->vdev, feature) ? "yes" : "no");
+}
+
+static int viommu_debugfs_status_show(struct seq_file *s, void *unused)
+{
+	struct viommu_dev *viommu = s->private;
+
+	seq_printf(s, "device: %s\n", virtio_bus_name(viommu->vdev));
+	seq_printf(s, "input_range: %#llx-%#llx\n",
+		   viommu->geometry.aperture_start,
+		   viommu->geometry.aperture_end);
+	seq_printf(s, "page_size_mask: %#llx\n", viommu->pgsize_bitmap);
+	seq_printf(s, "domain_range: %u-%u\n", viommu->first_domain,
+		   viommu->last_domain);
+	seq_printf(s, "identity_domain_id: %u\n",
+		   viommu->identity_domain_id);
+	seq_printf(s, "probe_size: %u\n", viommu->probe_size);
+	seq_printf(s, "map_flags: %#x\n", viommu->map_flags);
+	seq_puts(s, "features:\n");
+	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_MAP_UNMAP,
+			       "map_unmap");
+	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_INPUT_RANGE,
+			       "input_range");
+	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_DOMAIN_RANGE,
+			       "domain_range");
+	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_PROBE, "probe");
+	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_MMIO, "mmio");
+	viommu_debugfs_feature(s, viommu, VIRTIO_IOMMU_F_BYPASS_CONFIG,
+			       "bypass_config");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(viommu_debugfs_status);
+
+static void viommu_debugfs_print_endpoint(struct seq_file *s,
+					  struct viommu_endpoint *vdev)
+{
+	int i;
+	u32 domain_id = 0;
+	const char *domain_type = "none";
+	struct iommu_group *group;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
+
+	if (vdev->vdomain) {
+		domain_type = viommu_domain_type_name(vdev->vdomain->domain.type);
+		if (vdev->vdomain == &viommu_identity_domain)
+			domain_id = vdev->viommu->identity_domain_id;
+		else
+			domain_id = vdev->vdomain->id;
+	}
+
+	group = iommu_group_get(vdev->dev);
+	seq_printf(s, "endpoint=%s group_id=%d domain_type=%s",
+		   dev_name(vdev->dev), group ? iommu_group_id(group) : -1,
+		   domain_type);
+	if (vdev->vdomain)
+		seq_printf(s, " domain_id=%u", domain_id);
+	if (fwspec) {
+		seq_puts(s, " ids=");
+		for (i = 0; i < fwspec->num_ids; i++)
+			seq_printf(s, "%s%u", i ? "," : "", fwspec->ids[i]);
+	}
+	seq_putc(s, '\n');
+
+	iommu_group_put(group);
+}
+
+static int viommu_debugfs_endpoints_show(struct seq_file *s, void *unused)
+{
+	struct viommu_dev *viommu = s->private;
+	struct viommu_endpoint *vdev;
+
+	mutex_lock(&viommu->debugfs_lock);
+	list_for_each_entry(vdev, &viommu->debugfs_endpoints, debugfs_node)
+		viommu_debugfs_print_endpoint(s, vdev);
+	mutex_unlock(&viommu->debugfs_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(viommu_debugfs_endpoints);
+
+static unsigned long viommu_debugfs_count_mappings(struct viommu_domain *vdomain)
+{
+	unsigned long count = 0;
+	struct interval_tree_node *node;
+
+	for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULLONG_MAX);
+	     node; node = interval_tree_iter_next(node, 0, ULLONG_MAX))
+		count++;
+
+	return count;
+}
+
+static void viommu_debugfs_print_domain(struct seq_file *s,
+					struct viommu_domain *vdomain)
+{
+	unsigned long flags;
+	unsigned long mappings;
+
+	spin_lock_irqsave(&vdomain->mappings_lock, flags);
+	mappings = viommu_debugfs_count_mappings(vdomain);
+	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
+
+	seq_printf(s,
+		   "id=%u type=%s endpoints=%lu mappings=%lu aperture=%#llx-%#llx pgsize_bitmap=%#lx map_flags=%#x\n",
+		   vdomain->id, viommu_domain_type_name(vdomain->domain.type),
+		   vdomain->nr_endpoints, mappings,
+		   vdomain->domain.geometry.aperture_start,
+		   vdomain->domain.geometry.aperture_end,
+		   vdomain->domain.pgsize_bitmap, vdomain->map_flags);
+}
+
+static int viommu_debugfs_domains_show(struct seq_file *s, void *unused)
+{
+	struct viommu_dev *viommu = s->private;
+	struct viommu_domain *vdomain;
+
+	mutex_lock(&viommu->debugfs_lock);
+	if (viommu_identity_domain.nr_endpoints) {
+		seq_printf(s, "id=%u type=%s endpoints=%lu mappings=identity\n",
+			   viommu->identity_domain_id,
+			   viommu_domain_type_name(viommu_identity_domain.domain.type),
+			   viommu_identity_domain.nr_endpoints);
+	}
+	list_for_each_entry(vdomain, &viommu->debugfs_domains, debugfs_node)
+		viommu_debugfs_print_domain(s, vdomain);
+	mutex_unlock(&viommu->debugfs_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(viommu_debugfs_domains);
+
+static void viommu_debugfs_print_mapping(struct seq_file *s,
+					 struct viommu_domain *vdomain)
+{
+	unsigned long flags;
+	struct viommu_mapping *mapping;
+	struct interval_tree_node *node;
+
+	spin_lock_irqsave(&vdomain->mappings_lock, flags);
+	for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULLONG_MAX);
+	     node; node = interval_tree_iter_next(node, 0, ULLONG_MAX)) {
+		mapping = container_of(node, struct viommu_mapping, iova);
+		seq_printf(s,
+			   "domain_id=%u iova=%#lx-%#lx phys=%pa size=%#lx flags=%#x\n",
+			   vdomain->id, mapping->iova.start, mapping->iova.last,
+			   &mapping->paddr,
+			   mapping->iova.last - mapping->iova.start + 1,
+			   mapping->flags);
+	}
+	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
+}
+
+static int viommu_debugfs_mappings_show(struct seq_file *s, void *unused)
+{
+	struct viommu_dev *viommu = s->private;
+	struct viommu_domain *vdomain;
+
+	mutex_lock(&viommu->debugfs_lock);
+	list_for_each_entry(vdomain, &viommu->debugfs_domains, debugfs_node)
+		viommu_debugfs_print_mapping(s, vdomain);
+	mutex_unlock(&viommu->debugfs_lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(viommu_debugfs_mappings);
+
+static void viommu_debugfs_init(struct viommu_dev *viommu)
+{
+	struct dentry *parent;
+
+	if (!iommu_debugfs_dir)
+		return;
+
+	if (!viommu_debugfs_root)
+		viommu_debugfs_root = debugfs_create_dir("virtio",
+							 iommu_debugfs_dir);
+
+	parent = viommu_debugfs_root ?: iommu_debugfs_dir;
+	viommu->debugfs_dir = debugfs_create_dir(virtio_bus_name(viommu->vdev),
+						 parent);
+	if (IS_ERR_OR_NULL(viommu->debugfs_dir))
+		return;
+
+	debugfs_create_file("status", 0444, viommu->debugfs_dir, viommu,
+			    &viommu_debugfs_status_fops);
+	debugfs_create_file("endpoints", 0444, viommu->debugfs_dir, viommu,
+			    &viommu_debugfs_endpoints_fops);
+	debugfs_create_file("domains", 0444, viommu->debugfs_dir, viommu,
+			    &viommu_debugfs_domains_fops);
+	debugfs_create_file("mappings", 0444, viommu->debugfs_dir, viommu,
+			    &viommu_debugfs_mappings_fops);
+}
+
+static void viommu_debugfs_remove(struct viommu_dev *viommu)
+{
+	debugfs_remove_recursive(viommu->debugfs_dir);
+	viommu->debugfs_dir = NULL;
+}
+
+static void viommu_debugfs_add_domain(struct viommu_domain *vdomain)
+{
+	struct viommu_dev *viommu = vdomain->viommu;
+
+	mutex_lock(&viommu->debugfs_lock);
+	list_add_tail(&vdomain->debugfs_node, &viommu->debugfs_domains);
+	mutex_unlock(&viommu->debugfs_lock);
+}
+
+static void viommu_debugfs_remove_domain(struct viommu_domain *vdomain)
+{
+	struct viommu_dev *viommu = vdomain->viommu;
+
+	mutex_lock(&viommu->debugfs_lock);
+	list_del(&vdomain->debugfs_node);
+	mutex_unlock(&viommu->debugfs_lock);
+}
+
+static void viommu_debugfs_add_endpoint(struct viommu_endpoint *vdev)
+{
+	struct viommu_dev *viommu = vdev->viommu;
+
+	mutex_lock(&viommu->debugfs_lock);
+	list_add_tail(&vdev->debugfs_node, &viommu->debugfs_endpoints);
+	mutex_unlock(&viommu->debugfs_lock);
+}
+
+static void viommu_debugfs_remove_endpoint(struct viommu_endpoint *vdev)
+{
+	struct viommu_dev *viommu = vdev->viommu;
+
+	mutex_lock(&viommu->debugfs_lock);
+	list_del(&vdev->debugfs_node);
+	mutex_unlock(&viommu->debugfs_lock);
+}
+#else
+static void viommu_debugfs_init(struct viommu_dev *viommu) {}
+static void viommu_debugfs_remove(struct viommu_dev *viommu) {}
+static void viommu_debugfs_add_domain(struct viommu_domain *vdomain) {}
+static void viommu_debugfs_remove_domain(struct viommu_domain *vdomain) {}
+static void viommu_debugfs_add_endpoint(struct viommu_endpoint *vdev) {}
+static void viommu_debugfs_remove_endpoint(struct viommu_endpoint *vdev) {}
+#endif
+
 static int viommu_get_req_errno(void *buf, size_t len)
 {
 	struct virtio_iommu_req_tail *tail = buf + len - sizeof(*tail);
@@ -676,6 +972,9 @@ static struct iommu_domain *viommu_domain_alloc_paging(struct device *dev)
 
 	spin_lock_init(&vdomain->mappings_lock);
 	vdomain->mappings = RB_ROOT_CACHED;
+#ifdef CONFIG_IOMMU_DEBUGFS
+	INIT_LIST_HEAD(&vdomain->debugfs_node);
+#endif
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
 			      viommu->last_domain, GFP_KERNEL);
@@ -691,6 +990,7 @@ static struct iommu_domain *viommu_domain_alloc_paging(struct device *dev)
 
 	vdomain->map_flags = viommu->map_flags;
 	vdomain->viommu = viommu;
+	viommu_debugfs_add_domain(vdomain);
 
 	return &vdomain->domain;
 }
@@ -702,8 +1002,10 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	/* Free all remaining mappings */
 	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
 
-	if (vdomain->viommu)
+	if (vdomain->viommu) {
+		viommu_debugfs_remove_domain(vdomain);
 		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
+	}
 
 	kfree(vdomain);
 }
@@ -1035,6 +1337,9 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	vdev->dev = dev;
 	vdev->viommu = viommu;
 	INIT_LIST_HEAD(&vdev->resv_regions);
+#ifdef CONFIG_IOMMU_DEBUGFS
+	INIT_LIST_HEAD(&vdev->debugfs_node);
+#endif
 	dev_iommu_priv_set(dev, vdev);
 
 	if (viommu->probe_size) {
@@ -1044,6 +1349,8 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 			goto err_free_dev;
 	}
 
+	viommu_debugfs_add_endpoint(vdev);
+
 	return &viommu->iommu;
 
 err_free_dev:
@@ -1057,6 +1364,7 @@ static void viommu_release_device(struct device *dev)
 {
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 
+	viommu_debugfs_remove_endpoint(vdev);
 	viommu_detach_dev(vdev);
 	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
@@ -1170,6 +1478,11 @@ static int viommu_probe(struct virtio_device *vdev)
 	viommu->dev = dev;
 	viommu->vdev = vdev;
 	INIT_LIST_HEAD(&viommu->requests);
+#ifdef CONFIG_IOMMU_DEBUGFS
+	mutex_init(&viommu->debugfs_lock);
+	INIT_LIST_HEAD(&viommu->debugfs_domains);
+	INIT_LIST_HEAD(&viommu->debugfs_endpoints);
+#endif
 
 	ret = viommu_init_vqs(viommu);
 	if (ret)
@@ -1237,6 +1550,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	vdev->priv = viommu;
 
 	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
+	viommu_debugfs_init(viommu);
 
 	dev_info(dev, "input address: %u bits\n",
 		 order_base_2(viommu->geometry.aperture_end));
@@ -1254,6 +1568,7 @@ static void viommu_remove(struct virtio_device *vdev)
 {
 	struct viommu_dev *viommu = vdev->priv;
 
+	viommu_debugfs_remove(viommu);
 	iommu_device_sysfs_remove(&viommu->iommu);
 	iommu_device_unregister(&viommu->iommu);
 
-- 
2.34.1

