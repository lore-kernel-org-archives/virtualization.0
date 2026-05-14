Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E47D30BBBC
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772752; cv=none; b=aTCouJWq54PIfDc9JpF6F16+5EfuqK4qdOSt1yCCiBBjMPgyuH9F2xdhAm8+jdco8KdDBeCDTsapoIVTfFXbIMqhd8pssg5ePSC/ids2vh0CII8btPy0H/zV0Mc8lxYdUL0Ecq48QiVZhCc1K5RHltTFH8KQXTEPGQl5hpoqIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772752; c=relaxed/simple;
	bh=DNEzxhCO1K+15YArSw9FozqwIgcFAXLLbX9mz/RoBls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt4bF4tR5vRUbO4GkTDxW6hsYelb8OiN5TUlTid8ntqA7hwKVQ/9G45872DhFJce/jrUqcZUoFfn0NQi6kKtuxYlR+8WsPSaXbZ758avq9zS4xFPokZ7ir2Q57BLL+Xs9UMGOqrXhDBM6lWalqxWYjq8cGRjshS0Wobw71wyN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N35SnYQp; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N35SnYQp"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-628086439b6so6148122137.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778772749; x=1779377549; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0Jrdww3R9YJMBWZEBaj/2VHLPNdS7oRIHQummGxhrc=;
        b=N35SnYQpvzxJtNOVCBJ5QRuOk/7uJlvn28vYVQuT36s9DwhHXgqfYRu0UBj511wy47
         0r1+pDTV5/Z3PXSNFHU44Oa43bHFPvriq44crxfxyTxF6dlMxD5yGGWRNJUzVVoVmmc9
         iTmd9SZTAGaO972TiRu7MXZ2V6LuNEZmQKRrtiP1iBlSjYORAMAKUbCHqbPfuE2yy14L
         LoGDL69P2q+V9nDnl1LDggrGyKO4+vBKr5js2UVgcN1xWq+YZcVVU7kT7QAEHDM4nrlU
         SKb5FB4ubCKjtOfgG4q+VdpEEan0UGSCs1Y5cBlBeWpcBfdlgepGSo4wwRKB7fpki1bS
         NTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778772749; x=1779377549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0Jrdww3R9YJMBWZEBaj/2VHLPNdS7oRIHQummGxhrc=;
        b=fBt4bDUMOGQjSL19UQTi6mZ0ZPKCiIKTxpZdjd4uO0quIKdlK07V3NfllzT2JVVDHH
         3fU4xqNlypZzDGoSV4iIauB36lVZVkGr52obLg5o9RRJhbAj77Qag/k9bh8uph0NUGcN
         uDi27phVi6/Hnxogz1a+Dxqlcs4fKg5ssUDc5dKDJkWIco9UhomNBWooW7uc2IqbWv+y
         DtUrOD4c6aEQr3AgI1QC7NuZ796qQ9Vvv1Hk/0AM1YX2LOrTT+RbsxR26Q+fNf5xY4KO
         V8IUgKsyKw+4rXGLfGiYbv19OgH1bQTDNSZS9HqITBe8NKxhDMrH1F0+6St7kt2nxYWo
         jzeA==
X-Forwarded-Encrypted: i=1; AFNElJ9X089exvhdEN6LvwnGToVVGd/BaJLKTce5eOovimsmyCNmduOj6OoQ9avW5is+fAvJqRJQ1Q8kD+pUaUQ7pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxzqw1SEjDtcBnNzv7mwAVXRW0zVNBTyN22RXQ2AnsFkNyoVBUG
	AtTHUhSi9aaByB2cbknnw/plB2WFzHG5kVZzx1UXouq1xqJUFq1zlonfnkcEIXcs9L8=
