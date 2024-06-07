Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096EF13BC35
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754265; cv=none; b=CVhNhLKZg5gYcqGbg6ZivWgOH8QCb9BcBrLtu7WyGwwgqPZeCF4Xfon/bCtUxyXBWbsoNVmpfMt2LMOB9JF9WyXG4SyaBWSjzooOklY2xPGK2WkOnbqlcBd9GmzOoWpMNfRXV38gzHdXl9EOQVzu4Jmnmz3+MWELj5dL6WTta3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754265; c=relaxed/simple;
	bh=/YVauGNkxfZmCtpgAS2qjdG1HQlwrBhQuUEQVIVA5E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb2LMCcSHllVOe4J8o2Yv8pBEGzptIQQRX6Ty9pOOJdZhpYilrZLBQCjchR2keVQJ9iypk3YRuyERPoHWwS5iSmUkQV7ufMdrlwMLZIvWDrT0sjg+7A+OW+xrkEjQv+0lvuFmJAJcTnE5N4ypH3YexQvj1yOuLs8swYQAD+BsUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yWKpYIqM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yWKpYIqM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so1665245e9.0
        for <virtualization@lists.linux.dev>; Fri, 07 Jun 2024 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717754261; x=1718359061; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lX/OsBtlFYO6Y1jhc0Js+/gWtM87drYmKWJU/1wy0xg=;
        b=yWKpYIqMD9FvsMTb7XZ6dc3fot2MCjMYLd89Z99cr1M0NTQAJYgy0f2RwUiw6H5ffI
         qfyAwdShzxPxiQjsf5k0F3euUAeWAXBZ+gEW/OT2UfKFiBuAAV5EyK2o5pFstPK71c5+
         CW33j4tjwZbBANYIeaTAjEQJUrgSBHof/NyQ2mBbgDbiez/+NOcO+KnyYbytH7HWPk0O
         ZpmL5CW9zvDUjpegboI0mXgBRPGUCSnRU1f7ggAfJTVawjDTqKsCQmsSQPkF9E9CsNHs
         tlnfvzmGV98Pr7+YJ3bQ0nN83UcK12m3BFdc/Y3qQ1NzFx7+dPxcaFsDPddFP+PsXJvK
         nI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717754261; x=1718359061;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lX/OsBtlFYO6Y1jhc0Js+/gWtM87drYmKWJU/1wy0xg=;
        b=TfZa78X5rdvQw073K0lPR0e6mnn0Wepd/65/f9uF5GTePMc7XCOJjwtrSPWsDagx60
         WYNDmJw6JW7p7/koP3vLlXwLEwEQlwk4HvrrTzS06lj7moYmHXBnpaWOrFx3j6SqA/zr
         EGud+S0/8tNTIUQPu5SNYTYOq9DlL9AOzxiqnIySwQyMD0VsgwsAVaN0c2w/zlan1BpF
         bKodwbNBI3kPKVTxVSc7YfINPXhi7kUkeJ/CEC7uGoM0RN768nW89lsrAsw1iA81zTFe
         nWo9tmYkWcH9bqgzSNGFO+Qh9iwGWyvB0vqouALrG8FmTm68nIkrP8uvUgZjMU5NMh1q
         1Erg==
X-Forwarded-Encrypted: i=1; AJvYcCVh45ZQ161+POQoi+6q3k6RpMNWNavX0Wrz1JArPwoKIzblSpGq9blK8mc9pcO3njcGvGxGQ5aHIo9xbho1hYvmPQGt9fqZ8BvF6JMJ1nc=
X-Gm-Message-State: AOJu0YyAGQDeqBCXc2Yh60dktJVdZIOX01TrLb/s0k0XzJEmbsa2jdZR
	sdZVXqGJAwgoBHkaDIbR3TnJVDQ8ISUCGQ5mJJpv9vrlYeTjrsNaPWOYgYk1sqY=
X-Google-Smtp-Source: AGHT+IGiT+DP9lfy1eyklkV6A+U2eSaMxY6fdfTimXtGyCadSjz3weq17UsEuiihRR50xbG06KxRiQ==
X-Received: by 2002:a05:600c:524e:b0:421:4754:c49a with SMTP id 5b1f17b1804b1-42164a20cd0mr21493755e9.31.1717754260933;
        Fri, 07 Jun 2024 02:57:40 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215811d992sm79620645e9.26.2024.06.07.02.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:57:40 -0700 (PDT)
