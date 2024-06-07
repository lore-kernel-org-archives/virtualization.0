Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63018FDAF
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759364; cv=none; b=Tk3R80aR8r+DF+bXlW43RALpUvC6865A9oO935HJJV5We0bHmYc8RMpmLBAoVvLvl5c5pxa6n5dLWN7vKBc+LsY864HuK9Sj/5RGxNaEhOQVydKD4CpzYg7VPqBBGkFZ+bV3pxiXdq0l6OmEFEUIT4kkCvygEdRzksLNUqi1gxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759364; c=relaxed/simple;
	bh=Upz4RiLLWtkT9CH3fuydHOi5B6ipHJ6OVJUwdL5BG9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzWV7WgarW6gvMQyPWqOjw/kS5zQJB9FJ3y7RzfBRojS7XHv5zqDtDx744gTaHISGOtmhRfL0QQB7+0APD3VAyuX6kKq4Tkfv2mTK79SBsh30ZFkAQ5NeeWfq+koKc7FKpAzDK3ZSHb0vM2iZhaHXe/l4+pgZSsZXL5e3Tzv+Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz0bLf3J; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz0bLf3J"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63a96so2491017a12.0
        for <virtualization@lists.linux.dev>; Fri, 07 Jun 2024 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759361; x=1718364161; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxNSiv0bWToch8vRIYw3I2Yt7g0qfD37HpIws5gP+EQ=;
        b=dz0bLf3J1mN7N6vEF2VL4QNRTduEKAu3YQZ3gsO09bww+jg3+V7BeTRXU1XUH4DL5B
         DnsGP1UrKgQQkh7WhSFdF7FD1QmboapmqqVd4CMLyvVDEySowHcfTcxsH+luQh3wdIbg
         MjK+Xg6txqwtmQuxPfsTZtJOUuuLtIpJg5GeC0ilJKKihpjB1ttlF4rFUTYMvbDUAXVB
         NxywqaN63Fa/WD2ydhn+RrrwzmL9t5iU0btaVfmi5tP97xtp5zKN/W1ZO728XO1+7sVY
         cH2lum+vKCaGPVPgPbDkCMWNdfrh6sqKobIUcouchiz7H6UtxscwNrN8iN7/TD0ZdE3r
         i0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759361; x=1718364161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxNSiv0bWToch8vRIYw3I2Yt7g0qfD37HpIws5gP+EQ=;
        b=LEmWMBjArIZWaCRHjUBk9IuHYRAqGDEKG27u8jKxXlfrEIc+Zy953wStDX7UE5M8Hz
         r5K5f26zR8ltqkN8WV4EEl99qq7tYYlO7dwgWhyRJoJ4ZQsYDfRjD5Sr6dvrSEafavVt
         HEmfDbOJVxOkfoFOqKFbIVnzlk3ktqvswuoieAzomCaZ9yz0oHRrrl2+exBw/400N69u
         Ti27xo81T+mThI1+EOB5A9dPtvdvz643Y5V8KzobZ4H0FDKRAbGG9cYOsyElLkEhXyeu
         mXVX24U7H+OxZNZM3HjO8BmHbvwaobqZihVCoC0ic/9j6cShxMthrqzX3pSevT2xeQZ6
         wtlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvClB0noUlvJqqUMbKvOI8ce5dU3w2JmlhYLOcoS3k37S7gUu+c0HaTKoSRcMsQbQSHfJsMlAHnJBgaGOiZyrhaOQoGlTraaltsgR6SW4=
X-Gm-Message-State: AOJu0YxDwYJDBmwSz+sTn2mxg8seYdjGYumA9b2T5q7p4iZg5zLsHdf9
	TsLhCpQBDoD0+n7bhD/dDSbcFht1bGMBWiMl6VWs+jXLNq0uHOPfaqOruNZoPQHHJHdRfmiqwZA
	CfUgn71qO8Hs+cZ/2a/CneP01bHA=
X-Google-Smtp-Source: AGHT+IFl8WNNejbJBPSnM878qXzHJOSh1drIJWdih0hjfQVp/eOvbIsLzMksGRbMR4kJq3oF0DegXvPSo+XZyKi7tYU=
X-Received: by 2002:a50:c2d9:0:b0:57c:5fc8:c95d with SMTP id
 4fb4d7f45d1cf-57c5fc8ca83mr575351a12.18.1717759360518; Fri, 07 Jun 2024
 04:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org> <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion> <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion> <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
