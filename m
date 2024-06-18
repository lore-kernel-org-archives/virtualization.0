Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF314C8F
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671977; cv=none; b=uPfxKPrTcjjMv6TUucEEuIzUZSGnOpOheiLeoX+h9jBx1lJTN9gKJNDXHArwRoUa495i7abN3SknKC+1yliHOaVog8MqJxffwCjFgF1wzpOZ4/xt9huPbigKYL1Fg9IC57TjPE0GI8ON/RKDlyrrznkhG+og+3Xbv71Nt1ezXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671977; c=relaxed/simple;
	bh=nFPe7Fr7NrrvclcHrrJyLIKOE3ordfgnei6PYt9cMbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJohI76zW7wt+5IgWSBRi8vkGIpRaTapfoGQMzZlLay5cyK6kw/BwzWhdUh9TcaILTid9KUk5H2EfcFhF/OiIU7UWtyopMi2ViCVsPkJiO1yKXKdDFE6CvpPEaap4c9dOaskzBX47tTOGZSHvb6W69/k2Jq+xXAjj6HaLS7HV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hR8Ce3ky; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hR8Ce3ky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718671975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UbitODA8/gAi63tAtWbfOg6cnaUyUUcJ7N8r21Res4w=;
	b=hR8Ce3kyHt8DEd9nMaqw+bNljbhzy5AcJiI/+5YN9vZr+ZPQsjq6k49myd+STisLpffd2x
	UoBjq7wtz7kVIyBf41feEns2fx+LbDiVfAdO5jSuQXDwaBRxZjHEMlYbOLq1K3Vhh6rfFH
	sJgDdPfG4FsNCM2g6HicXirk65pFB+0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-2mxiHHHGOn-1EmsrrH4m6g-1; Mon, 17 Jun 2024 20:52:51 -0400
X-MC-Unique: 2mxiHHHGOn-1EmsrrH4m6g-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c315247aedso3963902a91.1
        for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 17:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718671970; x=1719276770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbitODA8/gAi63tAtWbfOg6cnaUyUUcJ7N8r21Res4w=;
        b=Y5qhFAFyzXnquTmB/bJujepB9JlbBSQyzW+Q6d/f/Ewdynm6uq9xiL78TO11KoT11U
         TR3j1zvEbkqETAUGpP7eshpQVsCkTfmexE0NIBQR5ypJo7RI8Mh8hsx/Q/jWX70gXNkA
         cy/qJXec5IxO4BvOk01UO6UTho2fRWfk7a6RT6VijFgjALKknXLuxWgQJ1cbZDaCMVCA
         qFSJYvtpwHf6WfzUraXnejt70t9+DKgjXqoB8wTOCOzNZ4GF3rYFF+V9gTAoGji3wJSy
         Q3DvrIgQdo1sTVpya9GUJSQu9nN9FvPxQimOP9sLFv2ttQ7qHxbWyz1ubvTSrN2PWYND
         ZSTA==
X-Forwarded-Encrypted: i=1; AJvYcCXYtga0LnhBbZb3koOg7NTX3NBWjBHBa1/R2RGn77suVrykiR5ITyJAQREsA7JnXke79Srq9XZnn9gxfDyo2Mi9iIwdcJS2fuORLqR2+Wc=
X-Gm-Message-State: AOJu0YyAkW0kBfXix5pYBM3cY3X9XPeU+kRsnhnfcvRslunvu1664q14
	dKMwCFZ4jEFCoGwPMA7bptsg8prNMUxaUpznDKPS7dnWePOH5Ko/3OnVhYG9Op9QTaWNRlq+8i/
	t5e2C3b+EzxPyyPnqbBCIjl58v8pP03NhmCTkVmwVHj8hMq+ZN5mriz7Gdxzxo3B/krO85Rmafy
	Cpml2S/PYsJwLDJHhKNlkYBZsIaITY4eXL6aEQ8bY=
