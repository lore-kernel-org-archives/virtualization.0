Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE8EE732EA
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 16:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A42E2615B3;
	Thu, 28 Sep 2023 16:50:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A42E2615B3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cjBZTUUu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7TV6qPHn9kf; Thu, 28 Sep 2023 16:50:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1D14861199;
	Thu, 28 Sep 2023 16:50:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D14861199
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07F46C0071;
	Thu, 28 Sep 2023 16:50:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58AD2C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FCB683AA3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3FCB683AA3
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=cjBZTUUu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRIAQBLGkJFT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 14B0781CA3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 16:50:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14B0781CA3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvgYBte1eOu0UBDgUh+8ODgy48ddEN03y+E9wEDZLwa+BlnqD4pSqCSWgGgH1rEBGKfVVySRspvVCn2ufSAadOjL5XHthg3vSlHvqkkwGc5MNLSNHv7MpQZdyg11sVXorjOC4ctNCYf3egNn5fQHOqQJuH8PjekPybt0QaDIFtP3FCIYaGXgkzYpZehVKXjtOed7bGIQb5LBzvTVfL2s9rNkrCpD6Uzwi4eL9HXkDySstpz0AWdh7RFZuYS64Pc+qkdcAmm3NEwWlvowKPAKpiWNQkxSKKaeGUWCVUZuAVCGM3eDFF+V92noJPpIPuEyAxIhDCzyNfR3kMjmGmpe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pugKhXn1yyJ2eySbGpZefWpS3s+uIziF5TphRI58E5w=;
 b=YHyvHb+8frVH2OJZnrRW+ysYrZu1OP3+kVsAFpbzJ+Zvkd1xK3yv6B6M02M8R/prerV0DMYUuyQdAhWKzTxS9iYq5hJHsdZtb1txx85ob513wEHa9blzdfzgz/qYhhbbObT7jw07U7nCghXr79MlV+5AxShtW1JlTj6/B8+61VzKoNAYnGkx+poo0kzBfTnLZ9YKcr0aeAy8QF7w5PjGuB5g1GrYf+3cyures4rYGBm/1zQ2UPbOJosB0re4gXL1SufK+Pqee5mcQnsU8iGRKQISeHSjpF2PHc9l6TwRJ6JMZ43C5pJ2E5W9EgPmmIlfgb3Vo3H3/XUB6a+AeqFYpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pugKhXn1yyJ2eySbGpZefWpS3s+uIziF5TphRI58E5w=;
 b=cjBZTUUusX34zRWyErUREsLDQOigKqUQnirQrYCZMVucfQbJ5uLXqhCeCPzXyRmPPtTj8u08s1bkDOe6rcHbIiBn3G6pbfAq4f/byCePafn7tT3wAPARzvzzEm+5jxvvKudmFeKPZw87izA4QDKVPnBbzwwdaOr08iHZ8nb+DIGJHu9XUSkstvIJ760sZb/hJ8DEdhc1GiAvjrH7t98NDHu4o/18Zgwbt2c3fbU8fpJD+Cq4+7uN4D799Bo77N7L8ioGxZRfqNezazkgXpTRDfRh/s4/YQk6HoQOCtcf9Gvvm0PiISA6bFz59+/YmaAjsJmslBz/CobRRH0JPO/STg==
