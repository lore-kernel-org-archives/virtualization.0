Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022075.outbound.protection.outlook.com [52.101.126.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E526470432;
	Tue, 18 Aug 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056610; cv=fail; b=JKcfdlwLm0dlXZbXrJFrRxEglwGa2MDGmHJZIVO7EDiP3QKlEbR3/km7MJeQk14Jgf4/nBTs34/nI9av+TMWs3Q+cCCzS5gXX1otk1fld5T/c1+hfihEbr7MEaxActk1h9Z1HDbpKAZ5nvN3lal2OcT2oryrvoD5krciAR05bD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056610; c=relaxed/simple;
	bh=MHiYDdEZtLdHopw5cfIcCa4ymBZ16vyI6Cs5w6uGv4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t8hRN6N8R8v8TiNOGcEz633YXHLJcNLSQ4LdKloo8/PPflmxefBK9Qg71ZFzNIi1pG/pEIHkW01zdA6SiNEB5KdwlFGp4h4qrYbIinNyAp+zo5pUO4PjlKuqjdBm7biTZfQJoUMbZSpTvF6AgBGwUJLwQekhcuY70+ghGJ3EI6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=OBykWRDj; arc=fail smtp.client-ip=52.101.126.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="OBykWRDj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGY0i5jzTwE9qZiSDg5QsrrKwHBeaVUC54VXMvZsHE6QMmNc/CzemZAbYtnzExfymQbrIHzKD+sHDdyfoC8Ypa21gzbWH3k6gx1YilM+8KNzqZOdW2s9ZkUg0Zmxv1RolkMgnuiq0OtuukSaGa8UU80BkOPeazFrHuZ8wbkux1t3fba4WuyNr7a6TdWidLa/pIG0jpUVXHPfo4kFVNE9EAyhm+202z0cRlXFMogKWgLp0QB6Y9GTxf9ELSYCCBfmR7IptRygfvgntNuh7Aqy3Y0tC5l+P/9x+T+qUAl/HSKSs4vHnqCeqfvqQ5CpUfwUMXbFhA3bCAORp+WhIXXEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSCYceNFfNdZKwqgt5DYi76GoQjriTjEpxnQT2vxMGU=;
 b=KHptQPm3vFfvvMhuQi7zxqddZxPgVMhxc8kE05uQanTmIW2u/39EjWhHIcW4DSrN1Ek5QVWEe0LP36j10YqnFm8/+3sVhjzG3DZtoRZ3fqZRFmodAwtynDCCDtPwVWOV27qqh+ycqI+y0blzf77DlRDpA148zzUbMZO2yOLEvjXYaYI1az+7l1pCTl4coPo/gQLDkzX74c/IHsEZfy8iCstPXRloOv/T9xio9qQVadpoRvyAbzZzyynewwhqqnFdNgNYAVsAPgXXEQYQ3xIszkTmkDwGssEKQfRmrHmgm9hNS9N5wPaAYCbCLH/k+6L/85+mlz0OHPJeqikDuHV9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSCYceNFfNdZKwqgt5DYi76GoQjriTjEpxnQT2vxMGU=;
 b=OBykWRDjwGiGwgBfBZdSnLOlMVi5HczoSjFGLPSXt/MTkQwJnMikicoiZnd252nTNFyqxmkKiTfrHQem/SdO1ELEO90PWMKCS0oDpoEZCXmtNIS7o6XGLWAIqvBzLzWnh1uPkRrqaojF7NSCR7SB8JaD1YdxWBSyCfFC7g31TR650BImxNkznj85Bm0/mTDLt3u1bPkPfcEa/o/ekrPgll3AaQzEFhnKB4fKtx0mNX10N1dQAurmal644UgEzz6FxriuZmB6j2UpnWToW1a/3A0kobJEdIM7MAQnlnajGan+kE1kO7OQmxSoyQkhVsiy+hCrNSFs64P+s7zRHxV7Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by SE3PR06MB8016.apcprd06.prod.outlook.com (2603:1096:101:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:36:39 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::3dd6:8bad:93db:74a3]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::3dd6:8bad:93db:74a3%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 12:36:38 +0000
From: LiMing Wu <liming.wu@jaguarmicro.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	Angus Chen <angus.chen@jaguarmicro.com>,
	Liming Wu <liming.wu@jaguarmicro.com>
Subject: [PATCH v2] iommu/virtio: Add debugfs state dump
Date: Tue, 18 Aug 2026 20:36:18 +0800
Message-ID: <20260818123618.637-1-liming.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.49.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To PSAPR06MB3942.apcprd06.prod.outlook.com
 (2603:1096:301:2b::5)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB3942:EE_|SE3PR06MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4307ec0d-e394-4a33-8986-08defd2558a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|23010399003|376014|366016|38350700014|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	J2+cyCW4ROURk7QJUmzDRy6mmWi3v1c6jdnSfRtcB3G3gBSGvksbll7UYhydNBv3l8wTAG1giMa1+D9hctxCVRJVxcvkluHoOm6Yew6s6nXR2w/wjttxQGhExVBjytqRcj+AO5mzcC7tEZS/PkPJr3oFfumzF7ixF3Mq+tQZihdZnwcYrXENy0JwDsPBRc0a+fCiIVSZCqDU6HMM/Lrw+FPTYee4ZHpCsVmi0enstolysgoOh++qBROWIKff/JlpOioOVBeUHxsuq+S/3hhuof5ghwnxhao6Ii/cFMsd1ZbmGz1hum9z3yz9LLOzhe/7Iw1gvTVecZTNjtsRIXoWQsqTFdJwvHDbMMegpPAaDrdkyXX6HayKauCYUGrAnTue1M42BG97pXeqSQqBtzUB3l9zbui3L9IgpmZn1G0gh+g6Oqh1uccmAlZ7Xr3oO0GPGuBTkwjQ2rd6XVcNJo/5J5cNK4oVmLZB7zmn9iNgIP4HQtxNIIX9GjHkTDlsLxjqRSdygPbNeGcCIuUNMVFIYMwK5HUolOji+3u/hueXC0LSVft12Qj3F8N2aoOz5WCxdS1ddNl6h2hdifWiaCFbOQouC8QZ6GqiBTTS8O4KxPnYfWBWO9vZB8/UtP45p5cX80P9/VoDof0Umc1sSlW/NVVIFqp2CeSBBIDJ5DTR1MLHBe9Eg6HJWjYX8w1tZx+XeHJ423kZfSnM4P5U4cvapNDVSlM3+JaTWThD9YLVa1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(23010399003)(376014)(366016)(38350700014)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZMPaK7fkQt7IMtHu28fqBFDWxt28/tN3JyH9RkYUdRZRv1Tw/FxHzjQKkbz?=
 =?us-ascii?Q?UEo93AEkmE6l72mcRSQLr4Soz31c8UKlVlsjcbeLpGqDxHgwUi4gwqmlhT6C?=
 =?us-ascii?Q?bbvDzWJDUcZVMfex0QYasafLHdPaa/PPBLK2zCboU+Uay4p2Q021oDuGGxFJ?=
 =?us-ascii?Q?+4WzobsTuB+bnidpW4dthNXcCsWDDCe6LmBH31v3FCwBZzgVf8o9I1NE5ig2?=
 =?us-ascii?Q?CrIHkhcOI3akbsvawfwmfnLSm1L/MyRJsvC74M/xAcSuYsuPwEEIfBSWp1vS?=
 =?us-ascii?Q?xiCIMEosxXU5+YX2xTQz+Kn/KfgxPuNT71a6gwBJoZKIvaybzN/SevU/564y?=
 =?us-ascii?Q?COCSoaKKBidvIUPcdh7Q+IOSIkE7iA4A+QpMB/OXDWkgAFscxcgyCl9AE9LO?=
 =?us-ascii?Q?d41nTyB0573s/bt4zP/tJpeSQteuZZU2Tofhq9Qi2/duZwAL5WTFE1gbtiwF?=
 =?us-ascii?Q?4T12yDUJlQ9Q5h6xvbpDv/52Glrhdlj/cmmOD7H2HGNB0KccXYawn1wy/Xyv?=
 =?us-ascii?Q?ZgWPjsoaq32ePgqOcLf+1yPoCnrx6t7xX6e+VBAYCYeTGrCk5p3Ed6XXbqdc?=
 =?us-ascii?Q?Anfvdk8AOSUtARB57hGov3u1PqRrI00PqjrDGDWLcpCUgNlZJSGr87fi5uWR?=
 =?us-ascii?Q?qoNUtP5hI8MSx1R4CNNdaSCincWXDmRT6VR4xgfYaz8RB61kKIKcN7M+2YSh?=
 =?us-ascii?Q?KSyQXDeMsj0lUjk1xh5gHfQdHVUH7DZ0167R8sFjQCRgcmieShk1eJ9LMnTO?=
 =?us-ascii?Q?fY7uGLmqvcY8GWLial9n+QwvtK9jQyhmqmY1iNcD1QgrcoPBaFRLEIsqiESO?=
 =?us-ascii?Q?2fC/jNi+3rhy9vhc6QDJrD+9wm3xpo3a7a3d7VuBi7bJ99qXtE9Z0KQHd5r4?=
 =?us-ascii?Q?6kvhwVfWAnh1wFoY3ek5vZkkZKy4osnlmbvHUI44vr9XlC+zZe0UJO9btwLP?=
 =?us-ascii?Q?nWmrDcJcHcYAfK27K2KBMnIrnIueaU/C0NURuBmo+r0txEsG08BEYFkn/Wsk?=
 =?us-ascii?Q?QutgCjS0Pyo4jyt/Xs0AdLNmZuirk1WjHNCeGRmuVF8WmF3Jx2I2ff6X5Snr?=
 =?us-ascii?Q?nwGzfLCyuxO5iLgrZTW/YQNLKJVsXoj7M68cqgfiV8I2c6yMQCJjN0LMijE/?=
 =?us-ascii?Q?EJlkuPhURWjYww76nhekZ12Xd/ev6Li1Z25cp8LFjheplmAgvcLiQqeh5XPl?=
 =?us-ascii?Q?aXj/hpk6V2Ssr8Tnx5pqFgZotk/MSKc9teRr2mzyGhRJOuYh09LPo2/WsxFm?=
 =?us-ascii?Q?Mzm8w5s8gv1sG7yzFIEx4M0vQ4hkbaKMHpiOMPwis6dTDGlGrlBPOQs6F+Ia?=
 =?us-ascii?Q?DyljKbjV4i0MLvT75GCvVpxS/vKwLhE/A56fuzXhODMBzDSLqF/CThSBaCwQ?=
 =?us-ascii?Q?TDd65WwIAJ+1vu87me7CJEVZXprz/OeuE7BmVxmtU0lHl7fEwO+vAKSjX7Tr?=
 =?us-ascii?Q?1tsxtuQG7hkapMgjDtcy9XRSJP73QUrjweSQxRByx48aBcLbTvtN8D0m0DZO?=
 =?us-ascii?Q?5l7cG8IFZrewWFCV+SAnk8MkGVBs1WFxE6F7j7wxYL6ZsA7igbY/zcFzLoSL?=
 =?us-ascii?Q?r/jjQo3N5MEwfkCCnYAhHrjX0WL/NlisnpydvkaRBFoLblEC7VltnG8R1Oky?=
 =?us-ascii?Q?Hqs5jorCVJ6eo2r3W77yCmPstq4zyub+5KLBwb+nf++/bnO+BY9tIM7Oe7Va?=
 =?us-ascii?Q?Os5MhOGK96oVOFXzcHEz2N3QICFK8lROZBQp31zE5KnXvzFfBftJUcNKHWwi?=
 =?us-ascii?Q?UBA2T01geA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4307ec0d-e394-4a33-8986-08defd2558a7
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:36:38.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5jq+kvxi8RDMuFFZnUpO+E5Gyglqikufmp3s2sXfi9wr0JPxD9YXtRs5ZgQu8V5AR0CQQzqtdwEO/LayM+X/7RXP4KvUq0QGVfGfpNATH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8016

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
v2:
- Fix i386 build warnings from kernel test robot.
- Use %pad for dma_addr_t geometry addresses.
- Use ULONG_MAX for interval_tree range arguments.

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
+	seq_printf(s, "input_range: %pad-%pad\n",
+		   &viommu->geometry.aperture_start,
+		   &viommu->geometry.aperture_end);
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
+	for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULONG_MAX);
+	     node; node = interval_tree_iter_next(node, 0, ULONG_MAX))
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
+		   "id=%u type=%s endpoints=%lu mappings=%lu aperture=%pad-%pad pgsize_bitmap=%#lx map_flags=%#x\n",
+		   vdomain->id, viommu_domain_type_name(vdomain->domain.type),
+		   vdomain->nr_endpoints, mappings,
+		   &vdomain->domain.geometry.aperture_start,
+		   &vdomain->domain.geometry.aperture_end,
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
+	for (node = interval_tree_iter_first(&vdomain->mappings, 0, ULONG_MAX);
+	     node; node = interval_tree_iter_next(node, 0, ULONG_MAX)) {
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
