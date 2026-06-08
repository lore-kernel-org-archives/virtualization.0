Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9F37649A
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952172; cv=none; b=G4N4FIeKM1clFkQ+LjJvIVEaUFaZ/WCMnzirJ0xcoFg+D18gGFvnNV/gMgKySOHgfneEAICipqsT/Wq1ZJXacmnYnChi8SWUU4VxyCoYoSNok5y71kVBKmQZw9ZoTKw1Zu6Fv6TRWjwLeR6q66LFr/jDBz9sitMbOrsB931esRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952172; c=relaxed/simple;
	bh=4uPqreWhfD9TRFZ8S24VSlOkGn3Vz++056QSRM5GRyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0usSUvwiXYs+IUJOn9oPIClVKDX6uy42C+WqgQKcNB4exxiV7fXZ40K4q2f1y/3CZhQA9Sh2OppQfSMqYd0VVyGD+em50zFJvPQPfVsjCD689r+jKAfyEBrMlCUYG4K6+9BYIuW734ZB2MeBX9po0u2Fs+MnpnQJFtrmdwxBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RniNjbo6; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RniNjbo6"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177945a22eso32534001cf.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780952171; x=1781556971; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHaHyUtmd7xYX3FTc2W1dWbFRus+iCyGxuj8fCGhfn0=;
        b=RniNjbo6aC1KSYqx1YvHQ4IdzTGEdjOImecHEl4XzJM3OIZ+rewWqDRNgL3e/j49jB
         ko6OdAAZe1dw3mIdKAoBmIVd1IBmbnPOTaDS965SLIjubay1EUXtY+3vW+gb00Ou4YNh
         4tJLd1u6qYzoGwltLMfiBtmQ19I+IXR5bPVYgRzj+brX/E6l8/I4rsmkRxkp4DC0+o/a
         NKhxEPDKulmBV3Rv042piXc5h/PJqzJN47uMgbJzKSs8/K0twi8EIdKe+xjGfTx62c3O
         gZoOYhAwKarTanCdd/wLhuq70d+HzPR3AmqKCqLPhHLkjK0BWF6oZVvJIEAJvi6AE63d
         zVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952171; x=1781556971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHaHyUtmd7xYX3FTc2W1dWbFRus+iCyGxuj8fCGhfn0=;
        b=FiEC5uo9ZOCEAMGjeqooszQf+hieb4qfvZv0+mbvAfOP174JqYQzjNqXLUkMTfklxp
         Yg49ILrljv85vC8zIuRKV5oPZiQZJqLYOhRSeuzZp666BFEECYYE64JBtCWOtcqhxVLk
         GsLG9Zt1dlJ1QG1QX5MTO8zYwJcDAtpTOoaD69NIbAQ6FlyUILeay199U4bKiBYa16Bw
         k4XcqCPNqN//yeS/NPupfvi35/FCcD3a96xMTZHd6dPmSYyjr86klrQIlb7NmW0ScZeT
         vokXMO01piDnPVb5ktHV5wLTYibon83OGD+XvBJKmHUclhl9cvAnpXS1PNvkpf9hEsvX
         wGJw==
X-Forwarded-Encrypted: i=1; AFNElJ+Fapdrc3q/WZ6veSu0BdyRgh62GiZvwJV7QslDG3zNaFav+44WCgxS0eBHYCsKdR1ppCamWJeYEvPhrwBbCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8q7jFqwZdbXRWHBXvaWMK1h5V/umJCvTSLNEUNMx1uSHP8dPH
	rFuroyKjhsG2VtbkmI+BbsvETE+tjmnaCzX6GUXrWinVgeQpio9vVZ7aVP6TK0vbu9s=
