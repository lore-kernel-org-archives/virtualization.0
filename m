Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C1282EB
	for <virtualization@lists.linux.dev>; Tue, 11 Nov 2025 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762821951; cv=none; b=tDXLLkqSBZreg2Q/HVy4rbGuDAG/N0J6JOrF6Lk3931EVexxHpO8Ip2urmZpXMjgMN5ykl55tw/NnmAAMTXwIZ2l03mqy6o/yWU7HzYQsL1LkdWGHaj4l3j8LQUAohjiNL/iXWEmdLC7y3wwwZIDjNTRqDEbAqn2XhKfSkvrB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762821951; c=relaxed/simple;
	bh=dVuPMCslW28VmgSKRsWmna3DfC5pd3VD4foVAKXsE60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q756p1T9zcNAIa93FI7lEwWIKTsDVZrT32VEPSnSt6LiYhZw6HqyPh516ccFHeYEA4l7H0wwPPb/W1jCmbsGxy9MCUIBWkr7AuJ+0SkUpKoY5zeby151UT64WznfVBxEGK3qHydryIILOnjOgwJebuJGMaVlQ7Yyl+eWD4eMaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adKtfuW1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adKtfuW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762821948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVuPMCslW28VmgSKRsWmna3DfC5pd3VD4foVAKXsE60=;
	b=adKtfuW1TiS+fV9D0Vlrv3P981Yzj9l+8SnKcjv4m5AP6fngW6hcWJcvv/mhS5Bpnw1o16
	hgVNtXp4dtuyfjMpQOlR7iXVxzEvDkt4hGtZd7T01sK4nwaJYNMZko8j5h+XlkMfanv1Dy
	iNhXPZcAaZVJuhONlZjnrrXnH4WMxOE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-7aB44r62OVCC95CsjWQtPA-1; Mon, 10 Nov 2025 19:45:47 -0500
X-MC-Unique: 7aB44r62OVCC95CsjWQtPA-1
X-Mimecast-MFC-AGG-ID: 7aB44r62OVCC95CsjWQtPA_1762821946
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3439fe6229aso440083a91.1
        for <virtualization@lists.linux.dev>; Mon, 10 Nov 2025 16:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762821946; x=1763426746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dVuPMCslW28VmgSKRsWmna3DfC5pd3VD4foVAKXsE60=;
        b=bf+dNJOrdGGsbECF7AAs55+11oMEJ1/tHK3qLW47cX/uoZRUouYpN67/qBypBxPhdf
         Fiii1uqkcW0UY3PQeBWKV8oPBan00iEJdC4TAbRpsxwkl3bawXAQ+cy/vQHschAIu3XK
         XZxmVp51IS8zIUfGRqhHNypyUzr6ovB1jeR0cb7tt3KzS1prAESqbD7G1PWMyr1Tjiuy
         jwC0+Vu2jKhQdrcTZ1q0x+y4KPAAD6B+P4R18NW2IBvgQVdu/AZItFojlSK69nyr0gOi
         Ql8NzeabSJHLh5ykpKKPGQSGK5bza/DYK+1Wnegs4oemzvuKQa7057/A6Zjzj73MtWQw
         xhnw==
X-Forwarded-Encrypted: i=1; AJvYcCWAok2LzIQKwthWqgFtvs89OBQDU1BQKNBfXJwxdemgOzt/UKODlHVpWRAAad5bu27BvMdY3LYnmIuRPaPyrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwroiKeCPziFRInTbuYoWSyKmUyXskxE0xV4g86iKEt7/FwM6L6
	i1b1rVlRAboh+HKPRS46jsbRPKdnyh2t3BxnbNGx3nKFUFRC1OvTtH/RSVANc6Fa5Ht6H/RV5Ps
	FaoZ7iaEEQo5movZIJuIgV8OClxRTIwRtvGEFkZSp7h/F3vheW/7Y8aMyALJ+CmWTcd/1yJDzW2
	klDw3o5g+SbqWlmRHynISCOW494qo0cMMnEce/Y5Jkzv4=
