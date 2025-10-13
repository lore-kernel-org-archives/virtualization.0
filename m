Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5731A54A
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369314; cv=fail; b=H4mwRKoIJQlvlI8lybWa59N7td7JB1pda89VtmNSGOpaM65CmS7T5gH25Rja+IqhCuDdnEle7dld6tBrNfAMJXA6ZOrq0MggJlYv/tBLd6RpeOvJXkkTdXRdkU+yK9MyRcxezj/cMdg2jpSpt9i42Sinzf8qQAx2w+lz7//EcZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369314; c=relaxed/simple;
	bh=0N6IVUDnhcnJjIwXfMtUd/Q+mRevdbESSXSawH3EQLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWMbKw46HSHXfH/oSyTqRTbJM1q4Ofb2jx9MBBQcMLfh2LOYr+bZ4ToGSkVt/H2QD74lThoITSrjlhQr4gqeP3QOIhy0tysno1Uvywi/LO8OEOeEmE++h2pafkSbyAAV93J/Cn4NiKB0fCQMgCj5HdxKva27D/jvvGYxnYSIxfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qml4A+DR; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qml4A+DR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJalaaSvResE8rEb9DCQdl40Kfp6TeoBLLOft8z7IlC+Hh7D3oozDFLOML5XRzYE99SKlEUEjOFMyJ7ao7y+XIL7dRsV4+V10Tr9O9/9PjgnrnMMq7UJkQSQhk8nUNMW+IpBJazETy7QrPLFpMslsDH01eIPOj4q1bZqeqmiurz9b7+u0XLPVtBQRJ01W5G/FsjENo268aZZ87++/3FRZ3YuHX5MvwINnidFLhQ2RP89EsKeOiCfmpE+TLE5Y3ukvCUP4tMFVEuny36KPVxpPkU6MT7oYyHQU4eLEZ8fcX83tHFa9AKQnpxMQt4iJfUmxAtWah9LXosqSazYK/pkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt4MzHrJbZxExPH2Ba9dhf6o8n5VHZ/RgQtt/GBVOVg=;
 b=Fpbv6ucDdG86U2/gjNshGWT8WdxIwJ8PB2W62x5kxxt3b9+KEUsK3j4wJNi83QdBqmAFHJHmIhE7uNlwwfTW+xwnOkuRHFPqS+1zyps58D+F1da2023pT/+gCk07UHhmmJg8rlntsotDGl2Yxb0Ffa5WX9hPqvptO4YBhYpDKNXB1OST7bNtx8sTgIaJ1MW7ul5aSORDN+FDQf0IBpM++nWrc/CUOV2huwAmZlwneZzFurY/hcW+896mvfqQdzczD5AzQrG1WZGSTm+hoWItyT8U38g1lBUgA4wChR6KDtagwAUUr6cJKC8gV7+SFq6mr8irN/6b66x0+597pUW66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt4MzHrJbZxExPH2Ba9dhf6o8n5VHZ/RgQtt/GBVOVg=;
 b=qml4A+DRP2oNK+EndZrHxdqMOk4MawMm6LTWEz3nzMYKpvsIs4pEyXu67M7fUFmLAIWZLwyBmTeVSUOpUME1pWGZN7i5a2sSSnBOWGMFveuc8Ru3r721E6TFW0yAkaa1KVJflhjTC+8dWi7i6DYA8i0X7CC+C1e00svYzZCesJKUfwP7WdHjsUiT9GI+43wQjTAmdmAqbRP2ekuXqxPxUohtgnvRFQAO+QgrjKAHidpys8+75vlpOcdGq5oCO8l8ZmoM/Q47KXWr4OFZxAxPj6yx80JQUbwwRAEmXl5hPX/yI2urn9HjpgHCGlK0gKLrLaA7GJAK2wuHrqcKUGDZlA==
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 15:28:28 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::ce) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 15:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 15:28:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:15 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:14 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 08/12] virtio_net: Use existing classifier if possible
Date: Mon, 13 Oct 2025 10:27:38 -0500
Message-ID: <20251013152742.619423-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013152742.619423-1-danielj@nvidia.com>
References: <20251013152742.619423-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: a64b6282-a064-4c83-7e5c-08de0a6d2882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZq/K/E9kTdsWTMcbUlmVQvtFZDsLxz5tf7hC1CUOE/EB0Ov7SvGo6U1OH8y?=
 =?us-ascii?Q?2z9abJFNKgEeq4gQ0AKZeSuXviuH91d64I6cKOTJpbpHeQVUKlCaM44yl8Mr?=
 =?us-ascii?Q?shE5WiAJcli/8fsgOCpN8zUdLaO+u6B2q14vONTmzGSsM+DWf+jWDPf57YAs?=
 =?us-ascii?Q?12dQzVyapuX4Y9e5KyLQOum2dAOjUKfHIZlQRLH9HMNsGn2s96gIXCPpb1V/?=
 =?us-ascii?Q?0q8l9Kzm/wXTn1bcl+fAmjzTjCCKX0BaeUS3CAcd+OoDCYBmHe5SUm2egwGS?=
 =?us-ascii?Q?ifefCdMgfLS99I1EcD7pHEMcyOFQMMFllWyohavDy8FFI77s1GPFs0k6xPVg?=
 =?us-ascii?Q?fe8Y3SYENSxwvjfI1AkSoUcX+WKX9f2z6JLA20RSY2YOGbmgXcrIP9hyXOJp?=
 =?us-ascii?Q?qX7nVf6GOJiLe1dFASUaJBTM/W1ugnfhLtsCWWUE5NgssUtCBU3McETY0Sbo?=
 =?us-ascii?Q?n2VWwScngH7pvBOEniv7nOwYoOBOOFNDbaSIdGsEtiYkWD1fVa4LL5I1eF2o?=
 =?us-ascii?Q?j1FUL0tnOPwG+xfPiE0YCww3cO9pBeY2AhlMoBf2yIriX7nXXVqGcnPWDhCf?=
 =?us-ascii?Q?IWZyM8ZcDfGmqPRzfHz07ogQnmEbiTuL8VskMnHpkb0yywKPN60UPdcdR+C0?=
 =?us-ascii?Q?Xa9i3cZCPM/XhPG3tKUtkArSJd0R78SOyzNqyqnxKnFrds1iAQ9YydVlm4jm?=
 =?us-ascii?Q?deOdj3Eci3pwbT7aYXzjQjfBZ59szK0YoYvAkxkXT+JMGY6G3bNFRi8cHxjC?=
 =?us-ascii?Q?jKp+UoT7m+07Pb4mbSTtimYv3FfEnHOnJALj8PD8f6vwL71C/VJwCJxv3c02?=
 =?us-ascii?Q?76bUKaxK3gggn6mIlNRMnsKXvzFrWWKA4ELJBDiNrk/MdBzgYecw4Bc/pPR4?=
 =?us-ascii?Q?73GS7bskHqufGcIlRAohnNJnn4shHxgn92lqB9SPXr3o5cgEYmGKPwSJUliS?=
 =?us-ascii?Q?byfAy2lAkmyyTlqRBZSAxmsAu4lcTho02BZgXMd0dLT/o5lT9jaUDU3XRgNB?=
 =?us-ascii?Q?tsBU0aoAnAo5YJ8uNyDyrmgaGS0BslVhgiA9a4esmKpj00JFsKGrM5aoYsh/?=
 =?us-ascii?Q?C+e/kiGX2m6eSOkeIkzpZioUKb2Db4m1Q7rFaB0Q5ZZHv/voKgrF1QdMP0+M?=
 =?us-ascii?Q?Q3kfanZpIqpgvRAwnyrDpDXzp5SBYGYN/UxD9KQZAs5WBUaN8T5Y8zEsIZky?=
 =?us-ascii?Q?esksCNI2sHMFjAR+CD6kxiFqnAVLlWr5hN6RoX/0g6vrZW6yRPRWRXxW6NQR?=
 =?us-ascii?Q?Bvh6D9b+Xo9Pp/4N4eRXwyVCLRE31VITXvqRqChJhoP0UB7/4QeGZwb8MvBE?=
 =?us-ascii?Q?hLusQHzso+dg+7YEWKkfdfUD0KGiPYkpHfO3nIO3DqtWRQxZBwfI6PwvGM0D?=
 =?us-ascii?Q?aXjF+jndYweeVQNNRqHPst8t6Y3+oc8l1TWfSynLVPnyrW3R66PYyDDED7eZ?=
 =?us-ascii?Q?Rt+W4RQIfyTux+EKlFFtkTNkutT3zm4+a4Udk9jBtu3gkxUZ8odT7NN+kmUr?=
 =?us-ascii?Q?YzWnEbyhgQDivR8RD2C1gBGW31IK12dXW7A6Q6+te/PNIeM6OKhe7ivEoga9?=
 =?us-ascii?Q?pS5j/Vrj1vZeAsKNw5M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:28.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64b6282-a064-4c83-7e5c-08de0a6d2882
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4:
    - Fixed typo in commit message
    - for (int -> for (
---
 drivers/net/virtio_net.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4185b3dfb61b..e0f0be40c238 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6806,6 +6806,7 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -6899,11 +6900,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
+		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
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
@@ -6911,29 +6925,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->classifier,
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
@@ -6957,7 +6972,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -7082,8 +7097,9 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 			      int num_hdrs)
 {
 	struct virtio_net_ff_selector *selector = classifier->selectors;
+	int i;
 
-	for (int i = 0; i < num_hdrs; i++) {
+	for (i = 0; i < num_hdrs; i++) {
 		if (!validate_mask(ff, selector))
 			return -EINVAL;
 
@@ -7137,14 +7153,14 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_key;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
 		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1

