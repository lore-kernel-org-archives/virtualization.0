Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE18AC4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 19:43:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DE86103A
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 19:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 71DE86103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BC3F4074B;
	Thu, 12 Aug 2021 19:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hr53geDhXnyy; Thu, 12 Aug 2021 19:43:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74D4C40753;
	Thu, 12 Aug 2021 19:43:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3321EC001A;
	Thu, 12 Aug 2021 19:43:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 283B8C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 19:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1682D605CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 19:43:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zN7WY8iLvKeM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 19:43:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F34466065C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 19:43:32 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3303D60F57;
 Thu, 12 Aug 2021 19:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628797412;
 bh=mycw/N87DcjoHhRJ24PqFxiKdFx6FKqzLp6B9V1Bci0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=U12QjMP3CnJpA4KXSSptXiM7d4U5MWdCrpeOte+jO3bwyMUv8NPwvxLUgFBkLPzJG
 0+V8IWPqotJnu14+YIThfkvpHQAUd8VQQT75qa7ba7XsebzxEAnPz0qWtfUFG26Bp/
 q5JQjRUPXRmxnk0Tg5uqJxW2nMU4F0seSzZa9wJepceDj4orZlm9IUhtLrdN964cZS
 nWBQm7819X7a6zF4A6FMBvJIdwsl0M8HnoT7m+ZeqOgExq1wq+NyL7UFbBdXdQbAHF
 2RxCZLDi/pGlG0ECy/gcR0mz6EpSMbgaPlm/7h16BZ8WCKqXkDjRsUh6LRlcxGRkKE
 adLdtJCQmOiuw==
Date: Thu, 12 Aug 2021 14:43:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v4 09/15] pci: Consolidate pci_iomap* and pci_iomap*wc
Message-ID: <20210812194330.GA2500473@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-10-sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@HansenPartnership.com>,
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

Is there a branch with all of this applied?  I was going to apply this
to help take a look at it, but it doesn't apply to v5.14-rc1.  I know
you listed some prereqs in the cover letter, but it's a fair amount of
work to sort all that out.

On Wed, Aug 04, 2021 at 05:52:12PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>

If I were applying these, I would silently update the subject lines to
match previous commits.  Since these will probably be merged via a
different tree, you can update if there's a v5:

  PCI: Consolidate pci_iomap_range(), pci_iomap_wc_range()

Also applies to 11/15 and 12/15.

> pci_iomap* and pci_iomap*wc are currently duplicated code, except
> that the _wc variant does not support IO ports. Replace them
> with a common helper and a callback for the mapping. I used
> wrappers for the maps because some architectures implement ioremap
> and friends with macros.

Maybe spell some of this out:

  pci_iomap_range() and pci_iomap_wc_range() are currently duplicated
  code, ...  Implement them using a common helper,
  pci_iomap_range_map(), ...

Using "pci_iomap*" obscures the name and doesn't save any space.

Why is it safe to make pci_iomap_wc_range() support IO ports when it
didn't before?  That might be desirable, but I think it *is* a
functional change here.

IIUC, pci_iomap_wc_range() on an IO port range previously returned
NULL, and after this patch it will work the same as pci_iomap_range(),
i.e., it will return the result of __pci_ioport_map().

> This will allow to add more variants without excessive code
> duplications. This patch should have no behavior change.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  lib/pci_iomap.c | 81 +++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 37 deletions(-)
> 
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index 2d3eb1cb73b8..6251c3f651c6 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -10,6 +10,46 @@
>  #include <linux/export.h>
>  
>  #ifdef CONFIG_PCI
> +
> +/*
> + * Callback wrappers because some architectures define ioremap et.al.
> + * as macros.
> + */
> +static void __iomem *map_ioremap(phys_addr_t addr, size_t size)
> +{
> +	return ioremap(addr, size);
> +}
> +
> +static void __iomem *map_ioremap_wc(phys_addr_t addr, size_t size)
> +{
> +	return ioremap_wc(addr, size);
> +}
> +
> +static void __iomem *pci_iomap_range_map(struct pci_dev *dev,
> +					 int bar,
> +					 unsigned long offset,
> +					 unsigned long maxlen,
> +					 void __iomem *(*mapm)(phys_addr_t,
> +							       size_t))
> +{
> +	resource_size_t start = pci_resource_start(dev, bar);
> +	resource_size_t len = pci_resource_len(dev, bar);
> +	unsigned long flags = pci_resource_flags(dev, bar);
> +
> +	if (len <= offset || !start)
> +		return NULL;
> +	len -= offset;
> +	start += offset;
> +	if (maxlen && len > maxlen)
> +		len = maxlen;
> +	if (flags & IORESOURCE_IO)
> +		return __pci_ioport_map(dev, start, len);
> +	if (flags & IORESOURCE_MEM)
> +		return mapm(start, len);
> +	/* What? */
> +	return NULL;
> +}
> +
>  /**
>   * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
> @@ -30,22 +70,8 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
>  			      unsigned long offset,
>  			      unsigned long maxlen)
>  {
> -	resource_size_t start = pci_resource_start(dev, bar);
> -	resource_size_t len = pci_resource_len(dev, bar);
> -	unsigned long flags = pci_resource_flags(dev, bar);
> -
> -	if (len <= offset || !start)
> -		return NULL;
> -	len -= offset;
> -	start += offset;
> -	if (maxlen && len > maxlen)
> -		len = maxlen;
> -	if (flags & IORESOURCE_IO)
> -		return __pci_ioport_map(dev, start, len);
> -	if (flags & IORESOURCE_MEM)
> -		return ioremap(start, len);
> -	/* What? */
> -	return NULL;
> +	return pci_iomap_range_map(dev, bar, offset, maxlen,
> +				   map_ioremap);
>  }
>  EXPORT_SYMBOL(pci_iomap_range);
>  
> @@ -70,27 +96,8 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
>  				 unsigned long offset,
>  				 unsigned long maxlen)
>  {
> -	resource_size_t start = pci_resource_start(dev, bar);
> -	resource_size_t len = pci_resource_len(dev, bar);
> -	unsigned long flags = pci_resource_flags(dev, bar);
> -
> -
> -	if (flags & IORESOURCE_IO)
> -		return NULL;
> -
> -	if (len <= offset || !start)
> -		return NULL;
> -
> -	len -= offset;
> -	start += offset;
> -	if (maxlen && len > maxlen)
> -		len = maxlen;
> -
> -	if (flags & IORESOURCE_MEM)
> -		return ioremap_wc(start, len);
> -
> -	/* What? */
> -	return NULL;
> +	return pci_iomap_range_map(dev, bar, offset, maxlen,
> +				   map_ioremap_wc);
>  }
>  EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
>  
> -- 
> 2.25.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
