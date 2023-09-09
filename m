Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78FEEEB57F
	for <virtualization@archiver.kernel.org>; Sat,  9 Sep 2023 08:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4706960F82;
	Sat,  9 Sep 2023 08:45:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4706960F82
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-03-30 header.b=jwY2W2vc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7mJaf8WmhGyW; Sat,  9 Sep 2023 08:45:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA3A760F58;
	Sat,  9 Sep 2023 08:45:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA3A760F58
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0646C0DD9;
	Sat,  9 Sep 2023 08:45:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29D32C0032
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0435D60E5B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:45:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0435D60E5B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 277IlunoojC8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:44:57 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57AC260742
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Sep 2023 08:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57AC260742
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3898dIeN003749; Sat, 9 Sep 2023 08:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=wwfjx/OB200GPDGLoxpb2/crdOzbmG82Z+OGEza7gbA=;
 b=jwY2W2vcWFaozUAPl0oHZ1SNsWBkaY6pwPEQN/aIiOT+q2fQP0sPuzTceUIx3HuCPQGY
 zdEEHFLS8XS1tsS1jcllZSi4vmFK+2qoHbOmkKcUX27Ch6zRXFJnyt68gl9AeXEPO6xN
 N2uxVQcXAMgoEHMgawOfGpdr32iB7InoO1EZKphXcrHcly31tt6PBxr+2Pvq92zyIrWx
 yKGU0hVwLhAlBOaU/5QeXPjz3DQL/c5f3cACVID3RLf0xpmUFwtWniJ3DocGqdfqRNpi
 crhEEqT+alAKLyWjc4sHQAN2d+3oFz6l13GxSnjqYbcyYEyPw1XloGtRF4XZ0n8L9AMJ hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t0ncu0145-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 09 Sep 2023 08:44:56 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38954WNn002299; Sat, 9 Sep 2023 08:44:55 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t0f58qgc7-1; Sat, 09 Sep 2023 08:44:55 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: eperezma@redhat.com, jasowang@redhat.com, mst@redhat.com
Subject: [PATCH RFC v2 0/3] vdpa: dedicated descriptor table group
Date: Sat,  9 Sep 2023 01:42:36 -0700
Message-Id: <1694248959-13369-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=786 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090078
X-Proofpoint-GUID: RARovG4qCVfecs7FAZjVXmxO7-ShsEgc
X-Proofpoint-ORIG-GUID: RARovG4qCVfecs7FAZjVXmxO7-ShsEgc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Following patchset introduces dedicated group for descriptor table to
reduce live migration downtime when passthrough VQ is being switched
to shadow VQ. This RFC v2 is sent to incorporate the early feedback
from reviewers on the uAPI and driver API part of changes, the
associated driver patch set consuming ths API will come around
soon along with formal submission of this series.

Some initial performance data will be gathered using the real
hardware device with mlx5_vdpa. The target goal of this series is to
reduce the SVQ switching overhead to less than 300ms on a ~100GB
guest with 2 non-mq vhost-vdpa devices. The reduction in the downtime
is thanks to avoiding the full remap in the switching.

The plan of the intended driver implementation is to use a dedicated
group (specifically, 2 in below table) to host the descriptor tables
for data vqs, different from where buffer addresses are contained (in
group 0 as below). cvq does not have to allocate dedicated group for
descriptor table, so its buffers and descriptor table would always
belong to the same group (1 in table below).


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