In-Reply-To: <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Jun 2024 19:22:02 +0800
Message-ID: <CAL+tcoCRSCvbwxNibDu7MdWXF77qjROd1eTeyZN6Sh-ckXDQrw@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 5:57=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Fri, Jun 07, 2024 at 08:47:43AM CEST, jasowang@redhat.com wrote:
> >On Fri, Jun 7, 2024 at 2:39=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
> >> >On Thu, Jun 6, 2024 at 9:45=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> =
wrote:
> >> >>
> >> >> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
> >> >> >On Thu, Jun 6, 2024 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> >> >> >>
> >> >> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> >> >> >> > > If the codes of orphan mode don't have an impact when you en=
able
> >> >> >> > > napi_tx mode, please keep it if you can.
> >> >> >> >
> >> >> >> > For example, it complicates BQL implementation.
> >> >> >> >
> >> >> >> > Thanks
> >> >> >>
> >> >> >> I very much doubt sending interrupts to a VM can
> >> >> >> *on all benchmarks* compete with not sending interrupts.
> >> >> >
> >> >> >It should not differ too much from the physical NIC. We can have o=
ne
> >> >> >more round of benchmarks to see the difference.
> >> >> >
> >> >> >But if NAPI mode needs to win all of the benchmarks in order to ge=
t
> >> >> >rid of orphan, that would be very difficult. Considering various b=
ugs
> >> >> >will be fixed by dropping skb_orphan(), it would be sufficient if =
most
> >> >> >of the benchmark doesn't show obvious differences.
> >> >> >
> >> >> >Looking at git history, there're commits that removes skb_orphan()=
, for example:
> >> >> >
> >> >> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
> >> >> >Author: Eric Dumazet <edumazet@google.com>
> >> >> >Date:   Fri Sep 28 07:53:26 2012 +0000
> >> >> >
> >> >> >    mlx4: dont orphan skbs in mlx4_en_xmit()
> >> >> >
> >> >> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for =
TX
> >> >> >    completions) we no longer need to orphan skbs in mlx4_en_xmit(=
)
> >> >> >    since skb wont stay a long time in TX ring before their releas=
e.
> >> >> >
> >> >> >    Orphaning skbs in ndo_start_xmit() should be avoided as much a=
s
> >> >> >    possible, since it breaks TCP Small Queue or other flow contro=
l
> >> >> >    mechanisms (per socket limits)
> >> >> >
> >> >> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> >> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
> >> >> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
> >> >> >    Signed-off-by: David S. Miller <davem@davemloft.net>
> >> >> >
> >> >> >>
> >> >> >> So yea, it's great if napi and hardware are advanced enough
> >> >> >> that the default can be changed, since this way virtio
> >> >> >> is closer to a regular nic and more or standard
> >> >> >> infrastructure can be used.
> >> >> >>
> >> >> >> But dropping it will go against *no breaking userspace* rule.
> >> >> >> Complicated? Tough.
> >> >> >
> >> >> >I don't know what kind of userspace is broken by this. Or why it i=
s
> >> >> >not broken since the day we enable NAPI mode by default.
> >> >>
> >> >> There is a module option that explicitly allows user to set
> >> >> napi_tx=3Dfalse
> >> >> or
> >> >> napi_weight=3D0
> >> >>
> >> >> So if you remove this option or ignore it, both breaks the user
> >> >> expectation.
> >> >
> >> >We can keep them, but I wonder what's the expectation of the user
> >> >here? The only thing so far I can imagine is the performance
> >> >difference.
> >>
> >> True.
> >>
> >> >
> >> >> I personally would vote for this breakage. To carry ancient
> >> >> things like this one forever does not make sense to me.
> >> >
> >> >Exactly.
> >> >
> >> >> While at it,
> >> >> let's remove all virtio net module params. Thoughts?
> >> >
> >> >I tend to
> >> >
> >> >1) drop the orphan mode, but we can have some benchmarks first
> >>
> >> Any idea which? That would be really tricky to find the ones where
> >> orphan mode makes difference I assume.
> >
> >True. Personally, I would like to just drop orphan mode. But I'm not
> >sure others are happy with this.
>
> How about to do it other way around. I will take a stab at sending patch
> removing it. If anyone is against and has solid data to prove orphan
> mode is needed, let them provide those.

Honestly, we in production have to use skb orphan mode. I cannot
provide enough and strong evidence about why default mode on earth
causes performance degradation in some cases. I mean I don't know the
root cause. The only thing I can tell is if I enable the skb orphan
mode, then 1)  will let more skb pass the TCP layer, 2) some key
members like snd_cwnd in tcp will behave normally.

I know without orphan mode the skb will be controlled/limited by the
combination of TSO and napi_tx mode thanks to sk_wmem_alloc. So I
_guess_ the root cause is: the possible delay of interrupts generated
by the host machine will cause the delay of freeing skbs, resulting in
the slowing down the tx speed. If the interval between two interrupts
is very short like the real NIC, I think the issue would disappear.

That's all I can tell. Just for record. Hope this information could
also be useful to other readers.

Thanks,
Jason

>
>
> >
> >Thanks
> >
> >>
> >>
> >> >2) keep the module parameters
> >>
> >> and ignore them, correct? Perhaps a warning would be good.
> >>
> >>
> >> >
> >> >Thanks
> >> >
> >> >>
> >> >>
> >> >>
> >> >> >
> >> >> >Thanks
> >> >> >
> >> >> >>
> >> >> >> --
> >> >> >> MST
> >> >> >>
> >> >> >
> >> >>
> >> >
> >>
> >
