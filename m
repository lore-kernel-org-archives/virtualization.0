Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE4BC64ED8
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 378C741728;
	Mon, 30 Jan 2023 09:24:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 378C741728
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Qx6f/vAl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qfvxMk3HzRDq; Mon, 30 Jan 2023 09:24:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 37BC341706;
	Mon, 30 Jan 2023 09:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37BC341706
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0767DC007F;
	Mon, 30 Jan 2023 09:24:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D8D7C007C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 74E5C4063C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74E5C4063C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Qx6f/vAl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yv6jmeih5N0b
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD1B6401D2
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD1B6401D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=iTork4lgSqwAnNzEK3lzK1UwHk37chVOVoUGPRhe1ko=; b=Qx6f/vAlt0702Bw2gaA0yw3fMn
 DSbWXckp85GKL6x2K0wVZWlmBP/HHAMGhBrYB08/Vlm/YRJQCq3kI3xMG/WASmjfzQ5X57qRgvH1M
 aDf2q/VfFfkAfOqqUqPetL8Nnll6XIjG7NgvoDUHbD0cnB+MO8UuF7ljYLg4f4YTGaLPU4yXfmMbt
 xSZ2xC24sTznBHqPUwQ2KOdIbwsTxD5YqcKUievCZTrFdiYRp348Iffsdx6IiKzBdbwdD1fWYnp87
 CKqOs2Hi1NMEf6sOsnEZOuE8nGXc6MpsuZ0+93w6fPSfAyQf9ElR2gHbrsn8rljB8JPoxhMSuKyqW
 Ecg9ip0g==;
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMQNF-002oFW-6t; Mon, 30 Jan 2023 09:22:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/23] coredump: use bvec_set_page to initialize a bvec
Date: Mon, 30 Jan 2023 10:21:48 +0100
Message-Id: <20230130092157.1759539-15-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130092157.1759539-1-hch@lst.de>
References: <20230130092157.1759539-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Eric Dumazet <edumazet@google.com>, target-devel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 Mike Marshall <hubcap@omnibond.com>, linux-cifs@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, devel@lists.orangefs.org,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

Use the bvec_set_page helper to initialize a bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/coredump.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991beb..0a6873a9c4d0cd 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -840,11 +840,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
-	struct bio_vec bvec = {
-		.bv_page	= page,
-		.bv_offset	= 0,
-		.bv_len		= PAGE_SIZE,
-	};
+	struct bio_vec bvec;
 	struct iov_iter iter;
 	struct file *file = cprm->file;
 	loff_t pos;
@@ -860,6 +856,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	if (dump_interrupted())
 		return 0;
 	pos = file->f_pos;
+	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
 	n = __kernel_write_iter(cprm->file, &iter, &pos);
 	if (n != PAGE_SIZE)
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
