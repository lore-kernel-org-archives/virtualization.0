Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717BEC636D3
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAD1C817C3;
	Mon, 30 Jan 2023 09:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AAD1C817C3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0HizygZk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxMTjv0YpHtX; Mon, 30 Jan 2023 09:24:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 14DB0819B4;
	Mon, 30 Jan 2023 09:24:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14DB0819B4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6996CC007F;
	Mon, 30 Jan 2023 09:24:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF420C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA9F3817AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA9F3817AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iUUyF3TNlxkD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1419C817BD
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1419C817BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=kORmqO/9LhO3glrNFnQu4Hg9yMGINb4dC3Y3cN2SyCY=; b=0HizygZk2nZjv0o2ajWsgJ6NxN
 HeRnnJ1D22tpfXLoTyq1RPwvhbr9Hiij2NkO9yjBgJPw0OncbMANB9niSSOrRVZ2N46LpusCcE0BB
 jppqbA+4ogA5vchuAFpwIfPib1H34fAqGiBc55ohmeWXo4V1xtSPW8b8UVdQPWfxnr0ojaeVAE8mW
 5BG1gAx9dS/IpjC8HJj51SPaIhLswJAaTrcmg8S5HJj0ItA/7z4nEzsHIlF7fTEotoyWvhZ3wIenz
 pNMuCzbIVd5wch1ImTQQLdqp02J0HQI3Zz62oRWCvcMwzv7D5j4NXjlbmjtwNIkk6uFSzNM7w+c0R
 43WrGivg==;
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMQNQ-002oHi-98; Mon, 30 Jan 2023 09:23:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/23] orangefs: use bvec_set_{page, folio} to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:50 +0100
Message-Id: <20230130092157.1759539-17-hch@lst.de>
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

Use the bvec_set_page and bvec_set_folio helpers to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/orangefs/inode.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4df56089438664..215f6cb3dc4129 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -49,10 +49,8 @@ static int orangefs_writepage_locked(struct page *page,
 	/* Should've been handled in orangefs_invalidate_folio. */
 	WARN_ON(off == len || off + wlen > len);
 
-	bv.bv_page = page;
-	bv.bv_len = wlen;
-	bv.bv_offset = off % PAGE_SIZE;
 	WARN_ON(wlen == 0);
+	bvec_set_page(&bv, page, wlen, off % PAGE_SIZE);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
@@ -102,15 +100,11 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 
 	for (i = 0; i < ow->npages; i++) {
 		set_page_writeback(ow->pages[i]);
-		ow->bv[i].bv_page = ow->pages[i];
-		ow->bv[i].bv_len = min(page_offset(ow->pages[i]) + PAGE_SIZE,
-		    ow->off + ow->len) -
-		    max(ow->off, page_offset(ow->pages[i]));
-		if (i == 0)
-			ow->bv[i].bv_offset = ow->off -
-			    page_offset(ow->pages[i]);
-		else
-			ow->bv[i].bv_offset = 0;
+		bvec_set_page(&ow->bv[i], ow->pages[i],
+			      min(page_offset(ow->pages[i]) + PAGE_SIZE,
+			          ow->off + ow->len) -
+			      max(ow->off, page_offset(ow->pages[i])),
+			      i == 0 ? ow->off - page_offset(ow->pages[i]) : 0);
 	}
 	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
 
@@ -300,9 +294,7 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 		orangefs_launder_folio(folio);
 
 	off = folio_pos(folio);
-	bv.bv_page = &folio->page;
-	bv.bv_len = folio_size(folio);
-	bv.bv_offset = 0;
+	bvec_set_folio(&bv, folio, folio_size(folio), 0);
 	iov_iter_bvec(&iter, ITER_DEST, &bv, 1, folio_size(folio));
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
