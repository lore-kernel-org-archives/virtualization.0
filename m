Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA737649A
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952700; cv=none; b=tnALlw7N8GMXKmqvHgWVGWVTkvsy4LpPr5eJEfRECrg94ylF9W2JFRmS0I1f+KotLNkwhqUL/N3d6flEc+DKdiiLyf/dEmI881dc/gEbau4HT6eM4HxTghBAMj1YqqgFeASMG/LsRvYXlG1q6bzJx+A16FT2qSV/Z6tjjPsU4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952700; c=relaxed/simple;
	bh=OgF9k+IiDMtBnvBE0GxYSZsQiXwofytTaJX9Y9hKkt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lOBnm60NKX4+bsGLE3A8wsxMZJmX2rWBCg6ck1/f/WjP64hO5KqXsKh4T7gBbI1zBrRMkogqz7qFSPPc/nm2s3YjECT1Ka2BifsLzFDx4D2TSGoTkD2EBMXwgXm7lcs1xdAJyrYa/891U6ZTBBDH3O4kFaz1SSNN5oIkt8H+6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erk/qgUF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erk/qgUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780952698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CG7TX63y8ii7nF3o7st9M+h9AET+tnVYkN3+ZIy7R/k=;
	b=erk/qgUF8BaJ1BTNeOJ6pQ4uAN9ViN3fMF2x1UmsAsvpvWpthbV7JE8WCwXYB38SaeaX/A
	St8yNDik/i4hrjKspUPoqWZIVAE3iyjRIABi3X9PluBTu+vE67FLl6sw5H9D6wPvXfalk6
	LrTxXy3owGFfOtjZjKuKBdA+87768+k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-Bpe3ZFFkMja2sqqruW9Wqg-1; Mon, 08 Jun 2026 17:04:56 -0400
X-MC-Unique: Bpe3ZFFkMja2sqqruW9Wqg-1
X-Mimecast-MFC-AGG-ID: Bpe3ZFFkMja2sqqruW9Wqg_1780952695
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef616db45so3821575f8f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 14:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952695; x=1781557495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG7TX63y8ii7nF3o7st9M+h9AET+tnVYkN3+ZIy7R/k=;
        b=qy2b+GNclknSMQq6KuwstnuTbKvqvgY/+dtyBf4tclumziukh28a5elB59ZDhSsHZn
         ENKzCWFW48fRCDhg0toFI/Vy/i6oPixhdN56Gaj52v8VvKQLDRZMzc/PWS87aKz4VWvP
         tH0vhRjQ1cLmmtOLNxKPBTT7Kql7G5aB77XGFX69kgkaOfaZxI/+cbZx00yPwNBARSQ6
         f8Ija5Xe4wcyKLenKHxRfVTNOZJB7eR6/MLDofLrY/8q07qnemCZH6RuFKfjewkeXpZ8
         Tk3PB84jnK6wrJ3QXNelxjkmmRw8orVXwFPV4AN9vpSbNAoPDYazucWzhYd60r1+WM4a
         CdQw==
X-Forwarded-Encrypted: i=1; AFNElJ8Icg634NSbQwO2btdRH+5I9QmMCeRgtCEQnS9EqTu0kmBLa1EYw8n+DG3/kuqCXfDUoz6hU+es23EUKME/yA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg5OAaHEDh+47FNarQGh4R8VkbqQUieVQHaVQfGPrFBnoM5eZ1
	48up2MpVmK1ULdgaLOel06MeWy5dPo5VkRtgko7jGKw0hqe23tsWg9ErpND/NGvK8xh3NK4k6NA
	3dmxRgjWFIr9+9hiOIGuWxwo0OBmmSvPLXv2wWQ2LA84jF7Plb6xASbqBsE94AFqIedeM
X-Gm-Gg: Acq92OGOKj9hqshcfdnlp04pazGLUvfNxQN87vBGmCP16VNMtKbthJYJn+SgoKlbwG8
	4JKcKTpROC5cX6zMBj8ANGSlBah0hbFTO5CFzno+gmQ+Z74r9W6VWB1HzWZz8FgfgET3mr/mngO
	i7ic8mONYt5sQ0jCFBXnaQQ866jETSeW0BYTS+Ql8J4WOgykvnCnPv3Nk/6tlkBOX4z3SSC+V+H
	6xhe9vfqVUVSnmQ4yBWkrjQK/WMaMkvBPujfAQoLn0TLIleiQcEkaNWwjcmPlun1qZs+3wkjImy
	2Zhw4/9g95b7iniWI0rlxcFU0RTYz/F/76DgZ1AWVASKVQjsqYwHaN9arR9ZY7wjA1v1SPuMfLz
	JEfmDYCPglTY26aP7Lo4ErBHwO1abKq9Cfsu1lAPnOjPhCX4J8J4BRw==
