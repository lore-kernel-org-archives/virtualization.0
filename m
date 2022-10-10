Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF5CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 18:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DFA2A40AA2;
	Mon, 10 Oct 2022 18:32:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFA2A40AA2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=T2ne5EhT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9sLOr-rg7H5c; Mon, 10 Oct 2022 18:32:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0D7604039D;
	Mon, 10 Oct 2022 18:32:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D7604039D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7F67C0033;
	Mon, 10 Oct 2022 18:32:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CD86C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 18:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BBF1660F34
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 18:32:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BBF1660F34
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=T2ne5EhT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nacjjL154vnl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 18:32:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B66D460C15
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B66D460C15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 18:32:41 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29AHE4uj030275;
 Mon, 10 Oct 2022 18:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=gNNvBBNPYBqKYuM1ciEmyRgavP619cN/PfYbtF960No=;
 b=T2ne5EhTPjgTzIH6M0JRwOkbEpYHwtHp8ETzO3FEY64kFbdU0yV1XyJXSbnhmDGe1KnW
 M3fpM+m82+01BJcpXZhY34N2/kshwkRJ2LDtLeLvt0Jr1+qnFeD/nSOaV3o6zerWc1+z
 6f4boE8UtFxUZaGRTFzQDEoMffxiZTNKCXLQ+8oUJrd30igmu0XI7Bw1cAzINI9NRR4D
 kKH0hxC3Q1iBpJeGlKn8vRnMrrPsUO/PAcZZaB2cfOQ33eqQKx2LeGUZ/wHWMTqPikOe
 Cr4U0e00bk+3VJcty7qMY36rRzCg8bBf61kRZlC8/OjappsK55WPNgnLdDo5JlnutXG3 +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k2yt1ck2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Oct 2022 18:32:40 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 29AFvjk7021914; Mon, 10 Oct 2022 18:32:40 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3k2yn3d2yr-1; Mon, 10 Oct 2022 18:32:39 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com
Subject: [PATCH] vdpa: merge functionally duplicated dev_features attributes
Date: Mon, 10 Oct 2022 10:27:03 -0700
Message-Id: <1665422823-18364-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_12,2022-10-10_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100108
X-Proofpoint-GUID: zkeON0obNnAy7MYQ4vZa9xQ7ZeHmZnpF
X-Proofpoint-ORIG-GUID: zkeON0obNnAy7MYQ4vZa9xQ7ZeHmZnpF
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

We can merge VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES with
VDPA_ATTR_DEV_FEATURES which is functionally equivalent.
While at it, tweak the comment in header file to make
user provioned device features distinguished from those
supported by the parent mgmtdev device: the former of
which can be inherited as a whole from the latter, or
can be a subset of the latter if explicitly specified.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/vdpa.c       | 2 +-
 include/uapi/linux/vdpa.h | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index febdc99..41ed563 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -855,7 +855,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
 
 	features_device = vdev->config->get_device_features(vdev);
 
-	if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
+	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
 			      VDPA_ATTR_PAD))
 		return -EMSGSIZE;
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 9bd7923..54b649a 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -53,11 +53,9 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
 	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
 
+	/* virtio features that are provisioned to the vDPA device */
 	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
 
-	/* virtio features that are supported by the vDPA device */
-	VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,	/* u64 */
-
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
 };
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
