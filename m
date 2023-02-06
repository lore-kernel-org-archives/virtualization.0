Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E355C64EC5
	for <virtualization@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 259FF405A2;
	Mon,  6 Feb 2023 23:08:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 259FF405A2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2022-7-12 header.b=qwwhdXQd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENNlZ5h0BSjQ; Mon,  6 Feb 2023 23:08:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6FEEF405BC;
	Mon,  6 Feb 2023 23:08:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6FEEF405BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB5BC007D;
	Mon,  6 Feb 2023 23:08:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8661C007B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 23:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C19C040594
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 23:08:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C19C040594
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NYIJ3qP2tPDt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 23:08:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5961240590
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5961240590
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 23:08:22 +0000 (UTC)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 316KECEt024746; Mon, 6 Feb 2023 23:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2022-7-12;
 bh=j/lEJg/ReXobH4hd+iLRobue9kWLN1CWVWeI2l8aOjc=;
 b=qwwhdXQdZXD7FMgnNscW+P863qCVCOh6tvRjiV04MQPunqc9lj5Jhx9v0NO1nRcuMobU
 hWqi3wN+fEBca8diO/AofPibovmbC7EZQGsI6JPJudatoILZHMXSmYkIrjCjEI9i4DQl
 94t1c9+qeLB0G87hiKd+GHDRVue5X/ByGnMvpD4Eh/fhIIwGtbo3I5p2jz6ndQPO+7fU
 8IiNKiFCpRYHGP7VMJjaEv1477sfeAaySkYhmJociEKFHsVNN8MMM/tIPA/xYZmhvP2x
 D/YBD4jBDWwn+6ay2mgDNN+6X1vwYcOcC/3/Ze+2LFH0Z4wB0AcJ+T4hTnBwv6vt8ijF /g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhf8a458p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Feb 2023 23:08:21 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 316LbeUJ040865; Mon, 6 Feb 2023 23:08:20 GMT
Received: from ban25x6uut24.us.oracle.com (ban25x6uut24.us.oracle.com
 [10.153.73.24])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3nhdtb99m7-2; Mon, 06 Feb 2023 23:08:20 +0000
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, elic@nvidia.com
Subject: [PATCH v3 1/6] vdpa: fix improper error message when adding vdpa dev
Date: Mon,  6 Feb 2023 15:07:55 -0800
Message-Id: <1675724880-7216-2-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675724880-7216-1-git-send-email-si-wei.liu@oracle.com>
References: <1675724880-7216-1-git-send-email-si-wei.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060202
X-Proofpoint-ORIG-GUID: jc3UYtVBS5crri5Ryl2hBVF1nOIRFXDi
X-Proofpoint-GUID: jc3UYtVBS5crri5Ryl2hBVF1nOIRFXDi
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
Error: vdpa: Some provided attributes are not supported: 0x1000.
kernel answers: Operation not supported

Fixes: d8ca2fa5be1b ("vdpa: Enable user to set mac and mtu of vdpa device")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8ef7aa1..3a82ca78 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -622,9 +622,11 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 		err = PTR_ERR(mdev);
 		goto err;
 	}
+
 	if ((config.mask & mdev->config_attr_mask) != config.mask) {
-		NL_SET_ERR_MSG_MOD(info->extack,
-				   "All provided attributes are not supported");
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "Some provided attributes are not supported: 0x%llx",
+				       config.mask & ~mdev->config_attr_mask);
 		err = -EOPNOTSUPP;
 		goto err;
 	}
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
