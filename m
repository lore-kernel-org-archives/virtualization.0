Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C13E6DD0
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947576; cv=none; b=YMkmCZ1tUudugLPWpVRYhZNqwOMsTF7qd0hg8GsSsaBUhLcEuUmOkCuZ4F9b9Hbgu3ApMEsAumqK45O7HPU7TBgBZecj37Wg22hI+rqkXdOnRE9+E4as3sPFy2XYiv7cfgdssu//BTucBcpNm0S93ydKMmqgMCvz08nV3ZUueEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947576; c=relaxed/simple;
	bh=skQdtmpohn7WRik717QBgGh9dXdmENEdeXodx+KKPB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=irHYv19yNwMDifZN8ze9pilj8g2V4ew/I7JnktLuY4L4myNFwk9/ToMOCejulb6FoNMIIM4VWyfsMOGYsNutO9kcIukHDNowfLiRbLUhckksIzBvFrQg83uwpialoiiv2Nzi43pEYxOhZwtLVxOLvL0/FcUJANn2THt65gnGAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkQwQOpL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkQwQOpL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780947573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojAM3itDn3ZymS70Vu5Gl5MXdODLh0QLR6qk02zjekw=;
	b=QkQwQOpL8hThwDf2gaf0hXONmcmROn4DAeNcTGWIY1UFWZay7jjpiLiVPrkBK5QArLAG/B
	2PnhGztr1LGqGi8RFltQNiSwyo53VIh7x6EtvDJYt5UE3/V6JXKFaX4oIv++6NJSbTySlM
	WHCSKDeGLwr/kssGZoQXhjwKpZaBR/M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-KwaUIqDKMDagFixBN4-ZIQ-1; Mon, 08 Jun 2026 15:39:30 -0400
X-MC-Unique: KwaUIqDKMDagFixBN4-ZIQ-1
X-Mimecast-MFC-AGG-ID: KwaUIqDKMDagFixBN4-ZIQ_1780947569
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-460198535bcso3034749f8f.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 12:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780947569; x=1781552369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojAM3itDn3ZymS70Vu5Gl5MXdODLh0QLR6qk02zjekw=;
        b=JSAAWpZh5qYMBQozA2g99LetPyGaqRjLBFcmlLBrNddhurUcCmJI2uR4x7CHaxfMAd
         fyblmOxIzH0R7coO+sKX0wJEq03Ke9kfRaAIrLRJjR/r7Cclipd8XlrHqbftYIlCJ558
         Dh/NJYFnXd2IZT83usXQJCWxZrbNi+cy5rL6+nNtsJZPQTKfJuKAbRkPZbdU4Aju0xev
         tSPyjNS0oZ4HRe8dfVoJ6QPzsqd+WHyEHjZfioKt7NT5VANdonT6c6ZOtUAs9puMBvpa
         i+OK/gyPaGCyqN2azW2tjVS5d9AFd+Ek2LE4Kc+DvyEE8ffslsAXCwXreMwwXEmiU6IQ
         OePg==
X-Forwarded-Encrypted: i=1; AFNElJ8vaUtdlcp5Pag4ZJaCTZ6WAgrw58HF/hSPCLjjNYiJo6uL/FBh1d2H4FXM9P9cCjj8Kn+MZeTi3Ao3tD/DIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfLEDP5wh78WHTdX/5H/73jDhPZPdvXH+DzbtfsKVYKJs1KLu3
	jWWJtTCj/MtG8SF50izyFx0wmJNC4PlqanZ/Thl9Z6pq4afdpBVrKdcUgRtN/qNLd+yx2G09S3z
	a3DwvlxAyri4UPB0UU/aekcHMIKmwt9R8b69NSWqx9g6UVR98qhS79RKiPbtnML+KOSv2
