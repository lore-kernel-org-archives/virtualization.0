Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4905E732EA
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 16:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C624611A0;
	Thu, 28 Sep 2023 16:50:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C624611A0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VGJivgmA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z_kxqQFvn15H; Thu, 28 Sep 2023 16:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23D4F60BBB;
	Thu, 28 Sep 2023 16:50:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 23D4F60BBB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE8E9C0071;
	Thu, 28 Sep 2023 16:50:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81D92C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DC3160BBB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5DC3160BBB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HetNRoyOII5w
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::605])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C67E615BC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C67E615BC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwQ42FeyZpcmqr4QpH3J3h2hpvWbbbdMi07REVGf/xClGq/sKh7Qpwya9dkPNuPBjC0LKFvP/RviwaWyk2SokC/BFGzXd7bGAOJ8qxw4NETCuqLUUfdTglyiDPFUc7T+EWkf8lEdMSLZf3UooyZkrnlyGs8WSTKTY9qncMcIwQvpHngTt5cJ+NbaMx7xkafNdiWzt8LMgUtQjpvRSvQ/b5DDpG4m4YfNGjzmy67m/PE13Umb35p0uSa+oRiyVhZxxGdhmxcFMBRA04Z39vNwvg6ZolfCAuCqDwCLDr9QSOaexr5gnq84wFWPz0XVBJ+hpqjPAEJeB0j3Z9aMTuVT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqXzNtuzmep7ULt81tvKIba4FBPF+U2bzirjqh6BoMg=;
 b=OMjKggyhn5CLKZ7DDp5DT0DpoAZh8kTLi6BoTzEI1Z//smRrg9ryEsYAJvCC+ciB4cEoG5eMsoKPTOX5tSYe0tKonZgDJqUZWpRAmvNrZ2v71X7q3HlaYsE9cLPThUnF0QA+3FEHx/bMvMfclIGAZbGspJuzToK3aVFNLsapPvifoZPIQlQmelf8waSrT/BSgVTEFstkaojyHeuFy81NJbtHC8X/uhxQA2jq0pX0k6VMRVDO4OwsjGKMkvyOohptNnojmhR0aU+y4RV9M8UGmfDbqxPf5MywgUN1NpSusTunINWudSVIw8TrFMdezhxy3f+bDbjPN8pJcc8DnS58ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqXzNtuzmep7ULt81tvKIba4FBPF+U2bzirjqh6BoMg=;
 b=VGJivgmAX5RifnPykfy9/28ffOOanjqIoILCSuTQOKgjXQpj58vSL44WrekW0SkjZ8UEzTrhZcp1v+PUu6ccI89Hh/jl2eOrzLOIENWgnpR8RdCpEhvuycstWs8UJv6/8bL4nvTtMfWb6LacCQkSOyWE2YmuobuDDpqAFM6UcZm9sJPJzq+7/se0s/HRdLtLA/DODY/X3c4Racamqjk6xkb4mGR4SUxbtCOmXNA9VGcHQDp7tK2pTjxxJcGjtRxI6sGWoeMrkO3UBj6RSy+fXK+x7k6D8Z0LqjX34Ha335w4XJ6aB0AFoKto2ALM4ojuyQdXmUBDtPpbA6fQuZ65XQ==
