Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CB42AB0
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730872723; cv=none; b=MjUojgfrrmTN522QkeEN8+3gozduQXRKltGpvYKjeHmZhBlwo2fcnsHsPol1phJxVcAYtdvkZWKaEfvMBeHdv6uvim+sieU7/mYUCH811lGVMLvQToyQmpDTEogHjG4wN7OAfGLwXb4/TzRhBamyD+FQCFt82zTKuwU2uPf3+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730872723; c=relaxed/simple;
	bh=ZFPd4uY4qlGD1LwpVPc7EuzT70wT8MCerRNEpzP+EDo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=qdf03eT0ehrlul9mbT973uB58O3cRKr0GKcYw3zFBks8Le5dks1muhrtm3QQ2U/kaAFstOav0paXfY38S/nELuAL/CAoTCmmNswKUR+8o5i89w+7lhk3Y9yqlnsG72g2lbcCC2H9aROEotF4n4nwaWzCymIYIjdR+bxXSRK5Dm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fdCntpFZ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fdCntpFZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730872718; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=pHbSw6p5cNfpqXOlfIALTgliunUWQloTTpF6qs8iA1I=;
	b=fdCntpFZOeffL7+qmmEhOwJi95A9sdD0bCWkGh2CloWN6XXwTSiDaEv4yFNt9l6FO7OVKEeoHdar9PxoQxo2ju0aIm+/VWl77MRxq/w8+VxZVfwScqmMUvFA9AUy7VtfHFhYpbulV6epdaOqjLHqdyMedtHhttOUWBs+BFHo1w4=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIqALev_1730872715 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 13:58:36 +0800
Message-ID: <1730872686.808495-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for indirect buffers
Date: Wed, 6 Nov 2024 13:58:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
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
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
 <1730789499.0809722-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
In-Reply-To: <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 6 Nov 2024 09:44:39 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Nov 5, 2024 at 2:53=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> >
> > On Tue, 5 Nov 2024 11:42:09 +0800, Jason Wang <jasowang@redhat.com> wro=
te:
> > > On Wed, Oct 30, 2024 at 4:25=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > The subsequent commit needs to know whether every indirect buffer is
> > > > premapped or not. So we need to introduce an extra struct for every
> > > > indirect buffer to record this info.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 112 ++++++++++++++++---------------=
----
> > > >  1 file changed, 52 insertions(+), 60 deletions(-)
> > >
> > > Do we have a performance impact for this patch?
> > >
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 97590c201aa2..dca093744fe1 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -69,7 +69,11 @@
> > > >
> > > >  struct vring_desc_state_split {
> > > >         void *data;                     /* Data for callback. */
> > > > -       struct vring_desc *indir_desc;  /* Indirect descriptor, if =
any. */
> > > > +
> > > > +       /* Indirect extra table and desc table, if any. These two w=
ill be
> > > > +        * allocated together. So we won't stress more to the memor=
y allocator.
> > > > +        */
> > > > +       struct vring_desc *indir_desc;
> > >
> > > So it looks like we put a descriptor table after the extra table. Can
> > > this lead to more crossing page mappings for the indirect descriptors?
> > >
> > > If yes, it seems expensive so we probably need to make the descriptor
> > > table come first.
> >
> > No, the descriptors are before extra table.
>
> Well, you need then tweak the above comment, it said
>
> "Indirect extra table and desc table".
>
> > So, there is not performance impact.
> >
> >
> > >
> > > >  };
> > > >
>
> [...]
>
> > > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > > -               vring_unmap_one_split(vq, i);
> > > > +               vring_unmap_one_split(vq, &extra[i]);
> > >
> > > Not sure if I've asked this before. But this part seems to deserve an
> > > independent fix for -stable.
> >
> > What fix?
>
> I meant for hardening we need to check the flags stored in the extra
> instead of the descriptor itself as it could be mangled by the device.

I see, we can do it in future.

Thanks.


>
> Thanks
>
