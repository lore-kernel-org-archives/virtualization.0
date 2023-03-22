Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E20C6FD1C
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 18:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 094D261320;
	Wed, 22 Mar 2023 18:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 094D261320
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=uJjJm+G2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fgVgnAj4wEAL; Wed, 22 Mar 2023 18:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B19CB6148B;
	Wed, 22 Mar 2023 18:56:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B19CB6148B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65AD9C0071;
	Wed, 22 Mar 2023 18:56:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A53B3C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 18:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 71E706148B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 18:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71E706148B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id un8bQ00WLZmP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 18:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3F3261320
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3F3261320
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 18:56:13 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 32MIMkjQ030889; Wed, 22 Mar 2023 18:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=nXUkYuAUVgMJXfQ1b2OVpiN3TmnwlbMSYdai19XO/8o=;
 b=uJjJm+G2o9N9d0ehFB2lSzjMQcXhAkWVETOR7f1AqC7N/z6FVP10KCVZzVLoim1XlKcE
 FW6+mcYltY9Qp3jYMkh3LpiBWhvGV6Z763IXxd4W8NjTUX1X5yDooJ6WufiIdB4IiDNa
 IQFAL509YYR8+sGFZnIsLjrRVD+7vFeJE+cxXK/3EALlV85JiBzFTD79+FOW/k/CNxKC
 kzbOOqAe2r9PxDpPzf4XoVyLQTLPoalymfHO4QiI9xGMZg7og3xhzOmgYwaq+h9QiuWZ
 ae1h8NpdYmPvcP8Bwetd7gnrVOSooy6LF1nwkHMBUZoVW4hDHuHn7j69U/KXGIiiFjHZ uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd56b1qrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Mar 2023 18:56:10 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 32MIWp9n002235; Wed, 22 Mar 2023 18:56:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3pg7238srj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Mar 2023 18:56:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32MIu8UY000312;
 Wed, 22 Mar 2023 18:56:08 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-169-59.vpn.oracle.com
 [10.154.169.59])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3pg7238spf-1; Wed, 22 Mar 2023 18:56:07 +0000
From: Mike Christie <michael.christie@oracle.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, brauner@kernel.org
Subject: [PATCH 1/1] vhost_task: Fix vhost_task_create return value
Date: Wed, 22 Mar 2023 13:56:05 -0500
Message-Id: <20230322185605.1307-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_15,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=949
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220131
X-Proofpoint-ORIG-GUID: aHz4IwfU2BEZ_HtlkxtmGjInSvl1fI5p
X-Proofpoint-GUID: aHz4IwfU2BEZ_HtlkxtmGjInSvl1fI5p
Cc: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
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

vhost_task_create is supposed to return the vhost_task or NULL on
failure. This fixes it to return the correct value when the allocation
of the struct fails.

Fixes: 77feab3c4156 ("vhost_task: Allow vhost layer to use copy_process") # mainline only
Reported-by: syzbot+6b27b2d2aba1c80cc13b@syzkaller.appspotmail.com
Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/vhost_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 4b8aff160640..b7cbd66f889e 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -88,7 +88,7 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
 
 	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
 	if (!vtsk)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	init_completion(&vtsk->exited);
 	vtsk->data = arg;
 	vtsk->fn = fn;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
