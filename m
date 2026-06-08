Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BD3B14AF
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780957727; cv=none; b=dHa/P3cIc1QqBSbWp7N78Mbyg4icHe2wsPnGlWSDePvAI1zI42a0P973aNhY7N7N7HnuJ6IK4C75/fx5lZZEPYxKhqLdsqkiEySsGNdlOa5H5dffu6DYOicqHtwqvvZZeMcW8g4xfwUYcVnPl06wsMfYK0AS3OFPLL07Cig5s8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780957727; c=relaxed/simple;
	bh=WPVk3fOsviPC5DEcsySe0ug5tCeq3XbI5TttjqERytU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVkoi2HIWFC+wEOogDc9yap+aHRpfQ4B/+VH8+9Fvna72JYg5psEK2akLjdW+OqB11G/smRnPgcFrSFaf5D37Uxuje3b31t2q4JAzUypaMNNE1s3pd+xWon52Mr1/3lhHCgZNliqAMM46EdoOlq7zy4E4a0uIkVT4DjF8ob/aW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JE5lDTAp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JE5lDTAp"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157b895c57so447830485a.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780957725; x=1781562525; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gX/mp9SJHUWlSmoLEXlEEj6nZQtwhCmJ71m3qpbTAE=;
        b=JE5lDTApuyhvHQYxYTvFQueF8IBtxSyrOWfuVaJMjt5gB1Zvuxv6ry9gdrbA/grqKk
         i6a/FutDvuAmE7l7rAOGe02fUOYa+gSuouodtmZbOGJ79mM8UYWaAvy7DR6qlFEIyu9e
         3UFmuh4BxoiZcWGkPX/p4HSAnCzUuKQ+NMkI1OoZRZYC3St362bWz8lJdSYUPpQMl6/f
         vTeUFfLHl0lltxTIUPLf+9OB2zoawO7BZ2GuoCUZgufd/ZPrzBR90EWMYkuti+o1Q8nA
         JoOWkFYbK6lc+dJzcECh+hHH1Yq+sRzKNg26egFwVb++nceSoUk3A6wvXD+RUlduY4mL
         /bPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780957725; x=1781562525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gX/mp9SJHUWlSmoLEXlEEj6nZQtwhCmJ71m3qpbTAE=;
        b=HdaKlIn7BaJQKYU/tpUBg7FG9ehbW7Zp1WvB5vn6W63DARxDX/qaUi35eUIgirZK/g
         pb4izN+XoALFTr4Y6XTXwpBcP2Z2KBq8UH+9qkgBBdsIJXzHtECewkSamx7IruXKLTFH
         5W0G/3FiXuoAfTyKEjX5EVZqH8YdEnIQf2U38uiq48yCTz9cNN/42AhzRiP3xrvcbYsa
         cYZ/a3g6R9A458ocDysmk14q8CLE2L4+REI5eQpsrTkAWOWeqUD6tiYGC7wC19Lc5iT4
         ixsKwvJUi/jMxwLC6UxXOog4j9FSD8UURhS76KKUEC4VwxiIhhONlIAEXswLyGRa3Vix
         2YqQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bFLJw1S8Qzth0rdgmbZVYGM1mhw+tyTyQeG8RNBhfXFWR/GhM4lKuELmnT+kRe6rFCTRiVeFnSLpRowj3EQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVhY1NzIXaNTh/8taQX0861kbCZaKI2E/Vge2ABDrhS1oZBz0A
	K+0TB0mYSOo5bmifmJpoh3Pk8FM/+vY2r1zMDGiMjcGiBEG9ob2wbIomAwfTL91dwlw=
X-Gm-Gg: Acq92OGE3KzSRyzwcNnl51QIrD6/tqI3mlhnN47HxtBkbofLSUWhbUHPFlOsUeDNglY
	pOYWLz/ck5oqkxVLAkLvQV//8Oow4plIC77tt1t310AQq3sxMrpg5TEoK4XCu5bvoBgREcei0a4
	d9nUw1drRBOOu9ngiSONrVJQNR9yjCrByQ7ndV3uSQgSckwj0lkUo5C0op2hfW7jaoCEv29laKW
	KlNQIKwcLeINYcbgXHg6dFQ8P5LOhsJk4PyeOmTELkTK5lFS+6Hm1Ye1NFt3o6v5m+jvNOdpF7y
	fUaB62TWLZXq2c2OjXcmwKsKbDJi8pRvsZWzq6PqHHEweKgBNHRwsmCkoBq5LcAZ4vVe3brJacK
	gvtZeFvMksf7hxeZXTvZuNziRMeI/8VjP5tgQFrRUiACj9I95C+GGPDEJXh5FjguyZB5/o5wz9Q
	wjOI1QdpuqSXExnD844Q3YlqjwrY3zzsP3lSUAe4Ii3BskOAO/Tj1RF0CpYOj7jHIohLfYRstl3
	6byhRfxicWTss4WUQ==
