Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC6CC77B7E
	for <virtualization@archiver.kernel.org>; Fri, 28 Apr 2023 16:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C149A842CE;
	Fri, 28 Apr 2023 16:31:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C149A842CE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=EmaRuAmV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ts3aOzRfOir6; Fri, 28 Apr 2023 16:31:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 47693842C7;
	Fri, 28 Apr 2023 16:31:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47693842C7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2521BC0036;
	Fri, 28 Apr 2023 16:31:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9341C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8942742892
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8942742892
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=EmaRuAmV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C99sbqiBL5j1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B537442893
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B537442893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Apr 2023 16:31:44 +0000 (UTC)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 33SF4Yj8031648; Fri, 28 Apr 2023 16:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=cLIMn5zMbyaKL0wEwqx2UH2vtyR/HpwCdA3U9NbdiJ0=;
 b=EmaRuAmVvkgkYhISAOonNEmH8CskXlcMIqPXGAUF2FAKh7EtVdf+f2OD0OV9j5Mb6td6
 aj5sVrghV/eVyZr/HG+7tCsbNYoAKYnKgaTx/mQKd7IKJq/wjuhiDHKuUMv0Mues9aHT
 wpV/YBLB3YwXXGlFvSt6CfWcDkCF+C4+8EhedW7VHbaece1bWxoI3nCdnA06wrFxR7hi
 /CPLseUJyFN3chxlwWZW12ilY5uJoTV//3ALNGhIOTnsa/3FPLHYanRS0J0nzL4TP4tm
 8SG+iii1vp/uoF33/n4Tl/J7lH0QaIYh6i/CxxTqCs/4SP7sYYj7SNBpE1ok+uuU14OH 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbxuev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:43 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 33SFsKSB020362; Fri, 28 Apr 2023 16:31:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3q461h8md0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Apr 2023 16:31:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33SGVYPh023567;
 Fri, 28 Apr 2023 16:31:41 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-109-59.vpn.oracle.com
 [10.154.109.59])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3q461h8m7j-6; Fri, 28 Apr 2023 16:31:41 +0000
From: Mike Christie <michael.christie@oracle.com>
To: virtualization@lists.linux-foundation.org, mst@redhat.com,
 sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Subject: [PATCH 06/14] vhost_sock: convert to vhost_vq_work_queue
Date: Fri, 28 Apr 2023 11:31:23 -0500
Message-Id: <20230428163131.92777-6-michael.christie@oracle.com>
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
X-Proofpoint-GUID: k7p2zJqr9uVeNAAGDzhgvdT_WCs9q5Kj
X-Proofpoint-ORIG-GUID: k7p2zJqr9uVeNAAGDzhgvdT_WCs9q5Kj
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

Convert from vhost_work_queue to vhost_vq_work_queue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 6578db78f0ae..817d377a3f36 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -285,7 +285,7 @@ vhost_transport_send_pkt(struct sk_buff *skb)
 		atomic_inc(&vsock->queued_replies);
 
 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
-	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
 	rcu_read_unlock();
 	return len;
@@ -583,7 +583,7 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	/* Some packets may have been queued before the device was started,
 	 * let's kick the send worker to send them.
 	 */
-	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
 
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
