Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD14C4338F
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 10:03:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77768601FC
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 10:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77768601FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C5506062B;
	Wed,  4 Aug 2021 10:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtH7IFAfxUf4; Wed,  4 Aug 2021 10:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A5706605EB;
	Wed,  4 Aug 2021 10:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D3FDC0010;
	Wed,  4 Aug 2021 10:03:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBFCDC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 10:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD59E40599
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 10:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9bS0r9cR4b-D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 10:03:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0FB44058F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=U8gl0ibigZuBxb1er2grGKX+goE9BthZJ/OF371A9bI=; b=wR11HIuSQMK44FHP61z8T70PBH
 PaVhFcTxwWOPc4pnZqyPEGVj9JzDzsXU4ilPRj8HNgVDJbT2PVl5B84w1V3kPeuIUfFt8yZ37Ho0z
 z01UKj/pwAhZEXcFNMlkYG9yjqd8rXxJc/QGiWBEZ7DrYfFC8yviuXRDsKYeDUm0P/BsTD/Q8A4at
 t0ie4dglmKF0awtMLfFDuviTiAVKBik4jaEW7q1/2w8cSPQ1sAkKQgIHt4rukLpaJ4dKNAJwjN65s
 lhBAaD+jrqWHjJb39cHqz5p/o38APHJLiXsCYIV9VX7QkP+OPbv5oOHfANZ0i57CwDry/qW3UzBCE
 wY3JGlEw==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDi1-005fHw-82; Wed, 04 Aug 2021 10:01:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/15] squashfs: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:25 +0200
Message-Id: <20210804095634.460779-7-hch@lst.de>
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
 fs/squashfs/block.c        | 7 +++----
 fs/squashfs/lz4_wrapper.c  | 2 +-
 fs/squashfs/lzo_wrapper.c  | 2 +-
 fs/squashfs/xz_wrapper.c   | 2 +-
 fs/squashfs/zlib_wrapper.c | 2 +-
 fs/squashfs/zstd_wrapper.c | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 855f0e87066d..2db8bcf7ff85 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -49,8 +49,7 @@ static int copy_bio_to_actor(struct bio *bio,
 
 		bytes_to_copy = min_t(int, bytes_to_copy,
 				      req_length - copied_bytes);
-		memcpy(actor_addr + actor_offset,
-		       page_address(bvec->bv_page) + bvec->bv_offset + offset,
+		memcpy(actor_addr + actor_offset, bvec_virt(bvec) + offset,
 		       bytes_to_copy);
 
 		actor_offset += bytes_to_copy;
@@ -177,7 +176,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 			goto out_free_bio;
 		}
 		/* Extract the length of the metadata block */
-		data = page_address(bvec->bv_page) + bvec->bv_offset;
+		data = bvec_virt(bvec);
 		length = data[offset];
 		if (offset < bvec->bv_len - 1) {
 			length |= data[offset + 1] << 8;
@@ -186,7 +185,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 				res = -EIO;
 				goto out_free_bio;
 			}
-			data = page_address(bvec->bv_page) + bvec->bv_offset;
+			data = bvec_virt(bvec);
 			length |= data[0] << 8;
 		}
 		bio_free_pages(bio);
diff --git a/fs/squashfs/lz4_wrapper.c b/fs/squashfs/lz4_wrapper.c
index 233d5582fbee..b685b6238316 100644
--- a/fs/squashfs/lz4_wrapper.c
+++ b/fs/squashfs/lz4_wrapper.c
@@ -101,7 +101,7 @@ static int lz4_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	while (bio_next_segment(bio, &iter_all)) {
 		int avail = min(bytes, ((int)bvec->bv_len) - offset);
 
-		data = page_address(bvec->bv_page) + bvec->bv_offset;
+		data = bvec_virt(bvec);
 		memcpy(buff, data + offset, avail);
 		buff += avail;
 		bytes -= avail;
diff --git a/fs/squashfs/lzo_wrapper.c b/fs/squashfs/lzo_wrapper.c
index 97bb7d92ddcd..cb510a631968 100644
--- a/fs/squashfs/lzo_wrapper.c
+++ b/fs/squashfs/lzo_wrapper.c
@@ -76,7 +76,7 @@ static int lzo_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	while (bio_next_segment(bio, &iter_all)) {
 		int avail = min(bytes, ((int)bvec->bv_len) - offset);
 
-		data = page_address(bvec->bv_page) + bvec->bv_offset;
+		data = bvec_virt(bvec);
 		memcpy(buff, data + offset, avail);
 		buff += avail;
 		bytes -= avail;
diff --git a/fs/squashfs/xz_wrapper.c b/fs/squashfs/xz_wrapper.c
index e80419aed862..68f6d09bb3a2 100644
--- a/fs/squashfs/xz_wrapper.c
+++ b/fs/squashfs/xz_wrapper.c
@@ -146,7 +146,7 @@ static int squashfs_xz_uncompress(struct squashfs_sb_info *msblk, void *strm,
 			}
 
 			avail = min(length, ((int)bvec->bv_len) - offset);
-			data = page_address(bvec->bv_page) + bvec->bv_offset;
+			data = bvec_virt(bvec);
 			length -= avail;
 			stream->buf.in = data + offset;
 			stream->buf.in_size = avail;
diff --git a/fs/squashfs/zlib_wrapper.c b/fs/squashfs/zlib_wrapper.c
index bcb881ec47f2..a20e9042146b 100644
--- a/fs/squashfs/zlib_wrapper.c
+++ b/fs/squashfs/zlib_wrapper.c
@@ -76,7 +76,7 @@ static int zlib_uncompress(struct squashfs_sb_info *msblk, void *strm,
 			}
 
 			avail = min(length, ((int)bvec->bv_len) - offset);
-			data = page_address(bvec->bv_page) + bvec->bv_offset;
+			data = bvec_virt(bvec);
 			length -= avail;
 			stream->next_in = data + offset;
 			stream->avail_in = avail;
diff --git a/fs/squashfs/zstd_wrapper.c b/fs/squashfs/zstd_wrapper.c
index b7cb1faa652d..0015cf8b5582 100644
--- a/fs/squashfs/zstd_wrapper.c
+++ b/fs/squashfs/zstd_wrapper.c
@@ -94,7 +94,7 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 			}
 
 			avail = min(length, ((int)bvec->bv_len) - offset);
-			data = page_address(bvec->bv_page) + bvec->bv_offset;
+			data = bvec_virt(bvec);
 			length -= avail;
 			in_buf.src = data + offset;
 			in_buf.size = avail;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
