Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3B1292F2
	for <virtualization@lists.linux.dev>; Fri, 10 May 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337442; cv=none; b=OIcw0LJUEhuHl9NCTspvWImZ7XheCTXTWiJ/WTl/O93mK0N+O64Q2KJeK43mrEj84NssG7jOCRCuyeiByV8tHXzJgb88RQI3DSZSg40ifos/cklVGSqQwgBu0dTGWFtTSAxris5OCEgP03WW3H6eExZOVuxXQbiJnuXJ2XmXAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337442; c=relaxed/simple;
	bh=nXgflE5B95vd9pNg+4/If8fnc0fknILcfN5X2631qLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oigiMYYMJVhCh0xX7QpXP1bAsYT0gw5uyW2k24gKyBXOB34UL3IPrrSiyIyq1TO8CpstxNqwqzNi/kFXUX2X/p7w5IIqGG2yaDq401Ky/H6PfKVsp1TB0kDkW9AdqzX4in6DrX5HCHdFvvqec75GrPQ+8DBpOP8mX7hxptpUjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mBh3HsXH; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mBh3HsXH"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2df848f9325so22445101fa.1
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715337439; x=1715942239; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wD5INpBrnsarO0AiJUhZuKf0j4l0d3r9JcWEyVVrlA=;
        b=mBh3HsXH85buKLsfMOUtSda3Fh17duDjaK7/BOtn6cN9nWawP6VbJQyF04VLZ42KKR
         wNCaVh1qKuVjan0KXhFp52uMKAuy8pSPjtAGOzwWG/+HIFt+c9e9aP7VLlqVgGhxwHTC
         o5XT9ErDpFlVffuAEK9jshtGSt834u3uR17TlYbCR5DutjJ1xEm6BJUXJaJswuil2dgy
         oH4Xxkc6qvHt6b4KP0TBPW5BugWM1seck8KLNy8SPZzm8W2ORBBJ3Rj1p7aZfqpcVH08
         8oYYpMnh0JcBmAUW50CVFpHgb0gGaB6RF34wCfERgcB4joZcdI5TGS1e525a7d+loNFS
         uovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715337439; x=1715942239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wD5INpBrnsarO0AiJUhZuKf0j4l0d3r9JcWEyVVrlA=;
        b=OMwmtoZUPUh7BH715A47/Z89ImI/wd18XKurHnhEgQVCot2jqTi2jJ7d0dQ3vEbXnV
         nK7/xtbYpHAVtyjvWQB/mCpEmMl6rw7NwTODpdgSVXHtHNwMCHxSrOrW92zub27KMX7d
         Svu8Ze1j7cYtkZCn6Ek6oAc/T3+jsSJZiOn5oAkYbtrDAqfi+wW0crDsb4nJ5Q2ZDqrJ
         pspIS0BAHuS50kboLXLEFPsJnfu00x3DoT2kM1gHvV7Pc9j2y5Ba+Q5Qg0wzDBGBg4+M
         +6B/PUWX1+VkOLijXfInBx9yqoUF8vZsmPET4JpViVSesFLPMmVHnO78p7X4+bT8A13m
         ByQw==
X-Forwarded-Encrypted: i=1; AJvYcCXL7/82BJN0/c3qXSdLnCDdnTKiegIVpYAItvyMBXMedrgsk2mOyk7EtN2aPFk17maN+S4ye7ctZeTCvVs3wWT+ivxYns2+T93wPPe3sd4=
X-Gm-Message-State: AOJu0Yw1PYBnmNIrJ0owFPNRugP+v9pkOUNqm4cPtvmvy0eZDQ1asPKP
	BiLBPuXKXA2aGKzwUiYh/UsNnEOIBbdMgsehKP6EiptzMS3x8rms0Ggl5ms3NI8=
X-Google-Smtp-Source: AGHT+IGk6Tu9ZaxL6acgoYnm6At4B4bc73fVWAaY3JZYI+o01Kpih02yFjeVK4Va11FoA+V+WYLocQ==
X-Received: by 2002:a05:651c:50c:b0:2e0:ffea:4298 with SMTP id 38308e7fff4ca-2e52039c0c8mr17507961fa.34.1715337438710;
        Fri, 10 May 2024 03:37:18 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88208886sm94053465e9.45.2024.05.10.03.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:37:18 -0700 (PDT)
Date: Fri, 10 May 2024 12:37:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <Zj3425_gSqHByw-R@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <20240509084050-mutt-send-email-mst@kernel.org>
 <ZjzQTFq5lJIoeSqM@nanopsycho.orion>
 <20240509102643-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509102643-mutt-send-email-mst@kernel.org>

Thu, May 09, 2024 at 04:28:12PM CEST, mst@redhat.com wrote:
>On Thu, May 09, 2024 at 03:31:56PM +0200, Jiri Pirko wrote:
>> Thu, May 09, 2024 at 02:41:39PM CEST, mst@redhat.com wrote:
>> >On Thu, May 09, 2024 at 01:46:15PM +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Add support for Byte Queue Limits (BQL).
>> >> 
>> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> >
>> >Can we get more detail on the benefits you observe etc?
>> >Thanks!
>> 
>> More info about the BQL in general is here:
>> https://lwn.net/Articles/469652/
>
>I know about BQL in general. We discussed BQL for virtio in the past
>mostly I got the feedback from net core maintainers that it likely won't
>benefit virtio.

Do you have some link to that, or is it this thread:
https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/

I don't see why virtio should be any different from other
drivers/devices that benefit from bql. HOL blocking is the same here are
everywhere.

>
>So I'm asking, what kind of benefit do you observe?

I don't have measurements at hand, will attach them to v2.

Thanks!

>
>-- 
>MST
>
