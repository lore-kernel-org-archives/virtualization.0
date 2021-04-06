Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6183DC43460
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AC1611EE
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 17:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AC1611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CA1A84A80;
	Tue,  6 Apr 2021 17:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RkcZ6LVbc2I4; Tue,  6 Apr 2021 17:05:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B356184A4F;
	Tue,  6 Apr 2021 17:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D755CC0019;
	Tue,  6 Apr 2021 17:05:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19E0BC0018
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D57784A64
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lSh70yM3zKkd
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690069.outbound.protection.outlook.com [40.107.69.69])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 114D184A4E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 17:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrvYPcXh/FWL1cWdMP1fGeBWymjAyubYJsxMOS6dkGgUyhnm8tIreZzdR46VjHtCwpa1jlll0DeOQqpqV5bgAjUzGm05NW1qD+jtSEda3d1aNz6PPi1mxj5Zv3er6glY5/G9DoX7tVdsxGD1vjwoPNG2+xLJosidvfr1P/Gw4BM98Bw4JLN356NllBVD8xuDid13/ReYdp82SGVGFRDcUj1Dkn5pD8mX1XqtRy+dy0gDme/ktK0Ib3fGDYsxIVqT84fTOoKFZbCvXEBT4gmisbhY3O8yZQvQq2VvgDk8M+Coct4U67OqP29xiQ5Q55ydPI2FHpsYRoix73Ikrr39Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7A/tEXgdaPH1IcAlKbXi01n/mKloADXX/mOh04LmTA=;
 b=Zp2VDahM/nyEaQdYvrB5CmNCSTgo3hLZRBObeZ1I0XxfwOiVndz05PS+IY2W/CcgZZ5j4E8bdZHZnrwEGKHyxRRP85XLf2f2qO0rRA0P8XcU5Iw4HaSA+cJlk0Im2ZYg1Uacex7YTdwqleM+tEj9ElobKZLf8K8ss9ItBWAZC+CkdV3eY/K+oXqkPE9dFlrz7zkf3YCt3E8qkEWFkUnqNpCIhhAwd15nTC06PYezNm8f95VmdEmg748SzG5FPswyZGHYm4+fpOn0aH9AaK5M+fvUepr+PwHziTbntftjQdf8PrRxckccXu4Ixs27c3xVFEp7T9PNcwKsPuCTKJ0K7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7A/tEXgdaPH1IcAlKbXi01n/mKloADXX/mOh04LmTA=;
 b=uZrbJeIJ98A7IyeqGL+Nzf1FlBGqW98xzKLOo6LlnJo0N5tuo23wlYx7uvTYw0DfORj7TIVPjIFKnuLWvYiAdKEuBoq5nO7HitD5VlA4PWoEaHaGtwLsRHyNIRow/qhLGbB9+UsntIIc0J/ggyGnGoXCnp8SsIWu4TNBxKNJybeEkVUzHKFrPHhjnlQUkOrq3NdBtHZGIHM6hJI05q0SUE/lgC5iv056RjptioSGppC41n64aVshHu/BaCCFEkvZFuCDuUGnSRle6ULuu8OFuvf+0QfYMcSW9I3nX3zjOMaRSP4co+jPOEpIh/kpRVnxxQeiKtBHR6nhamfZYUpjSw==
Received: from MWHPR19CA0059.namprd19.prod.outlook.com (2603:10b6:300:94::21)
 by BN8PR12MB3569.namprd12.prod.outlook.com (2603:10b6:408:49::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 17:05:21 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::3d) by MWHPR19CA0059.outlook.office365.com
 (2603:10b6:300:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 17:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 17:05:20 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 6 Apr 2021 17:05:18 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 09/14] vdpa/mlx5: Enable user to add/delete vdpa
 device
Date: Tue, 6 Apr 2021 20:04:52 +0300
Message-ID: <20210406170457.98481-10-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406170457.98481-1-parav@nvidia.com>
References: <20210406170457.98481-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36a4170a-c4ee-42a3-0163-08d8f91e294e
X-MS-TrafficTypeDiagnostic: BN8PR12MB3569:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3569C5EBDC2F15D2E2C8E766DC769@BN8PR12MB3569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nojqcPxaHoy5hJ4g53ikA378u+ReT1b/ljYQ4PPPP5U2aoU9ckJnGAqajsrlGVq0dk6TJHlhT/CNBkUBd9TnZ/iAmTHO/smuQzAn9lh6gFRaKVX7B5CVghrBmpLtnaWtAg+2KsDQU+q825xUuRudq8upeix6FV+Z9oGmhQ3UqHeZJEYzSIqjQZumRLC7SpmMStBFr5oEYXSquNCGdnQnQ2NaMXdti7v3zNK0HoufsP5jfvl/7MCltQKrKKbz1q9ogdoCaQR4WA11VQt2SFfQiINmFQWV22pTSRhv/Cz0dVM9Nks8j5AQqKS4YFZv/NOXEbmuDFah0t0dAzbrlOInYn7cuqEbblUjOgTHWb/1mz7bo2CltJ2RuT76QjGRpPwDLrgSNkUopxEuOk8VvRhdK3SK1ZXQwAltYrom/jny/IutdLQY8rC04QhlVasiBe9IoxrNfn0EwgMnkBt2DZ894h4hyAFFnI4gwmu5rs3+OUNarfIVbZd/i4dHF6HEa14m4b+GKnW+uljkLvO36mFXbYbpaf/uNqWfkBaY4sumMc0fcvIEZ4HVVy2+OL77b3ItJPqOqQ8lf89m9FTN95DPloio//Tq/v7KFc78xFGOdd0zWxqJ38FpTohPUB+R5TdnAfBcQZRQ6k/IpnQEkZ2IGdfEBX2itwLts/1VA21jlQ4=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(82740400003)(7636003)(356005)(5660300002)(70586007)(70206006)(1076003)(6666004)(83380400001)(82310400003)(426003)(2616005)(8936002)(8676002)(36756003)(2906002)(36860700001)(6916009)(86362001)(26005)(107886003)(478600001)(4326008)(36906005)(47076005)(54906003)(316002)(16526019)(186003)(336012);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 17:05:20.9118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a4170a-c4ee-42a3-0163-08d8f91e294e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3569
Cc: elic@nvidia.com, mst@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Eli Cohen <elic@nvidia.com>

