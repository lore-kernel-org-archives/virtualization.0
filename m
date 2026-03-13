Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30B1DF980
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382180; cv=none; b=qF8hDSiVYWhBpn+eYu4EB+9X7I8FFpmYAmeMl5KSV8LI9vQPfMTn1jocGsPQQk86zSu6p2OufLuLzS3FPaXXQ719RZmrfjzOC/1WK5UdUsThfVpJaYYF47wS8SVdKNg1Fl98/FTSXi8z8qrRr9vuSSSGAav7MP5JypDmRYU6rAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382180; c=relaxed/simple;
	bh=tMO9psBLLMvClqTpa7aKiQnuy7/vbHhQyKWYXYxKS2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh98EbDDT5DUpN9CZIEJaWOyTFwVQh5syt4LO0rL3hpcBOiM5w4jt1mUudKD78tsrdr7m99ERbpUe1Np3RYSjpAjhmT6p9tZ8/1iIwyUlBDxNN/5m92a04TDkQsODYSr5a/2ZqcrZC0MR/iF3SHJucrcFtCmDbaWZrq6ptfZpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edg6aSJW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edg6aSJW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso505912a91.3
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 23:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773382178; x=1773986978; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NedMiBsFyZMnPxqjdpPK7kjyHNNvVmLJBW01aJOpOfk=;
        b=edg6aSJWy8YqUngnUQRwGh4orDrhvX5ZarKLEGrc8e60b310x8rarcadw8F+SCPpIK
         wocnzOvrCh8pms6kTewfsAsdW4JV2DOjbH32AM2VdmRGHd2Mwv4CHsc641XaW9va9SO2
         zscyNJ/9Q3BYebUZ57T6iSGipRQ4tHYzoy1pHSGEvamcluCtrWB9CxA4scsAAVrQOFwt
         8EsPt3jCE5JkEK5ZX1C+NsFtxlIZ53xfnAyPKLzKVoC006jsbKh1q2e/THX59ltmit05
         eOzr9JyscIUMZ3RuK9/WnV8f2cMZCMwcP4i35WYF24GfnBY7h3qFCQJOELi8XSgWhgay
         iXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382178; x=1773986978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NedMiBsFyZMnPxqjdpPK7kjyHNNvVmLJBW01aJOpOfk=;
        b=MGywia9rt7ZsGEYJQmCJ3KgBj3amBNhdEthfLNw191PWuqpXJJ/lyvewy3oBzuwtcY
         qSzehZ1dV0H88NX0MUDOdTGsTV7Qxs9YKRKPmOM5VPhJJV1hEfSOKkLxv6onTGsdPMHR
         wbuyer892NiSgapp0VhjE3ikwukeQLFgPOrQxlhqFu0SZqVBCV9hYvGuHb3EyxcRRGwb
         /nK8ukdrz7IUGqD4EQYK5M/BU4UBP6XdrKxxXW5tVy3fstb3o+u2faveBgx/ya+x/1XF
         F8e5E1kU3qNeeyQnZ+Ex8QRhtzl/A1tjqst0jnQtEWc0cmwVzI0ZnA6TJ9tWci7njpus
         toKg==
X-Forwarded-Encrypted: i=1; AJvYcCVhzI/leWkanUNB2PdAp+F91z9+Ah7C2C80Zw7cNOTnMMsKn2lUjRbdLFwsoGOULAiVeiKcW2UeLtPOeI6YcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YypD4jXSGQ9mL25TGc0hgJ6PkshrBtw9Fdnh4xg8fgwwk4mEeXW
	RbLKzrxeqInGnYtLpiAw6aK3EE6ci9Rogx8+Aei/7ATnVLIBqov67ROzDSpXhBGPCxQ=
X-Gm-Gg: ATEYQzzoEMekFnVdOKAKNutYNaV+9LuE+AT0KGYTo+tGCfN5Uc3/06rh6lcr3ETLeUx
	Hwv2RWZuc9e4lLzhRV9mRC717l6QP2IpB0iF7E5hspBpqPTQOAx7wAPpIESDRPekCj9InqT4GqJ
	CuLqbBbc2mAuL7rlOpl9tLuSgLik3Vc5/gztta5Pje9yntQYDfcTZ4hKJsVzbrboaezjqae106F
	P4lZSaPb5kJQnEw4NZi3Hf27A4dN0BrO9EuVFi0Hh/pvADkbgmWA6dI0XR6SfZy6Q5jVAQPX/Vd
	eRgiPsUif/2n8m0/ouSM/LEXyCRjNyblDY4PUoa4+qTU2YBUZMnzjefug67CVuDgHpg+GyLM8sl
	4hOsV7gbBcjwfO13PUay2K86iJywEAJ0jFhvWqDbvaIB29Zghac1VL/PeZ8DcbFqRee/zDYotQa
	bdOULcsUNML3wNoUc/d9QXlDnN
X-Received: by 2002:a17:90b:3b87:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-35a220811a4mr1802735a91.29.1773382178162;
        Thu, 12 Mar 2026 23:09:38 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a1c34fa3esm3329099a91.4.2026.03.12.23.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:09:37 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:39:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"open list:VIRTIO GPIO DRIVER" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv3] gpio: virtio: remove one kcalloc
Message-ID: <7jwgbrijeldghk44tdg2be5q7o7vuj5np3nlbl2pxuln6c7ll7@ntuquxxdnfmm>
References: <20260312193717.12221-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312193717.12221-1-rosenp@gmail.com>

On 12-03-26, 12:37, Rosen Penev wrote:
> A flexible array member can be used to combine allocations.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  v3: add counting field for __counted_by.
>  v2: add space in struct
>  drivers/gpio/gpio-virtio.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index ed6e0e90fa8a..57d0eb532c3c 100644
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
> @@ -60,6 +59,9 @@ struct virtio_gpio {
>  	struct mutex irq_lock; /* Protects irq operation */
>  	raw_spinlock_t eventq_lock; /* Protects queuing of the buffer */
>  	struct vgpio_irq_line *irq_lines;
> +
> +	u16 ngpio;
> +	struct virtio_gpio_line lines[] __counted_by(ngpio);
>  };

I wonder if it is worth it anymore. Why combining allocations is better when we
are ending up using more memory ?

-- 
viresh
