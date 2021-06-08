Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9FC4743F
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 08:32:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B208C6124B
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 08:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B208C6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7190A60769;
	Tue,  8 Jun 2021 08:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JMCbJ7UG66HG; Tue,  8 Jun 2021 08:32:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20BF8605AD;
	Tue,  8 Jun 2021 08:32:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02F0CC000D;
	Tue,  8 Jun 2021 08:32:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CDCCC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 08:32:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE94D4018C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 08:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N96scGma1KrE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 08:32:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F54240109
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 08:32:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAF4561183;
 Tue,  8 Jun 2021 08:32:09 +0000 (UTC)
Date: Tue, 8 Jun 2021 09:32:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 04/12] mm/memory_hotplug: remove nid parameter from
 arch_remove_memory()
Message-ID: <20210608083206.GE17957@arm.com>
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-5-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607195430.48228-5-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Michel Lespinasse <michel@lespinasse.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-s390@vger.kernel.org, Laurent Dufour <ldufour@linux.ibm.com>,
 Jia He <justin.he@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Christian Borntraeger <borntraeger@de.ibm.com>, linux-sh@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Sergei Trofimovich <slyfox@gentoo.org>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Hui Zhu <teawater@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Joe Perches <joe@perches.com>,
 linuxppc-dev@lists.ozlabs.org, Marek Kedzierski <mkedzier@redhat.com>,
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

On Mon, Jun 07, 2021 at 09:54:22PM +0200, David Hildenbrand wrote:
> The parameter is unused, let's remove it.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: Sergei Trofimovich <slyfox@gentoo.org>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Michel Lespinasse <michel@lespinasse.org>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Cc: Jia He <justin.he@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/arm64/mm/mmu.c            | 3 +--

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
