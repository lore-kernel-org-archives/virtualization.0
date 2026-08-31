Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974993CB56D
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163126; cv=fail; b=PI6huTmzBrd+HYr7lE6m0jUIfFMiK1G0oX0BYerjn8LDRVHtstPM81GKECGaQiIqLwby6hPIJNeLVsBeTYUtXMEZxulVzBD61MEwZ5llr3iQ4dMW+hdRNzqStjqoGjePtgB1yb5FIyhQmV67HKmBjwYeX2Yv3HRk1KVPLXRKyhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163126; c=relaxed/simple;
	bh=gUnUqbDApvn6iicskp01BCD9KI9bQkMA1q6FRFIF5pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hPPguKFVrXnT/WeW16br+MQ5bxCy5DQPnytzkhDQqsrUW2y6V3A0n9wHjYrEdyGWc+BgpyRByoWQCvjuNUTNNnyqDYa166FZhR1ePKvYi+/RFHJ3CVZPQS/kQLsip8mCQ8wFcRY62QH1bKKnkQFtFHSXP6JYObfrF8BNTY/VshE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F/cAhxdD; arc=fail smtp.client-ip=52.101.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/cAhxdD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPItUd/aF/GC/gr7Ozd7R59jfAi2M9ngoGQpKtzMFG+H3ugofl+GvovN8uT+MWPGqhZQhEcpvq5K1P58QwTbMNtU3Mw9MmYATCZvsiW3d6sInMTkdXuid428hXWFQ7IzYE2YMMaDDoRqBDL8tiA+mqSkUco1TbHApEHDNnJOG6re+hPW71WnYzO9tV5qi1sfjTSeNcqJjbh79lbVlcYCjkqgrKfN/zx2W+vXQ8jkbsFs+cNX1Fp3VBs6ln+5xckbHJ8kUCLSUReVqTnIm4Vkx9yHnWgtnwI1QBduBgwuiv3FQQL89eKgSMOE1pTEbo5WtsK52RvtCHUMHM8znTzd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYPTmnfwOLUhjJ+i/ZJ4DhZk+4kDXmLWydkkld8gbVQ=;
 b=wUBm8ZTyTwzET5Su7ud8gdSdXJVCCfbJeDq+LoMWhAIyY8AF4uTj6O7FL5Pa8TzqVApwWJXvW7M9Umx5L5OY9yXgit1vXdQVyAZRGymWoGCgxuzcjh5+Cm3JEzSCEA8ne7oLDsb+go3ztSZW2saWGygf2KBHKQZF6iOACX9FX4Zkf+VZgwZR+5LApCnBsw235gStW138+8IFLtCw0GnpuRGEXE2G024BhIJr6zBS7BIs2C/mRlHOqL1/F0lJbfceBqeUBF+9BT3eYoOTo8XchawLf9vnWHiQ3a9s72vH5mmxVXbxDwLuWdfKAjD13Ml1PLXI6Ly5symN9ve2fL/Lxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYPTmnfwOLUhjJ+i/ZJ4DhZk+4kDXmLWydkkld8gbVQ=;
 b=F/cAhxdD8oFFcHIbVuQXliwDmo/uFYb8IBwyJdPgAKmvB9FppYclqiH/um/FYPUT+E7L3sCNtzQ0g4X+ZYb7hC98Bvq18AkUacarYoPtjcdq4ikvQOYJTRqnkMfN3/mEQTyCFi6lOsb+mcr/CxZblIO5CmbxmtAnxLqe2pGmlThYNrWj3usJ7QSyvjJh6fbvC2ZJWXJTOPrqXKCJF1XBo18Lcy5fHikvG08jBH6svQJHYQ4F6/ggN5fglOcS0ERlFRDO2nW9ARkqXtg6gtIA1n6efCZ+BmZA6RcIY0FgTMvSkVf+mZ+x71oobA5h4cPfy0pr6hUrmNYoDIsn0AlMHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:58:39 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:58:39 +0000
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
Subject: [PATCH net-next v22 10/14] virtio_net: Use existing classifier if possible
Date: Mon, 31 Aug 2026 10:58:03 +0300
Message-ID: <20260831075807.2891426-11-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14a4705d-f65c-4ffc-a3ad-08df0735aaa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gmE4KEeA/yWeCGE+sd963h1Hv92lK/ig6jw4TFepsvoTKHH9JoAtYJj+9GaptOCvGA3M6yiNYqYuXYn/J0y4m2kgqhJobL4pbVk0sAtLSJ2xFKhRy0lKVAKbXucnRyJGl/hKX1eBrRgZynkwz1KY+t9x7J6bKrZ0RGccPd5pmc6ECVWSbGMmQ3bhwj81AzGJsQttOFX1mphUsgp2bv4aMXJ7ZLq0p31Nxognv0AqpKqwOqkck49OCSdogEjjp2tAr7UIN9dqpESHKcIP9E0aBbedVcVodPEOvyBUSqxrseZeEnhYNzJS8NhciMdDfOR+VpcEv3PIce3SxuL/6ou1tCPadV1gsWWJIR2cRALmJ5umOfRfcmTpRfDo4ru1G0R07jhjQpNVQ/k7VdopkvLDr3yeR8qBU2ZDTiAh4g4n7d2lWfWqmzjiKZxZesWHdga+0/CM/XcpWCxiqoUSpNh4GG1iikZRAEBO2l7Cw6sxWdkTV8+WDWEF0nukbXax69v7sC2ZqPCYqfCG+KiMvHbqg6clAA5tPlYbc6sJDmIn6nW6TydhfqDirjerYycxLPVVUB+Dk8aD/+W5jeoDznOwZEkHAqsp2JeyYgBvzuIihe6vabv82DXcH9g9ykkZCjT60xu3zH8rN0H01Ebj3QiGJI6uiFhilTncfyV3zf6Mp8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yj8UBQuMJbYHLCbSsFhTuCpLAthCuEgZISn/DGipXV14wzDh8snAGvB9P/Ta?=
 =?us-ascii?Q?wrgEEXPEXeBnoqKHYnhh4enb26wQDPCxD9fgPmIo4QrYdo16X9v9S/mNot7I?=
 =?us-ascii?Q?ykO0G/rRCZFu3TqHIfk7uN9dTxFxWNXRhqPPO72EX1aiBl9WlHtceVeB3HXB?=
 =?us-ascii?Q?U9fzH11IShq5fDWl/0F1Svlq8g5gMM/x1vLHccPjufQy18nsgYk0e5WhzWxj?=
 =?us-ascii?Q?cQ1c9qUpJZ2saLTXPXdbDhyVIx/mJ7O8fY7JSKNjktwwK00lgRBXqLf+rp6E?=
 =?us-ascii?Q?UE2NfU3n7S69+1PxZSHc3qG60B35huIjK1TiP+LyfYpA0RyuXPS07vS4yzNZ?=
 =?us-ascii?Q?UrHa7gGbkxl8hpxkPHSPdFg9h9ErieJuZMLh3AOSshny4La6QEgKzbDSOVSd?=
 =?us-ascii?Q?8izYsJ16NbFFGngUd/6TpFl709hc91SD2bvqcJbP4jTzlamVNehG2Cg0r/K+?=
 =?us-ascii?Q?JFy0DMuZDnDlo5fAboZO8X8x2G4uHBuYS1Z3kJCpNcBp3HSEhlyiJkjRhN7T?=
 =?us-ascii?Q?DQi/KNmJb3qovGzr8/0w42uYroYZX6YJmGZik0r/kpR7ncpr8UyovjRimFU+?=
 =?us-ascii?Q?AtFSeT2j7rlTizGdjbDWk4jeZDKrDWmt5ekOLM9/J3KgRGUVBbD8pxzHr1KI?=
 =?us-ascii?Q?AljXEa6PNuZFxniQJ2YNTnuB/q7ztWGUgGFkFrPAW5qcuY6k/y0u8dnkaeD9?=
 =?us-ascii?Q?xdg8z1dB3+849Lbm527AOjwf5KypbEeqo4rH0uJ8EYYcRzEFt3uMqqFZGZqR?=
 =?us-ascii?Q?Xo1BWSzipHpQh9hk2I8xazFS8DiSgoELQq4tTgtcEXpa8HPanEY61mTMyPQl?=
 =?us-ascii?Q?V4Kg78bxyBez8ZKUFlRmm7qMZMLu7kPqBM9zQ1Te1c+bzdvzZSVTq1ZzOT0u?=
 =?us-ascii?Q?/jS/j3BJwyRQmGirJjE09G3FTt1qssf9NYNgpbL89YbRPRvixS9/+pVLwfc0?=
 =?us-ascii?Q?ef1ZIIOH0Hr6Scme53pq6GiPoE5zUcKxil/IRsPWdz0nFmVZmDE8FA5eUa20?=
 =?us-ascii?Q?y8KGT/qa0UfNhnHbt1OEW+StO/slG17hwwVubu5A1sMQ7fHUocErllIf63fd?=
 =?us-ascii?Q?PheNqSSFiB4eshLA/b7Tqrl+su15Rwc5D47r+GpPjQvfe7GROynm6otA6c/B?=
 =?us-ascii?Q?Pqq+8BRCD2ZIMxprrMdGLhB/QRGwkTkMGFQij8KjuPsVX0X+k7xzaTfFIJ9k?=
 =?us-ascii?Q?2hE/lSOjj2zEUL493H3jK7Uhe20wTTCGhDKOT3S+A+tiUz1QlZpisEeZKfhG?=
 =?us-ascii?Q?q/Nsm36AhhvSucUWg6Ls7ss669f69ylwTNtEkSLZWQxtmS2qm6DhDb4Arxb8?=
 =?us-ascii?Q?JgEPxGGf5/WKxIUoCNbO8Ud7LM+xbyj0arZTVhDO4CEL3+eW+xz8gggkmbXN?=
 =?us-ascii?Q?ZzkFLHFLgId4FkDNti76RlUDsoZtc3dHnMhh8bcaYLuIHLmt8xwhlr9c5d3+?=
 =?us-ascii?Q?hyyUdpWPVn0TFw9uS0y1SBPCtPgi7nujT0GzdBUBbId0/loFm3ycGMrqlktj?=
 =?us-ascii?Q?1/wUW4ESjybTTvg+fxDiJrjPtldX76IUuCxaW9oyGNKX20nlFlPlhL4VRzlL?=
 =?us-ascii?Q?qMrliNvpTNYPLFRb9vMGoDC0oGSkm2uexK/Mgn6mr9+iklWa1qQDuRIqEue5?=
 =?us-ascii?Q?qpBA95u5Nmv0omAD+9nEEsICR8bZ28q667Oto9KeXR6bC/a/sIk3O8Q34ZwM?=
 =?us-ascii?Q?63CRwPK3jaoHVR7xiFZ7S0VQqTrzZX+8YOIB77U/zPIUi80B4tqD07POvdLk?=
 =?us-ascii?Q?hKwSc0EJrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a4705d-f65c-4ffc-a3ad-08df0735aaa5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:58:38.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kts1wvGoTIUDr/1Yg8V0hBIHOj1dX51qGq5e4SK5NHlW6qEMJc0pkLgDTnayDhlUdd2B5NHs4tJ3UGE/g8P1Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430

From: Daniel Jurgens <danielj@nvidia.com>

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one. If duplicate
classifiers are created it would artificially limit the number of rules
to the classifier limit, which is likely less than the rules limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net.c | 50 +++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2596f8c6274d..72c0f40e7282 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,7 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
+#include <linux/refcount.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -5730,12 +5731,13 @@ struct virtnet_ethtool_rule {
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
 
@@ -5823,11 +5825,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -5835,29 +5850,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
@@ -5881,7 +5897,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6062,7 +6078,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6072,14 +6088,16 @@ static int build_and_insert(struct virtnet_ff *ff,
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

