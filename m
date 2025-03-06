Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80727CB0C
	for <virtualization@lists.linux.dev>; Thu,  6 Mar 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301097; cv=none; b=mkHVnJrAUopJti2xYx0tLfs2BhIBko7T6ry88qFkYz3j9ih5Z/gneXPzSEtxF7QA0ZST4idyZfRDvD2nex0BLfQCOOf7mDrRAgnbDs+eahoseqqbnnkN+qSh2t7oRUf60uSAbG3XFNhdezaZeaWCzOgM3Fh27yKCAO2i4VRoLUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301097; c=relaxed/simple;
	bh=WJGCuAvULpegUxMdbOK1NHjZx/sGgwb92zX49N6RDkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okWbktn+MetU++Fp74PPh0ZMQbN8ZI305sz0eNeyQhK5U2VTcCQCr2puIWOZB/WUzsYH48+P5qfKIk2PmSD57JZcBX5imbqTBhyu/XJ3BdmntFvCDD9+fpLYKFUtmCigh5RNlv1XJZN8OLatWrgaFJL53K7JS7qr0JF40l7CvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ue6+uLr9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ue6+uLr9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso4765ad.1
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 14:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741301095; x=1741905895; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJGCuAvULpegUxMdbOK1NHjZx/sGgwb92zX49N6RDkA=;
        b=ue6+uLr9IUdC2THZ/ksTrZjjHSNd+O00MrOcW7yJrXFZW45shiEZ66JxrAsplzKr9g
         7jqQbzO4hQ8eT/ioNA4PdKJvWhIoQaeV323zTKwXoemPxBIFfDqvLrzkjgI3ql6bLO+J
         q8e6nAWdm2BCCcelvj14gUq/ahPl9s8UWIcLGVM6tb453INn4EFPbyoHtxo9ugejYfYz
         WLFwCKzmJhcSb6CcF6oc+nSgfSsCfuewUIHxEl+xLbfdR/OvbiX5vCnMnFcB0d1a6z4V
         RmVP4BHr9ILikSaTMktLCLo35ONP+to2AeNFs/YMXzwDj9jI1ApDwkwJVy/I6Y5CmIJs
         +CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741301095; x=1741905895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJGCuAvULpegUxMdbOK1NHjZx/sGgwb92zX49N6RDkA=;
        b=oMVBK5LkvsxRCPsbLYr0wOVtlyQXRnurYIGUH2q9MAcy2H4IywA+cM9+MCpMfN22hW
         moywVflzGvAaRSpvCgcjGT+cjlnsQX6h2vOIi7PXsvSNA7my+MGUwyGP69BQ83W4Cp3i
         WGw/eH3xXIBANk5q0rA6kKH5Vrsh1EG4Su7E8AG3ubpPwmm3++AdgtNoNqlbJgGewVmM
         kCdVt/aMMV5reRbdBMh+tHxA/laLU05wkwLDaBX6me7lJBeKoArex/iSmSUgoskHVPr6
         wKZI2xl+K45NCUFQlGW9lpvMQl1uNF4xmezLmmjbxAv0xy1iUdOT18zXZ4NhL7mpOw40
         j7bg==
X-Forwarded-Encrypted: i=1; AJvYcCWYkzH85js5tDaLaq8QcMd95ALCzSduqqRSNPxTzCrqyk/rgb0wTPx2a77SFYj4OxEEuPbPeZfYwgu4DGkZGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjVfgqruCqP4kMZU7G9ZTuCkCGkybsJOy1V3ZcvEZWNMf3IvOn
	wm4+ZHTpSpNwRyEHFR9HcxqNvm5baMXZVEnAS6D99aLaFrsQUlAK6fTaQzWIKc3kHOjybQ0bu3b
	TBM3mxnH+kMsuFAo7CEeJnMpRQOEdXuLSF9a2
