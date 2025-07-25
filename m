Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9D253F12
	for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 08:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431050; cv=none; b=plNlrhytsN8unMeOmuNZpq+z+LjbZv4LLFkUFKHgKdizb5wjrp6mqf5xwycbzmWm1ubDH01I3CWbXOfZqR28INDvrB5D91F2Elm2JwuDtgkr96ZNMSmHufE8x46rj4itLDZ5o9Y0kQcSLktWE4nA7jg6uCMM7n5E++TqKg1uOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431050; c=relaxed/simple;
	bh=/8Jy2q7BUbMRemNSy/ayI7mRAKf+o02bPXV7CnXtXQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAzhPQHitHSgVxG0JPwFrztROkkbrhM3CIX6lLbXrwf82XvdtmwYYAHxu2ySBDUTcfIkVy4di2ptFuyVUg0Z/MSDCmlDrFCXeadMgsXsg/E96JD5SqpQyJdEPbwPjhGauABgynX87PJYb5HbhGoLJL/tQhfzEe4427APCVVvRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TQfYHhes; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TQfYHhes"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so13178515e9.0
        for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753431047; x=1754035847; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjnADGgMIxD9Mwt4aQx2cVoKFVB9u557YmwsL2pYhHc=;
        b=TQfYHhesEFIipDn8vIBPTUAaf07+0+qcFwyNKaj1AQMf61pps4+7Gv9CnqoSJyumH6
         ns2guxFbCun74EajpZjBhZj178OH/RAPzm2ictyFVCfUABs/RCtp0I0+f5RYWikOQI/N
         V/yMd5nJGoDghACQ2VpWKeR9YpmCZ15ZZLpbolrk52FFSDED6m5KjlwFP1tGZbSY98V8
         IXw7aA0/l0+q0heMgKOIhFHxWUB4+Z/W9psLxHE6vHwO9b40WZH8foYZBXo4HBfNBbRj
         IYISLyIC+U9+ghH7KfU6+DtvL4I0qPtvf7B6WMW93oGJsbm54A4HHQ0x2+PErpNTv0N0
         tjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753431047; x=1754035847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjnADGgMIxD9Mwt4aQx2cVoKFVB9u557YmwsL2pYhHc=;
        b=feGP3J8aqnlvmOoNBDR0wujNKo4huhBIuo73Bzmg4h5fxQa6a38P6zOwyvK/pbQaVd
         JQDA9fR4LOvNk3vVU4vZLokn5mjixLdqwatq7ER6WwgIWEwhpzS2e7BCMXfAn933A3OT
         l70pdI6xH8bFC+br/9gNiR9A1HNdTbZkPk/dpmUtUZTuLWgin58ff4wvECqDIXMDyl3E
         A3rGW2bkBk0k98H3gq4Knb/N/rsk+Qg9YW+QBiQWhJLQNpE+M94t+ld3Z5TLp7mdQ1PW
         YJxgQeSok7mG9xs30Qe2uyK60OR5ySrH0SADMnikdZmwFOF4bfvYWf02Zr1aR8RPHhpI
         dt2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY/OG24taB/N1x/pF2+l3ffNXenKpXIgiCsnYmw0gxk0NIpB1lqDaDRHWXmxjxCQRzGuo47UZrEJ315DrUDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmBvDysi4eEaRgpgLOVlrP/nmoRVL9qRAqM003j+/2/FgKMPKF
	sNjx4zk3odCGvZ3YsDWa8gkEYSQCJOF02fVe3ZrYTqk49UhXanKNINLfzrMAy66+Gr4=
X-Gm-Gg: ASbGncvc8d8r71t9W8UeZjmKqNZ8JS3gXHHYGLpgylvvRIpIu+HwNjuSEv9zmqBjcwW
	m3MjMQojIPNNHOWfFmxUV3ikAc1UeZvgeQKeBYyl+kyDwpyHqC/ytBcak5BCKM7IwLDyHfnpFke
	DnBrNzMcV3Kpghaj4EiEu/WxCr2EYM6L+m8vn8rP7BdNg8CUxvfN5YQIGp0vKowqmtgS01f7lnb
	S+d/FFpTyjf8fe8qf1ylmfrOo+FiAWjK7zFzAOB3fNQOTV2K3ZVaAFmsN+bxmD9Llt+9XB/s+M0
	nTwuzOk6zxfBfq8UCeT1NvlgxyaWHsBLxscrBKQ6nQY1i+2TopUxvJQTXwjA2rc2ZjrXhVElcAq
	r0ODHcUcyr9R+l2EZSkzxsO0=
X-Google-Smtp-Source: AGHT+IFtrN6VUv3AxAAmMB1p8Cksy5ht9aBXYvpOBIp9CQazid75UckioUfrsNhXmPCAYyDnC0fv7Q==
X-Received: by 2002:a05:6000:2407:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b7765e6ba2mr811266f8f.3.1753431047252;
        Fri, 25 Jul 2025 01:10:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3c3c:6b37:9b23:6049])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad22asm4402723f8f.53.2025.07.25.01.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:10:46 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Enrico Weigelt <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] gpio: virtio: Fix config space reading.
Date: Fri, 25 Jul 2025 10:10:45 +0200
Message-ID: <175343097349.17150.917277696050409769.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
References: <20250724143718.5442-1-harald.mommer@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 24 Jul 2025 16:36:52 +0200, Harald Mommer wrote:
> Fix for Virtio GPIO Linux driver
> 
> The Virtio GPIO Linux driver reads the configuration space in a way not
> conformant with the virtio specification. The hypervisor we are using is
> strict in what it accepts so the current behavior causes a problem.
> 
> Builds on top of gpio/for-next, tested on Linux v6.5.7.
> 
> [...]

It's already Friday and I won't be able to run it through the autobuilders so
I won't be sending it for v6.16. I queued it for v6.17 and it will be part of
my PR early next week.

Thanks!

[1/1] gpio: virtio: Fix config space reading.
      https://git.kernel.org/brgl/linux/c/4740e1e2f320061c2f0dbadc0dd3dfb58df986d5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
