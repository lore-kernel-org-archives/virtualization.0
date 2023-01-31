Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E09C636D7
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 23:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B28BD41516;
	Tue, 31 Jan 2023 23:22:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B28BD41516
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=BUnktRU2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X_VoEGLQb2zp; Tue, 31 Jan 2023 23:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8CD1409EB;
	Tue, 31 Jan 2023 23:22:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8CD1409EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D504C0083;
	Tue, 31 Jan 2023 23:22:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D693C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 23:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23EA240947
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 23:22:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23EA240947
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5PM0FkECBClV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 23:22:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4691240936
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4691240936
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 23:22:26 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30VIiH7A021428; Tue, 31 Jan 2023 23:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=r0Xf7HwYTIa5HdBeaweSNt2PODdB5AMoLanWqL4vsmE=;
 b=BUnktRU2vwxC/uFjHpEvn6ISYNM1vWBs/qmac0ANisN6YzjgOuGQ1LvA3c/63h2fQ8l+
 HXFba+DVS68CjBHXNkqXR1tVQ4atC3AIe3dIuU3CqFRe2vxLJlJmPxP7SVWePb1RyhMQ
 P7bJtVRBQjxwAr01OY8hVDqPIPp+AwyJHr3C9hibR+3rPkndTb2qiDZpAVlX+6uJw08C
 xOz6tsFB+X0+BiN/qxX2dGax/BbJjOGdDysiBdWkDezURD2MIfWnievjhi1BK3k8lHaD
 fnFILnVqej6Ww1nEIQUd2doXiGHpYHVbtI/+i0pUfme55QzczLT3A/xhamLatR12Vg2T PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvr8q23c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Jan 2023 23:22:25 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 30VMuk9L031540; Tue, 31 Jan 2023 23:22:24 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3nct5d8c94-2; Tue, 31 Jan 2023 23:22:23 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH 1/6] vdpa: fix improper error message when adding vdpa dev
Date: Tue, 31 Jan 2023 15:22:02 -0800
Message-Id: <1675207327-22289-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
References: <1675207327-22289-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310201
X-Proofpoint-GUID: L0k5arDU938cX72WhdbrMRGjMC5w9dFr
X-Proofpoint-ORIG-GUID: L0k5arDU938cX72WhdbrMRGjMC5w9dFr
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

In below example, before the fix, mtu attribute is supported
by the parent mgmtdev, but the error message showing "All
provided are not supported" is just misleading.

$ vdpa mgmtdev show
vdpasim_net:
  supported_classes net
  max_supported_vqs 3
  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

$ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
Error: vdpa: All provided attributes are not supported.
kernel answers: Operation not supported

After fix, the relevant error message will be like:

$ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
Error: vdpa: Some provided attributes are not supported.
kernel answers: Operation not supported

$ vdpa dev add mgmtdev vdpasim_net name vdpasim0 max_vqp 2
Error: vdpa: All provided attributes are not supported.
kernel answers: Operation not supported

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8ef7aa1..5e57935 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -622,13 +622,20 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		err = PTR_ERR(mdev);
 		goto err;
 	}
-	if ((config.mask & mdev->config_attr_mask) != config.mask) {
+	if (config.mask && (config.mask & mdev->config_attr_mask) == 0) {
 		NL_SET_ERR_MSG_MOD(info->extack,
 				   "All provided attributes are not supported");
 		err = -EOPNOTSUPP;
 		goto err;
 	}
 
+	if ((config.mask & mdev->config_attr_mask) != config.mask) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "Some provided attributes are not supported");
+		err = -EOPNOTSUPP;
+		goto err;
+	}
+
 	err = mdev->ops->dev_add(mdev, name, &config);
 err:
 	up_write(&vdpa_dev_lock);
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