X-Gm-Gg: Acq92OEVA3xGT1hKXszCXdXMEUmkWXM9CO4HqoEYd/w+lCU5yZxG5sUNhIWaLPekV1B
	fkYgCJ/+6mVuwCEkuKC/3KTf32izQIMgwdHG1h2I3+4HwZ6oOo1hgmrFZsUdp3yqRB5heV5lkJd
	dsL/5QfXHQ5jWrjYz73zbZRITBGDpAIpL6gjz8RWWgx3nYeYM/B94lmBjZANNJpNh9T4W0F9zIt
	LX31AdfzqJUkoxwmovJCvLf17LN/u85HjxNwYtwk5+9JWVr3JFd6GJpjqZniQI2Mkxh89fkAt3x
	p0QO+vhSpTqpupO7nheMnnd8sPBIT97LWqBjD5YbiMbAB9m5xgt75mzGLjsn0ahqNrRcUf1+Av6
	qQeZJ6amG+R7e2cmJ48MCLgWUGmnF3L1YW8lR+3jZk9oUTZuIb8mmegOp7DwujUO396U5HnvZSv
	cEOlT6rBMGQysaT0vG/VW/m1UeSJcy6Px/qycee0QaujcvsMdGDPdcj+gBR10431OxLrjuflYR+
	M7hB9hH7oFY0kQ2spz3lo0=
X-Received: by 2002:a05:6102:604d:b0:632:eef7:4b7f with SMTP id ada2fe7eead31-63775d3d1b5mr4496453137.22.1778772749628;
        Thu, 14 May 2026 08:32:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e638sm275535485a.9.2026.05.14.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:32:29 -0700 (PDT)
Date: Thu, 14 May 2026 11:32:26 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: Re: [PATCH v7 02/31] mm: page_alloc: propagate PageReported flag
 across buddy splits
Message-ID: <agXrCinY2HmJmhT6@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <feab82b370b3e66b58b9cfbc1efaf26fe6061d2f.1778616612.git.mst@redhat.com>
 <agW3JyLAwVsCZ2qR@gourry-fedora-PF4VCD3F>
 <20260514104735-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514104735-mutt-send-email-mst@kernel.org>

On Thu, May 14, 2026 at 10:48:28AM -0400, Michael S. Tsirkin wrote:
> On Thu, May 14, 2026 at 07:51:03AM -0400, Gregory Price wrote:
> > On Tue, May 12, 2026 at 05:05:16PM -0400, Michael S. Tsirkin wrote:
> > > When a reported free page is split via expand() to satisfy a
> > > smaller allocation, the sub-pages placed back on the free lists
> > > lose the PageReported flag.  This means they will be unnecessarily
> > > re-reported to the hypervisor in the next reporting cycle, wasting
> > > work.
> > > 
> > > While I was unable to quantify the performance difference, it is
> > > an obvious waste, even if small.
> > > 
> > > Propagate the PageReported flag to sub-pages during expand(),
> > > both in page_del_and_expand() and try_to_claim_block(), so
> > > that they are recognized as already-reported.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Assisted-by: Claude:claude-opus-4-6
> > ... snip ...
> > > @@ -1731,9 +1740,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
> > >  						int high, int migratetype)
> > >  {
> > >  	int nr_pages = 1 << high;
> > > +	bool was_reported = page_reported(page);
> > >  
> > >  	__del_page_from_free_list(page, zone, high, migratetype);
> > > -	nr_pages -= expand(zone, page, low, high, migratetype);
> > > +	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
> > >  	account_freepages(zone, -nr_pages, migratetype);
> > >  }
> > >  
> > 
> > Maybe mildly out of scope but worth asking:  Are there other flags that
> > should be retained/propogated on a split?  If so, rather than pass
> > was_reported, should we just take a temporary copy of the page flags and
> > pass them all in?
> > 
> > ~Gregory
> 
> 
> Not that I can see, no.
> 

You do this exact thing again later :]

https://lore.kernel.org/linux-mm/9a22e0f9bbe1278913754db6df76e291a006181a.1778616612.git.mst@redhat.com/

~Gregory