Date: Fri, 7 Jun 2024 11:57:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
References: <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>

Fri, Jun 07, 2024 at 08:47:43AM CEST, jasowang@redhat.com wrote:
>On Fri, Jun 7, 2024 at 2:39 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
>> >On Thu, Jun 6, 2024 at 9:45 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
>> >> >On Thu, Jun 6, 2024 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> >>
>> >> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
>> >> >> > > If the codes of orphan mode don't have an impact when you enable
>> >> >> > > napi_tx mode, please keep it if you can.
>> >> >> >
>> >> >> > For example, it complicates BQL implementation.
>> >> >> >
>> >> >> > Thanks
>> >> >>
>> >> >> I very much doubt sending interrupts to a VM can
>> >> >> *on all benchmarks* compete with not sending interrupts.
>> >> >
>> >> >It should not differ too much from the physical NIC. We can have one
>> >> >more round of benchmarks to see the difference.
>> >> >
>> >> >But if NAPI mode needs to win all of the benchmarks in order to get
>> >> >rid of orphan, that would be very difficult. Considering various bugs
>> >> >will be fixed by dropping skb_orphan(), it would be sufficient if most
>> >> >of the benchmark doesn't show obvious differences.
>> >> >
>> >> >Looking at git history, there're commits that removes skb_orphan(), for example:
>> >> >
>> >> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
>> >> >Author: Eric Dumazet <edumazet@google.com>
>> >> >Date:   Fri Sep 28 07:53:26 2012 +0000
>> >> >
>> >> >    mlx4: dont orphan skbs in mlx4_en_xmit()
>> >> >
>> >> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
>> >> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
>> >> >    since skb wont stay a long time in TX ring before their release.
>> >> >
>> >> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
>> >> >    possible, since it breaks TCP Small Queue or other flow control
>> >> >    mechanisms (per socket limits)
>> >> >
>> >> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
>> >> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
>> >> >    Signed-off-by: David S. Miller <davem@davemloft.net>
>> >> >
>> >> >>
>> >> >> So yea, it's great if napi and hardware are advanced enough
>> >> >> that the default can be changed, since this way virtio
>> >> >> is closer to a regular nic and more or standard
>> >> >> infrastructure can be used.
>> >> >>
>> >> >> But dropping it will go against *no breaking userspace* rule.
>> >> >> Complicated? Tough.
>> >> >
>> >> >I don't know what kind of userspace is broken by this. Or why it is
>> >> >not broken since the day we enable NAPI mode by default.
>> >>
>> >> There is a module option that explicitly allows user to set
>> >> napi_tx=false
>> >> or
>> >> napi_weight=0
>> >>
>> >> So if you remove this option or ignore it, both breaks the user
>> >> expectation.
>> >
>> >We can keep them, but I wonder what's the expectation of the user
>> >here? The only thing so far I can imagine is the performance
>> >difference.
>>
>> True.
>>
>> >
>> >> I personally would vote for this breakage. To carry ancient
>> >> things like this one forever does not make sense to me.
>> >
>> >Exactly.
>> >
>> >> While at it,
>> >> let's remove all virtio net module params. Thoughts?
>> >
>> >I tend to
>> >
>> >1) drop the orphan mode, but we can have some benchmarks first
>>
>> Any idea which? That would be really tricky to find the ones where
>> orphan mode makes difference I assume.
>
>True. Personally, I would like to just drop orphan mode. But I'm not
>sure others are happy with this.

How about to do it other way around. I will take a stab at sending patch
removing it. If anyone is against and has solid data to prove orphan
mode is needed, let them provide those.


>
>Thanks
>
>>
>>
>> >2) keep the module parameters
>>
>> and ignore them, correct? Perhaps a warning would be good.
>>
>>
>> >
>> >Thanks
>> >
>> >>
>> >>
>> >>
>> >> >
>> >> >Thanks
>> >> >
>> >> >>
>> >> >> --
>> >> >> MST
>> >> >>
>> >> >
>> >>
>> >
>>
>
