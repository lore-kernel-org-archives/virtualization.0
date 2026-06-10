Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AE23C503
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 22:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131450; cv=pass; b=SyQgG2e6fg7F2r6RpzZE/tC5KBDMqfjvfqcMoqmcnllLPdX3HxteCDNwzhORKPt/2qQRmeFSkoX80NVDOmOd+lrckltS8RUsr0frI0U1ouyB7g8pyARDHDAH0W8BDeWT9yWIdzeYOBsDERKJCVcswswOrif8F//Ovc4D4SXtJEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131450; c=relaxed/simple;
	bh=br20ZOx5+JfsJTf3ObD/E7biiXwgMeTM26yhtT8hmaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJhLZE6jNIhZ1EFbvNrkE556VPkw+jsw3I88bB0XL+135D0RG6GqDH0Y0AslcDReQkw7cD3Jbfop7En1FgRyKexRfZBlY8CzkNEhga6MNFf3+l7ypaZkEMcSqxfP3OI1VtVRyRpgS6njhIL1p9BJoINMWtb7GuHMNuVfRbBVd6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=DTn4EZZA; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="DTn4EZZA"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ce9d444173so87756946d6.2
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 15:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781131448; cv=none;
        d=google.com; s=arc-20240605;
        b=fg4gdFoI+OW+ZmdpHaZJGckG2gtzwFg2Js0nSKTVIj0tGgnJDW/OEqvxIeI8xL6nj2
         fAp/ITKWGWwSdjUOI6KplcVTNfQmmdSCFg+BtF1YMU0gDV8SXZjyItQcerWOnGMt/zqE
         DKOkReC5AMQYpezM0xX7ZqO/sysMZi7o9rfHuXA40qYAN8ocgok7H3FBvIy1pzI1YkjX
         wkRpvxpuVmhyAjxq2lyciaqlRi2xY+kS4U3BnF2+YCCY4VMELX3zF6Cu9H+12A2VjF0p
         KJlqc+3nIo9I9arhuPx6uml8kP1wOvtqOg+OsuEcvqLjONzH0ZC3HQcQaANbYOdiA2Lc
         Wasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H+9ItBe9lxcsMAXxEA8xORo0f4DOTn6OB37cmsN38zA=;
        fh=f8VRHiqQtJObnVMEuvTvae5c43P1moLmrjTFtfr/jbQ=;
        b=PoG58tNW7pVH16lOWekSVbjQjkqMZgfKPYEhOB/a8XHrymJKdwdvV4pLKUSMQib6Cz
         NfRppqvKWOmQvGLzotFk/IShiR98wNIv2mtfIAnaYRr+mlLqiP8Ipobyadgf4cIRvb46
         rOBySz/QUEDDLDsdUPENQMCwul/TgUqDsW+SJ8/Q0vBCcKPiBUIci93HtQergn4mfMqI
         mWKocSzwplkg4UdgN2AbJm1Jf/1yT4TWoGI75qQpkeVhEq7bfOQG7joBiA2BPlDI3UM8
         lrhEislT0qj1xHm9g7RsV3KiUQUE51yrV392lZMDy/NXJDAFwLkxRY46VwMbTDNsUrjU
         HMVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781131448; x=1781736248; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+9ItBe9lxcsMAXxEA8xORo0f4DOTn6OB37cmsN38zA=;
        b=DTn4EZZARw4vQFbexwQb6PSp93Lsj+WG3fuYU5bTX5EBXX/gd5KVMgTmInvIs6bt9e
         wAX6dmPrdE+xgB+zR1mXVy4mByeg4ROWmq1E0Ler2on11ye/swPEQSZae/LclYqs6lWC
         Hqa2WziGnXyW/bQNsWCaO1ynYkLOqC226JiJzEIVtkuJXXXfDcwQc/KYwznVx0lcAdx5
         BzoNmU7+cdw+AxK5q4wOhWA6SjVnlb76MCRm0irAFM3gNS1vFvlFzW3pxnY5Lh/+4eAj
         SToLpz3D4F76aWxOaQjUD7B21YwriOg4g1gQ1e7DXjqjPiKQGJBqFBX/rDasINsSE6jt
         vDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131448; x=1781736248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+9ItBe9lxcsMAXxEA8xORo0f4DOTn6OB37cmsN38zA=;
        b=BuOfX+rG9Gf8sAdAFzSyfRJNUoqDkfRUIBC4yvGbAtNOPQHNLWiT1Ei0nNJsunVi/w
         IM2uGGG0/aNuwHi6Dch54bLCd6GBNhNXNgf9pjBnr3B02I57T7Ghdeb/zcH1P1L/8EZD
         EfT7XZOqUloyCQlv7HcOjq5L39nuaFaRFpdM6GGxPa/IIDzW19lcltUQcqv6hRZaX375
         wvUsO1MFjXf03sZHMC9bMs6Nb3eGiAtMHvglaXO/EbeKoxuHayaFSQcJcw/YF8i6eptr
         O7uwvw5+azjplfN9Euyxp7pGv5jYYoFw2Qm0T0QUuOxz+fmE4fQMzH4dKiqiplsccaKi
         uMuA==
