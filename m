Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792E371CFF
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536081; cv=none; b=Gqteik84RhOOGvSR5PMfnsTwKQitywONW3cpi6sXy2viOywBKqyQInBwgtyCxMYZBaEfE8ioVDH6+CQdcFpRZA7garvZzDqbvcwLvcHUyR3tmHBLsbEUIOwq+LrTbiT5g3cR/VaYfJlII2BFFcmHYhCBM5ZDa+nceJy7tJdZM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536081; c=relaxed/simple;
	bh=66iH2gLYu4zQZAcOaJ3NTaFrvEJ477mi4pa9WQaFGSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jo/x/YrYnhsHC0EvRBTq0UBSwGLaWRnq/Jb1ULRnQ1nHEKxmIxUMPtLc0xVjOMn6I/6srI+StKTi3PfoGp0bBrs6bnJrPCYGTlFvBbxrRGEId0IYxA5ctcV9wJFb68d1Klm+Zj8ldb/JxiEmZ3PTOuBJ67Ovj2cyx3wxd8xPZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=We3Jcm0z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="We3Jcm0z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778536077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H1xQri7WeZK2KoP5ZA3AQxtudqmOYwmsKhoFrsVAKDU=;
	b=We3Jcm0z0zWTR2lMgmkqZKpcJZCLmyi5HzfpYAf+169bQVb4V5eQ++IiWTv9+mMsVNlfx0
	169+IsQODI7NpOforTUtjg9jL4S8ofaXfbkhDCpyXVxW6XUYkIJ2ZwSQVmHonvkGYn0aWs
	LfwM/gQv8zET5vSledQsSIlIqiDVDAw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-ozQNaI_bM6OzhU1uqhYLUA-1; Mon, 11 May 2026 17:47:56 -0400
X-MC-Unique: ozQNaI_bM6OzhU1uqhYLUA-1
X-Mimecast-MFC-AGG-ID: ozQNaI_bM6OzhU1uqhYLUA_1778536075
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso42591305e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 14:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778536075; x=1779140875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1xQri7WeZK2KoP5ZA3AQxtudqmOYwmsKhoFrsVAKDU=;
        b=N0+pu3FxsIate9lRAa0s9AWF9LPvwN91qvOM+vvI8okD/oh0B+semaqHfpQBzQ/+3S
         L7VuN7XEBQ4bu6oyWcOu7XyFwJwKxKEWqNY9yf2UoFI7gp4TBddBf63UdCnNoerf9ovf
         gogd+w6TCDwugp5cUzO/26ZYqtvks4etNDZuT0b/KbqUQzqP51PHo6E3WOcDMS3J6qNC
         w5H2SFNDbAWx21jQCwgfGy9lqzi/YRfqLSAQjJDFXvkBT8HUKVn0gebV2EE7cXHrgprX
         qCp6G0sU8gYJSyvQTTpj7MBLbB7U5shFPflRVA1OJDdpp/AqQqOhth49Vnowk17elmv8
         zlgw==
X-Forwarded-Encrypted: i=1; AFNElJ+PIKPSik5QJqF90Pqq6M1RGpL2/Bw/yYcRvBamUKjmk6STUNGKGe6CftsMwPv/MucQTrWjwmTPpCxtTTpeBw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxtt3Sevgc9bLli/byLXbcHq0U06YtCEPoiYUdscZ8ZV1YxOFEw
	gt9Tz8qNeERExP8Ty0AhoL7+uArFnZ/uPWv2Na8hLJwLCddlpAygcUWchTYmjmODh8mJkbF5GNq
	jp11PZRdoZRLPhZdN1E6Iid3PpiAwknE7PH9i0znaERbOi7G9Q2nbee+6aSR1zXFpvx3U
X-Gm-Gg: Acq92OEAGXRskc0+MVboTieIKyf4//LAjR8jcWGCXWiQpjwoWNKQeaU9dnJ3jvoeDUK
	JizQhtKFG47ATJ8JU2uQgF/4YlnuswKn4q/OW4N//GQze0Fwi1kA+LInNb9Q3bcMvkN4msUhzaE
	jkWEuYFoby4c7jGQAo3o0sQ2utLcWIOmttG5Tt3E6vT0sRR10VMcwkAgqGJrLcVJH2R88Z1GM3N
	1TZZEmLI00wcWLr21cwIoYVY+iWq08HDsMYBGONLDINxb+PRkURDGlWvyMdMbzhzRUEvasUNr1f
	uoN+ZRgnZqL7/XSfLJf1QyvvODXyatJOrbpXJ1hPWCXRpzyTPz3OkCRxo1frUc1vHQTZuiG63Kp
	Gif7PKWfPP/GYYQapc1ePONuuREyQAAtB9+UpKBPe
