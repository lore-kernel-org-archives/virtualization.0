Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D6FC636D6
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7918F60F5E;
	Mon, 30 Jan 2023 09:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7918F60F5E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AeyW2dv3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1MMGx4wNMXEa; Mon, 30 Jan 2023 09:23:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC1A960F64;
	Mon, 30 Jan 2023 09:23:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC1A960F64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5838C0032;
	Mon, 30 Jan 2023 09:23:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 978CEC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FC7960F62
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FC7960F62
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uK0LZ-0QmjED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEC2560F5D
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AEC2560F5D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=mjnWElruolPujfuaQzrOj/G3l/fBXPdeJ5vitS9FjeU=; b=AeyW2dv3VrGmqK7xN2Y68HgAm3
 hh9AIAEzh5xupy5qbYXDao4MBJwRufhB0+Rklw61vqXEW59/3AXrMstXD9HpUj8whRVjKMJMKksw1
 F+HACTpk2HZv02EVd+1E0anoDOOXkPMYnyhx3OQfOs0Zs7+JgAAEM+EH4MnpToE5nbZD+gcW+Kxv5
 RRxGRvZ2U9vPF0VLvrfw4LaDLWjqfEbUdZown/DhIpBYN4rw26Fc1VzlYANaDoyFe1h++X6lxoqnh
 grGLHQ4m5s5Wx2rR8JgELRiQ++/ofjeYfF3YV1iR1Fe4G73jICcylJu1POXGqzsk8qRrUHOsuhAnx
 Kya4Yu+g==;
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMQNC-002oES-K9; Mon, 30 Jan 2023 09:22:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/23] cifs: use bvec_set_page to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:47 +0100
Message-Id: <20230130092157.1759539-14-hch@lst.de>
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

Use the bvec_set_page helper to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/cifs/connect.c |  5 +++--
 fs/cifs/fscache.c | 16 ++++++----------
 fs/cifs/misc.c    |  5 ++---
 fs/cifs/smb2ops.c |  6 +++---
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index b2a04b4e89a5e7..e6088d96eb04d2 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -759,8 +759,9 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	unsigned int page_offset, unsigned int to_read)
 {
 	struct msghdr smb_msg = {};
-	struct bio_vec bv = {
-		.bv_page = page, .bv_len = to_read, .bv_offset = page_offset};
+	struct bio_vec bv;
+
+	bvec_set_page(&bv, page, to_read, page_offset);
 	iov_iter_bvec(&smb_msg.msg_iter, ITER_DEST, &bv, 1, to_read);
 	return cifs_readv_from_socket(server, &smb_msg);
 }
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index f6f3a6b75601be..0911327ebfdeb4 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -143,14 +143,12 @@ static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 	struct netfs_cache_resources cres;
 	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
 	struct iov_iter iter;
-	struct bio_vec bvec[1];
+	struct bio_vec bvec;
 	int ret;
 
 	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, ITER_DEST, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
+	iov_iter_bvec(&iter, ITER_DEST, &bvec, 1, PAGE_SIZE);
 
 	ret = fscache_begin_read_operation(&cres, cookie);
 	if (ret < 0)
@@ -171,16 +169,14 @@ static int fscache_fallback_write_page(struct inode *inode, struct page *page,
 	struct netfs_cache_resources cres;
 	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
 	struct iov_iter iter;
-	struct bio_vec bvec[1];
+	struct bio_vec bvec;
 	loff_t start = page_offset(page);
 	size_t len = PAGE_SIZE;
 	int ret;
 
 	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, ITER_SOURCE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
+	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
 
 	ret = fscache_begin_write_operation(&cres, cookie);
 	if (ret < 0)
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 2a19c7987c5bd8..95cc4d7dd806d7 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1054,9 +1054,8 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 
 		for (i = 0; i < cur_npages; i++) {
 			len = rc > PAGE_SIZE ? PAGE_SIZE : rc;
-			bv[npages + i].bv_page = pages[i];
-			bv[npages + i].bv_offset = start;
-			bv[npages + i].bv_len = len - start;
+			bvec_set_page(&bv[npages + i], pages[i], len - start,
+				      start);
 			rc -= len;
 			start = 0;
 		}
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index e6bcd2baf446a9..cb2deac6b2d70e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4598,9 +4598,9 @@ init_read_bvec(struct page **pages, unsigned int npages, unsigned int data_size,
 		return -ENOMEM;
 
 	for (i = 0; i < npages; i++) {
-		bvec[i].bv_page = pages[i];
-		bvec[i].bv_offset = (i == 0) ? cur_off : 0;
-		bvec[i].bv_len = min_t(unsigned int, PAGE_SIZE, data_size);
+		bvec_set_page(&bvec[i], pages[i],
+			      min_t(unsigned int, PAGE_SIZE, data_size),
+			      i == 0 ? cur_off : 0);
 		data_size -= bvec[i].bv_len;
 	}
 
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
