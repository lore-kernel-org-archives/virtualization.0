Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FC367F22
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166280; cv=none; b=nyySAxV2D5ViILpCGNRwovfmcHq4eSo1Do0ey8UjH1Qi2+emd7E788cOcrKnketESRdZZ9L9OUJA3lH8xKv2BrJVJycC3Ix/HFtScB14yyd/xtIe7ivITzuPja97/owyCfwx7oYCocz1qk6xCRSJsunaAQXs057I6KbURcPaDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166280; c=relaxed/simple;
	bh=2JXv59EVE8tqU5CUvGyTpvWCqE6v5mn/F6kXBG1uDK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+9ZjWu2t+tGRnvsVewNLC2ct1eIxMQjZOvv9VJ7ZMJOQlmM3kR/gXtlf128FZ3MfoPW9fzqiKEEz/N4BJP5j68YEIj7ZkDlkn1dDWe2SqkOBVv2rdruTBT7BOrBd+9rGmCcauDyP2jTWduqhQiHgBJn3Rl9K5XM2j72ZDE3Qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ejw9/VuA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ejw9/VuA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso53107925ad.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781166279; x=1781771079; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=804yu81ouTxZb9nEIvZ35zhYf9Urr+McqqL3uFPd0xM=;
        b=Ejw9/VuApnNxcVy+HJ6b5TGzeSP6tH8cxBlpJTEseN2d8TINhrUa1BEII3J1w1Q0zO
         RlBamSGe/0woNzAk0J5+LuO1/KPcxha7YMR+MTxdtFTdoWq3hdNI+3gYLcPr4Q0wQYjg
         WBti9YFURZUF21dZHsZCHCWmAcI4GU8u0M6PmUDjMxSSx8zPIHS9KL4bqaALYzwvVg+U
         wEyl6p9KLlvW9uv0s4Kfr2wBv+oqzDT+BTT5QY6uZIva0jks2JSj/lG0wjqR2RtgaRO1
         xPr90no86NFsUoWEw4xCdb2lnbGdfhmqM0+J58P7UlZxxm+W07TX3+FKWvma0gbd0eF7
         vgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166279; x=1781771079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=804yu81ouTxZb9nEIvZ35zhYf9Urr+McqqL3uFPd0xM=;
        b=TLn9eipTkfs/xXwWOjqZeKMRAY1+KxHkPFs4TI+uinZ8miJXUM77nzo0LenZtWw9e4
         9Y5CVIdu48ozFAyMY8zWOtuo7nlGvuFrq84m0flbuxPpP8BvPUz2zxBXQ7RZH9VadzCb
         SJyZ5KImdz20QJT0pEVEbzLL50dxNcP9wiLO2Vf/JuQPS0fQ6m+al4HrPZqQUMDoGerD
         /qU3GC9hE3T0MNiB/fqXbUofRVvsgA7IhjKv3NO2Z5pLnadqjntyo37le0CspUwv45hz
         WLG5bZletfV8Y1+93n3lSNcoP91mvlggbBx/suAvCE5uOIcU18n2+05N3uBEpe35vhxZ
         HhdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9iniGdyVq+cDH5XVezgFWi8XCtWkhv2rqkljX9pFG9rGqMNMmw7XPhVX/XOERsjw0OZuToHrhVDG2QUlstUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoYQF11kaPk+Y3PkjBfpm0lnP8QuCYKXX90khiflANV7zCs0y1
	pioG7SAgc5zMBrF+gIHg+TWjT4TimGs9bDevORsgfsX507NmJbHrqhe4CsWUT3T3xHU=
X-Gm-Gg: Acq92OEv9G5JvKc7K9bEcNyGffJ1heD72ZEUx6Gboh5DDrwUhZQkZu8TvLEN2j9VqZ0
	FJMk4u10qz+RA2Ze39b9aC3yW0jD3AAAN2bdp7q9uVAx/cHBERuD5YxNNlxArbx0gOgC7ulBz5Q
	awNvihVDy4Vw0NhobOF6o4thoZ7bHQYHrIoaMSmaiKTMxi7fFmYfRbsb1bUwC6amfG14JaA4SM+
	xXQLtTadP9H68FFQO50PbeNBRlEW6B8OlFMCIzVfpF1DZxVVXbdypmhaLSOdYYRAmhH7yigc5Tg
	qKa0XzLmzYAv0StVbgvRX2C4pMTjfNW8rPgGP1Xqeh1O3y7gCNQoSesEVI9d576lQ9XtsllgWRt
	ho89Z/V4nT1Hx71R04BePSoYDouhotiQb4XRsqIojHD11AhNFI9/uTN3ZmAL3N9SsJnAX8IPtjK
	G8S+NSPZl/ozmf7+LSuWvwzvRyvuLqjLHO+g==
X-Received: by 2002:a17:902:cccf:b0:2c1:d49c:8397 with SMTP id d9443c01a7336-2c2f21a0e1cmr22477145ad.12.1781166278969;
        Thu, 11 Jun 2026 01:24:38 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm276101155ad.3.2026.06.11.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:24:37 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:54:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gavin Li <gavin.li@samsara.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-i2c@vger.kernel.org, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <yaeiwzxxh42y3oxiro5uxaxbvralwqxweb6cx4vzwx4y7nards@cysus3gbvple>
References: <20260610155834.79207-1-gavin.li@samsara.com>
 <20260610120606-mutt-send-email-mst@kernel.org>
 <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
 <CAKvMnUXk0GrYNNYOHvME6FYRdKik-7fV5B-NgvRM+i5yYKTmvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKvMnUXk0GrYNNYOHvME6FYRdKik-7fV5B-NgvRM+i5yYKTmvw@mail.gmail.com>

On 10-06-26, 13:34, Gavin Li wrote:
> Another option I am considering:
> 
> - Uninterruptible wait with timeout, timeout based on adap->timeout
> - Upon timeout, reset the device with
>   virtio_i2c_del_vqs() + virtio_i2c_setup_vqs() + virtio_device_ready()
> 
> This behavior more closely mirrors what other I2C bus drivers do.
> The device should be completely quiesced when virtio_i2c_del_vqs()
> returns, avoiding the UAF.

Looks more reasonable with lesser drawbacks.

-- 
viresh
