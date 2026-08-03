Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35841A517
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766076; cv=fail; b=iwwizX4CqikLp6U3g3baXDDsakqCr3o6qJm1lP7+2Nm447NMC4K4TyjfdXOiYTrOA4EAi+iGyu1ux/+ACsLlVDPusfkEgtHEJmseKrkePNKUA0HBuhNR1Sdmebyj1vC0j1nujC26EW/WujtDO9M4xxJTdZThN0TB51M85NDHGXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766076; c=relaxed/simple;
	bh=aNiu11qM+XpRnV3yD6wp+3GcfFPY2+oKEP2KyL0k8UI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D7AWXjy8+VX+jx49NPSRk+Gnh66tSsKyJUbOhE1BM0Erl8iivMFZrblYwGvfmMnWMJpFM8EgEhF1tc4wLAjM+QjiD5+BMpYOO+PH5hsx9Szs+GRlVLNgam6sp34SASJIwW6+OPnyDLRSILYAwltvayKKF23X4N7Qw5q5StInA9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=isx0OV2f; arc=fail smtp.client-ip=52.101.56.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="isx0OV2f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDAWI2ST2iD0LyRn7NWJxPwikPFgcN7fQUqsbpbDXwmQwkJ8nY/oqEJlK1bJfA+6kOIZo0qf9biRs6aAttg8AiE8hx4Ev9ngpLhCkVwfiUmsstn3QyCrN53JvQ7bOPFu5wfBVuhN2Cg2X/0IOLpp7/qKpXB/SCQT7GDGTTy1UMyOYtmnNyT8W+Fbd+tFTrKGSPEYBmgh6KRoXIhy4I0Wj48axnbfHEt0eZaec98bDPzq+mT1+hIjJBvNxCBEkDLN9WozKU5bhRMf0qhLV7XQ9/n5zb9jNXDeY7Z/kIG5XkBgjhoZaIeRdtWj8PQMfbE21O7xaNdcDa1oRSRGdU9dvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsUtdtuR4U2hnKg6LO+/sY+SpVuDwkId+d30tlqx+7w=;
 b=VHwGROHgG4ISiFdfNHlRBg9CvQrJm3s6tHKzIJAVh9X3AXIAQnolwf4yS7o786no6r2HYdZ7PWeNoIigFuV9rZgBRLuIktO97hHRFZNTMde0MPZMKf1SizkFW0mQPr7mxCDjWjuKi8SZ67684xtz6CnMgQ41aaRiS7t/uET9Zezzpy+TWZ2qCOReWQJ78Rye29iN1LKKc/9nZUc/jYscCTvtSSGuPCbKCY1K9WLMMQBpvB5IhiWheDMhksPbU19Brv8BiEqHpK4eRQG/ueOV3UXa6K5cKO2zRhdsYFOBArIFpN+eCmqOpP4xTwsmVW8GdQKTdjDNXc0ZM1yKwtNb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsUtdtuR4U2hnKg6LO+/sY+SpVuDwkId+d30tlqx+7w=;
 b=isx0OV2fyMCmTeQMBywdeVKLN2dCcZsPM7N6ro9ICssAbg0IFrR/obX5cT3uHSjP0p9CXeyTYo8hauahwKxpIH6sx/lshx9vlKCb7omi/b+dgbjAjCjLxjathuKSthxbemZrGtacJJts7ylgjEd/NenkpFJMye0IKRvFajNYpQzqlD9to3ulnW39RVIf0f+Yz/58u61iH46tQ3RzYUnS6ZHYT89TgTu2xWpN//VLkSQ34392xQJZovM0gK2hs7dsjQpvvJSoZklhUpsHzwKDmHnhftJt48c0hST9LjlIynai5cjgFUjCdnl7sqi4NNcnCV16DvVirEDZeg1WT9s3Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:07:50 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:07:50 +0000
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
Subject: [PATCH net-next v21 09/13] virtio_net: Use existing classifier if possible
Date: Mon,  3 Aug 2026 17:07:17 +0300
Message-ID: <20260803140721.1871678-10-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85d11716-966d-48e9-8b36-08def1689a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	84WiGTvMC5aqgDhym6RUF/nuPlcc9D4jtfMPnLZYnvlwd69Mhdmlz4Kjtt3CWzgMC/piwGxu1NWrQDHo3/0HU3Fw00cRij8Vhy/4Qw55AuukkwimPbFZHLpshFFk38AvezAtQ2n1hHcWp5uKZDaLrjBqMBA+1PTutoM+wArsVCKq3ksAwpoyO6kVRUoTQx6Do62LJVJUsIFXXKwWI4hsCMJ6MIER1b/hls3QxokTD3+eHnhleQz+JSlqDGm5wqB9iYnLW/XzGx6F3m4VOyDWE/IHaeNnau1LpJVEyefEW0C6Jy0D3xuOZFgW+RdN4smbqVzTO9H57m588cNpzbOrX9rYOHUOz+JdOFnITm8//ekFRhzRx8dCi7TlsrE4vPAvW1DIAJGFUmacfi15OuG4rrMQlba/cFzqMzcF7UY1cBplGa+PpbYE8izVSm3oidoXjxQwbXeS4mOzIhZUu+7CMeBo2/SjxNrSTRwY0yqS14YMYuXxQYgpYiRxLFoWTIUZWZey/qPQFPoPGGtm/5ZFrd4Ky7gaBDPVura0J/TeeyqEz2TZqMHhxFgwIde7V/SYvAzZajamGaEhsI6qXdHEbBtKBEGNKj2VlT+7QEocf7MTceF2g/OLF+H6KDPbIh0p2bOZHYLXXTl0U9b+5Tz9po8dCt/SvX1hudXi90zJbRo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6CD9v4a4ahOiVz/W+GJT87oTS0eRUS20S/ewRvWg11nEWdTWqXFTAGr0nhuS?=
 =?us-ascii?Q?tTXIfs5BrLmGu28UiApNodZscWU4CAir/pmzPAwu2xFE8aMrJ8yZXaGsx/vZ?=
 =?us-ascii?Q?nlO4pwgryPyIHpDozz4gokpbI1acTi5zYSYbgiDMX61IM4JH+w06Skq6W9QD?=
 =?us-ascii?Q?xVLcxof4SZ577PAmiV4RjPUoCfaO8iktyXlx5rkg6YcOp85JplGzvnZzMK+b?=
 =?us-ascii?Q?wqcf7Y2gZAGaqUeGr0nwAYAoQzv5+nMpvCu7KLzU63dJHG6Wz3JiWpygljeu?=
 =?us-ascii?Q?MnbvlR3GGyvDu4O1U6nvfOyAN8Fu3sI1UOdzXn3fkk77ExN0fLCvxFURXTKP?=
 =?us-ascii?Q?JMHATOHCpOTgCkouOckE+ObVjDbQm1GdMQc36f5gAp2g4yy1SGU32yAzffea?=
 =?us-ascii?Q?A9H/N2Ddb5r6JZB0fwy68h6g2imLFOipNsJWasm4PqgX0Q8TdWjEG5mbbzuf?=
 =?us-ascii?Q?o6OqPfB4bDHBnbp5oTq9T9zXF4EDU+pw/cRpr7xA3XNJ/xyNtstxv+9Eo7EI?=
 =?us-ascii?Q?7UAGDZNuM2Kuw23TsqkNdFpckuS3VBAFwDYbmX9MCHl9XG+Kv2M3Ieui8ZKT?=
 =?us-ascii?Q?y9cNtuHNAhbW7xnz8ISgZDQcIv/zc0JtkgLAmMHwdSQNNW1zM6O4An9MsFv7?=
 =?us-ascii?Q?moPWb9E2wgTJxi6XE3yCYE8CyISzhtmwvvjLtL7INA6LcN7hV7cMdqbnKCXi?=
 =?us-ascii?Q?pbgIIi1kYUcCU9twzRT6wTxaRZ4JVZ/Nyy9PJ7UedmF6IvKeex4M2ExlBoaz?=
 =?us-ascii?Q?V1UhgDFdFh4LKhYcn3MJNigLisflnQLd5obBGR63ik0BDknKXHFILvBtHSwL?=
 =?us-ascii?Q?gr3rE7AJG5KFxImfrnvJ9Q/29aZSS5B9EXHE5Mv5P/pKqT7QQAZg08xKomNI?=
 =?us-ascii?Q?+kqeh/F3obvUcoTlKt2CIJcSYuaW3nahVPoclmdvz9I+HAjRww7NbgRpAvVd?=
 =?us-ascii?Q?KPRGkGpoSuD9v6h7Bfq6Hxp7VNAonnqHEhNidpHvHe9n+VUcybUfpuQ2GdmI?=
 =?us-ascii?Q?XKeVW7j5DGPaoioXtlHvHSeqklgaAYd3JtR4MrMoiRT2ogWtCruG6AToB8M8?=
 =?us-ascii?Q?IVRm+oV6wtputDDMI2E0mxo98oGogIe/KPOu6my6kWUjUrsWwcL0yTyJoPnx?=
 =?us-ascii?Q?Qj3BsH9slKyGGCGEdg4eYvLOa0gfSGBzl5OFCe6rmSoBVFPhyhOcaW/IRmu2?=
 =?us-ascii?Q?4FHaz9syshCKsKcW1k10GGDDs5tTo1u5BkH87XDaapDoSEHNrhHfttagbwCx?=
 =?us-ascii?Q?X86cgjskqSL2A2JVKCBAABMi4cm6CqnwpGklFcKg+BxmoCukIGIo5CQlJBQ6?=
 =?us-ascii?Q?dcorwKl4I0csrpfJ57lPSvXBgDl0Ad9UO8vNjJx4cqty/5ve3AjG+avc8en6?=
 =?us-ascii?Q?UTmI8nJCkZLSJPz+f7+Vb2VpbYRAdADstXcoj9ASCOzxgYTiszDYGOEr88IH?=
 =?us-ascii?Q?ZrTwCPuKXR3DvVztLuwjZ86gQtebJ8c1Upjv5j1ZlhnaiGGDUQAE1MEqSDt7?=
 =?us-ascii?Q?9kWrgxnPNvWsrivRVFBMr13qNok/CcUrV9spYkT+GW+0B6LWQv6vSJZ56Jho?=
 =?us-ascii?Q?4AGEnbuum2oANSkRgNr9wTX8Xeu/ZFvd1DiSS/7JePyxa3hh/UiFO55944NR?=
 =?us-ascii?Q?YH1n5WgPrYxqYFYmu6ScVcFNF5Mrbid0LHJJbfzkaz2T8Crp6iAJzMJCw56I?=
 =?us-ascii?Q?Bjhepx0wKPd6Xkxm52qHppIYkFUWQjPUIxlyG3EXsR4Laks5eet83Ppeslzh?=
 =?us-ascii?Q?nBKMXbggfQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d11716-966d-48e9-8b36-08def1689a29
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:07:49.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMRqmvxF6xMOWLS+Stl0CinOEeubvq4EcgP1JA/tKFCRT+UyPr0CIA6xJuUEkrQck1MjCG41VjaBidKhXiQp1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459

