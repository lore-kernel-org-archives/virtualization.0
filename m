Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4667D2D634
	for <virtualization@lists.linux.dev>; Fri,  5 Jan 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJslTtRz"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso492010b3a.0
        for <virtualization@lists.linux.dev>; Fri, 05 Jan 2024 07:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704468936; x=1705073736; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LuFOrc8jZyA8aQFwg5Wcmjhl91YFITaxwbTd5b7XYqA=;
        b=CJslTtRzD+09by4y3Wh4IXL+FsdUJogRdAlx0/NOmXB4xLXjpsBhg2Tyqht0fJ3OeW
         hX0BFz/jOOQHHEPsp7r4ZLk0wHJ6zlr7/Tr7wz8J//5Uz0kNUtqmKzMvTq3niEqkE2y1
         g0BdlbIp7Iyzwg6itExHR6liyrmF3p7LYRA9MaQ0vbxcrzf5eA82eoQXZDrEKHzsLH4A
         MV/uQRmAyBXOEDJ2iA5xO6DfQYV0YEEf5p0a0Nh1ypirycK3TlOAPfYJaqoTKNi2CZuA
         4jw7wg84Y8J8ayYkkcwavgdprzYFWuEwa3rHPdE0PXkkVAOG/25ErTMlmNe69UIGyUOu
         5pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468936; x=1705073736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuFOrc8jZyA8aQFwg5Wcmjhl91YFITaxwbTd5b7XYqA=;
        b=iimnn3Yr2SVaH853CSH4uh7vGxZyg4xftfLKJLCrqHwto97UjrLrD95kg+A3IPT01Q
         MkLf78HrQ2S4kBYe/J1+Ebwvt/MuEWCqBNc9dAgagRtlQpB+4IBTCF0IhS16Vr1PCNZy
         UMLDbGRKeJWeOzCLwXU0YQcO02HU1zJSP3hQyM0RqlIgo5PzNWq2quEKsVm1CNHfAdS0
         e2T8qqzwQ2OkCIy2ISHYQcM0WRQpapl6G6O7FFZ4fyF2H7RWEMHOGQcXVixQIhfmye1D
         r9LquS8H/+8+FFsssrbzIAWlQnRYT5+RTkx4IVFvtb34uVn61G4DMUnushi+W7Uvchu+
         wVQQ==
X-Gm-Message-State: AOJu0YzIMDIxRNU6jQDK6BmyE9saaoKRnzQzkBkzEDaiE2qhaPIA4NuT
	/r0cpuqobX9YqXl8dcUBnVk=
X-Google-Smtp-Source: AGHT+IFf2OUiRiGgAY55SA0vjlNzy0JLVutkSWgDpb2/cc/7tt9nx67tojGCFEf8ku5WoiKMgNtQWw==
X-Received: by 2002:a62:5346:0:b0:6d9:b8fe:eee7 with SMTP id h67-20020a625346000000b006d9b8feeee7mr2864351pfb.8.1704468936510;
        Fri, 05 Jan 2024 07:35:36 -0800 (PST)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id l3-20020a62be03000000b006da13e27904sm1530638pff.44.2024.01.05.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:35:35 -0800 (PST)
Message-ID: <d4947ef05bca8525d04f9943e92b4e43ec82c583.camel@gmail.com>
Subject: Re: [PATCH net-next 2/6] page_frag: unify gfp bits for order 3 page
 allocation
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org
Date: Fri, 05 Jan 2024 07:35:34 -0800
In-Reply-To: <20240103095650.25769-3-linyunsheng@huawei.com>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
	 <20240103095650.25769-3-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
> Currently there seems to be three page frag implementions
> which all try to allocate order 3 page, if that fails, it
> then fail back to allocate order 0 page, and each of them
> all allow order 3 page allocation to fail under certain
> condition by using specific gfp bits.
>=20
> The gfp bits for order 3 page allocation are different
> between different implementation, __GFP_NOMEMALLOC is
> or'd to forbid access to emergency reserves memory for
> __page_frag_cache_refill(), but it is not or'd in other
> implementions, __GFP_DIRECT_RECLAIM is masked off to avoid
> direct reclaim in skb_page_frag_refill(), but it is not
> masked off in __page_frag_cache_refill().
>=20
> This patch unifies the gfp bits used between different
> implementions by or'ing __GFP_NOMEMALLOC and masking off
> __GFP_DIRECT_RECLAIM for order 3 page allocation to avoid
> possible pressure for mm.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> ---
>  drivers/vhost/net.c | 2 +-
>  mm/page_alloc.c     | 4 ++--
>  net/core/sock.c     | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..e574e21cc0ca 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -670,7 +670,7 @@ static bool vhost_net_page_frag_refill(struct vhost_n=
et *net, unsigned int sz,
>  		/* Avoid direct reclaim but allow kswapd to wake */
>  		pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
>  					  __GFP_COMP | __GFP_NOWARN |
> -					  __GFP_NORETRY,
> +					  __GFP_NORETRY | __GFP_NOMEMALLOC,
>  					  SKB_FRAG_PAGE_ORDER);
>  		if (likely(pfrag->page)) {
>  			pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9a16305cf985..1f0b36dd81b5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4693,8 +4693,8 @@ static struct page *__page_frag_cache_refill(struct=
 page_frag_cache *nc,
>  	gfp_t gfp =3D gfp_mask;
> =20
>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	gfp_mask |=3D __GFP_COMP | __GFP_NOWARN | __GFP_NORETRY |
> -		    __GFP_NOMEMALLOC;
> +	gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> +		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
>  	page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
>  				PAGE_FRAG_CACHE_MAX_ORDER);
>  	nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 446e945f736b..d643332c3ee5 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2900,7 +2900,7 @@ bool skb_page_frag_refill(unsigned int sz, struct p=
age_frag *pfrag, gfp_t gfp)
>  		/* Avoid direct reclaim but allow kswapd to wake */
>  		pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
>  					  __GFP_COMP | __GFP_NOWARN |
> -					  __GFP_NORETRY,
> +					  __GFP_NORETRY | __GFP_NOMEMALLOC,
>  					  SKB_FRAG_PAGE_ORDER);
>  		if (likely(pfrag->page)) {
>  			pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAGE_ORDER;

Looks fine to me.

One thing you may want to consider would be to place this all in an
inline function that could just consolidate all the code.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

