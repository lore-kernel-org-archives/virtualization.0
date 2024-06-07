Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820961CABF
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741369; cv=none; b=aSXLf7ogtyR2KINl/QTwPi25vqJ3u+8CEVH10HrE4FU+tvi2ndvDUwRGwcuBJoRzMQacN7fqBtPvpznnqWlqM0RyW8Ao5jTsBdPAtVA56VqEoS0ULUMl/Ngua2la7192eituFLyWj1ed03v5U639wNU0pWr+QnuQPkjFji4r90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741369; c=relaxed/simple;
	bh=LKuBQ28/1yz/CT83kCvNLcsL4DfCoTKrprm3yfzJhlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tm5i1AbhfOEFGi2AfC7rudHz/wSUd1RntQZT2iOdur2a2iTK5GFQOekCngEgdNQ6m3NkqWoD2khiRJr4lSwONB3YMQTVWdX/p+g2JRPZaQNCIKN8eJaGd0yVlvwyzC6N1EmEhtflM9FBSLA1Xm4f21Z1HglWNJrGl2U+IXQ6ZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cm9uuIMl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cm9uuIMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717741366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BpY/LvUhfACDsxU4VlJjRaAtdugouYaei4Fra/b/gc=;
	b=cm9uuIMlU7cMya7BCmUes/OnoQt7cJgMVY1eEeV0ngcSndwU1kciPkrmlYR527WePC27fG
	qMZy/6Vsj+aALjFd7BhlziBad7jDYB+CbGMdLt0xmfcDX0IX6hYUfI+oOdbrKCrlYN6d8x
	9188ubTGJMPBlT5V7N5RaEL0S/QgfKw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-NmtpkD47M2GsEnnixgPHew-1; Fri, 07 Jun 2024 02:22:45 -0400
X-MC-Unique: NmtpkD47M2GsEnnixgPHew-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c2c9ae984aso64155a91.1
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 23:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717741364; x=1718346164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BpY/LvUhfACDsxU4VlJjRaAtdugouYaei4Fra/b/gc=;
        b=SlgaerbTz9jimcz0GnmMVxJD2Ok2yJz/HUElneyQCxuYbLb+4qjIfjJ3+pu/vAcd3S
         /rD3W7o7hn6s1IpOs/QlNU0rydeX9sdqToJPZlHe8AYiDXHYynsLyMS4YwlCRhL9Z12S
         ixrMiyBvjs1hhQkeh6njjGCiCwLMk3oqElRl/TBH4FQ9A3ifqlfI4XyjEEOzvKRPYyfA
         I3yg8CCYN0BABxn4fmtoLHlzsr9e2L9eWhm7/nXOw8u52YbIK1j3xsykZ4TeJpsxh4W1
         L5WlX06qnKNsMA7gZ57oRGnQn5dsnfX5xu2ZWSxZehZajnKyJEg1CWTQGaWglWItvETp
         eIOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdRhdAH+bpUg8nRFDACZI7ECfXhXnkGoowjySi/j1prCPgq0+EcT0mcUW3k3Ytm6fEhmNKpIoqkE3Gfc3VCn5puclWscC6eGQF/aktgp0=
X-Gm-Message-State: AOJu0Yz4GvJ40/nSiIl5UszRkkqI21I394nPXnxA/okNMEbqXqdo7Bm+
	dJyTokguTd0lJRArdd61bMwre1jSoVy9HUwNv4lD/c2yJu/eQawwJQ7mfmo/ucXRrvHMmXwUSwQ
	U3Yc79eJZXl68XYKCZ8CrzhwbRvrBQCam/OD+yb5fvzTLkS/m/RiSURcymK7qaXeiiyG1bRa81A
	EemLdS9d37TPEXhcjKxxJuZks/OE+34lf/LtcylHw=
X-Received: by 2002:a17:90a:34c9:b0:2c2:c65f:2061 with SMTP id 98e67ed59e1d1-2c2c65f22femr416856a91.31.1717741363971;
        Thu, 06 Jun 2024 23:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyBZS5h+R8JA9Tc22RmwY8UoPLjde+OK53I9oajlQ717pQ3ervU6OuHFyTP+CRXM9T7JkR3n43g0OFCRYv8dw=
