Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CA2A1D3
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126289; cv=none; b=aJsrwRMf3F8IjWJrje3AD40wgwNd/uORorLtMYnOqU4YMofdrg7v5kcgUV3TmTSHvuMcyiKAtWH9tRyiHvwXFFVNLTMdXUFENu3BpSpGvhN/MWWwKrr5bkddzqblxLsmsaKBnpIshiw+Z6CdXHxyBE43i3ZeK9tkShLF3reZmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126289; c=relaxed/simple;
	bh=Qjd/2vEv6cDDhx4kT/W7J1TOl49DryW7hpUIRS+bdQI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=QJfvAdo/rJc23sGbGxS78Yo6brbJw7KjzWF8+4V3srgG1vnXihgDZ51ayGSbT6+QIws0mb6qHftR3GRgQmT0aRq5awd86gMhwJfSpyvu09qHGsXohYr+28k9Cm7GfLgotW+4g4GSQufb0/QqjZNMstaNV4oeN4r1EVngl3F3AsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=igidT5i6; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="igidT5i6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726126279; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=Gn7Rgru6zf1coeblHX+Gt/mTQByJxXbKoW7M8vaCPfo=;
	b=igidT5i6UZq4C9LB14NOvke4ljCX+nI/COuJ/Po6ZuOPIw1H1YtEt2xMxaB1zJ0k1HWG7Ex3bdPL24Eow6S+G1dHXkihcGEZq05ZvxUwz5dLYf8CHXVLZucIMuNlmMh06FnTRpV1kGLOKqQ+HMOVMZrFYeFZaPmQMkw66AAuZmA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEqceuJ_1726126278)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 15:31:18 +0800
Message-ID: <1726126234.0404134-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 02/13] virtio_ring: split: harden dma unmap for indirect
Date: Thu, 12 Sep 2024 15:30:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com>
 <20240820073330.9161-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
In-Reply-To: <CACGkMEuN6mFv2NjkA-NFBE2NCt0F1EW5Gk=X0dC4hz45Ns+jhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 11 Sep 2024 11:46:30 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > 1. this commit hardens dma unmap for indirect
>
> I think we need to explain why we need such hardening. For example
> indirect use stream mapping which is read-only from the device. So it
> looks to me like it doesn't require hardening by itself.
>
> > 2. the subsequent commit uses the struct extra to record whether the
> >    buffers need to be unmapped or not.
>
> It's better to explain why such a decision could not be implied with
> the existing metadata.
>
> >  So we need a struct extra for
> >    every desc, whatever it is indirect or not.
>
> If this is the real reason, we need to tweak the title.

YES. It is.

I will tweak the title in next version.


>
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 122 ++++++++++++++++-------------------
> >  1 file changed, 57 insertions(+), 65 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 228e9fbcba3f..582d2c05498a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -67,9 +67,16 @@
> >  #define LAST_ADD_TIME_INVALID(vq)
> >  #endif
> >
> > +struct vring_desc_extra {
> > +       dma_addr_t addr;                /* Descriptor DMA addr. */
> > +       u32 len;                        /* Descriptor length. */
> > +       u16 flags;                      /* Descriptor flags. */
> > +       u16 next;                       /* The next desc state in a lis=
t. */
> > +};
> > +
> >  struct vring_desc_state_split {
> >         void *data;                     /* Data for callback. */
> > -       struct vring_desc *indir_desc;  /* Indirect descriptor, if any.=
 */
> > +       struct vring_desc_extra *indir; /* Indirect descriptor, if any.=
 */
>
> Btw, it might be worth explaining that this will be allocated with an
> indirect descriptor table so we won't stress more to the memory
> allocator.

Will do.

Thanks.


>
> Thanks
>
>