Allow to control vdpa device creation and destruction using the vdpa
management tool.

Examples:
1. List the management devices
$ vdpa mgmtdev show
pci/0000:3b:00.1:
  supported_classes net

2. Create vdpa instance
$ vdpa dev add mgmtdev pci/0000:3b:00.1 name vdpa0

3. Show vdpa devices
$ vdpa dev show
vdpa0: type network mgmtdev pci/0000:3b:00.1 vendor_id 5555 max_vqs 16 \
max_vq_size 256

Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 79 +++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 71397fdafa6a..aaf7f9394af0 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1966,23 +1966,32 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 	}
 }
 
-static int mlx5v_probe(struct auxiliary_device *adev,
-		       const struct auxiliary_device_id *id)
+struct mlx5_vdpa_mgmtdev {
+	struct vdpa_mgmt_dev mgtdev;
+	struct mlx5_adev *madev;
+	struct mlx5_vdpa_net *ndev;
+};
+
+static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 {
-	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
-	struct mlx5_core_dev *mdev = madev->mdev;
+	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
 	struct virtio_net_config *config;
 	struct mlx5_vdpa_dev *mvdev;
 	struct mlx5_vdpa_net *ndev;
+	struct mlx5_core_dev *mdev;
 	u32 max_vqs;
 	int err;
 
+	if (mgtdev->ndev)
+		return -ENOSPC;
+
+	mdev = mgtdev->madev->mdev;
 	/* we save one virtqueue for control virtqueue should we require it */
 	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
 	max_vqs = min_t(u32, max_vqs, MLX5_MAX_SUPPORTED_VQS);
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mlx5_vdpa_ops,
-				 NULL);
+				 name);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
@@ -2009,11 +2018,12 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	if (err)
 		goto err_res;
 
-	err = vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
+	mvdev->vdev.mdev = &mgtdev->mgtdev;
+	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
 	if (err)
 		goto err_reg;
 
-	dev_set_drvdata(&adev->dev, ndev);
+	mgtdev->ndev = ndev;
 	return 0;
 
 err_reg:
@@ -2026,11 +2036,62 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	return err;
 }
 
+static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
+{
+	struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
+
+	_vdpa_unregister_device(dev);
+	mgtdev->ndev = NULL;
+}
+
+static const struct vdpa_mgmtdev_ops mdev_ops = {
+	.dev_add = mlx5_vdpa_dev_add,
+	.dev_del = mlx5_vdpa_dev_del,
+};
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static int mlx5v_probe(struct auxiliary_device *adev,
+		       const struct auxiliary_device_id *id)
+
+{
+	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = madev->mdev;
+	struct mlx5_vdpa_mgmtdev *mgtdev;
+	int err;
+
+	mgtdev = kzalloc(sizeof(*mgtdev), GFP_KERNEL);
+	if (!mgtdev)
+		return -ENOMEM;
+
+	mgtdev->mgtdev.ops = &mdev_ops;
+	mgtdev->mgtdev.device = mdev->device;
+	mgtdev->mgtdev.id_table = id_table;
+	mgtdev->madev = madev;
+
+	err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
+	if (err)
+		goto reg_err;
+
+	dev_set_drvdata(&adev->dev, mgtdev);
+
+	return 0;
+
+reg_err:
+	kfree(mdev);
+	return err;
+}
+
 static void mlx5v_remove(struct auxiliary_device *adev)
 {
-	struct mlx5_vdpa_dev *mvdev = dev_get_drvdata(&adev->dev);
+	struct mlx5_vdpa_mgmtdev *mgtdev;
 
-	vdpa_unregister_device(&mvdev->vdev);
+	mgtdev = dev_get_drvdata(&adev->dev);
+	vdpa_mgmtdev_unregister(&mgtdev->mgtdev);
+	kfree(mgtdev);
 }
 
 static const struct auxiliary_device_id mlx5v_id_table[] = {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