Received: from MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::28)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 16:50:09 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::83) by MW4P223CA0023.outlook.office365.com
 (2603:10b6:303:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25 via Frontend
 Transport; Thu, 28 Sep 2023 16:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 28 Sep 2023 16:50:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 28 Sep
 2023 09:49:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 28 Sep 2023 09:49:58 -0700
Received: from c-237-113-220-225.mtl.labs.mlnx (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Thu, 28 Sep 2023 09:49:56 -0700
To: <eperezma@redhat.com>, <gal@nvidia.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: [PATCH vhost 11/16] vdpa/mlx5: Move mr mutex out of mr struct
Date: Thu, 28 Sep 2023 19:45:22 +0300
Message-ID: <20230928164550.980832-13-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: cd71045f-783c-486a-fd41-08dbc042f9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4otg5Ue9/XaMs9MDhxqT3Rx0GB80C8kjBAHDhgtCEIQ8Jwds2w2XyMPTewtcHuv+fyNtvH8+UU+PnP2c/6c0Mtrx+HiaIyoH+Pg5XBLO64/8YrqkCpgKsWPzIp1l3i0GGd3Xdk7RssFeOBQJeLSbu+CzICp3kori9NtTp9lJrBuCuZoI/LTu/ynPuk5xqDjyolVhGQUs+wXZBnngNYnm0KvY5xrMJhVhmP82KpwVXakcv0+qeHMPJCxwqbI5To/FdAmrOszQW6D4aLdzgq6emg1Jm/lwOwPwZ48Ru5ZOrCaLcDbCHs4vR+bEAgfIRG6VB7zeqiSOG/DqfMbB/bFFv46qU2jL4kIOsH94gOx/V9w0ZD9Q4RCUPcgwHyvFJyJm55kaa6Kxa75LECTF/sC/SC99js/T+VRzue8knnhqMoe0OfKNpZPCl2JT4G82WJy3EZr13bBrirqlHCLc4ok98PQs28ILDj7LJ34o6nO5MyGAHowiIvnpcY1nGMigAiWoIrk4dp7GixYoIgbcKoZNK/4Z/hm9m380OST0w7+/kqJ5TbptJ23l/LQkmO47IWf0ym8dEwuZud/tnQMxusAiDI5RFr98lJtRQjHKrz8XGSBjSR4EnY0T5c1H7UIWuI9tBZ8/5a13Yf24KOjMlxLqWigx0X/qlP246KhU4ltgi4bgwNj/urgkR/0/cFqWPAamriYinYXM/jzvznzN0ZntNIgxdLZzYsRD/PF9Qfxuh7/cFYiXgAh/b3LrkREW5tVm
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(426003)(47076005)(40460700003)(356005)(2906002)(66899024)(86362001)(5660300002)(82740400003)(7636003)(6666004)(36756003)(83380400001)(478600001)(40480700001)(2616005)(4326008)(1076003)(8936002)(41300700001)(8676002)(110136005)(336012)(26005)(54906003)(70586007)(316002)(36860700001)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 16:50:09.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd71045f-783c-486a-fd41-08dbc042f9b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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

The mutex is named like it is supposed to protect only the mkey but in
reality it is a global lock for all mr resources.

Shift the mutex to it's rightful location (struct mlx5_vdpa_dev) and
give it a more appropriate name.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++--
 drivers/vdpa/mlx5/core/mr.c        | 13 +++++++------
 drivers/vdpa/mlx5/core/resources.c |  6 +++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
index 01d4ee58ccb1..9c6ac42c21e1 100644
--- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
@@ -34,8 +34,6 @@ struct mlx5_vdpa_mr {
 	/* state of dvq mr */
 	bool initialized;
 
-	/* serialize mkey creation and destruction */
-	struct mutex mkey_mtx;
 	bool user_mr;
 };
 
@@ -94,6 +92,8 @@ struct mlx5_vdpa_dev {
 	u32 generation;
 
 	struct mlx5_vdpa_mr mr;
+	/* serialize mr access */
+	struct mutex mr_mtx;
 	struct mlx5_control_vq cvq;
 	struct workqueue_struct *wq;
 	unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index 6f29e8eaabb1..abd6a6fb122f 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -509,11 +509,11 @@ static void _mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_
 void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev,
 			  struct mlx5_vdpa_mr *mr)
 {
-	mutex_lock(&mr->mkey_mtx);
+	mutex_lock(&mvdev->mr_mtx);
 
 	_mlx5_vdpa_destroy_mr(mvdev, mr);
 
-	mutex_unlock(&mr->mkey_mtx);
+	mutex_unlock(&mvdev->mr_mtx);
 }
 
 void mlx5_vdpa_destroy_mr_resources(struct mlx5_vdpa_dev *mvdev)
@@ -550,9 +550,10 @@ int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
 {
 	int err;
 
-	mutex_lock(&mvdev->mr.mkey_mtx);
+	mutex_lock(&mvdev->mr_mtx);
 	err = _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
-	mutex_unlock(&mvdev->mr.mkey_mtx);
+	mutex_unlock(&mvdev->mr_mtx);
+
 	return err;
 }
 
@@ -563,14 +564,14 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
 	int err = 0;
 
 	*change_map = false;
-	mutex_lock(&mr->mkey_mtx);
+	mutex_lock(&mvdev->mr_mtx);
 	if (mr->initialized) {
 		mlx5_vdpa_info(mvdev, "memory map update\n");
 		*change_map = true;
 	}
 	if (!*change_map)
 		err = _mlx5_vdpa_create_mr(mvdev, mr, iotlb);
-	mutex_unlock(&mr->mkey_mtx);
+	mutex_unlock(&mvdev->mr_mtx);
 
 	return err;
 }
diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
index d5a59c9035fb..5c5a41b64bfc 100644
--- a/drivers/vdpa/mlx5/core/resources.c
+++ b/drivers/vdpa/mlx5/core/resources.c
@@ -256,7 +256,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
 		mlx5_vdpa_warn(mvdev, "resources already allocated\n");
 		return -EINVAL;
 	}
-	mutex_init(&mvdev->mr.mkey_mtx);
+	mutex_init(&mvdev->mr_mtx);
 	res->uar = mlx5_get_uars_page(mdev);
 	if (IS_ERR(res->uar)) {
 		err = PTR_ERR(res->uar);
@@ -301,7 +301,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
 err_uctx:
 	mlx5_put_uars_page(mdev, res->uar);
 err_uars:
-	mutex_destroy(&mvdev->mr.mkey_mtx);
+	mutex_destroy(&mvdev->mr_mtx);
 	return err;
 }
 
@@ -318,6 +318,6 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *mvdev)
 	dealloc_pd(mvdev, res->pdn, res->uid);
 	destroy_uctx(mvdev, res->uid);
 	mlx5_put_uars_page(mvdev->mdev, res->uar);
-	mutex_destroy(&mvdev->mr.mkey_mtx);
+	mutex_destroy(&mvdev->mr_mtx);
 	res->valid = false;
 }
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
