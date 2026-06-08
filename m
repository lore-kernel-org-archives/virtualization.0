Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5839D6FA
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953426; cv=none; b=B7Ly5BUtoTKWZ6tqQ1Tig9JkTPMG9Rufw/UAtoh0bkpSK+abQer8NV51CP1AAe6IPq4fhmxQrzLlQHsPs9dXGZl0X9ZB6T6JCzk9GDJ8hWQKUVIwhT9oK94Bgq4t+xYlwxgfmOu9vJ8uNnWJTKmkUddNo06tyL5kgsOaQFYZmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953426; c=relaxed/simple;
	bh=WWbp4Q08+6LykO+kfjxwozipKHOwi/5G+PmFXyInhrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nwgo//hTXFV0KtcnMpqXsiusBBYKh766G/XjtKFESL2jtr9cAN97A0WGKtUGoI+5FrXYljBlEd30AUW5YGAqQqrAqhIPEp2FtVNVFVTKHmL34IIJbdk3wSBYpYZ6l/CpkuqpCRanuvyYHReRYL6VjRL6awvAcs2+PrbHKnZmNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdEBUr+p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdEBUr+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780953424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRdTTt1HwOOV0JRgBtySsMs51PNp1j0cJ53zgwnOjpA=;
	b=TdEBUr+pSSRY44zeVDUizBRQ7N5Xk3T1uL82HQn9dTtDE2oEACoUMS2CYi43UKFfmZ75VO
	BKvAQeGgvvWdgQawgHYpLfwFS1TJvQhoe6H/FyP3zBGT39PvB9IpiwG9BAeSpNLk0d6npi
	gzeZZyIeLXnV3/wNhFkPkgP7b/0ZvGQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-AQUoo7OONSS29dN1EQCciw-1; Mon, 08 Jun 2026 17:17:00 -0400
X-MC-Unique: AQUoo7OONSS29dN1EQCciw-1
X-Mimecast-MFC-AGG-ID: AQUoo7OONSS29dN1EQCciw_1780953419
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45eef10d5ebso2287630f8f.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 14:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780953419; x=1781558219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRdTTt1HwOOV0JRgBtySsMs51PNp1j0cJ53zgwnOjpA=;
        b=JacLsc+r97oOjS1wo4aSC4uW7zz9Uv1/R9SRaSSM+bhejj9LJWkSIVZPrG7qxl3LOB
         lOW63Y9KkzbDKJ4OA0VKLiXp1HvxgUdvBJPDOH2PlnSnRA7gq9HqDCDy3ccHtpTSk17I
         eBESJ839AvvE22MSrmZ16hyYez8z1kQw6UkA3bwWFIp1mvIp4BEjtJQtO+QVwz61Wp+b
         z3zUi6OsMpsKKc1DEr/oN8PRlVMOEEgKJh+uQ/JjfJlLn/EC84pkwlO5RyN2djFWdPp2
         1TbG5oNV/uOyJ8ioHWrzLyUcpTC1MpsAyy7wHjCJ/xlePDT64Z3fu2iLz0U5TuB29nS5
         HN4A==
X-Forwarded-Encrypted: i=1; AFNElJ/G1ysGuokEzLy8KFyO1oSPmidui3lpHb3DDc1AgfrdBnj6t7XpmWtGlTqaNrcMqEHQWmA12t1mmh/DLZqqlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzG5BywwVKzzhYNSmcTd6URqznUYw0qXUGEl9BCNnrqKnvO+Kca
	YmzBmTjZ3fU2wUi13YSC8o4Jc4zpFLom/0Uh8EegYLzSQxpqkpHatU6FOIkksndNEYVyuzNBezg
	ZERCneegYiwmDL0/umcQzJK6didqEgbdoU4LG/ZPLH7UGGjthWuA/QPpCBmHHsbboLErW
