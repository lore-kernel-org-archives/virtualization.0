Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4353E47B
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742881; cv=none; b=imS5pT6WRN2JQIcg9iyXX8pZE/AAbdSi0xembpaboD89srRgUjWYxRejorGAkXHRWklGud43X7bPHWBVqUJ6VgXSSGTwn7Anj/ZY+2yoI1TdCobqbwaYOUPd1ZM1WFVXjlzyGfmHGYhsLgn20Jskjmnth7SnzKCQiIH9wOPzwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742881; c=relaxed/simple;
	bh=IBqgcjtfkPxQ+RYhOLR7CfizykAPSvXKAo4SQJuuNKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7ttbbw69+woZ+tk5tqJdGje1WU0ZFcHw4TF//MX245oKLh2kaXp9C5dJ9QU5nTRuJuVNpiEjH0vJWUNdbmElW2PxX3KWUWGnGHEZZf5QnwUSTGdCFrIIF85OGYuhjL+spnfdnYQWXsHZbXAOIMRjE+LDIzjLuUASHkjcyXsL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGhlp2Hx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGhlp2Hx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717742879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J03Kp2Piu0WaqvcpbAKDUqC79Y14t4Zaki70ezbKPXM=;
	b=RGhlp2HxR0RCRo6DBnvY3rR9yW3Bsk0iPEZezjbq40KamIVC0bY6rNM1ZXzRyFU+UfRwg9
	PHL5JCnrmoDMtBfzAfBOyHN0ty1ScVS/B+F+xfP10Q75g2yLOttlOlj3eTseVKffovmJJc
	mfGVvjX1KymbLkxirPLXI5wCSKfuP5A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-qwEqfT8kPj-_Oc_4cuXDXw-1; Fri, 07 Jun 2024 02:47:57 -0400
X-MC-Unique: qwEqfT8kPj-_Oc_4cuXDXw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bf8512aa8dso1640898a91.1
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 23:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742876; x=1718347676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J03Kp2Piu0WaqvcpbAKDUqC79Y14t4Zaki70ezbKPXM=;
        b=AsAohTex6g2E9O7pUbCYMcs4zzq0klOH2FlQKpnFRYBZl7wBPiEkAoWvoiR/nZS5Yl
         faJruyNEGI35Kz1ZK3ZnnkGt7JNLMsDSx3ktV26mg3qltaZr2RicI+FLomYtWq+8e53g
         db5TdlnY+rLJJ1yJwx+JOzlCgDsLhbL1osUjJPOh43kYAMXltIhndUexYQUsRVSJ9zTy
         L1CTTbeBLYt88yXpaLE7fxYlUnGoAeYfZMd35GdsQtGPDB6/nV8jXaaD2TwEd+iAJ/9q
         lQ5C/pLPWr5u+6P+JtWf+qFaHJ5jDi9+ceXlGfy56hlDgNaqoiLHIXIzriZvKPJYtbJE
         LzPA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Dcr9vUFAaEpJ55lqBccmUugpe/zX6RIsNQ62afe33h50p4lPimrzFG4fWdzGPfbQSdi+CXHmwHz9plFwglCiq/f7/JsQDCvX8Vic9ZI=
X-Gm-Message-State: AOJu0YwoheVGgIzgRpmniji40dEBiplIaNBQdxBSALSEOUetqYshsg3U
	VD4IbAilKboY/beVBdbQWx12WmiaUSOHwm00EFZOXVShweNkHIHkuPP/qKgi9mbVwq+D400CDOg
	cSRayCmQ0mW5qBqFXRKxH09eHr5RvI9O9vbyAR3oAHfsZfa+P1vIX1G6MPK5VtkSyhxbbGkWYVd
	VOeO6q0gEYFwEwKZ/IQfx3msO8frtTZtlWQEsAiQk=