X-Forwarded-Encrypted: i=1; AFNElJ8c9uOrZyYFbKmU/VDSxKCTr012n6vrlLUyPxZjnZDLyOiX0cquUUKJ4sRjb1wiQXy/wQFqB2/KMROPeVwTfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6TEyQhpNBEFegDFePx98F9nj+fPC0fcZo4YpHLfLeZyT/Fd9j
	tmDY3GLdfq+x7Jk9473FDVX88KJbsNvlr7EjICaPpdtDEDroVHSyLu36GdiLkdTKCxTipxhZuJE
	9THQKBBlCxezh9NROa5e1COxEYPKoednytgIzfcJO
X-Gm-Gg: Acq92OG3SeJl+nHfEdjZlVGB0/Ym/e/VTDXve3yHRORDGEj/W7CCXBZPtvbMfFWMhGN
	w43C99DngrWQYmrE1Ix5h1G7jqLY7gCZ+7Lz9XsVgokJtUjNBUFDeRd75cOwNJMmF6Ky3LLGii7
	+l9p8Y0eelSpCLgDwJKIp/rrazaRM8yyap5rdw43eS0CEGwNzM5yQBv6oqovBuZpkUt0hD112nT
	h6jLXzInx4jjdZFvSTdwIZgHlHfR9cdC2Tqt+f29trGT8DUfOyw2I+jkE2QxLn5Mu4Pk4YTvXuB
	yxBM/hh9WtXLZCfIwD9PgeNK+5KPuJeMbQrQuhR7ILo2Ct60wOu4
X-Received: by 2002:a05:6214:2346:b0:8ac:7d43:f88d with SMTP id
 6a1803df08f44-8d1d4ce4492mr3920606d6.0.1781131448284; Wed, 10 Jun 2026
 15:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610221606.1091465-1-xmei5@asu.edu> <20260610181911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260610181911-mutt-send-email-mst@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 10 Jun 2026 15:43:56 -0700
X-Gm-Features: AVVi8Cf4mx5kl6MBvN9Gs2AR7WfDTm5JmMFtZi116xPgZJQCsmqqvhdrImRjBvw
Message-ID: <CAPpSM+RWNGnugK1+Oo53jsPXd5bTtf-NPzqW2UNo9Y0GQBs_sw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick reply. It comes faster than my reproduction email!

On Wed, Jun 10, 2026 at 3:22=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jun 10, 2026 at 03:16:06PM -0700, Xiang Mei wrote:
> > receive_big() bounds the device-announced length by
> > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> > add_recvbuf_big() sets sg[1] to start at offset
> > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> > check allows for the common hdr_len =3D=3D 12 case.
> >
> > A malicious virtio backend can announce a len in that gap.  page_to_skb=
()
> > then walks one frag past the page chain, storing a NULL page->private
> > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> > write past the static frag array and a NULL frag handed up the rx path.
> > Bound len by the size add_recvbuf_big() actually advertised.
> >
> > Fixes: 0c716703965f ("virtio-net: fix received length check in big pack=
ets")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Let's instead (or additionally?), bound the frags array index.
>
> Seems more robust.

Good call! I'll keep the length tightening in receive_big() and also
harden the page_to_skb() frag loop. So it can't index past
MAX_SKB_FRAGS or walk a NULL chain page, independent of what length
the caller validated. v2 will have both.

>
> > ---
> >  drivers/net/virtio_net.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..afe73eda1491 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_d=
evice *dev,
> >                                  struct virtnet_rq_stats *stats)
> >  {
> >       struct page *page =3D buf;
> > +     unsigned long max_len;
> >       struct sk_buff *skb;
> >
> >       /* Make sure that len does not exceed the size allocated in
> >        * add_recvbuf_big.
> >        */
> > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
> > +     max_len =3D vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_=
hdr)) +
> > +               vi->big_packets_num_skbfrags * PAGE_SIZE;
> > +     if (unlikely(len > max_len)) {
> >               pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> > -                      dev->name, len,
> > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +                      dev->name, len, max_len);
> >               goto err;
> >       }
> >
> > --
> > 2.43.0
>
