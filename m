Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245D4C84
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673608; cv=none; b=gTcU7JnFMPoO3irtDVHAgiNIjkbA46s0KIzqG8jks9BhTsjGqJDyfFlZjRKGJeGMGFLiScvsxOammLANkPM2fa8xxTHzAEcuoBxV0fq4WTAj2WfaBhyjs2dm7tpy0Uimcjh5KxG/FU211+iLhyasZzEdjgc4wFxRYlogVERUkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673608; c=relaxed/simple;
	bh=d0SnZw1Xf/53Eyu0IKqQJ47gBK/ILSrcvltGpevDImk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApOczWAc4SWUfAHO1aN5Eqw+xzni0wli7fMwxQ2JIJLQXwFJ6clZZ7Biy6/AW4NcD9YM+EmYZU0JJosPFPzJ02kfOrj/EE0KLgddiT8dqAJ/BEia368/sT9OAqRI+Y8o9Z9uRQBt/B8m+SYK/Mgc/Lj7FwOzP5A/M+ozfbbMBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HKRshzmv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKRshzmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718673606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlJplGu26itJiIifDWOuoHRWeDURtPOV07x+0z7gMfM=;
	b=HKRshzmvoSh4Q6RhKgVMzwOVCf1fD4MSGmUTUCdUdBpwLd74vbQoSSUmg5l/c9Ej7GGBG4
	J5a0QlKlcyRJgs97ZWJjC11w7O87fzITXFRHJDRMuUlxtCBGjt2PsDkg6l6UgF8LFpk3+H
	RXuRGYyv/3Tz7r0e+tmMX7hhP0nMEgE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-G58-ifqwOnufdpVNzooLtQ-1; Mon, 17 Jun 2024 21:20:05 -0400
X-MC-Unique: G58-ifqwOnufdpVNzooLtQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6e82b36467eso4829586a12.3
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 18:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718673604; x=1719278404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlJplGu26itJiIifDWOuoHRWeDURtPOV07x+0z7gMfM=;
        b=fZC6y/FJuaWkv2cdYqQWufO8L53EnefRp/2iTWTaJBFJm3i2iWV4Wl1AzWLyt1oNBU
         z99ubcVm3me0rnXpMcMKLCpe90pZhnp3Ps6gre4tWyviFMIm2RZW7/K+MRAOlgO3cUw7
         skgm9apKDx9lNoYJfpl2eUS9Slox88im+jDg0DVrNvtZiMdPpjGA7Y03H4OrXRQ7uo9K
         JsQlZPeZHDeEtLe5C89fKICEYJGVuVDHAkDXCoyQ9LB141kz7bw6iLLdSiaAK768kHyI
         YPbzZJECv/DfaVve9/Y3OABfKswofKwKq29/TrQzGcwWeX3tpIngEtpdyiSd+hX24sKn
         UeIg==
X-Forwarded-Encrypted: i=1; AJvYcCVQf51AdUuwemWLzmPm9oS0HAZtBurbIz6R8H/9MtCNvaT/ydU8dKO42YJPR9yp6S7WQg6hMoNCKA32CtW/QrPfi9LpmnQMfXFTSNSwM1U=
X-Gm-Message-State: AOJu0Yz/sU4ufQRxrXumYxI/4Px45AvOFL/ItdS6ivGgzr07/ugLgZf3
	WbMq8/IpaXi4fNgGSshTmZY7pqLQdLRnk+POxMNhEFZjFSuS6XLhONIU+GG3v4yUCmj8c/PJ1Lt
	iReMSelmdBpfKoFR54hX23edGcwsNe2CZeyqDesZTRzqzBaXn2gP8QmtkkGZFed7Fb3ZQxaK6mF
	230uzYfVMvP3hkREHH2DOJOKHBOjzScDt3HVxb6rw=
