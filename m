Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA0D130ADA
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434549; cv=none; b=ggzWc+RP/rd660nN5Rd3nm0cm4m65Q+xmrxj/PSADxCuc6rGb10Tst5IrnC3csaX2PycLBxLcypps9OLyrQlJVEmD0uJlzOcypc6trbAftWjhj0SB6mNTwPbH5/Y89QsyVKfyuU89ZOBuLlpOOLfIQrkBmCiLIbgxmGXmdT0lHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434549; c=relaxed/simple;
	bh=bbOsculdpTItYrfgREp6F0Q6OrQeZ+N8WXdyQ9WaxZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZqhDwV/BWrY6P94n+x6W3tGId1pPqEy/yAEujk6K8nLX6TKqaUfVisZ4KHi7PMT2Ju+bHbDn48qu6y4v8tPy8rtGThh+IAf9pbTmZujGuU3O8LtMi+JN1PX9bjo9+UbiUWl7F2wNEtg/ojA7x70ztWeBHPi97GzVgplsE4PLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YZ2v9DyY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YZ2v9DyY"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334c4d6829so7833712e87.2
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 00:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725434545; x=1726039345; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wh+WjO/eVoggYon1VI8AmiDiYT97jA+3Yp6qqo8Bz0o=;
        b=YZ2v9DyY5lkYM63My1ThLj2dO1zzd2+Kn7zTNt7kxn1JcPvcC9LfWHxlnVQ9papOXh
         vjPSLE/pz992IDwRy1sBVF90/KqfxolyT+tE8mmbjLWWy6ujTJP5gRQHfv1eQXSEDGaa
         xDDkXz3BtIBpPIh6SoCWeGNknGjMKOr+8ARyyDdYP3kNVuEi91D16xU2kPHUwoInSJBn
         cSb2ems37/zC4E4sZlQbVdGJANRa/6tI4ilqAfO9mIWZjxQNLLnG4WINxTzBxZe3wDV7
         lo6sqt1hvogEYGnsZBVabxFqQMh8IsSVEbKZBqx95S5TShM0GwSxfv8WrLfePt5QOyJs
         JyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434545; x=1726039345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh+WjO/eVoggYon1VI8AmiDiYT97jA+3Yp6qqo8Bz0o=;
        b=vltnm26xbNhmrJlN/r6QAuxR7gYZRJle8eP9cb4qOiHe8eFXgjU91olEiLJlIw8SY/
         kln0HddDpHj7DMasG3d4+9fi3536ij49TJ1tkXpNIaAdl0qjqFCPlhaOYsLEOkFBT2m8
         ikAxZmkiD3S9RoYejLl2yJ1q9xxeve7jAjUYFz1STNr0smIs28D5QDfCLa832MR4tUHM
         2T87lUjpBDih33YHwSO+0jBur/Ero0BnDgJBI8xIrM4ZQ2yqbjG/DQZUTHjnO7OUPx/d
         TYma4cKgSa386p7r9YvPTRez29JC0FyqF36hIQoQK7SgQ4Nz/gKi2Av9lAYX2XsIX90D
         Bx0A==
X-Forwarded-Encrypted: i=1; AJvYcCXsHz70F72CkTse5xmyOmbS5Q7cZe4vP3m5wa0XbiM8YWoBgyh5tnrcJY3pe0IdDSklj08doYjIOE6dKLIbnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw6MnDkVxsNpcgrMTQvx3zM1NcZSr8O6d8LiVSxaUxtGBklojw
	bLB6WHpsNfZcDUBL5kNa4O+avLGhsA07JV7bsp9W5XhRWe52g2dk/vrInovvQcA=
X-Google-Smtp-Source: AGHT+IG8z0kaSoq4W+20UCPAYQ/4EbWJkmc6rjz/n9sR4m5vvJuQveaRcmhYFgcpH0WFXJDIfkD49A==
X-Received: by 2002:a05:6512:3350:b0:534:543e:1895 with SMTP id 2adb3069b0e04-53546bab3damr7960271e87.39.1725434544882;
        Wed, 04 Sep 2024 00:22:24 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898919686bsm764838666b.134.2024.09.04.00.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 00:22:24 -0700 (PDT)
Date: Wed, 4 Sep 2024 09:22:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com,
	david@redhat.com, hailong.liu@oppo.com, hch@infradead.org,
	iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, linux-mm@kvack.org,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 3/3] mm: warn about illegal __GFP_NOFAIL usage in a
 more appropriate location and manner
Message-ID: <ZtgKr5aFjMXNNIjX@tiehlicka>
References: <ZtVwQL52EmIIyDsK@tiehlicka>
 <20240903223935.1697-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903223935.1697-1-21cnbao@gmail.com>

