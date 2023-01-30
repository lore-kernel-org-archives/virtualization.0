Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED67C677F1
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B111160F45;
	Mon, 30 Jan 2023 09:24:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B111160F45
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iooTsOLV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N57n2NVRCYDN; Mon, 30 Jan 2023 09:24:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F162D60F56;
	Mon, 30 Jan 2023 09:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F162D60F56
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F673C0032;
	Mon, 30 Jan 2023 09:24:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF33C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91CF4401D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91CF4401D2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iooTsOLV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfR2EsO6kyin
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9E2E4062A
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9E2E4062A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=h+lHe/qj9+NLcJnalyqirfAInpcSjbUKRj83r5gu0OY=; b=iooTsOLVmKIL/ixriJ6M6N2zLV
 p0LtPYaHnApKmXktbqYtS1iBIChQE//OrkhC9BejFL6iJyQ/YmCmQDM8IAHebGZsoPcKwlLZFMT6R
 rmqaY+v+wb+eMH9qR7ttcCPmX0HX3khYu/Xo5mViFs4Pott9I6Qn4V7/eQhFdGYEfQf3kZxzqLfY/
 ev81DRGCJKNL78EcC5Kfpr1hFkfI1lCJxwKAWUZqu6xN1RHdEsT32y8265Um+OWOJ7Io++V+ve2Ny
 seVOYj7SyoEnFycVFd1I/7fULPH30U/wlBRK5hBih4Dqubnzz1z+BiP1/3J2Sqawgs4/K9IzZt99x
 qcn9+TEQ==;
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMQNa-002oMU-Kp; Mon, 30 Jan 2023 09:23:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/23] swap: use bvec_set_page to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:53 +0100
Message-Id: <20230130092157.1759539-20-hch@lst.de>
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
 mm/page_io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 3a5f921b932e82..233f6e6eb1c508 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -318,9 +318,7 @@ static int swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 		sio->pages = 0;
 		sio->len = 0;
 	}
-	sio->bvec[sio->pages].bv_page = page;
-	sio->bvec[sio->pages].bv_len = thp_size(page);
-	sio->bvec[sio->pages].bv_offset = 0;
+	bvec_set_page(&sio->bvec[sio->pages], page, thp_size(page), 0);
 	sio->len += thp_size(page);
 	sio->pages += 1;
 	if (sio->pages == ARRAY_SIZE(sio->bvec) || !wbc->swap_plug) {
@@ -432,9 +430,7 @@ static void swap_readpage_fs(struct page *page,
 		sio->pages = 0;
 		sio->len = 0;
 	}
-	sio->bvec[sio->pages].bv_page = page;
-	sio->bvec[sio->pages].bv_len = thp_size(page);
-	sio->bvec[sio->pages].bv_offset = 0;
+	bvec_set_page(&sio->bvec[sio->pages], page, thp_size(page), 0);
 	sio->len += thp_size(page);
 	sio->pages += 1;
 	if (sio->pages == ARRAY_SIZE(sio->bvec) || !plug) {
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
