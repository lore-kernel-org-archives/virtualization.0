Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AD9C433B4
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 01:50:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B269861451
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 01:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B269861451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60A98419C0;
	Thu, 29 Apr 2021 01:50:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yEjwrfwM9CQw; Thu, 29 Apr 2021 01:50:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFB6C419BB;
	Thu, 29 Apr 2021 01:50:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A28EC000F;
	Thu, 29 Apr 2021 01:50:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A52B5C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 01:50:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 863038250B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 01:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BEQr1wLDVBPP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 01:50:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA81F84662
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 01:50:40 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T1mkHg009817;
 Thu, 29 Apr 2021 01:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=CEhFXbkeV5jb4Bwi3UMetDKwSUynvsvV1cHuD5gAY6A=;
 b=vRzuye4UEHqr2A54aSqyzq4bTMIfuAr/6Cwr3V/bSxOBkGubiNHwpqNvbhYERZbv9UFs
 sKsLSlHGbtykAD+/m7s4FL92vlGtmyBo+ymnO1Dm0blIRy1jdrMAmnhjw8Mv/CBmv0pf
 wBKtGNtrVr2l8lSadVNkOLlHsSbUemFfGbzlx2bmiM8rdW7BFXzNQwPvFlaVpnwW8pWD
 mYgnYFBUF7r7Q+nSmjiuLR5Gl+5PqiRxrpDmI2Ymp8uS7VGFpcZKcorwlEN4jMI/SQlx
 OUAkgXu7RX4elZbzMQlOh/CTBnQM8Tcj1hIYeFqZ+ZDsQu4iVQ84Ra9TQfX0+BeMTma5 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 385afq2ty9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 01:50:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T1oZIn023971;
 Thu, 29 Apr 2021 01:50:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 384w3vhppu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 01:50:37 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13T1oaYp024126;
 Thu, 29 Apr 2021 01:50:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 384w3vhpmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Apr 2021 01:50:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13T1oQGa007139;
 Thu, 29 Apr 2021 01:50:26 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 28 Apr 2021 18:50:26 -0700
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH v3 0/1] mlx5_vdpa bug fix for feature negotiation
Date: Wed, 28 Apr 2021 21:48:53 -0400
Message-Id: <1619660934-30910-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-ORIG-GUID: rrt_UaoDzYl39b02gY1zZs7WqvyHmeBO
X-Proofpoint-GUID: rrt_UaoDzYl39b02gY1zZs7WqvyHmeBO
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290011
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This v3 consisting of one single patch only is a follow-up 
to the v2 of mlx5_vdpa bug fix series as in:

https://lore.kernel.org/virtualization/1612993680-29454-1-git-send-email-si-wei.liu@oracle.com

which initially attempted to fix a few independent issues in the
mlx5_vdpa driver.

Presently Patch #1 in the original series was piggybacked and got
merged through a separate patchset:

https://lore.kernel.org/virtualization/20210406170457.98481-13-parav@nvidia.com/

and the issue Patch #3 tried to fix was addressed by another patch,

https://lore.kernel.org/virtualization/a5356a13-6d7d-8086-bfff-ff869aec5449@redhat.com/

that leaves Patch #2 in the original v2 series unmerged. Since it
was already Ack'ed by Jason and Eli in v2, just get it reposted
while dropping others after syncing with the current vhost tree.

Thanks,

--
v2->v3: drop merged patches from previous series;
        repost with updated commit message
v1->v2: move feature capability query to probing (Eli)

Si-Wei Liu (1):
  vdpa/mlx5: fix feature negotiation across device reset

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
