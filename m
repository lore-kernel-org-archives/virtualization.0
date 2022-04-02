Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A54DC433F5
	for <virtualization@archiver.kernel.org>; Sat,  2 Apr 2022 10:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C66048418E;
	Sat,  2 Apr 2022 10:32:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oT9GIZa76Q_3; Sat,  2 Apr 2022 10:32:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 567C88418B;
	Sat,  2 Apr 2022 10:32:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D88EC001D;
	Sat,  2 Apr 2022 10:32:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A230C0012
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Apr 2022 10:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4BA9419DB
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Apr 2022 10:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 90e6wM0AcEAO
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Apr 2022 10:32:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77D5141941
 for <virtualization@lists.linux-foundation.org>;
 Sat,  2 Apr 2022 10:32:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0V8zD-od_1648895570; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V8zD-od_1648895570) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 02 Apr 2022 18:32:50 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: miklos@szeredi.hu, vgoyal@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: avoid unnecessary spinlock bump
Date: Sat,  2 Apr 2022 18:32:50 +0800
Message-Id: <20220402103250.68027-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: gerry@linux.alibaba.com
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

Move dmap free worker kicker inside the critical region, so that extra
spinlock lock/unlock could be avoided.

Suggested-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index d7d3a7f06862..b9f8795d52c4 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -138,9 +138,9 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn_dax *fcd)
 		WARN_ON(fcd->nr_free_ranges <= 0);
 		fcd->nr_free_ranges--;
 	}
+	__kick_dmap_free_worker(fcd, 0);
 	spin_unlock(&fcd->lock);
 
-	kick_dmap_free_worker(fcd, 0);
 	return dmap;
 }
 
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