X-Gm-Gg: ASbGncvc5CPqqs7Ol7VX0io+uTDkZcbp85a4FJJGIt+ho+AYb/3RuKeUkS1SPLUkq5b
	b2qkvVruO7Si8V2H2p/zCoAK7ZHHsVZmmt6wpEY+O4ojj89/ZjvxDOu3Yvm2/H1FgtRTH0vi7eE
	JIU1L0//JIXT8DJ+62+ONhWkRUXGHLw/PIN8SIf2HHUgKeNPUWCLxLVg==
X-Google-Smtp-Source: AGHT+IGS+g4ZXFAp2nGdJpOHDce9EEY1Ln9JHFM0oHkP+LPpqqepXFJR4Sm8vslWM6D7/epATYsYkpZ1n4ukdSKEsNY=
X-Received: by 2002:a17:902:ea0c:b0:216:21cb:2e14 with SMTP id
 d9443c01a7336-2242a62b87amr242655ad.21.1741301095087; Thu, 06 Mar 2025
 14:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-2-almasrymina@google.com> <20250228163846.0a59fb40@kernel.org>
 <CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
 <20250303162051.09ad684e@kernel.org> <CAHS8izNWt2-1bC2f0jv4Qpk_A9VpEXNvVRoXUtL43_16d-Ui-A@mail.gmail.com>
 <20250306134019.1702e609@kernel.org>
In-Reply-To: <20250306134019.1702e609@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 6 Mar 2025 14:44:41 -0800
X-Gm-Features: AQ5f1JpdzmIgb4Qp1uwhgyjnsZGuDnrddzCXLNm0isLe9E-TpLpq-VU4X-9HjRo
Message-ID: <CAHS8izM8dnFNj5p8vKiyhV9qeE+9=a=BWRnH=vCu49Tq_XTL9g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
To: Jakub Kicinski <kuba@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Shivaji Kant <shivajikant@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 1:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 4 Mar 2025 17:39:37 -0800 Mina Almasry wrote:
> > > > Yes, great idea. I don't see why it wouldn't work.
> > > >
> > > > We don't expect mixing of net_iovs and pages in the same skb, but
> > > > netdevsim could create one net_iov skb every N skbs.
> > > >
> > > > I guess I'm not totally sure something is discoverable to syzbot. I=
s a
> > > > netdevsim hack toggleable via a debugfs sufficient for syzbot? I'll
> > > > investigate and ask.
> > >
> > > Yeah, my unreliable memory is that syzbot has a mixed record discover=
ing
> > > problems with debugfs. If you could ask Dmitry for advice that'd be
> > > ideal.
> >
> > Yes, I took a look here and discussed with Willem. Long story short is
> > that syzbot support is possible but with a handful of changes. We'll
> > look into that.
> >
> > Long story long, for syzbot support I don't think netdevsim itself
> > will be useful. Its our understanding so far that syzbot doesn't do
> > anything special with netdevsim.
>
> Meaning it doesn't currently do anything special, or you can't make it
> do anything special with netdevsim?
>

Meaning it currently doesn't do anything special with netdevsim. I
imagine we may be able to create a specialized syzbot instance that
loads netdevsim and starts fuzzing its APIs. However I'm told
specialized syzbot instances are much less valuable than making the
feature discoverable to existing syzbot instances, which is why our
thoughts went to adding devmem/unreadable skb support to virtio or
tun/tap.

Do I surmise from your question you prefer a netdevsim-based approach?
(and just curious maybe, why?)
> > We'll need to add queue API/page_pool/unreadable netmem support to
> > one of the drivers qemu (syzbot) uses, and that should get syzbot
> > fuzzing the control plane.
> >
> > To get syzbot to fuzz the data plane, I think we need to set up a
> > special syzbot instance which configures udmabuf/rss/flow
>
> To be clear for Tx you don't need RSS and flow steering, Tx should
> be trivial for any device driver which managers DMAs directly (not USB).
>

Yes, we don't need queue API or page_pool support or header split
either for that matter. TX fuzzing is definitely simpler. Maybe we can
start with that.

--
Thanks,
Mina
