Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7675343881
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955198; cv=none; b=Bh6R7PVDWZyBkem3S/6bSTGU5vfObByz2hERIynXkLqGp542irK0Pxqa5NNPyMmtpncNVcgYhNInGyyC7PD1hKtGJo4ZEW3UEMT3YY5HU5uhZsFmjlT2T2o+0EmfQUySkU39LFHPguZjNlOVheftL3kc9UnKEjdBYHUbmAa9Op4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955198; c=relaxed/simple;
	bh=Wt0eX66JeT1T5/z01Y2CCJjcqqWfFvakQ8FxHok40f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L0PFV//bEgcvihKbnddpf6eFiF/iXDF9eq06lvQd82I8jDSaps+wNh8M7FTSJJkvqwFaZm+9K0+Cfg3YKDRw6OofBseI4424p+Wem4oH5fIJDiBbF9vpFdnHPKZDmtoSyQL6qDv92CGi6UjkpfiX2MpfbtfZB/xIKzYcpSNwlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgBb/HTH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgBb/HTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780955196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kkj4BDKvd6RLxlrEHJrrkFJg5KJS8ZlmkKTYtWUT7OA=;
	b=VgBb/HTHN8nunwQMupt8R1zdCWbgkoU5fAqwl6lqE/uY3D7GnWn9NcQDxw/dQajdjDFZmI
	GrZU5r7OBqKENe0AbndTEFRh0MmwY2xUjPTzcsBkASNBPxhdRH/vz8jNsSlOBds1LZQsCS
	NzZ0X+3k2uzUEwpp6r8r6xU/8Wc4uZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-quGar1F7NLOHIpDy0daZUA-1; Mon, 08 Jun 2026 17:46:34 -0400
X-MC-Unique: quGar1F7NLOHIpDy0daZUA-1
X-Mimecast-MFC-AGG-ID: quGar1F7NLOHIpDy0daZUA_1780955194
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef697092fso3007145f8f.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 14:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955194; x=1781559994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkj4BDKvd6RLxlrEHJrrkFJg5KJS8ZlmkKTYtWUT7OA=;
        b=NAqOpMJPtyJo08tAXZF1SM/g93bb2PidNOJkT//8sYVm++fV2zY2ZYsdxoc30PBEnE
         6OGwS0Sp6cblt1C7wF+0PGicP4+GfqNb439vVA5GGNqpg3UxFqJ71ZZ4ai4KOBH7bJw/
         eJ3HmIxNH3EBruRNZCeNpx8mONtoaSqjLTO+uBAePngPCkZDul/HnfYPM5zeL8MgXqeI
         MVk9UM+u47p+uVbSTo5Hw6G+4npof/h0d1+zXL0qa7SK4Eza77QB7qZwf27whMr5Q42G
         TuN/ldkY7uvf+xBfyFCLftq1lu7osFsCsmGu6LMENWrhdxbn1WxHJOjBwJk8LBmFBRm9
         pr3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9isvBZwk6zeYEShnCW65zhALo5r+saP2T1zJ1JWNQk3CjGl6jGD+NB1g0DEOzvnL5p9lmBuvpXe8jl4X6/6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxnvaf15U+MoookKG3c/rnE1GvC/QWwVBEgxvrDor+V6dv34PQI
	gS5v04VH6bcLsuzDRnJ8M6+umWvJwzuojRM4VsNrq3CE2+EcwBr/tE0T3//UburGHu5N65oQNko
	f8j/Dg5rehMCfEiJfOtDiDHOv1F2yP0k8WReJhiuzF/UHblaOSx96ma5cnEO+z7kR5ns4
