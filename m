Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE931CAA6C
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777600; cv=none; b=RHU/9NzvOUHTRKCt0ccli4P40YXIGHCODZwnXX7+uD42BpWPl7wSiuFuMFjMCzRlQKYyPxPvyHWhkvTD1G07jOKk1adcrxASXxXXcUZ8sX991/K65lZrs231inhcHi+C1ZbHtX8yhM6absmoriXs5jvb3x3p5prooqkwJc4LquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777600; c=relaxed/simple;
	bh=l5nh2tX+tG4PyQxEGrsy245Ln5RZlFhnAyXMUDP8PX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HHRr7B4Z5hBQRTloMShSQb4WunseTN8vsgZs7Su3y51VEYyIhfPYlYhSsYVOAl5ijMhRR4hmwcF7u9Si7J3i/jGwNugeP9ZqVupSntjXdM4NhqyUEMVuvQcE1ME67VKImeYgoOGLSypyj5I1WtO4mCcLNroLNRLaay4Ma4lQRZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8UgxQ72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8UgxQ72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776777598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xexzte0yTqtWkjudFGvCNSwnTYifigEpG3qwMv3/9fw=;
	b=i8UgxQ72fa+nIiggRyMF3RKAikNtQ9GC2WyMUhzIIkQBqZNcTEolPDZ7xO3ryYj9m42yvI
	FrIOj50XPdnf6sXcvd7JNiYDYXoLRUtMYeaZbHDGeUERmsa6ZWVzmyinB3Z3O8euC6ISUC
	XfeQEmIT9ImbFnQq/IQYA2qdP2km+mA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-7EUvDMRYO5WDRD0a2p0ceA-1; Tue, 21 Apr 2026 09:19:56 -0400
X-MC-Unique: 7EUvDMRYO5WDRD0a2p0ceA-1
X-Mimecast-MFC-AGG-ID: 7EUvDMRYO5WDRD0a2p0ceA_1776777595
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-66e6f1b315dso3635834a12.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776777595; x=1777382395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xexzte0yTqtWkjudFGvCNSwnTYifigEpG3qwMv3/9fw=;
        b=dLJlVJD+vdEwg3S2cIXMRQIRXwAAs8CbRsPOk2dSyg5TEMQkYyZ7nilBJOrcBKekdD
         kd+WZWiC4xB6sO5rVKyKUMJG0p1NP3ixQpsgApOsHQUz0ZYj4OhYMf8MpWTpO3DZteh5
         zP3SzRZwhU1MVHsJfDVZ8cP7rsRy055JwGpeRuJwn7bdneN/wWy7UbuFtA7oC5tmOQVp
         8jE1pt3E34nMnSBsbSA4rlpAd2mMMSDGzXCOnbh/ksS69voQzkqDhbZ2+A9La8jliDR2
         YKXRz+SynTyBajHHdkVlmcsp8HEon30TDv4zoXwu5jd1iVRBYTBLmM0RlUby0SOEBToj
         FoRA==
X-Forwarded-Encrypted: i=1; AFNElJ+oNVALK+/63srgnMSkRZCf7BidWxSiValdcUvSVbnI+BXOgyfa7iSFyH5AHb5p8QyEIEtma01gqA7g/cpPqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfO4VKrCIhXNxSHnXLDeyhKZwd7CxK1JhIKHjWtZhNPP1UFdIO
	ctbHVeD81jGLsKkZA6CybDyHYFeGqg3838McFpk8/+RjHC1cplRF2q+CGR7/FxDTyYzMQwkn0a6
	i85fqG0OUL0jannNVDmRacLQ/LQoRPo77haM+OujG1eJO6228np/B59MVV3lsNHNjjXrh
