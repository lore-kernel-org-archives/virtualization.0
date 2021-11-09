Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA0C433F5
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:33:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15073611C5
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15073611C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD4BD403B8;
	Tue,  9 Nov 2021 08:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9vty_3XaWHi6; Tue,  9 Nov 2021 08:33:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 795EE403B1;
	Tue,  9 Nov 2021 08:33:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56215C0012;
	Tue,  9 Nov 2021 08:33:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA3A4C0021
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACE1B80CF7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cX3VGEBCrl2i
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02FFD80BCC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=zfCI/U8WTukvUOFF16NcuXhCNGsYjAKrDL4zQNucYJY=; b=o6GhNxlQ3IOt/+NcSH7pkNZyIL
 e2NSHpEgG9tiBm0dYKfFQsF4fAAYNym9zC+t/oW68Brq6whz7Cii35gCwCKYHwTVndsoeduiVYmUU
 Q801npG6fplWZawdN/5aJPLAtwfswvRBf/64Q7wOP1Dm1K7qDH0oTzbj4ICmluRQbgiYJxppS8Dyq
 nmjKrkOjW6ZuxyH4A718D3Pb5Io8KoSUtQMHFkso1tiV5r1efOgc5GVO5cgOJ+sDzKB+KCL0eafbU
 mBvauGwx5vGzElAKrv1yl8LYZP+pskH0bgRrmWiKl7zcxgKmqUdOOx76gDAbJy66nOvQsYHxFG+Ts
 VRdqkklQ==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZa-000s5E-1A; Tue, 09 Nov 2021 08:33:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 16/29] fsdax: simplify the offset check in dax_iomap_zero
Date: Tue,  9 Nov 2021 09:32:56 +0100
Message-Id: <20211109083309.584081-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
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

The file relative offset must have the same alignment as the storage
offset, so use that and get rid of the call to iomap_sector.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5364549d67a48..d7a923d152240 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1123,7 +1123,6 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 
 s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
-	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	long rc, id;
 	void *kaddr;
@@ -1131,8 +1130,7 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 	unsigned offset = offset_in_page(pos);
 	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
 
-	if (IS_ALIGNED(sector << SECTOR_SHIFT, PAGE_SIZE) &&
-	    (size == PAGE_SIZE))
+	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
 		page_aligned = true;
 
 	id = dax_read_lock();
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