From: Daniel Jurgens <danielj@nvidia.com>

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one. If duplicate
classifiers are created it would artifically limit the number of rules
to the classifier limit, which is likely less than the rules limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2540b9a23e5b..cfcbd8bcd550 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
+#include <linux/refcount.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -303,7 +304,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -5718,12 +5718,13 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
-	struct virtio_net_resource_obj_ff_classifier classifier;
+	struct virtio_net_resource_obj_ff_classifier obj;
 };
 
 static_assert(sizeof(struct virtnet_classifier) ==
-	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+	      ALIGN(offsetofend(struct virtnet_classifier, obj),
 		    __alignof__(struct virtnet_classifier)),
 	      "virtnet_classifier: classifier must be the last member");
 
@@ -5811,11 +5812,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	return false;
 }
 
-static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+static int setup_classifier(struct virtnet_ff *ff,
+			    struct virtnet_classifier **c)
 {
+	struct virtnet_classifier *tmp;
+	unsigned long i;
 	int err;
 
-	err = xa_alloc(&ff->classifiers, &c->id, c,
+	xa_for_each(&ff->classifiers, i, tmp) {
+		if ((*c)->size == tmp->size &&
+		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
+			refcount_inc(&tmp->refcount);
+			kfree(*c);
+			*c = tmp;
+			goto out;
+		}
+	}
+
+	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
 		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
 		       GFP_KERNEL);
 	if (err)
@@ -5823,29 +5837,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->obj,
+				      (*c)->size);
 	if (err)
 		goto err_xarray;
 
+	refcount_set(&(*c)->refcount, 1);
+out:
 	return 0;
 
 err_xarray:
-	xa_erase(&ff->classifiers, c->id);
+	xa_erase(&ff->classifiers, (*c)->id);
 
 	return err;
 }
 
-static void destroy_classifier(struct virtnet_ff *ff,
-			       u32 classifier_id)
+static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
 {
 	struct virtnet_classifier *c;
 
 	c = xa_load(&ff->classifiers, classifier_id);
-	if (c) {
+	if (c && refcount_dec_and_test(&c->refcount)) {
 		virtio_admin_obj_destroy(ff->vdev,
 					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					 c->id,
@@ -5869,7 +5884,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6047,7 +6062,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6057,14 +6072,16 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_classifier;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
-		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		/* try_destroy_classifier will decrement the refcount on the
+		 * classifier and free it if needed.
+		 */
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.49.0

