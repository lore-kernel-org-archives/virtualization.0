Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33839855
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767979; cv=none; b=TpmFsEPcViXrbeYsAopxhBMTOWFpzHGyOL+2Rk5UA4j3hKND//px6DFJfaW4AP1olceZxyLc8/ieXc/u1L87pDHcjMiAC4b8SBS6c02OC92wTyNFeu0td9pCvcDC6JPztTLglCC7D9rE9kTD1pMXVuH/ai+pnTJcFojzvnfAZaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767979; c=relaxed/simple;
	bh=Jm7RUfQw4CI3zJvXTakCTGu3NPLqBKOAnFDP8rBj+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xz+Zuy5Dlifc4vRlWohzXILqzFCv2d0yUY+4sH7gAUPqXOg/ptmylT0+NddF+2nrBol9YK8qvcAjKWCq1dx4puqbV5EBv3iwRmTKvYVO0Tn0FPNo0P1lY/EVMJpjgTdw6p+//0+Jj2PddbsNb6ilzDK9V5h9yqBRqaAGjfJhnFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vvOjZyXi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vvOjZyXi"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59c448b44aso163363266b.2
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715767975; x=1716372775; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYflvmvoD5h3ewENkkvrbhvA0VaewsbmI1fciZbLpdg=;
        b=vvOjZyXit9RYGHQ6YRlA4NrpBY3xTXBnwV0nzq6vK5Mr/cT7mNY4yT2lCMVvOQPBeC
         4uhVcw+UN+AD0M8tczZoXEUpwKL1jSlPsqnCCTk6vQkZfkaP006Skg2PArgCpACaPfaK
         /hEEXKcwDNkJNC70QdyVVJAzNVFnxTfKMkobTOr0RUzUrpCeTXi87kaVTjGyVIjHDT3J
         UMJVRQirlo0ogLKXE9EhuftQ+9cCExor9u/IdI44AdLeYc+q6J1SRvOG2LCrmWxI9NM9
         YLlx71BYqkP8/TKaHtLQ9OtMWBbd8d07nEHVh9iZkhYpebsbbizLaRcdtrOJwO6Z4/Zp
         tcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715767975; x=1716372775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYflvmvoD5h3ewENkkvrbhvA0VaewsbmI1fciZbLpdg=;
        b=mlM56saCpDZHWaLRmB5zbdaXP50qtINoxtqFH1OuuFhyMk5zzBrf/m6OSNJngyqkmr
         mcnfMADau44hplKKLMLrZQbT8HnIW7Y5W5NiJGP9iTcxGMbCeVBY3gZRGJa6DnwuxKLp
         sdczzOdsxnkuYNQLEpOoik0JSTTdK/xvdPiws/M9tc3LQy0Rrno54M+4yWhoSWKAwnY3
         XvfCN/kTlVrUfVMXP8f7kL4j2ugd8jZQOWIycWy015zxEqjW3VziYepIfKBTD3HT6Jru
         jVusO7XqrWZZr60l/FJ/qCtP7ZZDqGEr6CQ5d6gqv93CQmKw0/uMr7pjGeKfqvsn15l1
         gO2w==
X-Forwarded-Encrypted: i=1; AJvYcCXtfIAVcc9L8gP9KY7zME8NyvoFMmBquxus0Cv3J4VvGnUI2G8gdGwqeZNPhw8M3D/DzJfeE7v4DBXlyOmkNqPT5W2OWQWspWl3S5RcWAM=
X-Gm-Message-State: AOJu0YyKod8A4GXUSe0/c3KbfhU27hQ7f1l1IrS0hx+JiYAX9VxiQqnu
	Lsosz+nNKcA2agjCEmo9cS0TphgVpSGRlqNiJt03cgb72WIZr6z/CzTgPd+FhGU=
X-Google-Smtp-Source: AGHT+IFXM/EspvfrIN/leickGNyOyUDoR9NHpWMfb2KyTdB2EMc6DkXzoqqVxze0KUhTN+XxLqzKiw==
X-Received: by 2002:a17:907:9952:b0:a5a:1e8f:37f2 with SMTP id a640c23a62f3a-a5a2d66aa57mr979553466b.52.1715767975311;
        Wed, 15 May 2024 03:12:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01602sm846675766b.147.2024.05.15.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:12:54 -0700 (PDT)
Date: Wed, 15 May 2024 12:12:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZkSKo1npMxCVuLfT@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
 <ZkRlcBU0Nb3O-Kg1@nanopsycho.orion>
 <20240515041909-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515041909-mutt-send-email-mst@kernel.org>

Wed, May 15, 2024 at 10:20:04AM CEST, mst@redhat.com wrote:
>On Wed, May 15, 2024 at 09:34:08AM +0200, Jiri Pirko wrote:
>> Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>> >On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> >> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> >> 
>> >> >> >> >> Add support for Byte Queue Limits (BQL).
>> >> >> >> >> 
>> >> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> >
>> >> >> >> >Can we get more detail on the benefits you observe etc?
>> >> >> >> >Thanks!
>> >> >> >> 
>> >> >> >> More info about the BQL in general is here:
>> >> >> >> https://lwn.net/Articles/469652/
>> >> >> >
>> >> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >> >> >mostly I got the feedback from net core maintainers that it likely won't
>> >> >> >benefit virtio.
>> >> >> 
>> >> >> Do you have some link to that, or is it this thread:
>> >> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >> >
>> >> >
>> >> >A quick search on lore turned up this, for example:
>> >> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> >> 
>> >> Says:
>> >> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>> >>  overhead."
>> >> 
>> >> But virtio can have one tx queue, I guess that could be quite common
>> >> configuration in lot of deployments.
>> >
>> >Not sure we should worry about performance for these though.
>> >What I am saying is this should come with some benchmarking
>> >results.
>> 
>> I did some measurements with VDPA, backed by ConnectX6dx NIC, single
>> queue pair:
>> 
>> super_netperf 200 -H $ip -l 45 -t TCP_STREAM &
>> nice -n 20 netperf -H $ip -l 10 -t TCP_RR
>> 
>> RR result with no bql:
>> 29.95
>> 32.74
>> 28.77
>> 
>> RR result with bql:
>> 222.98
>> 159.81
>> 197.88
>> 
>
>Okay. And on the other hand, any measureable degradation with
>multiqueue and when testing throughput?

With multiqueue it depends if the flows hits the same queue or not. If
they do, the same results will likely be shown.


>
>
>> 
>> >
>> >
>> >> 
>> >> >
>> >> >
>> >> >
>> >> >
>> >> >> I don't see why virtio should be any different from other
>> >> >> drivers/devices that benefit from bql. HOL blocking is the same here are
>> >> >> everywhere.
>> >> >> 
>> >> >> >
>> >> >> >So I'm asking, what kind of benefit do you observe?
>> >> >> 
>> >> >> I don't have measurements at hand, will attach them to v2.
>> >> >> 
>> >> >> Thanks!
>> >> >> 
>> >> >> >
>> >> >> >-- 
>> >> >> >MST
>> >> >> >
>> >> >
>> >
>
