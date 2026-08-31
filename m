Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508847F2DB
	for <virtualization@lists.linux.dev>; Mon, 31 Aug 2026 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192700; cv=fail; b=LFlPSIBCOsPbdHB///vscEBBijtoXoOngxOikRDF86IWAnRBytQgQNkqrd0IZevxD9BYwZKX3A+UXGNUDA4bgnIduFnXt9NNP7v4aCSdkxrJiw+mG2E3h1b7sZSZNuLxhYNX0yISyz5oPiEyMC60JHZdzGYI6XqUTAjomitr7JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192700; c=relaxed/simple;
	bh=rWmrn9odrMGyHivqO8CpLS5K/CX35Hb+BT7hQEjofeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxNNCvCd9fQ6lWv6B/EOWF6AGz661De44l+0hPpLAieVDeq9+SpnQe35fsPcz0TCS+/azUNidy1BIvdQFfimdZ8f9T5zh8WersPRbJfcL0uQHOKjUeAhxeqZ9YEVXN7o4uzfpdtSInBhQ3CCQrQDnMi5u3blOVMMY1K8XnF4v48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pkZw668B; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pkZw668B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNdfN7ItKrlWVg6wAzh1ziFCG0TdWb6hLAz8sPQx7DcqxWTlYISreu8ILGhkw4xZptSqBYTO+0h1am5SJaag9Lex+C9VKgKl8bXEuxQOInFsE7fC5aLd2EN21CVmSVCSHjREFCRn+Wk/hjj4WihqK8uZslelsacY6Wlt1t2iq8bpeY8iJEQc/ioqx0YLnVPd60HidL0MZqJA42jm5slE+vJdKPJXceZlP5qf7eI70VUqJU10QDC7+N6HqgWJwa68suDu54PnKnAdxWcnttUiL6ifF9Kmu356wY0VPq9n6421rtPZY+MsMWvXRJHXWC8npyWQ6sIEkAZVKf7JBuidvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PG9QsLqG75gW/f4TUE9ZOwqkiHvmYKu2y8gb5Yr2T4=;
 b=bBUa7vk1KcIgnEXcdxvFIdDQ380LBLOtUm36DjvrL0qSb7JTRN9bHxfjq9erKIiy+2/rGA81SJfyyLTHjBd9IiiLuP7f1pc3MS3Z5xAFjYfAb6yi7DCVdcgoMVf2dJpK1XrDgqEDUYmFqlhEum9HLxWr38VifYmyQ1VGkuVCX8+C92YL8eAK8vls9NQ8xRQtjVrhiceDyuDB9TUMzqV6LxsP+TaReKP4veU7JCFsTCIPM6vw+RySzzB/4HTVpjSKcqRHH8AY6HelU/gmhe9BJmEuJL6ioocE/PGzuEKTl9JnPashY5SUeXmJu/+IlZwjXTUUzwUTdAquIX6N+bWWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PG9QsLqG75gW/f4TUE9ZOwqkiHvmYKu2y8gb5Yr2T4=;
 b=pkZw668BS+gOQ8U9RXrdiGY/2p8w0oxbswkqc8otrPraSiXpi+Ucnuq2yNsugHrsVEUppmDJYZTXRxCoB2rdJbWfgRp6F2rWYnRga0N/Xy+lfN+7w1fvpYw1tlTp/JPoAiURto2GRzwIPw/SeYMg7vNDeDa5QLssObXXf7miBYZ95WiIYD9LP3br4M/cUFPPTMmabc6uQmTvTyY3GauNJLcmZgMyYFjO1FIRGcqzCC9tI+PMYN999qt9EtDhNjyHxdEILwcpKITYqgMmx/UWz4n1M8ONLAeK9r6+voDisTI6Z02sCYDbzw0MJqdgRJnd8xOk4elTpPNvuulZXzMm1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:11:31 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 16:11:31 +0000
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
Subject: [PATCH net-next v23 10/14] virtio_net: Use existing classifier if possible
Date: Mon, 31 Aug 2026 19:11:05 +0300
Message-ID: <20260831161109.2999926-11-shshitrit@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9a37c50-3fcd-4758-3b4e-08df077a8542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xm5GvF43qTl3pJ2F4AMfLdcQKKzJgpWK1IWCJ4kTDvCBk6fhm4zH1uBrFWbe9QMBuFBML2KgQrxKvEfPL6k0cOQWup74B7KWOyPJpN8WW/+iZV7K6JiNUIcIpB6qttDPopvd6AUCqLclNRaHUKurmYgFQElAFsDYPA1iG7P/G4n342CPDnx0AwhhX+SJLQpZsOJ4SLg8GUEUWvUnkS0BjYXG+Ngobu114F7E4GiLOIWJlUC/LVKRTlE2YfcoRxQv6tmFqMulWvx94FqGV7Z2usQzz156D1CXZiw5+0CGeNQJWi1s3jf93pt4lAqdzXp5TZvwPxBSZnSCaZ9yW+6OyJw5xDQrzqg5wNbbu9hqGGE+cch4kd0vkFQPGtONdf4rZ/Nvb0seOYBCHSM2p/6AvIL5YoO8oPa1iqQXkd6N5LwqIxHm2O3nQo3wjkeyl1U1nEd2uOyd2VVkkQreB5V6Ym6+7OMdCSq5aAForPd9PfwmH+GVpKLUNObvraL9EKNGvmaO1p0vbw5HQRHV8ALmzBxua6MucV1Vx8EiMkQmyBToMhSVVxKJHYLDn/kV8CriJFNjsxDYGGc8yUGXtFPRBq78R8V2zwEbGsEByIoMZT8zqRUfCOZVrjFvpKcet7O5CahnBz0HW9190mbU0E5NL/d6MbeHBHcc5N0IYkv5KMo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ou5Sa8DlDEQfoAeO3+L0JTdSgjJfiCth+8Tv6RiJm2sDitT22PpL39I2bUxL?=
 =?us-ascii?Q?MEtnBZ9fy0uRWo53/0bF2vdbv0nx7ysWxV5lez3HI8+p88mbIQ5XJXMydHzv?=
 =?us-ascii?Q?aRWWiwrtF78mzIyADEt8PReMccU2vdk0fQUE4be0pNO0bJ/GaXV9UCjuABXn?=
 =?us-ascii?Q?11ox5YjuPoyfZgw4o5avDgKerzlLQk2GPdlfLuYsgwQ/81K6P4zBCJLPwMcn?=
 =?us-ascii?Q?+L+uvRb9lU3e9Ebh8jA76gaY8oOf6ApQqktHNZ6FqMSbNSpkV4whZbyKdIuA?=
 =?us-ascii?Q?1WEZ0zKAu1ZgeBtQApRIM3NoizIz6YfrqBKc1w97SQoaWQY79zXqJ87CW7HM?=
 =?us-ascii?Q?J5xEBUGaz0j9P8nA/ZQzzMIaY1tot2WTKUVJJILYIL4a7rD9diXPJoWnEVF5?=
 =?us-ascii?Q?GPiwe0ANf/ycpVmuS2G4FC6mWaPE71Gx77z48Dzm0u7lUge3vx3gA06MxgHE?=
 =?us-ascii?Q?Acp7V8iYRBdRIRkBKFJvF9TteLdJUHIhhXzdoU71zyT3YelTAVyyeVuA6Flx?=
 =?us-ascii?Q?hyD8iAE4/jD8clBhIjeh6giy84mEOcBYARCU6bUTW41Kx9ZXNzgbH1uJFuAH?=
 =?us-ascii?Q?1wCwcBzn1DGZVJfwWvO0j2NPZkKjdjcvLQYiNXNZkOq2Y+TKlS3+4ogwVJ85?=
 =?us-ascii?Q?DrR800cXxcEKMElvKJbpYuQhkSLzeBBBEeWULHZ6XuGmWFYz+RkVgPFYlNPR?=
 =?us-ascii?Q?AVQ5Vlh4WDCKe81STrtWXlwj/PXIrCMKIX7+TLNkvh9fINJmWCx2EWxYjKAu?=
 =?us-ascii?Q?fnLnmQZsJA2u240Z/IRbH4tJOg47p878W+OoIw2YNoByymTfMAFJxRxFdFS5?=
 =?us-ascii?Q?BVhsfvle+qjWsLjCEa1gNy70F8qjQrBFW8OzCzdrtefPsDxnPsPtbRPZWBRq?=
 =?us-ascii?Q?oSAIKjOLvPgOHJeetoM8uymBKI46ZiUiDKrUg0PRjus22WoSLEBFo2n57jU/?=
 =?us-ascii?Q?RaMzL649Fx3kTnERRJnaqfcdmtmKuBz5VB3kRDbxOWAc0A0IOrPCI9eR8Qk7?=
 =?us-ascii?Q?iiKcn6RCHs1+ag32iBCfCqL3MzWwOVbzpXx8wkMQ5IBQufJQh0gDKFuyYjMZ?=
 =?us-ascii?Q?CevafDDx/qgGVzw14CyxNk4ZKKA6bHHZjRXgZ1ljw1SNCFtvc5CkumNvRivM?=
 =?us-ascii?Q?jGcLJk/Wuq0Ue5v+Seqpz1tH5YciWSLi/evXKIVAZDWh6qdth8lOV8eveXNY?=
 =?us-ascii?Q?fChzvusdXEzWUZQ09TiBkHe2BOmyMdcuuakbGr+GZ8XQX8+4UIEhpVcTC3+X?=
 =?us-ascii?Q?2YBRRCKIRYrtdpuv4f52ocIJJINbvyHiMXX+F2R5tdnpJZi2zPazvWW3qTRy?=
 =?us-ascii?Q?ZZFOV0AqLsfadd6PSpYlq3wg9AjNVeb3wuwEOrezoHsdKPuM6ge2JBAf5vmf?=
 =?us-ascii?Q?JAhmscSXR1n4eB3m+CM8iPLXTAPuE/epir+iS18y0wBpYu/hWpIYrQdeue2e?=
 =?us-ascii?Q?+y3KCTjE/JNNPiiVnpT2LGqdJhmd0sPoP4ENUz37jHg0pf87mmoyA5SjOvve?=
 =?us-ascii?Q?Zo0UvqKYmIZUqYZsv9AU5rYSg75QtJmaqkEl2X2lMV3J3VsARV6SJ9eRr174?=
 =?us-ascii?Q?nVa4VL57smFlc3sC56EmA7BYk01K4Orsa+KM78l4FgPw3yrK5anyydgXuGne?=
 =?us-ascii?Q?Y+2BOmeD6babTG5oRgFz4FwAhqrDpDNr1hGHTfWA0wK/cuWvDbYx5llzVtb1?=
 =?us-ascii?Q?Qz7DqYOXHldRZaHK+oWz8/67Xr9xWzRkXPENhApBRfFCvtyPMhoYrdIRd7qy?=
 =?us-ascii?Q?U2+7kjefMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a37c50-3fcd-4758-3b4e-08df077a8542
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:11:31.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lerh9akVQT8G37pSUsqiAOQe9MyEVW0R+Ahzvw5fllngOv26CQKs9X3OXaeix0L1jypVlnbZ0la78R844tVdrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

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
index 6217c5bcfee9..6c07eab047af 100644
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
@@ -5835,30 +5850,31 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
 	int err;
 
 	c = xa_load(&ff->classifiers, classifier_id);
-	if (c) {
+	if (c && refcount_dec_and_test(&c->refcount)) {
 		err = virtio_admin_obj_destroy(ff->vdev,
 					       VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					       c->id,
@@ -5885,7 +5901,7 @@ static int destroy_ethtool_rule(struct virtnet_ff *ff,
 				       0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 
 	return err;
@@ -6068,7 +6084,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6078,14 +6094,16 @@ static int build_and_insert(struct virtnet_ff *ff,
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

