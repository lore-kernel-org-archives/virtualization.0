Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34264C433F5
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE57E405AF;
	Sun, 23 Jan 2022 00:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTJqoGqRDzrD; Sun, 23 Jan 2022 00:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 49F994045C;
	Sun, 23 Jan 2022 00:14:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2648DC0031;
	Sun, 23 Jan 2022 00:14:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6178EC002F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5076040904
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rk19jyLOOjjX
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BF4F408DF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:14:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 96CCECE0AD8;
 Sun, 23 Jan 2022 00:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CC9C340E4;
 Sun, 23 Jan 2022 00:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896850;
 bh=fXf8Fd4OrvDlxT5Apz9FOpWMoCpLeg9hl45JTALhEj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jYuM55LB6qXalLDuLOY40kN/wouOxTM4m97Csnk4vtZIiScLjsqlOUnT5FH0Wwx/d
 v7LECX/9BTL2w+2BxklG8ngyuObSrvSQNBu13/kR7cmeaVMidnvL+0e/RmyvTAtnfv
 Z1qNZLFBfN+xCCCrLkfVTstXmGb64/tFuAgb5prB82T+CwyuyTyZz3E/t7p4MsxNTP
 Q6Ap+8ugeq3V99kMdh46iRwtuRJI5mzIOWsspE+zkcEte+qFxT4YcvTtI/o4vLytRM
 Fs5If+0qPoLUOJsSlvsCNZqiBXWqwKOoIUhzFB9YQhF/CkfrCdkoCIPBaNgk7mmTJm
 SATeaEKrrtmSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/5] vhost/test: fix memory leak of vhost
 virtqueues
Date: Sat, 22 Jan 2022 19:13:51 -0500
Message-Id: <20220123001353.2460870-5-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001353.2460870-1-sashal@kernel.org>
References: <20220123001353.2460870-1-sashal@kernel.org>
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
index 55090d9f9de0d..2d6abe1c0dbec 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -167,6 +167,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
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
