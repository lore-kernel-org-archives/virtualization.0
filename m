Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55630C64EC7
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:23:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B93F340603;
	Mon, 30 Jan 2023 09:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B93F340603
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dhP5pRXP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUrhiaJfAoQL; Mon, 30 Jan 2023 09:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 969BC401D2;
	Mon, 30 Jan 2023 09:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 969BC401D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EDC3C0032;
	Mon, 30 Jan 2023 09:23:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B078C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1499401D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1499401D2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9WSm03UxLgZF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD36F405F5
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD36F405F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=w4kKntDuy29BQaIkx4v+gO5Mr7Op4d5AzstW4NmjqgQ=; b=dhP5pRXPs7QKG7qsUwhXqREoym
 zFzrmsc54uPZ3WPKRuV0WfgPkfnihth42MiqynU5Q/EDc9fWWebRrTHXAwUzGN/QJoApdfPiDDX0N
 /HmkaUaiYxfZXLR3z9hdV2llYBIbYlCe2dMJ6F0EqHVStN3Uz7UWDdL6oJBZcAAt0p+6fB6iGbjPD
 Nd/Ok11pRhrv+rkkmvwJZn5tR6ROXiqwJ2nZx3e7mQ0MNb0CMx12gTe0I5RWQiaLYIPF7aZ5ee0FT
 Y0XEhRZP9VSnQWzR1IGwBoRJV/D+7pYsUL1N+aAD7VKEQrSA2/9TIqep6pIrHdjX4TAXBBgOIMZ0Y
 QNuMFv5A==;
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMQMV-002nyZ-Kh; Mon, 30 Jan 2023 09:22:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/23] block: factor out a bvec_set_page helper
Date: Mon, 30 Jan 2023 10:21:35 +0100
Message-Id: <20230130092157.1759539-2-hch@lst.de>
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

Add a helper to initialize a bvec based of a page pointer.  This will help
removing various open code bvec initializations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c |  7 +------
 block/bio.c           | 12 ++----------
 include/linux/bvec.h  | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3f5685c00e360b..a3776064c52a16 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -124,23 +124,18 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 			   unsigned int len, unsigned int offset)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	struct bio_vec *iv;
 
 	if (bip->bip_vcnt >= bip->bip_max_vcnt) {
 		printk(KERN_ERR "%s: bip_vec full\n", __func__);
 		return 0;
 	}
 
-	iv = bip->bip_vec + bip->bip_vcnt;
-
 	if (bip->bip_vcnt &&
 	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
 			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
 		return 0;
 
-	iv->bv_page = page;
-	iv->bv_len = len;
-	iv->bv_offset = offset;
+	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
 
 	return len;
diff --git a/block/bio.c b/block/bio.c
index d7fbc7adfc50aa..71e411a0c12950 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1029,10 +1029,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	if (bio->bi_vcnt >= queue_max_segments(q))
 		return 0;
 
-	bvec = &bio->bi_io_vec[bio->bi_vcnt];
-	bvec->bv_page = page;
-	bvec->bv_len = len;
-	bvec->bv_offset = offset;
+	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
 	bio->bi_vcnt++;
 	bio->bi_iter.bi_size += len;
 	return len;
@@ -1108,15 +1105,10 @@ EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off)
 {
-	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt];
-
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio, len));
 
-	bv->bv_page = page;
-	bv->bv_offset = off;
-	bv->bv_len = len;
-
+	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
 }
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff651a5e..9e3dac51eb26b6 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -35,6 +35,21 @@ struct bio_vec {
 	unsigned int	bv_offset;
 };
 
+/**
+ * bvec_set_page - initialize a bvec based off a struct page
+ * @bv:		bvec to initialize
+ * @page:	page the bvec should point to
+ * @len:	length of the bvec
+ * @offset:	offset into the page
+ */
+static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
+		unsigned int len, unsigned int offset)
+{
+	bv->bv_page = page;
+	bv->bv_len = len;
+	bv->bv_offset = offset;
+}
+
 struct bvec_iter {
 	sector_t		bi_sector;	/* device address in 512 byte
 						   sectors */
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
