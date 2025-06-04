Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8981420DD
	for <virtualization@lists.linux.dev>; Wed,  4 Jun 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749062911; cv=fail; b=FELQwJaXAvIrL1Z8Efc7eWMjdNI48phiQhb7m43uVr9606vFv011OYs5kD3aoWOwY5Zm+GuaGRqFAxIHoXF9KaYIPyjN/R8pDcBsnWiK0spKOPA3RtXfiAc9mSHKG9C8Tq13ngpTO7wwI+B2WSSwCL4XUJ/ezrLy1Gbd3AmhOA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749062911; c=relaxed/simple;
	bh=IO5pc6136e4NInqLhVq645jLkab+Eo0ML60CUKjxIMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KtX5FGYUve2WvLJ+eltXdsGyFYnnNhnKmRmHigyCNGoe304y2zTUMa88qeUMHzeGOvE0W0ZiR6cY5iRPRXZEHTxEvwskuEPUdbOCofQsnbPnvETVwYN6Czo4VZ2ghvfC2Pw4KxltaM7BJeiIWar4lTmAtCs7WqpSqyjqTByxNKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tZvzlcwB; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tZvzlcwB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh2ekVMTFHCRBifWYWJQEkd/IWpSWmg6HSQjC/Alz4uaKMdFDfZ7KYVReWSm+R5+EaDohRtTrDVQEmUumMB4QIFNkAQHfj3KVB8FsP7kb1ItPXY4fdtFGm8TgNjLPIZ8D1FN4pjLcwi+IWiVD8t+zqtkHQYK3h4HpTAnS7B7b5wo0KVNgctXdAFL1NJVQTlp7ExD3DBguTCsmeDV5ACgj07pCNfB5SC/E9OYfRb2YtLtURMgkHS5leydhLYZTW6x2C5qlpqaeYr8cmwuuClg/kcJz+0VorwEUJKZjfDZqdFlqlwdMOIf+3P+9t5L8momvBX0Ig80bEWLDq7/U3szng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaov7hnlexyemPnihHEOUNGqHChhYrm/VyjQivHoHsw=;
 b=sfAs89PwMi0soStgXge7ZCz/w2VG3FFhlHLfYtW0e9O9z9EH7xQecMDEvwcn4ks9QZzNpVH9oZCBN1NuFLk2FwSbDRMMQdwx0QRvZxkLN979hFW3jiuMXOn7HOqHlXuk8OSQdSL1LqqfB7IygzIc2yHD3Esm8JVwW/U2ZdlCacQi/xFsBFKN5vsb+aAaImv6Gult6pKGw2//H9dIcyDZ69DS9POFEgoYZxTqucXUTofPa/x5xQl4KQUzASNAuhqCT2WBxY83ZkTaf48uBUZ0aF6VVqxSyKsU5AfJ8k/fxJATc4rkN4D1nYRCdMWVhetRioO5UDqyK5PkkZDxO5mgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaov7hnlexyemPnihHEOUNGqHChhYrm/VyjQivHoHsw=;
 b=tZvzlcwB3ICrGSIiJuqCTByB4bwl6rMGPS4gH3fnRdN2jrjNnATYvwJrzxRcuUYXLqf4TcK4wOR13rMf9dMiCWZv7EWPq2xRMe2KhNvIq35Vrb/ALm8/R5Mw6Jg/+qcVmBWzTv7zVk32QsuG+q5r/lFsLZ7iiG221Ub/86EFgx3zhYmRoQyfh0SG6TJ3IHxxArnbny86hbXfPxlY5uOj82OWldRX9D/PRVAGwTzkrE9jVwt8y5gH4t0jYR3LskdbjYZJ7OfBpZalIfT+5VsNiD2reE3TCroCJ/1zLZXrxWXBZTaO1CRUPqgCv8eapStooixJW0SolJ/JNcGcolec2g==
