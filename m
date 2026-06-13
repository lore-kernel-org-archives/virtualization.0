Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244437204C
	for <virtualization@lists.linux.dev>; Sat, 13 Jun 2026 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781380726; cv=pass; b=TdTHeAmNBdOky6bfrTPvgeW812jA/obetTemIAIHFwukPm3t63d79yVSDVAfdJIapZMJNLB66C+suL109HOAjCk7o6MnTLWunrFUl7EC9ThZ8hfQYlqpdiaMmQZ8GdRN2ejm5tro1d/25Pa4mUsQd4Ztd216Qk0nnnpL/vk3wEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781380726; c=relaxed/simple;
	bh=vcpUB+UXUqaVSZsYcoxe54DMhAV6MrxWp2jCTPbpzjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBlkyU0xbBFZrdN4wl3e2gFptf8oxkwqqJisNCCxDpHNJtPfIq5WzWkkYJRLljaCWrIRpBkCUBekV14xOS/ewgyhdTF64J5zYMhD/+qYWw3Tld2agJAHdXzqhNlOq/wEbzVnyqT95htVXsEBNRQVi1J2LMS689NsSI5VqgZp/q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=X7MHZkfP; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="X7MHZkfP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842288702fbso982988b3a.1
        for <virtualization@lists.linux.dev>; Sat, 13 Jun 2026 12:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781380724; cv=none;
        d=google.com; s=arc-20240605;
        b=dxoT8HyWRx8av4ocAAzFiFzHwZ3pspThuC2J/dup6tU9E+thpc28ShYjnh9DApyhBU
         ZPnHsY5H23WsZtbZSzCuHGchNpJvbvrO/ueVM5q5ONxu47aIj5qSC6ODyGbFKZ5bvdi5
         NJERWLprtAih66dfIL3gqxRi2lhoxDxMH8sO1U8HdIGZcA9HNoiRo5LClCMTnMbkwTWj
         W+QS6M4KyoyDKufniE4T7A1WAv8QIKw2aXCiugCDzX9+QHbGt2u0CDTjGqyde4BjRo3L
         1EEX+lIOV4AOeCgvhIZtsSyHu37iAGnp+wSfov4WAIkQYAkQ29M5qnLce/LHn2Q5o/zc
         QbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6JX6O4kgybRuajdLMH1asbB2r9iU+gz24puMLkaqEak=;
        fh=sIsEF4SIBY32pmeB2M6PqJ/b8K1HvEgTEpPmdIgj0X8=;
        b=kyWNu7KzfsK7Vjv5CRptwFgTRW+qko2Q970iEHMwhhldW/CXiJUN3WORt+XMRFeUFy
         fxKk2tUvvR8+nmb3uyT8H6LiZ5UikArGMoO7wzoGJV7in+4fO3D2LVaqBYcXWMITRczi
         BMbYmYAPnOPDRuWosOQXIhaGfRknSkL5L7xxvusJluQRBXw9+1JZNSfNQFxFEX56k8u4
         79aMDzWa4am+jW7fKkpE34kUCQjvK9GkYsXMBQJUtvAZXUFFOIpoK5WZQphpkH0QvFPO
         /+/dohjvDHHBME9nT/YzTWcxlwhuMd6uHMkHy0rASleBmCc7IyiXMSwq0/JH6Ucs1Fio
         wJOg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781380724; x=1781985524; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JX6O4kgybRuajdLMH1asbB2r9iU+gz24puMLkaqEak=;
        b=X7MHZkfPNr4qWn/p1GSXnN/wYVoYdTf1IqS70TKTTga0k1+wbB/EcpraBrwd+Q72mx
         +Juzz0gRY9bpZULAeT7ugBfhhkRY6NlHyV67HkXdSqbDHP1dYBoW4X5JYmIBu3gtCZ4O
         0nrr4fVZcbR5JeHUfKCXNq2WBfynrADM/qm4opvrbonKiWJHCZaBqh3aWCslILBXo4ag
         0JXfSzAMXPXPpKdqhbH/Q9TEN/bv7QD3bOeZOEJDzDWb6dnoODjmQ/0QbxdSVsi+6HxV
         niIIRgZVaeLXkhG9oqj3Jju0x4lX48ICKEQKQvVLYqw7s8Egsiwkbzlm/TPLM5Kqwi/u
         26uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781380724; x=1781985524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JX6O4kgybRuajdLMH1asbB2r9iU+gz24puMLkaqEak=;
        b=cnvPoq+RVMa589FpdjVlZEJh222u5RYNfoLKpl7ozEVAFEpJ4EybN7ayXQyfvudnVf
         VRH1CwMWcRl1BzhNI+3N/fLcOyhVA3qF9K6wFUeCXbI+NnQKn7/sfYUYCjegCPAWB7m4
         56/dKWsfrhUwyN8NMd9Ii4st8OuifdZ8VhR4gY3VbkfmF9wTrCjvltCkuSRiVKiYaaxy
         ufBIAOf9fRLubmDHfO62Kk+wuN+DDG9OA1HF8g9HqKhGzXz7Yn3cn5MsqwxRiembwhek
         Uf6FmQ1grLANzNgawHxNutbFWdwrIBgyNyX1Eeh7SvNDdEY0aJPkDREn4fetvGmgmAi/
         7Z7g==
