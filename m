Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931519F471
	for <virtualization@lists.linux.dev>; Tue,  7 Jan 2025 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736229653; cv=none; b=ihMQWdjbxGdRNcZI1e1Tm1cvZS3IaCEqmRoTPPD2/CjC157DbfUWpdxG2OLnC3HVsySt3sXKp1YWprwy4FMLFmvf7zMLaEKR06aMtV7E7ZAoCnPxjMriZrxM6gfcW0JVy6MRhifviwwZM74dJi0weiFqYyOxmOWd2pcLskCoaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736229653; c=relaxed/simple;
	bh=pcTS2IIvM5b/ePXGvpNyGCKS7Bb0XTsBiAqUhzDkKDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIJX71UKOiG4/YEZlKc768voIZt8VhB/bYPHivAs0k3xttzChDP76U5NVd8vp9ztwoZ0vnbvta7QNRfB8luDv79I3OEHKn29jNFl2Prwnn+KdmzUj85qVLW6JKPgD/FUyVjbHFaLqkkCK6lYSAcyQEnozkNvXLI+ZE4+Fp0F2vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VuMSX6QB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuMSX6QB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216728b1836so200466725ad.0
        for <virtualization@lists.linux.dev>; Mon, 06 Jan 2025 22:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736229648; x=1736834448; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1LqtCCFqO+EmbQDGZfil95JY56xLKJrZ75mF8dLQMY=;
        b=VuMSX6QByGBTkTthouFZc6rtqj2R0ejZyR3kCjY8P7O4bcsiNRC45V/OiNM3yRKmOQ
         69bc1Hdu1Xk/JBgrqtctowlELqjzanKz3FM/ww3CQYTYgr1nk1KAYZ7/2ODfXKRdXdSK
         P8Zw5vMit6zJgS8K/JMAoGSarXyDgl8EQYG5Awm+6VuYgRugWQcG6CHsoc+gcDpl7Z53
         n+dBAtmfMum4Zq/Ky2WM7oA1wF4UDpRZXkJcYcJ7SxjnuP04f0bOiaG4LfJs3c9FdYHQ
         Tk0R8khxrgb03It4G02srzBHTVOXaTQMrkQXV884Blh9SKqpTbFp+Qpiu6rN6fPa6364
         lw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736229648; x=1736834448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1LqtCCFqO+EmbQDGZfil95JY56xLKJrZ75mF8dLQMY=;
        b=oGG+90Mva/YKch9ALhwfrtjGuWsPaXRQKQXJwYbdJG9g5gJWR0OAOPMsFT9DF46C6X
         ZlG0HK2eqSvekSjVjEfsqLqut1rCBBGc1LCET5+v1uX3XwZfbi20kO4bI8SuJ/ZZ1joe
         VVQiglz2o9mFeQcnLYqgOJ4pe/Whhj+i14ClmcGyaAT5XGdWQ1LnQboot/ScCMtY+mcA
         /vl4UdhQ3gN1SCGNFtJaZan1qfW6UwNqGrSCm//c+S4m47yZfRlUJiECXFbT8hmsugcX
         pC5/zho2Y/m2lK2KiITUFBFpkqfZM++JFevKcFmEM5bQZ4fprm9LmgZ7Vo3wLqNM7ubk
         DKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkG33ZxCTSmFDtIeQha8jwzOXwo8lHTncgeASeYONFYOGzv/QUiiKWOdoQoEGmuiTI+PEqGjMglZdbqVO87A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzK8rAbW6oWxQOkbOuCxgi9VbNBZfsAyq0ycsra49tlDLxhfqPJ
	ynx/LQrT+vzCjbrMGOgE2bUjVzg4nw4OfzqmwFXUNQZh3Fkh652vQ3kaueqtyniOFqQErtNT9pm
	a
X-Gm-Gg: ASbGncuOlekP6yQHQQwujFGzUeTbs+HKeSSKbyi2vMIppE/7aCcIQyqp/l2CV91SVVX
	momy2cHOYogxDrKVNZgIxaluVKTRKya3tA3VX5PAHBqnXgdy863FWDguVd1DwvZ3GuVF6VpCyng
	mjqPfCVHt3C8IYbxtEWrDxDyY/Wsm82/LeoUWLB0ufigiStkbqdfrpR+TtEACDrhWr6yz29C2VE
	WGg9RZgfR+W7703uvWc32GjcLN72ztFwoKrV9Db4JzaRh3DQjZKjC/uutA=
X-Google-Smtp-Source: AGHT+IEV0SW8UbkPJKhQiSFE3WXE7urmJef0CRVNx98DBDbQuc5ZLOE88pPCGk4dWb4wb3Z1ikREsw==
X-Received: by 2002:a05:6a20:1596:b0:1e1:9f57:eab4 with SMTP id adf61e73a8af0-1e5e04609b4mr93184649637.16.1736229648586;
        Mon, 06 Jan 2025 22:00:48 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm29716122a12.4.2025.01.06.22.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 22:00:47 -0800 (PST)
Date: Tue, 7 Jan 2025 11:30:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: hlleng <a909204013@gmail.com>
Cc: info@metux.net, vireshk@kernel.org, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] drivers:gpio: support multiple virtio-gpio controller
 instances
Message-ID: <20250107060044.hteiw6dgycz5rr7x@vireshk-i7>
References: <20250103083520.1764441-1-a909204013@gmail.com>
 <20250106043508.x3pwt3jzh37t265f@vireshk-i7>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106043508.x3pwt3jzh37t265f@vireshk-i7>

On 06-01-25, 10:05, Viresh Kumar wrote:
> On 03-01-25, 16:35, hlleng wrote:
> > Modify the virtio-gpio driver to support multiple virtual GPIO controller
> > instances. The previous static global irq_chip structure caused conflicts
> > between multiple virtio-gpio device instances as they shared the same
> > interrupt controller configuration.
> 
> What is the conflict you are getting since all it has is callbacks only, I
> wonder why do we need to duplicate it.

Ahh, so irq chip should be shared actually..

static void gpiochip_set_irq_hooks(struct gpio_chip *gc)
{
        ...

	/* Check if the irqchip already has this hook... */
	if (irqchip->irq_enable == gpiochip_irq_enable ||
		irqchip->irq_mask == gpiochip_irq_mask) {
		/*
		 * ...and if so, give a gentle warning that this is bad
		 * practice.
		 */
		chip_info(gc,
			  "detected irqchip that is shared with multiple gpiochips: please fix the driver.\n");
		return;
	}

        ...
}

For your patch:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
