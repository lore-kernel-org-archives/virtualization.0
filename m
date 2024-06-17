Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C805916B
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718588712; cv=none; b=clgCbhP0e6nXAA9FdDumUZ2E8ub+pq368xyLZoGvKX7WVf7f3cy1ivQl6MVJc2aiPNJtlamTf1i5Gtepeg7ZJM7MA1RaePFx4dsoGxLhi4GdMB3zp1OKVc1BUtsdaF95RiNk9Nog9zSCb0bQREDDjehcxOgUv+8meNPX/VOWJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718588712; c=relaxed/simple;
	bh=t5MD1ex9VlAS8c468F/2oWD+5J03aRRoVhgBc7qIz0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VG3CRpm8iBS+4mp1GnQUuAxaW4KvxMq1nkkhm9Gcc2Cfi9zFQFmQ68eKFfnsyjjHULQbaiSP9l/Gji4gL9747wDTfYWVJPlCoHUTIOIzxezfP8bJUJEF/rR0v9Jle6VfEO5iCiHDia4EoFT1EcOVaC7x8tHM+1z3gL88ChPt5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuX4yWAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuX4yWAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718588709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=varLkYvQXXiVYrsly37DyVexBnZsFAUL1jZV89pLMSc=;
	b=GuX4yWAKQG6FCAFfZdQf8J8buiG4ob9K9fnaQmygUF+HMErud4FgBRrxZKabZJfDTRoMRL
	ywDROFVrtqnml5mSaukyYP+DVOAxr+Ys2Jm1ZOU2NOfx5Cf2GMCNpAJRK5t8vR3diVJvAx
	GJdTjYmHHmROg8NxIO3MLtoYhYxwFaI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-uBqGMX_aNiGzqRysDxd71A-1; Sun, 16 Jun 2024 21:45:07 -0400
X-MC-Unique: uBqGMX_aNiGzqRysDxd71A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c2f9da840bso4002770a91.3
        for <virtualization@lists.linux.dev>; Sun, 16 Jun 2024 18:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718588706; x=1719193506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=varLkYvQXXiVYrsly37DyVexBnZsFAUL1jZV89pLMSc=;
        b=M7dTdcbdO8uYIWYk3ytNlutKpf+96AWp9SIH8eWYoEXi+PaKJUdA7JXBj3cDSK9VkV
         hbKeswVjHZmvTT7F+29pJbZqe1HbP/csw/u1q1AwndFYqpPPb2c9JOjsrg4PmQdNyWxZ
         f67u87OqbAAoNFY8C22ca+b3+N9HnvkQQW0lfGwrnNEZ6T4AckIMnjaUDc2ynDFC7GzX
         W+emHWW5boTxkEZeqoUg7tTGWK9hj2K2GqdEkTNhZxDwLBwS6BGcRc8dTM0Ksh1Oi8Er
         45sbkGxSBZZSSYw9yoyGrTSek/DPN74ylmbJOFpguGzxfufYTgEEIRApXpoXiEnvPs+W
         rCWg==
X-Forwarded-Encrypted: i=1; AJvYcCW6QQCbxaod/rpV7F0JbKvFBKlljScdeYrhkkIautcQjCU4gFSwKNRsvC9JT+XVFGTRgswOBl7DShfDQ8ZU6+t9WCANR0ARClTZ/zCRPYw=
X-Gm-Message-State: AOJu0Yx+IG7Pdv1mR4JJxmZUc4BPDfXO0jTCmONHgHWkWEAUmVxzZIL6
	Ycy4Vrf+GRFEbEuVnGsJhXU8w0gDmlmHlldAb4wNRBWGTGmVGiDXpslP1sld67GUGb1YEN28cSn
	oUoqDL1jo2rLwh6Cto2yiVH7GcJj5hYX1vLqlxoU1NKG7B0KNkb64WhYglE4CNcz/t9HQD39/gf
	v0PSTp1E/hxm6jk0AJJuFpZVu9k33b7FKy1N9CSTk=
X-Received: by 2002:a17:90b:1109:b0:2c3:2557:3de8 with SMTP id 98e67ed59e1d1-2c4dba4cc8bmr6965579a91.33.1718588706645;
        Sun, 16 Jun 2024 18:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0AkWfMq72NwUEMIwBQBHsf866KKlMTTJe+fIwJHWEiL0M9NimZLgYzfnZ5J7nZR659gGCPKCffH8bhH406rg=
X-Received: by 2002:a17:90b:1109:b0:2c3:2557:3de8 with SMTP id
 98e67ed59e1d1-2c4dba4cc8bmr6965570a91.33.1718588706277; Sun, 16 Jun 2024
 18:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org> <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion> <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion> <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion> <20240610101346-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240610101346-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:44:55 +0800
Message-ID: <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
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

On Mon, Jun 10, 2024 at 10:19=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> > >> >True. Personally, I would like to just drop orphan mode. But I'm no=
t
> > >> >sure others are happy with this.
> > >>
> > >> How about to do it other way around. I will take a stab at sending p=
atch
> > >> removing it. If anyone is against and has solid data to prove orphan
> > >> mode is needed, let them provide those.
> > >
> > >Break it with no warning and see if anyone complains?
> >
> > This is now what I suggested at all.
> >
> > >No, this is not how we handle userspace compatibility, normally.
> >
> > Sure.
> >
> > Again:
> >
> > I would send orphan removal patch containing:
> > 1) no module options removal. Warn if someone sets it up
> > 2) module option to disable napi is ignored
> > 3) orphan mode is removed from code
> >
> > There is no breakage. Only, hypotetically performance downgrade in some
> > hypotetical usecase nobody knows of.
>
> Performance is why people use virtio. It's as much a breakage as any
> other bug. The main difference is, with other types of breakage, they
> are typically binary and we can not tolerate them at all.  A tiny,
> negligeable performance regression might be tolarable if it brings
> other benefits. I very much doubt avoiding interrupts is
> negligeable though. And making code simpler isn't a big benefit,
> users do not care.

It's not just making code simpler. As discussed in the past, it also
fixes real bugs.

>
> > My point was, if someone presents
> > solid data to prove orphan is needed during the patch review, let's tos=
s
> > out the patch.
> >
> > Makes sense?
>
> It's not hypothetical - if anything, it's hypothetical that performance
> does not regress.  And we just got a report from users that see a
> regression without.  So, not really.

Probably, but do we need to define a bar here? Looking at git history,
we didn't ask a full benchmark for a lot of commits that may touch
performance.

Thanks

>
> >
> > >
> > >--
> > >MST
> > >
>

