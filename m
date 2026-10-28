Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163204;
	b=O6OgL1R2Wylm9WTQpNtfp2aJHlUsAp95WpBJq/WbLTciWWpcXUqBRx1JLWuhnBHBE/Il
	 GjPxmxExrU/qJmoJQD/mNYQNX72Mdkx5sb9+VJSxR68pGcVLhPiHMwBl0O947A7YVA/nd
	 /dmNo2bHtuorz+NN81rIFaeQjOMJW3TYgUXpPdiPsVvMzaUrKEgnny9NZN8zB9VUMRVyx
	 R+rJ38Mrr8ay/K7ZImRPEvZA8jnr0nxqbnF6wjdOHAAgrUkS8jlu4bTsnSpYeQFR6AHk3
	 G6fKONy+dHpEcbU8g37y/GcWgZTX8QgS8gf4/LMEqpDzMAmwOs2ZVhL2mD6PhFu5FAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=iMvg9EuHuu+x9NUwMZWsnJGwMCIhGiOL6i2k5eUcGIU=;
	b=kECjLyVrDlQ/6PrghG/oImZ8Ftvsiho1IBeKpjSPNAmL2pYVsPqPaGhn619W1k3KRHFm
	 EnzedIHd/103y1j1RyJfAmbF36jH7xEUiNb0OzNz3QA2brXii7dToatTt+ovmjowYTsU7
	 gfQ+heOFPSJN6DrBpiRbdZpw8z4my/7nv1WyCmGMHYbJtGulack9/Mjg91ZJmQLsqj/pP
	 9Pm9M8pyvW336sYgihMm9COiNenjywuzfhCrRGGfm+E3MyQNfMKPmz138Zlht8Lnu+UrR
	 ybBGkrygZZ3gRMnTnHW9sUr393M0n4GuAlO+ioyI3duChy5byNMn5qqoTyuLStd4QqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fmWLLAZN;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F781606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 04:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F781606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fmWLLAZN
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35829219da8so2159493eec.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 21:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793163202; x=1793768002; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iMvg9EuHuu+x9NUwMZWsnJGwMCIhGiOL6i2k5eUcGIU=;
        b=fmWLLAZNyxyM+QuYFagtUkVa2ZyTmEMZrGbKZL1ZYtDzvtaF24WF1DKSfEKFhRTMPi
         clF97+AyrcCRgN+WcaeyCqB/OPMAHBy3hyA29/eYoeLsMdR0xp71b55YNKKneGWKgIn1
         +w/pLAgdjLyYFNYUv2uqnq+wOC6A3cG6c+MpzsP4V4XrC+VIQBlDy3AtBa58yfGxRYna
         T1ul1nwGchvT0g7x4WulubCnYP4rYdnsS7Z9zfp+e63un/h/8wnrqqjTFeLobBFrf6rU
         b9gocz5j4SWTU/BH1DR69xhDKbwyd0YPrDPCtCHLFjBRyyLLllB4fvfQHoXoTNcJMUjt
         +deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163202; x=1793768002;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMvg9EuHuu+x9NUwMZWsnJGwMCIhGiOL6i2k5eUcGIU=;
        b=WSMKi0V50KiJvSEGLhwOdlfJDIJrIE5R92w3BkoZ3oFKj0IhEo/3tlcpyiXjDbckcz
         nczqj37Bb2VFh/6SSQE8qxbFJ1wlIQlN3ciIfLdNUPSJa3u/Ues8KUpyc9NZBkU4qAAP
         J1Nj4FMPtbAd3b6+FmY8slAu9RWOi6uDnSlQPDnsJoY0SoDJMHquoR2hjkmp9bSXJnpn
         M/WQ+onzk5vfiZ6fOCQmzHtkflMp59IhPSuwYj2Hi23Fo8xbSeXZ+lqmPobu/UPKV+HT
         6APhM3yLbkkbxwtvGlfEJyRUkx8qqbFG0YKxp+ZBH38HKW18rAGQhzdV7pwjmId9tCZZ
         EZSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxf+ojHAeb72dvximgqfCPx+bH5FAjMIJItUzQgsMdHm59vO0rcweBKrU/5ibIB28WDl0wRb+CfUUUGEfvy3Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYIptoXTImGSM0Xi3Ca4VDqV6ePJ+TPkwrUwwpossUxEjsspTe6B
	z1V1z89ZvlQoP5N7Y+r8YsdqcuxUVG9ME61DA5rZao/c7k4jOvdYQMfD1FQGqcawXMk=
X-Gm-Gg: AYBFou21XcTHGh/qpBdPuDX0zzULZmQHOrLZzyYeCK2RcdPW2IB3w6ujV6VUaIuVukh
	AavGp/6PkCwH760sLUfJpNc894oUat30s1qaFky9iHJimvtDkmZRuzDZCpMBCspWzbDwNQomcvf
	5WZXvqg87olc7/lP0h+LvJ5mlnvANi7xONssxo1dcQZoXW7WA2HrmpiJNWB84SpDZjBdTz94Xlv
	1rV8eB/yyMGOJ2ILLK2jzlXA/7Ca6OmBrbQM+r83z+J8/2mZ5iUxqjPnviElJQxwHTAIJXx3OU8
	wf/8j3TenwPPhRj8kw2Y9SkOdqwJIl2lXCy9m1t9x1bqnbnzaVikQY8glL7g5IJiRd2xwKqS7AJ
	n3wyKcX1m2na7fUKXL73rVZa+CPAO6aJek6G9Z1Jb/dlU0IAR4xamsJ0DGUn+kKJB0IGGimrVOg
	cnNiFHuIT1ChfF9TAkcREX7PwCLlf/4G5WUqd7HQ+mvvj6yfZntHz5H868ZOUXxEn9EB5tYof5h
	zOFZuQS6lprFgK0J+ON4WT8GPjaFvUPtI/l7ZyzalIcsAGCF1NFPXKvSkEjaw7eJBDjtcOJR+BG
	sXvOTAJkKYw7Wu4dLAN0NucLIZGk2Z0=
X-Received: by 2002:a05:7300:a212:b0:367:a092:3c73 with SMTP id 5a478bee46e88-36a0f81af52mr6190963eec.12.1793163202055;
        Tue, 27 Oct 2026 21:53:22 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2395bee6sm1963997eec.21.2026.10.27.21.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 21:53:21 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:23:18 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: virtio: convert to immutable irq_chip
Message-ID: <auF_vjF6f0Y7dBHn@vireshk-B250M-D3H>
References: <20261027-virtio-gpio-irqchip-immutable-v1-1-f64ed13d4567@valla.it>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-virtio-gpio-irqchip-immutable-v1-1-f64ed13d4567@valla.it>

On 27-10-26, 13:55, Francesco Valla wrote:
> The kernel has been warning about non-immutable irq_chips for quite some
> time, printing messages such as the following one during initialization:
> 
>   gpio gpiochip6: (virtio2): not an immutable chip, please consider fixing it!
> 
> Convert the gpio-virtio irq_chip to immutable and add the relevant
> helpers. The exposed name is kept the same as before through the
> .irq_print_chip callback.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  drivers/gpio/gpio-virtio.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
