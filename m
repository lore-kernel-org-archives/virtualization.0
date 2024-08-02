Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2A216BE06
	for <virtualization@lists.linux.dev>; Fri,  2 Aug 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722618080; cv=none; b=TmtSlBzcE1VbNEANOaPgMmRBHfyB3RmuGNGkKRJzLAKcbqPIsamHCiZxU89oM8AETE8fipXZc+7JSdNR72MwOvE4gcsoTozg1dZ7akH+qJx86/297/hdScYTN6FLawz0q5GXTVJ+MpbWQZaSrsUGebex7EF5SKS/GBvzbpKw6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722618080; c=relaxed/simple;
	bh=PlUfNCqxVe9v+v7ZCfIJKFswC6CmaMtq9PjiV01p50s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hW8WrFGq6WlIhbzryoRb946xZQZ1vCkWg+jvx+We9hbYOdOC4U5/sV2/yX6MWZb7sLCEb7ULDnjKChxogLtOtRDAdVNB9sRVwq3qfDtprQD22fhhXy0V1YjEtGg9C9Qr2CcrRYeAnQs5/ACGxMdWU4YRr0j0JnGBpbzaoUK9uTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhe1jrVi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhe1jrVi"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3687fd09251so4354241f8f.0
        for <virtualization@lists.linux.dev>; Fri, 02 Aug 2024 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722618077; x=1723222877; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpcsgqmtuPo+pz6tWtSNKqkTo9JxSymPCppu91onA2Q=;
        b=Dhe1jrVivMmMtDS4voqwdRZ0OYaLqJBnPWG0CJokL53DGq/Zj385wwUNe37iRpMCC1
         iBG0c1yKGBG1UhI/wRRzp5Gn3XNycj0OG09dy3huE5Yxp+qNB0duwkUAMjH+vbPxGyHp
         hx5USxI8vcBxoIFLuW0rN/f97RN6S1fCUeOjRE/8ryCJE43qAjERZBr+wYDMLE2nCpZz
         SQzfeLrJYj5fh631+qMPBrboZI1gUpxTYFF6A5lK+4X8UeFUPKfg22S6/uTL8FDZTgiD
         7I85FEROgZH9KUlf++/kT2vqn1jNbytTlbPj3h+AG4YoPBfT6GZiFljO22I9bIQ/yrIB
         AksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722618077; x=1723222877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpcsgqmtuPo+pz6tWtSNKqkTo9JxSymPCppu91onA2Q=;
        b=M8emgGG2O+uSPKuZLQFD0uJt19vv/TDQE8yszIhpsdsy9qF1Nx7B/U33xrjTmfdANT
         jEbI9Fr+FXwFAQcQYuisIdP2JMX++k2fiAq2EbWOSEIVzo6SOo5lBxLJ4skf5IvVmETX
         z85Z2qGKLwPT3iq8w9khrtxgv6Z+InefBUksFhGzt1/tIVjTCWkoQRvOIeDhjB0gEhHd
         DC0dVZZixnXSUgs0jmYWmwGqa+N+UUeDlJmYKCEPMXpysvHHo5jJOUMfBkRjTUzJQOlM
         ziJpJzMZQvd7u7+tJcoQT11mVJPMyaNOomVVn7hLxWrMC1F/iVkjeLR7NQfogKSzPSHX
         kKOA==
X-Forwarded-Encrypted: i=1; AJvYcCVEiQu0ZfrzfseUNkPhlLBYc4WqWQ/lpehFomrZlCNdVrBcdqPz1vP8jUFWf8aHGSBk0J1Lywj8ZoPcleS2WKWBQ7UW2Enf2chD8/5EWmc=
X-Gm-Message-State: AOJu0YwSKyd4Et1COmSUGSUBlfpcF77B0SqgipcTk/5+UAlh94anwMdQ
	osYQnFBq870PcubLf/wznZXMQ9HTl9GcVRaDu+E11sDgCDQAc8PH0JRkIweV6Pz9yr6AIGgT2IU
	ytpkDXFaE6LrUHfIC7TzmBp8fy24=
X-Google-Smtp-Source: AGHT+IH75FU4JpBvhRKVqmFn8me2clEuJ7/a5V8Xhv6OElYPF/ofyi1s2L5ZzsGAeeZuvfLRALy59I0v9WsGM6Mhk90=
X-Received: by 2002:adf:e98a:0:b0:368:4d33:9aac with SMTP id
 ffacd0b85a97d-36bbc0fc757mr2416504f8f.31.1722618076415; Fri, 02 Aug 2024
 10:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com> <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
 <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com> <CAKgT0UcuGj8wvC87=A+hkarRupfhjGM0BPzLUT2AJc8Ovg_TFg@mail.gmail.com>
 <877efebe-f316-4192-aada-dd2657b74125@huawei.com>
In-Reply-To: <877efebe-f316-4192-aada-dd2657b74125@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 2 Aug 2024 10:00:39 -0700
Message-ID: <CAKgT0UfUkqR2TJQt6cSEdANNxQEOkjGqpPXhaXmrrxB0KwXmEQ@mail.gmail.com>
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

