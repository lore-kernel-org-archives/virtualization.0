Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A460361DB4
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918681; cv=none; b=N82VYeB/cpfUJvBGhQZmpLQxkwCVgpHctQf2iIwRNiwbgCZT74uPKqXVArwzbn6wCH4ARvq4humiuDbL0V6LWKvSMYqE2pQghyaSPf6VeTLo5FHbdEAgTYYjBUlKS8S184Jwyws7GlsOgJKzZ3oDpsX2fokrJ5BxGKjdcrCbEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918681; c=relaxed/simple;
	bh=WjqD8BmJJCSwnwwzfZ25UIQEN6U/q+AVmj3pu35cNZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ8p1PfbusBpfhtQqxD171Nnhy1UJLa3tCR0YB2YZ65rrvMe2azG/hE3eWlmpdC4dXU9qdKx8/Pg04qGUfc/MknpnQD3iOCKacFNmND+BCfVrgxJLrCrVxCxOKOKa8nMgxekA72P0dHCFySgjOcJwDkd+4VXCm8dqhWk4kRo4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZhuY+Ksn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZhuY+Ksn"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d6ab4476eso61334541cf.2
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 21:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776918679; x=1777523479; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzBI8Vs9g1xHTdi85g03Pkd08y9g2RbvUpIAv03SBC0=;
        b=ZhuY+Ksnbxj33jsXHBwIzUQBx9s5+YsPVWgATjhlhieZmpJ7FA5Xui47W36IqAilTW
         OMSVtrOAX20soKqLPak3e1/h7rI5Q+XpzVF/k6KZ6GvMjHJaN80msY9oTNQGNmPkqI1y
         qAsUBKU8nDY07lbjFdVTv+lYVUmeHUYVW720zuw+6WBWbKVfTg/B+6sCZ4ysYyOM3Cjo
         pbWVAFKQgaZojCy3XXWMPv1cOclbVPBDvggX7ZAmDJ8+28H7oTlf1ns2vC65IQd7ippj
         jJLSy2+Y5CZ3FjIiyVuVWTDBd9iQVF9jwJaoeXmoMM9OrSyjLgK5vOPe7yE8ZJzKfsKg
         hXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776918679; x=1777523479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzBI8Vs9g1xHTdi85g03Pkd08y9g2RbvUpIAv03SBC0=;
        b=XKXC0kD6m58qSMZts7u8M4XZtAiKEFvjLzT6fMZaMKeniUwfb26IjImiNtbQv54Ryr
         g4dqq8WhzTfdWMcKsearLEtx+06qXRFQZlBdKA6AfUnfVYBYhvOghxI0/KMqth2UKXjy
         +XA1tnOJ81dzmkpTEc+PGsSbtw9FqapoK+ufJspuCyspl2dEf093uWSG7n9gZUhdkRD1
         vWFWzzkn/pYwqMhsKDyllqf2NeAKd/kxZ+FtOoXjIKYlcqcI7xU3iu2j7FQMjCzmJme7
         AV0rS89YexAoy6mCTzafE2pQnTX1ibKRJLtX1ucKuWRhHrhwOa0ksDtNG5tE7Mc13Bwr
         KrBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yRpVz/PsJBgI+I1TFjIqI24fF7a7RUI4XM6duXXrcdgyZhXpHEYOt71IMm3OEjAF3jTEXnwlNGwUWAwCMGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0gu957FuO+IEpH0x1AsRICZzhpFPKJ6bxOq33xjRAmF2TX9P3
	266A2zV6dpdJYvRHfyMaoppeWFkh0eHdVEvnWtuATG8jsc3SRqR/9Di6OrSUZoqhVRw=
X-Gm-Gg: AeBDies0qDwZcs68zAiX6W9HPPfOy8jvkSV09LfJKug7Huyd33JUTamFFR1QRNcH43P
	mIkgTaQ2tkHFLz/pM9EYY0FrBMrkwigLlkHSK5iZvDg/hiNMduZExYHOLO1Gr/CpmQrLfqUGzQ5
	crNZaHkfbMOCmPGvNC/g3InhkfJrSBV/rx7A3sefIFgpd/TGyk7RNAZdiKrllqqCx1QcQyLR9hh
	6i/Xe8TwWtClTycf+HtO0meAJkifv7670hY02PWBQ0gIHHmvvk9r57GKaql1zA+QBTGQ49sFBNR
	RgJc+AbsrsKM0Vz35XqY/RQ+kR5hwS63TVuAIemXcVEZtm1ITHWGhhzRzI9c7YT1K8OjDZXCbg+
	UNB3b5+hxx/9J9FlxReDwYO8szR5BwCyv3lMWjQDcrio7Jc9xTGCJKia0k/JBeaRfMbAjqSFUFi
	kY+xvg5pXW1KMSHzxzvz7P4M5XFvQQKAQpkvMBHGMHV5j9d1o0C3Kxk8ALk1xR9dCZXEOQjqY2W
	RwysoG7kgVEaZEmNBtx
X-Received: by 2002:a05:622a:409:b0:50e:89e6:669c with SMTP id d75a77b69052e-50e89e6697dmr204320091cf.37.1776918679403;
        Wed, 22 Apr 2026 21:31:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-246-228-50.washdc.fios.verizon.net. [71.246.228.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm147982736d6.49.2026.04.22.21.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 21:31:18 -0700 (PDT)
Date: Thu, 23 Apr 2026 00:31:16 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
References: <cover.1776808209.git.mst@redhat.com>
 <9dd9deabd42801f3c344326991d1431c3d8db39d.1776808210.git.mst@redhat.com>
 <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422171315-mutt-send-email-mst@kernel.org>

On Wed, Apr 22, 2026 at 05:20:27PM -0400, Michael S. Tsirkin wrote:
> On Wed, Apr 22, 2026 at 03:47:07PM -0400, Gregory Price wrote:
> > 
> > __alloc_user_pages(..., gfp_t gfp, user_addr)
> 
> With a wrapper approach, looks like we'd need something like
> __GFP_SKIP_ZERO so post_alloc_hook doesn't zero sequentially, then the
> wrapper re-zeros with folio_zero_user().  But then the wrapper needs to
> know whether the page was pre-zeroed (PG_zeroed), which is cleared by
> post_alloc_hook before return.  So the information doesn't survive to
> the wrapper.
> 

I was thinking more that internally you already have that information
you need to know to skip the zeroing - and so the wrapper can just pass
__GFP_ZERO and post_alloc_hook() would do the right thing regardless

Then on the way out, the new wrapper would take care of cacheline piece.

However, i explored this a bit - and while it saves some churn on the
interface, it adds two paths into the buddy - and that increase in
surface might not be worth it.

So I see the tradeoff here.  The churn is probably worth it.

~Gregory
