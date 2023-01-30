Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEEAC64EC3
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 09:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBFB6408DC;
	Mon, 30 Jan 2023 09:23:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBFB6408DC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i9AYlKAO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4766uB4D2ML0; Mon, 30 Jan 2023 09:23:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 57D9A401D2;
	Mon, 30 Jan 2023 09:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57D9A401D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33C5EC0032;
	Mon, 30 Jan 2023 09:23:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5E2DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0FFB817AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0FFB817AB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i9AYlKAO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9c3TYcY--JJU
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A914817EB
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A914817EB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 09:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=p+yCA75hP3xTA4z0JqY98N90poOlsvGyo37k4Ap2woM=; b=i9AYlKAOZ43/SsWyYnAWPiWAuH
 wOnzstLTu84haohS93R+b3+/PFUtyvvWWjhOliCemb0tZtB/BvukLBGtdd3Qfn4AztHpMr5gPDiv9
 pykYVq16zioFYfJbJUqVapz/0j7Z9lIwlzAc3goAfS8/li6bXevI3m2oMuDgPE3R0eRL87akyah+L
 YP8S0UqhRwqk0u2hAa7aNsgUMmQdiU8H7GdpecxVRrtK2g0PJyMvxAcj0GHEEGiFPHkZlYN3Xcgrb
 Zg+hSn9E/U6Bt1mWTQkkWWRFPXtWhjWXN8hIQicH7S0OvZO+ZxtpZxRzB/wDZ4j0GKY2wY9iOJUXC
 VOKko6ag==;
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pMQMj-002o2F-W8; Mon, 30 Jan 2023 09:22:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/23] sd: factor out a sd_set_special_bvec helper
Date: Mon, 30 Jan 2023 10:21:38 +0100
Message-Id: <20230130092157.1759539-5-hch@lst.de>
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

Add a helper for setting up the special_bvec instead of open coding it
in three place, and use the new bvec_set_page helper to initialize
special_vec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 47dafe6b8a66d1..277960decc104b 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -831,6 +831,19 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	blk_queue_max_discard_sectors(q, max_blocks * (logical_block_size >> 9));
 }
 
+static void *sd_set_special_bvec(struct request *rq, unsigned int data_len)
+{
+	struct page *page;
+
+	page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
+	if (!page)
+		return NULL;
+	clear_highpage(page);
+	bvec_set_page(&rq->special_vec, page, data_len, 0);
+	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
+	return bvec_virt(&rq->special_vec);
+}
+
 static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdp = cmd->device;
@@ -841,19 +854,14 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	unsigned int data_len = 24;
 	char *buf;
 
-	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
-	if (!rq->special_vec.bv_page)
+	buf = sd_set_special_bvec(rq, data_len);
+	if (!buf)
 		return BLK_STS_RESOURCE;
-	clear_highpage(rq->special_vec.bv_page);
-	rq->special_vec.bv_offset = 0;
-	rq->special_vec.bv_len = data_len;
-	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
 
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = UNMAP;
 	cmd->cmnd[8] = 24;
 
-	buf = bvec_virt(&rq->special_vec);
 	put_unaligned_be16(6 + 16, &buf[0]);
 	put_unaligned_be16(16, &buf[2]);
 	put_unaligned_be64(lba, &buf[8]);
@@ -876,13 +884,8 @@ static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	u32 data_len = sdp->sector_size;
 
-	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
-	if (!rq->special_vec.bv_page)
+	if (!sd_set_special_bvec(rq, data_len))
 		return BLK_STS_RESOURCE;
-	clear_highpage(rq->special_vec.bv_page);
-	rq->special_vec.bv_offset = 0;
-	rq->special_vec.bv_len = data_len;
-	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
 
 	cmd->cmd_len = 16;
 	cmd->cmnd[0] = WRITE_SAME_16;
@@ -908,13 +911,8 @@ static blk_status_t sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd,
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	u32 data_len = sdp->sector_size;
 
-	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
-	if (!rq->special_vec.bv_page)
+	if (!sd_set_special_bvec(rq, data_len))
 		return BLK_STS_RESOURCE;
-	clear_highpage(rq->special_vec.bv_page);
-	rq->special_vec.bv_offset = 0;
-	rq->special_vec.bv_len = data_len;
-	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
 
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = WRITE_SAME;
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
