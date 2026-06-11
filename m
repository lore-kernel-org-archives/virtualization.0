Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADFB25A354
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145665; cv=none; b=hatpT3nsmBWon4ZPzZi+ZKsaexQIk2GGJ40NrS1SGo3NDI+RYtYOIEjkG4XapVPglxI0RHnvL9+OoHWan5Iyg/miEXPd8UZsu3GNNZpWE+qky0a1Un/A+K7XzK7aebdNZ7faAOGFXdQCjX/eMmUcMPa1CVYtXRSrorAdd2vUZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145665; c=relaxed/simple;
	bh=XMxl21juqOwu7ovEl6DADowLJ/SLFMJx0DTc2rKq0Gc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=gwg83RGcHx4RxMs1u0JTHJAk6FfJ9XEwecMlSyZ0u5yIuxfe1XPW0SsExNnyTDxB8RS8uHLCl+Z0aWhhH+WKEKp8vUJpTzkIuoLodpKnvsq3gQSFW4GfKBlsDDYX09FbF7bYH4eseq0yso1Ma1PzLlZW6/AoPN4UVd9yv0LrrJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mXPemDZl; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mXPemDZl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781145661; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=ha7BkfjaCY9/CYZC5+QJ/MJxoyTlbQ4TVcB5ZstAvSA=;
	b=mXPemDZlQW+0Ud9foG4/x+rMtjn910aw+avtsgqCg3jrmAN1gEjPVyszlKQlPUyuwieGCk2sp6vp0SSgznYFj788cqXOTDRuKH6F/CQ9Cul5VguuuEmXhXyEzdE91c+MZNcKGFp0A8NjdUCmfR3Mhc8V1zkjmdlrnNR24P4k9AQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4cF-VI_1781145660;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4cF-VI_1781145660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 10:41:00 +0800
Message-ID: <1781145615.903036-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet frag loop
Date: Thu, 11 Jun 2026 10:40:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 minhquangbui99@gmail.com,
 bestswngs@gmail.com,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20260610232936.1176094-1-xmei5@asu.edu>
 <20260610232936.1176094-2-xmei5@asu.edu>
 <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
 <CAPpSM+RApuYf3-ui15E+01fWEzUzfh6mgijQyT_+KjusMVxMfw@mail.gmail.com>
In-Reply-To: <CAPpSM+RApuYf3-ui15E+01fWEzUzfh6mgijQyT_+KjusMVxMfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 10 Jun 2026 19:24:03 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> Thanks for the review. I agree with that as I replied at the end of
> v1. If we obsolete 2/2 but keep 1/2, is it okay to just leave it as
> is?

You should post a new version.

Thanks.

>
> Xiang
>
> On Wed, Jun 10, 2026 at 7:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > > This is a robustness hardening patch. The slow-path frag loop in
> > > page_to_skb() walks the page chain via page->private until the
> > > device-reported len is consumed, implicitly trusting that len fits the
> > > chain. It does not stop when the chain is exhausted (page becomes NULL
> > > at the tail), nor when nr_frags reaches the end of the static
> > > skb_shinfo()->frags[MAX_SKB_FRAGS] array.
> > >
> > > Both bounds are needed: the chain length is big_packets_num_skbfrags =
+ 1
> > > pages, which for an MTU-driven configuration can be well below
> > > MAX_SKB_FRAGS, so neither guard implies the other.
> > >
> > > Make the loop self-defending so it no longer relies on the caller hav=
ing
> > > validated len: stop once the chain is exhausted, and never index past
> > > MAX_SKB_FRAGS. No functional change for well-formed input.
> >
> > At this point, we are assuming that len represents the correct packet l=
ength. If
> > there is a bug in the validation, it can be fixed, just like in your pr=
evious
> > patch. Indeed, not checking nr_frags is also based on the overall desig=
n.
> > However, I do not recommend adding this kind of enhancement. If we foll=
ow
> > this logic, we would end up adding similar code in many other places, w=
hich
> > doesn't make much sense.
> >
> > Thanks.
> >
> > >
> > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > ---
> > > v2: robustness patch
> > >
> > >  drivers/net/virtio_net.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index afe73eda1491..518c22fa1b68 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtne=
t_info *vi,
> > >       }
> > >
> > >       BUG_ON(offset >=3D PAGE_SIZE);
> > > -     while (len) {
> > > +     while (len && page) {
> > >               unsigned int frag_size =3D min((unsigned)PAGE_SIZE - of=
fset, len);
> > > +
> > > +             if (unlikely(skb_shinfo(skb)->nr_frags >=3D MAX_SKB_FRA=
GS))
> > > +                     break;
> > >               skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, o=
ffset,
> > >                               frag_size, truesize);
> > >               len -=3D frag_size;
> > > --
> > > 2.43.0
> > >
