Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6130103B;
	Thu, 28 Aug 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366532; cv=none; b=ur7441veAjPdu02HgSp8N5fiDxzI6G7UtGDYy4aEjchfGLhv02NwUFdg1rS6Oo95/WTQCLGZJFvwH56ujRjyuTq4/St3TRxnUl8Jrttp1ECoM6DCnKV63Ej28HkGUFagC/6iJoq3Po1W0ogG3bTrzY+9Or4H0u5h92LPEBQrWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366532; c=relaxed/simple;
	bh=HM+OHjGmq2TcnjkHfcjXG9OSRqGR45uKHnDS4eTuII4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJUmIFIUioNJS/07y5791+SD3BxaLJxVBpYHWb1GJ36H2MDXjtV2tWwqhKoF7H0UEdOelRL80jnMoy/MH9tbFngQynFFNgSdPLOBH//GOugsqdIAqpHa+lw3/s9hW/6ucAeoGKV05J0fubfGKhtem0+KWSTOKmoxG7owBIPBIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFMiGGp6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFMiGGp6"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b793d21so746986a12.3;
        Thu, 28 Aug 2025 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366529; x=1756971329; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wdLKdu3gRydbgkaOExgCyxr/LuNr8ANanTK9VurXYA=;
        b=UFMiGGp6sgeogk5qc3EiglCIeb6t3+uu8nedovADlbvQbuEPdw8XXI3eh5idvNkoyp
         WdmYAq1JUPuyLJ9Ogxif2WppNFh4SIJOnaxB+ruu9e+1vcH6RBGfZSC3Q/R/iR/VNcSa
         +W9S6Vze5E0isgMYPxHCV9hf1ZFmx/H6MVAGgPqoHXeFOUHIbIPd9AX3OozMc81xjIa4
         7FwfSwy4AteCsHVCV/KXOK2qyZXq8aha+R5W80JcM4iKUfTC+38zbYdv7afO6IaZzhAC
         eGLfWN7gCYiE+2Qk/uKrbURbaloNH7IQGQ6NZhvVgXSzC4tpPBGJ9vVL4AoTvrVSuX2B
         ohnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366529; x=1756971329;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wdLKdu3gRydbgkaOExgCyxr/LuNr8ANanTK9VurXYA=;
        b=pwFcuRuD+mZPCFO7YJ8zK3SYiFlbnLHDeBoXh6rFCwCcC6FeZ/nTF34uqKlYVXzIcA
         UHmYF1hpIacQg8RrhEmCcsc0wegDUhR00nGJjtCDeKkxwybZ1Y4nuwwv2UMZ2e50wdog
         FOFGLAXC4UIsJRIHRuOnmJzRpDScCDN6azOHiswWGtMei/iWGvJj4mG9Pssk336xG9QS
         dPvZ37rHMkA72J8JNHXcaC81ID6PtPr62qhy9Zkafez6/BEKF2GbHIPk7MJdw6Rzz/OX
         FkUBjY1qKijefwDsgiCg1Hy80xr7MYPlM0J9Clmj9kgfzUwHggMnAkcYXPdshbkRqEIk
         dBcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXblS2VbrHnImRMX1eU5Gf4kKRlsgtznvej8nAWriWBDV+p49SDIwBXjoD6faXNFSSJ8/8yJ0Q17TGo6f2us8g=@lists.linux.dev, AJvYcCXgrbaAawLFySNN/y6uVHP+csNH7b9jZS9EEEb77RqtXUxchIHmbIKzhNEV7aI6ct2Z7g75kA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPOY1+15+djjTm1CPdOgE+bUnthqgVHC9q+CmRKUTLpBN7tHL0
	vDRSKhsYqD+eCjgn4n061/Qn8EXmQKtZgt8SeJHZMdZVRDefDfJXl8h/
X-Gm-Gg: ASbGnctdNzBWd/MLyQ45XFgkBQj8mYaAx88eCQn2z/edfe0xs5GxyRBfMrJMsaQir+X
	rWDu6wVVlGOBs2nI2WVKpjqoch678ezBNXhqdPwKpZ0Umkfp7WAXwNDpNvor/2iHxf/33/PnDm+
	SykeOhHZ8W+oSklH59Iwc4Ni0Kh3MUA5tY4yuzaX5t5sOR5SKBac8R+EmyHRwuMjAq4PmU5AEb3
	z0oQSzVeqLaEJn9sJ8kzL6G7pqVay4j2ABlZP4NFhRkLjvaRAdoRbMD0oljDIO7jai66P+8BbQ6
	hKecMOBHGfPRV+h37kQKRTvMKfk3zPrr4h1iX+OShmzZmkIr76Jm734GAvbqa0C6p/h3F4+D5zg
	s4WyxzyuBFXQ7qHrDdmDP2YPGgg==
X-Google-Smtp-Source: AGHT+IH+/HdQFSXw/W0bPc1NEIz4PAWk+piUx/7dt/vdSor64JcoeKILsFtoJ4Brv3+pRvjO+XdeaA==
X-Received: by 2002:a17:907:3f0a:b0:afe:d590:b6af with SMTP id a640c23a62f3a-afed590c109mr310258266b.20.1756366529084;
        Thu, 28 Aug 2025 00:35:29 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe77c2b758sm886311466b.84.2025.08.28.00.35.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 00:35:28 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:35:27 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, iommu@lists.linux.dev,
	io-uring@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com,
	kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 09/36] mm/mm_init: make memmap_init_compound() look
 more like prep_compound_page()
Message-ID: <20250828073527.u4k47fohaquzf3pg@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-10-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220141.262669-10-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 28, 2025 at 12:01:13AM +0200, David Hildenbrand wrote:
>Grepping for "prep_compound_page" leaves on clueless how devdax gets its
>compound pages initialized.
>
>Let's add a comment that might help finding this open-coded
>prep_compound_page() initialization more easily.
>
>Further, let's be less smart about the ordering of initialization and just
>perform the prep_compound_head() call after all tail pages were
>initialized: just like prep_compound_page() does.
>
>No need for a comment to describe the initialization order: again,
>just like prep_compound_page().
>
>Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
