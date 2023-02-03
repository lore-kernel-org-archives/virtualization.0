Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD617C64EC7
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 15:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CC3A42A9E;
	Fri,  3 Feb 2023 15:08:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CC3A42A9E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ToEbOtDN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id st77mzejxrA6; Fri,  3 Feb 2023 15:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 805B242AB2;
	Fri,  3 Feb 2023 15:08:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 805B242AB2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B980C0032;
	Fri,  3 Feb 2023 15:08:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F5AC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3172C821E6
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:08:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3172C821E6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ToEbOtDN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BgwkBM16RzZ7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:08:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90C5D82201
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90C5D82201
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 15:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2wTw7HkUjs1o6mx8pDSLEqzVcH91B6qVA7sAnj3S4Po=; b=ToEbOtDNdTBGoUgoMd3dVYIAK+
 Vo+zqcrz8IVsOHzD2xIZFEL2t9Bn/hNiVbmh+YIKKRcvOn1ubj24IihBgJh2kM5KFu6iVtqtwpzxX
 oRD7Xo02sO7/WXeEh1Bq2VQyw4arZl+NOMyoR/R0jybBJwCkPEAv1fus8+GKr8vOV+/6nctIvAXQX
 v/8IR4b2+Vt8YkIC6hmjY723lH+FryD2Ya2pjiiKi55AuYTSdyGrkSc/nPY8GqU2dWmMb8VNRdmeA
 e6icfVpC02OEMu+KnxJRix9jzSPIf3CAvspcMVIb2QGK3zEHEfl6L8YRmlO1OSvmS6PInQuuEdJv8
 BjFgLaZQ==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pNxfH-002bLQ-H0; Fri, 03 Feb 2023 15:07:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 20/23] rxrpc: use bvec_set_page to initialize a bvec
Date: Fri,  3 Feb 2023 16:06:31 +0100
Message-Id: <20230203150634.3199647-21-hch@lst.de>
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

Use the bvec_set_page helper to initialize a bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Howells <dhowells@redhat.com>
---
 net/rxrpc/rxperf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 16dcabb71ebe16..4a2e90015ca72c 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -493,7 +493,7 @@ static int rxperf_deliver_request(struct rxperf_call *call)
 static int rxperf_process_call(struct rxperf_call *call)
 {
 	struct msghdr msg = {};
-	struct bio_vec bv[1];
+	struct bio_vec bv;
 	struct kvec iov[1];
 	ssize_t n;
 	size_t reply_len = call->reply_len, len;
@@ -503,10 +503,8 @@ static int rxperf_process_call(struct rxperf_call *call)
 
 	while (reply_len > 0) {
 		len = min_t(size_t, reply_len, PAGE_SIZE);
-		bv[0].bv_page	= ZERO_PAGE(0);
-		bv[0].bv_offset	= 0;
-		bv[0].bv_len	= len;
-		iov_iter_bvec(&msg.msg_iter, WRITE, bv, 1, len);
+		bvec_set_page(&bv, ZERO_PAGE(0), len, 0);
+		iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, len);
 		msg.msg_flags = MSG_MORE;
 		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 					   len, rxperf_notify_end_reply_tx);
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
