Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8698D34BA52
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263543; cv=none; b=d2K776Tg8vnSLTj04+DG+Gu3J91b4SUF0RU6csjoyXFD8ptmZI+eiPXf2kyY5irOfm2pspmItlSuzHxtbUrZyQBcK76sjqEd9O0csvv783/uVTacYk8J7vV8mUbBtICH7xtjOgixxemuTWVGgMQCHQunGrmw3qBMnSYuqKiQdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263543; c=relaxed/simple;
	bh=N0k6TtKDKDUQdywtF92TG2uJQGKv4E4BiGc9AuGCHpc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=sErMzjvdqYuWBbGX2MJUfhxdtATBMLow2p63a1cZPeUdjuSurb+HaoA2IrR1wlgNWTVMx+/21kmYZp8XoGGRsETYAo+ccKTYhYncQ/R+A3qKdig9/XvW56EGo+NCOXq2VfFVL3YCiJiNBWQFPT9D8G4UWTK+ts0nwItd4qQNwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EZgFZGq8; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EZgFZGq8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758263537; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=68aueCoPAROVNtONYC1RBAOYPfFMaSkaWVtDp3qJFMM=;
	b=EZgFZGq84aM6z8fPVodUDI5lZaHuhqjAm97xfPzR9ZL5WadeulBW89nEgeCxZWFJ2SY3rDl7YyVHdou+ur4pjsWZO3SkJjU++yiiu0I96Y42DBuAOy+fmUd4sz8ZDu8R9LBI7Ogf1lC79MQzDZCIguSZUy4I0vQr453rrjtgN7g=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WoIp-ay_1758263536 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 14:32:17 +0800
Message-ID: <1758263409.2668645-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio-net: fix incorrect flags recording in big mode
Date: Fri, 19 Sep 2025 14:30:09 +0800
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
 Heng Qi <hengqi@linux.alibaba.com>,
 virtualization@lists.linux.dev
References: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
In-Reply-To: <CACGkMEscCsCf8RC-xQzfTNMp94Ty4wTrBgLkF50OAQ+yF8xD-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 19 Sep 2025 10:11:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Sep 19, 2025 at 9:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> > checksummed packets handling") is to record the flags in advance, as
> > their value may be overwritten in the XDP case. However, the flags
> > recorded under big mode are incorrect, because in big mode, the passed
> > buf does not point to the rx buffer, but rather to the page of the
> > submitted buffer. This commit fixes this issue.
> >
> > For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> > buf address when unmapping for small packets") fixed it.
> >
> > Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed pack=
ets handling")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 975bdc5dab84..6e6e74390955 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi=
, struct receive_queue *rq,
> >          */
> >         flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> >
> > -       if (vi->mergeable_rx_bufs)
> > +       if (vi->mergeable_rx_bufs) {
> >                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len, x=
dp_xmit,
> >                                         stats);
> > -       else if (vi->big_packets)
> > +       } else if (vi->big_packets) {
> > +               void *p;
> > +
> > +               p =3D page_address((struct page *)buf);
> > +               flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flag=
s;
> > +
>
> Patch looks good but a I have a nit:
>
> It looks better to move this above?
>
> if (vi->big_packets) {

This should be
	if (!vi->mergeable_rx_bufs && vi->big_packets)


>                void *p =3D page_address((struct page *)buf);
>                flags =3D ((struct virtio_net_common_hdr *)p)->hdr.flags;
> } else
>                flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;


I'm also torn between these two approaches. I am ok, if you prefer this.

Thanks



>
> To avoid twice the calculations and reuse the comment.
>
> >                 skb =3D receive_big(dev, vi, rq, buf, len, stats);
> > -       else
> > +       } else {
> >                 skb =3D receive_small(dev, vi, rq, buf, ctx, len, xdp_x=
mit, stats);
> > +       }
> >
> >         if (unlikely(!skb))
> >                 return;
> > --
> > 2.32.0.3.g01195cf9f
> >
>
> Thanks
>
>
