Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEFC2FE074
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144659; cv=pass; b=pvcu03DAFwokTLev97EA8keWGIQhLMdnWoFty2tyBNBnezFS64cg7gEN6tfBwWV2UAGLUNTr79NuRqjIg4uEHnXhkKrrXxX7fv11kxZzbxaK4s0DlB56SmybEWwvkzIvo9ewWeJ0iMaqCc4qvf9FptaMZ33cEjrImMCcUPJJx+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144659; c=relaxed/simple;
	bh=HFuA9XjGPSoO0vDqba9U3w0/WoqIFHP7dSHWuV0v9bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIK/nrlJ/7ESiUjnNwRHbRIhXVnhwqj4PcdP54O8tQv1F2LdlGrWVAmQVM3mjZkO6FRBTDypLuQ6YEZ8XMoHA7a25oaPAi+Qf4rswnYMCrqBgQgxlRQvASun2P8necgnJWYvD+4DV8NmIX6xmGD2WytRo1yKkvcpQ9Syr3kEdxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=e0OqJaPB; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="e0OqJaPB"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c85893bce34so2968072a12.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781144656; cv=none;
        d=google.com; s=arc-20240605;
        b=Hec4N84ZuiHpIRFmB8mVIWUXH6zfzGjMrqoYeLlCNwvH0C8rtWPOD6caU/N9+t1D0/
         qWvqMwTZD1A+1Rn53KI70lc7aAKItSZjCrUo6V7zxE/N1rPSFsrJlBlpRB5gRUNBO89E
         FTsTK2fXVyMltqrMvfN5Dy0c2i2uNpD4Ziv+VUnDNM5AEs2tWxNIUaHZ7MRUS4oCgjuK
         umshOwpjiQrSJvaZlEYvI1SuTZrSkybEQPP59aHswroYz+AczCFy76B08klrL5bCm953
         L9+E65S/uCBy4LMz5zMyd7PnWLyqsNgGLGv7ib3i1cJuLl7Tret/oLI4Si8YXGGqhzlA
         3VGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NdBrEBlpAfFK5nSacNcDPGDMq8EZhUqxapMEX5SFjbw=;
        fh=TLLiMfr9OuZg8BMCdOVSMXSHCbxw277/Ih9xkCS6Cao=;
        b=E/W/B/vwSudbaBrGUHGOp+Vp8vtiNlB8CHxbSgFbgzFOF/nlDysIk2ApejvEgeQh3U
         wAaKi7vyRGg0iX+zUgLbFY+oigKIxdWw+DpbogTDK8LSDPnG0G2sOa3/ZJ1wffFUgBMN
         rFFZUtsLthurigrYRIsXEpVQ07Ixa/AoirbLcN6Mct+N/9QqJHoTUMsN0bzEWPt9pKAI
         soQZm3VIMI+FwsgS5y6jCONwL4lTcUTZgbYIiyy7m/GjxlIiAF/2PVfiCN55pdsToJFA
         CH+CdYBRWKjiJKbAF0Lh2cgiaDATfE4Rgngf7K5vfVgYO97zGeJsSXsivzXyPYpqM9+u
         YdQA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781144656; x=1781749456; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdBrEBlpAfFK5nSacNcDPGDMq8EZhUqxapMEX5SFjbw=;
        b=e0OqJaPB6XoCzgZFm3Tb5xQijRaXAJLrO/PpKUeaeopPvgMlp79pJz8xh48hH/CSY/
         9T9I4tvsElg5bAUA560BWzGy5aIzVW56O2GPpyAuS1D7fYJAqjdFsXz/51eSE90yIqi2
         /5iOlQqQlKQC/7+wQcH/t5/rtuR/yTU5TZh8tmteh4Nin1+AAIGzG5mur/+46jqN4aon
         xK3W0/0m1zAIa5vtXKDl703TINqEo+HtGA4vTj5yxPfp6+i0sIVrJpab3cRe0k6Rjnl6
         kAE6F6rnbu5DLPgxA1sJoezDSdiQHdpJK9YLwjyM7Y7cYuXVgCzoBpxEmSaGBvP/1fDz
         xSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781144656; x=1781749456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NdBrEBlpAfFK5nSacNcDPGDMq8EZhUqxapMEX5SFjbw=;
        b=omFduG8DWNkItD7b08dfGPPnmSacCvXxtHsyOioeaZfjbkCDZlfCbOFuPwi7jUHbpq
         mOvKlzpDRlie4nCwkGigTDSArLjLoFE1rpxAxyHEfdOtJFniwWlYlRhozNjLocq1xo8X
         DzUVmb9H+wt9fAGb6Ora8aPQhEqiU0ypXYMZF4XmhCEA7CDTaJsBuHBIlWIN3uT6iw8n
         QwIJppjUrlGa4yZSUE+dVb9uH9K0Dr7zocY0/lfQpnoHxMSVs3IS22yaSQt/3z2w2bwP
         ZY+aEgyNmeTREFxUnryU48rtSJM+o+wEp8HOd+M9KIzRmRGPiH+RaFQV0FV4i9SKc3XY
         WS4A==