X-Gm-Gg: Acq92OEcATG6BWfXkP08DZDVn2NxxBZhecXZ2qfwlOPnzAoC3Ir7WWfZU8oI/vtoe0V
	t01kn7CIc7nxltADBA5z7C6xqfH0rqptZHORUoFaQV/S+6jLx7ydEjNFCCFY/UrhshzpvVec5Tp
	bqlhxR8pX+JFpHxv22ksMMV0uEPj3CiebwIyHVPQT4aBsW5xOUa0ii5izEa7iTnajiwobRrmYOT
	l8LZCvV4ekoiQ60m335O5JW0I2iWM/cdnZ7dHuKHFq7qDqS8wtDx5XKQajvwwCRtiRI/wigz7mA
	X5PwCJt60Poxe9b74bBlkxwJBpBvXofYNfB73DARSaeGamU5Hl5MDnbPa+PFOgLsM2oM49dsBtV
	SskNxY6ROkgj87igwdiNKuX44dLgeDbuJzCWTZ4gWBKQDjCwVkbRdlg==
X-Received: by 2002:a5d:4b41:0:b0:45e:f3b2:122a with SMTP id ffacd0b85a97d-46030652fcemr21261528f8f.26.1780947569302;
        Mon, 08 Jun 2026 12:39:29 -0700 (PDT)
X-Received: by 2002:a5d:4b41:0:b0:45e:f3b2:122a with SMTP id ffacd0b85a97d-46030652fcemr21261482f8f.26.1780947568821;
        Mon, 08 Jun 2026 12:39:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm56739949f8f.1.2026.06.08.12.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:39:28 -0700 (PDT)
Date: Mon, 8 Jun 2026 15:39:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Gregory Price <gourry@gourry.net>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: Re: [PATCH v10 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <20260608153600-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <8d5d2fa3-a60c-4d04-b3bf-7a8fe89cb1a0@kernel.org>
 <e54f9b79-b6b4-4911-86ac-48b61889765a@kernel.org>
 <aibjjsoeEcvXobCw@gourry-fedora-PF4VCD3F>
 <aib9QIGIn8f4W6RM@lucifer>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aib9QIGIn8f4W6RM@lucifer>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fr3X9nPwU7HT8TW5QC1ey2ul5SsNHKXfPGZF5DM8cpU_1780947569
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 06:50:46PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 08, 2026 at 11:45:18AM -0400, Gregory Price wrote:
> > On Mon, Jun 08, 2026 at 01:13:42PM +0200, Vlastimil Babka (SUSE) wrote:
> > > On 6/8/26 13:02, Vlastimil Babka (SUSE) wrote:
> > > > On 6/8/26 10:33, Michael S. Tsirkin wrote:
> > > >> Further, on architectures with aliasing caches, upstream with init_on_alloc
> > > >
> > > > It seems those are niche architectures so we can ignore that part for perf
> > > > purposes; the other reason why user_alloc_needs_zeroing() would be true is
> > > > booting with init_on_alloc.
> > >
> > > OK I misread how user_alloc_needs_zeroing() works wrt init_on_alloc, as it's
> > > negated. But you're changing that anyway to skip that user zeroing, right?
> > >
> > > "
> > > This series eliminates that double-zeroing by moving the zeroing
> > > into the post_alloc_hook + propagating the "host
> > > already zeroed this page" information through the buddy allocator.
> > > "
> > >
> > > So relying on "everything in buddy is zeroed" would still work I'd think.
> > >
> >
> > This regresses for anything that previously didn't zero on free or
> > alloc, which is most kernel allocations.
> >
> > I think the scope of this set has increased too much based on early
> > feedback to fix the userland-initiated allocations piece along with the
> > balloon/reporting/double-zero piece.  That's making all of this
> > difficult to continue following.
> 
> Yeah I feel this is 3, 4 or 5 series put together, and there's a lot to
> discuss in each :) so it's pretty difficult to work with them all put
> together.
> 
> These need to be deferred/separated.

I can do that, it's just that the real performance benefits
only come with the last patches in the series.

If I send series that merely moves zeroing around, with
a bunch of threading of addresses and stuff to achieve that,
0 perf gain and slight degradation in corner cases like memcg
failures, you feel it will be well received? You guys really
want to do that, independently of the rest?

Just making sure, I'm not the maintainer here.


> >
> > ~Gregory
> 
> Thanks, Lorenzo

