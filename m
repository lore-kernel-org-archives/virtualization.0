Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B995155393
	for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739163418; cv=none; b=GwkvzOOJL9vSaQxeV4zQuDvuGBr7Zp9YNTxz8hrO+ChMPIIgLSvY7twHdK/zk4nOuj3GS3qKAMeCs/SerI2ggGfzthr4MCm8j7i0ArPnxjvwCYE0uCyLzFd6FnoHtYQNqeyhtuS9Ytt9MqNiAdTwaUaVxDKbq7YUajNg2ewRowE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739163418; c=relaxed/simple;
	bh=YAHkr0METhTi1KTLZaI/9EuUxKR5coa/VgzRRe2H2pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElcZoeXxJYtTbHshX/mxQVNeHSlW2g5qdLPg63QkdWysmmpmaIXJWRVp3B7kTbd7STQfzpXYKFxryRtMl210CSgJ7yIDZH9FY5n4NtfWzSiyprHY6TmLv2wntoWRRrmhlz5fgQRFXvqr/UEemfZZT9rw6JZf0dMOTttW5czjc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MEXaE7dA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEXaE7dA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f49837d36so40622555ad.3
        for <virtualization@lists.linux.dev>; Sun, 09 Feb 2025 20:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739163416; x=1739768216; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBZBkXBErlJMDONsaNIRaxXflZoSWgdPOLJTp5zZ1Q0=;
        b=MEXaE7dAFUMhHla+esO5z3u92o511avr88rnrYj9rK48m8S8gNepYkXpOc7le/Dn6Y
         T93D+QfxGO8Z6hgWuFz61p22+oF1mqy56XKqqawDnqPKuQNDvsWH9zbOstGMGK8HdeH8
         XY+uBaIpJlxRnzgFCSQtXczxOA3TFPc3gXlove/6kkJlqzbL/J1D2fk/lHB++hVwmrt+
         7jIxFxD7ctJvhbZgRY29zZptIrVInRYGY6bx4xSxoVaL+gRNj0RUHFakxfHxphi7wPPg
         nCh4eDU9hHtPZIOknozTxjr0ZKEWYaYtjrA8NJ+mRP42n5xzuCRV5XfWOElxyV6+8Fpv
         uwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739163416; x=1739768216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBZBkXBErlJMDONsaNIRaxXflZoSWgdPOLJTp5zZ1Q0=;
        b=WdceuXA1ILKNeabnBkBaXE41jrIy7dEIvddwS36gQjrVZuv6z3pH35yR43zj6zoPeM
         KyISworOrdDOqZpcjApLTGmsTp22iMFyE5gjsI7k79ufQIgBXheTStHatBEdJ03ctFnt
         x0LrP6fT3qMZbjSYAcDXydc3uL94uMtg0gDoA4hEbN79hCa8oh6mWpUX8tT2/Jp0gVd4
         qHf26qyy0HS0cV8RhO65PZy0WK6n3DmXeS+bWO6T33ynzTq/jYDnWwJdVi1vt6ekqBc5
         qmu8Yi5Fy2Brz9pgPQVAy1+CxRNUihhop5GOkh/0H4/DajP6juK85iJiquxOgrAVczuF
         CYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSaoV/3ADTCTEvEUu4Cikc4EUz3VEo2L9vn8p7HQ4PlyDUt5l47Upqkb/YpMHAhel1jpS8y+4A2h8MZBMZTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDvvIB5nguO2XQ5vZ0SwTLmpMylKMN//Iz3P1hyxQHZdAyQO66
	ZpjYpy3U/pG484fK9JEY+exuUNfy07IIBSS8fI6eUx8aFdyXB+SuOtHTgDoHL00=
X-Gm-Gg: ASbGnctckvr47YQzwk2iuyTuR6Qm58qsYh8+vfFlYezfHSxCjSa/+DpKSFahDFoQNr5
	FjESxAw+C6ko4ooPgqo56y1Jyuo4bzJj9H8YO8huMmKwg0jIlso6Dh+jKtcJ4lmwINiKLCkvWCG
	+z0gqXmg9UxhS7w5X4sgM3NZ3Pghezb+a+dQfv8WDQNgd5FVi4HlydDfVQcGVyuu0cB4KIIs8tf
	YTy8S+m8gHlcyou+e6KAOCbxFa2Cgo/XTkFbsxrEYuvdfFk/nglKd33mvXH+toQ5x7m0tmJGGeb
	rvbdnu7aaENKI4OLmw==
X-Google-Smtp-Source: AGHT+IHylgse8VRUp8uwAnVdFN1Fm4nsm42hMF25H4bQ839GlTcZj0Y1uxCc3mugNys8LftmyO8qsw==
X-Received: by 2002:a05:6a00:21cf:b0:71e:108e:9c16 with SMTP id d2e1a72fcca58-7305d4944admr19147693b3a.12.1739163416455;
        Sun, 09 Feb 2025 20:56:56 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73089afd0cdsm1556606b3a.134.2025.02.09.20.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 20:56:55 -0800 (PST)
Date: Mon, 10 Feb 2025 10:26:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Leng Cold <a909204013@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: info@metux.net, vireshk@kernel.org, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] drivers:gpio: support multiple virtio-gpio controller
 instances
Message-ID: <20250210045653.p5d6svdl4d32sttf@vireshk-i7>
References: <20250103083520.1764441-1-a909204013@gmail.com>
 <20250106043508.x3pwt3jzh37t265f@vireshk-i7>
 <20250107060044.hteiw6dgycz5rr7x@vireshk-i7>
 <CAHqiF6Aoe4eUShxpPfKczPF-bVneiyM0gpZ7xWF3artzoC__7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHqiF6Aoe4eUShxpPfKczPF-bVneiyM0gpZ7xWF3artzoC__7Q@mail.gmail.com>

+GPIO maintainers.

On 08-02-25, 15:54, Leng Cold wrote:
> ping
> 
> Viresh Kumar <viresh.kumar@linaro.org> 于2025年1月7日周二 14:00写道：
> 
> > On 06-01-25, 10:05, Viresh Kumar wrote:
> > > On 03-01-25, 16:35, hlleng wrote:
> > > > Modify the virtio-gpio driver to support multiple virtual GPIO
> > controller
> > > > instances. The previous static global irq_chip structure caused
> > conflicts
> > > > between multiple virtio-gpio device instances as they shared the same
> > > > interrupt controller configuration.
> > >
> > > What is the conflict you are getting since all it has is callbacks only,
> > I
> > > wonder why do we need to duplicate it.
> >
> > Ahh, so irq chip should be shared actually..
> >
> > static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
> > {
> >         ...
> >
> >         /* Check if the irqchip already has this hook... */
> >         if (irqchip->irq_enable == gpiochip_irq_enable ||
> >                 irqchip->irq_mask == gpiochip_irq_mask) {
> >                 /*
> >                  * ...and if so, give a gentle warning that this is bad
> >                  * practice.
> >                  */
> >                 chip_info(gc,
> >                           "detected irqchip that is shared with multiple
> > gpiochips: please fix the driver.\n");
> >                 return;
> >         }
> >
> >         ...
> > }
> >
> > For your patch:
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
