Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A5AC4332F
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 10:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D319B830CD;
	Mon, 29 Nov 2021 10:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srieJDvsdn7j; Mon, 29 Nov 2021 10:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3CCF2830E6;
	Mon, 29 Nov 2021 10:22:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10FA6C0046;
	Mon, 29 Nov 2021 10:22:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6532BC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D887401A1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oU2zUOLj-nGR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 92C7A40134
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Og+Y/LRPMRgZw3tJ8cXpjgwviRJJrJn9nJJ+2xu2tuc=; b=tooSDpcqoQvrM3NLXmSjjO50ZQ
 9UtXgS8Bhc9kkeWfQhlUoq3T9ey8lcuv8ncdemQh5KsRP2pvu0PfDhZrdgpyTiKVqNZx6GyKStLHU
 TaAD+KLUIaflLvjfbJV04HNPduJ6Mu/D8l/kdCHMA3TZWYRPw8OOP2Nv7YS+CzVkyPik0zUGa7JJN
 H7+OFwwh5010zD43YpZf8N1KPxlt2ij0T/naH7tL/2Ea7g6pF/BMTzbmZJVmzdK8/3vTd+xXjBW7d
 4MfbNzP5khcvpQf0UN9SkRifFylostsyI1RqNuYh6bxeDOhCCC+DzvF94M6PYtfh3vMEh+3K7Xeqc
 fy0SIHBw==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdnR-0073Ig-7d; Mon, 29 Nov 2021 10:22:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 01/29] dm: fix alloc_dax error handling in alloc_dev
Date: Mon, 29 Nov 2021 11:21:35 +0100
Message-Id: <20211129102203.2243509-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
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

Make sure ->dax_dev is NULL on error so that the cleanup path doesn't
trip over an ERR_PTR.

Reported-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 662742a310cbb..acc84dc1bded5 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1786,8 +1786,10 @@ static struct mapped_device *alloc_dev(int minor)
 	if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
 		md->dax_dev = alloc_dax(md, md->disk->disk_name,
 					&dm_dax_ops, 0);
-		if (IS_ERR(md->dax_dev))
+		if (IS_ERR(md->dax_dev)) {
+			md->dax_dev = NULL;
 			goto bad;
+		}
 	}
 
 	format_dev_t(md->name, MKDEV(_major, minor));
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
