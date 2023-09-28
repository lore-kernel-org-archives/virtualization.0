Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C713FE732F4
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 16:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E11560B4C;
	Thu, 28 Sep 2023 16:50:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E11560B4C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qa6z+RQy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PyFBbUyc4MXe; Thu, 28 Sep 2023 16:50:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A85F761387;
	Thu, 28 Sep 2023 16:50:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A85F761387
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82EBEC0071;
	Thu, 28 Sep 2023 16:50:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6E14C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B21978316F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B21978316F
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=qa6z+RQy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yziotJ7MLHYN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D374835F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D374835F2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0NryE7mczykT7tc2m5fAw4Ke4lOZhevG3v3Yh2G4vQF5L84uWDLpAZl/KlKQiMrsYRjpE24FcR1SWaOweTCSm4ytOrTv0L5nxKoaF7lxhdu7fXVAggPT9K9dp6u/PqcD8pZWWmqjZ4akDW5uGdt17YCv3xT6qtTDGa0y/GGJepg0OJtGbDKYlH6IYsvjkzuOgP0zuushmlPDW0VZKPkldnvkruA4jlOD7wq3xvLMMtagxKUrKpR1/VkrS6X8Mf2tjSYTeCv5OLz5p7LB6MeKAN//r6YAZV9QSvoLNirMBct+rbSucazmxDGVPmY5+Ov2lAC3dCdryMrZJcyJqMusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nqpxFPlC0nJlt8MPwoegjK6o2hj1U1JGXxph7oPUDY=;
 b=kA5BsEi4w6QrtvGv8cPZ0pW1SZCaq3n/M+DkLqt9Ozv2V1xGpFx5qXZxhWq0At7Bi7orVTcUAGsudqSqKuH2LIVeGUDdKyb9/BDLQF8ip1Re9wgketytTAPTRWr/9rKOpGVWLRG43EsHbE+KVJ/PQIb3hXG+xP9GwUip04eZp2S0pJDq+eTF378aXebWv+UN2BncoRnMtTWfJ14yDKAq1rMPkacXrLU3A0aAz2eRAyIorKW0yAO7NgMvhgV4mrjty3fzRblfc2PlkNCRetXYUCjyvgmHOrgrAaksNGFxiNG6wn8b0IViMGQzSs7R0wnzsvNcpBBPdWBdHsHgNZG9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nqpxFPlC0nJlt8MPwoegjK6o2hj1U1JGXxph7oPUDY=;
 b=qa6z+RQyOQq2fBLfSQ+s8OB3aUirLzZT1jB7JcaeHGi4lcUBFoZLGU9JLReNiXiVgzBRCglSMcfwMXppC5S4FO3q7RKgUhjaC5yCGUNm4klEd+aL4uYISDdLLTLKJ+L3SY1UsNh8W4DQvxP/ClEOPzpdkQEbIKT4SkvJ+M3++0h9fbMW/L8Ki8rnkBQNvG229enM0reYsdFPB8UHjrrdEpiW8yO9BPy+NiqxL+yx8OOTOZ6+DtgxwcPLMFgbfOUSb1fMbqvn049/Tta4naMAUPyROrYCpF4WenYRLEY5yZ2UIGvNi4oS3nb8T4dwI6fFNuXovLyitZ9putMoOhI9PA==