X-Forwarded-Encrypted: i=1; AFNElJ9q2oNDPXnvmOY5lh+w4Hz0065dn/Wh1GsUAcxrARiN8Pegi72EINzWXTHkpsRMvQHM8iAZuXaIgcZBX7T0Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLZQnRf9TLJusO+Rcd42bQepNTs6R88gG+7VXSx0NXsGXepWNn
	MqB3bHeO+XTxhtfvn/UpnjU0jIHhY1wc3IYciwhh2zrhjlYHW6218EZikpcihfG3FpM/vehAbpf
	moIEL/TqmmphHh/0T7Bwgzalv8xGwR/JgO5fndf1p
X-Gm-Gg: Acq92OH2ULsaxxIVgZcDDs9/pa1c8y1DYebTcHfE0arNRuAulqEXNXeVJpEfi8sW3PO
	CGzt1/QH2xDaF1qEhrjbg2Rnm42QsIpYvofrY1iqbcWHnpF/vHyuiUw4DpVS2wAqmaKTaWPH9fw
	zGPi3pVft3hcfCCaGjIK2k2ZgdIaIZNG13iTPX5wwi+udoqkGwg+qGhpndmV5U8igOlapu1p3WP
	BBXsrR3W0AZm3hxOB4lxq+Hl/qlMCnRI6hOQwqmS4hwns734wbnBTHLtB3+VE26fYvynGy14mWp
	gRqbS2ditJ5lk7mVUQ==
X-Received: by 2002:a05:6a20:9151:b0:3b4:9027:712 with SMTP id
 adf61e73a8af0-3b5e323684amr594770637.20.1781144656567; Wed, 10 Jun 2026
 19:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610232936.1176094-1-xmei5@asu.edu> <20260610232936.1176094-2-xmei5@asu.edu>
 <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1781144329.8069873-2-xuanzhuo@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 10 Jun 2026 19:24:03 -0700
X-Gm-Features: AVVi8Cff_FTIcsVHrr9aJqW72B1wQaebfIj61Efw6O15tCwyDyH1oC3aMziYxOA
Message-ID: <CAPpSM+RApuYf3-ui15E+01fWEzUzfh6mgijQyT_+KjusMVxMfw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet
 frag loop
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com, mst@redhat.com, 
	jasowang@redhat.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. I agree with that as I replied at the end of
v1. If we obsolete 2/2 but keep 1/2, is it okay to just leave it as
is?

Xiang

On Wed, Jun 10, 2026 at 7:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > This is a robustness hardening patch. The slow-path frag loop in
> > page_to_skb() walks the page chain via page->private until the
> > device-reported len is consumed, implicitly trusting that len fits the
> > chain. It does not stop when the chain is exhausted (page becomes NULL
> > at the tail), nor when nr_frags reaches the end of the static
> > skb_shinfo()->frags[MAX_SKB_FRAGS] array.
> >
> > Both bounds are needed: the chain length is big_packets_num_skbfrags + =
1
> > pages, which for an MTU-driven configuration can be well below
> > MAX_SKB_FRAGS, so neither guard implies the other.
> >
> > Make the loop self-defending so it no longer relies on the caller havin=
g
> > validated len: stop once the chain is exhausted, and never index past
> > MAX_SKB_FRAGS. No functional change for well-formed input.
>
> At this point, we are assuming that len represents the correct packet len=
gth. If
> there is a bug in the validation, it can be fixed, just like in your prev=
ious
> patch. Indeed, not checking nr_frags is also based on the overall design.
> However, I do not recommend adding this kind of enhancement. If we follow
> this logic, we would end up adding similar code in many other places, whi=
ch
> doesn't make much sense.
>
> Thanks.
>
> >
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> > v2: robustness patch
> >
> >  drivers/net/virtio_net.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index afe73eda1491..518c22fa1b68 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
> >       }
> >
> >       BUG_ON(offset >=3D PAGE_SIZE);
> > -     while (len) {
> > +     while (len && page) {
> >               unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offs=
et, len);
> > +
> > +             if (unlikely(skb_shinfo(skb)->nr_frags >=3D MAX_SKB_FRAGS=
))
> > +                     break;
> >               skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, off=
set,
> >                               frag_size, truesize);
> >               len -=3D frag_size;
> > --
> > 2.43.0
> >
