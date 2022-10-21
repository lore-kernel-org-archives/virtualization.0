Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69ED1FA3741
	for <virtualization@archiver.kernel.org>; Fri, 21 Oct 2022 23:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B51E41919;
	Fri, 21 Oct 2022 23:49:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B51E41919
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HQC4zNyS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 38Ko6jajvmcj; Fri, 21 Oct 2022 23:49:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 34B5D418A7;
	Fri, 21 Oct 2022 23:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34B5D418A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7B2CC0080;
	Fri, 21 Oct 2022 23:49:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E9CAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 23:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D855060E55
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 23:49:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D855060E55
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=HQC4zNyS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JqOf-yv2shyH
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 23:49:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 130D260BB8
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 130D260BB8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 23:49:40 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LLDuC6019522;
 Fri, 21 Oct 2022 23:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=P1b5Vz6uMAabNAwiX7q1M23FaXF98wy0/Q0czLGx1dk=;
 b=HQC4zNySVtL/KEYvUZ85OSTvYHcVKBX63F7oyv7cbPqa8g3E6CHuf7d/7SEOha2d/jYr
 IGIiZk8M0TDYoevcmoZiU4rUUfxBB0x7eO9sg6aURyJ/4z/eVQfbS7FdKCpDzfVzBg/Z
 rWieJ71iJC+1lOaCJ8QO9ofn4V7PbvFE26eYCPCwTQ+PfRGEZFYatK3LH7mIahxdMEm3
 89X4hjWeQJLnLbew0D6g2IV+m+6MH1OAd+MwFguvevngIE/+BFwXAk+iR7ixQ8MmIYGD
 HA6QcQSNIboNDObvqWFqAl+TLyFVP6cEBFb6Lqwje1rpUcrkls1oM6uwGsbjplNWPpbT Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7swc7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Oct 2022 23:49:39 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29LMgIQT007144; Fri, 21 Oct 2022 23:49:39 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3k8hre9a3b-3; Fri, 21 Oct 2022 23:49:39 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com
Subject: [PATCH v3 2/4] vdpa: pass initial config to _vdpa_register_device()
Date: Fri, 21 Oct 2022 15:43:55 -0700
Message-Id: <1666392237-4042-3-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210139
X-Proofpoint-GUID: i-UeKb6RIh-aSPzyS2heCENj2RNPyc5M
X-Proofpoint-ORIG-GUID: i-UeKb6RIh-aSPzyS2heCENj2RNPyc5M
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Just as _vdpa_register_device taking @nvqs as the number of queues
to feed userspace inquery via vdpa_dev_fill(), we can follow the
same to stash config attributes in struct vdpa_device at the time
of vdpa registration.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
 drivers/vdpa/vdpa.c                  | 15 +++++++++++----
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 ++-
 include/linux/vdpa.h                 |  3 ++-
 8 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f9c0044..c54ab2c 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -771,7 +771,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	else
 		ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
 
-	ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
+	ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring, config);
 	if (ret) {
 		put_device(&adapter->vdpa.dev);
 		IFCVF_ERR(pdev, "Failed to register to vDPA bus");
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9091336..376082e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3206,7 +3206,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	mlx5_notifier_register(mdev, &ndev->nb);
 	ndev->nb_registered = true;
 	mvdev->vdev.mdev = &mgtdev->mgtdev;
-	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
+	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1, add_config);
 	if (err)
 		goto err_reg;
 
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index febdc99..bebded6 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -215,11 +215,16 @@ static int vdpa_name_match(struct device *dev, const void *data)
 	return (strcmp(dev_name(&vdev->dev), data) == 0);
 }
 
-static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
+static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
+				  const struct vdpa_dev_set_config *cfg)
 {
 	struct device *dev;
 
 	vdev->nvqs = nvqs;
+	if (cfg)
+		vdev->init_cfg = *cfg;
+	else
+		vdev->init_cfg.mask = 0ULL;
 
 	lockdep_assert_held(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
@@ -237,15 +242,17 @@ static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
  * callback after setting up valid mgmtdev for this vdpa device.
  * @vdev: the vdpa device to be registered to vDPA bus
  * @nvqs: number of virtqueues supported by this device
+ * @cfg: initial config on vdpa device creation
  *
  * Return: Returns an error when fail to add device to vDPA bus
  */
-int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
+int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
+			  const struct vdpa_dev_set_config *cfg)
 {
 	if (!vdev->mdev)
 		return -EINVAL;
 
-	return __vdpa_register_device(vdev, nvqs);
+	return __vdpa_register_device(vdev, nvqs, cfg);
 }
 EXPORT_SYMBOL_GPL(_vdpa_register_device);
 
@@ -262,7 +269,7 @@ int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
 	int err;
 
 	down_write(&vdpa_dev_lock);
-	err = __vdpa_register_device(vdev, nvqs);
+	err = __vdpa_register_device(vdev, nvqs, NULL);
 	up_write(&vdpa_dev_lock);
 	return err;
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c6db1a1..5e1cebc 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -387,7 +387,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
 
-	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_BLK_VQ_NUM);
+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_BLK_VQ_NUM, config);
 	if (ret)
 		goto put_dev;
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c3cb225..06ef5a0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -260,7 +260,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 	vdpasim_net_setup_config(simdev, config);
 
-	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM);
+	ret = _vdpa_register_device(&simdev->vdpa, VDPASIM_NET_VQ_NUM, config);
 	if (ret)
 		goto reg_err;
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 35dceee..6530fd2 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1713,7 +1713,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret)
 		return ret;
 
-	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
+	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num, config);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
 		return ret;
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index d448db0..ffdc90e 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -538,7 +538,8 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
 
 	vp_vdpa->vdpa.mdev = &vp_vdpa_mgtdev->mgtdev;
-	ret = _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
+	ret = _vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues,
+				    add_config);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
 		goto err;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 9f519a3..e68ab65 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -381,7 +381,8 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs);
 void vdpa_unregister_device(struct vdpa_device *vdev);
 
-int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs);
+int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
+			  const struct vdpa_dev_set_config *cfg);
 void _vdpa_unregister_device(struct vdpa_device *vdev);
 
 /**
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