Received: from CY5PR17CA0049.namprd17.prod.outlook.com (2603:10b6:930:12::33)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 16:50:01 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:12:cafe::29) by CY5PR17CA0049.outlook.office365.com
 (2603:10b6:930:12::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19 via Frontend Transport; Thu, 28 Sep 2023 16:50:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:55 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:55 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:53 -0700
To: <eperezma@redhat.com>, <gal@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: [PATCH vhost 10/16] vdpa/mlx5: Allow creation/deletion of any given
 mr struct
Date: Thu, 28 Sep 2023 19:45:21 +0300
Message-ID: <20230928164550.980832-12-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MW3PR12MB4508:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9f4de9-b8bb-437d-f44a-08dbc042f4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79pJobIvEd0XNzl3PsD0vpi9HBZaXighEZZpWN02bCfqY93749oOEsdSuh84xRFfPixcyxXmqlJXYiUp151f+osipueRjjnDQZ9OaWiK3JAc9VP8biii75ZnF0ltJUk8vd4TS7MlO9cxRqXrKJoZHCqsqxoKF8KnDzkwNomhFyzqPnmHTNOWd9aiDJeqLt963B4cIEv18D79rhe8wi2Ic3EGvn378nrAn3MumCjJcxmLGQpwktWbhDM5B/yCZ6y65DgmeJQ+gMqIfy7tXFiJ5xVEZhZ2KdwMRQXI8OrG1D/BtPfCLH4TVn4xHE54fnBF69JSFp57BV2+lm3jOnAd52zYM/uISEaKBq2OPfnpvj/krunMXR08fqZf+rkSXQxj5AjGiO7gLoFCaIjAFKFHzIXabVYZImwc0Y/bNBr84XuaKQQ9bBCH3kipw0dQZ4SwYayILdjKyWXgTgCsHXtExfPm+CreSFfd9z/hxbAvFaF/ebov7D1iWaWvn9CiCfq/hlno/gHPpHz56hHJNTkyhdbykwh+Xbe3rnvn4i816j0WBm0Q69hYYVwBFQcIP8DV72rpVKrEEl2XIWSllNimHzLLic/mqpgwr7PwekK13VyK1S75P3fOciKNpVE0FnGrTWgq5vgvaT6oYY9h0fUlJ0ubq2I2ArnWJ/U9c0CeY2n4DU3XublBDozdiuwTZxj59fgcFbdeaMkXTBV0GSDTQ7AbgEaJrMlZwZhyJYFjqOx2IXaw2KVeQzTVt2xP4QbY
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(5660300002)(7636003)(6666004)(40480700001)(41300700001)(54906003)(70206006)(70586007)(110136005)(316002)(8936002)(4326008)(8676002)(36756003)(86362001)(83380400001)(47076005)(336012)(426003)(2906002)(36860700001)(356005)(82740400003)(26005)(1076003)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:50:00.8558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9f4de9-b8bb-437d-f44a-08dbc042f4bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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

This patch adapts the mr creation/deletion code to be able to work with
any given mr struct pointer. All the APIs are adapted to take an extra
parameter for the mr.

mlx5_vdpa_create/delete_mr doesn't need a ASID parameter anymore. The
check is done in the caller instead (mlx5_set_map).

This change is needed for a followup patch which will introduce an
additional mr for the vq descriptor data.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  8 +++--
 drivers/vdpa/mlx5/core/mr.c        | 53 ++++++++++++++----------------
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 10 ++++--
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index e1e6e7aba50e..01d4ee58ccb1 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -116,10 +116,12 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev, u32 *mkey, u32 *in,
 int mlx5_vdpa_destroy_mkey(struct mlx5_vdpa_dev *mvdev, u32 mkey);
 int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			     bool *change_map, unsigned int asid);
-int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
-			unsigned int asid);
+int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
+			struct mlx5_vdpa_mr *mr,
+			struct vhost_iotlb *iotlb);
 void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev);
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
+			  struct mlx5_vdpa_mr *mr);
 int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 				struct vhost_iotlb *iotlb,
 				unsigned int asid);
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 00dcce190a1f..6f29e8eaabb1 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -301,10 +301,13 @@ static void unmap_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct
 	sg_free_table(&mr->sg_head);
 }
 
-static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8 perm,
+static int add_direct_chain(struct mlx5_vdpa_dev *mvdev,
+			    struct mlx5_vdpa_mr *mr,
+			    u64 start,
+			    u64 size,
+			    u8 perm,
 			    struct vhost_iotlb *iotlb)
 {
-	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	struct mlx5_vdpa_direct_mr *dmr;
 	struct mlx5_vdpa_direct_mr *n;
 	LIST_HEAD(tmp);
@@ -354,9 +357,10 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
  * indirect memory key that provides access to the enitre address space given
  * by iotlb.
  */
-static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
+static int create_user_mr(struct mlx5_vdpa_dev *mvdev,
+			  struct mlx5_vdpa_mr *mr,
+			  struct vhost_iotlb *iotlb)
 {
-	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	struct mlx5_vdpa_direct_mr *dmr;
 	struct mlx5_vdpa_direct_mr *n;
 	struct vhost_iotlb_map *map;
@@ -384,7 +388,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb
 								       LOG_MAX_KLM_SIZE);
 					mr->num_klms += nnuls;
 				}
