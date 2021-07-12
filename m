Return-Path: <SRS0=5hAK=ME=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181ABC07E99
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 12:41:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73F3610C7
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 12:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73F3610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9CC884016B;
	Mon, 12 Jul 2021 12:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2eGShLBd6Xe8; Mon, 12 Jul 2021 12:41:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4413D40150;
	Mon, 12 Jul 2021 12:41:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B8D7C0010;
	Mon, 12 Jul 2021 12:41:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 377E7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 255EA834FC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RhIiv8itNGub
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:41:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65E67834F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626093707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iimg+qQSgcqxiRNdP92p/YunXPxELvQ8PHwm9CDHrrU=;
 b=gtBeDxczV/yWqKfjr0cVXNyn0kXIwa5ZjKFqoBHHXVWZhgGRrE5lWDpYpWaBjOgpYT/nik
 A3MssR1Z14mzDKYuiTD9Ev2H3jMZHo4kr5fOXwR9rMRlSO/+R6q2YmOYzZQxNlruN0Jqmn
 3s3p/bKKs+ylEjniNrOuOvp93jiiPVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-9K5-8dqLPLuDmHE1nn5TOQ-1; Mon, 12 Jul 2021 08:41:45 -0400
X-MC-Unique: 9K5-8dqLPLuDmHE1nn5TOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1FDC100CED4;
 Mon, 12 Jul 2021 12:41:39 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-111.rdu2.redhat.com [10.10.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E63A15C232;
 Mon, 12 Jul 2021 12:41:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN in
 zone_for_pfn_range()
Date: Mon, 12 Jul 2021 14:40:49 +0200
Message-Id: <20210712124052.26491-2-david@redhat.com>
In-Reply-To: <20210712124052.26491-1-david@redhat.com>
References: <20210712124052.26491-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Michel Lespinasse <michel@lespinasse.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Rich Felker <dalias@libc.org>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Laurent Dufour <ldufour@linux.ibm.com>,
 Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@ozlabs.org>, Len Brown <lenb@kernel.org>,
 Nathan Lynch <nathanl@linux.ibm.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Borislav Petkov <bp@alien8.de>,
 Sergei Trofimovich <slyfox@gentoo.org>, Andy Lutomirski <luto@kernel.org>,
 Jia He <justin.he@arm.com>, Dan Williams <dan.j.williams@intel.com>,
 Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierre Morel <pmorel@linux.ibm.com>, Scott Cheloha <cheloha@linux.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Joe Perches <joe@perches.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
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

Checkpatch complained on a follow-up patch that we are using "unsigned"
here, which defaults to "unsigned int" and checkpatch is correct.

Use "unsigned long" instead, just as we do in other places when handling
PFNs. This can bite us once we have physical addresses in the range of
multiple TB.

Fixes: e5e689302633 ("mm, memory_hotplug: display allowed zones in the preferred ordering")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h | 4 ++--
 mm/memory_hotplug.c            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index a7fd2c3ccb77..d01b504ce06f 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -339,8 +339,8 @@ extern void sparse_remove_section(struct mem_section *ms,
 		unsigned long map_offset, struct vmem_altmap *altmap);
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
-extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
-		unsigned long nr_pages);
+extern struct zone *zone_for_pfn_range(int online_type, int nid,
+		unsigned long start_pfn, unsigned long nr_pages);
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8cb75b26ea4f..93b3abaf9828 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -708,8 +708,8 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
 	return movable_node_enabled ? movable_zone : kernel_zone;
 }
 
-struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
-		unsigned long nr_pages)
+struct zone *zone_for_pfn_range(int online_type, int nid,
+		unsigned long start_pfn, unsigned long nr_pages)
 {
 	if (online_type == MMOP_ONLINE_KERNEL)
 		return default_kernel_zone_for_pfn(nid, start_pfn, nr_pages);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