X-Received: by 2002:a05:620a:454b:b0:915:a953:4b9c with SMTP id af79cd13be357-915a9c3659dmr2911955885a.3.1780957725130;
        Mon, 08 Jun 2026 15:28:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c645sm1828519985a.30.2026.06.08.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:28:44 -0700 (PDT)
Date: Mon, 8 Jun 2026 18:28:42 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <aidCGkafm9yUDTuf@gourry-fedora-PF4VCD3F>
References: <aiaUDTeHDA45ZXFS@lucifer>
 <aiagMc9Ng_AE_adh@lucifer>
 <aia93IzhTgi1vGi6@casper.infradead.org>
 <aicfERTP3H6AndOs@gourry-fedora-PF4VCD3F>
 <D1CF67EF-2CF1-45F8-9265-70A528C1CB01@nvidia.com>
 <20260608163257-mutt-send-email-mst@kernel.org>
 <BD0C8760-BC10-4BF0-9EE3-9B0DAF0D977A@nvidia.com>
 <20260608170348-mutt-send-email-mst@kernel.org>
 <DD2E08E8-1FD7-43E3-A2C8-B4435D3773D1@nvidia.com>
 <afb14c99-162c-4c36-b1ef-fe971678f6b9@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb14c99-162c-4c36-b1ef-fe971678f6b9@kernel.org>

On Mon, Jun 08, 2026 at 11:51:47PM +0200, David Hildenbrand (Arm) wrote:
> On 6/8/26 23:16, Zi Yan wrote:
> 
> There was Willy's comment in RFC v3 [1], which had 19 patches. Unfortunately, he
> no longer followed up to my initial push back and Michael's question later [2].
> 
> That would have probably been the right time to wait for more discussion.
> 
> RFC v4 had 22 patches with little replies.
> v5 had 28 patches with little replies.
> v6 had 30 patches with no replies.
> v7 had 31 patches with little replies.
> v8 had 37 patches with no replies.
> 
> [1] https://lore.kernel.org/lkml/aeu5P1bZW3yEH54t@casper.infradead.org/
> [2] https://lore.kernel.org/lkml/20260426165330-mutt-send-email-mst@kernel.org/
>

Hm, rewinding on this back to v3 here:
https://lore.kernel.org/lkml/016cc5e5-044c-46c6-a668-200f90a64d85@kernel.org/

You said:

  ```
  Exactly, that's why I am saying that vma_alloc_folio() is the only
  external interface people should be using with a user address.
  ```

Going through the list of folio_zero_user references:

Called unconditionally if a folio is acquired:
   fs/hugetlbfs/inode.c:   folio_zero_user(folio, addr);
   mm/hugetlb.c:           folio_zero_user(folio, vmf->real_address);
   mm/memfd.c:             folio_zero_user(folio, 0);

Called when user_alloc_needs_zeroing() and charging passes:
   mm/huge_memory.c:       folio_zero_user(folio, addr);
   mm/memory.c:            folio_zero_user(folio, vmf->address);

No one outside mm/ should know about this interface at all.
Arguably none of these should know about this interface either.

The appropriate place for this logic appears to be:
    vma_alloc_folio
    alloc_hugetlb_folio
    alloc_hugetlb_folio_reserve

The reason to sink it into the post_alloc_hook is to let the buddy
decide whether the page actually needs to be zeroed (like the virtio
situation) based on PG_zeroed or whatever.

It seems like at a minimum moving the logic all the way into
post_alloc_hook lets us actually delete folio_zero_user() as a published
interface and move it entirely within page_alloc.c.

The catch is user_alloc_needs_zeroing() coming along with it.

~Gregory
