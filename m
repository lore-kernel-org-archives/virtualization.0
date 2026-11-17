Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794892221;
	b=zOeWdPvT79mgNuALXv2jlHTwE+uQoWBMfLVutPn2H4Mv1W/B5OAgmkCgPNqOM9toGO1I
	 w3zfrkN+52mPmEcWu7pRoD1Vjwk0yI+E1mcQNHNMUwppWbQFoGLcNlu7VvA2fhPcd13LG
	 x5cdK1pN/qtCF63aRyhg73WSZl962TOCgnihkY6+XlfyXRWf7yJWU4IegTnGb1QdgGqxe
	 Qd2aah9GBiGzoMVZ6zSGMuNjrBQXUWFUn82yrPxkiLeFc3x3+2ZNwT3dAUBrwadMgW2g9
	 lu+SRqod2O4EU4+A+jam78ayH+p2ZkcVQlUvJJmFXhm6+YlJYOWGmHAUXnY06SGuWFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794892221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2HROhYrsHDpN8EZWrWCuWsnDk1gTxZfjwa9MvLNeoEE=;
	b=FCMtv8O4pIUd/eRskdCmVbrX8KhyGSC4MPLIVb9u49c7JSXg0diYc8Bp2rNejhfv8zYe
	 9ia5eOnIG8nj30GOA36HkiNml3W+B5/pYece5wSTzwkr7JJ8vL3M/cvIJrNWMOqfQgFOi
	 qB5yP5RRY3xm+Lwj1hcJN8jYxxxTDvNDnQh1p/2IG9LwvhZOpy6FWgHJny2wP+kq+4Csz
	 5kiO4uvQQ4b6yUmXRI4AgdiyT3gyP2e2aN+qtQCy+qX5JP7brg4sh+1K1OkSbOT3sMsZT
	 +uthghYsJck/EB6vOEtSl+tBOM3q7DUKKj7uGp623Ukqn5Eh6iNpjd9LW2ZwRfcastA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GywBbgQW;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B008606A31C
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 05:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B008606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GywBbgQW
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so5034770c88.1
        for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 21:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794892219; x=1795497019; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2HROhYrsHDpN8EZWrWCuWsnDk1gTxZfjwa9MvLNeoEE=;
        b=GywBbgQWf3QEy82S0kj6TLRR+uZpppTQmcgyE9UotDpL2ujjnLZxP/yg9YIwndsTVy
         lHs+bwLHwQ63HD4erJoALHGIWrNnWUBLGM5GmIjxoq5obZyufN7IzVao3RbJ9sHp3SW6
         uTK7KXMiPvoxHl9JOfASrBhDiBTlI6aqxlNUIVQws2Cpa79CNPQjACBgjDteYosnaTS7
         39GpLMLsTNtYBKPG3Ce/ZteJZe1DUrA1l6BwIsyUzZM88Acn3yR3m5fwr+F5hSe9EQWS
         EQxwK6ZENubeyR/YUl1n8MuIZk4SMowLpccEsasPXtHXr/U8YGosup0+8xBe6wwMogo/
         wq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794892219; x=1795497019;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2HROhYrsHDpN8EZWrWCuWsnDk1gTxZfjwa9MvLNeoEE=;
        b=ME8R7Qv2yU1gqP/BMS1UrEOwD4GmoUVKO5MCLIbtFpQ3wy78EsBN3d64CixvgoT1ML
         bteGYR/iyWOsoxLLZ5XaK9GHz0YNfVV24imRtgfy+TqaGtCIoUIcuT7WtZakarXa5Zxi
         x9qZbYQQjReGZZJiDDdkMXUNJRXN+Xae24mj+zR/tLeGQ4QjYI/75M12ht6XYsj8C8Ph
         pP/rwZDNBB3H6nVXLFGaukOfiSW7o49e3+bNijEDFVY7yJu/KIyVmEBUt4tcs65J5Z21
         rD+zqkCzCi/TYn0uy13WYW+ybyBANFLG9O52C4x8iLCULtOw9HEWZ/JIKVLCS1LkFRmz
         AEow==
X-Forwarded-Encrypted: i=1; AL+hErFKThKWWd+xt9j98QUsRyYpSSocwPBN/Ue3I8w7GGR4ZfchPol7cdEsYLE9EA0LkijDQzKF/4IUgGY884fXBg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8tM/stD75hNVMBOHd6oTfR/P8LWMlT4MnuEHj0tyPJxL40K9ly
	7NbIsKo1LPas8vcgPxlobTS0cocjgVQlq7oTNVO6cGbrONoJV0bxNLYZ6pEd6kM99kA=
