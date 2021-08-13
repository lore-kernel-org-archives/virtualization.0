Return-Path: <SRS0=i+Gq=NE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF545C4338F
	for <virtualization@archiver.kernel.org>; Fri, 13 Aug 2021 08:12:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF326109D
	for <virtualization@archiver.kernel.org>; Fri, 13 Aug 2021 08:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DF326109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4061401F1;
	Fri, 13 Aug 2021 08:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SYJIY1wfqVo1; Fri, 13 Aug 2021 08:12:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 448F84012E;
	Fri, 13 Aug 2021 08:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21A1EC001A;
	Fri, 13 Aug 2021 08:12:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA699C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 08:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95BA740756
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 08:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d6KJBiDT245R
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 08:11:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 861074074C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=J5iMSjwPMvkOFpq0TMlTZtl3sxje2OPtaEgmn6rI3kw=; b=tLoy64zP56BA6COvXf26VAiBG9
 oKjbIjnNL8arRxo50od3oQ9WiLXRnnIQhwWpPCi11t8FmIOTy5frodVYORATqo1cnyknkdAttACMh
 IuMWI23bPAIcxV2I4FQ55yZj75VZCoja9nk9jCbJl2kLpcbtCS6bW+/E3OtXurRenuXwnHahWGhHg
 VmR8RasuVRLggxW1RHCjYBVYq+of6asU83tj5SwmMaoQZlZNE/hmhjV94fEjEqMYdxvBoRzvKKJgC
 EoAexDTExue7OUZO7UKAGrfL514yBqR5kWkuh5KUCOhD+Khwegyzwh0IZDHIBx/Bt0akrVQgr2x1g
 9A5BlXNA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mESEG-00FTaW-Kf; Fri, 13 Aug 2021 08:07:59 +0000
Date: Fri, 13 Aug 2021 09:07:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 12/15] pci: Mark MSI data shared
Message-ID: <YRYoVBIXZ/910eaq@infradead.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-13-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-13-sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
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

On Wed, Aug 04, 2021 at 05:52:15PM -0700, Kuppuswamy Sathyanarayanan wrote:
>  
> -	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
> +	return ioremap_shared(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);

Please add a comment here.  I also find the amount of ioremap_* variants
rather frustrating.  Maybe it it is time for a ioremap_flags which
replaces the too-lowlevel pgprot_t of the ioremap_prot provided by some
architectures with a more highlevel flags arguments that could also
provide an accessible to the hypervisor flag.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
