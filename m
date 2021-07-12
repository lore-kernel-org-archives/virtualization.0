Return-Path: <SRS0=5hAK=ME=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52769C07E99
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 12:41:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86DB610C7
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 12:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86DB610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B5E24017D;
	Mon, 12 Jul 2021 12:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iGMbSLgguoKO; Mon, 12 Jul 2021 12:41:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 18AB240150;
	Mon, 12 Jul 2021 12:41:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4D33C0010;
	Mon, 12 Jul 2021 12:41:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C9D9C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E1BA834F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDhqLgyG2ZG8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:41:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B17A834C7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626093687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qEbDQXGhHEIQfXJJ1NDA7WskESqj8IOu7J2/Cf7/u6Q=;
 b=Fs9CXKbGTKina7mFGIErfcSJizxtVYM/EAiaRIGse6BQP2OcL+UNviTMEKgOYl17mMcoF2
 xZKaj8KjV45vyXdzvpbJXD0Y4yaEsu6gLbTD9OXVDTNqgKiFZPCKxYeY/cup5OLxzqqwSb
 kei8JGwPG1iwLTcC5bbrRGm1tePS4yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-VADwkUjmOYKhbpMmcyul4g-1; Mon, 12 Jul 2021 08:41:26 -0400
X-MC-Unique: VADwkUjmOYKhbpMmcyul4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A5AB802C87;
 Mon, 12 Jul 2021 12:41:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-111.rdu2.redhat.com [10.10.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 285555C1D1;
 Mon, 12 Jul 2021 12:40:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: mm/memory_hotplug: preparatory patches for new online policy and
 memory
Date: Mon, 12 Jul 2021 14:40:48 +0200
Message-Id: <20210712124052.26491-1-david@redhat.com>
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

Hi,

these are all cleanups and one fix previously sent as part of [1]:
	[PATCH v1 00/12] mm/memory_hotplug: "auto-movable" online policy
	and memory groups

These patches make sense even without the other series, therefore I pulled
them out to make the other series easier to digest.

[1] https://lkml.kernel.org/r/20210607195430.48228-1-david@redhat.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Oscar Salvador <osalvador@suse.de>
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
Cc: linux-mm@kvack.org
Cc: linux-acpi@vger.kernel.org

David Hildenbrand (4):
  mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()
  mm/memory_hotplug: remove nid parameter from arch_remove_memory()
  mm/memory_hotplug: remove nid parameter from remove_memory() and
    friends
  ACPI: memhotplug: memory resources cannot be enabled yet

 arch/arm64/mm/mmu.c                           |  3 +-
 arch/ia64/mm/init.c                           |  3 +-
 arch/powerpc/mm/mem.c                         |  3 +-
 .../platforms/pseries/hotplug-memory.c        |  9 +++--
 arch/s390/mm/init.c                           |  3 +-
 arch/sh/mm/init.c                             |  3 +-
 arch/x86/mm/init_32.c                         |  3 +-
 arch/x86/mm/init_64.c                         |  3 +-
 drivers/acpi/acpi_memhotplug.c                | 11 +-----
 drivers/dax/kmem.c                            |  3 +-
 drivers/virtio/virtio_mem.c                   |  4 +--
 include/linux/memory_hotplug.h                | 17 +++++----
 mm/memory_hotplug.c                           | 36 +++++++++++--------
 mm/memremap.c                                 |  5 +--
 14 files changed, 45 insertions(+), 61 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
