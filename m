Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB00FC433E6
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:32:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63ED120DD4
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 03:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ED120DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 13C248681B;
	Mon,  4 Jan 2021 03:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7kLhdZx11+S; Mon,  4 Jan 2021 03:32:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CDF508683F;
	Mon,  4 Jan 2021 03:32:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C473CC0893;
	Mon,  4 Jan 2021 03:32:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BADBEC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AE6E22051F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R06JZw7PgS7y
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by silver.osuosl.org (Postfix) with ESMTPS id 950EF1FEF0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 03:32:24 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff28c480000>; Sun, 03 Jan 2021 19:32:24 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Mon, 4 Jan 2021 03:32:23 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v2 7/7] vdpa_sim_net: Add support for user
 supported devices
Date: Mon, 4 Jan 2021 05:31:41 +0200
Message-ID: <20210104033141.105876-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210104033141.105876-1-parav@nvidia.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210104033141.105876-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609731144; bh=sOQV4nudA1BXJOUqsZ0mGzsnDoZQc9SZHPbEt9crKvw=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=LAVShhn0J2anGnPqp39XzFWNib4ynQq584B6B6HD3EAjXEinHvgUQ3JvEkhYSIVAP
 iKcJBnf0VeYsRiOHB9L5TBTJZzKPXCDDdY9/3JFdd6Z5R1f0nfJVW4PtlT7/EO3ifL
 kfRjPFTsYiUzAYhfqFaQ9evr/CW+YJ/dDkFGwpnz5JzFQykYEIXRa7s5uR2wfrJ2OC
 gFm4glm5nlmyC++UIzvgu5i2+F6JKkhMJUQ7u2McX9ZLoQc21pryjc/oDfnRN0iPnD
 XKhzarABTygNgTPUodWrHpwq5KRrjCVph5LVbBMRlVGfu+Zk8guwN2pEOKp2ptsIl2
 pVyfUcTb0lxBg==
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com
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

Enable user to create vdpasim net simulate devices.

Show vdpa management device that supports creating, deleting vdpa devices.

$ vdpa mgmtdev show
vdpasim_net:
  supported_classes
    net

$ vdpa mgmtdev show -jp
{
    "show": {
        "vdpasim_net": {
            "supported_classes": {
              "net"
        }
    }
}

Create a vdpa device of type networking named as "foo2" from
the management device vdpasim:

$ vdpa dev add mgmtdev vdpasim_net name foo2

Show the newly created vdpa device by its name:
$ vdpa dev show foo2
foo2: type network mgmtdev vdpasim_net vendor_id 0 max_vqs 2 max_vq_size 256

$ vdpa dev show foo2 -jp
{
    "dev": {
        "foo2": {
            "type": "network",
            "mgmtdev": "vdpasim_net",
            "vendor_id": 0,
            "max_vqs": 2,
            "max_vq_size": 256
        }
    }
}

Delete the vdpa device after its use:
$ vdpa dev del foo2

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
Changelog:
v1->v2:
 - rebased
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  3 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  2 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 92 ++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index db1636a99ba4..d5942842432d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -235,7 +235,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		ops = &vdpasim_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
-				    dev_attr->nvqs, NULL);
+				    dev_attr->nvqs, dev_attr->name);
 	if (!vdpasim)
 		goto err_alloc;
 
@@ -249,6 +249,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		goto err_iommu;
 	set_dma_ops(dev, &vdpasim_dma_ops);
+	vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
 
 	vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
 	if (!vdpasim->config)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index b02142293d5b..6d75444f9948 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -33,6 +33,8 @@ struct vdpasim_virtqueue {
 };
 
 struct vdpasim_dev_attr {
+	struct vdpa_mgmt_dev *mgmt_dev;
+	const char *name;
 	u64 supported_features;
 	size_t config_size;
 	size_t buffer_size;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 34155831538c..b795e02bdad0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -162,6 +162,94 @@ static void vdpasim_net_default_dev_unregister(void)
 	vdpa_unregister_device(vdpa);
 }
 
+static void vdpasim_net_mgmtdev_release(struct device *dev)
+{
+}
+
+static struct device vdpasim_net_mgmtdev = {
+	.init_name = "vdpasim_net",
+	.release = vdpasim_net_mgmtdev_release,
+};
+
+static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
+{
+	struct vdpasim_dev_attr dev_attr = {};
+	struct vdpasim *simdev;
+	int ret;
+
+	dev_attr.mgmt_dev = mdev;
+	dev_attr.name = name;
+	dev_attr.id = VIRTIO_ID_NET;
+	dev_attr.supported_features = VDPASIM_NET_FEATURES;
+	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
+	dev_attr.config_size = sizeof(struct virtio_net_config);
+	dev_attr.get_config = vdpasim_net_get_config;
+	dev_attr.work_fn = vdpasim_net_work;
+	dev_attr.buffer_size = PAGE_SIZE;
+
+	simdev = vdpasim_create(&dev_attr);
+	if (IS_ERR(simdev))
+		return PTR_ERR(simdev);
+
+	ret = _vdpa_register_device(&simdev->vdpa);
+	if (ret)
+		goto reg_err;
+
+	return 0;
+
+reg_err:
+	put_device(&simdev->vdpa.dev);
+	return ret;
+}
+
+static void vdpasim_net_dev_del(struct vdpa_mgmt_dev *mdev,
+				struct vdpa_device *dev)
+{
+	struct vdpasim *simdev = container_of(dev, struct vdpasim, vdpa);
+
+	_vdpa_unregister_device(&simdev->vdpa);
+}
+
+static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops = {
+	.dev_add = vdpasim_net_dev_add,
+	.dev_del = vdpasim_net_dev_del
+};
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct vdpa_mgmt_dev mgmt_dev = {
+	.device = &vdpasim_net_mgmtdev,
+	.id_table = id_table,
+	.ops = &vdpasim_net_mgmtdev_ops,
+};
+
+static int vdpasim_net_mgmtdev_init(void)
+{
+	int ret;
+
+	ret = device_register(&vdpasim_net_mgmtdev);
+	if (ret)
+		return ret;
+
+	ret = vdpa_mgmtdev_register(&mgmt_dev);
+	if (ret)
+		goto parent_err;
+	return 0;
+
+parent_err:
+	device_unregister(&vdpasim_net_mgmtdev);
+	return ret;
+}
+
+static void vdpasim_net_mgmtdev_cleanup(void)
+{
+	vdpa_mgmtdev_unregister(&mgmt_dev);
+	device_unregister(&vdpasim_net_mgmtdev);
+}
+
 static int __init vdpasim_net_init(void)
 {
 	int ret = 0;
@@ -176,6 +264,8 @@ static int __init vdpasim_net_init(void)
 
 	if (default_device)
 		ret = vdpasim_net_default_dev_register();
+	else
+		ret = vdpasim_net_mgmtdev_init();
 	return ret;
 }
 
@@ -183,6 +273,8 @@ static void __exit vdpasim_net_exit(void)
 {
 	if (default_device)
 		vdpasim_net_default_dev_unregister();
+	else
+		vdpasim_net_mgmtdev_cleanup();
 }
 
 module_init(vdpasim_net_init);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