X-Gm-Gg: AYBFou1FyB/tvK7NBMoalHjIchLcwNycliVL99HlYevT0H9VynRqKepy0ZjCnkizvzL
	f1M9T9l4mqPmUYpPuEeAdnVtRUIBI7sgGY6B3HdYBfFHbaI6MCRDD/hexBG9WVDpDDiCC90gm+y
	GM+k85f6lY4dHRUW4peVKBYFaBNtSYmvuyyGK2lQMk4mj3ji4y7ZmGkCUG2rUBkZKpMstqyOhOa
	83IfuqgBav4YsEmsyrY1DPbLXpluyGTYQH59N5AlziZBUv0hrKMDvtlYlK6eHIpkrOS6iylR+vM
	Y0bDw6zdIqN5G1/8yvJ+e9mI1cqQs4RCh1MpcQmmmWIUKN8zjCS8IOPKdrOCrF3BtNv3SOCtFnA
	xsEgSa0xnsutOoMpmpp55AO2RbwAa9glFOuIRn8+JK+IDKNh9n9R/3xxUzU93WnggafnNPfqgQM
	68lc4R3Mo4KEsHadpSd0p1e+zp7XyDENIEJ1QML+GlqU4LdHTx9M+bkLLse4Iw/yG0dwuuTPdbX
	oXRx8ms7XrFYmeB/7nZyObNzVJDe/3ezxeu3gWQ/O7PeSPO3to/LlrL2sRKnGFU/ipKLgdZP+U1
	g3MFT9sS5VKMzKBpSB36I1YsExJYzQ==
X-Received: by 2002:a05:7022:1081:b0:154:e9d2:d741 with SMTP id a92af1059eb24-1b503112e3amr10151143c88.8.1794892218987;
        Mon, 16 Nov 2026 21:10:18 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38116afd7f7sm3856351eec.17.2026.11.16.21.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:10:18 -0800 (PST)
Date: Tue, 17 Nov 2026 10:40:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: virtio: bound the line names block by its
 configured size
Message-ID: <avvht67hxDh7a9oV@vireshk-B250M-D3H>
References: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>
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
In-Reply-To: <20261104195632.1702765-1-lian@is.s.u-tokyo.ac.jp>

On 05-11-26, 04:56, Lianjie Wang wrote:
> virtio_gpio_get_names() walks the line names that the device returns in
> a block of gpio_names_size bytes, which the driver ends with a NUL, and
> checks each name only after stepping past it. If the block holds fewer
> than ngpio names, the walk reaches the end of the block after the last
> name, and the next iteration starts strlen() at the byte after the
> allocation. With a block that holds one name for four lines, KASAN
> reports:
> 
>   BUG: KASAN: slab-out-of-bounds in strlen+0x57/0x70
>   Read of size 1 at addr ffff8880026687c0 by task swapper/0/1
>   Call Trace:
>    strlen+0x57/0x70
>    virtio_gpio_probe+0xcb4/0xfc0
>    virtio_dev_probe+0xa7a/0xc50
>   Allocated by task 1:
>    devm_kmalloc+0x6e/0x280
>    virtio_gpio_probe+0xc06/0xfc0
>   The buggy address is located 0 bytes to the right of
>    allocated 64-byte region [ffff888002668780, ffff8880026687c0)
> 
> Check that a name starts inside the block before reading it.
> 
> This patch is assisted by Claude Opus 5.5.
> 
> Fixes: 3a29355a22c0 ("gpio: Add virtio-gpio driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
> ---
>  drivers/gpio/gpio-virtio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index ed6e0e90fa8aa..32326d91f33d6 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -520,13 +520,13 @@ static const char **virtio_gpio_get_names(struct virtio_gpio *vgpio,
>  	gpio_names[gpio_names_size - 1] = '\0';
>  
>  	for (i = 0, str = gpio_names; i < ngpio; i++) {
> -		names[i] = str;
> -		str += strlen(str) + 1; /* zero-length strings are allowed */
> -
> -		if (str > gpio_names + gpio_names_size) {
> +		if (str >= gpio_names + gpio_names_size) {
>  			dev_err(dev, "gpio_names block is too short (%d)\n", i);
>  			return NULL;
>  		}
> +
> +		names[i] = str;
> +		str += strlen(str) + 1; /* zero-length strings are allowed */
>  	}
>  
>  	return names;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
