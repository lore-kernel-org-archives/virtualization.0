Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C9AC77B60
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 16:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 949266FED4;
	Fri, 28 Apr 2023 16:31:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 949266FED4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=FTVEYR5H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ziKkMKpL98SB; Fri, 28 Apr 2023 16:31:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22F1560B65;
	Fri, 28 Apr 2023 16:31:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22F1560B65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08892C0036;
	Fri, 28 Apr 2023 16:31:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E37EC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2846540533
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2846540533
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=FTVEYR5H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gG_WSxiWlvs
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C21AB400B9
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C21AB400B9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:36 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33SF3pJs013966; Fri, 28 Apr 2023 16:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=LbRG2wydDSxjX1ixTgj57Utu1ty0LbZUNt+2VutbgGo=;
 b=FTVEYR5HFaMgS3UoyJpcFmO33Lnb3uTi0MFl9nrBMMknSYXCre+0FthyLvgbucZiV9iV
 +5NZvEDCzEc6JKd8RSo5ecAtcSnq49eskVVdVlthgrCjolCJ753KMiXYFIy5VfUOanFl
 XQRkCnc1s7MtO8urLG7DE5VvtIzqrw/F7duOw+EgeN8FoAI/LGIb+k5Vi9Yq/k2YgdI3
 w91k4V06B7/rBNskW7Ny2PozcxUXGW164WkvJWTqxrOCAYo5UC3Z36YVFCwZ1MWvxzhH
 7H6+OeWHdyOriW87p62Kd39dqwdD5Uk9ZYIiTmVsrHLEUaQWNI6cwCb9BXe6j1ioY7Ei eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q460dekku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:35 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33SFsWbV020469; Fri, 28 Apr 2023 16:31:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3q461h8m8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:34 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SGVYPX023567;
 Fri, 28 Apr 2023 16:31:34 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-109-59.vpn.oracle.com
 [10.154.109.59])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3q461h8m7j-1; Fri, 28 Apr 2023 16:31:34 +0000
From: Mike Christie <michael.christie@oracle.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: [PATCH 01/14] vhost: add vhost_worker pointer to vhost_virtqueue
Date: Fri, 28 Apr 2023 11:31:18 -0500
Message-Id: <20230428163131.92777-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280133
X-Proofpoint-GUID: zLX7JY6OUpCqJ1kKr3pcBuD-hiYT40m0
X-Proofpoint-ORIG-GUID: zLX7JY6OUpCqJ1kKr3pcBuD-hiYT40m0
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

This patchset allows userspace to map vqs to different workers. This
patch adds a worker pointer to the vq so we can store that info.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 24 +++++++++++++-----------
 drivers/vhost/vhost.h |  1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 10bf35a3db6e..7a8eef246e1f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -486,6 +486,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->log = NULL;
 		vq->indirect = NULL;
 		vq->heads = NULL;
+		vq->worker = NULL;
 		vq->dev = dev;
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
@@ -554,16 +555,15 @@ static void vhost_worker_free(struct vhost_dev *dev)
 	kfree(worker);
 }
 
-static int vhost_worker_create(struct vhost_dev *dev)
+static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
 	struct vhost_task *vtsk;
 	char name[TASK_COMM_LEN];
-	int ret;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
 	if (!worker)
-		return -ENOMEM;
+		return NULL;
 
 	dev->worker = worker;
 	worker->kcov_handle = kcov_common_handle();
@@ -571,25 +571,24 @@ static int vhost_worker_create(struct vhost_dev *dev)
 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
 
 	vtsk = vhost_task_create(vhost_worker, worker, name);
-	if (!vtsk) {
-		ret = -ENOMEM;
+	if (!vtsk)
 		goto free_worker;
-	}
 
 	worker->vtsk = vtsk;
 	vhost_task_start(vtsk);
-	return 0;
+	return worker;
 
 free_worker:
 	kfree(worker);
 	dev->worker = NULL;
-	return ret;
+	return NULL;
 }
 
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	int err;
+	struct vhost_worker *worker;
+	int err, i;
 
 	/* Is there an owner already? */
 	if (vhost_dev_has_owner(dev)) {
@@ -600,9 +599,12 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 	vhost_attach_mm(dev);
 
 	if (dev->use_worker) {
-		err = vhost_worker_create(dev);
-		if (err)
+		worker = vhost_worker_create(dev);
+		if (!worker)
 			goto err_worker;
+
+		for (i = 0; i < dev->nvqs; i++)
+			dev->vqs[i]->worker = worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0308638cdeee..e72b665ba3a5 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -74,6 +74,7 @@ struct vhost_vring_call {
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
+	struct vhost_worker *worker;
 
 	/* The actual ring of buffers. */
 	struct mutex mutex;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
