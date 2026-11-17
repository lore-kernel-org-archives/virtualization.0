Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892233;
	b=R/Dbp9WhpZOI/YBQ19uZw/mBSjItt5FY7CsKIPJcjpz9IleOR0xfzYrJ3HiWRabUxK/A
	 JmtRF7jIHCbawk/2QViv4f/DsjFhv/CgFUXtkZRDWdmhCkkSh6slP2PSiAASxmilgmaSM
	 ftyaVNZO0uZCNk8Ow+FY80J3aSL+ip75TYis+x03lnPZaGsu/zgOs95Y5VM4Q2NLtkM7O
	 7gvM85UwSshnJF77lc+Ea5zenO87pry41VWugyyQwkI8GppA2eTJD1+WEGcTabFrXbdCG
	 ztNAANFxNhqneVzwJTQtYYdC4wO6fou6OJ5DKL/1PkmB75RDp//Wfq002mEma8KfWtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TIi30UMnkbCM4UtGXQM9HLD1fy4eaWCJLQHah5nV8Gg=;
	b=X+aBB5e2KMRbPBtLse228qCJC0+YXHtSHpTwUKtZK3DCdnjD+TjuLH79okVSnX4P4PSo
	 KEDCudoNy9mPSjfOb1tmGLurBhTKk++XjiJGIqKi7DBtERJlEOQc6tyQwEcTd/NeKpbKb
	 38O5n7EbHH5BCtkUK4/ErtzFT3Udk9nnDU+khz5Q4G6JAY59d/pg24g0qxsH4SsYZr2bU
	 HfiXxO6qzLQs9WzWKvo6TaAOjMvAgupOgJDiC1fT4lRm5woNmaiaTJ4CT/DrOniPT8LFt
	 7XvtLNTh3F3VdJf9HZL7cFwCJZ9aqOu20a1lSJn0LygAgzM+tFFAemxIWlRv0aqoQrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FHgdsm7C;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65EB606A31C
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 05:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FHgdsm7C
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2761c69fbso494695c88.0
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 21:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794892232; x=1795497032; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TIi30UMnkbCM4UtGXQM9HLD1fy4eaWCJLQHah5nV8Gg=;
        b=FHgdsm7C1Q3nIPv2CoKGv/DiHbW41Pq/HbSLNn7G+/LQoEjNbl17EJScCn6Hc9oN8E
         HanFnbKUP5zCEyPg/1lrGWm2jJ53/COcx56MKeUAtB3XyeVuEwXGawgbohPvKa71l2Yn
         lvd3f0d1HjJRQG18Y4TQrUxDitSr/HQyts2m93qxf7mDsFVfW4TkUXvHkMPyoQhENuLQ
         lOjtynHv7LNdFes3xm543kzo1ePBYGpLvRCM4TPj8DQxQkRGzfJlq+Lvn3XZhP/ksDvT
         0kUX6jA/MNpSjlzc5t6AlulG4wottRXTRlYjbYqQkww3LWHj+9ll4854T80nMndPBxJH
         X7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892232; x=1795497032;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TIi30UMnkbCM4UtGXQM9HLD1fy4eaWCJLQHah5nV8Gg=;
        b=l2xdwuNbRiR1orUiWO6rp9NrRhiTsmMy7kNRNES23Ewzmml/DHPB8WQZ421+AsXZHt
         diADfLb2WydX4wvlhVsssdfxDQqoBNgGDIPXOgcZNHEx76U0ExaF+GDBtO8i5PYv6gya
         3uRwQ1EhqgWQkVuSxsZARhvX5qkE/LOh44IvADWCkXK8vdhNZSvzsKLQLYKdeAqZjutz
         emkdIVsQGjjRV/QIXs1sFICmrn6ODAiD+3CLUbXNjp7Y011+qRW7uZ2n7LIr9eYHs8gu
         abj4SeMjb/xdfZXMa/ty6g6tOTbO0aqyfmZRtpuXSx9p3LwWB2+eITVFuOjR0/0f+Fox
         7xGg==
