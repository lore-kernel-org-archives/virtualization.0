Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B226154C11
	for <virtualization@lists.linux.dev>; Fri,  7 Jun 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742369; cv=none; b=YtAA+Q1XmxOgbhJNxmjaR6u79EVFu8uBvLrzEmQkxiR8oG1TtjAqFK6sst2Hcso9SXyop/oWZyf+4PJcLJVbPXPiDqZUX8RvtuoyT8eiMt0N3u0N27N+av1aB73cFwCVCLbE17Q38Nk0zFGhwnAuVtw2k/XJ0py6jiWcAkFLDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742369; c=relaxed/simple;
	bh=BYMSRWUUkSA6XkO04VeTg8T/5G3D0T8FakYVcOs2tdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Irl0hdln4hGYleHHV2xql0nH0R7DeBEFzDNNlGkzJAH4Z3btOKywQceVf9IHyeMDH6OdeNuRjjb2bspZfL8XJsxiVdJ2VnC3cLAZC5R+20D7FZ58UgKwhl37pLJV7xPcwOnnhNujthCtGpMYUXIdK8JhZbk8xb1jYsHcM+SASQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wOZ6kR0t; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wOZ6kR0t"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaccc0979eso20891201fa.1
        for <virtualization@lists.linux.dev>; Thu, 06 Jun 2024 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717742364; x=1718347164; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=piMDbhmCQk0OBuwRv35GHgfcS+SZ43/YLuGchRk/pqo=;
        b=wOZ6kR0tTW/bY6VQA4u/X2WviU/Fuih8hCSyGd1pico9hGl1hmj75k5VYbhsn1n3+r
         VUUDfYfdi5eF2cHsERCtB6eVRe8xv+BqhaFqaFaT7phni7dDtV8f9va3gVV9ULgvN8cy
         y6XmodeHiLLQtR5+paAjrB3dNgSUzzD0ppVkN7pAYhZhiipQ26wHfUdaninJmbq0ebd9
         BefVSiYmit+TwDF+ZIS70cJ5YvC7xechvgOLrvtTO1XCJutpL7jNW7U0lidpTLTSvHLo
         4pIwWC3fNP1AmdU2G8k34kL2fi/49LkZMSRhamEtGpjXE9wIPOFdpSDV+ZS6pV4PipK4
         Gg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742364; x=1718347164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piMDbhmCQk0OBuwRv35GHgfcS+SZ43/YLuGchRk/pqo=;
        b=Kk11M7losrZ984nac+/1UnK7KqG7EKq+iXGyki/c/91rstQugXQONpZ8uxhNiWzbhj
         tpV4bMnUb5gjqbISdg8pQ6XEkBe0fVBslX0lEhxKZZY7YG2lJmpQha8c0GM6M8PupGzJ
         PY+pX7NhZ0hKdwJ5ruiDYXuxq6iHzyHGG8sMZhvtQ+o8cYNtH63qPDMmmxQVErEnyHbj
         99wY4j+GBqjP/daCcVlmED3/ERCqRG7S7kF8RJDjyF+ekLeMl3o5BuBd0CGLWhl3i9Na
         1xB9p7U0+GTNs+AepFWSp3EZl6REEJDASQ4c0JsC2Gh9D1Z6mPEYtFBbZsNPPoyUBpZC
         +Feg==
X-Forwarded-Encrypted: i=1; AJvYcCUW7uPfuUvDFnXmNLn2zOFM4jOe08buBjy7pSH4GvE+aBHAiSaQwNHIpKQO1V2CLfCbCHeG77qoH6tHq7bvaeIhaKIwfxtWp2izBVbXWIk=
X-Gm-Message-State: AOJu0Yz10GPnfncHID7eXTvO9VEkWf44fT7k7cNr5yZ0652V35Zd8OEa
	HJYmWfclXIr3HSAD49LAEv42AcLbFvVRIbB9W0sV/81q+rjb4FOgVkcxpI65Y5c=
