Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E23CF1E1
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 05:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587251; cv=pass; b=lt8M9nlRS0sljEO50ESFY5L+YMXeRugYMcI3Zf432v1x4XG5omLNnc5dQV/xBPg/VUYpeUrYj/h/V5BM8tEJs3JEwZiaR7Gs68SCispekdR4Loli6AK8WI6eUcBXK06+kTCvNdY7ieAaFuoBl0xYIRVBHPsNZN8O5+utHOpntfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587251; c=relaxed/simple;
	bh=1pTesxFWXzYuQxgGfaOTCXBTp1da8jVGIAPtlmYLgsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHkBGqXprk6v2OI6mJ1qzQTWi0H5vLh0q6QR4U6rB2s6NuKu+F5Zw7/CLkC7435ExsxC/QEtqq4xTVMK65BR5MvOKD8cUGckcpBEeLBjN6DgyN/Z3H32TF+KviHnNzTZeDP1Ur+NXn1Qutiznyg1v89Vah7wYQw+IQc31RB0PPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=iGECtMD+; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="iGECtMD+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0b9328c4aso30265435ad.0
        for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 22:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781587249; cv=none;
        d=google.com; s=arc-20240605;
        b=DXxMWAezeuf+7gLHFv5oPfAI0BeYUFGeyPwYdppnF5DJecgQReYjDhcHms6tvdlJmZ
         m6gOrvYTyZ9ctK3P91G9HtvOldbewkCKcewe869YPa2y1joKKVXu1w1UuiAQz3D5mbIn
         SE6+VFeoahqV4XB3W2oJIxMh6zXhoTkHv3IRvMHMTwCyqQ863v6H/V/fwDKZ7BoLGfpb
         8kbtGfdTuDnZgR43BhczYlzdasntvH/93HbXh/+zie4PhGWA7mJU7VJU7+aaW2pDcfH6
         XhhYf+SGg+vVnxAeFzNZc38DU/e5iAJqzOnuC+NulpqEeCttIxzUVjoQTf3q2vBi9P7L
         OBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOBfkW3s2HtntFIC62qbBB3es6YF5T0ky4hO2DWBBro=;
        fh=iSkVAuR9skDX99uxznmN1TqUUQqNQj8kLdPc8ZCK1bM=;
        b=NaLelZ1M5KApc8hNBx2BHkCPMjAr8bwQSccaeMB8hACnUkBmAm/zYM/L2HNE5TUkir
         LR4LpC7S9Zc7JY/vgnOo57vJdl/Twek5MCIsAQ+jzHe5k61578JJc8HPJtFuEmZPJ6FX
         DA3zFTZadxrGlxgU/EjATW0T5ksnNk9+CRoRai/k9rAawxhqTh3HxDLardwM6jos3eXt
         7Vr9KWTgaS3giffm2qgVQZpRS7tX+zTvxF9cPlMkiE0r3sabuSgAy20nz8DvApJaXOrJ
         uq3G2Ve6AaRzJvzJbrBHn95WC85p/LN3k74fln28f9SSJgNZ/RAH9q+qSbBd5BthSSct
         79Lw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781587249; x=1782192049; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOBfkW3s2HtntFIC62qbBB3es6YF5T0ky4hO2DWBBro=;
        b=iGECtMD++WyZea/DYAvB2A+/OwjLxn7C/cC3T+EU8ZlzyrHe9Nc3KzdW2ckCmxEEot
         7+pe0WXJ8wKaQIu/F2I2U/nPKvZaI3Hv6o3ISQhAcHGodEaXQLz/dDTVngbRd0CUQCc6
         /qJXU9E7ol8u+xGXOFLmz+WLvSpWRZWd21ab2TqGYGHepigGZJN4OfPQ/uVAdKYKQCtY
         LOeiRDrm9nK0gB+Du8hKtpQOk+OrrWhhBjXLJ4m8WQcSwIiau140l68zWV2dDWD44jSa
         1ZUhvaCe7HkdxOhFhUBgArP3bA2k+O+Oj5wMkaekiHGicJd1cTamJc4O+sR7oAmba9Bf
         SxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781587249; x=1782192049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOBfkW3s2HtntFIC62qbBB3es6YF5T0ky4hO2DWBBro=;
        b=tJwi/tsG7dx7Hk27FPkW0U6RlyvqCecAdRhN8qysx9Cr/7kj+lxxRtF6yc1w02jzEf
         G7SG/+hUYC4cAZVfsYdJNLnBNGUl2pa1IN8hBwBqU89PAFBT3PDQi+go1skTaa5mJS/n
         c1M6VCoV0tAB/CAZNpljE0hGzoH9YWEPw/8eIM1/xjaJvWBPs9hXxjPdjPtcUxkS7m/m
         jf6NLNspICe/LdpjlIdPIE9N8pII9GQ3M8lKvio28ZtspEB+a5kFawLJz9Yq/tIUO0O2
         xCnJtkx+tEsM4LxcvZsvbK/EHetDnSKiEFb5MUmgYt8e/c/B2I/K1ejG3lOw7ntdN7Fn
         J2pQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7jnuWrbn/bnGw9MKbUsLNbXIOIFEwX3BsEhFMLzJ7FFcbp8s5/bSaFsN/H9LkFKoNrqFQQrZbT552Tj15Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8jRTjdZ4icudc033ML4N7FAXv7gvt54u1y1jOoa4kJUI68UFx
	ssWuFClvGjZDobDB2Fs56OqevJTVu5HjAPfebtIPdwVnwZJMgY5GPQRcVEzgaZdN/G1Udojj2w0
	QyEOT4/gzzTpfHVpdZ/q/XNW0Ux+fj+XyigvNvv0V
