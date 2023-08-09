Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA57C04A6A
	for <virtualization@archiver.kernel.org>; Wed,  9 Aug 2023 12:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE75C8216C;
	Wed,  9 Aug 2023 12:56:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE75C8216C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=vry9LAYb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kTDWOAaYpt9X; Wed,  9 Aug 2023 12:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9184782127;
	Wed,  9 Aug 2023 12:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9184782127
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C60C0071;
	Wed,  9 Aug 2023 12:56:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54798C0DD4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27C206059B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27C206059B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=vry9LAYb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id skdtvMKrHRsf
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:45 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B64960597
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Aug 2023 12:56:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B64960597
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 379CrXId007909; Wed, 9 Aug 2023 12:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=k0kCVWckhCMjXSkcyiM8kVlzsSbHdstRKe95debTpsY=;
 b=vry9LAYbY4TgGMfadmOYAn+KVlgj/QvLTby7o0VgQW8oO8V3JaaR92MUqz9+p3YDASqB
 wuLjt3qxWWunv9N48fWUAFct4I6nMK9303SJa2KHFuX6huLEaknGFzJWiMZeQgsNEM8k
 sDeskB8r/duVAQJ9eaLTZMmOpFk9DPeBZnbuSn0sg07fJO2xoBPo+mKYuXpQTnUnEX9c
 +aStEtArq+H2xKSW+Yx3JNMAwjN2oAmo7li+lKuWLA0aF69x7uc1QVK8QhtlG1hrqUSW
 MtV3LByBPTGxUf8sHZEGFRROCXylrxikNmj+LUxcSSUwyTMPzOuKazVFsOh3gssJDPo4 cA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9cuerg54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Aug 2023 12:56:44 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 379CFxLI030509; Wed, 9 Aug 2023 12:56:43 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3s9cvdf832-1; Wed, 09 Aug 2023 12:56:43 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com,
 dtatulea@nvidia.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH RFC 0/3] vdpa: dedicated descriptor table group
Date: Wed,  9 Aug 2023 05:54:40 -0700
Message-Id: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=353
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090114
X-Proofpoint-ORIG-GUID: C65L6gQq-Tt_gaaBCsCmXlDtjdOYNBOb
X-Proofpoint-GUID: C65L6gQq-Tt_gaaBCsCmXlDtjdOYNBOb
Cc: virtualization@lists.linux-foundation.org
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

Following patchset introduces dedicated group for descriptor table to
reduce live migration downtime when passthrough VQ is being switched
to shadow VQ. As this RFC set is to seek early feedback on the uAPI
and driver API part, for now there's no associated driver patch consuming
the API. As soon as the support is in place on both hardware device and
driver, performance data will be show using real hardware device. The
target goal of this series is to reduce the SVQ switching overhead
to less than 300ms on a ~100GB guest with 2 non-mq vhost-vdpa devices.

The plan of the intended driver implementation is to use a dedicated
group (specifically, 2 in below table) to host descriptor table for
all data vqs, different from where buffer addresses are contained (in
group 0 as below). cvq does not have to allocate dedicated group for
descriptor table, so its buffers and descriptor table would always
belong to a same group (1).


              |  data vq | ctrl vq
==============+==========+===========
vq_group      |    0     |    1
vq_desc_group |    2     |    1


---

Si-Wei Liu (3):
  vdpa: introduce dedicated descriptor group for virtqueue
  vhost-vdpa: introduce descriptor group backend feature
  vhost-vdpa: uAPI to get dedicated descriptor group id

 drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
 include/linux/vdpa.h             | 11 +++++++++++
 include/uapi/linux/vhost.h       |  8 ++++++++
 include/uapi/linux/vhost_types.h |  5 +++++
 4 files changed, 51 insertions(+)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
