Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179F4C4332F
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 06:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D3D1607B5;
	Thu,  9 Dec 2021 06:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XfeAunt4fZT6; Thu,  9 Dec 2021 06:38:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B6A96069D;
	Thu,  9 Dec 2021 06:38:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 188EBC002F;
	Thu,  9 Dec 2021 06:38:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF546C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E49C160769
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:38:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id npl_uNeZ2En3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:38:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A25686069D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 06:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=e/I3Z/fVcm8ka4/7bniQ5z4YGZD4AAd7c/qW0XirAZ0=; b=i2hlpPdNZAF/hm4qW1s8FKFDEF
 6t7Mpr8ZkJc3YEVm6S/h5xB7Wst5GfUBeGFc+s8+1Uqfls+HOzKeRqeMd1SumX+4QYxwl5N0xpHrB
 nRSX4gsuF2aEn++FK4s7wqTgBswNC5OcT97Ip3IetmDgJgFwGOMUx8akFcn93DPeZ5z/PBikxKIZu
 7Ai7Y6Qf51aB7twOPUE4CWL+s85DVLBRc+gjMbPpmza3WWUlzft52RhVFQYWRG9aXS1BgivWqvYeT
 W8vJ1lEmo6iVbu2v034XT44vZ7eGoqwicAfgdn0c2ORzD1pawsY0Sd+2w9nTJxnwMQgXmB9srFy0L
 /SA4MbRw==;
Received: from [2001:4bb8:180:a1c8:2d0e:135:af53:41f8] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvD4Y-0096hS-Sr; Thu, 09 Dec 2021 06:38:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 2/5] dax: simplify dax_synchronous and set_dax_synchronous
Date: Thu,  9 Dec 2021 07:38:25 +0100
Message-Id: <20211209063828.18944-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209063828.18944-1-hch@lst.de>
References: <20211209063828.18944-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, dm-devel@redhat.com,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 Alasdair Kergon <agk@redhat.com>
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

Remove the pointless wrappers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c |  8 ++++----
 include/linux/dax.h | 12 ++----------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e7152a6c4cc40..e18155f43a635 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -208,17 +208,17 @@ bool dax_write_cache_enabled(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
 
-bool __dax_synchronous(struct dax_device *dax_dev)
+bool dax_synchronous(struct dax_device *dax_dev)
 {
 	return test_bit(DAXDEV_SYNC, &dax_dev->flags);
 }
-EXPORT_SYMBOL_GPL(__dax_synchronous);
+EXPORT_SYMBOL_GPL(dax_synchronous);
 
-void __set_dax_synchronous(struct dax_device *dax_dev)
+void set_dax_synchronous(struct dax_device *dax_dev)
 {
 	set_bit(DAXDEV_SYNC, &dax_dev->flags);
 }
-EXPORT_SYMBOL_GPL(__set_dax_synchronous);
+EXPORT_SYMBOL_GPL(set_dax_synchronous);
 
 bool dax_alive(struct dax_device *dax_dev)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 87ae4c9b1d65b..3bd1fdb5d5f4b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -48,16 +48,8 @@ void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
-bool __dax_synchronous(struct dax_device *dax_dev);
-static inline bool dax_synchronous(struct dax_device *dax_dev)
-{
-	return  __dax_synchronous(dax_dev);
-}
-void __set_dax_synchronous(struct dax_device *dax_dev);
-static inline void set_dax_synchronous(struct dax_device *dax_dev)
-{
-	__set_dax_synchronous(dax_dev);
-}
+bool dax_synchronous(struct dax_device *dax_dev);
+void set_dax_synchronous(struct dax_device *dax_dev);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
