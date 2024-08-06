Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE31392
	for <virtualization@lists.linux.dev>; Tue,  6 Aug 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722905567; cv=none; b=tvhAfcm13Ge/C4jteMIEffBqx2wKvsSz30bhvbBazSQtY4J6pYZjvRtXXPY9AxYOchaTUpGIRCTCQnQc/CrQiAN5il/Iw1doPgUkDYDUfLRlIg5gWg/KBFo0gxJtEzLS25HSExBgxssvuPrO4inE362z6DEGmRF7TuNKqFel+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722905567; c=relaxed/simple;
	bh=+m+W3mwS74dhm5CTDy5Jd1SPhQMqockB2uEXAZSjECM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bET47Ry+SDJ51qQM8qdx9CZnYyXRaYtVKweZAglGvYkzLIlD8CU8g3Zzt6eIDGrT0phLqDyAVkv5QI9qiw89AMz0UB0UnmArPWcFFwXMGpquxqVQgzmtmrLXUmgPC81Ri8r9+0qeiQ6B+TIpU45EyN93zrQeJZEElg8WLxb+nrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqATgqEk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqATgqEk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso870395e9.3
        for <virtualization@lists.linux.dev>; Mon, 05 Aug 2024 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722905564; x=1723510364; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbMs5Emme3Wh6YV9L5YnP1YT4GqHd5pCxV5C0hflVMM=;
        b=KqATgqEkHkTAPLfdidT1MeKEhAJcilBUvoqEjKLwsLWEpsPll1K+EPM/R5Icn9DJTa
         xflCXZBhFZ1cNaOxIEsHTt2sF9NuBt5JSBVzngcLM/Hp1FudlS0jIHc+L9FViRMGLP+B
         /j0GcKkwI+nFmRY5mHTtUf7Z2n4Zo3f5swmLnP9I4Aysq58idxuplxVWy8EFT2Lvjs9W
         +ozUnMhGYExbPKBUoP5YnLEs2GOn5NMEH+OwjQChseaXlcfHm+7UbyB8DKDmgA8OalUn
         N4GKImhJKChkmgzNwAZliVNR/7XJcUzBq0vBVQxOt3DKWudCkzCc6G0hllbXWqFRK822
         Vp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722905564; x=1723510364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbMs5Emme3Wh6YV9L5YnP1YT4GqHd5pCxV5C0hflVMM=;
        b=UqVOP+soc1FK4R2NAO2+JPKWSD+sTG13l+S5gbLvGcEQ/4ZOsS2C+g4h56LBvVNwcy
         x/VKzqm6pCAMxrrtXceysxpOdj6zt4tdOOjl9hwSkedbPleykSWaRsxRXt++5X6sHBE8
         rPxxatj2fCvDkFCXRdoYomrpCZVjNORUWIaZfxbpZJv105sSQ9A4AN67PQ6fQjQWYybI
         MpTdbqWVgQG3089xaZPtpIJWGyp+iFFB/Q3yPaQUUp/E0zK1uuiHlzqgap9tQ4AwGlmr
         6db4VdrdTgHMDS5dogs1ka/nb18MtvHn8lkvZYZXjY0QvPMRgVRaht8IT6XLNkc/QMW1
         1jyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFk8dBZBavZwyn9T4aOlxlpuRZ5SLNETJqHnn3CYZmG+wv+9WKgR3zOqYn6vI3jthBPenFEK90ynv7M5bbMS0jQ3BeGpEqtaOdD4kJQtQ=
X-Gm-Message-State: AOJu0YygIoA60RHuf02RgzgYmrPZsKF3axlRsuXcMbBY56HRM8nsQMCC
	t7aFWHoY6gp4ylSk66m9SCHChsOAu3p2/Q7xc2usvpP1G2EFiHgHgxTlFAiiy6Slh3IijNVsZwL
	k9rl1cai6WBcvqFV4lAbAHgx1SDw=
X-Google-Smtp-Source: AGHT+IGqdqorrE2wlr/gRUXIf6uZerGtzKcZj5VR2LPXl0lkIPBaNlvbUHmQ57kNpAjkgdSFWmDjnDGMqxYFtJZpI1s=
X-Received: by 2002:a5d:6042:0:b0:368:7f8f:ca68 with SMTP id
 ffacd0b85a97d-36bbc117fd0mr8920631f8f.30.1722905564079; Mon, 05 Aug 2024
 17:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com> <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
 <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com> <CAKgT0UcuGj8wvC87=A+hkarRupfhjGM0BPzLUT2AJc8Ovg_TFg@mail.gmail.com>
 <877efebe-f316-4192-aada-dd2657b74125@huawei.com> <CAKgT0UfUkqR2TJQt6cSEdANNxQEOkjGqpPXhaXmrrxB0KwXmEQ@mail.gmail.com>
 <2a29ce61-7136-4b9b-9940-504228b10cba@gmail.com>
In-Reply-To: <2a29ce61-7136-4b9b-9940-504228b10cba@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Aug 2024 06:22:08 +0530
Message-ID: <CAKgT0Uc6yw4u5Tjw1i0cV=C_ph+A5w0b_mtQMXmnBfKN_vvaDA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