Received: from CH0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:610:75::17)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 18:48:25 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::5c) by CH0PR04CA0102.outlook.office365.com
 (2603:10b6:610:75::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 4 Jun 2025 18:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 18:48:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 11:48:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 11:48:11 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Wed, 4 Jun 2025 11:48:08 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Cosmin Ratiu <cratiu@nvidia.com>
CC: Shahar Shitrit <shshitrit@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH vhost] vdpa/mlx5: Fix needs_teardown flag calculation
Date: Wed, 4 Jun 2025 21:48:01 +0300
Message-ID: <20250604184802.2625300-1-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 8836fa7c-0e61-41f2-ae00-08dda3986300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D/mDNNTnRMMjHk0zsalpMrpjyeFXWs66cZ0GMNZz+wR6edPgDEMfAprhvBVf?=
 =?us-ascii?Q?25n/wXmwDYRoLj9yFPFFZfnAOgFR6pdv+8AtWmWhkW0U2sRQUzejyKvWF1fl?=
 =?us-ascii?Q?0GyRLT2by4wuKxJsNhHDujq36SeY/JJ6PE/7aKuC0a+Nf//8NuPHLNkF79jW?=
 =?us-ascii?Q?AG4mE4PtKI0HT8k+rLPijmbLG0JeB28VtNodfNnqa9PPY6uH2Lgrq6Zf/bcf?=
 =?us-ascii?Q?rAXDWZRFSohJue8aKvlMl7vKwlfPAHYp8k4sOp2vYu4OFN7l3cQsFmT7kc9S?=
 =?us-ascii?Q?wj3l+nqjn0lCNTKU1Y7gj692tujXJcsXkt/+wsnxa//oMDejLcwC8csSnI8/?=
 =?us-ascii?Q?Fr0k/lDAC86SWZhn14+q9CcyUPx0IuiQkmchGrdfzpjYCcCvtCFHl7iMTIqt?=
 =?us-ascii?Q?MrAhJe/+cXJ+0RhR9XUQbNyKCLdSE+IrZFhgpf8ucNvE5Q+6Evzwibtf9SQP?=
 =?us-ascii?Q?QqvilKlYdQ38DdHK28C/24bt4sI3JNtXs2+bToDUQJk1aCvJHG7A41r3W8h6?=
 =?us-ascii?Q?vXxiYTLAGmeUblqjn33rSHsMS8pqnKkBivcTZ8q8m7SgXYDmCO1Z6Bup0PFC?=
 =?us-ascii?Q?3MwPQcxRagdHBvOFHYXY4+yGO6hAPqddEECBbyTyFfc4qlMXHk+2ECheXV2p?=
 =?us-ascii?Q?+7WCUTLkFm5u+sU/fy2f3iWRDMjwA4pn1riuqG6X1CYjOpnzHCTSx8KN0R7y?=
 =?us-ascii?Q?FwRdWXcSATvri4DbxXDNfnNQ+PuWUW5R6Mi9N2oSviEXZnJmlqh3bFLPC6/I?=
 =?us-ascii?Q?7cPzvNXQFL+NCgiNQj0pkyPR87nqq2x+uc/P0CO5WLt/M4XtM4QkMPBg2sQm?=
 =?us-ascii?Q?WhlkpiFtj4VtbH/iNOo2zXovDkpyW4mI1pKIn36hgsqkHvNhtt0DIdPD3MN0?=
 =?us-ascii?Q?FhElOEoylFFA2+q+Oy+goix/pBqa/uNWO4y4nTNwYS9g7jI20/m3vg7xGU/g?=
 =?us-ascii?Q?6zjr5iy0BZ+A9BNDfVeTp4GLuDIp9jHyiOr9Fa10fZLojdA0Iw0bl1l45TBR?=
 =?us-ascii?Q?4X3CtHsb5tnzt+BW6LwZZo95PPzNtpqn6CkvD/i5aczNoAPrDSOJHjCSKZG5?=
 =?us-ascii?Q?LtpWWvB5q9iixyFLQ3L1WEF/SqkBODNhR2KMGhPUo0GZupogQLkmB8Jr2kd+?=
 =?us-ascii?Q?1PoYISkTf0qv0eDA/Uq+7YFUkzEP8jlZ9KmWwKEcpnQXm+yJn+2vvxkgk1PS?=
 =?us-ascii?Q?3NQ5s144IaMDoNu+6Tojc1QXguIQyVusq9ldtQCryEKCjGSrX2o3ZvcW/RRf?=
 =?us-ascii?Q?dA0HtiRadckaYBtV9olQ+ZwAGlK2yx55uRloAUDvGyaPCPuplJqwgKmPcX28?=
 =?us-ascii?Q?QLgYTrGwIsMElW7ot224u5Xdutsk8B/+2JyW29rKSfMm27B7StaGR1XWkahH?=
 =?us-ascii?Q?sTldd7xtEujvV1v1y9YC7w1Ix3BHTXonYm/QmkqIKOsKThb6lFj7n+ZZx5Qs?=
 =?us-ascii?Q?bl3EANE09AgIFBME6X1/F9kmXTSeLCnongPbFjBMAsagt/RPEOHa+GI03yHF?=
 =?us-ascii?Q?ZNewtMiAU8Sps/T6LhsW+asGR37tWvUR8PaE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 18:48:24.6784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8836fa7c-0e61-41f2-ae00-08dda3986300
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651

needs_teardown is a device flag that indicates when virtual queues need
to be recreated. This happens for certain configuration changes: queue
size and some specific features.

Currently, the needs_teardown state can be incorrectly reset by
subsequent .set_vq_num() calls. For example, for 1 rx VQ with size 512
and 1 tx VQ with size 256:

.set_vq_num(0, 512) -> sets needs_teardown to true (rx queue has a
                       non-default size)
.set_vq_num(1, 256) -> sets needs_teardown to false (tx queue has a
                       default size)

This change takes into account the previous value of the needs_teardown
flag when re-calculating it during VQ size configuration.

Fixes: 0fe963d6fc16 ("vdpa/mlx5: Re-create HW VQs under certain conditions")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Tested-by: Si-Wei Liu<si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index cccc49a08a1a..efb5fa694f1e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2491,7 +2491,7 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
         }
 
 	mvq = &ndev->vqs[idx];
-	ndev->needs_teardown = num != mvq->num_ent;
+	ndev->needs_teardown |= num != mvq->num_ent;
 	mvq->num_ent = num;
 }
 
-- 
2.43.0

