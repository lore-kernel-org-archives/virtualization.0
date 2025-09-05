Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72436CE1A
	for <virtualization@lists.linux.dev>; Fri,  5 Sep 2025 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095362; cv=none; b=j1Eks5d2gLetn/MBDu6o+Wq8SECn9Tu1hMcRq761JVgggvIWAGyI4WxlaKidbF8CG3Fhmh17Fjk5iOywadrD8dDVm8eySJELrfDCojUvK59PnAKwmDUqfkUOlgxyttTtvTiqDI9cokA/44vJb7AQnv0yfvB1hzZ3UKEUB6Bi8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095362; c=relaxed/simple;
	bh=Qb+QuJSkObqX+fj1w4dRqT/e/kifWjnwMbO8oipHUNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6PZ8loezPWeis1rr5rjJMZjnlFcDktblSIX5WMu/YMDDq8s99i24gIcTkpu1oUR+nkxxrXYw8EJtPsILC3z79lZR8uDPjEcCY5/AJkiBFYFvc2K3bvphU3xxt+4w0rceNhjY0F8L2yDIIeomUdH9CwPc0bMOdtT68ZVrMuKqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7cLrF3F; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7cLrF3F"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b520c9c291dso764947a12.1
        for <virtualization@lists.linux.dev>; Fri, 05 Sep 2025 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757095360; x=1757700160; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyvqbUDXebspKl35FIPJk0lFngkuMldmVpFc1O8R/zI=;
        b=l7cLrF3FTQu6Cyy3QNKWtHldMQ6pAEtxZk7kcrzlkrQXpdXrq7CYwju8DWLuhznQFQ
         AcKJtPiANwApu0JtH8b1euPuXUPS5W4zE/hsocuVSJXdqkf/dmhHdHEBDlKGhHyWq/db
         EVf+wWlca2RGPEwxDRRbhAtMN3vphY38CcjY1ufrx4/mlJUnFaJpXvNGOTTYkZOzb2Tu
         sHci8oCFeMupQ19yKck4BWzg6SlFflF4aSWsBwOChAt2LoOL8eoHQPV1NfMuC3+NkmGI
         MYwfk9OoAYCWOKaVEkKGbX38WqXUX52qf/ctCoVd/vUhveIgOAptOe0PZdSdkvXHYywg
         KnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095360; x=1757700160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyvqbUDXebspKl35FIPJk0lFngkuMldmVpFc1O8R/zI=;
        b=GgRbfsxMibOIAJYehFSMyfZE2y8Jqg06792oiAR0yb3/gfeinuqW5glJn0Jr42eod3
         TMs6eBueueeJYfTH61TMgwvC19E40WyFlIXpGefwahmCakb5/THFI9YHf9fRr9BW4VLy
         CDNSSQrXhMj7LahHOgqwSxibGAgsthAHCjUvCYioqQW2ud3nEhfH4wHNCsNhZAn/B07s
         oRLVkAbCeGw4VAcOeWhpyi/YJ/X8ZrkA2PlXj1V4yp2GXdRkZ6cnZT9LSUgKCdtp2BQ9
         HCnKyZJvAXumYQrnSMvL+Yj9tkyebjx+Om7uDbDKEECTopjzjO7wQkG5VUQsIziiGsJH
         nFSg==
X-Forwarded-Encrypted: i=1; AJvYcCWZfyZCOomR92V3QDOYB2E+bRMgCEQSj/ZaydJUPLGaRxRM1TqsTjMsi0315FK39hKlMT/srbzWppRwRdSCHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMWhu1ugI60GRzzZWH9+drdpOZKIFX+3P4teZwb8zAuN+EFF2g
	+63Zty8hxgfT4jU390pz0OPl5vZS8e49KmURAx7b6VypqXK21REMh+Dn
X-Gm-Gg: ASbGncs1Nd0b9rYiSn90nocLoi9f5H6OkJfgzlS+lplaR5zJnZ7NiJSEJjFFsDlDF1x
	VAsDqlvyP2+/2tNOHNbNaFFRvjgoqxLhQdxXeRKwHXLGJ6cmm9Led1EidagkXfUAh0m39bhUcRs
	y8b1zGWi5+b6XjRg97HrbCupEg74wRpvGHOOEUTX4HBy9IZPv6s23XzRRyrQJtmPQx56OaAowM6
	aQ4NlTjxFoit3yCwR4vF3tQNN3YC/Cg26sTeeL0MuPhjQLdHQCMDEfiHjsksgoas/5HQG0EgWj3
	MCx660kegPMtoFmHQPoNHElR0HToa5fMdAsGlRlTJG2zfojZJTz7cAfkaLoUDWbdcOmJajftqpI
	drIgVXwbJgtkJ6nViG02be7MBntRppRuh0HJVXPuMZWs6KJlzv8gdZ18oWJgljzpcwKgKE0x95V
	M=
X-Google-Smtp-Source: AGHT+IH4BIuCOkufR5zpdXWK9alIlYMnPti5eXH+01WmcFERf5EmF47R3LvTkLS7gssMCY0/Uh9xug==
X-Received: by 2002:a17:90a:d64e:b0:32b:5c13:868d with SMTP id 98e67ed59e1d1-32b5c138af9mr13139268a91.1.1757095358574;
        Fri, 05 Sep 2025 11:02:38 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b95d31976sm5409595a91.22.2025.09.05.11.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:02:37 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:02:35 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/7] x86: Stop calling page_address() in free_pages()
Message-ID: <aLslu1yKPNgoz1OU@fedora>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-4-vishal.moola@gmail.com>
 <aLl9KneqOYTujcCh@kernel.org>
 <aLl98MQs-FlHo6bW@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLl98MQs-FlHo6bW@kernel.org>

On Thu, Sep 04, 2025 at 02:54:24PM +0300, Mike Rapoport wrote:
> On Thu, Sep 04, 2025 at 02:51:14PM +0300, Mike Rapoport wrote:
> > On Wed, Sep 03, 2025 at 11:59:17AM -0700, Vishal Moola (Oracle) wrote:
> > > free_pages() should be used when we only have a virtual address. We
> > > should call __free_pages() directly on our page instead.
> > > 
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > ---
> > >  arch/x86/mm/init_64.c          | 2 +-
> > >  arch/x86/platform/efi/memmap.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > > index b9426fce5f3e..0e4270e20fad 100644
> > > --- a/arch/x86/mm/init_64.c
> > > +++ b/arch/x86/mm/init_64.c
> > > @@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
> > >  		free_reserved_pages(page, nr_pages);
> > >  #endif
> > >  	} else {
> > > -		free_pages((unsigned long)page_address(page), order);
> > > +		__free_pages(page, order);
> > >  	}
> > >  }
> > >  
> > > diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> > > index 061b8ecc71a1..023697c88910 100644
> > > --- a/arch/x86/platform/efi/memmap.c
> > > +++ b/arch/x86/platform/efi/memmap.c
> > > @@ -42,7 +42,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
> > >  		struct page *p = pfn_to_page(PHYS_PFN(phys));
> > >  		unsigned int order = get_order(size);
> > >  
> > > -		free_pages((unsigned long) page_address(p), order);
> > 
> > Could be just free_pages((unsigned long)phys_to_virt(phys), order), then
> > the page is not needed at all.
> 
> Or even __free_pages(phys_to_page(phys), order);

Right. It actually looks like we could inline this whole block if we
really wanted to...

__free_pages(phys_to_page(phys), get_order(size));

Should I send a fixup (or v4) with this change?
