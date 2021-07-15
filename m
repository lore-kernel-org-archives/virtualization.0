Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39891C636C9
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 18:19:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1F561178
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 18:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1F561178
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC4D9404FA;
	Thu, 15 Jul 2021 18:19:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bltT4I-6RR0f; Thu, 15 Jul 2021 18:19:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 064244026A;
	Thu, 15 Jul 2021 18:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0993C0010;
	Thu, 15 Jul 2021 18:19:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E1FEC0010
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 18:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B169540274
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 18:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OGbA9JRX1lXl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 18:19:25 +0000 (UTC)
X-Greylist: delayed 00:06:44 by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B50984061D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 18:19:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1AF761289;
 Thu, 15 Jul 2021 18:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1626372760;
 bh=563x5jc9W0wYdsYhRrwdZ2cKbN/d2MVtmAqW50LZyZ0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FsZnz9nP1bhbXjnQ1v7vfL8Px6/NRc9/Tw/5rjvcQ0W74+LUQmJOvDrhD7sN0bzCQ
 A/377ILCL8HxH19Q2Bq7wRbdh8O+CrDgK5A9RTOxBhwtSw48htNA/wZQtNIKA/f8jC
 7An5l1t6/H9nn+OV8w1rtEldUw2KaUAy48s9tI5o=
Date: Thu, 15 Jul 2021 11:12:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN
 in zone_for_pfn_range()
Message-Id: <20210715111238.a557aec31381646d5cd71ef2@linux-foundation.org>
In-Reply-To: <99c59db8-4c3d-6bee-9acc-41a8f76899ef@redhat.com>
References: <20210712124052.26491-1-david@redhat.com>
 <20210712124052.26491-2-david@redhat.com> <YO9FWrT9h21e/G8X@osiris>
 <99c59db8-4c3d-6bee-9acc-41a8f76899ef@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Cc: Michel Lespinasse <michel@lespinasse.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Rich Felker <dalias@libc.org>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Laurent Dufour <ldufour@linux.ibm.com>,
 Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org,
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
 virtualization@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Yoshinori Sato <ysato@users.osdn.me>,
 Scott Cheloha <cheloha@linux.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Joe Perches <joe@perches.com>,
 Mike Rapoport <rppt@kernel.org>
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

On Thu, 15 Jul 2021 11:42:21 +0200 David Hildenbrand <david@redhat.com> wrote:

> > I'd propose to add Cc: <stable@vger.kernel.org> since I actually had
> > the fun to try to debug something like this a couple of years ago:
> > 6cdb18ad98a4 ("mm/vmstat: fix overflow in mod_zone_page_state()")
> > 
> 
> Good point, and thinking again what can go wrong, I tend to agree. We 
> are trying to keep zones contiguous and it could happen that we end up 
> with something like ZONE_DMA here (via default_kernel_zone_for_pfn()) 
> and would consequently online something to ZONE_DMA that doesn't belong 
> there, resulting in crashes.
> 
> @Andrew can you add  Cc: <stable@vger.kernel.org> and
> 
> "As we will search for a fitting zone using the wrong pfn, we might end 
> up onlining memory to one of the special kernel zones, such as ZONE_DMA, 
> which can end badly as the onlined memory does not satisfy properties of 
> these zones."

Yep, all done.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