On Wed 04-09-24 10:39:35, Barry Song wrote:
> On Mon, Sep 2, 2024 at 7:58 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Sat 31-08-24 08:28:23, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > Three points for this change:
> > >
> > > 1. We should consolidate all warnings in one place. Currently, the
> > >    order > 1 warning is in the hotpath, while others are in less
> > >    likely scenarios. Moving all warnings to the slowpath will reduce
> > >    the overhead for order > 1 and increase the visibility of other
> > >    warnings.
> > >
> > > 2. We currently have two warnings for order: one for order > 1 in
> > >    the hotpath and another for order > costly_order in the laziest
> > >    path. I suggest standardizing on order > 1 since it’s been in
> > >    use for a long time.
> > >
> > > 3. We don't need to check for __GFP_NOWARN in this case. __GFP_NOWARN
> > >    is meant to suppress allocation failure reports, but here we're
> > >    dealing with bug detection, not allocation failures. So replace
> > >    WARN_ON_ONCE_GFP by WARN_ON_ONCE.
> > >
> > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > Updating the doc about order > 1 sounds like it would still fall into
> > the scope of this patch. I don not think we absolutely have to document
> > each unsupported gfp flags combination for GFP_NOFAIL but the order is a
> > good addition with a note that kvmalloc should be used instead in such a
> > case.
> 
> Hi Andrew,
> If there are no objections from Michal and David, could you please
> squash the following:
> 
> >From fc7a2a49e8d0811d706d13d2080393274f316806 Mon Sep 17 00:00:00 2001
> From: Barry Song <v-songbaohua@oppo.com>
> Date: Wed, 4 Sep 2024 10:26:19 +1200
> Subject: [PATCH] mm: also update the doc for __GFP_NOFAIL with order > 1
> 
> Obviously we only support order <= 1 __GFP_NOFAIL allocation and if
> someone wants larger memory, they should consider using kvmalloc()
> instead.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

LGTM. Thanks!

> ---
>  include/linux/gfp_types.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 4a1fa7706b0c..65db9349f905 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -253,7 +253,8 @@ enum {
>   * used only when there is no reasonable failure policy) but it is
>   * definitely preferable to use the flag rather than opencode endless
>   * loop around allocator.
> - * Using this flag for costly allocations is _highly_ discouraged.
> + * Allocating pages from the buddy with __GFP_NOFAIL and order > 1 is
> + * not supported. Please consider using kvmalloc() instead.
>   */
>  #define __GFP_IO	((__force gfp_t)___GFP_IO)
>  #define __GFP_FS	((__force gfp_t)___GFP_FS)
> -- 
> 2.34.1
> 
> 
> >
> > > ---
> > >  mm/page_alloc.c | 50 ++++++++++++++++++++++++-------------------------
> > >  1 file changed, 25 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index c81ee5662cc7..e790b4227322 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
> > >  {
> > >       struct page *page;
> > > 
> > > -     /*
> > > -      * We most definitely don't want callers attempting to
> > > -      * allocate greater than order-1 page units with __GFP_NOFAIL.
> > > -      */
> > > -     WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > > -
> > >       if (likely(pcp_allowed_order(order))) {
> > >               page = rmqueue_pcplist(preferred_zone, zone, order,
> > >                                      migratetype, alloc_flags);
> > > @@ -4175,6 +4169,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > >  {
> > >       bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
> > >       bool can_compact = gfp_compaction_allowed(gfp_mask);
> > > +     bool nofail = gfp_mask & __GFP_NOFAIL;
> > >       const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
> > >       struct page *page = NULL;
> > >       unsigned int alloc_flags;
> > > @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > >       unsigned int zonelist_iter_cookie;
> > >       int reserve_flags;
> > > 
> > > +     if (unlikely(nofail)) {
> > > +             /*
> > > +              * We most definitely don't want callers attempting to
> > > +              * allocate greater than order-1 page units with __GFP_NOFAIL.
> > > +              */
> > > +             WARN_ON_ONCE(order > 1);
> > > +             /*
> > > +              * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
> > > +              * otherwise, we may result in lockup.
> > > +              */
> > > +             WARN_ON_ONCE(!can_direct_reclaim);
> > > +             /*
> > > +              * PF_MEMALLOC request from this context is rather bizarre
> > > +              * because we cannot reclaim anything and only can loop waiting
> > > +              * for somebody to do a work for us.
> > > +              */
> > > +             WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> > > +     }
> > > +
> > >  restart:
> > >       compaction_retries = 0;
> > >       no_progress_loops = 0;
> > > @@ -4404,29 +4418,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> > >        * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
> > >        * we always retry
> > >        */
> > > -     if (gfp_mask & __GFP_NOFAIL) {
> > > +     if (unlikely(nofail)) {
> > >               /*
> > > -              * All existing users of the __GFP_NOFAIL are blockable, so warn
> > > -              * of any new users that actually require GFP_NOWAIT
> > > +              * Lacking direct_reclaim we can't do anything to reclaim memory,
> > > +              * we disregard these unreasonable nofail requests and still
> > > +              * return NULL
> > >                */
> > > -             if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > > +             if (!can_direct_reclaim)
> > >                       goto fail;
> > > 
> > > -             /*
> > > -              * PF_MEMALLOC request from this context is rather bizarre
> > > -              * because we cannot reclaim anything and only can loop waiting
> > > -              * for somebody to do a work for us
> > > -              */
> > > -             WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
> > > -
> > > -             /*
> > > -              * non failing costly orders are a hard requirement which we
> > > -              * are not prepared for much so let's warn about these users
> > > -              * so that we can identify them and convert them to something
> > > -              * else.
> > > -              */
> > > -             WARN_ON_ONCE_GFP(costly_order, gfp_mask);
> > > -
> > >               /*
> > >                * Help non-failing allocations by giving some access to memory
> > >                * reserves normally used for high priority non-blocking
> > > --
> > > 2.34.1
> >
> > --
> > Michal Hocko
> > SUSE Labs
> 
> Thanks
> Barry

-- 
Michal Hocko
SUSE Labs
