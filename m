Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF53E63A8
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949818; cv=none; b=DrrFzErVHYXQmuppDhT+f20VfvwAxuKv04tYLGhVdMMitYaCXlTsHC2DcLLosM2mxXBjXMqSEpDUgb3jjFsiGEZZMGMZQGl3EO29SALXPHwBFQAcnySFL1nNAvaK7Fbg5m1I/4PzkVf7+r7o/3Eo0OFTFUuENk9u42Z+ekhf1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949818; c=relaxed/simple;
	bh=voJULOD6Bk4RPV8CLqcNAoUiGbKpXWPiJOWQF6KUr+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQYiIOdqwn2BL4jAvqHgTkaFa5U/GhoG3IGFalP2NqDCUZzmnwwp6c9Pm9m+nQEx6zXptj/XTxXKPm+h3qHTr5hX33n6w8Q3GfcIMDf99k33KlXXINrOZ3JOIL6DC0WLVlmfZvOLY0ZnxvDQ3ufpcFMc0vmrXHMALXu8BOpZzRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VHg3MTaF; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VHg3MTaF"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5176465a4a4so66164011cf.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 13:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780949816; x=1781554616; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5P0019yd+Yz79EK8psJPf72tTRfll1uVTKsf/rhDJ6c=;
        b=VHg3MTaFi6AYml9lhEwBOb8tMwjiKEyjTMdtuExTiRgmR2pDGZ0jb7VuPHBjaz5K48
         8L76Pb1UJ4Fzj/8d0oyTOWQx1zH0PSrCaKD7NyvzrCM2i8I0W5dn2U1xJuxxe/2Jx4ea
         lAatsb1cIkO5kftJ+eFvgIa4pZg4GlK2+3L9M3jMHIH71Nx3anITOe5P2IlqXXFHjoQI
         LlaZzo5J2U2ag80NHKRLF/8JnzTQOyo85L3UAVpFsHESkPx/pIohiOSmal4uaScqGHj/
         bWV1THRbYYT5+lxuucNETcNZnB0v6wGvCLeUEveEeH+piGRlutcu3z4yh/aJUhY1gBkS
         3sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780949816; x=1781554616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P0019yd+Yz79EK8psJPf72tTRfll1uVTKsf/rhDJ6c=;
        b=fuAKAJSifHFyYIxLUTvO5wF3DhuQr5ECX32roLmp/r05h3ptGZhjLjn64QVk1t7ZeB
         qY44ls6SohUSyYGKVpGzak4PwgZu114NMfRl6o2uvshN0sT41gzyB7er1QJZF59MtP0O
         1IkI/qphkOlQ72ByEzFobFaQKEAYbtNC9bmgqdRyyuO1BzaWdJPkMi3qq6HRGYXn/4KJ
         9yyPf0LS1hsMHRIreX7Vtf3oMax+u7uH4/EgdO29sGK2YVFJ0E/SSgKJNmUiYyAN67F4
         izB4kyTSxrJrQjBTBVaW4ulL4gK3+7qkeuER4mkuz+vSN1Qbb23J+e3ITPzWbY9X+ABI
         ybFA==
X-Forwarded-Encrypted: i=1; AFNElJ8sTjtK5S/jdvxW8doSeu348ZND8XOfc3kHawFiGh7ORGRHwBQOM5m0klPe4Ygy+nbF75ry4qqufPgyHRoLkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1la3zjUncWT5xZwi6//dKfm4xbmM6Xdscj4iOjOF7MiDvFpg5
	UcdD4LK3PhuuSDvj6tkTdq67bO7ROvpRyh5fCXPuCBR5vouykx7/Qjgmdi9Ai3OKwx8=
X-Gm-Gg: Acq92OG62H33W5EHfCeIwbj9IuMoK3BhzgHIuI8i3ROJSoldLImY+k3ikucqj5HkviY
	RkdCwLCPmw9WoDiPiXBiirBVdWKxZm6vcpuZTUudtu8eIYZTdyvcn4tF8euEFOzwznf8KF6zCvL
	k3OF8DRbw3y0esX3MRwbzlpRR/+WEDrIvsNOFgMSnathAZWrUM4DNfxT884San0/aWQrXUVQlD9
	fwFtZxHX5MJz8sgg3c7bRkSS7HsfwpMEwVX2tyxkmFQv7Yv2pa0HCESg4NBezu5MbeZlPf4+tCm
	nJXpbAbRWtg7LZBTjg4sDtOsorMVeW12ELdTApEd4BGdMiY9ZL2y0Xk8CDgJeXS7KG7KC3NStay
	6Lkj/eGeo8Owr1M18MPfjpmfQnTKW5Ov1O4Trc0YNzP4pwwbckr69GaTXelk6/IGEcMybJDrGqo
	Pj62Y9RIAFeIg4ZVwjmlDnVIsmefWV9umU9V4MCESZ4x8iJKI5B6c8nCvhdDdpbjBXcR5Xq1J5g
	tm8QSiHcP5dgaA7Hnj64dGCUCom
X-Received: by 2002:a05:622a:a6c4:b0:517:79f0:ae34 with SMTP id d75a77b69052e-51795bbfb19mr190530941cf.20.1780949815842;
        Mon, 08 Jun 2026 13:16:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c4648asm177764561cf.10.2026.06.08.13.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:16:55 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:16:53 -0400
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
Message-ID: <aicjNRrHYOOBt0Hx@gourry-fedora-PF4VCD3F>
References: <cover.1780906288.git.mst@redhat.com>
 <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
 <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
 <20260608154354-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608154354-mutt-send-email-mst@kernel.org>

On Mon, Jun 08, 2026 at 03:45:58PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 08, 2026 at 11:53:40AM -0400, Gregory Price wrote:
> > 
> > If `user_addr` is now implying anything other than exactly: "This needs
> > to be zeroed / caches flushed", then this is bad.
> > 
> > ~Gregory
> 
> Well if you do folio_zero_user in a non sleepable context then things
> are not going to work. So combining e.g. GFP_ATOMIC and GFP_ZERO and
> user_addr all together is not a good idea.
>

Can you say whether (GFP_ATOMIC | GFP_ZERO) w/o user_addr has the same
issue?  If not, then this subtle complexity is now a tripping hazard.

Is there some combination of arguments here that should just outright
fail if a user attempts it?

>
> You are saying it's bad? It's pretty fundamental to the idea of moving
> zeroing into the allocator, I feel.
> 

I'm saying having to infer that safety state from the cobbling of those
things together is not a good pattern (at least as-is).

If the introduction of user_addr into the mix is the thing that causes
us to have to infer safety, then there's an argument the page allocator
shouldn't handle that operation (in this case: user_addr cache flush).

Please consider that this is arguably the most fundamental interface in
in all of mm/.  All we're doing is going through the process of figuring
out what changes here are reasonable while trying to meet your goal.

~Gregory
