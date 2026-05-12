Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081783C988D
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619977; cv=none; b=kR5XKdVqwW6LDT471R05OMv0IYcVMw1hlDQdrKs7/As2JvQv3NtTPa0nJa3GEoj1N8G9Q4FMX7NlW5FJMJORpGAhF4VOVpj2lFnuhWeCYsupTgCUdnmRss/95MR0gQyb/Obe2olCDZdU8skoU7C+e3TN3926QDSU7aqzRCWl0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619977; c=relaxed/simple;
	bh=3McArHIdLgBghzfnrm+TQwXFwqILlkjaIIZYFynnsK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hUYl2z+Hbjd9OcyacKGFlgRnP9fkyHaBeTMlzYUszhcdzN4eXcz6HBEXmEFmklMo5Nk+x/bH1sGqjGHLC2S7hvW6GwjFczgS9YPher0YBdxJI1TAZ+/uYiRR61lmB4JG3klwt0tIHNRr2YZApskDMwqkLnRS+Xy8C1R3RvG+hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1GrqGpW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1GrqGpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tom/uL+543XR2YP2OF3z1y+v/10GzcsXvkyBJuLR6so=;
	b=C1GrqGpWxYjqvtJYkJKsGuWEquFtYhE81jIz4htu7IIVkJGL1YsJILl04wQhmaFQcLZKuc
	EETcDOQsWWfhruPJ2Oe13qe1zBrAVekM+i3v4SVRH1nVDJ/fODzorj3psV/9KBePGHc+BW
	U3EzgeCWjlO5sWyyl2S9N/nIEuWE9PA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-j-O_NbunN8m9exd2JYBKKw-1; Tue, 12 May 2026 17:06:13 -0400
X-MC-Unique: j-O_NbunN8m9exd2JYBKKw-1
X-Mimecast-MFC-AGG-ID: j-O_NbunN8m9exd2JYBKKw_1778619973
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c0120047so34769035e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619972; x=1779224772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tom/uL+543XR2YP2OF3z1y+v/10GzcsXvkyBJuLR6so=;
        b=D46hYXxOH1dshq3kq5887LkXy7MrqTIpm4PJ2B7OdX3ED0fUaaSVwwQGnlfRTlSaas
         c5foFXu+TyA742U0GlV0RqpVeZC4aa0xdt8LK7vHaKtw4cKCyTzAG8Lcn0rtsLtEEhN9
         ZVY1Pz+JquqmLyO+T+NpLs+UYlcSfnqOzZGcxGi9kxnBoJdt0Ezi32NEHa3zxaKOOt9d
         oZ+lRNba/UK5nJYC245m77GFEGVG9wLds3OO3ZurbYXzKbBFluP3ttnQykIvaweQFOij
         zPhrlXpieyM00WD27pOk0fs+lN+7CAQuOVbE4MUSO1rJ4H89+87uE2ZMpKfMohO+wzcC
         LuqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cf6No2kcFB5o/sFbjJpyHYoWGmLT1IWYJtYJrbL21f2uUPxpDrm44jK6vgEd/HMfuLYQ/7GBzoEgF+s2YQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySbEEuT/NiimbDkg4p+ZYOqYZAtAIdN0Psd5Yg9J8qdOY9aqui
	HcbPSr+oF3D1aQgo/qo4GSLcmpk56YCKMMSMognQZ7U0xAy2pOnbNpxMJkruJqCNEjt+fW3PcoB
	h+m208ROrPn3tG3ZuNnnuqqp7c9zugl/elQqmch6rMJ/8UsCrKZenbThhWdyDeqMYRCZ0
X-Gm-Gg: Acq92OEsBIWy1tQ4cLSAmnMjExThp1t3HpqbRbLLjtAhhiTBmVRCO5njDF8/b+Daqwp
	KXlJXOmJ424e9+rZntxM9tVMJKC4URjnjV2IO3y4roFmOnbhYGycHC2TGjGlcbYoPIBfenjTHxH
	epaJvY+eNrUCRQjOHT94E3ffcKjKrpUEnQCyJeAi7ckNkovMe6YnQOOeJnoqfJv2M9qRPdl27aB
	YIx4udeLyyj7i2pjvPOhcgeKnqJ4MUYHnSe5JsCBy8TwC9QsV+eUu/LoueIM0QNVUzErN1CUDy9
	uVpkOG15hHQgqRSroTBRu9mwhSBaygjNWua7RK+6RuBKu6itkmHpKbJa5Pb6JdKoS0G7FCBuprc
	lzaIjY0ZJAh+BTEaoy7iIbtGiDb2hLHMh2ow1w0HQ
X-Received: by 2002:a05:600c:3507:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48fc9a4a5e9mr5880565e9.28.1778619972423;
        Tue, 12 May 2026 14:06:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3507:b0:489:149a:f9e6 with SMTP id 5b1f17b1804b1-48fc9a4a5e9mr5879965e9.28.1778619971777;
        Tue, 12 May 2026 14:06:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454913049ecsm34251392f8f.19.2026.05.12.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:11 -0700 (PDT)
Date: Tue, 12 May 2026 17:06:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: Re: [PATCH resend v6 20/30] mm: page_alloc: clear PG_zeroed on buddy
 merge if not both zero
Message-ID: <20260512170525-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <a09c1848702368c3545b980c17101b5185ab774d.1778489843.git.mst@redhat.com>
 <agNNkvRK128bYhrf@gourry-fedora-PF4VCD3F>
 <20260512115805-mutt-send-email-mst@kernel.org>
 <agNWFPBTBszcq5GP@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agNWFPBTBszcq5GP@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -dceuGQweXqxOVwbtLwP0DQuN9XCjtknbaXI7JN4-UI_1778619973
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 12:32:20PM -0400, Gregory Price wrote:
> On Tue, May 12, 2026 at 11:58:27AM -0400, Michael S. Tsirkin wrote:
> > On Tue, May 12, 2026 at 11:56:02AM -0400, Gregory Price wrote:
> > > On Mon, May 11, 2026 at 05:03:35AM -0400, Michael S. Tsirkin wrote:
> > > > When two buddy pages merge in __free_one_page(), preserve
> > > > PG_zeroed on the merged page only if both buddies have the
> > > > flag set.  Otherwise clear it.
> > > > 
> > > > The merged page would inherit PG_zeroed, and a later __GFP_ZERO
> > > > allocation would skip zeroing stale data in the non-zero half.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Assisted-by: Claude:claude-opus-4-6
> > > > Assisted-by: cursor-agent:GPT-5.4-xhigh
> > > > ---
> > > >  mm/page_alloc.c | 15 ++++++++++++++-
> > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index bd3b909cacdf..d70c9ba6b329 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -940,10 +940,14 @@ static inline void __free_one_page(struct page *page,
> > > >  	unsigned long buddy_pfn = 0;
> > > >  	unsigned long combined_pfn;
> > > >  	struct page *buddy;
> > > > +	bool buddy_zeroed;
> > > > +	bool page_zeroed;
> > > 
> > > If you want to play some code golf, i think you can get away with a
> > > single bool here:
> > > 
> > >     bool zeroed;
> > >     zeroed = PageZeroed(buddy);
> > >     zeroed &= PageZeroed(page);
> > > 
> > >     if (zeroed)
> > >         __SetPageZeroed(page);
> > > 
> > > ~Gregory
> > 
> > Does it matter? It makes my head hurt.
> >
> 
> Less code generally means less bugs, but this is more style nits than
> anything.  Either way
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 
> ~Gregory


many thanks for your detailed review. I did my best to address all
comments, and sent v7. 

-- 
MST

