Return-Path: <SRS0=0+SM=OG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36782C433EF
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 13:47:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C180161248
	for <virtualization@archiver.kernel.org>; Thu, 16 Sep 2021 13:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C180161248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DB1A403C4;
	Thu, 16 Sep 2021 13:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s_9vpnl2GzX1; Thu, 16 Sep 2021 13:47:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A182C40102;
	Thu, 16 Sep 2021 13:47:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73F6DC0011;
	Thu, 16 Sep 2021 13:47:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7896C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 13:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9A5D41485
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 13:47:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=fail (1024-bit key) reason="fail (message has been altered)"
 header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UmmPoeeZXXPo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 13:47:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C21A4407F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 13:47:49 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59BB161214;
 Thu, 16 Sep 2021 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1631800069;
 bh=F2XkhsrQs/wgtELPov+RrP6TrqnJppesh8YAEtfF5d0=;
 h=Subject:To:Cc:From:Date:From;
 b=fE4Q8HKrDW4ixUri3+e/BKx2jMyCCo+uxmZi7KnoioqmC64m2OM5zY9QlHBRMrGOe
 UiUcdR6M/Gb9mpRgZ2QKElMG38mHjfloDghDt6OceRO2C2cAxR8ufr/PRtOy5PLFzb
 Hf6f9kZG4q3WAu0OXsmw9u3Svx2o0cpL9VR7wQc0=
Subject: Patch "mm/memory_hotplug: use "unsigned long" for PFN in
 zone_for_pfn_range()" has been added to the 5.13-stable tree
To: 20210607195430.48228-1-david@redhat.com, akpm@linux-foundation.org,
 aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, anton@ozlabs.org,
 ardb@kernel.org, bauerman@linux.ibm.com, benh@kernel.crashing.org,
 bhe@redhat.com, borntraeger@de.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
 cheloha@linux.ibm.com, christophe.leroy@c-s.fr, dalias@libc.org,
 dan.j.williams@intel.com, dave.hansen@linux.intel.com, dave.jiang@intel.com,
 david@redhat.com, gor@linux.ibm.com, gregkh@linuxfoundation.org,
 hca@linux.ibm.com, hpa@zytor.com, jasowang@redhat.com, joe@perches.com,
 justin.he@arm.com, ldufour@linux.ibm.com, lenb@kernel.org, luto@kernel.org,
 mhocko@kernel.org, michel@lespinasse.org, mingo@redhat.com, mpe@ellerman.id.au,
 mst@redhat.com, nathanl@linux.ibm.com, npiggin@gmail.com, osalvador@suse.de,
 pankaj.gupta.linux@gmail.com, pankaj.gupta@ionos.com,
 pasha.tatashin@soleen.com, paulus@samba.org, peterz@infradead.org,
 pmorel@linux.ibm.com, rafael.j.wysocki@intel.com,
 richard.weiyang@linux.alibaba.com, rjw@rjwysocki.net, rppt@kernel.org, 
 slyfox@gentoo.org, songmuchun@bytedance.com, tglx@linutronix.de,
 torvalds@linux-foundation.org, vbabka@suse.cz,
 virtualization@lists.linux-foundation.org, vishal.l.verma@intel.com,
 vkuznets@redhat.com, wangkefeng.wang@huawei.com, will@kernel.org,
 ysato@users.sourceforge.jp
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Sep 2021 15:46:53 +0200
Message-ID: <16318000137757@kroah.com>
MIME-Version: 1.0
X-stable: commit
X-Patchwork-Hint: ignore 
Cc: stable-commits@vger.kernel.org
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


This is a note to let you know that I've just added the patch titled

    mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()

to the 5.13-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mm-memory_hotplug-use-unsigned-long-for-pfn-in-zone_for_pfn_range.patch
and it can be found in the queue-5.13 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 7cf209ba8a86410939a24cb1aeb279479a7e0ca6 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 7 Sep 2021 19:54:59 -0700
Subject: mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()

From: David Hildenbrand <david@redhat.com>

commit 7cf209ba8a86410939a24cb1aeb279479a7e0ca6 upstream.

Patch series "mm/memory_hotplug: preparatory patches for new online policy and memory"

These are all cleanups and one fix previously sent as part of [1]:
[PATCH v1 00/12] mm/memory_hotplug: "auto-movable" online policy and memory
groups.

These patches make sense even without the other series, therefore I pulled
them out to make the other series easier to digest.

[1] https://lkml.kernel.org/r/20210607195430.48228-1-david@redhat.com

This patch (of 4):

Checkpatch complained on a follow-up patch that we are using "unsigned"
here, which defaults to "unsigned int" and checkpatch is correct.

As we will search for a fitting zone using the wrong pfn, we might end
up onlining memory to one of the special kernel zones, such as ZONE_DMA,
which can end badly as the onlined memory does not satisfy properties of
these zones.

Use "unsigned long" instead, just as we do in other places when handling
PFNs.  This can bite us once we have physical addresses in the range of
multiple TB.

Link: https://lkml.kernel.org/r/20210712124052.26491-2-david@redhat.com
Fixes: e5e689302633 ("mm, memory_hotplug: display allowed zones in the preferred ordering")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@ionos.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: virtualization@lists.linux-foundation.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jia He <justin.he@arm.com>
Cc: Joe Perches <joe@perches.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
Cc: Michel Lespinasse <michel@lespinasse.org>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Scott Cheloha <cheloha@linux.ibm.com>
Cc: Sergei Trofimovich <slyfox@gentoo.org>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/memory_hotplug.h |    4 ++--
 mm/memory_hotplug.c            |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -366,8 +366,8 @@ extern void sparse_remove_section(struct
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
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -834,8 +834,8 @@ static inline struct zone *default_zone_
 	return movable_node_enabled ? movable_zone : kernel_zone;
 }
 
-struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
-		unsigned long nr_pages)
+struct zone *zone_for_pfn_range(int online_type, int nid,
+		unsigned long start_pfn, unsigned long nr_pages)
 {
 	if (online_type == MMOP_ONLINE_KERNEL)
 		return default_kernel_zone_for_pfn(nid, start_pfn, nr_pages);


Patches currently in stable-queue which might be from david@redhat.com are

queue-5.13/mm-memory_hotplug-use-unsigned-long-for-pfn-in-zone_for_pfn_range.patch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