X-Gm-Gg: Acq92OG8tgKg20n1qbbQrlANEnE6NStFhD1lCNmtlG8SjQw640FXIWi32pix7VVrPr7
	1bS1VqErVTLskc+y21EsU+XcBTJmb3qWIfy9/uoYdgMEPpRE5IqJ+vGltqwCgwdW1/i7/iiZzjy
	X/Tlx6TDMMD61xYSUdDLS0H02fnRUygrpWqBWJumHtrVkkLsNSGARMuKNvhOAPZAeEmrUB0v/TJ
	egsbcpK4jJhuKV9Lw7qJ6dyj9QXUwzEoWMiHAUqwsp17pvpQEl8FRh6EaymHQcwQFlkhzS/KO9Q
	4cvDnOY=
X-Received: by 2002:a17:903:19e5:b0:2bf:128d:f7ff with SMTP id
 d9443c01a7336-2c69a15d10cmr23423855ad.16.1781587249076; Mon, 15 Jun 2026
 22:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260616042837.2249468-1-xmei5@asu.edu> <20260616003903-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260616003903-mutt-send-email-mst@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 15 Jun 2026 22:20:38 -0700
X-Gm-Features: AVVi8CdHw4FBskNeiNkd-2Q0mi8e2wV3bqRPKnGfF77ZInLfXHYM-ueHGQy0ANM
Message-ID: <CAPpSM+SxTkCn6VPXCpKO64op5-w=w5+BhQOrfAVeOK8d7cc88A@mail.gmail.com>
Subject: Re: [PATCH net v4] virtio-net: fix len check in receive_big()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 15, 2026 at 09:28:37PM -0700, Xiang Mei wrote:
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
> >
> > Bound len by the size add_recvbuf_big() actually advertised.
> >
> > Fixes: 0c716703965f ("virtio-net: fix received length check in big pack=
ets")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> > ---
> > v4: use easy to understand math to compute the max_len
> > v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
>
> I still feel 2/2 is good defence in depth but it can be
> pursued separately.
Thanks, Michael. I'll leave 2/2 out of this series.
Appreciate the review.

Xiang
>
> > v2: add additiona check as 2/2
> >
> >  drivers/net/virtio_net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..8f4562316aaa 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1999,15 +1999,16 @@ static struct sk_buff *receive_big(struct net_d=
evice *dev,
> >                                  struct virtnet_rq_stats *stats)
> >  {
> >       struct page *page =3D buf;
> > +     unsigned long max_len =3D (vi->big_packets_num_skbfrags + 1) * PA=
GE_SIZE -
> > +                             sizeof(struct padded_vnet_hdr) + vi->hdr_=
len;
> >       struct sk_buff *skb;
> >
> >       /* Make sure that len does not exceed the size allocated in
> >        * add_recvbuf_big.
> >        */
> > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
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
