Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F73C7EE21
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 16:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B4D0842C3;
	Fri, 28 Apr 2023 16:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B4D0842C3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=gnAsz2ar
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJnAVnxSmUYv; Fri, 28 Apr 2023 16:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B786C84100;
	Fri, 28 Apr 2023 16:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B786C84100
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FFA4C0036;
	Fri, 28 Apr 2023 16:31:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA6B7C0090
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4A3B6FED8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C4A3B6FED8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=gnAsz2ar
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DVkdsDTN455
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D0D560B65
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D0D560B65
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:40 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33SF3oFG020040; Fri, 28 Apr 2023 16:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=MMipRdJyARLVDob9ubjZ3HZ/EHRcJ4qPatByvM7HEns=;
 b=gnAsz2aruwnaAHOLmgSdT4HTFOYPH1cgmvFKYMfUrn4ieR/QzP1TNvknwf70Qowvcn0d
 FDyDw1gT8GXx6qeHLIi2Q07NKCI+EHshgOh9sSuGKJEgi89nHfDf6vwo2zbEhIVuwzy/
 3+oDjW38dWIkMkYogUnDXiSy1aPLBzyvHJ7jXspqGmVidT8EcnMBiONhI/HCR41MlzX8
 4FANd5miOQxkVrwJocmj7gwHiEqvgAqKjhH0PHm2Fv6BeWAiGyaX+JETcAD+tPLqGFgh
 lIptmKmyThOVBP8fCwGIn65CTlCOzxyzKoBuPjCB5tKCB5EHxAt8iHKs5jgFLqoSGqZp Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q476u6mwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:39 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33SFxbJC020360; Fri, 28 Apr 2023 16:31:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3q461h8mbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:39 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SGVYPd023567;
 Fri, 28 Apr 2023 16:31:38 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-109-59.vpn.oracle.com
 [10.154.109.59])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3q461h8m7j-4; Fri, 28 Apr 2023 16:31:38 +0000
From: Mike Christie <michael.christie@oracle.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: [PATCH 04/14] vhost: take worker or vq instead of dev for flushing
Date: Fri, 28 Apr 2023 11:31:21 -0500
Message-Id: <20230428163131.92777-4-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428163131.92777-1-michael.christie@oracle.com>
References: <20230428163131.92777-1-michael.christie@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304280133
X-Proofpoint-GUID: nMirWIm_9t8rlLgOZSGuESgx2O4KwJEF
X-Proofpoint-ORIG-GUID: nMirWIm_9t8rlLgOZSGuESgx2O4KwJEF
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

This patch has the core work flush function take a worker. When we
support multiple workers we can then flush each worker during device
removal, stoppage, etc.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index faf1dcf0af30..957f33f9ad25 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -247,6 +247,20 @@ static void vhost_work_queue_on(struct vhost_worker *worker,
 	}
 }
 
+static void vhost_work_flush_on(struct vhost_worker *worker)
+{
+	struct vhost_flush_struct flush;
+
+	if (!worker)
+		return;
+
+	init_completion(&flush.wait_event);
+	vhost_work_init(&flush.work, vhost_flush_work);
+
+	vhost_work_queue_on(worker, &flush.work);
+	wait_for_completion(&flush.wait_event);
+}
+
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 {
 	vhost_work_queue_on(dev->worker, work);
@@ -261,15 +275,7 @@ EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
 
 void vhost_dev_flush(struct vhost_dev *dev)
 {
-	struct vhost_flush_struct flush;
-
-	if (dev->worker) {
-		init_completion(&flush.wait_event);
-		vhost_work_init(&flush.work, vhost_flush_work);
-
-		vhost_work_queue(dev, &flush.work);
-		wait_for_completion(&flush.wait_event);
-	}
+	vhost_work_flush_on(dev->worker);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_flush);
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
