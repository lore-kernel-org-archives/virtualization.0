Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4302147F9
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790517; cv=none; b=tasruPa6tgLKAL0e9d2L6yPKaTjlpi5xGB6izlRktL3HxOI1SMN3v9O8m96Wid2BYqshlKw8tL1jykGEpVOFMc57hXVCKwLU4IzickOhdsq24Na6Zrc7xUAyWvSkkhn3mJ0DymmXaRzdnwxCNqS9peL+yi716jJFhvOtcRIIOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790517; c=relaxed/simple;
	bh=nEesjhAuTJziUxYVq7v1gWdsPVAbJrLdrW6QwCP71vM=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=itI5+jCNtmn3KKNJcgND1q/3lFb/7QpoK0lrGIGaeHS+ZWOE3zjTrvAS8YCOYDkpCQ/ROexWx+bPYOkb9j64PXjH8d19QE/h41QxIWBiiz+gn4QUHiyCi3jlFYsi1nH934VsASZjBCAcFFP0YJ4LniI9PufYADgAsHMoTb8F85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQRd1I6P; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQRd1I6P"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1398E4163D
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:21:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D9co6Q2G0xhP for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 21:21:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e35; helo=mail-vs1-xe35.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2F17F41462
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F17F41462
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IQRd1I6P
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F17F41462
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:21:54 +0000 (UTC)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4b11a11a4f0so62746137.3
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Feb 2025 13:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790514; x=1739395314; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA59/b0HqiTbM3mdKAGWxKNjJnBpzxH7nv45X6IYWmY=;
        b=IQRd1I6PvlkDZTwN9pyxaHVeMNmBPiexJBj+5Ctp281TOeDi3M0Ls2Wi4onCH9wy4+
         R0KXnq69i8KrMq3VaWkTnCjobEQ2DWaRM3HX5/WpricpLhRtrMPUfi8t0rfmGQ7E4YHK
         xPu/LCDQb/4rTui5EwcAVw2+yu9qt8dxNROlxOS/ljPSrzICX2aGzbYaRsZ0puybh8gv
         ctGAZS1jUZGrWMWWA6VwJQb00b1iX8IOK4+cVyjdRceTWuRbtq3x1mWMY84mnYfIr9C0
         wWyeOazkst/Y9yb6DaqFlT53AF8MT/qWuKvIeTbmUcEiHEDnkXt8d9KBJhQl7RhybUZO
         oe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790514; x=1739395314;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oA59/b0HqiTbM3mdKAGWxKNjJnBpzxH7nv45X6IYWmY=;
        b=Pn3UFeRGJBeW7ZnQXfIRoeVZMJ1XWRJ4EyreldxNVa4PwFh6Oh4vwRiiUn4b1Zmag0
         1qbB9yTCEkiqVVojSTM/0NnkYsR72SybivzEC++4Z6WrvnOdnFRhJcLR6RdVVOtGJMmx
         WxNZbyze7xx7aFLPSZ9meA/xFMYjy0bGTXZte7TZXetX/FbHSCV0VwC7SvZznHL0rQt3
         O6lDtkPcLb1cteldq7ABbrcIe2ItuD8uVuyFLa2j1ArW1zXs+OrO1GrP3Y38ngAfJId5
         x8AtbPZp78J5X5xX0hh6h/YrZgzzKY/h8Gh0jmIUfzlqbVK81T94X83tz1aomzz73rGg
         xyDg==
X-Forwarded-Encrypted: i=1; AJvYcCVisiUqrNUEEcVBkihsAN6McsfwG/v/++C/VDuB4h+uwlW9Wdn+YbKMhjVyLHfKU9jbeWjEuHWiKZyI4qG4RA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwRS9MgFyjKJgkeTXX5YXEw8FUFWZOS+v0Ee1juyfvns1NOIaO0
	WVQRuQelhCHDiRoMsCjgVAPNLGvuJR2xR2aQeGCmMLbi3rZFAt7y
X-Gm-Gg: ASbGncsKfZcH2eB0TR3ewgbWozYCwEfh7G8ljpqwrWi3A4QMy/irL7uOjDEb+6hbdWR
	I4rf/JbeKjnVFxSNwfYxLGfa2VK6wGgW93GPOljgGfFGjN7uTnUVoxizOtBU0lI15UNItdbHn3g
	H9YG7tZ9hoDhoKzeXXOVL+k4BaLcGMFgBatB7y1O2wX4AlG80qSLgZkdLicSfSnRtnEn+iVm8Jq
	jbzRZKacI7FIhyLtgJKADhccHYUZWv1NbaBjJaWTt92ktdarZiPTDqZG2znLPtFsH7YqTxQxXV0
	yTbg9yWAUZKBQh4ahE0WJCD1aW+a123hq4tVEayuadKwdfNYGcznA4iHKeKU+9Y=
X-Google-Smtp-Source: AGHT+IGMnECoIZSQWPaeSS6dNPkAqETjHSQP+dcqfl8m4ZhiKsez3m+3zBDXaugCYi/i3Eptq/eBDQ==
X-Received: by 2002:a05:6102:3f4c:b0:4b0:ccec:c9de with SMTP id ada2fe7eead31-4ba47ae88c3mr3894330137.24.1738790513631;
        Wed, 05 Feb 2025 13:21:53 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baadae67sm2516649137.15.2025.02.05.13.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:21:52 -0800 (PST)
Date: Wed, 05 Feb 2025 16:21:52 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> hdr_len is repeatedly used so keep it in a local variable.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> @@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>  		struct iov_iter i;
>  
> -		copylen = vnet_hdr.hdr_len ?
> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
> -		if (copylen > good_linear)
> -			copylen = good_linear;
> -		else if (copylen < ETH_HLEN)
> +		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
> +		if (copylen < ETH_HLEN)
>  			copylen = ETH_HLEN;

I forgot earlier: this can also use single line statement

    copylen = max(copylen, ETH_HLEN);

And perhaps easiest to follow is

    copylen = hdr_len ?: GOODCOPY_LEN;
    copylen = min(copylen, good_linear);
    copylen = max(copylen, ETH_HLEN);

>  		linear = copylen;
>  		i = *from;
> @@ -697,11 +695,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  
>  	if (!zerocopy) {
>  		copylen = len;
> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
> -		if (linear > good_linear)
> -			linear = good_linear;
> -		else if (linear < ETH_HLEN)
> -			linear = ETH_HLEN;
> +		linear = min(hdr_len, good_linear);
> +		if (copylen < ETH_HLEN)
> +			copylen = ETH_HLEN;

Same
