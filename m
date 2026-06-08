Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8031E85C
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954435; cv=none; b=A+g8C3liw0TIq2K1eNs6fKU+HOlgRITFFBvPIECqiAkWYPT5xvaMn/UthLtTXTbrgSLR9NN+wX0dJMxx2O2++f/1EsvQeLybDXoAyESouhdavp0ocT5onRJKUIhx2SZRpltdah4SrPtGDffWRBpZ6a2MHZm2tS6AXjLcqstted4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954435; c=relaxed/simple;
	bh=uszGO4MNZllLL/tNWFtSqCfpuTZq+zRrEO2na9inYgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9WBRioWfV0+BVczoBSwmaXdeapIhFafGI+c42VhfEwzeQQu1TXCTTCOL6TbnjtsEIABAoMMCa7r1zkeyKAPUT40FbrihaP9DO8ES1F7mc0IWVBLbsIN3KFuShDEXGaqF0iEthJwitb45djRHNlbxgyaLAzDek1hn1TZa+I8Uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=A4XymM6J; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="A4XymM6J"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9159da9bba5so348515085a.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780954434; x=1781559234; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgdwZVogUbainy7/Unrt+E9dpZacJHCnboYcy2jriXI=;
        b=A4XymM6JRnCoUgIqvqB6opIb6VcKCFCSLeGIWpRxPhYe8Ti1Oqo0cTkLjDh9w73qe/
         7F/C6Ox/+LCOzTppGqeEmrmocb4xScbO/c0CdjCIzUNHbY43gSJlIoTjOX8N3YJ5J6g6
         0XEoGaDySPvucZsJwC0xoCSowpytRR7Mv56QJcCuVMOy9X4Hg2Xbhm7cIr614ni5hGOB
         zChdBC6k9Xw6DjzDkITUMvaBF57xCDH/F5h26rtTqwWXLC/sOyIFgzg2FCaZapX3347N
         KNOa7Pxx9g5KyFWgw0h5sLeqtepm9YgkAUfF7N6SzPsmu9c622SDK3Jg4akkN62BTrUE
         +Bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780954434; x=1781559234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgdwZVogUbainy7/Unrt+E9dpZacJHCnboYcy2jriXI=;
        b=LW4aC7zrPOjSE8YO6CKPZfjzmkDMgl7fyG46VEsM33eQOLNR8PV+D6LzV92ioiPTZ2
         oYeKnLemFOiUX8CXr0jA3GYQgbiS8qkpo/p8opbgi9IcI9G0kItHFUxBCIjZqDewFZQU
         kLK6k6coJ3vFVm+B6Dz+chy0Dpb0kyA9c/tSL8OYOopTUMqUVEG0fOflIbZidzNpbiPc
         Nq0T0Ok2kRwX6/EluQsvB6VJxbJ+b8Be9X1Ny0OWFMIUddIFNEY18IK+EvWYcyVvPfi3
         7k9dG1A87SR4Xk/mx+sjTGdn2ii/DQM/dE1z9TolFTm0O5yBuCFhB5HI7QPbl4ExZHKX
         Ynuw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZY9hJQOIKokROpw+lm8RbCpxBkADdARhzRFlvbYlLQvtp6XcvPJLsa/mqaxNH+r2su9rAFQ4J4O+qmniMcg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+JGxaKo/NXUmc8G21eO8qM50XDcbqmBCtRh47OGBtLw0Lip9/
	Nw4c/wLQt/bsiZM5qrYtXEvEkdrfqNhOGt1Y3TwYrLKui6eSu/4S56B84BbqsLKIa0Q=
X-Gm-Gg: Acq92OH9O7uS6SrEvI7Kqv0AQn+qct93l+5uCjBpMB7t01lqVvnGXO02lxeu8irbfN2
	Q9KHfD5RnQp8EaI15BCz+7GHOC6Y3VgBCHiJDV+Mp5NKaGh3pdo188sJb/+vAgnuLLOLCrmUSjD
	ThYfrs4XKHNDGH9eK3A7i7Oyn9KmlvGVp76ivUSUM9nE/G/hV1zXHzdxT+e1l5SFSdKPy2S1eMe
	2lPCa5LDeVF4G1eTHiFXT1uVmdB/CXgsrFdfQX7YUM1JhSxihKAKCWhKIRw9sQ5kVR/QR9tbpJA
	dSR7Td/hltisdnYDP7eW1l4RURhFii1e5hL2arO0rUsjnA9M/D9jSSZbBCuNiU7Z17hdkUDGzDT
	BtDeS6ITQASYijnwzYZJG0GUTaLQfZpvG3zge+NHJAxZiZ8rnxvunf5VeIhGx5sfTt8qwUIgXYb
	Y/lbbEBzVYhsa26QiXYLeNdtxVDKNLGd4hhiPahihKkBC4BcooCiIadkS04tFS7nkcqJ6UXFAxM
	2vUhxVXey1OoGStiw==
X-Received: by 2002:a05:620a:2589:b0:915:5576:df09 with SMTP id af79cd13be357-915a9c25802mr2949853985a.3.1780954433560;
        Mon, 08 Jun 2026 14:33:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915a6935cd8sm1467977385a.21.2026.06.08.14.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:33:53 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:33:50 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
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
Message-ID: <aic1PoxSiHzZ40Jr@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
 <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
 <20260608154354-mutt-send-email-mst@kernel.org>
 <aicjNRrHYOOBt0Hx@gourry-fedora-PF4VCD3F>
 <20260608161810-mutt-send-email-mst@kernel.org>
 <aicruns_4nOx0hD-@gourry-fedora-PF4VCD3F>
 <20260608170646-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608170646-mutt-send-email-mst@kernel.org>

On Mon, Jun 08, 2026 at 05:16:53PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 08, 2026 at 04:53:14PM -0400, Gregory Price wrote:
> > 
> > As a start:
> > 
> >   1) the user_addr and zeroing piece seems like a discrete
> >      improvement worthy of its own set - aside from end goal.
> > 
> >      This is needed by your patch set, but was requested to
> >      try to push us towards a more reasonable pattern for
> >      folio_zero_user().
> 
> What I worry about is people can't agree what api they want.
>

Oh that's just our base state of existence.  We mostly agree that
all APIs are bad in some way and we don't want any of them :P

What you're looking for is to get people to agree to the
least-offensive, least-worst option :]

I don't think we're far off from that.  I suggest doing as Zi said and
start a [DISCUSSION] thread on specifically this and lay out the needs
and wants and design issues that you've learned from the past set of
versions and continue the discussion there.

It helps to take some snippets from your set to lay out what you've
learned and explain why you need the folio_user_zero() stuff to get from
A->Z, and then let maintainers hash out whether that should live in
post_alloc_hook or new interfaces (or outside page_alloc.c altogether).

> I don't mind trying all kind of approaches, but it seems to
> be past the point where people feel it's costing too much of
> their time with all of these revisions.
> 

People are still commenting, so I don't think you've gotten there yet.
I think the rate of revision is what's costing too much attention.

You'd save yourself some revisions by taking the attention you have
right now and starting the discussion thread (and consider submitting
the topic to LPC if that's something interests you!).

All this is to say you're doing fine, just keep on keepin' on. Maybe
pivot your approach from iterations to discussion for a bit until the
opinions settle.

~Gregory