On Fri, Aug 2, 2024 at 3:05=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/8/1 23:21, Alexander Duyck wrote:
> > On Thu, Aug 1, 2024 at 6:01=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2024/8/1 2:13, Alexander Duyck wrote:
> >>> On Wed, Jul 31, 2024 at 5:50=E2=80=AFAM Yunsheng Lin <linyunsheng@hua=
wei.com> wrote:
> >>>>
> >>>> Currently the page_frag API is returning 'virtual address'
> >>>> or 'va' when allocing and expecting 'virtual address' or
> >>>> 'va' as input when freeing.
> >>>>
> >>>> As we are about to support new use cases that the caller
> >>>> need to deal with 'struct page' or need to deal with both
> >>>> 'va' and 'struct page'. In order to differentiate the API
> >>>> handling between 'va' and 'struct page', add '_va' suffix
> >>>> to the corresponding API mirroring the page_pool_alloc_va()
> >>>> API of the page_pool. So that callers expecting to deal with
> >>>> va, page or both va and page may call page_frag_alloc_va*,
> >>>> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
> >>>>
> >>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >>>> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >>>
> >>> I am naking this patch. It is a pointless rename that is just going t=
o
> >>> obfuscate the git history for these callers.
> >>
> >> I responded to your above similar comment in v2, and then responded mo=
re
> >> detailedly in v11, both got not direct responding, it would be good to
> >> have more concrete feedback here instead of abstract argument.
> >>
> >> https://lore.kernel.org/all/74e7259a-c462-e3c1-73ac-8e3f49fb80b8@huawe=
i.com/
> >> https://lore.kernel.org/all/11187fe4-9419-4341-97b5-6dad7583b5b6@huawe=
i.com/
> >
> > I will make this much more understandable. This patch is one of the
> > ones that will permanently block this set in my opinion. As such I
> > will never ack this patch as I see no benefit to it. Arguing with me
> > on this is moot as you aren't going to change my mind, and I don't
> > have all day to argue back and forth with you on every single patch.
>
> Let's move on to more specific technical discussion then.
>
> >
> > As far as your API extension and naming maybe you should look like
> > something like bio_vec and borrow the naming from that since that is
> > essentially what you are passing back and forth is essentially that
> > instead of a page frag which is normally a virtual address.
>
> I thought about adding something like bio_vec before, but I am not sure
> what you have in mind is somthing like I considered before?
> Let's say that we reuse bio_vec like something below for the new APIs:
>
> struct bio_vec {
>         struct page     *bv_page;
>         void            *va;
>         unsigned int    bv_len;
>         unsigned int    bv_offset;
> };

I wasn't suggesting changing the bio_vec. I was suggesting that be
what you pass as a pointer reference instead of the offset. Basically
your use case is mostly just for populating bio_vec style structures
anyway.

> It seems we have the below options for the new API:
>
> option 1, it seems like a better option from API naming point of view, bu=
t
> it needs to return a bio_vec pointer to the caller, it seems we need to h=
ave
> extra space for the pointer, I am not sure how we can avoid the memory wa=
ste
> for sk_page_frag() case in patch 12:
> struct bio_vec *page_frag_alloc_bio(struct page_frag_cache *nc,
>                                     unsigned int fragsz, gfp_t gfp_mask);
>
> option 2, it need both the caller and callee to have a its own local spac=
e
> for 'struct bio_vec ', I am not sure if passing the content instead of
> the pointer of a struct through the function returning is the common patt=
ern
> and if it has any performance impact yet:
> struct bio_vec page_frag_alloc_bio(struct page_frag_cache *nc,
>                                    unsigned int fragsz, gfp_t gfp_mask);
>
> option 3, the caller passes the pointer of 'struct bio_vec ' to the calle=
e,
> and page_frag_alloc_bio() fills in the data, I am not sure what is the po=
int
> of indirect using 'struct bio_vec ' instead of passing 'va' & 'fragsz' &
> 'offset' through pointers directly:
> bool page_frag_alloc_bio(struct page_frag_cache *nc,
>                          unsigned int fragsz, gfp_t gfp_mask, struct bio_=
vec *bio);
>
> If one of the above option is something in your mind? Yes, please be more=
 specific
> about which one is the prefer option, and why it is the prefer option tha=
n the one
> introduced in this patchset?
>
> If no, please be more specific what that is in your mind?

Option 3 is more or less what I had in mind. Basically you would
return an int to indicate any errors and you would be populating a
bio_vec during your allocation. In addition you would use the bio_vec
as a tracker of the actual fragsz so when you commit you are
committing with the fragsz as it was determined at the time of putting
the bio_vec together so you can theoretically catch things like if the
underlying offset had somehow changed from the time you setup the
allocation. It would fit well into your probe routines since they are
all essentially passing the page, offset, and fragsz throughout the
code.
