Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A032DC35F;
	Thu, 28 Aug 2025 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756365535; cv=none; b=YLzYCQJBJfzfj580bW8AfNpsYN59I2THTbNvi/yVypxmz0vQYaaBc49ZJmTzLLuI/AoLjioaGoH02CZtnaLMW+X2aOh80GORczcEvFptuEqOtn8J3U6MGBzLFz5aF9J4TsHRxSngv1zCh0Hys3KV1TcgkdeNa03pFb9HjI29ssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756365535; c=relaxed/simple;
	bh=RLiNIIZsDGQt0B7qhXbwVc0kC0z981GdJgTavaVVo+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPMCurDfcsANH35QmR6eeVJnkKCFzdmBmMnE6i1xTIOtEnQLxIYSu7Ph+m3lWbbkA6lbi94SHiXyJvKrf70Eo7RmCss9VGeuVKhvK0dj3QScxxGb6UP4ew2TZTqhblYDF+TdA8aPdRecYFM+rGXNIEydYhwrcH7q1otgwI9boG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9LacJwN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9LacJwN"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afe9f6caf9eso87483766b.3;
        Thu, 28 Aug 2025 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756365532; x=1756970332; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACPidqQG6DQZNVxh12NaJPKP3Jkf06hyqyPjQ1p5F2E=;
        b=f9LacJwNSChH4MtAZW/xnwbMYN38uyl2ubCOJ9RAyjH+uR6bwVtH3LtZ+Lkgp3Vb2F
         3OMWqqn36KPfL+JLoIChXc6dQ/2EOWDbsTH3x6+774mn+SmfmLhySbYb7Ioc8kYDWzJc
         r0PKYSzThoapMMFBRZja2LCQ3LC0Zrz1TjfDbB3gChVJGCurmvVRCeHyMfo6O7QmCv+K
         RjBTKm3m02nv77Vv/tpPWuZ6BC1Ju1vys0bOa/UUq5Mu3mDMTURO+l1s8ofvyt0E/KRX
         rKi41Ky9/94Q1diaIjg6PRioQ9k5L1Yz2XdEncDvTr/kQwei3G8q8uzudGTQNJo96BrW
         0cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756365532; x=1756970332;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACPidqQG6DQZNVxh12NaJPKP3Jkf06hyqyPjQ1p5F2E=;
        b=DjYPadwMWG8X4MoAbF8gwn2wFnqoWWsxCKT9+xmqOX7eIiC9bJc3x+PZAbYQb7xNK6
         QnHS90JBTjGTFxMMkbZ6j8JRhHUClXpAJUkk6HO+Kviktn1njDj6wqhqANafqn3Olx4d
         0TL3NKYPSyKDl4sKQnPsj4YLNrslT4g8n0wEfnT9iWSMf/kW3QTV7ctgDVVeQZm2omQy
         Ime2Nr1INvvw4kah9sLPiuwNvh3Wbv0Sy4H+bxE6gyff1yUJvWgHijYsHi9JyPFE+6TA
         Yp2U14IVnfRys7KYa+705k2Jx6mXzEx7f2pHTm2aESq4Akk3+56HyF5sqA8j4jwDjBqY
         uV7g==
X-Forwarded-Encrypted: i=1; AJvYcCWUmJ6OnvFKo+IlSMndqKJKwbD8vTSNUN1WXJma5wd5woTJyzBuE/08Qi/eUwPfnafllMBIKw==@lists.linux.dev, AJvYcCWdQHCLiKJBIOUYyzGHNKYdkXOx4Cq78YipECjN2+TN4b87s93wJBPVZiqxm9ta9psSGQBofpTiwDXYRJY9L2k=@lists.linux.dev
X-Gm-Message-State: AOJu0YzEPPP0tx6qLKoLPlSLLyLFU4Q0KsUiYypjZj3YvFy/lB2Z5/co
	T3oJPX9wlb/9QVWbvw4w3T+dpFJIfERE2Y5AVqaTw9y5KjXz7FmNBkeR
