Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2D168D0
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403189; cv=none; b=lcE/AJXtoXhJODBjjRnZ0NEP3Tf3vhEC6CRzqjBSxKZVamPpvTXGOq2tEjDzktKYMNdU78TnaSgukuZAJL/ilhHOkSlaPcDSESZjvrTJer+fTC1zYiPkOk/FF3qcYQmPNskiIt4D471AW7Ey+Bqn1ihEpFIrAI8gAd/HP3x/QRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403189; c=relaxed/simple;
	bh=KeS+/H/ggeQdORa2PHv0xcObmCvkTFDDKzaYSlN5KcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGmMFDepl7qCKmv7ItC69wLH7Vjn5mJM75WnxzuuujS23wY6nS5aytktmjqltdgQFN9Ots0aKTLbBAwA0XnSdMNpcn356SY9uce91AoN9/jkPnwEAF0tZGj9S2Vc93iL0R2FnNmvPgPPduqQV1aT4SR3Pwa6/6cT9SF3BJN4ixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyYlSsdf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyYlSsdf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2055f630934so21202015ad.1
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 15:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725403187; x=1726007987; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJzEDZ6Y41Cwm+nItw4ApEDZvLrm6Zf0G+Ovt54oSKM=;
        b=hyYlSsdfMf8+AM01WJ0rI4N3dKPO40CBkznMu0whmneTP6HQyUygD2UBG/rKG1ASbF
         kcs2NqOOVRc/tnE8auXpkQLdmhzpKs+zVDlb//HW1iULEm5o3LI0MPYWjsTs8Gbx5Ige
         s0+kECtcoNQlNJ7/ZSpHVEU9zSo8jiupXm/XBz39P2PpBvOCgFsYaaRoDGXLZJKzWFH0
         9AqxQJOC7YQxUMUPc53i0wzRCTle4tyo8uGOtV6RgHoOEhHcM+SPII2Ggu98vwiWyZyo
         4CZ7vGBb1MIAENjXyOmK8VQlfAPsdlLcdDthkoA4ikgCO9GzwhOApZgmOrb9LLdzh8ow
         GmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403187; x=1726007987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJzEDZ6Y41Cwm+nItw4ApEDZvLrm6Zf0G+Ovt54oSKM=;
        b=mj2KA7NZQZ8JyU1D3F/Q7cIdgm9YLiphypM7DfRL69COEX81FwaO2lSEjqIQJj1RDV
         4aaqZqJ2JyDbzYeIxstiBeXD3Mo3dmz0wYkkTortkWZTxHrpxMTHT2x3pOvkA+S6e40M
         lj1n4/bajg1VylqowTxiQ4UdJwGJ/9LbaR46D5AAh6Y1ICEaoHCrFe/XIwV6iQ+7RLHU
         WFEZFOZd+QKBEylgv4oDFOkZ17EATFg8E/uRr4J27YYtLX7Bp0CVXjYlPYPGqxmyNHR5
         AQzPb13Cfi4Q0/e7ldYxMzT6Whd+rtLKdVYsJOH5M8WHd9gc7PAMmzh0F/FwUkZqfXpE
         e4Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUg+edgKgPQDDAJoAPW33eKz8p2bZ9cXGeK0c6RW3CHDMHmIqjAk/qjqy8GDutouEgMigr/UdahjXqxUZxf8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxa2feF8o4PYSgncu9HKivUL17c9dIK+RNG1SVykhE1N8aXldz6
	rdfcR8hMK35rtUdYFCxhSiIQ2A8hbrkPSk+5D4VqUK3tx+EDo0+v
X-Google-Smtp-Source: AGHT+IF4JZ9uttpCEjhGk+KRVirtmc6UBRZKXBbOBrpMJWbwoF0ZbezJXFzPRsbM0ocaAmPCoeH3ig==
X-Received: by 2002:a17:903:2b04:b0:205:51ee:b81e with SMTP id d9443c01a7336-20551eebb28mr131826195ad.15.1725403187460;
        Tue, 03 Sep 2024 15:39:47 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:3dfb:fdbe:2749:2520])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea55789sm3007825ad.217.2024.09.03.15.39.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Sep 2024 15:39:47 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: mhocko@suse.com
Cc: 21cnbao@gmail.com,
	42.hyeyoo@gmail.com,
	akpm@linux-foundation.org,
	cl@linux.com,
	david@redhat.com,
	hailong.liu@oppo.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	laoar.shao@gmail.com,
	linux-mm@kvack.org,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	torvalds@linux-foundation.org,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4 3/3] mm: warn about illegal __GFP_NOFAIL usage in a more appropriate location and manner
