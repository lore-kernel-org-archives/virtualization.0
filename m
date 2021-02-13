Return-Path: <SRS0=xhJn=HP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5526AC433E0
	for <virtualization@archiver.kernel.org>; Sat, 13 Feb 2021 18:39:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB8A64DCC
	for <virtualization@archiver.kernel.org>; Sat, 13 Feb 2021 18:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB8A64DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CEAF6F5A6
	for <virtualization@archiver.kernel.org>; Sat, 13 Feb 2021 18:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XzfG504Q-V_t for <virtualization@archiver.kernel.org>;
	Sat, 13 Feb 2021 18:39:37 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 7E7F26F5D2; Sat, 13 Feb 2021 18:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF8716F4C9;
	Sat, 13 Feb 2021 18:39:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDF9DC0174;
	Sat, 13 Feb 2021 18:39:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04643C013A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 18:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DFDE5869C6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 18:39:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TDOtABh9+mAn
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 18:39:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5D025869B9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 18:39:32 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60281ce30000>; Sat, 13 Feb 2021 10:39:31 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 13 Feb 2021 18:39:31 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH] vdpa: Fix memory leak in error unwinding path
Date: Sat, 13 Feb 2021 20:39:19 +0200
Message-ID: <20210213183919.248254-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613241571; bh=/byL9wtpRVPgPbXJ8B9frzV6biGMK4IPhBIDRiAHaZs=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 b=d0Xdp6Ab0QsQu7IpRZhPIHJ46oubslTwiPu/d3/OrwIHrUjfBJil4V5z3hgw7GGMq
 hTehKQRR6eyzt/5QSVYubuHI+l+rXKJKR2n/D4X11MK0wZeS6mZMCjvooRHoAs7JMy
 6u30Q5IOFnb/62opKwOFsvPJRgkyahaOshlentwxLDxvEfelT53u28H2FKa99OBupA
 UJ7psilIM2tovV8EvOb0eMKIX81PaLSnSryDNYn53D2yLC58YpmIY6QUJrSZyo48X2
 9bok0p3+ylWNdObtGfsYOv2npGgE51rB7+9DKe0ohmz03xaPe4+5s7hOV2SoFKqREX
 ZRtp8KSoo/6tg==
Cc: mst@redhat.com
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

When device get command fails to find the device or mdev,
it skips to free the skb during error unwinding path.
Fix it by freeing in error unwind path.

Fixes: a12a2f694ce8 ("vdpa: Enable user to query vdpa device info")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/vdpa/vdpa.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 3d997b389345..e3f1bfdf8d6f 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -540,20 +540,22 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!dev) {
 		mutex_unlock(&vdpa_dev_mutex);
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
-		return -ENODEV;
+		err = -ENODEV;
+		goto err;
 	}
 	vdev = container_of(dev, struct vdpa_device, dev);
 	if (!vdev->mdev) {
 		mutex_unlock(&vdpa_dev_mutex);
 		put_device(dev);
-		return -EINVAL;
+		err = -EINVAL;
+		goto err;
 	}
 	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
 	if (!err)
 		err = genlmsg_reply(msg, info);
 	put_device(dev);
 	mutex_unlock(&vdpa_dev_mutex);
-
+err:
 	if (err)
 		nlmsg_free(msg);
 	return err;
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