X-Received: by 2002:a17:90a:c688:b0:2c2:d73e:2a93 with SMTP id 98e67ed59e1d1-2c6c8b2cc53mr1679766a91.5.1718671970478;
        Mon, 17 Jun 2024 17:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFY13tM/YuCaVcyGgJAl0trnmQdTmH5/e7E3aknmgTUjeYb9pzBSwU3i0tkRQHPm/ryt/rSyjtel1uPPIEAMU=
X-Received: by 2002:a17:90a:c688:b0:2c2:d73e:2a93 with SMTP id
 98e67ed59e1d1-2c6c8b2cc53mr1679741a91.5.1718671970118; Mon, 17 Jun 2024
 17:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion> <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion> <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion> <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com> <ZnACPN-uDHZAwURl@nanopsycho.orion>
In-Reply-To: <ZnACPN-uDHZAwURl@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Jun 2024 08:52:38 +0800
Message-ID: <CACGkMEvYC0vV9McY=G6V9K56yqtc5=9RVk7XbVX495GYyRcQcg@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:30=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Mon, Jun 17, 2024 at 03:44:55AM CEST, jasowang@redhat.com wrote:
> >On Mon, Jun 10, 2024 at 10:19=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> >>
> >> On Fri, Jun 07, 2024 at 01:30:34PM +0200, Jiri Pirko wrote:
> >> > Fri, Jun 07, 2024 at 12:23:37PM CEST, mst@redhat.com wrote:
> >> > >On Fri, Jun 07, 2024 at 11:57:37AM +0200, Jiri Pirko wrote:
> >> > >> >True. Personally, I would like to just drop orphan mode. But I'm=
 not
> >> > >> >sure others are happy with this.
> >> > >>
> >> > >> How about to do it other way around. I will take a stab at sendin=
g patch
> >> > >> removing it. If anyone is against and has solid data to prove orp=
han
> >> > >> mode is needed, let them provide those.
> >> > >
> >> > >Break it with no warning and see if anyone complains?
> >> >
> >> > This is now what I suggested at all.
> >> >
> >> > >No, this is not how we handle userspace compatibility, normally.
> >> >
> >> > Sure.
> >> >
> >> > Again:
> >> >
> >> > I would send orphan removal patch containing:
> >> > 1) no module options removal. Warn if someone sets it up
> >> > 2) module option to disable napi is ignored
> >> > 3) orphan mode is removed from code
> >> >
> >> > There is no breakage. Only, hypotetically performance downgrade in s=
ome
> >> > hypotetical usecase nobody knows of.
> >>
> >> Performance is why people use virtio. It's as much a breakage as any
> >> other bug. The main difference is, with other types of breakage, they
> >> are typically binary and we can not tolerate them at all.  A tiny,
> >> negligeable performance regression might be tolarable if it brings
> >> other benefits. I very much doubt avoiding interrupts is
> >> negligeable though. And making code simpler isn't a big benefit,
> >> users do not care.
> >
> >It's not just making code simpler. As discussed in the past, it also
> >fixes real bugs.
> >
> >>
> >> > My point was, if someone presents
> >> > solid data to prove orphan is needed during the patch review, let's =
toss
> >> > out the patch.
> >> >
> >> > Makes sense?
> >>
> >> It's not hypothetical - if anything, it's hypothetical that performanc=
e
> >> does not regress.  And we just got a report from users that see a
> >> regression without.  So, not really.
> >
> >Probably, but do we need to define a bar here? Looking at git history,
> >we didn't ask a full benchmark for a lot of commits that may touch
>
> Moreover, there is no "benchmark" to run anyway, is it?

Yes, so my point is to have some agreement on

1) what kind of test needs to be run for a patch like this.
2) what numbers are ok or not

Thanks

>
>
> >performance.
> >
> >Thanks
> >
> >>
> >> >
> >> > >
> >> > >--
> >> > >MST
> >> > >
> >>
> >
>