-				err = add_direct_chain(mvdev, ps, pe - ps, pperm, iotlb);
+				err = add_direct_chain(mvdev, mr, ps, pe - ps, pperm, iotlb);
 				if (err)
 					goto err_chain;
 			}
@@ -393,7 +397,7 @@ static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb
 			pperm = map->perm;
 		}
 	}
-	err = add_direct_chain(mvdev, ps, pe - ps, pperm, iotlb);
+	err = add_direct_chain(mvdev, mr, ps, pe - ps, pperm, iotlb);
 	if (err)
 		goto err_chain;
 
@@ -489,13 +493,8 @@ static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr
 	}
 }
 
-static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
 {
-	struct mlx5_vdpa_mr *mr = &mvdev->mr;
-
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
-		return;
-
 	if (!mr->initialized)
 		return;
 
@@ -507,38 +506,33 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid
 	mr->initialized = false;
 }
 
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
+			  struct mlx5_vdpa_mr *mr)
 {
-	struct mlx5_vdpa_mr *mr = &mvdev->mr;
-
 	mutex_lock(&mr->mkey_mtx);
 
-	_mlx5_vdpa_destroy_mr(mvdev, asid);
+	_mlx5_vdpa_destroy_mr(mvdev, mr);
 
 	mutex_unlock(&mr->mkey_mtx);
 }
 
 void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
-	mlx5_vdpa_destroy_mr(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
+	mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
 	prune_iotlb(mvdev);
 }
 
 static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
-				struct vhost_iotlb *iotlb,
-				unsigned int asid)
+				struct mlx5_vdpa_mr *mr,
+				struct vhost_iotlb *iotlb)
 {
-	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 	int err;
 
-	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
-		return 0;
-
 	if (mr->initialized)
 		return 0;
 
 	if (iotlb)
-		err = create_user_mr(mvdev, iotlb);
+		err = create_user_mr(mvdev, mr, iotlb);
 	else
 		err = create_dma_mr(mvdev, mr);
 
@@ -550,13 +544,14 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
 	return 0;
 }
 
-int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
-			unsigned int asid)
+int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
+			struct mlx5_vdpa_mr *mr,
+			struct vhost_iotlb *iotlb)
 {
 	int err;
 
 	mutex_lock(&mvdev->mr.mkey_mtx);
-	err = _mlx5_vdpa_create_mr(mvdev, iotlb, asid);
+	err = _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
 	mutex_unlock(&mvdev->mr.mkey_mtx);
 	return err;
 }
@@ -574,7 +569,7 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 		*change_map = true;
 	}
 	if (!*change_map)
-		err = _mlx5_vdpa_create_mr(mvdev, iotlb, asid);
+		err = _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
 	mutex_unlock(&mr->mkey_mtx);
 
 	return err;
@@ -603,7 +598,7 @@ int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev)
 {
 	int err;
 
-	err = mlx5_vdpa_create_mr(mvdev, NULL, 0);
+	err = mlx5_vdpa_create_mr(mvdev, &mvdev->mr, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ab196c43694c..256fdd80c321 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2644,8 +2644,8 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 		goto err_mr;
 
 	teardown_driver(ndev);
-	mlx5_vdpa_destroy_mr(mvdev, asid);
-	err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
+	mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
+	err = mlx5_vdpa_create_mr(mvdev, &mvdev->mr, iotlb);
 	if (err)
 		goto err_mr;
 
@@ -2660,7 +2660,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	return 0;
 
 err_setup:
-	mlx5_vdpa_destroy_mr(mvdev, asid);
+	mlx5_vdpa_destroy_mr(mvdev, &mvdev->mr);
 err_mr:
 	return err;
 }
@@ -2878,6 +2878,9 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 	bool change_map;
 	int err;
 
+	if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] != asid)
+		goto end;
+
 	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map, asid);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
@@ -2890,6 +2893,7 @@ static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			return err;
 	}
 
+end:
 	return mlx5_vdpa_update_cvq_iotlb(mvdev, iotlb, asid);
 }
 
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
