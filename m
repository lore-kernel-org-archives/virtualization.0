Return-Path: <SRS0=s3M2=MC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A19C11F69
	for <virtualization@archiver.kernel.org>; Sat, 10 Jul 2021 23:51:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CE5613DC
	for <virtualization@archiver.kernel.org>; Sat, 10 Jul 2021 23:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CE5613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4470A60617;
	Sat, 10 Jul 2021 23:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8x7po4V1Zcj6; Sat, 10 Jul 2021 23:51:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD7FD60684;
	Sat, 10 Jul 2021 23:51:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0139C0010;
	Sat, 10 Jul 2021 23:51:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8DD4C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 23:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98999400CB
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 23:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J--mj7DaoC8e
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 23:51:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00082400AB
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jul 2021 23:51:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D120D613C3;
 Sat, 10 Jul 2021 23:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625961063;
 bh=ghpaVWJ+td67lKFErmQY2um8C1Z1cHXdrgKEpehURYg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rk41BMmB+7iWTqwy7/h92I/5l7GNOnfRi25vXwdFAoOwLUDl00yEOwNopyT8LEs/G
 g9UyrkshVP2/l9byd7xBTynrT2qngvtuMh7FwT52Ctk905XIVeIo4ZGRKxj6bmNfE4
 LDawvi0NWwNvco3qEtpw5i3uuWGu0GBAmQcrs+jL5o5dPG2UuOkHzLGhIZiCK8gbBC
 ytBD4qKqC0kW5vDHhpGdOO3ySs9i5KpyycsHezt7RAUpYZwQQFepyXXJD8vCmDIm5c
 Dda3SoQ25zjUiSJbjTycfdCiuARd3LS85RTJxR6Uzy8TBa2PRxcr4YBK+I8bbtJU8t
 viBdbl/tyo/Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 35/37] virtio_net: Fix error handling in
 virtnet_restore()
Date: Sat, 10 Jul 2021 19:50:13 -0400
Message-Id: <20210710235016.3221124-35-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235016.3221124-1-sashal@kernel.org>
References: <20210710235016.3221124-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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

From: Xie Yongji <xieyongji@bytedance.com>

[ Upstream commit 3f2869cace829fb4b80fc53b3ddaa7f4ba9acbf1 ]

Do some cleanups in virtnet_restore() when virtnet_cpu_notif_add() failed.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Link: https://lore.kernel.org/r/20210517084516.332-1-xieyongji@bytedance.com
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 286f836a53bf..0e7a99424fc7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3228,8 +3228,11 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
 	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	err = virtnet_cpu_notif_add(vi);
-	if (err)
+	if (err) {
+		virtnet_freeze_down(vdev);
+		remove_vq_common(vi);
 		return err;
+	}
 
 	return 0;
 }
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