X-Forwarded-Encrypted: i=1; AFNElJ9oBfRcndamXKxU1nG0kJzrwyUKEnz6NTdm7NLHiPJacVz6gta6s7fAIaVMeivKIJ+3edi2tXzrGZ6bgMSuBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMYFLov8dnNUXS9ohAuL+izehWS9Yb40GDn4RAq2K8HKedbBKA
	7hXtbB4C39rNSkTonxMMk5ebY6YmTT2UM8GEoi2kqoV9bwCRgOBCGheFaOg1RO7zTQ/ZOF4n25c
	2gXRBQZQ6AvRPJd0EZTjwS9TQta+4w0PR1pJka8LY
X-Gm-Gg: Acq92OF1Tw7DyZt20Fex3jRKa0G0jKLsvS3G/TqexiPPH+cNtgc5Ucy5i6VfnQSKV0U
	85h6jtSgn2/pBarcxQTBCpJNxXVMlJPzxSd6cvglTGiqzxT+zhImDovq+YNw8fGx986oPSK2SWc
	C5dGTogVBMIqs9uqVvljOJQcqEzu5GN6Or5ZNKG7geALT3xK+jwz3VRhb+nMfymoS/JLwk6+PSo
	8nqEWY8ojdo1tAv+BYFiU3eQmniaAR8kdCwp6x6OTa3sOLID1ulwhchxs4hvuR7oiyfDtMnzyxX
	i4aBFPeUqZ3qK64nhaExEEVG+ICD16p9iME3W3E=
X-Received: by 2002:a05:6a21:3983:b0:3b4:e4f0:94e1 with SMTP id
 adf61e73a8af0-3b78406e4f9mr9203454637.39.1781380724410; Sat, 13 Jun 2026
 12:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610221606.1091465-1-xmei5@asu.edu> <20260611104836.469610b0@pumpkin>
In-Reply-To: <20260611104836.469610b0@pumpkin>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 13 Jun 2026 12:58:33 -0700
X-Gm-Features: AVVi8CcFpMU5NBtrCka8keKaTwzvxnEfo3CKDV-XtrGtxvmDOmvEfxSqN8pA_vc
Message-ID: <CAPpSM+TN8Av-1_JxkRqiZp-u2rjzjsU+m6dmHw7rQr3WU5+7dg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
To: David Laight <david.laight.linux@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:48=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 10 Jun 2026 15:16:06 -0700
> Xiang Mei <xmei5@asu.edu> wrote:
>
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
>
> That looks like a constant (for the vi).
Thanks, agreed it's a per-device constant, so the expression never
changes after setup.

> Probably worth saving rather than recalculating all the time.
>

I thought about caching it in a vi->big_packets_max_len field computed
once after virtnet_set_big_packets(). My only concern is that the
saving is marginal here: receive_big() is only reached when
mergeable_rx_bufs is off (the "else if (vi->big_packets)" branch). Any
backend that negotiates VIRTIO_NET_F_MRG_RXBUF takes the
receive_mergeable() path for all RX, so receive_big() is never hit
there at all. And the bound has exactly one consumer.

So it's trading a 4-byte field (probably free in existing padding)
against one cache-hit load plus a shift, and two adds, on a path
that's effectively cold on modern setups. I mainly work on security
issues, so I would like to listen to your idea.


Xiang
> -- David
>
> > +     if (unlikely(len > max_len)) {
> >               pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> > -                      dev->name, len,
> > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +                      dev->name, len, max_len);
> >               goto err;
> >       }
> >
>
