Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3001DF248
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372184; cv=none; b=odyUbipjuzRpoZFmzXBhho7FvhVLuA40+38lXShxOzWfRt2rOUvI3U/B4nw9y5xwtme55AE3dMwlDzL1ZIvSjR4rUDaXBk5TW5CFJWQ+XVWAjH7wEXLMfaEaOsKllSd4VnvZIh/9WmhHsEq+q5uuT+QzVNGul9/3Ip64JlC3at0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372184; c=relaxed/simple;
	bh=HL4NOIBIqDr6Darnum6YQxEjBaAyuTmyhd02SeFQ4Xs=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YEoYlSJcqlrnhSpmKhQx3+YNqMAllWp4kSsXOPYvL/LQ3uQ20Ixc0y43fEPH2cNYPI6PoFfc690Yc5mNMPSD+nASrYZnX8kD2C9ArnsOOU0UETpRqe8vHclqv8aw1ZHe4p3hwCHhmblW2yq5PqLK8eSjsHXcRLgkl5si2L1pNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuobfN+U; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuobfN+U"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2101D40F2A
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ybNJTOS8F3U2 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 11:23:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::731; helo=mail-qk1-x731.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2728440D80
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2728440D80
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RuobfN+U
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2728440D80
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 11:23:01 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7b9bc648736so429478885a.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 03:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737372181; x=1737976981; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LmLNrJ6dN/z3G0kjzC1LxBo8C1cL6y8Q3pCQOJZRpo=;
        b=RuobfN+UgiuO+UurcmIcc0HTShDhQwVXr4BTG7Q2MXxhxjlFpdvvKgOvUqlzcuVLwW
         hMtdomLVbq8iGzf+GUU7DClDBYgNpuVGRvrYeccyqBruPwdQCgkwxNkTJW+0VGA0uVwD
         PXcNpSKUni3CsnVLdHzM2xZu3OWdcV3n98EQa+R3SbjsQstw5d8UIB6TeIVThfEPcjJR
         2porOFESuKPNUxV4vNOzcIFbKy3EqTgtq82rZoAp/XY7PUR1mvKSKytQKddH+MyqlKI4
         MXrlzi86Q1jxsocQwT5UmX3ULFLbS+5+hsyLnCy2yAvfRlEBFNO3XBrp2EJNV+6qD6c+
         iZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372181; x=1737976981;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LmLNrJ6dN/z3G0kjzC1LxBo8C1cL6y8Q3pCQOJZRpo=;
        b=KGC3wqxChpGU1A2xi0MBgAEbgkAUHhm8BcMUyFbsDT7FPIe/MZISNYjmkJIWVcbcJi
         5c8rChu+pe1KCOEoodkp1Wt7izgaHYkZuN9BlIXC+MuSjuEYiHAqqQcVefpaCdLjLfVC
         PiCUtz6LEyXfHNYx52dt83cCBx7kxqhyYKcT1ScnOPQaIg5FLEEgX9znh3f7H31YC9XB
         5zvn16l21JD0fcPFAMF28vK3BMUvJeesFc4h3JiQOYqHjgZFd4Pt/r1SsjO5jtwSA/XQ
         Xm63hL6Jj9VhA5pTKnwX5KXEkMIvMOt/3bk/e8iWNCVOQbnAjgCL9Sn8U22KdpVtR+8f
         1lrw==
X-Forwarded-Encrypted: i=1; AJvYcCVlWKk4gxMQW/MDjkCG04WgQT7O45V1nULTudmqtNxpigLNxpG0xaviRDeOJX7J5cHtbYQB+84vJhfbK6uWmw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzl6WnxGrSvoi8MKYUm0iJhpxXLFMBJfFtBbqWf51T6nySNKAxK
	GmrjUZWvOWU1SfrvoduvLwnTSJenuf1/tXdVHLK3RLKBHcSMq0ks
X-Gm-Gg: ASbGncuOh3Ze4W46Q1IFYQ0l73v9iLSsJUcVPN/qzE494bShBDNoOXGfpnfpLmbd45y
	ptxDarJIIDBBMSd80ALQWfIwUuPSybhl4p50/jJEB2XQfHP9AQaHtVv0EWzDpEBy4VWV8WGL4ZS
	Ogl7StU7GbM2lNXszodgc9xdg+KKXEpw6l+Dfx4lgXdQQtw99xrMdGYgZqH2gJejrrYyx5vAqKB
	1ofRzva+mJHWnYb+z9wZfnq2GpCNoctk99URmYfQgtey/1gpgHRt437CyfAZhne2ruHkFHSzEeL
	6ZgVSpURpeuFXeKX1Z8HgiqBN5wsAXCLjubkxIoALQ==
X-Google-Smtp-Source: AGHT+IE9/KsqlakxdkIjJQLNUAmeevdFGSUQQ85Q/xSP4kAbWM2K4qAj7YFEOy9G3QE7BawLS+XjRA==
X-Received: by 2002:a05:620a:2848:b0:7b6:dedf:b6c2 with SMTP id af79cd13be357-7be631e51e0mr2045349785a.5.1737372180817;
        Mon, 20 Jan 2025 03:23:00 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147591bsm434654785a.4.2025.01.20.03.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 03:23:00 -0800 (PST)
Date: Mon, 20 Jan 2025 06:23:00 -0500
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
Message-ID: <678e321430c77_19c737294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250120-tun-v4-7-ee81dda03d7f@daynix.com>
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-7-ee81dda03d7f@daynix.com>
Subject: Re: [PATCH net-next v4 7/9] tap: Avoid double-tracking iov_iter
 length changes
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
> tap_get_user() used to track the length of iov_iter with another
> variable. We can use iov_iter_count() to determine the current length
> to avoid such chores.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tap.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 5aa41d5f7765a6dcf185bccd3cba2299bad89398..061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -641,7 +641,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	struct sk_buff *skb;
>  	struct tap_dev *tap;
>  	unsigned long total_len = iov_iter_count(from);
> -	unsigned long len = total_len;
> +	unsigned long len;
>  	int err;
>  	struct virtio_net_hdr vnet_hdr = { 0 };
>  	int vnet_hdr_len = 0;
> @@ -655,9 +655,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>  
>  		err = -EINVAL;
> -		if (len < vnet_hdr_len)
> +		if (iov_iter_count(from) < vnet_hdr_len)
>  			goto err;
> -		len -= vnet_hdr_len;
>  
>  		err = -EFAULT;
>  		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
> @@ -671,10 +670,12 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  				 tap16_to_cpu(q, vnet_hdr.csum_start) +
>  				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
>  		err = -EINVAL;
> -		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
> +		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
>  			goto err;
>  	}
>  
> +	len = iov_iter_count(from);
> +

Since len is still used in the rest of the function, might as well use
it from the start. I'd drop this patch.
