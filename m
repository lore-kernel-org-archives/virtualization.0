Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61F2C433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 19:42:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DCA2076E
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 19:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmaS8fG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DCA2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 349922155E;
	Tue,  4 Aug 2020 19:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYlE6aorjCYS; Tue,  4 Aug 2020 19:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A7FFD22179;
	Tue,  4 Aug 2020 19:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D756C0050;
	Tue,  4 Aug 2020 19:42:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6002C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 19:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C05EA861A7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 19:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WWNmdR+VfIwg
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 19:42:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0CC9F86234
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 19:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596570140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1cdcrpSaUyPT7UgxPkoUt6fR2Ifv+AIMispg+nEOrI=;
 b=GmaS8fG9CGhfMLYGFYWE04zDYbnZTEfJsYcUqVopliWZynLAIyq6KrP7Urxy3F+M51z8Ae
 JP1g+hFtvS7z634NFQrSpGvVLlsB7JasfcV+6mILaLFowHrPWA7Oz6ZY3ij75Y3raHdZNY
 vZNF+XKah6MypAuduqwYP+0oU4fPFFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-a5iX9AmiPN6YMOCLCbM3nw-1; Tue, 04 Aug 2020 15:42:16 -0400
X-MC-Unique: a5iX9AmiPN6YMOCLCbM3nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4AED1800D42;
 Tue,  4 Aug 2020 19:42:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-95.ams2.redhat.com [10.36.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A51A72E4F;
 Tue,  4 Aug 2020 19:42:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] mm: document semantics of ZONE_MOVABLE
Date: Tue,  4 Aug 2020 21:41:42 +0200
Message-Id: <20200804194142.28279-7-david@redhat.com>
In-Reply-To: <20200804194142.28279-1-david@redhat.com>
References: <20200804194142.28279-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Baoquan He <bhe@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 virtualization@lists.linux-foundation.org, Mike Rapoport <rppt@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

Let's document what ZONE_MOVABLE means, how it's used, and which special
cases we have regarding unmovable pages (memory offlining vs. migration /
allocations).

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index f6f884970511d..3c22aca6cc4f1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -372,6 +372,41 @@ enum zone_type {
 	 */
 	ZONE_HIGHMEM,
 #endif
+	/*
+	 * ZONE_MOVABLE is similar to ZONE_NORMAL, except that it contains
+	 * movable pages with few exceptional cases described below. Main use
+	 * cases for ZONE_MOVABLE are to make memory offlining/unplug more
+	 * likely to succeed, and to locally limit unmovable allocations - e.g.,
+	 * to increase the number of THP/huge pages. Notable special cases are:
+	 *
+	 * 1. Pinned pages: (long-term) pinning of movable pages might
+	 *    essentially turn such pages unmovable. Memory offlining might
+	 *    retry a long time.
+	 * 2. memblock allocations: kernelcore/movablecore setups might create
+	 *    situations where ZONE_MOVABLE contains unmovable allocations
+	 *    after boot. Memory offlining and allocations fail early.
+	 * 3. Memory holes: we might have a memmap for memory holes, for
+	 *    example, if we have sections that are only partially populated.
+	 *    Such pages cannot be allocated. Applies only to boot memory, not
+	 *    hotplugged memory. Memory offlining and allocations fail early.
+	 * 4. PG_hwpoison pages: while poisoned pages can be skipped during
+	 *    memory offlining, such pages cannot be allocated.
+	 * 5. Unmovable PG_offline pages: in paravirtualized environments,
+	 *    hotplugged memory blocks might only partially be managed by the
+	 *    buddy (e.g., via XEN-balloon, Hyper-V balloon, virtio-mem). The
+	 *    parts not manged by the buddy are unmovable PG_offline pages. In
+	 *    some cases (virtio-mem), such pages can be skipped during
+	 *    memory offlining, however, cannot be moved/allocated. These
+	 *    techniques might use alloc_contig_range() to hide previously
+	 *    exposed pages from the buddy again (e.g., to implement some sort
+	 *    of memory unplug in virtio-mem).
+	 *
+	 * In general, no unmovable allocations that degrade memory offlining
+	 * should end up in ZONE_MOVABLE. Allocators (like alloc_contig_range())
+	 * have to expect that migrating pages in ZONE_MOVABLE can fail (even
+	 * if has_unmovable_pages() states that there are no unmovable pages,
+	 * there can be false negatives).
+	 */
 	ZONE_MOVABLE,
 #ifdef CONFIG_ZONE_DEVICE
 	ZONE_DEVICE,
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
