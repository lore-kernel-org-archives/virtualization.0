Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DD5C61DA4
	for <virtualization@archiver.kernel.org>; Mon,  6 Feb 2023 23:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86F0F60C03;
	Mon,  6 Feb 2023 23:12:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86F0F60C03
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=a+JTZ2nN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EInRSyv8qF9d; Mon,  6 Feb 2023 23:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2309860D5B;
	Mon,  6 Feb 2023 23:12:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2309860D5B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC37EC0071;
	Mon,  6 Feb 2023 23:12:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D801C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 23:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 584554160B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 23:12:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 584554160B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=a+JTZ2nN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IzzacK5pqs0M
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 23:12:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B6264150E
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B6264150E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 23:12:26 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 316KDs7K003917; Mon, 6 Feb 2023 23:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=rqLjb7Eq7PhCO+c3t5Ma4CPmiNDolUZo9sZGERYgDXk=;
 b=a+JTZ2nNEPkF9aBL8ncX5UiDJJNm9xk1KnCfUyrEKWabJAIFKXIeahTQO4yJH/5nvJXW
 XwKm6ej+XcBW8vUnzaHIy9StaGpVT4vj8PHT2Q+5MutGug0Y6Uow1pyiFrJUWqPi87J8
 WgSP7fBqsy776WI/2Rn4xAdL59p33oaFEUDHYXppSm0sSi346kIZtQAFyCRBmAHONNRw
 Y+ZzrS2pjxUAYggIgUteNFsuY5ei/jcXAH5V2Uz0MtxebdUC/Wz4bwZAzYoLjmWX0N1p
 Eum78uJLPtEkYQahyTj9Pe5HdMYmJAiKOH4GrmiFjT2F0V8CEQQsUcGotjC+NpW7P4Eq FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytv8bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Feb 2023 23:12:25 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 316LpWgp021033; Mon, 6 Feb 2023 23:12:24 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3nhdt4sj6f-1; Mon, 06 Feb 2023 23:12:24 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH RESENT v4 0/6] features provisioning fixes and mlx5_vdpa
 support
Date: Mon,  6 Feb 2023 15:11:58 -0800
Message-Id: <1675725124-7375-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060202
X-Proofpoint-GUID: sMkSKpJqvpXunl3q339Xx1j39Rc-awbv
X-Proofpoint-ORIG-GUID: sMkSKpJqvpXunl3q339Xx1j39Rc-awbv
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

This patchset is pre-requisite to export and provision device
config attributes and features for vdpa live migration, in a way
backward and forward compatibility can be retained. The follow up
work [1] will need to be built around the new feature provisioning
uAPI, with which it's easier to formalize migration compatibility
support at the driver level.

Thanks,
-Siwei

[1] [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
https://lore.kernel.org/virtualization/1666392237-4042-1-git-send-email-si-wei.liu@oracle.com/

---
v3 -> v4:
  - rewrite while loop to a for loop per mst's call
  - fix wording in the subject of patch
v2 -> v3:
  - fix incorrect reference of local variable in future patch
  - prohibit per-device bitmask macro from exposure in uapi header
  - add fixes tag
v1 -> v2:
  - include specific attribute info to error message 
  - move conditional feature presence in mlx5_vdpa config space
    to a separate patch
  - remove redundant check
---

Si-Wei Liu (6):
  vdpa: fix improper error message when adding vdpa dev
  vdpa: conditionally read STATUS in config space
  vdpa: validate provisioned device features against specified attribute
  vdpa: validate device feature provisioning against supported class
  vdpa/mlx5: make MTU/STATUS presence conditional on feature bits
  vdpa/mlx5: support device features provisioning

 drivers/vdpa/mlx5/net/mlx5_vnet.c |  71 ++++++++++++++++++++------
 drivers/vdpa/vdpa.c               | 103 ++++++++++++++++++++++++++++++++------
 2 files changed, 144 insertions(+), 30 deletions(-)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
