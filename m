Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF850C25B6B
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 07:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8198D415D1;
	Thu, 26 Oct 2023 07:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8198D415D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=a+36HKk2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0NO80q8lBXzl; Thu, 26 Oct 2023 07:17:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A24F8415C3;
	Thu, 26 Oct 2023 07:17:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A24F8415C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89062C0071;
	Thu, 26 Oct 2023 07:17:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B6EDC0DDC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65282830DE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65282830DE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=a+36HKk2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z1ziCYUhg7PV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:33 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 932E7830AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 07:17:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 932E7830AB
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39Q3mvbF004657; Thu, 26 Oct 2023 07:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=iL+GGI9lnqphQGpGgu+EO6uIkX+l48HLl5Adt3nu9dI=;
 b=a+36HKk20oSIoM9/1HIRu8lWJPCsRjni/9LbxBkI6jQ4scvh9Bmiv0sXq5sgoKrd3VZF
 LP/Cdwx+pnSWA69yaeyfWJ9KACFRfhd/1FVUubeXz+RJVYW1XwL23aJ1ib7Ljcm4cefE
 JPhLr3yGST/eneUWHmXSzVqnIL4ZzSsGZqcsqoLxqIwMHM+yh5bprvVdHLM2016CXSkI
 MoZb8AWFMeOZcK3K7osgwvcvHeqPucVRv5+KMeoonfMH+nmGcuxfJvxuNB+Qk/KcVNTT
 FZIiF7se1Yu1AsqucXmLH6YprnGXjbgSs5BNenZ5qKqobGJCMFZkfb9Z/HeGH4rdZvtl mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e3a9v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 07:17:32 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39Q6tbAK015200; Thu, 26 Oct 2023 07:17:31 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3tv537t53r-6; Thu, 26 Oct 2023 07:17:31 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
 sgarzare@redhat.com, dtatulea@nvidia.com
Subject: [PATCH v5 5/7] vhost-vdpa: clean iotlb map during reset for older
 userspace
Date: Thu, 26 Oct 2023 00:14:38 -0700
Message-Id: <1698304480-18463-6-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
References: <1698304480-18463-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=966
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260060
X-Proofpoint-GUID: TdFbP2b_FDK7GJTHhaF0eCwLPiYKBicx
X-Proofpoint-ORIG-GUID: TdFbP2b_FDK7GJTHhaF0eCwLPiYKBicx
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

Using .compat_reset op from the previous patch, the buggy .reset
behaviour can be kept as-is on older userspace apps, which don't ack the
IOTLB_PERSIST backend feature. As this compatibility quirk is limited to
those drivers that used to be buggy in the past, it won't affect change
the behaviour or affect ABI on the setups with API compliant driver.

The separation of .compat_reset from the regular .reset allows
vhost-vdpa able to know which driver had broken behaviour before, so it
can apply the corresponding compatibility quirk to the individual driver
whenever needed.  Compared to overloading the existing .reset with
flags, .compat_reset won't cause any extra burden to the implementation
of every compliant driver.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/vhost/vdpa.c         | 20 ++++++++++++++++----
 drivers/virtio/virtio_vdpa.c |  2 +-
 include/linux/vdpa.h         |  7 +++++--
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index acc7c74ba7d6..30df5c58db73 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -227,13 +227,24 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 	irq_bypass_unregister_producer(&vq->call_ctx.producer);
 }
 
-static int vhost_vdpa_reset(struct vhost_vdpa *v)
+static int _compat_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
+	u32 flags = 0;
 
-	v->in_batch = 0;
+	if (v->vdev.vqs) {
+		flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
+						    VHOST_BACKEND_F_IOTLB_PERSIST) ?
+			 VDPA_RESET_F_CLEAN_MAP : 0;
+	}
+
+	return vdpa_reset(vdpa, flags);
+}
 
-	return vdpa_reset(vdpa);
+static int vhost_vdpa_reset(struct vhost_vdpa *v)
+{
+	v->in_batch = 0;
+	return _compat_vdpa_reset(v);
 }
 
 static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
@@ -312,7 +323,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 			vhost_vdpa_unsetup_vq_irq(v, i);
 
 	if (status == 0) {
-		ret = vdpa_reset(vdpa);
+		ret = _compat_vdpa_reset(v);
 		if (ret)
 			return ret;
 	} else
@@ -1344,6 +1355,7 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
 	vhost_vdpa_free_domain(v);
 	vhost_dev_cleanup(&v->vdev);
 	kfree(v->vdev.vqs);
+	v->vdev.vqs = NULL;
 }
 
 static int vhost_vdpa_open(struct inode *inode, struct file *filep)
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 06ce6d8c2e00..8d63e5923d24 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -100,7 +100,7 @@ static void virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	vdpa_reset(vdpa);
+	vdpa_reset(vdpa, 0);
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6b8cbf75712d..db15ac07f8a6 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -519,14 +519,17 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
 	return vdev->dma_dev;
 }
 
-static inline int vdpa_reset(struct vdpa_device *vdev)
+static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
 {
 	const struct vdpa_config_ops *ops = vdev->config;
 	int ret;
 
 	down_write(&vdev->cf_lock);
 	vdev->features_valid = false;
-	ret = ops->reset(vdev);
+	if (ops->compat_reset && flags)
+		ret = ops->compat_reset(vdev, flags);
+	else
+		ret = ops->reset(vdev);
 	up_write(&vdev->cf_lock);
 	return ret;
 }
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
