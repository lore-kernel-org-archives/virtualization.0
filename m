Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB00C77B60
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 02:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 047C382045;
	Tue, 28 Mar 2023 02:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 047C382045
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=tD+qNWS+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gvFUQ1hA_uWI; Tue, 28 Mar 2023 02:17:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C1028204A;
	Tue, 28 Mar 2023 02:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2C1028204A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 018A8C0095;
	Tue, 28 Mar 2023 02:17:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4225C007C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7072E416BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7072E416BE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=tD+qNWS+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id euWKGfBvSevI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3519A417CF
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3519A417CF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:22 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32S24StX002382; Tue, 28 Mar 2023 02:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=utJRfCJimOAWKu00Vi7qNacxx+3R2KLWHFmZjfNQP8I=;
 b=tD+qNWS+iUHtm1R5zqCC4YUnsjBdcEnsOcGIhiqor1QGnZh5slh67zvsN30ZmGkIZG8e
 sJCJ7PW922relQiUPmJYi/Cswwv/y/SUoYfY4o3XDv43gtZUydQ+N43S02uc11Rj/nos
 gB0WzkOxaRkFwcYPbO4HEPryJDM5z2qrEt9owwyijm6wDEkVi1lcweRmDezFAnueuR0I
 fm1/4oXnW/3xaOQpLAA7rSeyRCchv0P9JWqzknM4BojLr+ah+kTmW//6PL30C0Ghf5i4
 JAxJd8DvcpKs5wyXrrwluPNmJgOuDWhPJY3/CLHdIplt8Zxnta21C3V+i2TWuZ9PqI7I 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkq4j80ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:22 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32S27TpT020404; Tue, 28 Mar 2023 02:17:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3phqd61bnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32S2FZld038246;
 Tue, 28 Mar 2023 02:17:21 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-123-40.vpn.oracle.com
 [10.154.123.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3phqd61bky-2; Tue, 28 Mar 2023 02:17:21 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v6 01/11] vhost: add vhost_worker pointer to vhost_virtqueue
Date: Mon, 27 Mar 2023 21:17:07 -0500
Message-Id: <20230328021717.42268-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328021717.42268-1-michael.christie@oracle.com>
References: <20230328021717.42268-1-michael.christie@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=980 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280016
X-Proofpoint-ORIG-GUID: 44ZhYV7Y9STuA0KYAAbl1JGeM8LsWQHl
X-Proofpoint-GUID: 44ZhYV7Y9STuA0KYAAbl1JGeM8LsWQHl
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
---
 drivers/vhost/vhost.c | 24 +++++++++++++-----------
 drivers/vhost/vhost.h |  1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4368ee9b999c..e041e116afee 100644
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