On Sun, Aug 4, 2024 at 10:00=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> On 8/3/2024 1:00 AM, Alexander Duyck wrote:
>
> >>
> >>>
> >>> As far as your API extension and naming maybe you should look like
> >>> something like bio_vec and borrow the naming from that since that is
> >>> essentially what you are passing back and forth is essentially that
> >>> instead of a page frag which is normally a virtual address.
> >>
> >> I thought about adding something like bio_vec before, but I am not sur=
e
> >> what you have in mind is somthing like I considered before?
> >> Let's say that we reuse bio_vec like something below for the new APIs:
> >>
> >> struct bio_vec {
> >>          struct page     *bv_page;
> >>          void            *va;
> >>          unsigned int    bv_len;
> >>          unsigned int    bv_offset;
> >> };
> >
> > I wasn't suggesting changing the bio_vec. I was suggesting that be
> > what you pass as a pointer reference instead of the offset. Basically
> > your use case is mostly just for populating bio_vec style structures
> > anyway.
>
> I wasn't trying/going to reuse/change bio_vec for page_frag, I was just
> having a hard time coming with a good new name for it.
> The best one I came up with is pfrag_vec, but I am not sure about the
> 'vec' as the "vec" portion of the name would suggest, iovec structures
> tend to come in arrays, mentioned in the below article:
> https://lwn.net/Articles/625077/
>
> Anther one is page_frag, which is currently in use.
>
> Or any better one in your mind?

I was suggesting using bio_vec, not some new structure. The general
idea is that almost all the values you are using are exposed by that
structure already in the case of the page based calls you were adding,
so it makes sense to use what is there rather than reinventing the
wheel.

> >
> >> It seems we have the below options for the new API:
> >>
> >> option 1, it seems like a better option from API naming point of view,=
 but
> >> it needs to return a bio_vec pointer to the caller, it seems we need t=
o have
> >> extra space for the pointer, I am not sure how we can avoid the memory=
 waste
> >> for sk_page_frag() case in patch 12:
> >> struct bio_vec *page_frag_alloc_bio(struct page_frag_cache *nc,
> >>                                      unsigned int fragsz, gfp_t gfp_ma=
sk);
> >>
> >> option 2, it need both the caller and callee to have a its own local s=
pace
> >> for 'struct bio_vec ', I am not sure if passing the content instead of
> >> the pointer of a struct through the function returning is the common p=
attern
> >> and if it has any performance impact yet:
> >> struct bio_vec page_frag_alloc_bio(struct page_frag_cache *nc,
> >>                                     unsigned int fragsz, gfp_t gfp_mas=
k);
> >>
> >> option 3, the caller passes the pointer of 'struct bio_vec ' to the ca=
llee,
> >> and page_frag_alloc_bio() fills in the data, I am not sure what is the=
 point
> >> of indirect using 'struct bio_vec ' instead of passing 'va' & 'fragsz'=
 &
> >> 'offset' through pointers directly:
> >> bool page_frag_alloc_bio(struct page_frag_cache *nc,
> >>                           unsigned int fragsz, gfp_t gfp_mask, struct =
bio_vec *bio);
> >>
> >> If one of the above option is something in your mind? Yes, please be m=
ore specific
> >> about which one is the prefer option, and why it is the prefer option =
than the one
> >> introduced in this patchset?
> >>
> >> If no, please be more specific what that is in your mind?
> >
> > Option 3 is more or less what I had in mind. Basically you would
> > return an int to indicate any errors and you would be populating a
> > bio_vec during your allocation. In addition you would use the bio_vec
>
> Actually using this new bio_vec style structures does not seem to solve
> the APIs naming issue this patch is trying to solve as my understanding,
> as the new struct is only about passing one pointer or multi-pointers
> from API naming perspective. It is part of the API naming, but not all
> of it.

I have no idea what you are talking about. The issue was you were
splitting things page_frag_alloc_va and page_frag_alloc_pg. Now it
would be page_frag_alloc and page_frag_alloc_bio or maybe
page_frag_fill_bio which would better explain what you are doing with
this function.

> > as a tracker of the actual fragsz so when you commit you are
> > committing with the fragsz as it was determined at the time of putting
> > the bio_vec together so you can theoretically catch things like if the
> > underlying offset had somehow changed from the time you setup the
>
> I think we might need a stronger argument than the above to use the new
> *vec thing other than the above debugging feature.
>
> I looked throught the bio_vec related info, and come along somewhat not
> really related, but really helpful "What=E2=80=99s all this get us" secti=
on:
> https://docs.kernel.org/block/biovecs.html
>
> So the question seems to be: what is this new struct for page_frag get
> us?
>
> Generally, I am argeed with the new struct thing if it does bring us
> something other than the above debugging feature. Otherwise we should
> avoid introducing a new thing which is hard to argue about its existent.

I don't want a new structure. I just want you to use the bio_vec for
spots where you are needing to use a page because you are populating a
bio_vec.

> > allocation. It would fit well into your probe routines since they are
> > all essentially passing the page, offset, and fragsz throughout the
> > code.
>
> For the current probe routines, the 'va' need to be passed, do you
> expect the 'va' to be passed by function return, double pointer, or
> new the *_vec pointer?

I would suggest doing so via the *_vec pointer. The problem as I see
it is that the existing code is exposing too much of the internals and
setting up the possibility for a system to get corrupted really
easily. At least if you are doing this with a bio_vec you can verify
that you have the correct page and offset before you move the offset
up by the length which should have been provided by the API in the
first place and not just guessed at based on what the fragsz was that
you requested.
