Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872334405B
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609202; cv=none; b=Quzx1T9fbUWNdAXmAX18qd0bffVPPaemIwk2X30/6ng/wTPw0Gf8SJLjW5CqIJr0tjB28foxnDKmBSTF+tuVwdE8lQwnloITw16swjYXAxvr6R/xPOjpJRgiexF1GE9SnQlgkCtAHiw6AZz8oQIHMU0UFVkArTQvAsclroPFxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609202; c=relaxed/simple;
	bh=RpSu/XW/aDuFc8HVqqoQGgZcY95TC8aEBDOi0Yk9GRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S4+TI8cgRa4vlz9FHOS13aKpx0N6O4DLSSNckxek6ojHrjBfw+DaWgB6bQyhMblDQkGVkJIltbQOm99rVqhd4TYdTErMy7Hx2sjYvjkSmBpM169hdRhNklUxieiStCyCSJ0l0Vlv+pVoGGHGTUvDBpkJRE65m72JqXi5UgreUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2tsIREP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2tsIREP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778609200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xc/NhkzuaZoAdTp3ChNwKwwR0U6LJ0GRCb8Tqmiuz2M=;
	b=c2tsIREPmkcs2vM1fL+038wFWSCSs7pxMM9BjVzCiwXIwUlL7IChxfpDANDSyk7gzOgerO
	PIHeLsx9f+x3PPMG02Bis73QHAsUsVY9ovVu7vMsAQgjJtoxLyHGgaNd23L4rLFPk4IVmv
	dccUjhk4rS96B0Ubw8sHZMP2iRlkYxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-DNAZoZTpO6mTZ-1Svgw97Q-1; Tue, 12 May 2026 14:06:38 -0400
X-MC-Unique: DNAZoZTpO6mTZ-1Svgw97Q-1
X-Mimecast-MFC-AGG-ID: DNAZoZTpO6mTZ-1Svgw97Q_1778609197
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ff19e54beso4093919f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 11:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609197; x=1779213997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc/NhkzuaZoAdTp3ChNwKwwR0U6LJ0GRCb8Tqmiuz2M=;
        b=l1UrDgaL+/fs1HQX4L54TdlniqFOfWZ7MzdRcSh8ABP2LXzP3y2uzhwdCuouVIUEKy
         SL5nO1foDKtMQyA7s/hOr13fmsFy8vQtIF60m3bCujnUPAwLgDD7QAn1PiKsN0E1n94X
         CaFgv1R3Wd6HsMeQzy8HHQGhQFwWHQ4IjG1L9hgsgcQt/7MUkfrB2IBgLAu3R0eOjjls
         5evLH1bIDUMoL993WzXggO5IxAlkHH9HgM+00+OpiJ1RJS0tCNCgBb1BFXVmPSMLa5QJ
         Kl0RYm18yFFC9gDSk8PfVaKD82UOxuTJUSi0z/BjVSCa/amdoEpwC36OmculSeLL/7Q7
         lTtg==
X-Forwarded-Encrypted: i=1; AFNElJ9w0z+CWXjL/n6yr/cD58r4Fxn6ZWvZK7LdCPmF7dFQVCpi2vy3jP5qOrNenxo3rDvOhq4DQCPXS80YXGk2XA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrFVfahhCAOkKLlYnJ4CDZ+PgCcGNUPJhWR25eHk+4lAobIjry
	4WFnT4RBLTHrzsd/am4DI6ztKnVabsxX6dvhIcHOrooPaIPmZ3tRpa+E+NZjrcSElgNvi2iToi6
	c2sxy3kofvagTdahbRPSMM6smAROEAYj04L0/3aAYmLOlNcNSztPsxtCSV6nGOg9S84q0
