Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66D16E893
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341002; cv=none; b=n5oEusKhMl2+8FpemggUFZAMssK7jBNkUs87EFAoRwwt5/dZmuBjdcm3TtiAUI9dO7trGTfJK4WvkRWLL7mryO49PTylQf7EUGjM9C9f24SZY8GIJwCDaYdghrJaEjhR/qmWOotdZkDiGYrE+JYoNkPMHdfyS65vCz5yC9cmPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341002; c=relaxed/simple;
	bh=APYGCt/t12JvzC3mlthjHTMtKtcsux0i+ZWcP2cHJXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfkN11N9brzLwDNTNgF4YV41L7/SXR2QXkIcbhspjzwfApMovmTgVgmd54paHQeB9DUjqLekpTFWto/QaiRC1uyc6s/tP15MtvSfLb80MjZZOev/yBU8dNhPwpz1OpMoLZYjr/ImvHwda5H84i0KhbIcYo0O8NUmXo57dvSOLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zeagodcH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zeagodcH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41c1b75ca31so13603105e9.2
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715340999; x=1715945799; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEpawp0jLL5YJD1E03t9v4CSTSHHxAczOaB7wWjUuH4=;
        b=zeagodcHtl7LatpFSkfWteB38u1oY4ar+bJBmlwIXPtIay1PzhtVlhV2H3rXWWNJTY
         KxWua1AxWvrPOP+KT/Ny25ZuJpwHyBWjzjkGMyPmiCp9/kMpIyrFQsJ6kbJdLdaMhza7
         91+ziK10iVyIgGiFzXFTg1f9lCAyt7lujax6fkYi+IWxqxWiuj+CTHkus1SXlcFh8+mD
         mbX5xHPRTQmBNkuNGCAFyDTVfzR3W12a7N6TYldO/8xk29w2umE3lQxqLXHwKOJ9uI61
         tMriMWn8c9QSCOAy29GU37PN6ZFFA8yozwX99Wrg/EsaJsGsfPbWrPdBj0teZjqUVh7D
         DzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340999; x=1715945799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEpawp0jLL5YJD1E03t9v4CSTSHHxAczOaB7wWjUuH4=;
        b=Hev3Ju6BBFYvSVfng36XVGKbw9lyfOeJKFCfJZxIzq++l4AhPqN9aOBbRL5UfNaSba
         xVs8EaHerVm4lCkxoi9Y2Se0IFBJwVtHzFPvlDNs9lFZu1sxadg5TPRfEYD2kv43ybHv
         R2C/wQbrYcxJYVejowUCFxHjDng6TT4HPvdX8lRR7lz04tUDbbbYs76hkU3crpJXTWKw
         13Oqj2HkpiL4GSPwwfi2052KJTv8GAJsCt8YN9p6fDEn38tKEDwRZXWR8HkZQrfuToZE
         Vg/RnU8ta8MIDPka5BN9Gn0ANkuurW9foKuIXVk2ArVLZYb8YvrMijAgmaX2gN0fmgoe
         UtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNjOogeQtg+yG9tAeU8W1W4Ic2LgHCLjNZTzVIMZxQD2Xh7gF1B0KA4d0lH59AADCRbYmJtVz1Tf3BBr9B8rWprqNndfYx2hd/uLNFiDk=
X-Gm-Message-State: AOJu0YxySnl17UjTqi2LfVJi1oKf/LFpwiv5CCQpUn0val0adMPdZKrW
	Mfq1b1DMkIdTE9lNP1RSmBy4AiKNivq2DYaYnVVN4CO9e0XDnTRiYgXa119MEOY=
X-Google-Smtp-Source: AGHT+IHZfCGuk+GqlIdc8CMNcbdW9LHfDq0A6ImdoUAGoHpo+I5oeBh0k6qw8nyb9ibHRimM3FHEPA==
X-Received: by 2002:a05:600c:154d:b0:41f:c1af:835d with SMTP id 5b1f17b1804b1-41feaa30876mr22384945e9.12.1715340998802;
        Fri, 10 May 2024 04:36:38 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe1532sm59667175e9.46.2024.05.10.04.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:36:38 -0700 (PDT)
Date: Fri, 10 May 2024 13:36:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <Zj4Gw52pTbg01vvR@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
 <Zj3425_gSqHByw-R@nanopsycho.orion>
 <20240510065121-mutt-send-email-mst@kernel.org>
 <Zj4A9XY7z-TzEpdz@nanopsycho.orion>
 <20240510072431-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510072431-mutt-send-email-mst@kernel.org>

Fri, May 10, 2024 at 01:27:08PM CEST, mst@redhat.com wrote:
>On Fri, May 10, 2024 at 01:11:49PM +0200, Jiri Pirko wrote:
>> Fri, May 10, 2024 at 12:52:52PM CEST, mst@redhat.com wrote:
>> >On Fri, May 10, 2024 at 12:37:15PM +0200, Jiri Pirko wrote:
>> >> Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>> >> >On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> >> >> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >> >> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> >> >> 
>> >> >> >> Add support for Byte Queue Limits (BQL).
>> >> >> >> 
>> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >> >> >
>> >> >> >Can we get more detail on the benefits you observe etc?
>> >> >> >Thanks!
>> >> >> 
>> >> >> More info about the BQL in general is here:
>> >> >> https://lwn.net/Articles/469652/
>> >> >
>> >> >I know about BQL in general. We discussed BQL for virtio in the past
>> >> >mostly I got the feedback from net core maintainers that it likely won't
>> >> >benefit virtio.
>> >> 
>> >> Do you have some link to that, or is it this thread:
>> >> https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>> >
>> >
>> >A quick search on lore turned up this, for example:
>> >https://lore.kernel.org/all/a11eee78-b2a1-3dbc-4821-b5f4bfaae819@gmail.com/
>> 
>> Says:
>> "Note that NIC with many TX queues make BQL almost useless, only adding extra
>>  overhead."
>> 
>> But virtio can have one tx queue, I guess that could be quite common
>> configuration in lot of deployments.
>
>Not sure we should worry about performance for these though.

Well, queues may be scarce resource sometimes, even in those cases, you
want to perform.

>What I am saying is this should come with some benchmarking
>results.

Sure, I got the message.

>
>
>> 
>> >
>> >
>> >
>> >
>> >> I don't see why virtio should be any different from other
>> >> drivers/devices that benefit from bql. HOL blocking is the same here are
>> >> everywhere.
>> >> 
>> >> >
>> >> >So I'm asking, what kind of benefit do you observe?
>> >> 
>> >> I don't have measurements at hand, will attach them to v2.
>> >> 
>> >> Thanks!
>> >> 
>> >> >
>> >> >-- 
>> >> >MST
>> >> >
>> >
>
