Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796A41DEFFE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372290; cv=none; b=IVf/XaTK1rmrRzGPxTm7yPY4QU9JtDsF8xHYAS4dlYOK07kZGhd7iygkKGsNHR6dD2eDyx8Rp+yXtRRT/X7dQlX1/2AwxoeiiGt82GaIZeEnt0vC30u3sH0I8sZ6NRORlU4WaLdtEQWhf6FjBxXj+AknjRyVTGiBR8FmUtz4vYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372290; c=relaxed/simple;
	bh=F8c8n8lUERUPHL+mdTKkzpkhrHzyZz5klNWhEUx/HOs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RqXlt1Q+Lgc+Ag8Kv9B8ePY7f7O3c8Va4Ymc13RF05skl2OlojksXO99qoszwknRtZU2Gtrpia9TQjzuuNyjGO0k4euK6c0snqdh1soIe5ibZHSjfWAKbqsnQ2zvDjD/X9KlR/wMSozGUnyXLnJGw0kX91PN+oNrg05R14QTXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghte5rtc; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghte5rtc"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15973812B9
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZkD4cz6XiK2N for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 11:24:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::82f; helo=mail-qt1-x82f.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4D634812B7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D634812B7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ghte5rtc
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4D634812B7
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:24:48 +0000 (UTC)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-468f6b3a439so44307791cf.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 03:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737372287; x=1737977087; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2b6PEWocf214nlQxHdjOFbir3dB1Ek3Kvgqh1AcVpc=;
        b=ghte5rtc5hU8NqDCojIaoRc2WvwTSHYoUH/5muiGIYt1Kn8igTUL49Mmw/gZSaKINf
         fc3G7J3luGyi+VM5aOBl+nf7tfVfJjPlWiEsknzDiV8fdpNerg+LlWA/9+isNJGmf07f
         xJomKIBUx/QTUV1YOlwZDiSW/UD4H3XW9EsiFeKM3TBzC+BAzougr3p0mvqs9qMmLwSF
         UDoLpuaJdQg+d4C9V8FP54YhesCgYm9fD9JN808kO1aD/o+ZNPeBvDpsCzkywI31/fY9
         dmpS4UbStYX46oUS16y5A2WFH0Bc1AH7zbM766cXDSgTeIKjcsuVaGEVpUo5OwjavCUU
         Xmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372287; x=1737977087;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2b6PEWocf214nlQxHdjOFbir3dB1Ek3Kvgqh1AcVpc=;
        b=nWACyaEyPl6PnBX5eNSqbAf2OFEtn9pOA1U94OHsVipSzyXuSJ+TIbR9H/cftJBLhB
         mU90lHePW2zLZUQnOegszZJlN8bxi+432YvgIxaay3fsk6nATfevK66fUZ2vWCizvENQ
         FItVgruLDsnFXNKKHzNAmQ3XyOL0a7iK7IfOeXDIMdMVFM41ZF7IIh+iUb61cQVeOpNG
         fD5h5WtsE7wBCBsJnNb0thrQLTaWToKHJPuNKnRreXDN1328YGNqhOzFizvLfXa1gDpT
         VqW6LvUypgYsIZESbHPKz/vWeQkvcxMuWHhqfWo4QcR5nFhKL48B9TPaEzQJ175WbgMu
         L2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCU00DXwWed21NtI9QoRmdBOaav0xfpr/qXkQTM/G1hSZpgWho84Q7255Ona3OrKO0AjUAmU+16JUDxdE2x5fA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwepNS8d3YFmVbdGI2LLZ4JCxmmIaWH9CrTHakoGBhXv1KEgRlj
	Cp03Iwij1X3i1TaZljxWHcek1rqpP/0wLphfBrcy3PmkU/DsiEbX
X-Gm-Gg: ASbGncuRpZGxy/tN+uneu0v+GamdyFTNXyxuOYp6bvPpWckFCnjnlFclSLqn26HyxpT
	9tqmRgp/uvfiIJGomZ31GlO/91GCVfx7M29CX5lxjcGfge4yjp9N+QHErw3iyAMY6t/xttDQmBC
	KjG5jCC5KCAPU3jX/dU+adBb215tKCAz982pZMnhNuBIC7qVK7dkHdn8ezTfcmYsxUrypZUNAy4
	+6W4ouXo9djGlWMVkLAx2rBSb3+iJars+urXBXJVuGsRJrl+6iCkvBhLujdWwEpy/9D5HwtGmNz
	o72873DlLZvntm6JBHZEqu1Js/0ssV5VakkLiHSdJA==
X-Google-Smtp-Source: AGHT+IEbMrWKUTs5M/W8DCHFtlIrBWKmvjQeT8P8UnoJEJpMua5cPVTSwsGq0gh/5/6so3JDrbLKwQ==
X-Received: by 2002:ac8:7f4b:0:b0:466:b394:92bc with SMTP id d75a77b69052e-46e12a0c2aamr181155671cf.6.1737372286947;
        Mon, 20 Jan 2025 03:24:46 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e2f67ea89sm15197411cf.10.2025.01.20.03.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:24:46 -0800 (PST)
Date: Mon, 20 Jan 2025 06:24:46 -0500
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
Message-ID: <678e327e34602_19c737294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 8/9] tap: Keep hdr_len in tap_get_user()
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
> ---
>  drivers/net/tap.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8..7ee2e9ee2a89fd539b087496b92d2f6198266f44 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	int err;
>  	struct virtio_net_hdr vnet_hdr = { 0 };
>  	int vnet_hdr_len = 0;
> +	int hdr_len = 0;
>  	int copylen = 0;
>  	int depth;
>  	bool zerocopy = false;
> @@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  		err = -EINVAL;
>  		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
>  			goto err;
> +		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
>  	}
>  
>  	len = iov_iter_count(from);
> @@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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
>  		linear = copylen;
>  		i = *from;
> @@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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

Similar to previous patch, I don't think this patch is significant
enough to warrant the code churn.