X-Received: by 2002:a05:6000:46cd:b0:460:1492:4f0d with SMTP id ffacd0b85a97d-4603063c591mr17367248f8f.34.1780952694637;
        Mon, 08 Jun 2026 14:04:54 -0700 (PDT)
X-Received: by 2002:a05:6000:46cd:b0:460:1492:4f0d with SMTP id ffacd0b85a97d-4603063c591mr17367215f8f.34.1780952694170;
        Mon, 08 Jun 2026 14:04:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm100416244f8f.27.2026.06.08.14.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:04:53 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:04:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20260608170348-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <50d410b47fe3f45327783e05bd306d5eaab75e65.1780906288.git.mst@redhat.com>
 <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
 <aia93IzhTgi1vGi6@casper.infradead.org>
 <aicfERTP3H6AndOs@gourry-fedora-PF4VCD3F>
 <D1CF67EF-2CF1-45F8-9265-70A528C1CB01@nvidia.com>
 <20260608163257-mutt-send-email-mst@kernel.org>
 <BD0C8760-BC10-4BF0-9EE3-9B0DAF0D977A@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <BD0C8760-BC10-4BF0-9EE3-9B0DAF0D977A@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SBgyUoJGHtfYuR9ok0IM_qVZG5jyikcD3r7A2ifMiYs_1780952695
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 04:40:15PM -0400, Zi Yan wrote:
> On 8 Jun 2026, at 16:33, Michael S. Tsirkin wrote:
> 
> > On Mon, Jun 08, 2026 at 04:21:08PM -0400, Zi Yan wrote:
> >> On 8 Jun 2026, at 15:59, Gregory Price wrote:
> >>
> >>> On Mon, Jun 08, 2026 at 02:04:28PM +0100, Matthew Wilcox wrote:
> >>>> On Mon, Jun 08, 2026 at 12:06:35PM +0100, Lorenzo Stoakes wrote:
> >>>>> But instead of overloading user_addr to indicate all kinds of things, instead
> >>>>> make life easier by actually breaking things out.
> >>>>>
> >>>>> Like:
> >>>>>
> >>>>> enum alloc_context_type {
> >>>>> 	KERNEL_ALLOCATION,
> >>>>> 	USER_MAPPED_ALLOCATION,
> >>>>> 	USER_UNMAPPED_ALLOCATION, // Maybe? Do we ever?
> >>>>> 	/* Perhaps some other states we want to encode? */
> >>>>> };
> >>>>>
> >>>>> struct alloc_context {
> >>>>> 	...
> >>>>>
> >>>>> 	enum alloc_context_type type;
> >>>>> 	unsigned long user_addr; // Only set if type == USER_ALLOCATION
> >>>>>
> >>>>> 	// Maybe something suggesting context or whether we init before in some
> >>>>> 	// cases?
> >>>>> };
> >>>>
> >>>> Ugh, please, no.  As I suggested last time I commented on this
> >>>> trainwreck of a series, lift the zeroing functionality from
> >>>> alloc_frozen_pages() into its callers.
> >>>
> >>> This sort of just implies writing the "alloc_frozen_zeroed_pages()"
> >>> wrapper that does the zeroing at the end before return, and then killing
> >>> the post hook nonsense associated with it in the first place.
> >>
> >> This means it is going to be a multi-step optimization. This is probably
> >> step 1.
> >>
> >>>
> >>> None of this resolves the user address annoyance which is needed on some
> >>> archs for cache flushing.  Whether anyone agrees that the page allocator
> >>> should be responsible for this particular operation - open debate.
> >>
> >> This is probably step 2. But does the virtio use case apply to these
> >> archs? Does the performance matter for them? If not, maybe this part can
> >> be left as a TODO.
> >>
> >>
> >> Best Regards,
> >> Yan, Zi
> >
> > I doubt it. But I don't get what's proposed, the code that we
> > have to modify is arch independent?
> 
> Change user_alloc_needs_zeroing() to only check address aliasing even
> if that can cause double zeroing for virtio.
> 
> Best Regards,
> Yan, Zi

Ah. I started with exactly that in v1/v2. It's a simple approach.

But mm maintainers said no, user_alloc_needs_zeroing is a hack and
I must not add to it.

-- 
MST

