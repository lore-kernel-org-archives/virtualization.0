Return-Path: <SRS0=dwtO=HI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C90CC433E0
	for <virtualization@archiver.kernel.org>; Sat,  6 Feb 2021 13:18:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F6764EBC
	for <virtualization@archiver.kernel.org>; Sat,  6 Feb 2021 13:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F6764EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E7A6F87160;
	Sat,  6 Feb 2021 13:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtETnaHhh+zW; Sat,  6 Feb 2021 13:18:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 81F128714D;
	Sat,  6 Feb 2021 13:18:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BC64C0174;
	Sat,  6 Feb 2021 13:18:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7448C013A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D237187163
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UM6Neut3w1pl
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 440C98714D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 13:17:12 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 116D946u057665;
 Sat, 6 Feb 2021 13:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Zzsxe15nl3d988vk8AaqrmaUEcvQcJ5h5MrS5qwe/Xw=;
 b=ZgrOZj4abAsDitUmibPdAcO5HB7+NZf4gLbivW8HRCrPP1WAc4Ln6xgG1qhNf5zEnrBu
 QWlmJ5dpDfTveGnX2fxRs/ijF7X2E/iMhpwZ/BuTZJQBv4U4d+HKIu1cJRNorXbveP3l
 HzT+p5HJ9elQa9BVoW159wKv7JISv3RUJWh77YakhlZohoZuafh+yjISRBLpi4ZKbLu8
 0Uf8ZXhAjC3fPpLcG16KwB620aKZ8TTRjWJyFzaDQh1ylrX1oIV1aWNjMZWtqmK93OdJ
 YaM51oK2Ixi+mqw6UXlwDb6BQYe2mGEytg34hUbMbZZyVibNvMjTTgDoHFgPKWz0cmTl Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 36hjhqgn9e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 06 Feb 2021 13:17:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 116DAQvt028419;
 Sat, 6 Feb 2021 13:17:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 36hjeh3f64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 06 Feb 2021 13:17:09 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 116DH8h0030613;
 Sat, 6 Feb 2021 13:17:08 GMT
Received: from ban25x6uut24.us.oracle.com (/10.153.73.24) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Sat, 06 Feb 2021 05:16:17 -0800
MIME-Version: 1.0
Message-ID: <1612614564-4220-2-git-send-email-si-wei.liu@oracle.com>
Date: Sat, 6 Feb 2021 04:29:23 -0800 (PST)
From: Si-Wei Liu <si-wei.liu@oracle.com>
To: mst@redhat.com, jasowang@redhat.com, elic@nvidia.com
Subject: [PATCH 2/3] mlx5_vdpa: fix feature negotiation across device reset
References: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1612614564-4220-1-git-send-email-si-wei.liu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102060093
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102060093
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

The mlx_features denotes the capability for which
set of virtio features is supported by device. In
principle, this field needs not be cleared during
virtio device reset, as this capability is static
and does not change across reset.

In fact, the current code may have the assumption
that mlx_features can be reloaded from firmware
via the .get_features ops after device is reset
(via the .set_status ops), which is unfortunately
not true. The userspace VMM might save a copy
of backend capable features and won't call into
kernel again to get it on reset. This causes all
virtio features getting disabled on newly created
virtqs after device reset, while guest would hold
mismatched view of available features. For e.g.,
the guest may still assume tx checksum offload
is available after reset and feature negotiation,
causing frames with bogus (incomplete) checksum
transmitted on the wire.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b8416c4..aa6f8cd 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1788,7 +1788,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 		clear_virtqueues(ndev);
 		mlx5_vdpa_destroy_mr(&ndev->mvdev);
 		ndev->mvdev.status = 0;
-		ndev->mvdev.mlx_features = 0;
 		++mvdev->generation;
 		return;
 	}
-- 
1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
