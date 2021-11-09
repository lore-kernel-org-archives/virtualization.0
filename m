Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8403AC2BB54
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:34:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501E6611AF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 501E6611AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CA2C60764;
	Tue,  9 Nov 2021 08:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sQANGaZXK-kO; Tue,  9 Nov 2021 08:34:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D3A3F60730;
	Tue,  9 Nov 2021 08:34:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFB3CC0012;
	Tue,  9 Nov 2021 08:34:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A053BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F6C180EDD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:34:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nbobX3ckTrkm
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:34:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE3FD80EDB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=brXsiud4Cc0AgfRTr4nbCZuEA3TzdfnPNyojG8VnBfw=; b=b+PYedIIgGjCdMCp9JN/B8B1Fz
 nzGeNiytbR6ImqRNS4vswOWH638cDm5VRSAitO6lGR+yV/I/Mz2iufYPGI1Y1GX1IfNXWO7JHC4ld
 fEzA52mVx4lCysgJIIwa69LyDX4hyeuPdKgbYC8DhqLL6Y8vrE5UVY453IQYCupw9RKT4TsXvf2ce
 j+ewr0bulk+Ez7yJgzAmbWDuIKmcUNTufJ5ljbdNaEC9XUayw1afVZIMZLjhbdRsIoNb6B7m+WiJa
 HgAsWfZs/0KGoArpevAcNfqJzQStr/V52bfoKMqM4fyX+hMXZKusk/jwOEJCnVmIpMa7W4rq6AHIj
 j82xNF8w==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZm-000sAK-3U; Tue, 09 Nov 2021 08:33:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 24/29] xfs: use xfs_direct_write_iomap_ops for DAX zeroing
Date: Tue,  9 Nov 2021 09:33:04 +0100
Message-Id: <20211109083309.584081-25-hch@lst.de>
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

While the buffered write iomap ops do work due to the fact that zeroing
never allocates blocks, the DAX zeroing should use the direct ops just
like actual DAX I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 8cef3b68cba78..704292c6ce0c7 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1324,7 +1324,7 @@ xfs_zero_range(
 
 	if (IS_DAX(inode))
 		return dax_zero_range(inode, pos, len, did_zero,
-				      &xfs_buffered_write_iomap_ops);
+				      &xfs_direct_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
 				&xfs_buffered_write_iomap_ops);
 }
@@ -1339,7 +1339,7 @@ xfs_truncate_page(
 
 	if (IS_DAX(inode))
 		return dax_truncate_page(inode, pos, did_zero,
-					&xfs_buffered_write_iomap_ops);
+					&xfs_direct_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
 				   &xfs_buffered_write_iomap_ops);
 }
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
