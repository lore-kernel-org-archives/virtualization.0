Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87D7222586
	for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 21:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221806; cv=none; b=rstHYNzoY/e+BaHyaS+e4oCxROxNlofsLr/cj4JgQpYxGzTAUKtAXMjhuSr9jZNsR8tTNgGeR+y0usPeBdukI121chOsgatLGt4skaFOTT1q4jJHHon/PNvIyqOWSwBtlocMN3cGvQmzzfOj6li+3PVK10bGHVjzBbSw5KGm+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221806; c=relaxed/simple;
	bh=KJLfGH4r6zCwTj9etgMAbr9xZH0AFU/ISuULlewI/hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lANQfkBFp7VRH2gBxqszsiu34j8dJxs9jKGRdTO+lbKCc7ygnbQpnNA2tMdC1jcCfiWiMsakJDGb39dGk4kmsml4PC6aVj/jClWaC5z56m+NkNXrBLo7NDOz06877moeuRYLoSH4JYrbgZJyExS8KoevL2WGWQT9saFvLDmNils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAXyoFpo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAXyoFpo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f6ca9a81so4075ad.1
        for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 13:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739221803; x=1739826603; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpOwhdLpPNB8gZcJrWR5hgdVmgWAHMy1UaC6q1qkDqE=;
        b=EAXyoFpoLRIiEuHPId7XCkA5eXA5+wdL9Ij3ZsSwN2LFsX5RG87Ej088ujmbRaKEkq
         LL6PbQkASDY9lkT4SPqNVWsiEchFMk4ivdV+sXB+XN9BusGRiuvZhVZbpCY2gbkOwZV8
         KbhOG2mE4p1mz3/PoVFbcOcDJJZz8ya/HHEFoaW6f17QzHhTVlcZNyvIIU/tOJ2K2Pl0
         2eF6cbeT4IiL5Ybz0bPPnrPi8qU5NSK919z+qIsqVE9sZXo2GCQ2v00Zn8QOOcX3m1ey
         4nee1+JHSdIaoCR45EVlsxljYFWFD0qCbjfJzMbtZZ68vzjj/LqIxB43Ur7RZnNcDN1/
         ZkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739221803; x=1739826603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpOwhdLpPNB8gZcJrWR5hgdVmgWAHMy1UaC6q1qkDqE=;
        b=IxTQDE/OgEgQXHrXzqCUbJPxTjHFt29QQJteAgXAw2k6ANH1cBKHhRM2y7YhO8Ex2w
         34wdzrKYVxOPfTrXnROnpf9bEY1EuBZ8zWmULbXEDwRvSXK/IKbWQaC2IPsvBSCD0NS1
         zg0HilRDzdZe7wTXRzLKpIMvsQJUiKhH/S4a6tnR+uCc92mttWzYzai9eNeTKzpi/dtc
         jBrC4yG2+FfHI6Ph/2TDjZoE8nfiKV6W/N5Z0L0Tj3XwwUJoYDlmftI1Jvpxi3vVoqUf
         kI+i2g/kVuCbl0ghSI1FgUjcN5o7KmfP/8oVNlSw03NpGDtGBLnaf3iJFcFnsqVYSibz
         pm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+NYjiZsdQhwBJ6mrdr3qj4tVN6SeLyUsoU1iRiovkuBE4X508M9f77ws2SXVnNuAfMJF4HD6PzIerAqCH5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YylTly3h+y4yCVjDlkmqqAlM0IheMCgwo8mUGgxXm9/Ps3+5dDK
	ZyJa+7LOBF3TN8Y8mOc7iK0ne+EgPk6S71I7Mv53HUZWjwb4vrmjAgbsuZTEmf3Rq2Aj06wqxsJ
	IM/HAzaO3gLkZtkWfma4vbiyyqVWFh79CfyHI