X-Gm-Gg: ASbGncswb/P98eI0P8/9MxOKNwfTy/8o95JMEywK6DXmvkQG9HlhlKJSmCXYHNFDYfJ
	OTwEpz0KxtrdG0WQcP7nbrFJbKBxEOevXoBViAuMDWmVaBd/AxfZfMo92bDWTBrYNIX0yeV32MJ
	a9d0iUb5bbtYlu2EIynM0mZVDso6eQOBPBrIiSQ9ETkg3di4vvgc7d
X-Received: by 2002:a17:90b:3943:b0:343:78ed:8d19 with SMTP id 98e67ed59e1d1-343bf0bd417mr1695434a91.7.1762821946240;
        Mon, 10 Nov 2025 16:45:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQUmvPvGXxjrfxDrSY5BguI5eT/+blkmNjZR3Gj94t1Sfp7uvokh13xuEGRkj1wZchbTW3URKIPgxezklb2Po=
X-Received: by 2002:a17:90b:3943:b0:343:78ed:8d19 with SMTP id
 98e67ed59e1d1-343bf0bd417mr1695376a91.7.1762821945678; Mon, 10 Nov 2025
 16:45:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com> <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org> <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
 <20251110022550-mutt-send-email-mst@kernel.org> <CACGkMEt+czNGi_KFgnHkZteNVNmBc7ND_xh7R=uNDo-ZumFEfA@mail.gmail.com>
 <20251110110751-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251110110751-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Nov 2025 08:45:34 +0800
X-Gm-Features: AWmQ_blZvE7rBc4Z9MGidBidk5AJhCi--F0DfIvPMWElMJxReUbIA_Y-Jurf-ZU
Message-ID: <CACGkMEs9qwGfnmTR2zCS09QZpKG5OnpCJ19BUtL6AkAW3L-9eg@mail.gmail.com>
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wFezg4xIalirQ6U7wghKPT93Rou_bbsf9O1QqtroCW0_1762821946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 12:10=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Nov 10, 2025 at 03:39:50PM +0800, Jason Wang wrote:
> > On Mon, Nov 10, 2025 at 3:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Nov 10, 2025 at 03:16:08PM +0800, Jason Wang wrote:
> > > > On Mon, Nov 10, 2025 at 5:41=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > > > > > On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@li=
nux.alibaba.com> wrote:
> > > > > > >
> > > > > > > The commit be50da3e9d4a ("net: virtio_net: implement exact he=
ader length
> > > > > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST=
_HDRLEN
> > > > > > > feature in virtio-net.
> > > > > > >
> > > > > > > This feature requires virtio-net to set hdr_len to the actual=
 header
> > > > > > > length of the packet when transmitting, the number of
> > > > > > > bytes from the start of the packet to the beginning of the
> > > > > > > transport-layer payload.
> > > > > > >
> > > > > > > However, in practice, hdr_len was being set using skb_headlen=
(skb),
> > > > > > > which is clearly incorrect. This commit fixes that issue.
> > > > > >
> > > > > > I still think it would be more safe to check the feature
> > > > >
> > > > > which feature VIRTIO_NET_F_GUEST_HDRLEN ?
> > > > >
> > > >
> > > > Yes.
> > > >
> > > > Thanks
> > >
> > > Seems more conservative for sure, though an extra mode to maintain is=
n't
> > > great. Hmm?
> >
> > Considering it's not a lot of code, it might be worth it to reduce the =
risk.
> >
> > But I'm fine if you think we can go with this patch.
> >
> > Thanks
>
> hard to say what does "not a lot of code" mean here.
> but generally if VIRTIO_NET_F_GUEST_HDRLEN is not set
> just doing a quick skb_headlen and not poking at
> the transport things sounds like a win.

Yes, this is exactly what I meant.

>
> I'd like to at least see the patch along the lines you propose,
> and we will judge if it's too much mess to support.

+1.

Thanks

>
>
> > >
> > > --
> > > MST
> > >
>

