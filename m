Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55423E8686
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948758; cv=none; b=cs9xwGjJZhSylhtmoziuv7gV8MOBASpC+LxLwQMweJ4qG/7y4bwefM4sRslwV6lenv9qB6xPJ/0bOwrZyvTFBVfggZZh5PcgShNjKxNxCBjQq1Jj/5+S8nNSogdkQwC9lUQ1CnNM6jBe7I/pQFI1/vpszmtBnDHmlXldzr+TlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948758; c=relaxed/simple;
	bh=nC/1q8EJEgXGdRfM0fgAm8GRfOb2Sflm3M+qFkNWGug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsXIVvY9UtOUXJncqdY+uNKY01s0WOcBJZI2Wfu2Ejiheh3K4Efgz7IYtJPhkflsvloCZVTO2oDTtUj+MedmRsAd/O2yl9vm6+9PTpCzUdW9pQMjLMu3wcJd+Yz15w4zVVxmFxP6h5fqLUdOGvyRykj3BzWyI6EHzd5ekA50vEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QPvrA9tD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QPvrA9tD"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9158c621ebbso566408785a.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780948756; x=1781553556; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xwdm1oiBGcy95PBpOYBrMILZr7DavlHrl7pDmQKHX0=;
        b=QPvrA9tDdX9904p4RgEKctodDpNjjRcrCDfyaCV3NeMDWZJfQhoPTRljKo+lJwwcCr
         NV58aEuGsPKsN/YrFYMGolF5iLtjDPZiH8kjrq0wVOX87So2pt+8IR6EvQCY2J013ipk
         hDQmyTgxHyt17ZIfSfAWPjrjCI7ThbjLlgmNoImf3dRGv8y4N8gTHcwa1Z3N/TVVAaw5
         L30doHKPbDJQ+BH3P2HwdWiOj5MdLL0vPevAYvQNadp1eLxiFDTrfkLyv1jDuRFoHqC0
         UqX1uesqv6VNr/XO4o40wfH9817RwdPGYwioTFA0MByZ1dQyf8q0QQDZ+XBhFdKkVaK6
         lGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948756; x=1781553556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Xwdm1oiBGcy95PBpOYBrMILZr7DavlHrl7pDmQKHX0=;
        b=gtchSZJnD+zMsQxf/EUFb0EG8HeViWSTqUlksMf/yvxzrdod47d421R4ShXEAYqCyv
         9PuX8etJ7OpOHBKUtEQ/gqFAd6OJ3kewyyaKzcVRfPhMkUs7GNW166tRZBw44pX7y39s
         fNUl295phLLdlHQ3M/ZUjogTrfN+PIakoMwChaDE4JMu+CJCKypSKxNHNQaNbfXBoVJM
         3htRBPl6FSxtTWYXdblncnD9oHVorVFDLKR7J6CSX9tgPXlkH0td8SXw4bB7Dbav2PFO
         goVz7GoxvS+auJIYbb51hmyAYU7+YXM+/2DQa88jEJg5xbuaEVGwQ4zJ4AjvfipFHrEb
         PBvw==
X-Forwarded-Encrypted: i=1; AFNElJ8KghOVo0lgogFByjP4J/UJ+Sr8LC2ze9Bjpy/UEGZZqX2i0zHh0tXvv007kc24YvMDeE5Ipew4EGSuHyNcQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/RhTzS2npvu2+pIV5Itvcw27uZkNfe5shVYs40aHKGdqfAkDr
	QwMG8MiteDoPwdCuIPa/UapMAJ3IVefJgQ6NIkB+dPbhfgKjJBQT8dkWsvKQpi/06uw=
X-Gm-Gg: Acq92OGg+oRG5Sb3yypvSUcJKfCk97qBzVY1EHJqqHUKNQkrX4TE48Od83TxLeG3xDl
	EA1X3X2RCl7ehbEuopO0em/sPWXUAc+GJs2qsAupinI6B8vyKL1eWijgDMamLcJo4ohoHgUzqKy
	c4sBvqyMHEQ0MhPTqLQq+e5uyUrHwKvrlX5eRZD+3nCQ5CAMsCo8Z7OOknaFv2F6VZJFCl0neTo
	SbXpvO2oINeCpCA93mWx1SfRRb5egETjzWboBXVtT+EBIyiIjMuimLysIFA795pCrY5C/v+rBcw
	C8c7ITi3RFMfgXNSKpFXuVlTnxC7J039fZrlHO3/QQTupoOmRyz9mejs+GlqMGnyxrNyd5tzXNw
	C8zGRkQFhF/N6fd8y3sCkUSys1OGw03N/AsfkjN9RVIJllUWZfxF26vEkDu/tPT5YBnOAgdgP74
	NXCLADzaK3/OLo/xU8waR3Xqvz3ChRTtTe5+E3bQ6CvUCsqAHUJs1k7GeoGAOdI25pND0junBDF
	yrYIvVvtgrPmxcE7g==
X-Received: by 2002:a05:620a:a0c8:10b0:914:babf:9f56 with SMTP id af79cd13be357-915a9d763b4mr1978857285a.39.1780948755844;
        Mon, 08 Jun 2026 12:59:15 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3c2492sm1978154685a.34.2026.06.08.12.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:59:15 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:59:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v10 07/37] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aicfERTP3H6AndOs@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
 <aia93IzhTgi1vGi6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aia93IzhTgi1vGi6@casper.infradead.org>

On Mon, Jun 08, 2026 at 02:04:28PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 08, 2026 at 12:06:35PM +0100, Lorenzo Stoakes wrote:
> > But instead of overloading user_addr to indicate all kinds of things, instead
> > make life easier by actually breaking things out.
> > 
> > Like:
> > 
> > enum alloc_context_type {
> > 	KERNEL_ALLOCATION,
> > 	USER_MAPPED_ALLOCATION,
> > 	USER_UNMAPPED_ALLOCATION, // Maybe? Do we ever?
> > 	/* Perhaps some other states we want to encode? */
> > };
> > 
> > struct alloc_context {
> > 	...
> > 
> > 	enum alloc_context_type type;
> > 	unsigned long user_addr; // Only set if type == USER_ALLOCATION
> > 
> > 	// Maybe something suggesting context or whether we init before in some
> > 	// cases?
> > };
> 
> Ugh, please, no.  As I suggested last time I commented on this
> trainwreck of a series, lift the zeroing functionality from
> alloc_frozen_pages() into its callers.

This sort of just implies writing the "alloc_frozen_zeroed_pages()"
wrapper that does the zeroing at the end before return, and then killing
the post hook nonsense associated with it in the first place.

None of this resolves the user address annoyance which is needed on some
archs for cache flushing.  Whether anyone agrees that the page allocator
should be responsible for this particular operation - open debate.

~Gregory
