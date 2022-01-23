Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC86C433FE
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0A2240A67;
	Sun, 23 Jan 2022 00:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CaI-zTPjsp2m; Sun, 23 Jan 2022 00:14:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10D02405AB;
	Sun, 23 Jan 2022 00:14:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9394C0039;
	Sun, 23 Jan 2022 00:14:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20FF6C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0FE4840904
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id em1EzIyUpiYo
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36DAE408DF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:34 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 3AAF5CE0ACB;
 Sun, 23 Jan 2022 00:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DA6C340E2;
 Sun, 23 Jan 2022 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896871;
 bh=B4b/v8rgLAQzM1fDet8n5dlholfeAY0dB3jJ34q97cs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sjzLE2KLkv6R63GH8JvIazeZ33btUg1HyaUncmlDdlbtXoGym9zWGlUmgzt+rID8O
 l2kfeU2o2J0F3PMmwl8ZPVh3csZVjFcEJa/4zahxrfiH1xXsKAkgvTvk0g2sVGxuQt
 kz66hc03lPSdtMwl38d4BWCkXQQCQK/sPY8aj8XV726MKXhFzvsZgQ1ogwW1+02U9F
 qrgFWyGsZrKvfLm3SPd5lbRXcb/7hDJ4wk5dCuzxoNmk55r1oXkT6lHTtVxj6ca81J
 DRYEN9F4u5NnIXhyRIlkLZYh3d0lkn8luoOcBCwhOBSvQlJw8jfvMj+2s8XXZRveiD
 RvjrKyAdRDxDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 4/4] vhost/test: fix memory leak of vhost
 virtqueues
Date: Sat, 22 Jan 2022 19:14:21 -0500
Message-Id: <20220123001423.2461009-4-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001423.2461009-1-sashal@kernel.org>
References: <20220123001423.2461009-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Xianting Tian <xianting.tian@linux.alibaba.com>, netdev@vger.kernel.org,
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

From: Xianting Tian <xianting.tian@linux.alibaba.com>

[ Upstream commit 080063920777af65105e5953e2851e036376e3ea ]

We need free the vqs in .release(), which are allocated in .open().

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Link: https://lore.kernel.org/r/20211228030924.3468439-1-xianting.tian@linux.alibaba.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 682fc58e1f752..3abe6833be88e 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -166,6 +166,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
 	vhost_test_flush(n);
+	kfree(n->dev.vqs);
 	kfree(n);
 	return 0;
 }
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
