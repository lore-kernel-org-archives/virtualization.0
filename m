Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F3FC636D6
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 15:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D49EA415C2;
	Fri,  3 Feb 2023 15:08:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D49EA415C2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BFKATpqt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0qg-lflnSWTF; Fri,  3 Feb 2023 15:08:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 584A4415C1;
	Fri,  3 Feb 2023 15:08:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 584A4415C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FEB1C0032;
	Fri,  3 Feb 2023 15:08:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D37AEC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AEA25612EF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:08:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEA25612EF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BFKATpqt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KA_dAvbCgYgd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:08:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2880612ED
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2880612ED
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hrqLS9VRJdwWgQKPMrZrcg15ZPJuMvt1hsLhaUGAnIc=; b=BFKATpqtVunXubdNNkJ5PWdGdR
 w5eGqcr1X3knNS9rr6k9oWENyIENlbi6OonNovYL8ZHpJJjUDwpcHhHTonjJY90oiMj+zCg0GCLCT
 ZgNdYtwQXm0LQxe0W+f7iZTRogn9U/K+/3e+BH4ejOUB6/fIsWrQ9/00S1gnU4+Kd1mny+mtvIcKf
 JBQbwIHCn96cgHxD69nkGyasiOfbHuKn0hnE8rzKpZB3qBEEW9iNbSwkEF+umPMiYEN99kqyv25Ra
 OyRlO6fWHiMfP1LpyRoEaKpRG1PL6hAcJNC4/vgMJdlJJBo2kCaI7cWoF5XwWHzsLSZZ3Jn/itg0Q
 3+X6SEYg==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pNxfT-002bcT-3j; Fri, 03 Feb 2023 15:07:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/23] libceph: use bvec_set_page to initialize bvecs
Date: Fri,  3 Feb 2023 16:06:34 +0100
Message-Id: <20230203150634.3199647-24-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150634.3199647-1-hch@lst.de>
References: <20230203150634.3199647-1-hch@lst.de>
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

Use the bvec_set_page helper to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger_v1.c |  7 ++-----
 net/ceph/messenger_v2.c | 28 +++++++++++-----------------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index d1787d7d33ef9a..d664cb1593a777 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -40,15 +40,12 @@ static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
 static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
 		     int page_offset, size_t length)
 {
-	struct bio_vec bvec = {
-		.bv_page = page,
-		.bv_offset = page_offset,
-		.bv_len = length
-	};
+	struct bio_vec bvec;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL };
 	int r;
 
 	BUG_ON(page_offset + length > PAGE_SIZE);
+	bvec_set_page(&bvec, page, length, page_offset);
 	iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, length);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 3009028c4fa28f..301a991dc6a68e 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -149,10 +149,10 @@ static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
 
 	while (iov_iter_count(it)) {
 		/* iov_iter_iovec() for ITER_BVEC */
-		bv.bv_page = it->bvec->bv_page;
-		bv.bv_offset = it->bvec->bv_offset + it->iov_offset;
-		bv.bv_len = min(iov_iter_count(it),
-				it->bvec->bv_len - it->iov_offset);
+		bvec_set_page(&bv, it->bvec->bv_page,
+			      min(iov_iter_count(it),
+				  it->bvec->bv_len - it->iov_offset),
+			      it->bvec->bv_offset + it->iov_offset);
 
 		/*
 		 * sendpage cannot properly handle pages with
@@ -286,9 +286,8 @@ static void set_out_bvec_zero(struct ceph_connection *con)
 	WARN_ON(iov_iter_count(&con->v2.out_iter));
 	WARN_ON(!con->v2.out_zero);
 
-	con->v2.out_bvec.bv_page = ceph_zero_page;
-	con->v2.out_bvec.bv_offset = 0;
-	con->v2.out_bvec.bv_len = min(con->v2.out_zero, (int)PAGE_SIZE);
+	bvec_set_page(&con->v2.out_bvec, ceph_zero_page,
+		      min(con->v2.out_zero, (int)PAGE_SIZE), 0);
 	con->v2.out_iter_sendpage = true;
 	iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
 		      con->v2.out_bvec.bv_len);
@@ -863,10 +862,7 @@ static void get_bvec_at(struct ceph_msg_data_cursor *cursor,
 
 	/* get a piece of data, cursor isn't advanced */
 	page = ceph_msg_data_next(cursor, &off, &len);
-
-	bv->bv_page = page;
-	bv->bv_offset = off;
-	bv->bv_len = len;
+	bvec_set_page(bv, page, len, off);
 }
 
 static int calc_sg_cnt(void *buf, int buf_len)
@@ -1855,9 +1851,8 @@ static void prepare_read_enc_page(struct ceph_connection *con)
 	     con->v2.in_enc_resid);
 	WARN_ON(!con->v2.in_enc_resid);
 
-	bv.bv_page = con->v2.in_enc_pages[con->v2.in_enc_i];
-	bv.bv_offset = 0;
-	bv.bv_len = min(con->v2.in_enc_resid, (int)PAGE_SIZE);
+	bvec_set_page(&bv, con->v2.in_enc_pages[con->v2.in_enc_i],
+		      min(con->v2.in_enc_resid, (int)PAGE_SIZE), 0);
 
 	set_in_bvec(con, &bv);
 	con->v2.in_enc_i++;
@@ -2998,9 +2993,8 @@ static void queue_enc_page(struct ceph_connection *con)
 	     con->v2.out_enc_resid);
 	WARN_ON(!con->v2.out_enc_resid);
 
-	bv.bv_page = con->v2.out_enc_pages[con->v2.out_enc_i];
-	bv.bv_offset = 0;
-	bv.bv_len = min(con->v2.out_enc_resid, (int)PAGE_SIZE);
+	bvec_set_page(&bv, con->v2.out_enc_pages[con->v2.out_enc_i],
+		      min(con->v2.out_enc_resid, (int)PAGE_SIZE), 0);
 
 	set_out_bvec(con, &bv, false);
 	con->v2.out_enc_i++;
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