X-Gm-Gg: Acq92OHbrIIdXwls7CA01rjprecfTqvjwISR3gJ3NzRyogotfLvKTo3LW8fmWM9hHJP
	+YXWhyGuLCDKHRxjZbYF5mr0UFJYjZ/wieklYWjjZh4JjCrszsd5ZtioSOIBdV34INIZ+prifI0
	gWhV1oolbzox1s1NBrTxNwkOq8rlkcCa5KHa/4M5SVZ3/kSbbgfIDXe4pkzeV/IytnvSixTtxfY
	cZwjw/3w/cQw6DP6ybz9nvt5XNbeG0iZi5iw63oi3mKerXkuN4JniFbndxykFnm/QPSXnpSY0ml
	K/vZb7LAXl4xpb7GQSX6oI5oEKpwCxZfrcYvO7gaPCzgqhlOyWdLEut1n8WtV0nWyHKFk9Ml1dV
	S1oJUj5RgZe9xGcpBYjX+pLPPArvd7zxXIv+MQ76q/BHKNHqk1yAD9RpN0Q8rojnHvgDQ2zbmA4
	P/87RpvqNzuR2EhbLEL10fAyB3ONLGzOw6kNdqycON++QS5vsnpylkNmQ48N34lzd7KjZB7uxxR
	RRnlTel2kssqh2U1g==
X-Received: by 2002:a05:622a:2597:b0:516:cfb9:2856 with SMTP id d75a77b69052e-51795be2429mr255289181cf.31.1780952170668;
        Mon, 08 Jun 2026 13:56:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fda2sm180883106d6.2.2026.06.08.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:56:10 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:56:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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
	Johannes Weiner <hannes@cmpxchg.org>,
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
Message-ID: <aicsaMeDd2C08_xf@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <64f2e580-aa82-4849-9236-b8ec4208ca24@kernel.org>
 <AEB19464-20A9-4C5B-97B8-681CCDD81031@nvidia.com>
 <2475e4c4-9ba3-4091-9bfd-1c1c15163da7@kernel.org>
 <aicbZ9lewv1wJqqS@gourry-fedora-PF4VCD3F>
 <8BB8D6E5-8644-4CBC-BAF1-0AA19702E042@nvidia.com>
 <aiclJGgB07L3rV-P@gourry-fedora-PF4VCD3F>
 <D754DEDB-3A3A-4F6E-BF64-79086F0A6467@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D754DEDB-3A3A-4F6E-BF64-79086F0A6467@nvidia.com>

On Mon, Jun 08, 2026 at 04:37:59PM -0400, Zi Yan wrote:
> On 8 Jun 2026, at 16:25, Gregory Price wrote:
> >
> > essentially we end up with something like
> >
> > alloc_frozen_...(..., gfp)
> > {
> >   folio = whatever(..., gfp);
> >   if (gfp & __GFP_ZERO)
> >     folio_zero(folio, -1); /* don't do cache flush part */
> > }
> >
> > alloc_frozen_user_...(..., gfp, user_addr)
> > {
> >   folio = whatever(..., gfp);
> >   if (gfp & __GFP_ZERO)
> >     folio_zero(folio, user_addr); /* do cache flush part */
> > }
> >
> > The downside of this is obvious: it's easy for developers to get this
> > wrong and call the non-user interface for user-bound allocations and
> > miss the cache flush (that is only needed on some archs).
> >
> > Not saying that's a deal breaker, but it's something to chew on.
> 
> I agree that misuse can cause trouble. But if we do the churn approach,
> what prevents developer from doing alloc_frozen(..., user_addr = -1)
> and using the returned page for userspace? It is possible the allocated
> page can be exported to userspace later.
> 
> BTW, that cache flush thing is fragile even today, you probably can
> do alloc_page() + vm_insert() to get a page without doing proper flush
> and export it to userspace. There seems to be no mechanism to
> prevent that.
>

Oh of course, I said that elsewhere.  It leaves us in a spot where we're
not technically worse than we were yesterday - except that the surface
of the buddy has increased (developers need to know about 2 APIs instead
of 1).  That carries maintenance burden (if something in alloc_frozen()
changes, something in alloc_frozen_user() may need to change).

There's a careful dance here.

~Gregory
