Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FCD3F788D
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016632; cv=none; b=Ad6Uczx1775WDzUNZuOvyMDZRbtZvyLt4sB/SLqOulpyrxfKBDTL5OZl9+I63iVoaxa+sFgbftQ5TpwnqBPjJof17teUVHf/fXCmHjTz1Bc9f20y0Pn+fhLfBKLcsrDXjtK+JTSscZ8wbv7+bh6AX8lU36fvHfTy6XaZMshWCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016632; c=relaxed/simple;
	bh=lKe7dB2Ux6isdSw93DPoCdIedZBS0rBiJXIpQS74mWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdgE/70dkqLi3BRolc0rKCo07XUYmOnB6b8pThGuGawrcJKEUS/LVQ+er0vg+gj77oHXXfkAmugHFhHCuJCz+6F9NOGrdgWy5Pp3RFUakJyGdxlCG9VRD46hk5Xh6/v0EFXlrYESIdkytHn9QXwWf5dxnzbhazX598gaNtYCP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kOymPj/U; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOymPj/U"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8453427d3f4so3466135b3a.3
        for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784016627; x=1784621427; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qMw7BjXvglPvLnw5aA95K1W+uWIFJhm43vKAHapzhcI=;
        b=kOymPj/UtUrb+hM9Ioe0UM22TWnmLmfT+GJXKMuC8qojNY1t7OXe4lkmwMGo8TdjL+
         XUE48EpkFwWMJKKyrcR53W5N+ALkqwU9z2CgFJ6/mGgFxBcgINrKRdUE/wRUxD/jwvLF
         wfIgMp+/FGMcGnGXWQYh/4oPO40bHVdVCB66q+XbIzRLcw6Qe9+2l3mBeJdSHNr9vFW0
         8cKRlc89gjcyEPFsrZa/uWKQ5NsHMnA06stzrgjCJLVP4qDnF0JCBCcmJKFw68nqk344
         EQoYOxnG88m6K12taVxl39Nds9N3MbF51FhenxbEKDMWf+Z1TX8f+v4xLvJfnHKFbNsN
         +bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016627; x=1784621427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qMw7BjXvglPvLnw5aA95K1W+uWIFJhm43vKAHapzhcI=;
        b=a+OFiXQ1cWE84eIDcv5DqevOb2wmoan3dTAgmV1JymgGFUKCqWn7JdmhprHjmInenX
         ngIsHOaB1vzai/rBOZRkeyHQBzj2SwMu2LJP0Z0iFDEHeIJWiBxG4DhOFgxYzY5TpKHz
         eeQ3ZJnCemIPb6QPGhbZwzjUM0xHOL+GHzr6zm2OTFGnnywrB+eI7v0OwdrDSaTm+8DC
         tempK1jBmaOXbwnye1gsfnCjRyyIla8pNHA9XcgyGzPfuB2sxGDS9SV4eetMspmmDXcm
         mk0ovoXneXJ61zEk+3pPqyGTtLKoawyxSTLFCpH2Dfy/py3OzU4IK+EMWskQGRdIl7SW
         ks3A==
X-Forwarded-Encrypted: i=1; AHgh+RqIp5wXBNbdPRxC74iQ3ZC+kBbWNUWNYIqstfv4w5KvTV0m7XeBmmwWHHgpox9mDdPCIO1ACC90NgnXnRm+sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKI7TG37c06CvSPl2Wr8jqV5RoBWAoJL8ly3l6CpUVD8Fk0vsk
	xwD52NVNoRPh0S+ysyKFCIFxlLk+FKeD+nlM2l1PWF2MwXztDR/HaWhJ5acrrP1/HZ7l/yAU0Xp
	UxMWo
X-Gm-Gg: AfdE7cmw0dnNiTNC3Ew93AnIfrIVq+XM9+9OJlplOnOtXwjD6BCxrmUtt+ttp0LRntd
	qpOO1SMmJVn2EvDpHw8toXSnenAozH+rloR/5iuz82sPkqAepG1PVD1BVmAkrW3VVhUlyiwkniG
	rWGn0/DY3ZmzST9QgmR08GjGmYTdA0//8mdBcosEeoLB4N0h+oTqhlXFbKoyXBMzvZqQ6UIjqSw
	WwNYBm5do8J92M0r6VGgIII6m7VJ84SbEst5drK0Y6DzQqQlXtxt2XpLcwmu19ewa7v9HoRNb2L
	srWH2CUvnpo0wl+CP8Q+BHIc7IY52okWfeAAZSgX4Mn6sZW/rrtd1fUh1iIkbZ3+XX0JzT+B4/L
	uycSYoLeW4kBkRJ1DGzg51Uah5UEL3Ya9z+usMF7Wh0F+oILYqZrpq/IeXgtYuSs93VBojdOOMh
	I7EWNHH0y3A+lO
X-Received: by 2002:a05:6a21:62ca:b0:3bf:6c08:fb87 with SMTP id adf61e73a8af0-3c1109f0a15mr14553127637.55.1784016627284;
        Tue, 14 Jul 2026 01:10:27 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9bb8682bsm18011561c88.10.2026.07.14.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:10:26 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, linux-gpio@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/20] gpio: virtio: Use a named initializer for
 virtio_device_id array
Message-ID: <je7u5l3i3tk6cu6ikahe7plgr72swe7f22m2eopjw3am6vof5n@32u7fsmvyipz>
References: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
 <1f764e00e8cbe7624f4c9f3d8e5c368fd9a13e08.1784013063.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f764e00e8cbe7624f4c9f3d8e5c368fd9a13e08.1784013063.git.u.kleine-koenig@baylibre.com>

On 14-07-26, 09:24, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> This patch doesn't modify the compiled array, only its representation in
> source form benefits.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
>  drivers/gpio/gpio-virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index ed6e0e90fa8a..42871db05ec1 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -646,7 +646,7 @@ static void virtio_gpio_remove(struct virtio_device *vdev)
>  }
>  
>  static const struct virtio_device_id id_table[] = {
> -	{ VIRTIO_ID_GPIO, VIRTIO_DEV_ANY_ID },
> +	{ .device = VIRTIO_ID_GPIO, .vendor = VIRTIO_DEV_ANY_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(virtio, id_table);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
