Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B57132139
	for <virtualization@lists.linux.dev>; Thu,  1 Aug 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525760; cv=none; b=gn9XprmJpJ6WjLMGNr4q/ooiiwBM+NrrTML30YuhpxDuVfkz0CPq/04oxObwMDiQSOPyFcq+ibgwCRkzFrZTKGGBxN5Z5diWAft4gtoW82s5wBOhi13WuSh32axwbb8a5GbQOOpYpEzau5y+NJ9IT5bZI9Ui8JIWRm2rHM7Py6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525760; c=relaxed/simple;
	bh=8Dx2Bv0d2od3Km7MjoXRYzhl1VfhP4WqwsY5gBZHcjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fE28F938iGfEfrdV3ayPQWECxkFMpXRpAzBGiKNtkYo9eJZ6Ygx5s6Th173Pm8FW1UIuKKQQs03VY0Fgmr5njGUiD0iRT58zM/xTkc7L4QU4GlknEXI+U33HdGZaZXYaR5/pCQcK+UhO5/D0mJr9wZop1sdijWtrEpjtc1d6J/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1GLlaw5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1GLlaw5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so6439315e9.2
        for <virtualization@lists.linux.dev>; Thu, 01 Aug 2024 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525756; x=1723130556; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Dx2Bv0d2od3Km7MjoXRYzhl1VfhP4WqwsY5gBZHcjc=;
        b=P1GLlaw5VSw7Apl5kxolmZdZ8amM5YSaOSIvrFPKIJ+IUFXMk54XzythQhwF8Nsst+
         /P3u9UPIfUcc5AMLI3l+6RW2wXgiWCzhglX7YRfYx3k6H3npSDgdRrMtfjMP+IUV4czF
         KpyB9k63lqAnpHbqM7KHTUf9CirXKNQkoPhgbb8Y6cLyCsYE6ANZ79vaOVNeBfSP3zGX
         DU5bMzScdcciCMhTLv68iiVbHtJJYHy9aQbWqwDv/iSGUOq0eFVXspS3MaGMLpwptz8R
         n7FzQ0H12o5xTm6H2O3GDr4stgYHm7htxPKxsGapDALrV/EaYiSE7NrTA+cpc2Ehtooo
         gKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525756; x=1723130556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Dx2Bv0d2od3Km7MjoXRYzhl1VfhP4WqwsY5gBZHcjc=;
        b=MRyx3NnqhZtERIdTyBiIM5Z70IjiKIx0fHiven9F6oIPrm7SWevQ89o6NFCg76t7ex
         Tk55h7bAy/P61kWgdr4XSZVrK5D6nPZoe8wzeLfIj+Q7wjmbdhuUxohG8O83moTbDtxz
         VTdoEWZcs8o3AnafFWbecmpw5MtBThCYCxb74O5p2QNF9QYLwP2faFxLtXdwxuHwPqCf
         XgjWunDk6RdXrPz9ZWj5+/u2p+6ZC/O6NajFkGZ1J87gPL50lp8GJeFAfJbU4CW6BDxt
         OurcgCQQGkEQcwB8+3lpssx8GtCIUl5P04/ZWkSmtWIv4Y/nFggZoqV40VJ3s2aUmYxV
         2o9w==
X-Forwarded-Encrypted: i=1; AJvYcCWHu1HFlJVJuOglfLdvcCYeY7SCqfa8M4y4zXcQmYNFruZh5sOYxEV/H1K4Im0lXNgxIxAkWHwSp3bgycf4eckAz7du1M7OrZz2xAVh0KA=
X-Gm-Message-State: AOJu0YwcxW4Du7P/47nJxD5rgUUgsAaEKDByDo/6vQyi5Z6kTxYdIqbc
	TyT0N/JcU3SrLtB2qZykrLAC2ptOO2xEjb68+85XfGajhX6APz2Y4DsE8g9ae1Hf071WS0P3Ood
	CEXNUmKn03AkRXgdjdlcf+rwvAyg=
X-Google-Smtp-Source: AGHT+IHJwpMJUuvVBDGd0+iVwndbV1UbEfs+MYBNb+0c/veShsqCR+fklPSjDi/gK00dEDB9UQYZf/nj06+15imHIwM=
X-Received: by 2002:adf:f14d:0:b0:368:4bc0:9211 with SMTP id
 ffacd0b85a97d-36bbc0f3459mr125871f8f.17.1722525756248; Thu, 01 Aug 2024
 08:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com> <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
 <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com>
In-Reply-To: <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Aug 2024 08:21:59 -0700
Message-ID: <CAKgT0UcuGj8wvC87=A+hkarRupfhjGM0BPzLUT2AJc8Ovg_TFg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, intel-wired-lan@lists.osuosl.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:01=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/8/1 2:13, Alexander Duyck wrote:
> > On Wed, Jul 31, 2024 at 5:50=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> Currently the page_frag API is returning 'virtual address'
> >> or 'va' when allocing and expecting 'virtual address' or
> >> 'va' as input when freeing.
> >>
> >> As we are about to support new use cases that the caller
> >> need to deal with 'struct page' or need to deal with both
> >> 'va' and 'struct page'. In order to differentiate the API
> >> handling between 'va' and 'struct page', add '_va' suffix
> >> to the corresponding API mirroring the page_pool_alloc_va()
> >> API of the page_pool. So that callers expecting to deal with
> >> va, page or both va and page may call page_frag_alloc_va*,
> >> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >
> > I am naking this patch. It is a pointless rename that is just going to
> > obfuscate the git history for these callers.
>
> I responded to your above similar comment in v2, and then responded more
> detailedly in v11, both got not direct responding, it would be good to
> have more concrete feedback here instead of abstract argument.
>
> https://lore.kernel.org/all/74e7259a-c462-e3c1-73ac-8e3f49fb80b8@huawei.c=
om/
> https://lore.kernel.org/all/11187fe4-9419-4341-97b5-6dad7583b5b6@huawei.c=
om/

I will make this much more understandable. This patch is one of the
ones that will permanently block this set in my opinion. As such I
will never ack this patch as I see no benefit to it. Arguing with me
on this is moot as you aren't going to change my mind, and I don't
have all day to argue back and forth with you on every single patch.

As far as your API extension and naming maybe you should look like
something like bio_vec and borrow the naming from that since that is
essentially what you are passing back and forth is essentially that
instead of a page frag which is normally a virtual address.
