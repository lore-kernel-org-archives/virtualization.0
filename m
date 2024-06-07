Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BEA4CB36
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717741537; cv=none; b=MOkeP+eM8nKsq6rGKC0ZnFf9kFzZgldLQZWxiE3rVhJU8QsZXfpWfUX4Ev3OVO5RyoI2wVzubsAsaK119iX9ymyPZMkGjwIbh4bFfmEiXA9/j6+6TzpSbYis20Oae/7TMRgjCTzMGoissUARulZNX/ozg8haYZbA10qdLKvN9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717741537; c=relaxed/simple;
	bh=vNSvPl6arDFt3bloR5w0I1uaCU7Peho4prbi2Lx8/9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkFHHoCF7HblzhXdp/bBZ2ioiWOFXwroaTMhYOsbsdFuVG70+6Nj0yTB47uVKiFofGm9QveNlorA0BuK6tuB+aPUE5+2ay7b0wf9RTcybLTbjwgNgd/FxvSWgN0vLkWLlHyDh2xIwvSOzGLFkihOCwBWnIYUFsjkcObgxB6JkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A01Bw5kG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A01Bw5kG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717741535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPombUCSKVXobqHvHlGD2t6hSXSJCfgvNAdOEXWRbHw=;
	b=A01Bw5kGEjuW3btk8CQzIG20n7O5Q+o+r1grEMwEsZQsfRyHJ1Jrk/GGroAMX6E/V0cu0W
	VJa05SaAGzK1C0VQhZo5YkUBCpcs54qECh3y3qKp0LtX3dcs7bcGV8uhEhkOeVqpex2wTb
	M6Ao+Pn47CUglsi+Di9uQ7BNHaLeGOs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-b2Otk-WhPjmS9DK6YCmh5A-1; Fri, 07 Jun 2024 02:25:33 -0400
X-MC-Unique: b2Otk-WhPjmS9DK6YCmh5A-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-681877855adso1544686a12.0
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 23:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717741531; x=1718346331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPombUCSKVXobqHvHlGD2t6hSXSJCfgvNAdOEXWRbHw=;
        b=HxPnzZKZZuIRUUbU5J9kJlCfDg8nzonW4xPVW3iSnx/38CYwvAhbIOzlr9pvE8l3wi
         mIm8bbIH5lARZI6blND4mtmzXJDcHNWOmPiCPCz78CqOp4WhyQvc7nYi1T3Yh9TrC54+
         RcOiXTYzARRfTEu/sMly1FtJqUUrNgeDtteA1jvKE2szXKppuLZXHLC3n8xFXAae+P3i
         jZLeONxEgEggLTi5+BSR+oSh0TG/OJTVgcL9ct2+jmaQ0s5TAljmq2LyPKvAqjZsLwNL
         ZY5IFTgk1H7394GZjfbCQdxtBqsfRh4YwUsGOSuX8DnDggLa+vi0ZjoFl3n9J+JE/TJE
         538Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQCiomPmlA5lI2zt8bo/qJCXN1jkCuK2lj+enOyv1fHyhybr6q1u9bwn9boXHse4xb/eWmYONAXxLr+fAxcsYNbYdXsMb7d0gR/ha62e8=
X-Gm-Message-State: AOJu0YyNqb/4KbsF7w6tmclhtftildEjx+l7qXmhL2wo7pWQgIFL5Jrt
	5OeTp9whmI9hl/fh0GX0VKMGBVwtmYqM458DKWqxUmUlD08MezLVCo+Zj0eOVfyVgZBFcjrTPam
	xjPx7y1KmtmuJercArCaHJ9u54/eCTSVWc1nyI1bm4ywN9/xfxY+T5lvR2jKB9lBhBI2fM6W6Ax
	GAoxrB5vE3HBhdi9tHJkYZJF2iTEqq/wxaF2Pjy7A=
X-Received: by 2002:a05:6a21:3393:b0:1af:cfc2:8069 with SMTP id adf61e73a8af0-1b2f96d6969mr2022367637.4.1717741531261;
        Thu, 06 Jun 2024 23:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUi4WYnn4OxXsHHOSsqUiW4sOic725gpoYQvC+aEOeUdW/61KfsYupAjPBn+0SnlkmpiFzup0Mi2qIQpb+b9Y=
X-Received: by 2002:a05:6a21:3393:b0:1af:cfc2:8069 with SMTP id
 adf61e73a8af0-1b2f96d6969mr2022351637.4.1717741530901; Thu, 06 Jun 2024
 23:25:30 -0700 (PDT)
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
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org> <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
In-Reply-To: <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jun 2024 14:25:19 +0800
Message-ID: <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
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

On Thu, Jun 6, 2024 at 9:45=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 6, 2024 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >>
> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> >> > > If the codes of orphan mode don't have an impact when you enable
> >> > > napi_tx mode, please keep it if you can.
> >> >
> >> > For example, it complicates BQL implementation.
> >> >
> >> > Thanks
> >>
> >> I very much doubt sending interrupts to a VM can
> >> *on all benchmarks* compete with not sending interrupts.
> >
> >It should not differ too much from the physical NIC. We can have one
> >more round of benchmarks to see the difference.
> >
> >But if NAPI mode needs to win all of the benchmarks in order to get
> >rid of orphan, that would be very difficult. Considering various bugs
> >will be fixed by dropping skb_orphan(), it would be sufficient if most
> >of the benchmark doesn't show obvious differences.
> >
> >Looking at git history, there're commits that removes skb_orphan(), for =
example:
> >
> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
> >Author: Eric Dumazet <edumazet@google.com>
> >Date:   Fri Sep 28 07:53:26 2012 +0000
> >
> >    mlx4: dont orphan skbs in mlx4_en_xmit()
> >
> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
> >    since skb wont stay a long time in TX ring before their release.
> >
> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
> >    possible, since it breaks TCP Small Queue or other flow control
> >    mechanisms (per socket limits)
> >
> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
> >    Signed-off-by: David S. Miller <davem@davemloft.net>
> >
> >>
> >> So yea, it's great if napi and hardware are advanced enough
> >> that the default can be changed, since this way virtio
> >> is closer to a regular nic and more or standard
> >> infrastructure can be used.
> >>
> >> But dropping it will go against *no breaking userspace* rule.
> >> Complicated? Tough.
> >
> >I don't know what kind of userspace is broken by this. Or why it is
> >not broken since the day we enable NAPI mode by default.
>
> There is a module option that explicitly allows user to set
> napi_tx=3Dfalse
> or
> napi_weight=3D0
>
> So if you remove this option or ignore it, both breaks the user
> expectation.

We can keep them, but I wonder what's the expectation of the user
here? The only thing so far I can imagine is the performance
difference.

> I personally would vote for this breakage. To carry ancient
> things like this one forever does not make sense to me.

Exactly.

> While at it,
> let's remove all virtio net module params. Thoughts?

I tend to

1) drop the orphan mode, but we can have some benchmarks first
2) keep the module parameters

Thanks

>
>
>
> >
> >Thanks
> >
> >>
> >> --
> >> MST
> >>
> >
>

