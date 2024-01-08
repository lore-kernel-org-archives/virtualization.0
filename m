Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CC524B7
	for <virtualization@lists.linux.dev>; Mon,  8 Jan 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnhD8Nai"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28cec7ae594so1752097a91.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jan 2024 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704730452; x=1705335252; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unjvTIPzqvEYfu9k31l2UbfWfPgY7ha+9toKsyi5Vr8=;
        b=jnhD8NaipB9SNmv29EEgCyIbnyIAdSqx+8Q3JC8yKUYGLO3FnUyBcMMl9J1FwGcjuB
         LXDucHQwSG52r+JMmcEIvHTDK2iSlJab0ktkA8etks8h7qXmDv1PXIRovy9YHWzSreoP
         +uXgplatWhe1pZzUEUo7FLcPhYrbx/Xf13zXHYyB5VeOYpBTpr+teozOWOoCuWMDIRsB
         bCCJ/V5FkZva4NgDBsH4d2YWUCLymjkUNb1Vj0ZaLUNlaEBf6v99I+qdbVmjy7/Tf/C7
         EBiGaABZLFdYUEpgvp6T3q3XMdzIYy4+NfJ3qSX1nYfeJmEm9lw1iFi4cZVYLpJUJ+Dp
         DBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704730452; x=1705335252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unjvTIPzqvEYfu9k31l2UbfWfPgY7ha+9toKsyi5Vr8=;
        b=h/d+VjDN1lT7oyYIPJbOmGhdpxzHwM84BAYZ5S+HuqUAn6mq4EXEz0dylUbtbY+Kg4
         engNPjXmLVb459nFEFcCy8GRJ6TxDgD8HriBpBD0Ly3v9+4zjUDZNHQ6DNcFDl0mhGvM
         akjUsEA54uJxaZk+PDgI8luH+Vt7EgMqrVgVyr7VzztdHT0OtLsiJZm92t3lUlkR9+I1
         /MQZ7/oqzU1rZeohfslRN74rcoGjPrNsoaoVdxfXVRP82z6zJxZeVElKsEGHC8EAZpJ1
         dqL5aArukTFmCKZxMpa35274GjM8r9i1cvcJ1r61kPJUA5GccB0V6daQ5by7yNcsORgB
         /THQ==
X-Gm-Message-State: AOJu0Yxap6YYm5epmGVMtUWjCV/TWbUWrlj27ci6dS1grgUYodQyYU/X
	z8hKkxx2x9wtMmuNA6V7PzJSJM9sHHT82o1NQRHTOwGB
X-Google-Smtp-Source: AGHT+IGGbd9uEm1HwzeQk0zSJgcIrych+A4ioq0XePO8wLwmpeqipVfchKXfctSdfiFT9SV1RSAuYB49yeFctZANvgM=
X-Received: by 2002:a17:90a:604e:b0:28d:19d3:8c58 with SMTP id
 h14-20020a17090a604e00b0028d19d38c58mr1670693pjm.73.1704730452552; Mon, 08
 Jan 2024 08:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240103095650.25769-1-linyunsheng@huawei.com>
 <20240103095650.25769-3-linyunsheng@huawei.com> <d4947ef05bca8525d04f9943e92b4e43ec82c583.camel@gmail.com>
 <1d40427d-78e3-ef40-a63f-206c0697bda2@huawei.com>