X-Received: by 2002:a17:90a:34c9:b0:2c2:c65f:2061 with SMTP id
 98e67ed59e1d1-2c2c65f22femr416835a91.31.1717741363472; Thu, 06 Jun 2024
 23:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us> <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com> <ZmG8eMl3E4GvGl2b@nanopsycho.orion>
In-Reply-To: <ZmG8eMl3E4GvGl2b@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jun 2024 14:22:31 +0800
Message-ID: <CACGkMEv1+ZSPiy5w1SN=a73-XCwCR6vE35LWNpqhaVAom71afQ@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:41=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Jun 06, 2024 at 06:25:15AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 6, 2024 at 10:59=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >>
> >> Hello Jason,
> >>
> >> On Thu, Jun 6, 2024 at 8:21=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> >> >
> >> > On Wed, Jun 5, 2024 at 7:51=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >> > >
> >> > > On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> w=
rote:
> >> > > > Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> >> > > > >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com =
wrote:
> >> > > > >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.=
us> wrote:
> >> > > > >>> From: Jiri Pirko <jiri@nvidia.com>
> >> > > > >>>
> >> > > > >>> Add support for Byte Queue Limits (BQL).
> >> > > > >>
> >> > > > >>Historically both Jason and Michael have attempted to support =
BQL
> >> > > > >>for virtio-net, for example:
> >> > > > >>
> >> > > > >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521=
e1bc3@redhat.com/
> >> > > > >>
> >> > > > >>These discussions focus primarily on:
> >> > > > >>
> >> > > > >>1. BQL is based on napi tx. Therefore, the transfer of statist=
ical information
> >> > > > >>needs to rely on the judgment of use_napi. When the napi mode =
is switched to
> >> > > > >>orphan, some statistical information will be lost, resulting i=
n temporary
> >> > > > >>inaccuracy in BQL.
> >> > > > >>
> >> > > > >>2. If tx dim is supported, orphan mode may be removed and tx i=
rq will be more
> >> > > > >>reasonable. This provides good support for BQL.
> >> > > > >
> >> > > > >But when the device does not support dim, the orphan mode is st=
ill
> >> > > > >needed, isn't it?
> >> > > >
> >> > > > Heng, is my assuption correct here? Thanks!
> >> > > >
> >> > >
> >> > > Maybe, according to our cloud data, napi_tx=3Don works better than=
 orphan mode in
> >> > > most scenarios. Although orphan mode performs better in specific b=
enckmark,
> >> >
> >> > For example pktgen (I meant even if the orphan mode can break pktgen=
,
> >> > it can finish when there's a new packet that needs to be sent after
> >> > pktgen is completed).
> >> >
> >> > > perf of napi_tx can be enhanced through tx dim. Then, there is no =
reason not to
> >> > > support dim for devices that want the best performance.
> >> >
> >> > Ideally, if we can drop orphan mode, everything would be simplified.
> >>
> >> Please please don't do this. Orphan mode still has its merits. In some
> >> cases which can hardly be reproduced in production, we still choose to
> >> turn off the napi_tx mode because the delay of freeing a skb could
> >> cause lower performance in the tx path,
> >
> >Well, it's probably just a side effect and it depends on how to define
> >performance here.
> >
> >> which is, I know, surely
> >> designed on purpose.
> >
> >I don't think so and no modern NIC uses that. It breaks a lot of things.
> >
> >>
> >> If the codes of orphan mode don't have an impact when you enable
> >> napi_tx mode, please keep it if you can.
> >
> >For example, it complicates BQL implementation.
>
> Well, bql could be disabled when napi is not used. It is just a matter
> of one "if" in the xmit path.

Maybe, care to post a patch?

The trick part is, a skb is queued when BQL is enabled but sent when
BQL is disabled as discussed here:

https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.=
com/

Thanks

>
>
> >
> >Thanks
> >
> >>
> >> Thank you.
> >>
> >
>

