Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90F1EEA37
	for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262145; cv=none; b=R4oy3Q75ri6iEO2I9T9hBbjoghD+BTdYL+ubYsP+kMtnQBfjSJnlxikwMybFKQxrA98Ip1aUoduBu7Rk0g4RBfxigtDrMT7YDKdnAffXfPJ2PtQ08dK3SX2WWVoQExWgz8PnkU/aly0PkKyNQA5ERzjUzCc/rd6qW92Nxw+Kd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262145; c=relaxed/simple;
	bh=VtlCoBRlyZzN6frYOm+UDR9Y9LTgg9CCmXLOlgK4JqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BRVH/MXjaTP1K0b9IIv11OtySyYiVy647HjdFNk9QW8G5YlVlGzvmfQHod5B2vH5fMDkMlgvC72zQbZlZReP9vvk2E7DSp/97TO9yeMVWb8CSSqsJ9WZHWwGXAO11oXopNgTrw1kd7unmiOCzGwHOvu0cV1l3ysZSi0GbnbC6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NMin0yOc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NMin0yOc"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38dc0cd94a6so2421159f8f.0
        for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 00:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739262142; x=1739866942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abkvBx0v5xQR+AB9ER99VMmoPJKSMX/xYZ55cOWkUJY=;
        b=NMin0yOcXaRe79W9sKNxBhF/t/dD8KeUa11UXI1Flc6dYmGDfJlcTV5zGCoXv+uXtN
         OFBxO2wQYLJTEEdW1AELYOLbLmZdGT59aADDndKYifCj4EEPoGY3TbU49oxuFqMY0UbB
         LCrcs8oQccoSyEsUcE93w7kWq/M8AWREI7lPkoS0ODO/aOLpyUUn8TMjdVnAr+/JDpdh
         2RlGQM7RtIuHZ1tmwZDh+sm1E6use7YENkFDDRIRXCp9CzjxSuaH2OwJ6/LVhxlV+XjR
         hzZ7S+LB8Ks9/el+XQX5vy22bXFxCEhyKMu0N1vis96re3gmPhRqLJANEUBZj1Rtu3i9
         v1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739262142; x=1739866942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abkvBx0v5xQR+AB9ER99VMmoPJKSMX/xYZ55cOWkUJY=;
        b=FpARcKyUvoAQIsmRuLg33y20YYqLwruIxuFmW7qtL1yaxfIDhN5+fRm/zEU2lNNsGK
         4ZPDUQOwc2KaRJZk+odemBp1wyCnLwPFfjwdplog6resN55YYZh/aFAplvlRkf44nwnI
         3ptOnxZXI+/DYVwI1sznxxuQohtKE1uY+d9f/+BS+GBlBmQpv0gExJgDjIWvgs8QKfeN
         I6L5WN0K8gQQg61s0msWHJrLPI5rOzuAJLdnaeqFUEeoV4vEZBhuOYTYI24q+uu9p30F
         RuJIzynfG5KwJWI84YTIml5RNf4VnLAo1u13QKtv9Nai5j8ZKl6FC3qSIT16lCwFugrn
         YiBg==
X-Forwarded-Encrypted: i=1; AJvYcCVk0sxeSUY5OhIJQnMbLrtQsNJiBSM36lI+JGgs0BYS4qdoLN0puDI3CywZ7vHycVjAq1qYVPXSUHE04FG+AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU7/QSQY7INAVrOmyk5kgBPm1AxbJeEUtobtwsz1emGgOMr4LH
	erEkYIvmluKG+nTnsiKgRK2keKI/dhEgB529MplK2c9oA6XYGXWwHUnWQEaZPtY=
X-Gm-Gg: ASbGncvrmi8xamDn/9rg019Fka7e+/MlhRs1Os5LSqAalFpWkkhJckPKviMiKogbxFr
	+kdlf1MP8BukZKsP40bN09EZEdQInTQeRAYBfwB/Jq8cLFWHt5AZ8m4iOEcRFj1dd8MiYWhaep+
	Hl6dB3UqZAon7UCxTan8zEQ+8IxEwPR9qrhcxA4xbvf1OQ0GSIGsgBiS3INGnxxbO6JUojeEgSY
	GJdT7S57GZ0accJvArOiBcFEcTJmLNDwhMFMbToR0jhjV7UN7VdCrWUjnhXjNTdzPM9QXsLUkOf
	O723C4rJxBwrmQ==
X-Google-Smtp-Source: AGHT+IFMK0Nn9o2/qeM7LLSpZk9GKr3o9T2LYpmMng3eAzPZNsEZRpFEaZ5tqKD9U5N7kc3OHLpkdw==
X-Received: by 2002:a5d:47c9:0:b0:38d:e12e:5db4 with SMTP id ffacd0b85a97d-38de12e5f10mr4447546f8f.29.1739262141893;
        Tue, 11 Feb 2025 00:22:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:561:8978:1d41:636a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dccc1f531sm10913753f8f.87.2025.02.11.00.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:22:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: info@metux.net,
	vireshk@kernel.org,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	viresh.kumar@linaro.org,
	hlleng <a909204013@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio:virtio: support multiple virtio-gpio controller instances
Date: Tue, 11 Feb 2025 09:22:19 +0100
Message-ID: <173926208976.9431.867890278648224136.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250210114935.204309-1-a909204013@gmail.com>
References: <20250210114935.204309-1-a909204013@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 10 Feb 2025 19:49:35 +0800, hlleng wrote:
> Modify the virtio-gpio driver to support multiple virtual GPIO controller
> instances. The previous static global irq_chip structure caused conflicts
> between multiple virtio-gpio device instances as they shared the same
> interrupt controller configuration.
> 
> Fix this by:
> 1. Remove the static global vgpio_irq_chip structure
> 2. Dynamically allocate a dedicated irq_chip for each virtio-gpio instance
> 3. Use device-specific names for each instance's irq_chip
> 
> [...]

I fixed the subject, there should be a space after "gpio:". Also: when sending
a new iteration, please add a changelog.

Bart

[1/1] gpio:virtio: support multiple virtio-gpio controller instances
      commit: 84693df49dac458e980eaf37f26ae6e23ead98d5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