In-Reply-To: <1d40427d-78e3-ef40-a63f-206c0697bda2@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Jan 2024 08:13:35 -0800
Message-ID: <CAKgT0UdjsJPNLps+JFgjk89oyB9PDuMkw9pYuBg4ArnGh35Osg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] page_frag: unify gfp bits for order 3 page allocation
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:25=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/1/5 23:35, Alexander H Duyck wrote:
> > On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
> >> Currently there seems to be three page frag implementions
> >> which all try to allocate order 3 page, if that fails, it
> >> then fail back to allocate order 0 page, and each of them
> >> all allow order 3 page allocation to fail under certain
> >> condition by using specific gfp bits.
> >>
> >> The gfp bits for order 3 page allocation are different
> >> between different implementation, __GFP_NOMEMALLOC is
> >> or'd to forbid access to emergency reserves memory for
> >> __page_frag_cache_refill(), but it is not or'd in other
> >> implementions, __GFP_DIRECT_RECLAIM is masked off to avoid
> >> direct reclaim in skb_page_frag_refill(), but it is not
> >> masked off in __page_frag_cache_refill().
> >>
> >> This patch unifies the gfp bits used between different
> >> implementions by or'ing __GFP_NOMEMALLOC and masking off
> >> __GFP_DIRECT_RECLAIM for order 3 page allocation to avoid
> >> possible pressure for mm.
> >>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> ---
> >>  drivers/vhost/net.c | 2 +-
> >>  mm/page_alloc.c     | 4 ++--
> >>  net/core/sock.c     | 2 +-
> >>  3 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> >> index f2ed7167c848..e574e21cc0ca 100644
> >> --- a/drivers/vhost/net.c
> >> +++ b/drivers/vhost/net.c
> >> @@ -670,7 +670,7 @@ static bool vhost_net_page_frag_refill(struct vhos=
t_net *net, unsigned int sz,
> >>              /* Avoid direct reclaim but allow kswapd to wake */
> >>              pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM)=
 |
> >>                                        __GFP_COMP | __GFP_NOWARN |
> >> -                                      __GFP_NORETRY,
> >> +                                      __GFP_NORETRY | __GFP_NOMEMALLO=
C,
> >>                                        SKB_FRAG_PAGE_ORDER);
> >>              if (likely(pfrag->page)) {
> >>                      pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 9a16305cf985..1f0b36dd81b5 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -4693,8 +4693,8 @@ static struct page *__page_frag_cache_refill(str=
uct page_frag_cache *nc,
> >>      gfp_t gfp =3D gfp_mask;
> >>
> >>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >> -    gfp_mask |=3D __GFP_COMP | __GFP_NOWARN | __GFP_NORETRY |
> >> -                __GFP_NOMEMALLOC;
> >> +    gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
> >> +               __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> >>      page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> >>                              PAGE_FRAG_CACHE_MAX_ORDER);
> >>      nc->size =3D page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
> >> diff --git a/net/core/sock.c b/net/core/sock.c
> >> index 446e945f736b..d643332c3ee5 100644
> >> --- a/net/core/sock.c
> >> +++ b/net/core/sock.c
> >> @@ -2900,7 +2900,7 @@ bool skb_page_frag_refill(unsigned int sz, struc=
t page_frag *pfrag, gfp_t gfp)
> >>              /* Avoid direct reclaim but allow kswapd to wake */
> >>              pfrag->page =3D alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM)=
 |
> >>                                        __GFP_COMP | __GFP_NOWARN |
> >> -                                      __GFP_NORETRY,
> >> +                                      __GFP_NORETRY | __GFP_NOMEMALLO=
C,
> >>                                        SKB_FRAG_PAGE_ORDER);
> >>              if (likely(pfrag->page)) {
> >>                      pfrag->size =3D PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
> >
> > Looks fine to me.
> >
> > One thing you may want to consider would be to place this all in an
> > inline function that could just consolidate all the code.
>
> Do you think it is possible to further unify the implementations of the
> 'struct page_frag_cache' and 'struct page_frag', so adding a inline
> function for above is unnecessary?

Actually the skb_page_frag_refill seems to function more similarly to
how the Intel drivers do in terms of handling fragments. It is
basically slicing off pieces until either it runs out of them and
allocates a new one, or if the page reference count is one without
pre-allocating the references.

However, with that said many of the core bits are the same so it might
be possible to look at unifiying at least pieces of this. For example
the page_frag has the same first 3 members as the page_frag_cache so
it might be possible to look at refactoring things further to unify
more of the frag_refill logic.
