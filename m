Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364115250B
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742624; cv=none; b=TLTP9oPgbHCv6PngmQHqsf9BToE+b0M3B0xLnzAtjf0QvTc01oMtDK+hsPNKZ1koqSEJdxGSZa67B+W9cQymCIWveZvgrbJSGpHfjl8qNT7HOvsOmU0gSPQYbUqmvX94hyEUhUMdjvK10QZcmTT2QDYyskPVuvr86TwW7bf1svk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742624; c=relaxed/simple;
	bh=/xdYMfcVV9jovDn+g8CmRv9oBT+5S/BDQQ3k7pb9crI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=imdx5E/EGazTPOmeyL5QNNxqXK943duAa9Boq5ulEl6oc8bEH65c+U52qW2miImTmbmekWrqZ8sli8/dSr6pf6HOI3n1J4TwGQXyfHokhuUciEO0q/h78p5QT7ZpVkljFF+u1W1zbBSvyrLo9qP7VcTco28JH0uRPRT+uGoSb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReNkz+l7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReNkz+l7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717742622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rL5WzBeZZQ0tho6qsKfq0awo3sDUhxqbwzK5xndnSDY=;
	b=ReNkz+l70pV0Cik/y5N77KkvYmM6L0bDr/xRmQGrs5VIAC27ZXamG2hyZj2O77kfotT0V3
	igyb8Eevjq+DeI2fUfY7RbykNFhV3RXX7kkAJ3nq3UbaPdsC8nKJsXxfk5hgcbwryP92DJ
	YTsnYsdw0vxB2+8J3ATmmzwb/UrtMBY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-UR7AtYT2NPeoiC-iihYkMw-1; Fri, 07 Jun 2024 02:43:41 -0400
X-MC-Unique: UR7AtYT2NPeoiC-iihYkMw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57a4d24a479so548062a12.2
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 23:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742615; x=1718347415;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL5WzBeZZQ0tho6qsKfq0awo3sDUhxqbwzK5xndnSDY=;
        b=o9e2tMg6lzSBbAI5m18I/Y+K+Ftk45qJsHn7P7iIOOn5PrdYv1pnTyNBwu1+fd2Fcc
         vRuBtc6/0K4K0bP0HecWSqUosBstQL3xF23igFVFp+lQpC/WEtcEB++FdSj7x61uGMpj
         gYBy+wXAA7ionWUs7NlWL9EhHGDYaHDQ/Q+nullTxuekAF1Xu1CQpXN3TbQWT49EajIG
         yebELkFo6nbwFtN9idM3Eb2VQ92EYNW9L3goT0XoWeSh2VYsqcagz20rjuv7NIK2UmrD
         yQ6UTB19tK3+iUTNMFFYASIzzhPlLnhDv2xj6FJ51fdZ5WPpCTiZ1kMPl6bHaEGNj3R1
         U1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXbi8NP1yovZBugNnenSVYsThSuzZMwde+4mihU4fG0Qxx/F9mP1uKdTyaVeZYJLyff284hbdu1qmD7O66RrYf7vnLqlb+GfiUUc02YEw=
X-Gm-Message-State: AOJu0YwX3bIweYnylbwHT8yAqHM7+lQFrpO2coFGM1yWswpZrnUDPJtD
	n95pUM5wVKYmqa0GG4A2SesGWHYGdMzhdrjMbJKXbIjuegAPdtfiajkLgj3+C7fEjm4hnvv7V1I
	ftInda4UfKTVKsgOd+0z6iwX4u5ENFt5yYW03N+1hq9vdAy6+Q5VHymr9AjGLweO2
X-Received: by 2002:a50:a68e:0:b0:57a:3424:b36e with SMTP id 4fb4d7f45d1cf-57c508eeee7mr876446a12.13.1717742614775;
        Thu, 06 Jun 2024 23:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmnJhQeO92KUlefgY2U2zoUjx1WCCNehyRAvLNjZi3NHcq2+9YWY/j/rrHZp93GT2w5IFl8A==
X-Received: by 2002:a50:a68e:0:b0:57a:3424:b36e with SMTP id 4fb4d7f45d1cf-57c508eeee7mr876422a12.13.1717742614192;
        Thu, 06 Jun 2024 23:43:34 -0700 (PDT)
Received: from redhat.com ([2.55.8.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae20243esm2224517a12.68.2024.06.06.23.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:43:33 -0700 (PDT)
Date: Fri, 7 Jun 2024 02:43:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240607024057-mutt-send-email-mst@kernel.org>
References: <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 07, 2024 at 08:39:20AM +0200, Jiri Pirko wrote:
> Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
> >On Thu, Jun 6, 2024 at 9:45 PM Jiri Pirko <jiri@resnulli.us> wrote:
> >>
> >> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
> >> >On Thu, Jun 6, 2024 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> >>
> >> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> >> >> > > If the codes of orphan mode don't have an impact when you enable
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
> >> >will be fixed by dropping skb_orphan(), it would be sufficient if most
> >> >of the benchmark doesn't show obvious differences.
> >> >
> >> >Looking at git history, there're commits that removes skb_orphan(), for example:
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
> >> napi_tx=false
> >> or
> >> napi_weight=0
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

Exactly. We are kind of stuck with it I think.
I would just do this:

void orphan_destructor(struct sk_buff *skb)
{
}

	skb_orphan(skb);
	skb->destructor = orphan_destructor;
	/* skip BQL */
	return;


and then later
	/* skip BQL accounting if we orphaned on xmit path */
	if (skb->destructor == orphan_destructor)
		return;



Hmm?


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

