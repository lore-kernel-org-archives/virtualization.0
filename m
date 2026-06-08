Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39C3E7BAA
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947969; cv=none; b=LftJ6F0PzgOqSwvoNSph/zqLXn46BOB/TVlKx/hnX0QSEvftG0QOy8GBujHgjLLPy7Z5ns/bkCzCTTvtn4KdgYAZPbHHKVQ109cBhh20zlg+S+QCHUSN/AXlyC+5OqQAbkmttdSLnw/iwrmSOaWKgKUHFmwXyAwh3aW7QxZ6pdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947969; c=relaxed/simple;
	bh=HiesDSG2XitHdXdDDhZeaFf7JuMX1rHkw3DjlsPTdDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gL0CxbNyqpCDmzYbmcx0Xb2WyFdRbdxXYEwvX75l4zyfH/UZgFU1T2l3ylYhuO4Niup/knN/idxvtmDe54GNTIMaYQ6Et2WJgnu0HWlIqoTK30lK272y6TunlpMp7MUsRqNa33mF0jje+YowAp0tV30SkAQDOzkiTFGjdu45QTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FS5YNG4Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS5YNG4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780947967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4XkshBTgN4Zv/gIvkBzsPSwBPTNRhn2JGaJhvMxMoi0=;
	b=FS5YNG4Qzuw3CqdH6arVeFsPHaGB7GcowCDzkht35chflTX+gkcjieFFjaES+47cpBqC00
	iYUUlBuPUwTje/UWh76CG2joVF3fFmPRfkvpOlRwgonYSfWKnI2IUb/dB00M52Qx1/Ey7U
	MUOMf3lRNzmYkEOZqCv3P2vCXyzYxKc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-yp8031HAM4uK6YX7ohSBZw-1; Mon, 08 Jun 2026 15:46:06 -0400
X-MC-Unique: yp8031HAM4uK6YX7ohSBZw-1
X-Mimecast-MFC-AGG-ID: yp8031HAM4uK6YX7ohSBZw_1780947965
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b61243easo27633885e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 12:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947965; x=1781552765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XkshBTgN4Zv/gIvkBzsPSwBPTNRhn2JGaJhvMxMoi0=;
        b=na6nvON66xrSSjObSRJlqzQNHZOpIcx1jicU5MUdfT92AOZP+6gF2zFvT8gMkCFEn7
         syd86uyf02HMNQmRej+cxJg6xOBkfgoJT4/B4baGIHpVh3YNLJ5Mque5f5TjOfD4liXQ
         EFEpRp0U7nnsccupUvytQfLluBCWMoyhIV9uIoBNHsx+Afwt+oPgVRIyvGJbhYdaHkRJ
         PhEfDpOXK48ksk57PXtYHRKHjxXXXA2dW9kE02HvflSnGstxHLuTq/Ns3i91e+FBUNTU
         6uXq5P3E7xYwyn4oorwEZs2E/2f08n9N7AH65+oChNgkOyxLu6xbblET3ksOsH3zzwjx
         WJZA==
X-Forwarded-Encrypted: i=1; AFNElJ/k6sKFwBvOB0qo+5IxsuDh3AZ/nEtkLR5dQ/wrdkkN3BndbCCghi2xI0gZU8ImcXwRWv4ahSgf5s1fmIyrrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyY0cfwrEsCVSg35cGnHA9Ivh4MsQSAuWhTAR2m4McjppZCdhXH
	XeJsfHSk9qR0famTCc99ConVaJX0Qz0zwPvbsjAe314ARqr80D42eY6uA41puKVftOJRfe3brvl
	/h7XV3zHUNg1wYGx8x9An3Vc+/OGvfUQWKNGPHaR4Aav6XcZZo16uEBeHC7cGFyDN8G5T
X-Gm-Gg: Acq92OENlvKQkZZICKZUCwc5YrEHw3cBoCd6cJwd6rbqnzJUGlqfGTexaqnfxkD5A0a
	PJP5UuvyAqTX5kBZHKq6eNsuL7TeNPwhUzkLjzQsqm6Poxan739lkcUR6R9lliBPYiipH4u5LxY
	/dKH2ykWM8VdEa/5zZla18kd0wtQJp8Zi1toc4dryGupzp+qgqzMNhPHq+oHSaA0D/y2v7PyYyC
	6DkXh3ois1XAjQN7FsmR3ZM739y/N5wlYdpuWWAa5OWu9P+r7hXxDuXi+vswnaO5V0PMtUtsjx2
	IsjURPPZ5dFn4UC6vxj7a+ECRsB5dhNPc8Mw0lXofQMSVDjdBwYLxNg5nCuda5P6LtH/JS0pgIk
	+LqB9fetiIuOWQnRyf1g7TqILjoDgbjG+QJAvGtB9enTufST54AXtNQ==
X-Received: by 2002:a05:600c:468c:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490c257c3c8mr290867895e9.12.1780947964666;
        Mon, 08 Jun 2026 12:46:04 -0700 (PDT)
X-Received: by 2002:a05:600c:468c:b0:490:469c:556b with SMTP id 5b1f17b1804b1-490c257c3c8mr290867255e9.12.1780947963943;
        Mon, 08 Jun 2026 12:46:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d663csm465687715e9.11.2026.06.08.12.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:46:03 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:45:58 -0400
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
Message-ID: <20260608154354-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
 <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kNFB6MMa6QhoAhb-8Bikj90ItheaQi_ZxvF4OehJ91Y_1780947965
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 11:53:40AM -0400, Gregory Price wrote:
> On Mon, Jun 08, 2026 at 12:23:07PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jun 08, 2026 at 04:36:38AM -0400, Michael S. Tsirkin wrote:
> > 
> > > +			 * user_addr != USER_ADDR_NONE implies sleepable
> > > +			 * context (user page fault).
> > 
> > Can you safely assume that? Also inferring which context we are in from this
> > parameter seems risky.
> > 
> > It seems to me that you're now making it such that kernel developers:
> > 
> > - Have to know when and when not to specify a user address, and under what
> >   circumstances we might consider that to be mapped.
> > 
> > - Need to know to do this correctly for aliasing architectures or have silent
> >   correctness issues.
> > 
> > - Need to take context into account when specifying this.
> > 
> > We definitely need to find a simpler way to do this!
> >
> 
> This feedback was poked at in earlier versions.  There's a tension
> between keeping the old interface as-is, having explicit interfaces
> for something like this, and the state of a page inside the
> allocator vs outside.
> 
> Double-plus complicated by the fact that we're trying to reason about
> two allocators at once:  host and guest.
> 
> It seems it has gotten a bit more complicated since then (I missed this
> "sleepable context" bit, not sure if it was there on prior versions).
> 
> If `user_addr` is now implying anything other than exactly: "This needs
> to be zeroed / caches flushed", then this is bad.
> 
> ~Gregory

Well if you do folio_zero_user in a non sleepable context then things
are not going to work. So combining e.g. GFP_ATOMIC and GFP_ZERO and
user_addr all together is not a good idea.

You are saying it's bad? It's pretty fundamental to the idea of moving
zeroing into the allocator, I feel.

-- 
MST