X-Received: by 2002:a17:90a:ab88:b0:2bd:d42b:22dc with SMTP id 98e67ed59e1d1-2c2bcc5d648mr1680460a91.43.1717742876096;
        Thu, 06 Jun 2024 23:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYFmmfqHuA2Hv2pzK0DIRXS2in8abdxsG1OUe4Q27XZMjutmwqEaAflzBjQsZNBuB9U9eJ9WCxrytqvrPEzsM=
X-Received: by 2002:a17:90a:ab88:b0:2bd:d42b:22dc with SMTP id
 98e67ed59e1d1-2c2bcc5d648mr1680441a91.43.1717742875690; Thu, 06 Jun 2024
 23:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZktGj4nDU4X0Lxtx@nanopsycho.orion> <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com> <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org> <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
In-Reply-To: <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jun 2024 14:47:43 +0800
Message-ID: <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
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

On Fri, Jun 7, 2024 at 2:39=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 6, 2024 at 9:45=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
> >> >On Thu, Jun 6, 2024 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> >> >>
> >> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> >> >> > > If the codes of orphan mode don't have an impact when you enabl=
e
> >> >> > > napi_tx mode, please keep it if you can.
> >> >> >
> >> >> > For example, it complicates BQL implementation.
> >> >> >
> >> >> > Thanks
> >> >>
> >> >> I very much doubt sending interrupts to a VM can
> >> >> *on all benchmarks* compete with not sending interrupts.
> >> >
> >> >It should not differ too much from the physical NIC. We can have one
> >> >more round of benchmarks to see the difference.
> >> >
> >> >But if NAPI mode needs to win all of the benchmarks in order to get
> >> >rid of orphan, that would be very difficult. Considering various bugs
> >> >will be fixed by dropping skb_orphan(), it would be sufficient if mos=
t
> >> >of the benchmark doesn't show obvious differences.
> >> >
> >> >Looking at git history, there're commits that removes skb_orphan(), f=
or example:
> >> >
> >> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
> >> >Author: Eric Dumazet <edumazet@google.com>
> >> >Date:   Fri Sep 28 07:53:26 2012 +0000
> >> >
> >> >    mlx4: dont orphan skbs in mlx4_en_xmit()
> >> >
> >> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
> >> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
> >> >    since skb wont stay a long time in TX ring before their release.
> >> >
> >> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
> >> >    possible, since it breaks TCP Small Queue or other flow control
> >> >    mechanisms (per socket limits)
> >> >
> >> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
> >> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
> >> >    Signed-off-by: David S. Miller <davem@davemloft.net>
> >> >
> >> >>
> >> >> So yea, it's great if napi and hardware are advanced enough
> >> >> that the default can be changed, since this way virtio
> >> >> is closer to a regular nic and more or standard
> >> >> infrastructure can be used.
> >> >>
> >> >> But dropping it will go against *no breaking userspace* rule.
> >> >> Complicated? Tough.
> >> >
> >> >I don't know what kind of userspace is broken by this. Or why it is
> >> >not broken since the day we enable NAPI mode by default.
> >>
> >> There is a module option that explicitly allows user to set
> >> napi_tx=3Dfalse
> >> or
> >> napi_weight=3D0
> >>
> >> So if you remove this option or ignore it, both breaks the user
> >> expectation.
> >
> >We can keep them, but I wonder what's the expectation of the user
> >here? The only thing so far I can imagine is the performance
> >difference.
>
> True.
>
> >
> >> I personally would vote for this breakage. To carry ancient
> >> things like this one forever does not make sense to me.
> >
> >Exactly.
> >
> >> While at it,
> >> let's remove all virtio net module params. Thoughts?
> >
> >I tend to
> >
> >1) drop the orphan mode, but we can have some benchmarks first
>
> Any idea which? That would be really tricky to find the ones where
> orphan mode makes difference I assume.

True. Personally, I would like to just drop orphan mode. But I'm not
sure others are happy with this.

Thanks

>
>
> >2) keep the module parameters
>
> and ignore them, correct? Perhaps a warning would be good.
>
>
> >
> >Thanks
> >
> >>
> >>
> >>
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >> --
> >> >> MST
> >> >>
> >> >
> >>
> >
>