Received: from MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Thu, 28 Sep 2023 16:50:29 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::85) by MW2PR16CA0035.outlook.office365.com
 (2603:10b6:907::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:50:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:50:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:50:14 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:50:12 -0700
To: <eperezma@redhat.com>, <gal@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: [PATCH vhost 16/16] vdpa/mlx5: Update cvq iotlb mapping on ASID change
Date: Thu, 28 Sep 2023 19:45:27 +0300
Message-ID: <20230928164550.980832-18-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df76dc9-3965-44b2-e1bf-08dbc043056d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wiL0Vb8XEAa5WYLQvRQw9gJJryeUhdQE6JegoxvSi/5hDP0lgt1DavRqoEc0RkLjAHhD6dielmyvDtlfKERUUbP+xh+UPyQNendkrfdiuDIXdHlKmXY4NVzSCJW2zyamtNbAyys10pX6wt8+OR7TAqgUs9fw3n7wkgr8Yeh+Q1tfcX8XUbCcmgSH7n8lmElwsYTclayIgbyVav3LMWzVCRKUKqhzEfVWxo1p0H4InZgqn3NOLyNGc8B62qA93cZ//RnUZStZVLgjd2/XBy4ctLqCFmWjYK3/x+2B42QhdtMJ9smrhdbkVsHvMygrqI3dkJHgWG4P7Hqbq6ksQZJxtD8dkBlzfBWahyAW5faau8w9H4TjDl85G+vlSddc9uQgHr59lrxAz9AgjmV7TsNR8lNRk66MdEpZVSvW1Nk66sN6O1HnNrQc1OQlmLqgXR4PcJky9dE+ZjO3EsHo/FyvsUqpLzQD5cbg7fff9cO/507a9N7SKfraCttcM3CdWpNCLF0fquDMGFs4GoFKJvUG7QLOR18L5VncDhK+ftBmLT7OABNY7OwKSzH0nP+9t5telBmvgxWJ3J5cg5VkW/5b5SjD5pB7jAY1jHzPD/M1gYfFpxVr4/0Wiky3wY/paRXh9OX7UDMFpOP97r/PIegTIe2l08FdNJW6Ol/Mbj04e8MF3rRdzzcVQH0IBGyrFAWPqbf5FOuRtjyEfXhXVKGGHudmhNlILMpeY17SSPOwCZVql/OwOdGfOCwuAqq9rsv
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(7636003)(336012)(426003)(47076005)(1076003)(36860700001)(2616005)(86362001)(26005)(41300700001)(36756003)(83380400001)(40460700003)(8936002)(4326008)(40480700001)(356005)(5660300002)(70206006)(8676002)(82740400003)(110136005)(2906002)(6666004)(70586007)(316002)(54906003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:50:28.8548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df76dc9-3965-44b2-e1bf-08dbc043056d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
From: Dragos Tatulea via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

For the following sequence:
- cvq group is in ASID 0
- .set_map(1, cvq_iotlb)
- .set_group_asid(cvq_group, 1)

... the cvq mapping from ASID 0 will be used. This is not always correct
behaviour.

This patch adds support for the above mentioned flow by saving the iotlb
on each .set_map and updating the cvq iotlb with it on a cvq group change.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 ++
 drivers/vdpa/mlx5/core/mr.c        | 26 ++++++++++++++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  9 ++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index ae09296f4270..db988ced5a5d 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -32,6 +32,8 @@ struct mlx5_vdpa_mr {
 	unsigned long num_directs;
 	unsigned long num_klms;
 
+	struct vhost_iotlb *iotlb;
+
 	bool user_mr;
 };
 
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index a4135c16b5bf..403c08271489 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -499,6 +499,8 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_
 		destroy_user_mr(mvdev, mr);
 	else
 		destroy_dma_mr(mvdev, mr);
+
+	vhost_iotlb_free(mr->iotlb);
 }
 
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
@@ -558,6 +560,30 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
 	else
 		err = create_dma_mr(mvdev, mr);
 
+	if (err)
+		return err;
+
+	mr->iotlb = vhost_iotlb_alloc(0, 0);
+	if (!mr->iotlb) {
+		err = -ENOMEM;
+		goto err_mr;
+	}
+
+	err = dup_iotlb(mr->iotlb, iotlb);
+	if (err)
+		goto err_iotlb;
+
+	return 0;
+
+err_iotlb:
+	vhost_iotlb_free(mr->iotlb);
+
+err_mr:
+	if (iotlb)
+		destroy_user_mr(mvdev, mr);
+	else
+		destroy_dma_mr(mvdev, mr);
+
 	return err;
 }
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 46441e41892c..fc5d6b989a5a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3154,12 +3154,19 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
 			       unsigned int asid)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
+	int err = 0;
 
 	if (group >= MLX5_VDPA_NUMVQ_GROUPS || asid >= MLX5_VDPA_NUM_AS)
 		return -EINVAL;
 
 	mvdev->group2asid[group] = asid;
-	return 0;
+
+	mutex_lock(&mvdev->mr_mtx);
+	if (group == MLX5_VDPA_CVQ_GROUP && mvdev->mr[asid])
+		err = mlx5_vdpa_update_cvq_iotlb(mvdev, mvdev->mr[asid]->iotlb, asid);
+	mutex_unlock(&mvdev->mr_mtx);
+
+	return err;
 }
 
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
