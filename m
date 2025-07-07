Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C4E78F2F
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876975; cv=none; b=hvRkV2crIwdGHUKAOGmjKHFq0+urXuF3T+1k95bzUk9Pnj1oy4CpeFiaJq6M5SUWSU5Ugjhx5RAFAUY5ins5cwse4Hb7pAyo/zIOx5J+TPl/ya7vBM9XiaUVszbsJvGU/Q7RNn12/Z72OQuZd1NIykQ7N1byN0L8PoAPLNRacoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876975; c=relaxed/simple;
	bh=ZmuwxEwRz9hvR9dPQVP2ysixcdlQYWY+Fgsp2U0+Nu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvhhIMQmKoiFyq6rmMF+P5bNh/Pn208LIju5ba908LCbr4Yv16U8dPyFTwkaMBdqrEI6UwU88olLX2uiJIeciB9SiiRj5iASD12vJUUhjYpS9VWNqSEoBALE/yMT5zv1wyEnRGT32FnEbn/7l6xpYjmqKmyWxOWJE8SUKDTSqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t/Laf1FG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/Laf1FG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2353a2bc210so25139115ad.2
        for <virtualization@lists.linux.dev>; Mon, 07 Jul 2025 01:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751876973; x=1752481773; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WktzVbMCOuSz2XCDiNHlBWqihhwDZRtZkZ7oMJdFGs8=;
        b=t/Laf1FGq3U3CFhfstH5LQ4zIiFfVsibydH7tkJSAKguL7yoWVv5rf7h9yynfKWdX3
         oIkR7tK/+glKUjMit0I4W0yPelmY6XYnQMjHAeeYS6j+l9BOdRT5DIm2fWowcnRTEjMx
         PzddKxH985w0xT3SyyPzkv05YSKgkZVQg+/VEhHGCLm+My6qokgXEbaj9+91z2MhUEDO
         ZGbsU5DsQ4/mySa9p02cRrxXuGmr4qKgI3UrzMO5T5byVrKGymlvgIWcH/ByZ7b6pNqG
         Q26ZoEH3U7DV9TzTIA95NGr9ORSHesmZz0vszQTkkgCzRsbSyV9EtQbinbhrMhlL/oH7
         B9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751876973; x=1752481773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WktzVbMCOuSz2XCDiNHlBWqihhwDZRtZkZ7oMJdFGs8=;
        b=kTdp7edXok2qO48CCp7bNa907rtyVw+LBt/+9wEXDPz5maxm3dqtRnKJSYgZJtoiAD
         or8xg1Oi4J2BQraFe5gZ7+XvpszMomUpNF1e6d0WrnVtRi6RVn0ZZFbqzygWpXhICKSH
         wzr5N7P3x89MZ6oMVEKO3G+G+w3JkTcV82sYwMMS/WdD3dez+UNDq0P/k/oWUC1N0Q4c
         n/uz9+bXqxkiO6VWpJgoreC7Ztn5jrizFVmGnbdYs23jNJ4XqY2s1jXVewgka2xTkfzR
         Q4PMYTMwOlwVGU29ikF+V+WW5lPVPPbUfuA8Imft50wa1+hjDSuLCmeIpEkzYDZOuy9N
         zupg==
X-Forwarded-Encrypted: i=1; AJvYcCVEmSHMWuMsP2xyiIETOH0nqW5o8OIlizmi8V6bR5jCp7GcMdXlapzh+WuUnQSga7VZNCcONYrRWY6IteXCPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaZPvBXyRR51IjBScEx5TzaWmXar80L+EpX31FlS1bNF/N5AWf
	17gk0ptZuPWRRupu9tyEanfPYGXo57j6f/b3hQ5r8ElP6Ol7I8/XtXu/aWKALgM7TKM=
X-Gm-Gg: ASbGncuplDJ63cy0KJZJDuciRxutAzYQWcYz5c0FRRJBOBPnGJ2MQ0Tj6K2kl6iQFEN
	RjP54oPuBJS+E4g8ZsG67p2p9cGc6q8wZlfEufOs2LV2j34TFcwe6kKLeXsYnnQJvw6FWakLSk1
	VQL7+hw4YZUTz3Vu927eNfZkLfWFAEoytvW1IUKppVPaF1u4iaFdgI880ITcUXnx9EjviPR9/nH
	xcw5/XBBzpraBeC+ZPt4TPW0dCXpB7TQfBs4DZHgf7mZV317s4Z/daLN9CiMdd5yw8UC5HbSUAj
	j6qVsf+5EXJqfpw9mfJAA35Q8UsQLwLoFE6zg/GeAdtFNXwL/4Wku7XqD6dNlDo=
X-Google-Smtp-Source: AGHT+IEzG4PTUXHjQ19lS5u/nsqPLFIxy4HYD8J7svSUDedR3HYEqjepBCTrT6erZSMiBmj/Gzsypw==
X-Received: by 2002:a17:903:198c:b0:235:7c6:ebd2 with SMTP id d9443c01a7336-23c85e745b6mr148490455ad.31.1751876973579;
        Mon, 07 Jul 2025 01:29:33 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845894a3sm80048605ad.187.2025.07.07.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:29:33 -0700 (PDT)
Date: Mon, 7 Jul 2025 13:59:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
	linux-arm-kernel@lists.infradead.org,
	virtualization@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 12/12] gpio: virtio: use new GPIO line value setter
 callbacks
Message-ID: <20250707082930.boxyt5lrfmmxjrmk@vireshk-i7>
References: <20250707-gpiochip-set-rv-gpio-round4-v1-0-35668aaaf6d2@linaro.org>
 <20250707-gpiochip-set-rv-gpio-round4-v1-12-35668aaaf6d2@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-gpiochip-set-rv-gpio-round4-v1-12-35668aaaf6d2@linaro.org>

On 07-07-25, 09:50, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-virtio.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
