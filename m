Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E30C636CD
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 21:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1ECC8208C;
	Mon, 30 Jan 2023 21:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F1ECC8208C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=iewcRZoL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zN-hwynEmo3c; Mon, 30 Jan 2023 21:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95579822B6;
	Mon, 30 Jan 2023 21:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 95579822B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E015C007F;
	Mon, 30 Jan 2023 21:37:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ECF9C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF937704A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF937704A6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=iewcRZoL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EkRlY7b3w3ma
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:37:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5C3B702E3
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5C3B702E3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 21:37:24 +0000 (UTC)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30UL3uD8004244; Mon, 30 Jan 2023 21:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=t7qcF4HWMxrV8l58tGxaDXS4xRP41Hcy7/t+u7kgys0=;
 b=iewcRZoL3kDhtcYYGSJ66GY8hW1qFJYpuZeLttuXAPc6MFcHtlS0nhgQxAok5BSMRyUE
 y3eiPgiax8qh6oD3w1aW8xpFet3Qg8UOFjU+QSVM26NTBkWOxcbBdO3w2sbWW5topVrD
 zSW7pwhtfIBjaLPsbfaC+mM6RoT5k0ZdcHaksS1N+NaEkZmcLPFlfTTtbbtZKAXzYWYo
 p4S6hEX0tBNiWzNqBG5ANGpBbtw/ZPTvJGCNyX3nm+C+xtE7r7cQ3/FlCXrD7Bypb7Zn
 517u8JXEayV5B/JSp7W4ApipT3IHEgYKbCCingNLEXa31DrqQqO16UErKkO+xxU2JTki eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvqwv3gj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jan 2023 21:37:23 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 30UK8hq2031798; Mon, 30 Jan 2023 21:37:22 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3nct54qa7f-5; Mon, 30 Jan 2023 21:37:22 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH 4/6] virtio: VIRTIO_DEVICE_F_MASK for all per-device features
Date: Mon, 30 Jan 2023 12:30:41 -0800
Message-Id: <1675110643-28143-5-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300200
X-Proofpoint-ORIG-GUID: t9Q0xg6tFlNqxE9pU81AP5Q1c_F5cLIM
X-Proofpoint-GUID: t9Q0xg6tFlNqxE9pU81AP5Q1c_F5cLIM
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

Introduce VIRTIO_DEVICE_F_MASK bitmask used for identification
of per-device features. Feature bits VIRTIO_TRANSPORT_F_START
through VIRTIO_TRANSPORT_F_END are reserved for transport
features hence are not counted as per-device features against
the 64bit feature space.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/uapi/linux/virtio_config.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 3c05162..3bdc7ed 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -54,6 +54,14 @@
 #define VIRTIO_TRANSPORT_F_START	28
 #define VIRTIO_TRANSPORT_F_END		41
 
+/*
+ * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_START
+ * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
+ * all 64bit features
+ */
+#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
+			      ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
+
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
  * suppressed them? */
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