X-Gm-Gg: ASbGncv79qiQjEI+8dNi9jvrRehaccl0MldxK+9dCU9t4/mDPN2npUy8Mq63sipL/5q
	PlkkrWaQdOtKElWDMen7WA2ijkieJWtlShmVThXaVpTXyZPr+NXRECb731/GpB6lgl8l7sQdI+9
	8kUUvNv27WSEefv7DGlWr1/HOwpuedZLaVG6mRoEONRz56wydwlvm7u4Oll2Jrco/wASK2aCtdP
	zLl3CpbIvwHYNDxCzE9i64cCGRt1/TuAlKvkvzBc8tvYR4tr6TMfO1aTcqy3i/qyhzUS1u/URKX
	NbO9SDf5JP7fLx78Ppx1bkVZtuvAuhBpGntstDP8Dg3vwEYR9TS282zDglWGmOHPJzW4azkL1RH
	VwveHZwo5t4RuU5Uqks1YJ2w7QccZRa6ieYu8
X-Google-Smtp-Source: AGHT+IEf18QCG44U8jBJ4evHstdtd0oL4Hr6BpN08BPT0cHmsLXVki3gbBRZpXohq9eRx3IUTA8+0Q==
X-Received: by 2002:a17:907:d2a:b0:afe:dbfb:b10e with SMTP id a640c23a62f3a-afedbfbb935mr140730666b.47.1756365531421;
        Thu, 28 Aug 2025 00:18:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe98ade972sm616427066b.50.2025.08.28.00.18.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Aug 2025 00:18:50 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:18:50 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	SeongJae Park <sj@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
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
	wireguard@lists.zx2c4.com, x86@kernel.org
Subject: Re: [PATCH v1 01/36] mm: stop making SPARSEMEM_VMEMMAP
 user-selectable
Message-ID: <20250828071850.kl7clyh6e75horlk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827220141.262669-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Aug 28, 2025 at 12:01:05AM +0200, David Hildenbrand wrote:
>In an ideal world, we wouldn't have to deal with SPARSEMEM without
>SPARSEMEM_VMEMMAP, but in particular for 32bit SPARSEMEM_VMEMMAP is
>considered too costly and consequently not supported.
>
>However, if an architecture does support SPARSEMEM with
>SPARSEMEM_VMEMMAP, let's forbid the user to disable VMEMMAP: just
>like we already do for arm64, s390 and x86.
>
>So if SPARSEMEM_VMEMMAP is supported, don't allow to use SPARSEMEM without
>SPARSEMEM_VMEMMAP.
>
>This implies that the option to not use SPARSEMEM_VMEMMAP will now be
>gone for loongarch, powerpc, riscv and sparc. All architectures only
>enable SPARSEMEM_VMEMMAP with 64bit support, so there should not really
>be a big downside to using the VMEMMAP (quite the contrary).
>
>This is a preparation for not supporting
>
>(1) folio sizes that exceed a single memory section
>(2) CMA allocations of non-contiguous page ranges
>
>in SPARSEMEM without SPARSEMEM_VMEMMAP configs, whereby we
>want to limit possible impact as much as possible (e.g., gigantic hugetlb
>page allocations suddenly fails).
>
>Acked-by: Zi Yan <ziy@nvidia.com>
>Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>Acked-by: SeongJae Park <sj@kernel.org>
>Cc: Huacai Chen <chenhuacai@kernel.org>
>Cc: WANG Xuerui <kernel@xen0n.name>
>Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>Cc: Michael Ellerman <mpe@ellerman.id.au>
>Cc: Nicholas Piggin <npiggin@gmail.com>
>Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>Cc: Paul Walmsley <paul.walmsley@sifive.com>
>Cc: Palmer Dabbelt <palmer@dabbelt.com>
>Cc: Albert Ou <aou@eecs.berkeley.edu>
>Cc: Alexandre Ghiti <alex@ghiti.fr>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Andreas Larsson <andreas@gaisler.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/Kconfig | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/mm/Kconfig b/mm/Kconfig
>index 4108bcd967848..330d0e698ef96 100644
>--- a/mm/Kconfig
>+++ b/mm/Kconfig
>@@ -439,9 +439,8 @@ config SPARSEMEM_VMEMMAP_ENABLE
> 	bool
> 
> config SPARSEMEM_VMEMMAP
>-	bool "Sparse Memory virtual memmap"
>+	def_bool y
> 	depends on SPARSEMEM && SPARSEMEM_VMEMMAP_ENABLE
>-	default y
> 	help
> 	  SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
> 	  pfn_to_page and page_to_pfn operations.  This is the most
>-- 
>2.50.1
>

-- 
Wei Yang
Help you, Help me
