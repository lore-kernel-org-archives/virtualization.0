Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603CE3E0258
	for <virtualization@lists.linux.dev>; Sun, 16 Aug 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882925; cv=fail; b=QWY+tvTiBpPJN23hn5OO3I1541cLvq0kpiHxB2MzU/UPLOxNJQUnB0hiIClYyuIMLkB/2ZfUwEEIUbCVP+vL9g6r+5tQjeFyfntfaQihUTGmkUHaSCAr6gs3G/mJzr93nrgNcdX7l5jMEyeUJOQqpg0/yl0Qdn8VSCip/7sTtO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882925; c=relaxed/simple;
	bh=NjBazpMyJpCKMG2Qa/rKYTLwAcNU2PGoxI5SvkDq0z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9qjS+Bw9v8nr9X4aP7RIidetZdoK48hgAWnUMDmSt29A3aa5OW8aaFNw6du4nJASwPvVXOaAZcECt/4EX2LHGro/8SiMhQDE3eBuQDEYjXCx62sE0AzsR8lOdOztd38iU8xnJb/jpBfV7rHV6dbr/0dYgpm1pZ9GoZ7ADEs/w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KFgjguC2; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KFgjguC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBUDpqRXfW2HxjdEF73c65xbCAqC/VuNzj4TKI526kd+ibki+waG3sHHngJf1iNCJLDzl9MnsgdoP7X49QiSA5fFAsIE4o9/BedYQYmVlQehsQL+uSaS2sbKNndpwydrQgHgQ2ejkeEvqaSQf6/78dpEQHSBzvUqr62HFTaGfn8PvMwjUCg0U3oPdQiq5/qQUbCDmlyyRmf37ljgq8viuO3nStsbkDFcwcFYi1QtplyOu4GAJfpNN6HbMIvOClkqH5U8KCtmeRJViydeWTaJguvoMLirWSycpvDvEY2mNHYp9EogUPowQXUh6+l9up/+OA4URdGXU2G7gzjU2bMyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0Qx0WIl1yaQWHMGHzD6x6dF/EzqnEY0i1C2V3/dGg8=;
 b=PL/SI4gMbSeg6HVLckGiAXq1byQ6LQuLkHgn9zYXVfedJcRCV2g672ZGTjzLFw92KaoQGNlY18a5h+/QhXMAnznNF97uZiEQuxIBEAsZufwRL5Yvh5ahVkzuhcoUFfmn3wYgbVLMlwxlnCZgOK21y5ZthuqQDnSRtWDW/NjRsImyK7O2trZtQf8bWfS9gId9RHtAXMIiphxKNviMdcipSWBiwmJZWKsQ8XwqGNJzWIX2bHo+2RFESeMiDuQgGEFFwVw+x7eSikmgwvLCKaeUO9m2sUUr15rs/nxwLQwWaT2po9MBW0LMhTvWCIN66jXoeuocXh1yZWdYOmdvNC6YrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0Qx0WIl1yaQWHMGHzD6x6dF/EzqnEY0i1C2V3/dGg8=;
 b=KFgjguC25UfIyVihoF1kHv9zUjeq0ylIl/p57wFbl4q60Qhw7JkntVAp+WsExeN0mHG8PN6uboCwRpx2k9WGrp9P6WNd2hEbjCVB8EVYWwYeSXq2i+zowYEf/P72oyKPDCgCX0CxGpuaPOneFmdS4MKeYgdQ/CuKFSGL/u1QRjiuhu0R3InqwEAuZn6gmNfC2fGCbbFeh9NC5hBkxQRXA1eRy3pNUeQ7XX201+o1ZscPC1mmOredTofpjECHW/ch3J4/hnEWNXumJlFUUb9HN3dcYxlIVu+SE4bMaySPHrUmJYXQqgMxqkRJyLdngoSkEZ7MzU33qBs+xM3ciE/ixg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:21:58 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:21:58 +0000
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
Subject: [PATCH net-next v22 10/14] virtio_net: Use existing classifier if possible
Date: Sun, 16 Aug 2026 15:21:07 +0300
Message-ID: <20260816122111.2495240-11-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49ef7809-4b64-4e27-a28f-08defb90f778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	SBTHIMPKmTdyXFLyaVrgzwJL/b6zhVKssPM9Zg30SxJ9IS6WsOeOOT7kJvaMMhGFD4P1M104bJkhQavGrUj49NYL21eydJ+mnx0WwZKunZqY50fHJC1/uaSQ+vtpl0t2648YKHlqxJI8hK9vhfnBtoVkOsgI7ZxWmwjphIYTJqfO8M6OS79zTXBtmuwdU6oIjM7uZEeliLD/f+NXBeCx50kwHItcV+vbnl8YxUNHLNdQyyJuNRZo3mDFYryr3nSiYmzYHsS1g+cdoJ7AwyV8CN1G+TJXUJn1E1cAJhcbN4CAcBKMILurReNFnBjKJbRM1FGBILu/xjeuHF4t2ax7BdlD6yX37EGvkjABB1Tng0TuLQl9QKU6iTVfQIoSPH/4S/8VtqUdmH02OFU3HhVXiezvnQgE2Gu8Rnh9IYrYjnZjDcJOql+nS2F5fv8kitSESyMt0u4cDOkw/Z9BVdBdYKttqKMr8PszKm9CuwAGYxinmY3jSRFtvx0Hj9U6ANhFIKqxzh7wi/xlfbGrPd0HyZMyOCWyg5U7ttGibqfgvT38z16me/viFjewP3cRYtRe6xwyJGduPxdIpM1VByN4nyB3kFY8iW4frQ06WOK5RiSK0t8e0N6usm3C4r2jXIflkmo6iIRT46pyk6arI7tAwR5ExSWtlGKbNrz1ncBG+xo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q74OCCN9D8GWfHWHF96firG9ojBW0EySy8xFzHY9Oar8hfqNR+ZOv6Xy9Uhj?=
 =?us-ascii?Q?s0h9/qk4Tloof6v78Ae/CkT115eokTe6lWPuS10+WIgCxJtc4xp37KrPfckj?=
 =?us-ascii?Q?v6E7xwQckzM+XJeDem+Ql9Yg+uZPBD9gAh57Clfx1sjytjnRC/nTJ372N+Qt?=
 =?us-ascii?Q?Mn4epN/R+ZyUoVkGKC6mQNiIpUR3P4e0kaKMuBQajdClZbPPjg7+sNpKNkrC?=
 =?us-ascii?Q?gEX0+pKTDiL5ParfxT+d45dBK7Bxgmdt7ywNEh78XGNl5iGKICgVgw9SR5/i?=
 =?us-ascii?Q?J+zx9ZYhnYUuMm62IqnYHboNrmyfZ5Oj9w8IORzY81TX15d4oLmOkjVo6bct?=
 =?us-ascii?Q?WWLn76nCUg7R/H9h8S72jPhvvOnOxnwC0zPAm57sSPyOcp75t+p1MWmCBuNp?=
 =?us-ascii?Q?9ZOCledVqzN5A+R2m3KDyWCTsUKaa4cFhDSGyQnIQdlhBm9d2YOrK/i0nrqO?=
 =?us-ascii?Q?AnZnPTHyWNKN7+LcM9sCaweVra0nBa9/P0sq5DMT2LxlxGunL85Jl79l0Tjy?=
 =?us-ascii?Q?Zuzh/Pge1bV0pCyIbZZ5yivKP6a5g1aNkEdRZC3iQKjSUMzix9SuPCMaSk8v?=
 =?us-ascii?Q?UtA9vDaE99/BjNmy7ZC/ZCjDqDmDBVKxMZ26VE1W9qZTO7fMNYDU15vwoSle?=
 =?us-ascii?Q?k5Z0O8uhiqIXalC8g93H+LwPgF5IzPgdyphnVsoxPQo2U5KR1VO2pTKBkgAm?=
 =?us-ascii?Q?0yhlxVIgh7SHYMFkSucl1DhTYJvF+Q7nRi/UED7La+Fc8RLBMrkGmx2mo1EO?=
 =?us-ascii?Q?Uv5xHNzNAiA0vqr9RK2UM118ol6w78kkmIhl/mimFbS6gIcgYVAKDJ90aTgC?=
 =?us-ascii?Q?5X4i8fF4gSMMhDtNQKDdgYwwFSV1diwuhl4mDQGVG+b4trvKLgN2NFOZjnY+?=
 =?us-ascii?Q?noV6YRifzhvoGBUeENjcv3BOkxHCI0YIeUepZEQMiCe12/QOJv1JRwSFWgs5?=
 =?us-ascii?Q?xuZik7FI/1d+CB41+yWItcs/LPcAXQc1eF8v+4xlj7BsQ3MvueDI5R/j45SH?=
 =?us-ascii?Q?sZb+Pk75uiulRgiMZpJFg/GV9BPVLeL6McbBzusXKZUfgLp8n1eB02Kjzl4i?=
 =?us-ascii?Q?VprukqyuxpJHJApMWmw5TwVCSCV2S1KIJEXrd04k/yhrTmU6coVummTcRQnp?=
 =?us-ascii?Q?Xw878P9TAacHAlnhx/OnH1KM1Ebf78lWPTEK9ydqxXtovHTmB34/a1QNgnNn?=
 =?us-ascii?Q?dGTx7NnG/lovOxqOMrEHUOjpZjbp6IA1twL8rBMq7KCg2X9r/f7JhSweUFnr?=
 =?us-ascii?Q?8d29eioUdZZYFUGhgoW2DtxSKAZ4sUawjdkcVuCT1CXLetYDjPimeX6NEIy+?=
 =?us-ascii?Q?YASARm+YdT1QjmHQewtr63k3jtvQvsId9yUTpY8ohY/MFzunqcZIFijpqqV6?=
 =?us-ascii?Q?dejjDdHyEcOH7m/Bf37UxVY9ihBKfFnOV572F+EObp6R1ZGB2M/2cW19pkGx?=
 =?us-ascii?Q?TPq3JYyKS7IxWT37dYUwBcOmUwpzCXh3TumNUALLOIYDaIuyG+eXVNirwLAK?=
 =?us-ascii?Q?yu+SFaLyiwZh3c6BZJiyRefz9XBnvs4BzjvxwIut9eAQKCdS6nJhgqAeTN0Z?=
 =?us-ascii?Q?Lx6tYK0miFFbtFyGxoG9bbS4r9jxtXFcIwiuRvjMIBR+kISzxBGe5iPsgIs6?=
 =?us-ascii?Q?IwBy7KtarTL197pg+IXSvbvRymkRfN+hOgfCaxkkX31WXYgyJsWHNZ82UpVi?=
 =?us-ascii?Q?Bl8A85W8ydJ2ySMr+ETCEsrFLiJCdEDwbJ2jwW/ZJzp+7vkNcp0UU3HSuc1E?=
 =?us-ascii?Q?m0gzD6Zkpw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ef7809-4b64-4e27-a28f-08defb90f778
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:21:58.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q705v73Ndw7gJ9TqDaXC2vWwWIOTsBcObcJ89FQYL/nJbz4+LweMLK5tctomLgMZmC0KynqyoAly5bLWU5Xvow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

From: Daniel Jurgens <danielj@nvidia.com>

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one. If duplicate
classifiers are created it would artificially limit the number of rules
to the classifier limit, which is likely less than the rules limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index eb2e5e92c786..9d58ac0b96b2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,7 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
+#include <linux/refcount.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5716,12 +5717,13 @@ struct virtnet_ethtool_rule {
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
 
@@ -5809,11 +5811,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -5821,29 +5836,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
@@ -5867,7 +5883,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6048,7 +6064,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6058,14 +6074,16 @@ static int build_and_insert(struct virtnet_ff *ff,
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

