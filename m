Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D23126CA
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146060; cv=pass; b=n8STbq+Bs/X37D3y76OgBym/NTNg62kl2dQllewG+s8Koz9Qjemem5GWp9qzoEwVZLOtSux+PXNa+KqBudjUC2/ThA0vucpQowoA77Hl2xNomuBK+oTuT+eHNlO1UeellWcEA03lRIHO/rBFJvNs4UQ3LWosswkqIemfndm46Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146060; c=relaxed/simple;
	bh=x6vh5tb3L8+S6QgCDQ5aHCu0jbDOOsbdS+QIL1xS5UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHgwaN0g1oFk9gVe1MzQkRZJfJ5zNdWwk4sy44w5cdKpKbbPAojD1Ueyq6gQEcobIEMN7zuwIk3adjOwvdtX6+kfdi3dnB5CjD+i+e5Xw1tHvCoqoeXOODdyRIanhZX/plTgxOzWdBr+5N6FZ32YQ4bMFA7ofrrXrYKYn5VCKI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=W2AC7kL5; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="W2AC7kL5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso4913851a12.3
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 19:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781146059; cv=none;
        d=google.com; s=arc-20240605;
        b=dZ85D5Od3XsgTBj0Hw9f/5xsC6pEMKHKs/dQWh/YNrTCb0crA5HKlQZNIqROhsRBoJ
         AJiQuOSRyakfKmG8PWDM0e8wAGKLpV4/VgXhlecysChNXeON+u0XVye7IKSNqd7KH40s
         +X+6YYftTmngJ6ceNJHM0ByBdhTWPaluE/760zMu1Z5lF6hPuLhpGO5ty1CSEwJutOXt
         M1StPl3+QqUgAXmk7BZ+JK3ID2kD/9n8qgmpJoeN1fN7/vREPAObDW43KNpe4bK31jS7
         4EHLLhI7nJTyWznTUJiLO13rL/2uG0yPlMEU4N6v/EOJPQ4kTC03+d9ItAkdMpsJeCog
         5aKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsPqAjNDSq55+C7fcw+ysUSml38tK5lHovl+6aPb6Gc=;
        fh=QONLX3oWPa8DOnTmkJiMvQK/giFT4+GfsEniokq0qcI=;
        b=jmoUkjzSEhC2dTsOzD362LZnYWWY1ipGcydDWXnHb4aDyGdgcdLEaURVlZ6OKrziv1
         TI0p7ot7WW+YsqWPuIotn+gOOjio1FVDHycpPqFlWBDuH+oiXthg4oNqqIYr+rGFkyk4
         hkH0iCyYI8gBT75l8a006qKQnJq0xnqTmUrI3/oXyvL6jgIyAaFeA1uK2/9G9EgBOXYC
         PagByjS1oFPEv5BtAJh4aATWtwZB7W38KJURf9FHcoUemo7ZszutTg0wDFk+DoLt/pGy
         Mq+3LEzuKYr0Pb+AL0R5JsS1FlVsK4ETxNJzkG/vScNHozfEn1jB8vuGsXMmbJBPvgGV
         U/sg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781146059; x=1781750859; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsPqAjNDSq55+C7fcw+ysUSml38tK5lHovl+6aPb6Gc=;
        b=W2AC7kL5QYCZH5yMs2sX8608wgxg5b1c6HqIct4LIPbyZrGo1ZDTb4sJYVwqD1qG/V
         921bIl54yv1ISckoG2Myi0QC4ZNrtZpgXMX3lLcXXZ1o9SmNEODq8gWoXXOYm4+mWBhs
         pc5Oiex271LWaAU/hatKQ1pibN0bZPJIJ6z+vUUX/Pq4BjmP+mXv22d3MrwG/TztlrjW
         gkusWO2xiA13b8hVQ8spmPEwIVMB+zeXLClhyti+vqyxNcdjbhOnwqKhepjorsGlL4Rj
         VslspBSHk7bEvtP0psAAWOqcD15XPz8fZkgwG7Dli8N73dvxhg78pyq97erWLZnWhFXJ
         F33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146059; x=1781750859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TsPqAjNDSq55+C7fcw+ysUSml38tK5lHovl+6aPb6Gc=;
        b=qJYip+tm83Sy2MG2f5BSGs7ptp151QvZFU1NzLFGo0r7j8N2CT/q4/2+19fcpKjvHw
         G2HqyJQbaJHfwt5mGHglUxrTMnRorUzbDLx1op39sQlo9ig1tlP01VNIOMUsF6EziMl+
         5SzchhXfncXdfQDcC3rzhd2vDaZ4ynQLSQ3O3Fk2Bw3JrKbYAcSe+nhapxhjpkZmTmNh
         gAvQ39fYL1YbqUyZjCa5D360OFiGw7X3XqM2xDZveHMI9RGf4kzmmvgubSBf/wCgP4qw
         YKnmZnNbV7/K5D5xh9MsM63gp3vFYDY7dITIghmEse7vIh3B11sluvwkmCN9avHpAGto
         MbTA==