X-Received: by 2002:a05:6a20:430d:b0:1b6:db6c:11dd with SMTP id adf61e73a8af0-1bae7e29041mr12347868637.9.1718673603802;
        Mon, 17 Jun 2024 18:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwMCQpzGRduK8eBGmbYbrrgYYqBMFiL1FjxTaND7gNyPprMKC/3wMqe3WZ/0zQIphPvUai/mECzBBG34xjvLY=
X-Received: by 2002:a05:6a20:430d:b0:1b6:db6c:11dd with SMTP id
 adf61e73a8af0-1bae7e29041mr12347848637.9.1718673603354; Mon, 17 Jun 2024
 18:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion> <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion> <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion> <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
 <ZnACPN-uDHZAwURl@nanopsycho.orion> <20240617121448-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240617121448-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 09:19:51 +0800
Message-ID: <CACGkMEtkzezg6Pm8+12MSvMAk4AFrc7Q_cymDqs6pa0Uvu+pJQ@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Xing <kerneljasonxing@gmail.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:16=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Jun 17, 2024 at 11:30:36AM +0200, Jiri Pirko wrote:
> > Mon, Jun 17, 2024 at 03:44:55AM CEST, jasowang@redhat.com wrote:
> > >On Mon, Jun 10, 2024 at 10:19=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > >>
> > >> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> > >> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> > >> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> > >> > >> >True. Personally, I would like to just drop orphan mode. But I=
'm not
> > >> > >> >sure others are happy with this.
> > >> > >>
> > >> > >> How about to do it other way around. I will take a stab at send=
ing patch
> > >> > >> removing it. If anyone is against and has solid data to prove o=
rphan
> > >> > >> mode is needed, let them provide those.
> > >> > >
> > >> > >Break it with no warning and see if anyone complains?
> > >> >
> > >> > This is now what I suggested at all.
> > >> >
> > >> > >No, this is not how we handle userspace compatibility, normally.
> > >> >
> > >> > Sure.
> > >> >
> > >> > Again:
> > >> >
> > >> > I would send orphan removal patch containing:
> > >> > 1) no module options removal. Warn if someone sets it up
> > >> > 2) module option to disable napi is ignored
> > >> > 3) orphan mode is removed from code
> > >> >
> > >> > There is no breakage. Only, hypotetically performance downgrade in=
 some
> > >> > hypotetical usecase nobody knows of.
> > >>
> > >> Performance is why people use virtio. It's as much a breakage as any
> > >> other bug. The main difference is, with other types of breakage, the=
y
> > >> are typically binary and we can not tolerate them at all.  A tiny,
> > >> negligeable performance regression might be tolarable if it brings
> > >> other benefits. I very much doubt avoiding interrupts is
> > >> negligeable though. And making code simpler isn't a big benefit,
> > >> users do not care.
> > >
> > >It's not just making code simpler. As discussed in the past, it also
> > >fixes real bugs.
> > >
> > >>
> > >> > My point was, if someone presents
> > >> > solid data to prove orphan is needed during the patch review, let'=
s toss
> > >> > out the patch.
> > >> >
> > >> > Makes sense?
> > >>
> > >> It's not hypothetical - if anything, it's hypothetical that performa=
nce
> > >> does not regress.  And we just got a report from users that see a
> > >> regression without.  So, not really.
> > >
> > >Probably, but do we need to define a bar here? Looking at git history,
> > >we didn't ask a full benchmark for a lot of commits that may touch
>
> It's patently obvious that not getting interrupts is better than
> getting interrupts.

Exactly. But dropping orphan mode seems less intrusive than the commit
that makes NAPI default.

Thanks

> The onus of proof would be on people who claim
> otherwise.
>
>
> > Moreover, there is no "benchmark" to run anyway, is it?
> >
>
> Tought.  Talk to users that report regressions.
>
>
>
> > >performance.
> > >
> > >Thanks
> > >
> > >>
> > >> >
> > >> > >
> > >> > >--
> > >> > >MST
> > >> > >
> > >>
> > >
>

