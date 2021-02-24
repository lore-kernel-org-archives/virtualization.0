Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C277BC433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EC064E24
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EC064E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D0C083ACF;
	Wed, 24 Feb 2021 06:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kOla5zC4MpaD; Wed, 24 Feb 2021 06:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B3F283ADE;
	Wed, 24 Feb 2021 06:19:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC22CC0018;
	Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4362C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8FDA6F5C7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJ-cZ88YhT2R
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E16CE606BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:04 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6035efd80002>; Tue, 23 Feb 2021 22:19:04 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 24 Feb 2021 06:19:03 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next 6/9] vdpa/mlx5: Enable user to add/delete vdpa
 device
Date: Wed, 24 Feb 2021 08:18:41 +0200
Message-ID: <20210224061844.137776-7-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210224061844.137776-1-parav@nvidia.com>
References: <20210224061844.137776-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614147544; bh=d4C6GfnLQF8Sa1zXK91jB81Z8ywRQk+KaNvZsgXE04k=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=ns/MWTo5p0LhfdC7oJOPGpVwa+V2GWXZSUE/cb4IR+aYjjVR9lqLSxwq8BbQY3CKv
 0d+BGZXn83Oj/Zt8Te2afr5P9gp6wJbnTEdVq71t2PgEVBj6kZPewdeUBYZnRT+CL3
 Ke5j4wwiccdooj2yt3sqt3hVhTzp/FxhiPoD+kYaosUu8oTTVDwIdOmeXLzPFmya7A
 56vod1WGKovnKB5wW3mQisF4/dmwQrCXGRsrip3jz4UERkwo3ZDRT0nlp4cceHUnQy
 /Ha2MjQXGUjEcdoQF3gup1f9FMreQFzHWNPVWXAeWfM5QZs4MDxJCo85eSSQ3BVjW2
 /xG+gOv6Kn+pQ==
Cc: Eli Cohen <elic@nvidia.com>, mst@redhat.com
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
index 10e9b09932eb..b67bba581dfd 100644
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
-				 2 * mlx5_vdpa_max_qps(max_vqs), NULL);
+				 2 * mlx5_vdpa_max_qps(max_vqs), name);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
@@ -2009,11 +2018,12 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	if (err)
 		goto err_res;
 
-	err = vdpa_register_device(&mvdev->vdev);
+	mvdev->vdev.mdev = &mgtdev->mgtdev;
+	err = _vdpa_register_device(&mvdev->vdev);
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