X-Gm-Gg: Acq92OEffmL+CYDv8SEkh6vw4eeGx3hDLqBpfJCLmyubhv/aWW+eRvfGGvu9/iyFD1A
	KcGTU2mMaqVMck5DDR145Td4y/akP36C4z69dkNJHn/frpCwD/U1UeD0iifsfn+IN/qdnSbbrye
	P9NJMhVu3NEFLxci7XqcV26wWgNFWOkk+Y4N6pBtCBzq3lj55xdb47nYrAsJMsQMnfLCQ27Vfy/
	BEkptlY2I6TPehyuxzuKztnzx8otQboS70HIy0z3piqVmHG1PGGnjwS2uz2OfbOje840dlbEPeN
	6bip1zwtvoAh98k7eyVMRm59IPL1jzXrCSDaj2MEAI8M4IMovuBzEqo6DU/Pwd09BaeURt9t8Tg
	RIt/M+CfeKgVpiuL2rtjYz3xhx37vdV47q+JxamtJ
X-Received: by 2002:a05:6000:2311:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-4546140ac8bmr30487476f8f.13.1778609197033;
        Tue, 12 May 2026 11:06:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2311:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-4546140ac8bmr30487412f8f.13.1778609196463;
        Tue, 12 May 2026 11:06:36 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca383asm33507368f8f.28.2026.05.12.11.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:06:35 -0700 (PDT)
Date: Tue, 12 May 2026 14:06:30 -0400
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
Message-ID: <20260512140254-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <9b53972f4854c1064b92cefc464f51949afeb83f.1778489843.git.mst@redhat.com>
 <agH3wceKcPNmixCj@gourry-fedora-PF4VCD3F>
 <20260511114853-mutt-send-email-mst@kernel.org>
 <agIJOkLhTOsvJs1-@gourry-fedora-PF4VCD3F>
 <20260511175032-mutt-send-email-mst@kernel.org>
 <agKViOG_YQci0ffN@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agKViOG_YQci0ffN@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RGXLFzdU2LNqz2-_XFelKCMPtro7wzjQV_J1a7_jQn4_1778609197
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 10:50:48PM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:59:23PM -0400, Michael S. Tsirkin wrote:
> > On Mon, May 11, 2026 at 12:52:10PM -0400, Gregory Price wrote:
> > > On Mon, May 11, 2026 at 11:55:40AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, May 11, 2026 at 11:37:37AM -0400, Gregory Price wrote:
> > > > > On Mon, May 11, 2026 at 05:01:55AM -0400, Michael S. Tsirkin wrote:
> > > > > 
> > > > > > +/*
> > > > > > + * Sentinel for user_addr: indicates a non-user allocation.
> > > > > > + * Cannot use 0 because address 0 is a valid userspace mapping.
> > > > > > + */
> > > > > > +#define USER_ADDR_NONE	((unsigned long)-1)
> > > > > 
> > > > > Ehm, hm.  Does -1 hold as a non-user address across all architectures?
> > > > > 
> > > > > What about in linear addressing / no VM mode?
> > > > 
> > > > this is used on a fault. I don't think there are any faults then?
> > > > But maybe FAULT_ADDR_NONE would be clearer.
> > > >
> > > 
> > > Meh, naming here is less relevant than the sentinel correctness.
> > > 
> > > My only concern is really whether -1 could end up being a valid address
> > > in some horrid future timeline and this all going belly up.
> > > 
> > > Is why I asked about whether this is correct on all architectures.
> > 
> > I think the answer is yes: on all architectures Linux supports, the last
> > page of the address space is never a valid user mapping. The kernel
> > enforces this -- mmap will not create a mapping whose end wraps past -1.
> > 
> >   if (addr > TASK_SIZE - len)
> >       return -ENOMEM;
> > 
> > 
> > So the maximum vm_end = addr + len <= TASK_SIZE.
> > On every architecture TASK_SIZE <= (unsigned long)-1, so vm_end can
> > never wrap around to 0 and address -1 can never be within any
> > VMA.
> > 
> 
> That is worth documenting at least in the changelog if not the comment
> with the define there's a clue if anything ever changes.
> 
> ~Gregory

Actually that's one reason. And there is *another* reason. Almost all
callers pass vmf->addr in there (with hugetlb being a single exception
using vmf->real_addr). So I changed hugetlb and now everyone always
passes a page aligned address.

It can never be USER_ADDR_NONE


