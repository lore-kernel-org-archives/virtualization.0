Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B693C433FE
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4013240587;
	Sun, 23 Jan 2022 00:13:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtEmEe9u-vlJ; Sun, 23 Jan 2022 00:13:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 96BD8403C8;
	Sun, 23 Jan 2022 00:13:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F6C4C0031;
	Sun, 23 Jan 2022 00:13:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB3ADC007A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D334408E1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ySXnwRCkv-hE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:13:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F102740241
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:13:50 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4413B60F9D;
 Sun, 23 Jan 2022 00:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3D7C36AFE;
 Sun, 23 Jan 2022 00:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896830;
 bh=b2/OYtgv4as7vKqkmBgE+8vaPjBVKsqCDH6dDM+tQ64=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IjjUINFPGr28kXELbH6KkgCjegEucH60JD1vckw6czCrKhZMyZEwRGuy4eWU1N/J9
 GtOwhF0b0PoW0KzEYYPGnqH+4V0guae+dr41k7KOFfYowWpkAqiiJUX+jp0Bat+z11
 gdKxQBmTAbWgwy4uT8X7kjtpI/gycoAVUAu6jAJayxkRowgp+lbZARC47mLJd3Xdpq
 MmmIJlGOh0B1dHJBVG1L1Pjc7z4/nesRKe4LgESVk8O2/qJvnO5CVc7hYAlWYwo6WP
 7zhbLrwVOWliB8Hm0Q0dlHgHdws2wTEH3r3u/MR6bbDIWG0y1sO4nQPsR0DcUlxzU5
 Eh98X4dWWF8uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 7/8] vhost/test: fix memory leak of vhost
 virtqueues
Date: Sat, 22 Jan 2022 19:13:22 -0500
Message-Id: <20220123001323.2460719-7-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001323.2460719-1-sashal@kernel.org>
References: <20220123001323.2460719-1-sashal@kernel.org>
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
index 056308008288c..fd8e9f70b06d3 100644
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