Date: Wed,  4 Sep 2024 10:39:35 +1200
Message-Id: <20240903223935.1697-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <ZtVwQL52EmIIyDsK@tiehlicka>
References: <ZtVwQL52EmIIyDsK@tiehlicka>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Sep 2, 2024 at 7:58 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Sat 31-08-24 08:28:23, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Three points for this change:
> >
> > 1. We should consolidate all warnings in one place. Currently, the
> >    order > 1 warning is in the hotpath, while others are in less
> >    likely scenarios. Moving all warnings to the slowpath will reduce
> >    the overhead for order > 1 and increase the visibility of other
> >    warnings.
> >
> > 2. We currently have two warnings for order: one for order > 1 in
> >    the hotpath and another for order > costly_order in the laziest
> >    path. I suggest standardizing on order > 1 since it’s been in
> >    use for a long time.
> >
> > 3. We don't need to check for __GFP_NOWARN in this case. __GFP_NOWARN
> >    is meant to suppress allocation failure reports, but here we're
> >    dealing with bug detection, not allocation failures. So replace
> >    WARN_ON_ONCE_GFP by WARN_ON_ONCE.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Updating the doc about order > 1 sounds like it would still fall into
> the scope of this patch. I don not think we absolutely have to document
> each unsupported gfp flags combination for GFP_NOFAIL but the order is a
> good addition with a note that kvmalloc should be used instead in such a
> case.

Hi Andrew,
If there are no objections from Michal and David, could you please
squash the following:

From fc7a2a49e8d0811d706d13d2080393274f316806 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Wed, 4 Sep 2024 10:26:19 +1200
Subject: [PATCH] mm: also update the doc for __GFP_NOFAIL with order > 1

Obviously we only support order <= 1 __GFP_NOFAIL allocation and if
someone wants larger memory, they should consider using kvmalloc()
instead.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/gfp_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 4a1fa7706b0c..65db9349f905 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -253,7 +253,8 @@ enum {
  * used only when there is no reasonable failure policy) but it is
  * definitely preferable to use the flag rather than opencode endless
  * loop around allocator.
- * Using this flag for costly allocations is _highly_ discouraged.
+ * Allocating pages from the buddy with __GFP_NOFAIL and order > 1 is
+ * not supported. Please consider using kvmalloc() instead.
  */
 #define __GFP_IO	((__force gfp_t)___GFP_IO)
 #define __GFP_FS	((__force gfp_t)___GFP_FS)
-- 
2.34.1


>
> > ---
> >  mm/page_alloc.c | 50 ++++++++++++++++++++++++-------------------------
> >  1 file changed, 25 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index c81ee5662cc7..e790b4227322 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3033,12 +3033,6 @@ struct page *rmqueue(struct zone *preferred_zone,
> >  {
> >       struct page *page;
> > 
> > -     /*
> > -      * We most definitely don't want callers attempting to
> > -      * allocate greater than order-1 page units with __GFP_NOFAIL.
> > -      */
> > -     WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
> > -
> >       if (likely(pcp_allowed_order(order))) {
> >               page = rmqueue_pcplist(preferred_zone, zone, order,
> >                                      migratetype, alloc_flags);
> > @@ -4175,6 +4169,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >  {
> >       bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
> >       bool can_compact = gfp_compaction_allowed(gfp_mask);
> > +     bool nofail = gfp_mask & __GFP_NOFAIL;
> >       const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
> >       struct page *page = NULL;
> >       unsigned int alloc_flags;
> > @@ -4187,6 +4182,25 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >       unsigned int zonelist_iter_cookie;
> >       int reserve_flags;
> > 
> > +     if (unlikely(nofail)) {
> > +             /*
> > +              * We most definitely don't want callers attempting to
> > +              * allocate greater than order-1 page units with __GFP_NOFAIL.
> > +              */
> > +             WARN_ON_ONCE(order > 1);
> > +             /*
> > +              * Also we don't support __GFP_NOFAIL without __GFP_DIRECT_RECLAIM,
> > +              * otherwise, we may result in lockup.
> > +              */
> > +             WARN_ON_ONCE(!can_direct_reclaim);
> > +             /*
> > +              * PF_MEMALLOC request from this context is rather bizarre
> > +              * because we cannot reclaim anything and only can loop waiting
> > +              * for somebody to do a work for us.
> > +              */
> > +             WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> > +     }
> > +
> >  restart:
> >       compaction_retries = 0;
> >       no_progress_loops = 0;
> > @@ -4404,29 +4418,15 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >        * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
> >        * we always retry
> >        */
> > -     if (gfp_mask & __GFP_NOFAIL) {
> > +     if (unlikely(nofail)) {
> >               /*
> > -              * All existing users of the __GFP_NOFAIL are blockable, so warn
> > -              * of any new users that actually require GFP_NOWAIT
> > +              * Lacking direct_reclaim we can't do anything to reclaim memory,
> > +              * we disregard these unreasonable nofail requests and still
> > +              * return NULL
> >                */
> > -             if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> > +             if (!can_direct_reclaim)
> >                       goto fail;
> > 
> > -             /*
> > -              * PF_MEMALLOC request from this context is rather bizarre
> > -              * because we cannot reclaim anything and only can loop waiting
> > -              * for somebody to do a work for us
> > -              */
> > -             WARN_ON_ONCE_GFP(current->flags & PF_MEMALLOC, gfp_mask);
> > -
> > -             /*
> > -              * non failing costly orders are a hard requirement which we
> > -              * are not prepared for much so let's warn about these users
> > -              * so that we can identify them and convert them to something
> > -              * else.
> > -              */
> > -             WARN_ON_ONCE_GFP(costly_order, gfp_mask);
> > -
> >               /*
> >                * Help non-failing allocations by giving some access to memory
> >                * reserves normally used for high priority non-blocking
> > --
> > 2.34.1
>
> --
> Michal Hocko
> SUSE Labs

Thanks
Barry

