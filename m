Return-Path: <SRS0=/j96=DI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A5EC47423
	for <virtualization@archiver.kernel.org>; Thu,  1 Oct 2020 21:01:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14540206E5
	for <virtualization@archiver.kernel.org>; Thu,  1 Oct 2020 21:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o6P8Cd50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14540206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8719186BE2;
	Thu,  1 Oct 2020 21:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fABsFg6Sz1DQ; Thu,  1 Oct 2020 21:01:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22B4D86BC0;
	Thu,  1 Oct 2020 21:01:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2F92C0889;
	Thu,  1 Oct 2020 21:01:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 029CAC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 21:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EC2D386BC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 21:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7EuSKOLxfKQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 21:01:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 468D486BC0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 21:01:35 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091L03gw134672;
 Thu, 1 Oct 2020 21:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=zXkx84w5tl9t6q8pRAhHxciaF+0XLChHsEh+wOkrN40=;
 b=o6P8Cd50cKYGE6Xe+70KXlv0b+jS8OxYNjWisXb2+Ie78bGN6JTQtrkv4BNVnfto03fC
 Hy321fkMA6m+b5tffWZXsQk9s4OWmRgcyRbOpm7WlMg+rQyu65gKmpOaDJ4NR7v7FKQM
 Q8LOk6TsHmEDz6v9F9QPqhi9X0LF2FzwmVQYu61+vddiLCbKEjHwY3NH1cMeetNzc1MU
 slehNrPMVHoyHwpkR/UP7oOiabp7GWiTWZKbseH8dsIj6Cuxgy9IeW8emMTOL8x1W+bN
 D8AAZ6nNBooVqBTzil8V6zrNC2l2NxmY+OkfVgCtATrQtz2FQHlx1+rlfqPjCfsjORKu CQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2130.oracle.com with ESMTP id 33su5b8g02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 01 Oct 2020 21:01:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091KixfQ097828;
 Thu, 1 Oct 2020 20:59:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33uv2hea2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Oct 2020 20:59:33 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 091KxXfe024670;
 Thu, 1 Oct 2020 20:59:33 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 01 Oct 2020 13:59:32 -0700
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com
Subject: [PATCH] vdpa/mlx5: should keep avail_index despite device status
Date: Thu,  1 Oct 2020 16:18:31 -0400
Message-Id: <1601583511-15138-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010169
Cc: virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 linux-kernel@vger.kernel.org
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

A VM with mlx5 vDPA has below warnings while being reset:

vhost VQ 0 ring restore failed: -1: Resource temporarily unavailable (11)
vhost VQ 1 ring restore failed: -1: Resource temporarily unavailable (11)

We should allow userspace emulating the virtio device be
able to get to vq's avail_index, regardless of vDPA device
status. Save the index that was last seen when virtq was
stopped, so that userspace doesn't complain.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 70676a6..74264e59 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1133,15 +1133,17 @@ static void suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
 	if (!mvq->initialized)
 		return;
 
-	if (query_virtqueue(ndev, mvq, &attr)) {
-		mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue\n");
-		return;
-	}
 	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
 		return;
 
 	if (modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND))
 		mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed\n");
+
+	if (query_virtqueue(ndev, mvq, &attr)) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue\n");
+		return;
+	}
+	mvq->avail_idx = attr.available_index;
 }
 
 static void suspend_vqs(struct mlx5_vdpa_net *ndev)
@@ -1411,8 +1413,14 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa
 	struct mlx5_virtq_attr attr;
 	int err;
 
-	if (!mvq->initialized)
-		return -EAGAIN;
+	/* If the virtq object was destroyed, use the value saved at
+	 * the last minute of suspend_vq. This caters for userspace
+	 * that cares about emulating the index after vq is stopped.
+	 */
+	if (!mvq->initialized) {
+		state->avail_index = mvq->avail_idx;
+		return 0;
+	}
 
 	err = query_virtqueue(ndev, mvq, &attr);
 	if (err) {
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