X-Forwarded-Encrypted: i=1; AFNElJ/ExMSWrMtCDQSz+GYRjTIVbgQEAkaAyZ9w/AE0oGnvDrJxyM3VwxVfaHQbZNtAqEQSlurR2NWnCMIUGtjDsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOaLKZpKaTU5oioBVB8ON2+lZJ/Fa1/bMPl8A6SMtkfLd+iXch
	TghjlQG2YhQC05mmk/hNKO+4jHOkRNLM3kNzgmCbEB7LM0AaEVCpnQ4AIWeqpXrliVvZJPqcQcj
	OE/orxak6lHfdmWfHyz2hU9FG0mnm+8oV0DZB2deB
X-Gm-Gg: Acq92OG7KBhrWvUjqESCEG1IhRe56o0d3tfyVqXGQqrNqgE5MsSit4PNO4rWaHJNBRf
	sp6uZWZ/UjZuBgY/SL+l7YAY7HVa1b/x9Emh29EweB3WAsXmPEJcDI4qz49uO3GJZQfvS+9+twe
	siCMlbK2m3WmZgR2xgFFgocgVW5Fzb5agWG3nGuqtDrF9cL+mBuQY5WKJacJVK5iwDmylnqzY48
	zj+x1Xg7K3hDBdWhudUHxfYtDYd1Oa4v532ojrgrmItEDQupTnbWBbi6KmgflKvHRiHS4uhTNQc
	6kyH7WhNhbWhg2VXUA==
X-Received: by 2002:a05:6a20:430d:b0:3b4:b30e:1b4d with SMTP id
 adf61e73a8af0-3b5e3339f82mr745556637.40.1781146059061; Wed, 10 Jun 2026
 19:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260610232936.1176094-1-xmei5@asu.edu> <20260610232936.1176094-2-xmei5@asu.edu>
 <1781144329.8069873-2-xuanzhuo@linux.alibaba.com> <CAPpSM+RApuYf3-ui15E+01fWEzUzfh6mgijQyT_+KjusMVxMfw@mail.gmail.com>
 <1781145615.903036-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1781145615.903036-3-xuanzhuo@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 10 Jun 2026 19:47:28 -0700
X-Gm-Features: AVVi8Cf5s6nvnKDkPBneLlYXv6u8D4i4SZ3qTpyjInY3qYwcuAbdGVZNvWt0g14
Message-ID: <CAPpSM+Ra96knTzOHO0pFdOtvpOK=Nfh4Xx8TvRExwohuYTqn6A@mail.gmail.com>
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

On Wed, Jun 10, 2026 at 7:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 10 Jun 2026 19:24:03 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > Thanks for the review. I agree with that as I replied at the end of
> > v1. If we obsolete 2/2 but keep 1/2, is it okay to just leave it as
> > is?
>
> You should post a new version.
>
Thanks for the tips! V3 has been sent out.

Xiang
> Thanks.
>
> >
> > Xiang
> >
> > On Wed, Jun 10, 2026 at 7:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > > > This is a robustness hardening patch. The slow-path frag loop in
> > > > page_to_skb() walks the page chain via page->private until the
> > > > device-reported len is consumed, implicitly trusting that len fits =
the
> > > > chain. It does not stop when the chain is exhausted (page becomes N=
ULL
> > > > at the tail), nor when nr_frags reaches the end of the static
> > > > skb_shinfo()->frags[MAX_SKB_FRAGS] array.
> > > >
> > > > Both bounds are needed: the chain length is big_packets_num_skbfrag=
s + 1
> > > > pages, which for an MTU-driven configuration can be well below
> > > > MAX_SKB_FRAGS, so neither guard implies the other.
> > > >
> > > > Make the loop self-defending so it no longer relies on the caller h=
aving
> > > > validated len: stop once the chain is exhausted, and never index pa=
st
> > > > MAX_SKB_FRAGS. No functional change for well-formed input.
> > >
> > > At this point, we are assuming that len represents the correct packet=
 length. If
> > > there is a bug in the validation, it can be fixed, just like in your =
previous
> > > patch. Indeed, not checking nr_frags is also based on the overall des=
ign.
> > > However, I do not recommend adding this kind of enhancement. If we fo=
llow
> > > this logic, we would end up adding similar code in many other places,=
 which
> > > doesn't make much sense.
> > >
> > > Thanks.
> > >
> > > >
> > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > > ---
> > > > v2: robustness patch
> > > >
> > > >  drivers/net/virtio_net.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index afe73eda1491..518c22fa1b68 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virt=
net_info *vi,
> > > >       }
> > > >
> > > >       BUG_ON(offset >=3D PAGE_SIZE);
> > > > -     while (len) {
> > > > +     while (len && page) {
> > > >               unsigned int frag_size =3D min((unsigned)PAGE_SIZE - =
offset, len);
> > > > +
> > > > +             if (unlikely(skb_shinfo(skb)->nr_frags >=3D MAX_SKB_F=
RAGS))
> > > > +                     break;
> > > >               skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,=
 offset,
> > > >                               frag_size, truesize);
> > > >               len -=3D frag_size;
> > > > --
> > > > 2.43.0
> > > >
