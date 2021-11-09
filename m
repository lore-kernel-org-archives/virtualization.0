Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5BDC4167E
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:33:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83982611BD
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83982611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60FCF403B3;
	Tue,  9 Nov 2021 08:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SoOmFvZeIRbj; Tue,  9 Nov 2021 08:33:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D339B403AD;
	Tue,  9 Nov 2021 08:33:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC2F1C0012;
	Tue,  9 Nov 2021 08:33:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7742C0039
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96D5060772
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7PkGbHK9FWl1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C156260757
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=GFhvoqOvL9OJvQf8+jTjW82TnTUOvEd+75/q2F+O9PE=; b=skBgYHYjavMuoPq2CV+3MX/Hg3
 N0ec6jUVnP3dTGwezupk6zCDVbBZpXVnnkz2V1hkxkmqrKJSgR0xhtkALlVZvJtYBEiEhfIWlBAKK
 BC7m73sgtzTm5SOhafl9DgiuxDS6wK6jJq6TtnTNhuFgXa7mVCaRWvYtE9Z0pFIDQGcniQntwbtzp
 VL1vMQMckVa3zEij5h0NcvaLDA6J8imgtaEBv4iiTmwIiEYegUYnbbtmVEn9zhY8R99+J1WWGh5J+
 qMY3LBjBWS5k/isgkkDvO1c/87syeC7Cwd7SmnLK1Fif4MEuSuYTPq+uejut0GwzwpVuXr5aRz6g9
 Ga0NH+ww==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZU-000s3V-Sg; Tue, 09 Nov 2021 08:33:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 13/29] fsdax: use a saner calling convention for
 copy_cow_page_dax
Date: Tue,  9 Nov 2021 09:32:53 +0100
Message-Id: <20211109083309.584081-14-hch@lst.de>
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

Just pass the vm_fault and iomap_iter structures, and figure out the rest
locally.  Note that this requires moving dax_iomap_sector up in the file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 73bd1439d8089..e51b4129d1b65 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -709,26 +709,31 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 	return __dax_invalidate_entry(mapping, index, false);
 }
 
-static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
-			     sector_t sector, struct page *to, unsigned long vaddr)
+static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
 {
+	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
+}
+
+static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
+{
+	sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
 	void *vto, *kaddr;
 	pgoff_t pgoff;
 	long rc;
 	int id;
 
-	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	rc = bdev_dax_pgoff(iter->iomap.bdev, sector, PAGE_SIZE, &pgoff);
 	if (rc)
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
 	}
-	vto = kmap_atomic(to);
-	copy_user_page(vto, kaddr, vaddr, to);
+	vto = kmap_atomic(vmf->cow_page);
+	copy_user_page(vto, kaddr, vmf->address, vmf->cow_page);
 	kunmap_atomic(vto);
 	dax_read_unlock(id);
 	return 0;
@@ -1005,11 +1010,6 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
-static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
-{
-	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
-}
-
 static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 			 pfn_t *pfnp)
 {
@@ -1332,19 +1332,16 @@ static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
 static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
 		const struct iomap_iter *iter)
 {
-	sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
-	unsigned long vaddr = vmf->address;
 	vm_fault_t ret;
 	int error = 0;
 
 	switch (iter->iomap.type) {
 	case IOMAP_HOLE:
 	case IOMAP_UNWRITTEN:
-		clear_user_highpage(vmf->cow_page, vaddr);
+		clear_user_highpage(vmf->cow_page, vmf->address);
 		break;
 	case IOMAP_MAPPED:
-		error = copy_cow_page_dax(iter->iomap.bdev, iter->iomap.dax_dev,
-					  sector, vmf->cow_page, vaddr);
+		error = copy_cow_page_dax(vmf, iter);
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