X-Gm-Gg: AeBDieud5r553TRoIlGUwBwlbWqxVII9M1Tlz/f9qg/D7q8eDnGbp8MRm3CAofy8kN6
	CYBvQMzdfIBWAoL25myoJn+MEk+gl6mrmM5IrITOQsEHyNUv1rfAph2gbbUvZxk2HmIc07gBdKq
	zMbADAWL9euFCDWF8vk9OvOwbcI7HJO48/z8JqXsiwrC4+ZqlPmKPAkl1wZuj81YHqkd4iYjV54
	1CQZQFGZYO6qnaXO5JlAgG56IXh7EA0q9g9e7aJ4YqBtoqHsO/9qE37YL56POYb69NajZNTCGYm
	nOa9pF7768+FsqpXaD9WcD0a7kJbd1pvsRiYfWi3A/IEZfg+VFOY+kl0+pRi6GBNCy7d8xgVEUk
	+F33YJdcOrIzP9HrDKCnxcT0rKvLk6XCHTZKdTrGk76BUahr5VWOClw==
X-Received: by 2002:a05:6402:2b9b:b0:670:8b30:a8a7 with SMTP id 4fb4d7f45d1cf-672bfc12ae6mr8152673a12.0.1776777594773;
        Tue, 21 Apr 2026 06:19:54 -0700 (PDT)
X-Received: by 2002:a05:6402:2b9b:b0:670:8b30:a8a7 with SMTP id 4fb4d7f45d1cf-672bfc12ae6mr8152659a12.0.1776777594246;
        Tue, 21 Apr 2026 06:19:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm2080687a12.30.2026.04.21.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:19:53 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:19:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH RFC v2 11/18] mm: skip zeroing in
 vma_alloc_zeroed_movable_folio for pre-zeroed pages
Message-ID: <20260421091759-mutt-send-email-mst@kernel.org>
References: <cover.1776689093.git.mst@redhat.com>
 <39c3c8e647fc4c8e3dcb5c9d12f2e29b5404e8f2.1776689093.git.mst@redhat.com>
 <b7fc296b-06bc-4d52-b607-2da94c123fa4@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b7fc296b-06bc-4d52-b607-2da94c123fa4@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fem095gNEh6379N8ywJ2k7l1IJcdcK3XPVXF4x-nEfo_1776777595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2026 at 12:58:11PM +0200, David Hildenbrand (Arm) wrote:
> On 4/20/26 14:50, Michael S. Tsirkin wrote:
> > Use vma_alloc_folio_hints() and check PGHINT_ZEROED to skip
> > clear_user_highpage() when the page is already zeroed.
> > 
> > On x86, vma_alloc_zeroed_movable_folio is overridden by a macro
> > that uses __GFP_ZERO directly, so this change has no effect there.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > Assisted-by: cursor-agent:GPT-5.4-xhigh
> > ---
> >  include/linux/highmem.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > index af03db851a1d..8bb67772c1cb 100644
> > --- a/include/linux/highmem.h
> > +++ b/include/linux/highmem.h
> > @@ -321,9 +321,11 @@ struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
> >  				   unsigned long vaddr)
> >  {
> >  	struct folio *folio;
> > +	pghint_t hints;
> >  
> > -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
> > -	if (folio && user_alloc_needs_zeroing())
> > +	folio = vma_alloc_folio_hints(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr,
> > +				      &hints);
> > +	if (folio && user_alloc_needs_zeroing() && !(hints & PGHINT_ZEROED))
> >  		clear_user_highpage(&folio->page, vaddr);
> >  
> >  	return folio;
> 
> 
> For others reading along, the variant on your other branch:
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index af03db851a1d9..ffa683f64f1d1 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -320,13 +320,8 @@ static inline
>  struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>  				   unsigned long vaddr)
>  {
> -	struct folio *folio;
> -
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
> -	if (folio && user_alloc_needs_zeroing())
> -		clear_user_highpage(&folio->page, vaddr);
> -
> -	return folio;
> +	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
> +			      0, vma, vaddr);
>  }
>  #endif
> 
> Looks like an extremely clean interface.

OK, sure. I will post that one as v3. Let me just add a changelog in the
cover letter, and see what to do about balloon.


> -- 
> Cheers,
> 
> David

