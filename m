Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308C1C433E6
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 21:49:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03AF64EDC
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 21:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03AF64EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE5B787280;
	Wed, 10 Feb 2021 21:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lg6UvQzFOZav; Wed, 10 Feb 2021 21:49:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB66087222;
	Wed, 10 Feb 2021 21:49:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4E1AC0891;
	Wed, 10 Feb 2021 21:49:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30B94C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E7BC6F56D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id doOFyrEfem1C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:49:54 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 1EBA66F516; Wed, 10 Feb 2021 21:49:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5D906F516
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 21:49:52 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ALjOiM090661;
 Wed, 10 Feb 2021 21:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Tdndnpd4eEExL2M0vXU8tvqQad0Lunj0ISddzhpccyE=;
 b=d7zvhFgaPGvV2yvUgnNVbXqvrSPC/c8VNfwGrudzxt8Phy9o4eJC32mqC3zzYIVECc2R
 1Nm2Molv8569RL54H/LFumt8ZJiPS3R5c1OHTLu3rfsmGCQRgbjqOq6+FeY+/riiWNXR
 SvJD+P73BGc8wOTMdW4h9x4EDcptGNBDdhvYIkYC1ViOvHkYTpKvCIJ2mb5iCW8sPejN
 HrqEYpiv/vqsRu14l50dF1/+FOXZM4ZJrxvp2PSGpltwlIPr0kdbtRW0kex47zno8boS
 mh4M/cOYmn0VdrZ9OWstGfmlitkw/F3QGl1nIRh7Ws7TspfsmUPwpyNmjYj1OKl2OEK0 2w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 36m4upurgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Feb 2021 21:49:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ALk1vB104194;
 Wed, 10 Feb 2021 21:49:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 36j4pqpxrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Feb 2021 21:49:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11ALnjtO002810;
 Wed, 10 Feb 2021 21:49:45 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Wed, 10 Feb 2021 13:48:42 -0800
MIME-Version: 1.0
Message-ID: <1612993680-29454-1-git-send-email-si-wei.liu@oracle.com>
Date: Wed, 10 Feb 2021 13:47:57 -0800 (PST)
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH v2 0/3] mlx5_vdpa bug fixes
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100189
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100189
Cc: si-wei.liu@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

This set attempts to fix a few independent issues recently found
in mlx5_vdpa driver. Please find details for each in the commit
message.

Patch 1 and patch 3 are already Ack'ed by Jason Wang. Patch 2 is
reworked to move virtio feature capability query to mlx5v_probe()
as suggested by Eli.

--
v1->v2: move feature capability query to probing (Eli)

Si-Wei Liu (3):
  vdpa/mlx5: should exclude header length and fcs from mtu
  vdpa/mlx5: fix feature negotiation across device reset
  vdpa/mlx5: defer clear_virtqueues to until DRIVER_OK

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  4 ++++
 drivers/vdpa/mlx5/net/mlx5_vnet.c  | 42 +++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 12 deletions(-)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
