Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7ABCA0EC3
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 13:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17400417CD;
	Tue, 12 Sep 2023 13:02:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17400417CD
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mW9AG9Z9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HPy6e61Cc74U; Tue, 12 Sep 2023 13:02:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5F711417D9;
	Tue, 12 Sep 2023 13:02:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F711417D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 392B4C0071;
	Tue, 12 Sep 2023 13:02:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C9E0C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 579CE82153
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 579CE82153
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=mW9AG9Z9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gnWSbC0gockL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::615])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A7BD821A6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 13:02:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A7BD821A6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jycDFvQTxoRk7FZPv1YfHoR3Cb+kxmhM3d0k5yUVvM/KqSZrNGutpHWju4/iUzkwZU2xK00b05ji2V01H/1gwsDTpGfbQPRnaGpysmwWLg/WVyaIn9nrZ9rAap+85S9mdkjfiRe1VMPJBMWMWjh+mNDoh0zsOAKy0xvoDj++q4+AZYFg3pSj/t3cjzvdRNN1LVEbXpylP6FyVmZB2X1EaKbo32N3a5Ouz1ejQeQktXtotxY8E/KjhHHrJQYYp2ZuAVEj7ywxibaE43BV+p3eGnp38Mz+h9spBolufL4LUppOa0R1TPGf3e85JCEVDqiqcUkTRlWYoZWfJO/wW/qy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN7szLTCXb+wWgzLhnuPBQbz7RGrjIznjedtZvLDUog=;
 b=ALG0qkVQkNMLaVvptloJvLT1wKGDceHujGZ3NDml9pEaozMPhF+d4QT96Qi3xQqqIfRGQw7vgVvhG0K4rTrI2WsaNpxr6tz4yfH1vKzx9Xu3FGEyY/WEaEHrmOpXtgDzGwMjJi/7+ebSfTk3ELV8FR6ZwXLgo5TrMCssPeLDMAxmZXZPSw2QHPLfsHyo543aL6gVgGY5a/WKviAGkTqlTjZuHaqET1cebYvrWwOXI3ADSY9TmDrj3JNHSfLbVbPcOqr3J3M0NyeI2Fqj6TsHCe6p+q1c3KDYgWxvdaqJ/6bcH+9wFyCVkfqFjWu/1pQdYc59YEFQDIcNuynn7vE1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN7szLTCXb+wWgzLhnuPBQbz7RGrjIznjedtZvLDUog=;
 b=mW9AG9Z9f0xhyiybYSpuHACPMVS73BcGKPYuCsxi2uVv5zBCqlSJ+AjRzUctg+48YQ58LLPjZjm5N1SMmUvMJlgxC4JWmdO6SA8EkfqNWrpwvSxKmS+lljyID/8xp5oYT/A87gYcY/rRX1dUestFxQT52UUbw426XD2Peyxhi3Rz9XntWyuIc1Fh09w1cSrqKlehyBXqybcRJmdGONgqND5Fiq2No72tJukSNaG0Gx2U+ET+AWHHb8ejh8Xdqi25FVScN4CAqKN7H9FOsftiESJT/ImtV5CdEI5Pcilto7BWdsH0OBz4lWSFo8j3hKG/rsupX9N7FZyDmJfhK8RAiQ==
Received: from CY5PR22CA0074.namprd22.prod.outlook.com (2603:10b6:930:80::22)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 12 Sep
 2023 13:02:23 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::f2) by CY5PR22CA0074.outlook.office365.com
 (2603:10b6:930:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 13:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 13:02:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 12 Sep 2023
 06:02:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 12 Sep
 2023 06:02:12 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via
 Frontend Transport; Tue, 12 Sep 2023 06:02:10 -0700
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
 <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 <virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/16] vdpa/mlx5: Rename mr destroy functions
