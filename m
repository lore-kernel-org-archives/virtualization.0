Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960D0C77B61
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 02:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DBCB82049;
	Tue, 28 Mar 2023 02:17:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DBCB82049
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=bDNiqAJy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxiZE1s6vaqw; Tue, 28 Mar 2023 02:17:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 82E9881FC8;
	Tue, 28 Mar 2023 02:17:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82E9881FC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F361C008B;
	Tue, 28 Mar 2023 02:17:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DA38C008D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 284014010C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 284014010C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=bDNiqAJy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oyt16n11X7X1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E5E8400EC
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E5E8400EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 02:17:27 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32S252xl007155; Tue, 28 Mar 2023 02:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=1fpSE9dlt149eut5r/Jt5roHU1Rj/YqS9kJnqgS/2l0=;
 b=bDNiqAJypo2nL9d7YX1z429aVSjPciL25a+TBiJ2CD621T9vhe8Sq7A7owSqUCMje4PC
 MBK8flfGpeW+a8sOalmFxa6SCB4LdTHKgBzq4BX5n2txwuIOhIvtZngb5NaZIzEj0vaM
 1Xhm4+0vLWyPobNrC+NIbOHweQ4GGDgqjrRg9xHgR4Z4/0qnsHGsyt2pEQp/2XczDMxS
 GsBcqeAJVPuV2QM1Bx+CCunXJXLW4eQFLfrfwTaCQgiH02OiteEjjC039IRqLQv45JSj
 qJhkJWahws/ZQri+Z0Yp8TsqJU+JjGfeKJlfoQTXpJzuMm+h+ikKG97I/vzuSsrDIY9w iw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkq4k00e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:26 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32S0KoWZ020554; Tue, 28 Mar 2023 02:17:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3phqd61bqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Mar 2023 02:17:25 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32S2FZlj038246;
 Tue, 28 Mar 2023 02:17:24 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-123-40.vpn.oracle.com
 [10.154.123.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3phqd61bky-5; Tue, 28 Mar 2023 02:17:24 +0000
From: Mike Christie <michael.christie@oracle.com>
To: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
 sgarzare@redhat.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v6 04/11] vhost: take worker or vq instead of dev for flushing
Date: Mon, 27 Mar 2023 21:17:10 -0500
Message-Id: <20230328021717.42268-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328021717.42268-1-michael.christie@oracle.com>
References: <20230328021717.42268-1-michael.christie@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280016
X-Proofpoint-ORIG-GUID: tmYzLcSqwAcDYaxdYDpStxOBLMCdLFHF
X-Proofpoint-GUID: tmYzLcSqwAcDYaxdYDpStxOBLMCdLFHF
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
---
 drivers/vhost/vhost.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index cc2628ba9a77..6160aa1cc922 100644
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