X-Google-Smtp-Source: AGHT+IHkk2ZJMtE5Pt8tmFrEu5Kp9C6ZkZfrS8jDBp7qq+8A8hsD2w14r5KVEh3oPlmsh+AFrHfDhQ==
X-Received: by 2002:a2e:a589:0:b0:2e7:1bb6:2e8b with SMTP id 38308e7fff4ca-2eadce713c9mr11276921fa.35.1717742363811;
        Thu, 06 Jun 2024 23:39:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e67fsm44152205e9.2.2024.06.06.23.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 23:39:23 -0700 (PDT)
Date: Fri, 7 Jun 2024 08:39:20 +0200
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
Message-ID: <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
References: <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
 <20240606020248-mutt-send-email-mst@kernel.org>
 <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>

Fri, Jun 07, 2024 at 08:25:19AM CEST, jasowang@redhat.com wrote:
>On Thu, Jun 6, 2024 at 9:45 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Jun 06, 2024 at 09:56:50AM CEST, jasowang@redhat.com wrote:
>> >On Thu, Jun 6, 2024 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >>
>> >> On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
>> >> > > If the codes of orphan mode don't have an impact when you enable
>> >> > > napi_tx mode, please keep it if you can.
>> >> >
>> >> > For example, it complicates BQL implementation.
>> >> >
>> >> > Thanks
>> >>
>> >> I very much doubt sending interrupts to a VM can
>> >> *on all benchmarks* compete with not sending interrupts.
>> >
>> >It should not differ too much from the physical NIC. We can have one
>> >more round of benchmarks to see the difference.
>> >
>> >But if NAPI mode needs to win all of the benchmarks in order to get
>> >rid of orphan, that would be very difficult. Considering various bugs
>> >will be fixed by dropping skb_orphan(), it would be sufficient if most
>> >of the benchmark doesn't show obvious differences.
>> >
>> >Looking at git history, there're commits that removes skb_orphan(), for example:
>> >
>> >commit 8112ec3b8722680251aecdcc23dfd81aa7af6340
>> >Author: Eric Dumazet <edumazet@google.com>
>> >Date:   Fri Sep 28 07:53:26 2012 +0000
>> >
>> >    mlx4: dont orphan skbs in mlx4_en_xmit()
>> >
>> >    After commit e22979d96a55d (mlx4_en: Moving to Interrupts for TX
>> >    completions) we no longer need to orphan skbs in mlx4_en_xmit()
>> >    since skb wont stay a long time in TX ring before their release.
>> >
>> >    Orphaning skbs in ndo_start_xmit() should be avoided as much as
>> >    possible, since it breaks TCP Small Queue or other flow control
>> >    mechanisms (per socket limits)
>> >
>> >    Signed-off-by: Eric Dumazet <edumazet@google.com>
>> >    Acked-by: Yevgeny Petrilin <yevgenyp@mellanox.com>
>> >    Cc: Or Gerlitz <ogerlitz@mellanox.com>
>> >    Signed-off-by: David S. Miller <davem@davemloft.net>
>> >
>> >>
>> >> So yea, it's great if napi and hardware are advanced enough
>> >> that the default can be changed, since this way virtio
>> >> is closer to a regular nic and more or standard
>> >> infrastructure can be used.
>> >>
>> >> But dropping it will go against *no breaking userspace* rule.
>> >> Complicated? Tough.
>> >
>> >I don't know what kind of userspace is broken by this. Or why it is
>> >not broken since the day we enable NAPI mode by default.
>>
>> There is a module option that explicitly allows user to set
>> napi_tx=false
>> or
>> napi_weight=0
>>
>> So if you remove this option or ignore it, both breaks the user
>> expectation.
>
>We can keep them, but I wonder what's the expectation of the user
>here? The only thing so far I can imagine is the performance
>difference.

True.

>
>> I personally would vote for this breakage. To carry ancient
>> things like this one forever does not make sense to me.
>
>Exactly.
>
>> While at it,
>> let's remove all virtio net module params. Thoughts?
>
>I tend to
>
>1) drop the orphan mode, but we can have some benchmarks first

Any idea which? That would be really tricky to find the ones where
orphan mode makes difference I assume.


>2) keep the module parameters

and ignore them, correct? Perhaps a warning would be good.


>
>Thanks
>
>>
>>
>>
>> >
>> >Thanks
>> >
>> >>
>> >> --
>> >> MST
>> >>
>> >
>>
>
