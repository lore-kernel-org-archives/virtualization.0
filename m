Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BC190045;
	Wed, 26 Jun 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420229; cv=none; b=Hkg737X8OkClXEqXgcb1FcmqbMqCrPRgHu2gL2Fpu7MsEvHOyYxco2fjlSxWm1xE8WTck02Bt1cdGo8bGEAKXphbquQf17orNfVGTyv1v0ozPtCvWMjScoNNs7rN3p/FMctnX82aupWzegQoNM/Q+tk8qjo9rghwtVaMz2DKPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420229; c=relaxed/simple;
	bh=VG0CTW/l6QMPvH75w6uUTc8si0UlyREe3hdbA6mVWjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGjT0WPI9Er1Xcrpe7wxRXouPSsNiKhP0lmgEGaquN67jU7CNXFl9YqwlAGqFkfHANyfGj1ugnu1zZP+bXebaVLOwb1qm53Kh8+tKyHPNUCoDieAtfzAE7Um8mTbuV3GJe7drhgA0VMuEqIn0N/3G4tfdQBPsglc6DYsEYZnzIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dx/lvlEF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dx/lvlEF"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-630b743635bso3965127b3.2;
        Wed, 26 Jun 2024 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719420226; x=1720025026; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zhrdzthSK3H9hkETy9VZKmUKkeoLCNjPCZYKjf+xG1s=;
        b=Dx/lvlEF4ilvT/9od1ETB4zZ+x4ZVdHtlQzXzGs8wMOxaV6S+msTiR2OCKmaWKYD9F
         slyzOTduyeDFani3r1ktPmn5lAZmt5V/EfExPm4FouJJKOQ2ERSjDMp6NMI4oXWpYpys
         IQhe9bvujsq15U8eZZmDMe7TekeUsVwKOQrxFKAVzeid+B6fcL9orRSo3Knog0n6DbSL
         4RSfABIO4qXjmOse0w9Wpud0dcUyS9N9SCgRDCFyIv37qXcxCae3+2yKeP3Qc+Ll18qU
         cpQcSLPy2wc7aMGC7dTlVRsG3Dt+7LyegT2fYpR8JezPMN9eUjrI03AwyME3gAyx6iQq
         4/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420226; x=1720025026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhrdzthSK3H9hkETy9VZKmUKkeoLCNjPCZYKjf+xG1s=;
        b=HWUXO5riKBOXj1xU33cAVrJ2N49yKtuEaJhsD93d8g5sPicuAWd/bHQfMcKEBaGRVT
         ki5/WRqqZfhmaxu+RoLQ9h207LSL0yarjpo9aKj8s5FDphwUbzsUUBG5w3ww+HzVNQMd
         LwR9madPf1AjSrmDerCC1y5Per4k4IorXrnJK2LuVB0rryNRbz59oscivjXwWmi6cds2
         sAZOGt6V4BMfJoBJ2kYRAza0OULzYHf17/R2BRunx8HZg0Nhgqs1CrdgqFQW9F1WIr/b
         jZYfyAxAIuvfFKzKdm1vYCtCbWzqSQgytP+jSO4XZNssApNpCz+os0vi+kEV4UcePpwS
         ymsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBs/EwBKZWVXcg5FB1gKtC7qqZj8zifvSK+oFfXPsQiB3wcivNX9AmKnkllPPds+zsHesRYcZPDt/e/oN95otefMIzfaLeUHVAegsDA87Oc8jGSZ8SWMFz0l+5MYiE/NeVA6mX3CcqLeMq
X-Gm-Message-State: AOJu0YzUGFn5Q7Htgil5Ztky+ZZ5jp7o7X8YzMRB7L7GaISq+i7ADh8V
	frppujho80K1KZkP1eNICe404yXPpLY8Q2Yv3yw/kxbBUCu8OgLg
X-Google-Smtp-Source: AGHT+IHCdgDSdlNbkbnAcycpINiojpcU5U7poX3MUB5iUjfsCrwkArPk6D/Bh/TNX6YdFEgG7FEJJw==
X-Received: by 2002:a05:690c:63ca:b0:62c:e485:5591 with SMTP id 00721157ae682-64207460d3cmr94060417b3.3.1719420226540;
        Wed, 26 Jun 2024 09:43:46 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f10f8847asm39169167b3.5.2024.06.26.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:43:45 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:43:42 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
	"Ridoux, Julien" <ridouxj@amazon.com>, virtio-dev@lists.linux.dev,
	"Luu, Ryan" <rluu@amazon.com>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Jason Wang <jasowang@redhat.com>, John Stultz <jstultz@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [RFC PATCH v2] ptp: Add vDSO-style vmclock support
Message-ID: <ZnxFPkwGKTdRWTZh@hoboy.vegasvil.org>
References: <4a0a240dffc21dde4d69179288547b945142259f.camel@infradead.org>
 <87jzic4sgv.ffs@tglx>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzic4sgv.ffs@tglx>

On Tue, Jun 25, 2024 at 11:34:24PM +0200, Thomas Gleixner wrote:

> There is effort underway to expose PTP clocks to user space via
> VDSO.

That sounds interesting.  Has anything been posted?

Thanks,
Richard