X-Gm-Gg: ASbGncuWurKoh1eujERpX9MqzEEFm8Ja/iZ8TXM42eP+FnC/MlhBZFxkCNU5Llm5MEa
	/kKiDIFvX8DQeZ0kPKFISBUG2LCdcw01FuqPrAdR4/AU3OgdUypPzsZe2w8+Sk5Ypg4ZUAdwn
X-Google-Smtp-Source: AGHT+IHi+uVLv++ClIB5TNGxSvvd8P8hJcj6QNPCjz84MeycHAppY5tmh3RbNn2a2dnjMuITjeslPW3wgJ9FwpR0OB4=
X-Received: by 2002:a17:902:7c8a:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-21fb80c64a8mr630465ad.0.1739221802714; Mon, 10 Feb 2025
 13:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com> <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
In-Reply-To: <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 10 Feb 2025 13:09:50 -0800
X-Gm-Features: AWEUYZlmH-9dq3h0n7ypL1723AKovUOyGvCt-k8ZJ20f-dbsLO-5Bruftf8RSss
Message-ID: <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:20=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> On 2/3/25 22:39, Mina Almasry wrote:
> ...
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index bb2b751d274a..3ff8f568c382 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct so=
ck *sk, size_t size,
> ...
> >   int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
> >                               struct iov_iter *from, size_t length);
> > @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff =
*skb,
> >   static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
> >                                         struct msghdr *msg, int len)
> >   {
> > -     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter,=
 len);
> > +     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter,=
 len,
> > +                                    NULL);
>
> Instead of propagating it all the way down and carving a new path, why
> not reuse the existing infra? You already hook into where ubuf is
> allocated, you can stash the binding in there. And

It looks like it's not possible to increase the side of ubuf_info at
all, otherwise the BUILD_BUG_ON in msg_zerocopy_alloc() fires.

It's asserting that sizeof(ubuf_info_msgzc) <=3D sizeof(skb->cb), and
I'm guessing increasing skb->cb size is not really the way to go.

What I may be able to do here is stash the binding somewhere in
ubuf_info_msgzc via union with fields we don't need for devmem, and/or
stashing the binding in ubuf_info_ops (very hacky). Neither approach
seems ideal, but the former may work and may be cleaner.

I'll take a deeper look here. I had looked before and concluded that
we're piggybacking devmem TX on MSG_ZEROCOPY path, because we need
almost all of the functionality there (no copying, send complete
notifications, etc), with one minor change in the skb filling. I had
concluded that if MSG_ZEROCOPY was never updated to use the existing
infra, then it's appropriate for devmem TX piggybacking on top of it
to follow that. I would not want to get into a refactor of
MSG_ZEROCOPY for no real reason.

But I'll take a deeper look here and see if I can make something
slightly cleaner work.

> zerocopy_fill_skb_from_devmem can implement ->sg_from_iter,
> see __zerocopy_sg_from_iter().
>
> ...
> > diff --git a/net/core/datagram.c b/net/core/datagram.c
> > index f0693707aece..c989606ff58d 100644
> > --- a/net/core/datagram.c
> > +++ b/net/core/datagram.c
> > @@ -63,6 +63,8 @@
> > +static int
> > +zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *fr=
om,
> > +                           int length,
> > +                           struct net_devmem_dmabuf_binding *binding)
> > +{
> > +     int i =3D skb_shinfo(skb)->nr_frags;
> > +     size_t virt_addr, size, off;
> > +     struct net_iov *niov;
> > +
> > +     while (length && iov_iter_count(from)) {
> > +             if (i =3D=3D MAX_SKB_FRAGS)
> > +                     return -EMSGSIZE;
> > +
> > +             virt_addr =3D (size_t)iter_iov_addr(from);
>
> Unless I missed it somewhere it needs to check that the iter
> is iovec based.
>

How do we end up here with an iterator that is not iovec based? Is the
user able to trigger that somehow and I missed it?

--=20
Thanks,
Mina