X-Gm-Gg: Acq92OFUzfY7b95hYBoONF41PirAssYwmDbR4QPsZiqi+02L+XvQQ5LrnvDwUGumu/k
	OoCD6IDdefZFRkDdMp3FwluI6hrd+2F+i/x7f2odZ8k/usVirZtGrnP8VGYkLh5pFjYXwI4+SD3
	NmvyKjFSEwJY5MFKJl4wLRIbnKlsuA+QvQ+JMdi9C3DkPH8gd/AN53zkA4hxU613epQ5yM9zRuV
	ORwipevfwJ1aIU5+PuIq3FfveQyGdw+K/MQSOGQkobN/vFjEcUBKQyCrpgSsf5Zhodu5ihmvPwg
	FPnoET9yjZAnQ1L9p5zWyyJT7F+zSPtT2tbNXfp/0x/BeliMoy4R0k57ad8qRjo1SbEmXfsRbwh
	8YhftD2z1owf32mNTtW4JYx/SXFtdbaUceZqfOQ3ShFE1zQH7F5QomA==
X-Received: by 2002:adf:f911:0:b0:460:24c1:db8 with SMTP id ffacd0b85a97d-46030777545mr22264740f8f.38.1780955193542;
        Mon, 08 Jun 2026 14:46:33 -0700 (PDT)
X-Received: by 2002:adf:f911:0:b0:460:24c1:db8 with SMTP id ffacd0b85a97d-46030777545mr22264681f8f.38.1780955193058;
        Mon, 08 Jun 2026 14:46:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f5612sm53618998f8f.15.2026.06.08.14.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:46:32 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:46:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v10 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <20260608174430-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
 <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
 <20260608154354-mutt-send-email-mst@kernel.org>
 <aicjNRrHYOOBt0Hx@gourry-fedora-PF4VCD3F>
 <20260608161810-mutt-send-email-mst@kernel.org>
 <aicruns_4nOx0hD-@gourry-fedora-PF4VCD3F>
 <20260608170646-mutt-send-email-mst@kernel.org>
 <aic1PoxSiHzZ40Jr@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aic1PoxSiHzZ40Jr@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lc7Ii2JhUEWr8omTPmQ5ZBwCR1LIGz8HlmRnnMcuKEQ_1780955194
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 05:33:50PM -0400, Gregory Price wrote:
> On Mon, Jun 08, 2026 at 05:16:53PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2026 at 04:53:14PM -0400, Gregory Price wrote:
> > > 
> > > As a start:
> > > 
> > >   1) the user_addr and zeroing piece seems like a discrete
> > >      improvement worthy of its own set - aside from end goal.
> > > 
> > >      This is needed by your patch set, but was requested to
> > >      try to push us towards a more reasonable pattern for
> > >      folio_zero_user().
> > 
> > What I worry about is people can't agree what api they want.
> >
> 
> Oh that's just our base state of existence.  We mostly agree that
> all APIs are bad in some way and we don't want any of them :P
> 
> What you're looking for is to get people to agree to the
> least-offensive, least-worst option :]
> 
> I don't think we're far off from that.  I suggest doing as Zi said and
> start a [DISCUSSION] thread on specifically this and lay out the needs
> and wants and design issues that you've learned from the past set of
> versions and continue the discussion there.
> 
> It helps to take some snippets from your set to lay out what you've
> learned and explain why you need the folio_user_zero() stuff to get from
> A->Z, and then let maintainers hash out whether that should live in
> post_alloc_hook or new interfaces (or outside page_alloc.c altogether).
> 
> > I don't mind trying all kind of approaches, but it seems to
> > be past the point where people feel it's costing too much of
> > their time with all of these revisions.
> > 
> 
> People are still commenting, so I don't think you've gotten there yet.
> I think the rate of revision is what's costing too much attention.
> 
> You'd save yourself some revisions by taking the attention you have
> right now and starting the discussion thread (and consider submitting
> the topic to LPC if that's something interests you!).

Well it's in october, is it not? I don't think I have the patience to
keep fiddling with that for half a year.

> All this is to say you're doing fine, just keep on keepin' on. Maybe
> pivot your approach from iterations to discussion for a bit until the
> opinions settle.
> 
> ~Gregory

