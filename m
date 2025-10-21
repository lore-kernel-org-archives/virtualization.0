Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1234B186;
	Tue, 21 Oct 2025 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066818; cv=none; b=Us3oP8AKZJF3LvfcAYWZwMSPsJuKnBQQcvkVZQqOz8ieQrBkQL6Poy9hMdhT+LTihZMW62U0JHmlQdl7QFz4s939pVL6Ik06VE1i93soFqRAtSLDQSFPsas+wzbk03TVisjJd8sg/l0qPKts3PhBWvq/Y8XKD+WKmJo9eXKMDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066818; c=relaxed/simple;
	bh=R5R2k63XM16jqmqIYLNZB7V1352UBMlgCSWQ7dgTCYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGkBN+rRFXcrdHZH24SsALAFY90UBY4ywbLmX40YpUTepVI5Iopa4SrLAP8wTOpC+T+Y7aOC+DoweO3lpZfYRuMQNwLS5rT4jONUff2QKjGk3orjBJ/CXGcxOPsyUjWCL/sQECoFHjhF+5/P8D/DExPGgF+i/T68GDptrqz8NUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2Q1SsXK2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Q1SsXK2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=T7OF7YinQtdM6zEwx9mf3VJteIbSNxF5xxDOzyp6kaY=; b=2Q1SsXK2pXUN8mCnQvRcx+QhQn
	VHutmMR5Rm8NehoV2QJEip/SnFEKMiY64LR/hUPPumhePnybaugYxUzHfGHyOTx0cLGbotoYVCFO+
	9lyaG/SBzt/6AdyC0IaqifMG/VBu1VMxQL4cnSdmGLEv5ebIL4NZuRX+insIu9cdUJH+b1dnBTRaV
	g/ngxAKGwaWSaDIqSP52BljzzeAD3aihVqBuTjHlzHYldIZjI+8FkMKoKbeVVwYEWZ5Mboqi23dON
	0PhF/1OuVgk3SXof8lmqPChWNgxxrLnkYAEP0sqPbIgJb3IRxOhYKRc9Dv4GF2LUgqx3m6edVBpYg
	uGdt9VGQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBFvS-00000000CZQ-0p2N;
	Tue, 21 Oct 2025 17:13:34 +0000
Message-ID: <3ba11b0c-818f-41d5-8885-038c7e0133f5@infradead.org>
Date: Tue, 21 Oct 2025 10:13:33 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/23] mm/kconfig: make BALLOON_COMPACTION depend on
 MIGRATION
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021150040.498160-1-david@redhat.com>
 <20251021150040.498160-4-david@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251021150040.498160-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/25 8:00 AM, David Hildenbrand wrote:
> Migration support for balloon memory depends on MIGRATION not
> COMPACTION. Compaction is simply another user of page migration.
> 
> The last dependency on compaction.c was effectively removed with
> commit 3d388584d599 ("mm: convert "movable" flag in page->mapping to a
> page flag"). Ever since, everything for handling movable_ops page
> migration resides in core migration code.
> 
> So let's change the dependency and adjust the description +
> help text.
> 
> We'll rename BALLOON_COMPACTION separately next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/Kconfig | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e47321051d765..3aff4d05a2d8c 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -599,17 +599,14 @@ config MEMORY_BALLOON
>  #
>  # support for memory balloon compaction
>  config BALLOON_COMPACTION
> -	bool "Allow for balloon memory compaction/migration"
> +	bool "Allow for balloon memory migration"
>  	default y
> -	depends on COMPACTION && MEMORY_BALLOON
> -	help
> -	  Memory fragmentation introduced by ballooning might reduce
> -	  significantly the number of 2MB contiguous memory blocks that can be
> -	  used within a guest, thus imposing performance penalties associated
> -	  with the reduced number of transparent huge pages that could be used
> -	  by the guest workload. Allowing the compaction & migration for memory
> -	  pages enlisted as being part of memory balloon devices avoids the
> -	  scenario aforementioned and helps improving memory defragmentation.
> +	depends on MIGRATION && MEMORY_BALLOON
> +	help
> +	  Allow for migration of pages inflated in a memory balloon such that
> +	  they can be allocated from memory areas only available for movable
> +	  allocations (e.g., ZONE_MOVABLE, CMA) and such that they can get

nit:
s/get/be/

> +	  migrated for memory defragmentation purposes by memory compaction.
>  
>  #
>  # support for memory compaction

-- 
~Randy