X-Received: by 2002:a05:600c:3f0a:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e8e208ec7mr17163625e9.9.1778536075146;
        Mon, 11 May 2026 14:47:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0a:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48e8e208ec7mr17163285e9.9.1778536074640;
        Mon, 11 May 2026 14:47:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e5dd3e1sm8561305e9.1.2026.05.11.14.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:47:54 -0700 (PDT)
Date: Mon, 11 May 2026 17:47:48 -0400
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
Subject: Re: [PATCH resend v6 14/30] mm: hugetlb: use __GFP_ZERO and skip
 zeroing for zeroed pages
Message-ID: <20260511174337-mutt-send-email-mst@kernel.org>
References: <cover.1778489843.git.mst@redhat.com>
 <fe1d24d4deafe0f5d1a9c51fcc040d9561c8592a.1778489843.git.mst@redhat.com>
 <agIFq63QZugkWcXJ@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <agIFq63QZugkWcXJ@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vd7HnajzVTKFv3vEIUIkvOUcAFldtUV4P5luNeOc7QI_1778536075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2026 at 12:36:59PM -0400, Gregory Price wrote:
> On Mon, May 11, 2026 at 05:03:02AM -0400, Michael S. Tsirkin wrote:
> > Convert the hugetlb fault and fallocate paths to use __GFP_ZERO.
> > For pages allocated from the buddy allocator, post_alloc_hook()
> > handles zeroing.
> > 
> > Hugetlb surplus pages need special handling because they can be
> > pre-allocated into the pool during mmap (by hugetlb_acct_memory)
> > before any page fault.  Pool pages are kept around and may need
> > zeroing long after buddy allocation, so a buddy-level zeroed
> > hint (consumed at allocation time) cannot track their state.
> > 
> > Add a bool *zeroed output parameter to alloc_hugetlb_folio()
> > so callers know whether the page needs zeroing.  Buddy-allocated
> > pages are always zeroed (zeroed by post_alloc_hook).  Pool
> > pages use a new HPG_zeroed flag to track whether the page is
> > known-zero (freshly buddy-allocated, never mapped to userspace).
> > The flag is set in alloc_surplus_hugetlb_folio() after buddy
> > allocation and cleared in free_huge_folio() when a user-mapped
> > page returns to the pool.
> > 
> > Callers that do not need zeroing (CoW, migration) pass NULL for
> > zeroed and 0 for gfp.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > Assisted-by: cursor-agent:GPT-5.4-xhigh
> > ---
> >  fs/hugetlbfs/inode.c    | 10 ++++++--
> >  include/linux/hugetlb.h |  8 +++++--
> >  mm/hugetlb.c            | 52 ++++++++++++++++++++++++++++++-----------
> >  3 files changed, 53 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 8b05bec08e04..24e42cb10ade 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -810,14 +810,20 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
> >  		 * folios in these areas, we need to consume the reserves
> >  		 * to keep reservation accounting consistent.
> >  		 */
> > -		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false);
> > +		{
> > +		bool zeroed;
> > +
> > +		folio = alloc_hugetlb_folio(&pseudo_vma, addr, false,
> > +					   __GFP_ZERO, &zeroed);
> 
> This feels like a very odd pattern:
> 
>   1) ask for __GFP_ZERO
>   2) Have to check whether it was actually zeroed
> 
> Seems like the zeroing piece should just be sunk in if you're going to
> ask for __GFP_ZERO anyway.  And in that case, maybe just `bool zero` as
> an argument, rather than GFP (to avoid future overloading of flags).
> 
> ~Gregory

Heh. The reason is that it either allocates from buddy - using gfp flags
or from the pool, in which case it zeroes.

We could even avoid the bool - just test __GFP_ZERO inside
alloc_hugetlb_folio. Would that be better?


-- 
MST