X-Gm-Gg: Acq92OE+yRAcXoSMTCXr4d/u89AphEAmYZjpTeVELUfSIgNGhhIrsBWqwr5ifsYTVzG
	fDAha7CuMXGaOILRbPRULgQeBRxOXe7mk9vNhvXaBSFDhN0gFtCtrwTp6xmOZLRzsNBkxkyk+lP
	e0pcPY3XaD9Sya+N76ymPz3t8sFMsRH0LlwgrPWTrxMSwEeo8lTVUji1+31zwT+ic6vy9CpT/dF
	ZImdt41bLwnICvlabuYHNBM45GL4WgMG3RXlpLGw/gBVMzcNA5GEmPCLJ5cKsPdCIsuZd0rbB/8
	NTiDaXE+Kj/2qIqqnTDmwTQysjhXynnNsYaiRlkBAASLMRK3VeFTrsGjXAEWRe3xdHvr+QFly5+
	MhXrVf4hOPPh8jl7kDRMnjyBaM5tGK4rfk7JaJDgTlrVBNSB7RFA94w==
X-Received: by 2002:a05:600c:4e09:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-490c259a003mr317354605e9.6.1780953419434;
        Mon, 08 Jun 2026 14:16:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4e09:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-490c259a003mr317353935e9.6.1780953418919;
        Mon, 08 Jun 2026 14:16:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm505952095e9.9.2026.06.08.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:16:58 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:16:53 -0400
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
Message-ID: <20260608170646-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
 <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
 <20260608154354-mutt-send-email-mst@kernel.org>
 <aicjNRrHYOOBt0Hx@gourry-fedora-PF4VCD3F>
 <20260608161810-mutt-send-email-mst@kernel.org>
 <aicruns_4nOx0hD-@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aicruns_4nOx0hD-@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RhLDoaBQvScDI3kCckfPQ_IxPl4-OiPe1A38L69FnYY_1780953419
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2026 at 04:53:14PM -0400, Gregory Price wrote:
> On Mon, Jun 08, 2026 at 04:30:46PM -0400, Michael S. Tsirkin wrote:
> > > 
> > > Please consider that this is arguably the most fundamental interface in
> > > in all of mm/.  All we're doing is going through the process of figuring
> > > out what changes here are reasonable while trying to meet your goal.
> > > 
> > > ~Gregory
> > 
> > I don't mind discarding all of this and doing something else completely,
> > but I dislike it that multiple people are apparently now angry that I
> 
> I wouldn't say anyone is angry, I think most folks are tripping on the
> complexity of the set - which has increased (at the request of others).
> 
> > don't address all the contradictory comments at the same time.
> 
> Such is life in mm/ :] - it's hard to known the entire state machine,
> and sometimes the contradictions aren't even wrong.
> 
> > I thought just sending a patchset to show how the result looks like
> > is easier than arguing about architecture, and would be helpful.
> > 
> 
> Notice: When folks argue implementation, they largely agree the
> end goal is useful.  I haven't seen anyone say your problem isn't
> real or that it shouldn't be addressed - just opinions on a particular
> path forward (which is utterly normal here).
> 
> Getting the right incantation of an API is really hard when the
> API being changes is something that underpins the entire kernel.
> 
> > I'm not pushing any of the mm rework, I was asked to do it,
> > myself I just want the ridiculously effective optimization in there.
> > 
> 
> As Lorenzo, David, and Matthew have said, the focus of the patch set
> does seem to have become unweildy (in part at the request of folks
> asking something be done differently).
> 
> What needs to be done now is to break it up into some pull-ahead 
> sets that are easier to review.  Having a brief RFC doc that lays out
> the set of patches might help clarify the confusion going on here,
> especially as new folks come in to ask "What's all this about?".
> 
> As a start:
> 
>   1) the user_addr and zeroing piece seems like a discrete
>      improvement worthy of its own set - aside from end goal.
> 
>      This is needed by your patch set, but was requested to
>      try to push us towards a more reasonable pattern for
>      folio_zero_user().

What I worry about is people can't agree what api they want.

Simply not being an mm maintainer, I don't really have the
perspective of what changes are envisioned down the road
and so what api makes sense for you guys.

I don't mind trying all kind of approaches, but it seems to
be past the point where people feel it's costing too much of
their time with all of these revisions.


>   2) There are a handful of patches that seem able to pull-ahead
>      (some of the mempolicy stuff), either as prep work for #1 or
>      just on their own.
> 
>      Some of these patches seem like latent bugs that aren't hit by
>      current users, but do seem to be doing something subtly wrong?

Right.

>   3) the final virtio piece seems like it should be entirely separate
>      once the core pieces are done.
> 
> It's not uncommon for core changes like this to take multiple prepatory
> sets over many major versions before the final feature lands.
> 
> ~Gregory

