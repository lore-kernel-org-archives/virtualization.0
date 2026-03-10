Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312AE23B62C
	for <virtualization@lists.linux.dev>; Tue, 10 Mar 2026 05:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773118913; cv=none; b=RCr/QCv0VBfswOeDHxL6I1V0aRiY5B/RBexMFF6sWAPhNvywDb1o8pkeoyAZiQTGseuzQqBvSOMKyEPWzw3B+wAs3yMY+nOoxyMyPHg3zN8vASj4wnIHXemPKiCvr98jOpLTvJPfb5R5ItBWlcRJS3N7Gn9Lf+65/YLQN/t9I+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773118913; c=relaxed/simple;
	bh=R3jMW8ZmkBtM32pcjgP9kGqpFKjlYsyUvI6+VjdQ3I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwgLdyRD4vs8rvJYMWn+hOBl94pFMSDgiQa6U3sSRTe+uhkviZMf8q/73FRo2V/5b5s6yG/EivF/c/TTX7lxIe4hbfhwl9fyox9rJT1ZpeQ8e97FzwzO/ZbYcBVEL0lyi3Zi2reJJcX7kN336E2U2DFuC1dpHIKJgReMZRuvWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUves7Dd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUves7Dd"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7388fb61adso1901920a12.3
        for <virtualization@lists.linux.dev>; Mon, 09 Mar 2026 22:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773118911; x=1773723711; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbT9TM6XMNn8MYcYe10K1UH44o/w1pSutn1XPvv9QwQ=;
        b=WUves7DdIIR2edCL2aTx+kFsSu90rMxpG1r+gZZpZJNFQJQcCAMgVmpUuiaOfz1+aC
         m3VQvC7eN4YtfnAKr1DM72UBBytfLdElo0KqcfVzm1znjwrx/E6TpJ4VIC38EnjMa0hS
         xavuExv5KZeBm7AhwFVwyrxbztivXL6JRerWpaMd2Apec0d/8uR92F95HhABon7PyYwM
         ngWRPesYWFJlTUePZzWfu04WDb7fRs/yhnUqbqf3/n+EuZj3K0qxvFL9hvZs6mJL8Ezj
         U7dUZDyTe3mrW0v3a01z1hHtkbWk8ec/4jtHfe6b96o7Z7Is/qHcEMp9vTeq7NyG4LOs
         Lkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773118911; x=1773723711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbT9TM6XMNn8MYcYe10K1UH44o/w1pSutn1XPvv9QwQ=;
        b=UV09nEM8I6v5iH2MUMSV5Vl9+w+FhMLVor+4JkakzAgT91KEouEI4kH6KnNFkBAGa8
         qFuMfpNHcmOr8XN5aMWhNZz6vJcHQwUcxrSqeTEqL/zqsP6bdG47Mk5BNfLa21DjghSs
         IIdsmHzJJ6FtqH+el4pR3YvvOmZOMtthpQfkFrcM3qPE9+ngb8NOX1gmEq8qKSVV8jnz
         GtSCm8wPZ/DgoU2DaMLyAvPG56QYBHQBhG+wh3Wf7upxGTWSRq4JMzTMPehWUpN4ddUe
         XT09soVXE/IGT4eAfB94K3FlID4ck/5h9gfhH+Uh3TJjaaaLow6d1X6zav4eu8/rjf4R
         vgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXafJ0tFq2hV7uEzavnv4nfoIC60+eMBwj3HsAH/pUib6/BqyB6Cq9CPY2L0kl+u7YqgL/dvChv9BE0E/86Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC761Qt/q4bOunVwFUEtyYhLTm1H5cCcSSvGuPAEvT7u63I6Gd
	/uXKarph4tiGsVmUcEo4UIY7cC3ffL77fpHLsk6HhbmFNgOXgfJEhIy7uIXH+I4vx8w=
X-Gm-Gg: ATEYQzxXAh0rEKEEgdsxpYa+7CBevmF9SQWQ6i43/qwfA2Jk7yDDohg1oAR1D1BKvpb
	ffw28AZQDUwU0bLn29YTfPRuPUwO32HN7xnRz67ndQK61Dkiruy78flYX0bT9WpmYXcpYbQtQwy
	78o7FSEGB+HVsUAC+53vOBf2r8ynrVaew8rLW9d8bI8/H19KimgX74TYrEZP2F5MT4QabQlkASt
	D0WYesy3oNXO26smLloIqd1VoJ7ArE31aud7JvGaWHPbSsYdwa3fcD0p8AlOXL+nqLBjEZFBsxH
	XFU6L8SudPja1kqnULAqwv4tfaA4ZkWlZ6AUXI+CqhwappFyeARP4kSBRgg6rgKFpL1NT9gStFU
	87aEJ5Q96hmMLRUPwRpb2sox+TC460KCc0lAxHwY4ZZlYr6ErVzzWoIIE/fJrOF4IPKnd9CdZZn
	4KwcaQpDDPJWk97peVOh83jSVN
X-Received: by 2002:a17:902:f68a:b0:2ae:7f24:27ec with SMTP id d9443c01a7336-2ae82512971mr142991985ad.47.1773118911306;
        Mon, 09 Mar 2026 22:01:51 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aea3d26565sm11358025ad.2.2026.03.09.22.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 22:01:50 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:31:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, "open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: virtio: remove one kcalloc
Message-ID: <sdcvb4g2d5optcout5f2qvvdvnb2g6o76tlc2dkf5zl7p2mc6j@52ejlit6fnoj>
References: <20260310020057.340550-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310020057.340550-1-rosenp@gmail.com>

On 09-03-26, 19:00, Rosen Penev wrote:
> A flexible array member can be used to combine allocations.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/gpio/gpio-virtio.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index ed6e0e90fa8a..876a34ed739d 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -52,7 +52,6 @@ struct virtio_gpio {
>  	struct virtio_device *vdev;
>  	struct mutex lock; /* Protects virtqueue operation */
>  	struct gpio_chip gc;
> -	struct virtio_gpio_line *lines;
>  	struct virtqueue *request_vq;
>  
>  	/* irq support */
> @@ -60,6 +59,7 @@ struct virtio_gpio {
>  	struct mutex irq_lock; /* Protects irq operation */
>  	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
>  	struct vgpio_irq_line *irq_lines;
> +	struct virtio_gpio_line lines[];

Add a blank line before this to separate this out from irq-support
entries.

>  };
>  
>  static int _virtio_gpio_req(struct virtio_gpio *vgpio, u16 type, u16 gpio,
> @@ -541,10 +541,6 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
>  	u16 ngpio;
>  	int ret, i;
>  
> -	vgpio = devm_kzalloc(dev, sizeof(*vgpio), GFP_KERNEL);
> -	if (!vgpio)
> -		return -ENOMEM;
> -
>  	/* Read configuration */
>  	gpio_names_size =
>  		virtio_cread32(vdev, offsetof(struct virtio_gpio_config,
> @@ -556,8 +552,8 @@ static int virtio_gpio_probe(struct virtio_device *vdev)
>  		return -EINVAL;
>  	}
>  
> -	vgpio->lines = devm_kcalloc(dev, ngpio, sizeof(*vgpio->lines), GFP_KERNEL);
> -	if (!vgpio->lines)
> +	vgpio = devm_kzalloc(dev, struct_size(vgpio, lines, ngpio), GFP_KERNEL);
> +	if (!vgpio)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < ngpio; i++) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
