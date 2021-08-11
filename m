Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E9EC4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 20:36:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754B86101D
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 20:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 754B86101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4802E405DB;
	Wed, 11 Aug 2021 20:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id skzZIe_N4G8q; Wed, 11 Aug 2021 20:36:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81B1F405DF;
	Wed, 11 Aug 2021 20:36:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 595A3C001A;
	Wed, 11 Aug 2021 20:36:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 168F8C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF6E44049D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cs1a1u1dcWia
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:36:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B1AD40343
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628714200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6LHuy13nKs4bZicpGZZauB7ft7dST8UEGnG3gy9DN8=;
 b=CkGxclVG3pHshZRvoKuDO8pJhBY7TF7JPGOlVTxlFefLxaEkpJ76fW6eUIC9QpX5MWWYot
 bY0cMjAlMAtJoNV2031j8TI/3bfQb5A/FSYChGDFW/Ivd4SbGt9IzB97DoOFxienL4HwvX
 Mp8K9u4Ob2bOq552K90cZhayDV32Skw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-QSB5eX08MEuIOl7_aCX0kQ-1; Wed, 11 Aug 2021 16:36:36 -0400
X-MC-Unique: QSB5eX08MEuIOl7_aCX0kQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BDEF8799EC;
 Wed, 11 Aug 2021 20:36:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 154021B46B;
 Wed, 11 Aug 2021 20:36:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] kernel/resource: cleanup and optimize
 iomem_is_exclusive()
Date: Wed, 11 Aug 2021 22:36:12 +0200
Message-Id: <20210811203612.138506-4-david@redhat.com>
In-Reply-To: <20210811203612.138506-1-david@redhat.com>
References: <20210811203612.138506-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Hanjun Guo <guohanjun@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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

Let's clean it up a bit, removing the unnecessary usage of r_next() by
next_resource(), and use next_range_resource() in case we are not
interested in a certain subtree.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/resource.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 2938cf520ca3..ea853a075a83 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1754,9 +1754,8 @@ static int strict_iomem_checks;
  */
 bool iomem_is_exclusive(u64 addr)
 {
-	struct resource *p = &iomem_resource;
+	struct resource *p;
 	bool err = false;
-	loff_t l;
 	int size = PAGE_SIZE;
 
 	if (!strict_iomem_checks)
@@ -1765,27 +1764,31 @@ bool iomem_is_exclusive(u64 addr)
 	addr = addr & PAGE_MASK;
 
 	read_lock(&resource_lock);
-	for (p = p->child; p ; p = r_next(NULL, p, &l)) {
+	for (p = iomem_resource.child; p ;) {
 		/*
 		 * We can probably skip the resources without
 		 * IORESOURCE_IO attribute?
 		 */
 		if (p->start >= addr + size)
 			break;
-		if (p->end < addr)
+		if (p->end < addr) {
+			/* No need to consider children */
+			p = next_resource_skip_children(p);
 			continue;
+		}
+
 		/*
 		 * A resource is exclusive if IORESOURCE_EXCLUSIVE is set
 		 * or CONFIG_IO_STRICT_DEVMEM is enabled and the
 		 * resource is busy.
 		 */
-		if ((p->flags & IORESOURCE_BUSY) == 0)
-			continue;
-		if (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM)
-				|| p->flags & IORESOURCE_EXCLUSIVE) {
+		if (p->flags & IORESOURCE_BUSY &&
+		    (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM) ||
+		     p->flags & IORESOURCE_EXCLUSIVE)) {
 			err = true;
 			break;
 		}
+		p = next_resource(p);
 	}
 	read_unlock(&resource_lock);
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