Date: Tue, 12 Sep 2023 16:01:18 +0300
Message-ID: <20230912130132.561193-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912130132.561193-1-dtatulea@nvidia.com>
References: <20230912130132.561193-1-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 5863f2f8-7067-41fa-a467-08dbb390816c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPQPpErM8U7QrA+m9ENXwgoH1V4fNzEys0q6pbF/mXtmwCz6CsMMjWvzA7zy1i6rJaqjUvYmUpiO/FoNC/fkijofVPMTRWZVS3m6fW3K+dWpvcvuQiEHaaExNIj8RVtBrRNxI3RtECQNCYXR3R9QCBeBtlojFH8eGr45tElMB5bCC7ZWs1YkqcJ4TmSSd8M/bUUMPmJIukTvJ3x3N9/JBcaoBG+N1nKPBMQhh8m5t7fIzPqehHaOpqeA5nyT4xWHQiHTQV60Xer1jFK6WD4QKtLI9zChEKOmnvpkcvOk2X/rUy2G/znbKNUOToXipKuUDgbvIX3VlOXQnwt/JopBtTwpZKZqnTh6ivzf2yZGqw374PIYs0lxt3bcgSotousSl0u9dT4BEUmbRWx+rumQ62GQ5nujDAsK/jm94hE3Vpc4FcY4EmQrP9y7v5+HL6ui65YBsvq3TdxJ+UDMGF0uc7+8cZfyDchJHxmNpbj9OOfMrUtAgf3v7ItY32X3uQdMx3S9My9OMRvWvMBVdukdAUQ6+QE5jsWqqncBgYgNGTmkVg52OQb7Lo1gDUW28FxAdNy6NSHooWGAxHChEiNRT2NL5plWwTG3gdw6Ss8vd4UvoutCvPlBsC2CVTwcL9fKRja8XvrwSR49RgvYB/LRsR3DDwzvNq0gzlbZBKL+E4YEgCqeSPqpcwCGaL3E9rxtDORMZNEFxkhQrkqbgJFlIb9D01wN0DgslD8yCH1ZmvhNdKnmtw8hiVfvsZZhbPJI
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(4326008)(40480700001)(8676002)(8936002)(36756003)(26005)(40460700003)(7636003)(356005)(86362001)(5660300002)(82740400003)(2906002)(36860700001)(47076005)(336012)(426003)(70586007)(83380400001)(70206006)(110136005)(41300700001)(2616005)(1076003)(478600001)(54906003)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:02:22.9537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5863f2f8-7067-41fa-a467-08dbb390816c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org
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

Make mlx5_destroy_mr symmetric to mlx5_create_mr.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++--
 drivers/vdpa/mlx5/core/mr.c        |  6 +++---
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 554899a80241..e1e6e7aba50e 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -118,8 +118,8 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 			     bool *change_map, unsigned int asid);
 int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb,
 			unsigned int asid);
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
-void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
+void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev);
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
 int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *mvdev,
 				struct vhost_iotlb *iotlb,
 				unsigned int asid);
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index fde00497f4ad..00dcce190a1f 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -507,7 +507,7 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid
 	mr->initialized = false;
 }
 
-void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
+void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 {
 	struct mlx5_vdpa_mr *mr = &mvdev->mr;
 
@@ -518,9 +518,9 @@ void mlx5_vdpa_destroy_mr_asid(struct mlx5_vdpa_dev *mvdev, unsigned int asid)
 	mutex_unlock(&mr->mkey_mtx);
 }
 
-void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
+void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
 {
-	mlx5_vdpa_destroy_mr_asid(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
+	mlx5_vdpa_destroy_mr(mvdev, mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]);
 	prune_iotlb(mvdev);
 }
 
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 061d8f7a661a..4d759ab96319 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2644,7 +2644,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 		goto err_mr;
 
 	teardown_driver(ndev);
-	mlx5_vdpa_destroy_mr_asid(mvdev, asid);
+	mlx5_vdpa_destroy_mr(mvdev, asid);
 	err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
 	if (err)
 		goto err_mr;
@@ -2660,7 +2660,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 	return 0;
 
 err_setup:
-	mlx5_vdpa_destroy_mr_asid(mvdev, asid);
+	mlx5_vdpa_destroy_mr(mvdev, asid);
 err_mr:
 	return err;
 }
@@ -2797,7 +2797,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 err_driver:
 	unregister_link_notifier(ndev);
 err_setup:
-	mlx5_vdpa_destroy_mr(&ndev->mvdev);
+	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
 err_clear:
 	up_write(&ndev->reslock);
@@ -2824,7 +2824,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
 	unregister_link_notifier(ndev);
 	teardown_driver(ndev);
 	clear_vqs_ready(ndev);
-	mlx5_vdpa_destroy_mr(&ndev->mvdev);
+	mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
 	ndev->mvdev.status = 0;
 	ndev->mvdev.suspended = false;
 	ndev->cur_num_vqs = 0;
@@ -2944,7 +2944,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
 	free_resources(ndev);
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr_resources(mvdev);
 	if (!is_zero_ether_addr(ndev->config.mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
 		mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
@@ -3474,7 +3474,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 err_res2:
 	free_resources(ndev);
 err_mr:
-	mlx5_vdpa_destroy_mr(mvdev);
+	mlx5_vdpa_destroy_mr_resources(mvdev);
 err_res:
 	mlx5_vdpa_free_resources(&ndev->mvdev);
 err_mpfs:
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