X-Forwarded-Encrypted: i=1; AL+hErGx18YsyYhtF7XsCNLjBe+wfiE3WYwyhQdAZjgWNh+I6xtsKjQd0DbWU3hy5udbFWmIX6RZmrJ/FSUFucnJiQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ywbI+vMW8BMQrJrhZE7yLj0q7dY+K41nLASW1GsnvWZAWbilo
	VgNeh1osZ2okO80Ag//OchQE0wqaU9vEOH9qmTEs97JvE0PSS8DkEa4MmrCqPVgwFRA=
X-Gm-Gg: AYBFou2jCypn7IewK6fFOrrE/OyQN061LMGaqf13P1juM3bkmZkj+ylqZpDFwAipH7V
	QIwGBuvzWvz/WiWIKdvhq7n5/zbRacIozy7jc9DjGH2JcJqvY6ZsI0tWdFMGCJPqf/vaJq4RibS
	CKlgJMIGTHDfD9mkH2+dxWiwH4Xk4mtLoBcQ+Q4yuGJZ+CMwpG0gwcEeb+hlEYrEkpSYNVyOER0
	0UXRc+a9NBCXta7D1RSo/xaCXvlr7RnzpzEnnGaPahYDSJznHMWjmXoA/e9zRW5LkNtMVhcNUcv
	NYcw8weMDZO4HNEYJeEDkCZU5j0X8HeDCms2QmTi1RmoZ87lFwf/8h64DfPx6/A+SUgsuO/Fmex
	Bcf5oFUsJVutD34fmeZ6Kk23+SdBZiRk5hHARuHU9WpGhLKjJ6eKLi4wkA3o/nDA5b4iTaOqDby
	9BzZ5FDPtjaIfwwKshJtdnIJeZ3S7CKlm2OXJdkobX6JeG9wlXSI/P2oeAo26jFgmqyjRlAanGf
	ypCQIJVHwNpL8bJpsCr3EA3gRoW84Af/OFPdedY/w7piLa6yYVtr/dZ5yPOrPoyuwW5mapqRiTZ
	idA9USskP8ufEY01iStiV6b9fjZF1I4=
X-Received: by 2002:a05:701b:251b:b0:144:f089:b189 with SMTP id a92af1059eb24-1b50319ce4bmr12633287c88.36.1794892231696;
        Mon, 16 Nov 2026 21:10:31 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad6casm38745543eec.26.2026.11.16.21.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:10:30 -0800 (PST)
Date: Tue, 17 Nov 2026 10:40:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] gpio: virtio: compute the line names size in a size_t
Message-ID: <avvhxNXQ3fI73QgD@vireshk-B250M-D3H>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
 <20261104195632.1702765-2-lian@is.s.u-tokyo.ac.jp>
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
In-Reply-To: <20261104195632.1702765-2-lian@is.s.u-tokyo.ac.jp>

On 05-11-26, 04:56, Lianjie Wang wrote:
> virtio_gpio_get_names() computes the size of the GET_LINE_NAMES response
> as sizeof(*res) + gpio_names_size in an int, where gpio_names_size is a
> u32 from the config space. A gpio_names_size of 0xffffffff makes the
> size 0, devm_kzalloc() returns ZERO_SIZE_PTR, and reading the status
> byte of the response through it oopses:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:_virtio_gpio_req+0x2b8/0x550
>   Call Trace:
>    virtio_gpio_probe+0xc2a/0xfc0
>    virtio_dev_probe+0xa7a/0xc50
> 
> Compute the size with struct_size() into a size_t.
> 
> This patch is assisted by Claude Opus 5.5.
> 
> Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
> ---
>  drivers/gpio/gpio-virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 32326d91f33d6..fb7b40eff37dd 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -494,12 +494,13 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
>  	struct device *dev = &vgpio->vdev->dev;
>  	u8 *gpio_names, *str;
>  	const char **names;
> -	int i, ret, len;
> +	size_t len;
> +	int i, ret;
>  
>  	if (!gpio_names_size)
>  		return NULL;
>  
> -	len = sizeof(*res) + gpio_names_size;
> +	len = struct_size(res, value, gpio_names_size);
>  	res = devm_kzalloc(dev, len, GFP_KERNEL);
>  	if (!res)
>  		return NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
