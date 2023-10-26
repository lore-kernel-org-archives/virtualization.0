Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C314DC25B48
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 20:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54ED181E7A;
	Thu, 26 Oct 2023 20:11:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54ED181E7A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ozndSAJH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W0HOZWAHJ6Eq; Thu, 26 Oct 2023 20:11:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED73F81DE0;
	Thu, 26 Oct 2023 20:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED73F81DE0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C336AC0071;
	Thu, 26 Oct 2023 20:11:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF4BAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 20:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC92B6FC4B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 20:11:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AC92B6FC4B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=ozndSAJH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZcU0drxajOs2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 20:11:22 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDBB56FC48
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 20:11:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDBB56FC48
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QJsZXs022995; Thu, 26 Oct 2023 20:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=sEJaHi8D5zE3GzzOYXpgBAdryXTBPVqu/owy7NkIqfI=;
 b=ozndSAJHokav5q61a9/P99h+OXZT7nFE2XOTsG9fbvsjRCMiFsg9cq6tfPQyXQLm9sWZ
 jLAgLxBu2IbunBBEeZp4p4JNlnqj6PkRrj6FZM3Depchcg5ZqU+hHVzjfmV+JDYQ4nKn
 2QbaPiO2324I5AjIULWX3IOAUaoSl0h3TV2LRoAIyBM19o0P6UOaU8FnAX9mvPZzATL1
 vpbmrtVBy8e0vXgy/T6prD4CR0MsUipA4b3bSEdQW9XxPMgAdrD31vI8nBG5/IaqMLwJ
 CXE9/uIEthlGjFUl653vuznIha0hqhavzamOo0usMD5spruSaw97tTj/mTbMqqdBV2AZ AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywuc84mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:11:17 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QImmU8008100; Thu, 26 Oct 2023 20:11:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqhjy4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:11:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QKBGDo004951;
 Thu, 26 Oct 2023 20:11:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3tywqhjy4c-1; Thu, 26 Oct 2023 20:11:16 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFC] vdpa/mlx5: preserve CVQ vringh index
Date: Thu, 26 Oct 2023 13:11:15 -0700
Message-Id: <1698351075-415989-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260174
X-Proofpoint-ORIG-GUID: uDbtsfEWjIDO3JobeStHxQ99AMXzJ-_w
X-Proofpoint-GUID: uDbtsfEWjIDO3JobeStHxQ99AMXzJ-_w
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, Eli Cohen <elic@nvidia.com>
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

mlx5_vdpa does not preserve userland's view of vring base for the control
queue in the following sequence:

ioctl VHOST_SET_VRING_BASE
ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
  mlx5_vdpa_set_status()
    setup_cvq_vring()
      vringh_init_iotlb()
        vringh_init_kern()
          vrh->last_avail_idx = 0;
ioctl VHOST_GET_VRING_BASE

To fix, restore the value of cvq->vring.last_avail_idx after calling
vringh_init_iotlb.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  7 ++++++-
 drivers/vhost/vringh.c            | 30 ++++++++++++++++++++++++++++++
 include/linux/vringh.h            |  2 ++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 946488b8989f..f64758143115 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 	struct mlx5_control_vq *cvq = &mvdev->cvq;
 	int err = 0;
 
-	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
+	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
+		u16 last_avail_idx = cvq->vring.last_avail_idx;
+
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
 					MLX5_CVQ_MAX_ENT, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
 
+		if (!err)
+			vringh_set_base_iotlb(&cvq->vring, last_avail_idx);
+	}
 	return err;
 }
 
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 7b8fd977f71c..799762c83007 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -595,6 +595,24 @@ static inline void __vringh_notify_disable(struct vringh *vrh,
 	}
 }
 
+static inline int __vringh_set_base(struct vringh *vrh, u16 idx,
+	                    int (*putu16)(const struct vringh *vrh,
+	                        __virtio16 *p, u16 val))
+{
+    int ret;
+
+    ret = putu16(vrh, &vrh->vring.avail->idx, idx);
+    if (ret)
+        return ret;
+
+    ret = putu16(vrh, &vrh->vring.used->idx, idx);
+    if (ret)
+        return ret;
+
+    vrh->last_avail_idx = vrh->last_used_idx = idx;
+    return 0;
+}
+
 /* Userspace access helpers: in this case, addresses are really userspace. */
 static inline int getu16_user(const struct vringh *vrh, u16 *val, const __virtio16 *p)
 {
@@ -1456,6 +1474,18 @@ void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb,
 }
 EXPORT_SYMBOL(vringh_set_iotlb);
 
+/**
+ * vringh_set_base_iotlb - set avail_idx and used_idx
+ * @vrh: the vring
+ * @idx: the value to set
+ */
+int vringh_set_base_iotlb(struct vringh *vrh, u16 idx)
+{
+    return __vringh_set_base(vrh, idx, putu16_iotlb);
+}
+EXPORT_SYMBOL(vringh_set_base_iotlb);
+
+
 /**
  * vringh_getdesc_iotlb - get next available descriptor from ring with
  * IOTLB.
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index c3a8117dabe8..e9b8af4e6a5e 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -306,6 +306,8 @@ int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
 			 struct vring_avail *avail,
 			 struct vring_used *used);
 
+int vringh_set_base_iotlb(struct vringh *vrh, u16 idx);
+
 int vringh_getdesc_iotlb(struct vringh *vrh,
 			 struct vringh_kiov *riov,
 			 struct vringh_kiov *wiov,
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
