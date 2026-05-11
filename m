Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE494DA53F
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536775; cv=none; b=gxOw5MXG22zUJihFNkNe4hSvfzexK/QsH3GWkwLQVZcgcknPFJfP3b3vjh4trk/ebqiuQjaYrPxrIcW8Hlfyd/2NLI4soPQiBFB8M0Ltj2VzpYtOifmEToSbAo0l0KFCtuPz4/42SKaa8wHFVMck6AvlMJ6uEyKaozCxgew6YbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536775; c=relaxed/simple;
	bh=/RAKwLs7xITQyzEZAe+L+bwxAZbSC3kmGnvLvR0cXFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mD1+DG789LHh39aQ7f94PuKmfgKVqswGKweXcFBeqkEsiqq4x78FjXDE/mxWx9wkIEMbrX/T4htKadtdpKf1UkF3QsYnVTmT6pAQgz8RRvdfnW6eVAhVHerLPkDdGrD/T4uyKAe78TJSEUBnrbwPMap/BWg/rW9fR8gdbc7PWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtM/7CFg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtM/7CFg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778536773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjGUst/RnjF+SV00Nscm4z96ojlmIg7JTTzXC6ZQiZA=;
	b=PtM/7CFgbWnQmf9ArgeQ51jfRU9WYoNLD7N0LVFgKLuFxm+EISUxChXpNLYuD2nb86cqiu
	yQiKBfgEidZiLnYrE0NCoQsWnH9cZvBeBeGy2jAZ+ZMCRoJrnAmfxW/dklYALLvOHfJsO0
	/OnZGKrnKMISfEw1TgSNdMzCxafw7o4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Lr_XMjNGMCilRDMh0TqFRw-1; Mon, 11 May 2026 17:59:31 -0400
X-MC-Unique: Lr_XMjNGMCilRDMh0TqFRw-1
X-Mimecast-MFC-AGG-ID: Lr_XMjNGMCilRDMh0TqFRw_1778536771
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso3035816f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536770; x=1779141570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjGUst/RnjF+SV00Nscm4z96ojlmIg7JTTzXC6ZQiZA=;
        b=j+O6sPe4aghpgwFNK/O0oVC4qcT/EpG0RTvCnmPl2CNLqDovoEKb2XIaFAisPRcv2W
         44qk9/DM7F9kFNgPGHFDJjPgMmXc60rBEixvcJh8cqCDx/t9Sy/fqLvvgO/bRNhkzd6x
         //UVtpjo0pX23LDAjsWqiyeAFCq4OaPXesi8bBZ7plTtl5RIazTS+WJ6Gx1itTo9fQAH
         uM7FQi3eiMC290MytjkAwFoZdTc557W6hPQoI6rhEeL6cnldUzv7Uimsp3ohJoHBoxEA
         ZCY/wUaJkYsuikpMZ2ymT3aD7hlJJ5pEvyFx3SmMBdvaH7TqusRrBWe69R9xvyprqpbM
         ljlg==
X-Forwarded-Encrypted: i=1; AFNElJ/1JXfQlAK6PSVJtFX3av5PdEmuKbn26fdoE2aFkL+ivESwC1fg41f3iz8fqmiub2Ez1Zg2tHuW93w1HTDXVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdLCKgxDJkBoAOjI6RG96pjprVmYxTuJPMnBjZVnzsOC/f/LUW
	tSshd8f0NDDcn0qjORq8VsU+qxZQhXqQRyo7oDxM7pFwXYVHhJSsC1z7Zxl0mqFINvKHdIXaYoD
	+/fRzjdouXpbyvLsBljdsqZKhH+yoZDkTGBPym+5/mKFJ0I9xXraO2/24OtFyA+ekZSI7
X-Gm-Gg: Acq92OHH8etg/Dy8yFcVb40GDrx4m4QLHzB1yLhbAYZL1CMNw0w0PFH7P1D90D10Fqm
	6smlhC5LBUssT/OdQezf90PWLWimZibY8rsARzpm+G6HIePhcdfmU9RBjzl5xmm0iZ5V/8ScOO6
	sBfS+jfSJj1t7Rd9IotHIeK+8uXMrKfbNSTnJ2z+haWNkzKbxzn3Nq/v4/r/XyhqW48xqIukbXQ
	nXZW793fGBCZA43R5f6gjwYNQWTidVLnwaYhY6BHjmpS3w8ffkCcIQlcTTsJj2ZHcyWkjZiqYn6
	IY6NgbHzLOrNbqplo465y7sofp0ownPcarQEwf4qfreuj8DjXc5xNMfYVZ/Zr0z/fYpsIQYf9ap
	C1Qv02VIqeK4hfZXYwIahhjHp6PShduatL5tw6UYq
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4515d3dcac9mr40872502f8f.33.1778536770535;
        Mon, 11 May 2026 14:59:30 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:43b:4f86:e985 with SMTP id ffacd0b85a97d-4515d3dcac9mr40872434f8f.33.1778536770030;
        Mon, 11 May 2026 14:59:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm26961587f8f.16.2026.05.11.14.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:59:29 -0700 (PDT)
Date: Mon, 11 May 2026 17:59:23 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>
Subject: Re: [PATCH resend v6 03/30] mm: thread user_addr through page
 allocator for cache-friendly zeroing
Message-ID: <20260511175032-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <9b53972f4854c1064b92cefc464f51949afeb83f.1778489843.git.mst@redhat.com>
 <agH3wceKcPNmixCj@gourry-fedora-PF4VCD3F>
 <20260511114853-mutt-send-email-mst@kernel.org>
 <agIJOkLhTOsvJs1-@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agIJOkLhTOsvJs1-@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m9XfklX_ZcEvgyTqZWKAgG7MiwE1oHvGxzItMxhh-6Q_1778536771
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 12:52:10PM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 11:55:40AM -0400, Michael S. Tsirkin wrote:
> > On Mon, May 11, 2026 at 11:37:37AM -0400, Gregory Price wrote:
> > > On Mon, May 11, 2026 at 05:01:55AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > > +/*
> > > > + * Sentinel for user_addr: indicates a non-user allocation.
> > > > + * Cannot use 0 because address 0 is a valid userspace mapping.
> > > > + */
> > > > +#define USER_ADDR_NONE	((unsigned long)-1)
> > > 
> > > Ehm, hm.  Does -1 hold as a non-user address across all architectures?
> > > 
> > > What about in linear addressing / no VM mode?
> > 
> > this is used on a fault. I don't think there are any faults then?
> > But maybe FAULT_ADDR_NONE would be clearer.
> >
> 
> Meh, naming here is less relevant than the sentinel correctness.
> 
> My only concern is really whether -1 could end up being a valid address
> in some horrid future timeline and this all going belly up.
> 
> Is why I asked about whether this is correct on all architectures.

I think the answer is yes: on all architectures Linux supports, the last
page of the address space is never a valid user mapping. The kernel
enforces this -- mmap will not create a mapping whose end wraps past -1.

  if (addr > TASK_SIZE - len)
      return -ENOMEM;


So the maximum vm_end = addr + len <= TASK_SIZE.
On every architecture TASK_SIZE <= (unsigned long)-1, so vm_end can
never wrap around to 0 and address -1 can never be within any
VMA.


> > > So the trade off is:
> > >    a) churn the current interface for everyone
> > >    b) add a user_ variant and know people will just get it wrong
> > 
> > I was also explicitly asked not to proliferate too many new APIs.
> >
> 
> Yeah simply spelling it out, not asking for a change.  Probably no
> better way to go about it.
> 
> ~Gregory

