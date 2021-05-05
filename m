Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD61C433B4
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 16:37:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D4761977
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 16:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D4761977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BFA360A70;
	Wed,  5 May 2021 16:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mXZf70UAboCQ; Wed,  5 May 2021 16:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBDB560804;
	Wed,  5 May 2021 16:37:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCED8C000D;
	Wed,  5 May 2021 16:37:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 267E0C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0830960A67
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TsJ3767FxeE9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:37:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 80CC360804
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:37:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4933D61969;
 Wed,  5 May 2021 16:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620232675;
 bh=S6mHnGbcMAlOfu21dw04qkZuYKHktDgvstABXYrwtcE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u5DYOaxl8Os6Rp5I9bFCr0QcNRxyBiwIYkGMNggGVyVkkaH9pW9DSpyNhkX9z8s2s
 DHMaR1R5RoZkV344uMdatl/2l0OY8h00dbRMhif5q5ROPC4uoMci34zPRvp2WoN9Or
 fcb3wPf650uJHd9ixeWRrz2bUvwqVd3HAPaCKmkDEtX9E1/ruLU0KlxE7AGLsg2yOT
 lXNCTZEcS4zKBzhGsmpUyaChv9Qa7htIc+7TxVY+dmbMLcYokOrjLcWLoT0Qg5AQYQ
 uxtDkmK/FCUrmgCE2OB+O/6tl0S0+YPp3vzWcrVWIEQM8ybcTaQmV3y/zr9+wiM8uU
 heqoCAEHa/oDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 45/85] virtiofs: fix userns
Date: Wed,  5 May 2021 12:36:08 -0400
Message-Id: <20210505163648.3462507-45-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505163648.3462507-1-sashal@kernel.org>
References: <20210505163648.3462507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
 linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 0a7419c68a45d2d066b996be5087aa2d07ce80eb ]

get_user_ns() is done twice (once in virtio_fs_get_tree() and once in
fuse_conn_init()), resulting in a reference leak.

Also looks better to use fsc->user_ns (which *should* be the
current_user_ns() at this point).

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/virtio_fs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 3d83c9e12848..9c0211a629d6 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1456,8 +1456,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 		return -ENOMEM;
 	}
 
-	fuse_conn_init(fc, fm, get_user_ns(current_user_ns()),
-		       &virtio_fs_fiq_ops, fs);
+	fuse_conn_init(fc, fm, fsc->user_ns, &virtio_fs_fiq_ops, fs);
 	fc->release = fuse_free_conn;
 	fc->delete_stale = true;
 	fc->auto_submounts = true;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
