Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF629C4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 10:02:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDE7601FC
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 10:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CDE7601FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1FB5B40354;
	Wed,  4 Aug 2021 10:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0T8CEudJZVYf; Wed,  4 Aug 2021 10:02:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5AD2C4034D;
	Wed,  4 Aug 2021 10:02:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C7A8C0010;
	Wed,  4 Aug 2021 10:02:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E45F4C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 10:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3FFB83A4C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 10:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8nr9uFDpqRT6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 10:02:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2519583281
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 10:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=38PP0nqE1Rr5Q2SngGpX8SaabB796rszA7pe5/OYcCE=; b=NZVo6Syey+ucG1T/H4GNaod0LQ
 R3HS7TqZ5afkR+W+LPQJkznZOdAp8uReL+jaUNSYRPcVYrEd+QKJpXhyMJeIOUpxn6c6kg6oOcnrj
 ycZVGqV90IGpgWJAdd/4RU4VedNIa+ouNFQPdggcsnOZH0MibUQDRqjnN6Klph1gOoqn8Oowgd+90
 SKSpiLwMFkfPxHoVq1iUv+bgY8YaLlGZCl1KwsC1LwwnnIhdy0CzjMqtFV9iC0vVxrqjp46rQonBS
 dvE79Kmj5hVeLSHgBE3iwZOdeXA8BcSCT2lsyusJ9iEyY1RsgiF6m8nRVF5xP1/KOWT5fQu+V9TFA
 MzZrJ0rg==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDhE-005fC7-4b; Wed, 04 Aug 2021 10:00:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/15] dm-integrity: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:24 +0200
Message-Id: <20210804095634.460779-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Ilya Dryomov <idryomov@gmail.com>, linux-um@lists.infradead.org,
 Coly Li <colyli@suse.de>, linux-raid@vger.kernel.org,
 linux-bcache@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Geoff Levand <geoff@infradead.org>, Phillip Lougher <phillip@squashfs.org.uk>
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

Use bvec_virt instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 20f2510db1f6..a9ea361769a7 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1819,7 +1819,7 @@ static void integrity_metadata(struct work_struct *w)
 				unsigned this_len;
 
 				BUG_ON(PageHighMem(biv.bv_page));
-				tag = lowmem_page_address(biv.bv_page) + biv.bv_offset;
+				tag = bvec_virt(&biv);
 				this_len = min(biv.bv_len, data_to_process);
 				r = dm_integrity_rw_tag(ic, tag, &dio->metadata_block, &dio->metadata_offset,
 							this_len, dio->op == REQ_OP_READ ? TAG_READ : TAG_WRITE);
@@ -2006,7 +2006,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 					unsigned tag_now = min(biv.bv_len, tag_todo);
 					char *tag_addr;
 					BUG_ON(PageHighMem(biv.bv_page));
-					tag_addr = lowmem_page_address(biv.bv_page) + biv.bv_offset;
+					tag_addr = bvec_virt(&biv);
 					if (likely(dio->op == REQ_OP_WRITE))
 						memcpy(tag_ptr, tag_addr, tag_now);
 					else
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
