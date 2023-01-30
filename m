Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC6BC61DA4
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A715781A27;
	Mon, 30 Jan 2023 09:24:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A715781A27
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yIyzvzQM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lr8KF1ONiGMx; Mon, 30 Jan 2023 09:24:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3102B819F8;
	Mon, 30 Jan 2023 09:24:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3102B819F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D428C0032;
	Mon, 30 Jan 2023 09:24:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18EC2C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBEA8819F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBEA8819F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QLNhgSFBxx4t
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F76A81A33
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F76A81A33
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=JggVdFejlVrHezfZyUPZIF+fbKFzTvLqyM6x/B/bNX0=; b=yIyzvzQMfPVH5Gb1fGbCTBoUMm
 xloJv91yDUd5JQdWLlRBk+1sLVwSJJvK1sQPKmxCs/LNN1eQPMeGgwtVAmuRonsvhzwxw0ztVLd5H
 uqTuZOrnXue/mLxyXQ899NpF62ExiwbTi/woLW4nvWS9CICI4bQ1XP2mMwUqoe+ELqlA9Ltt45QBS
 A1RN48wY4MO2whvwBYTYJeo6A20nM7cF0dsRRmfS8Ta41XMgoSLMfClVVyS2ZQY3DqywQTajuIYZ9
 P1s4vwRo6Pu1l3nmpmKYQrYw0pvU+oaOEhwJk+puAKc1PPGVc3KCMZJMyOB5E9Yi2nzwi5ZdtIclp
 AQmElk3A==;
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMQNs-002oRV-Sa; Mon, 30 Jan 2023 09:23:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 21/23] sunrpc: use bvec_set_page to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:55 +0100
Message-Id: <20230130092157.1759539-22-hch@lst.de>
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
 net/sunrpc/svcsock.c | 7 ++-----
 net/sunrpc/xdr.c     | 5 ++---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 815baf308236a9..91252adcae4696 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -252,11 +252,8 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 
-	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE) {
-		bvec[i].bv_page = rqstp->rq_pages[i];
-		bvec[i].bv_len = PAGE_SIZE;
-		bvec[i].bv_offset = 0;
-	}
+	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE)
+		bvec_set_page(&bvec[i], rqstp->rq_pages[i], PAGE_SIZE, 0);
 	rqstp->rq_respages = &rqstp->rq_pages[i];
 	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index f7767bf224069f..afe7ec02d23229 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -150,9 +150,8 @@ xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
 		if (!buf->bvec)
 			return -ENOMEM;
 		for (i = 0; i < n; i++) {
-			buf->bvec[i].bv_page = buf->pages[i];
-			buf->bvec[i].bv_len = PAGE_SIZE;
-			buf->bvec[i].bv_offset = 0;
+			bvec_set_page(&buf->bvec[i], buf->pages[i], PAGE_SIZE,
+				      0);
 		}
 	}
 	return 0;
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
