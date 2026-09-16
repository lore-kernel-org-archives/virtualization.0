Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385654B0E32
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577640; cv=none; b=OjEtpwpTfkZu4wriredmqktNo8gwkf8zM8owRT7AQV8pG1TnzRsZAV/J14sFf1SALfXv4+Ri40TB8p1PqHE07W38MoENcKu99aVx8CKUnkezblGCLvVVbgPVPYA1V/AhGANWkRAzYXw5meR6uwGHWr8DBqa46dIJPOJiUTnTTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577640; c=relaxed/simple;
	bh=EM7CE+WdCTpAe7xOGaTErjOkfP5tYkgIqeyCvMsIy14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHTY2HbDSZ5lzqgviYYPLvRrbEtEO2ohSer3wUaXwV1woaOuQDzs+nS74n1YcA1o2lW5CRnfqUjzIGwlc9pEDKaql2E8hWx2kcmWZSIgXbuDODlVsGT5wZzzSKlogLdV9tlDpYBkEBzbY06qu80n+wxySc8lTMfcG4NeAjUhLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2h/HjOW; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2h/HjOW"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-80a71781323so651396a34.1
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577625; x=1790182425; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qiMEGCD9dITrWSfnCr0MqfmzsfjQT2aA9fOLt9oXWrQ=;
        b=C2h/HjOWUspJBs+Z9Z9O9OXslNT6SocjumX9pH1xFjG4Oz/ZGcFEeoveLd7gW/r3Nd
         cL+CljivODlxIUiBXIg9TjhaM7lm32xyVZj2rjzMTn7tB/tHpcHxCJQhmsgrn34oYTm2
         WNrvJSOpVYEhbYNur30i4Wwbk7I2CScg82tHOhGLkZ5OFBkShR7vNNx/2Gyq5frF24MJ
         WChVF0qajvVtAGsYuP+ednSO2qDNX4tY0Io1J0DVSs4QOosvH5uyF9JRgJlJuwRjOdeu
         o6CCLqTOQ4/q1tv8QbowhzExGcVDQ3RZmaOU2vMd7dQe5ELR4jeYEVY/2BddVAMn/B6q
         kDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577625; x=1790182425;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qiMEGCD9dITrWSfnCr0MqfmzsfjQT2aA9fOLt9oXWrQ=;
        b=oKQxqefCXh506Touvw700Ua6kR/fyGEmKMgHPmomBNX/TAWFPO6OWTDo6DE4wna6QF
         E55U8Ca7Mg9Hg70kO/9iVlOvhXo5BGtbvVpLFk2Nq9cI2Y6uXXZ8s3qivd0RpCFupehg
         BVauTlPW4yMajhVPAOYGNgdDz9V47tcrDnbEByDlRjbXNi320kZ+CRCo2lrX21CTSHkg
         Za/mm1doApviG1ixPhgHb4lqFiaj5PqYwzuiW4mI+V4F8slAMis+JC44WgBK7SQe+H7e
         tFJgTb+7HmYyALxP7Yefhio7KYKK/eJ8yLYlsGTBpW8gskqjOdTkhmOvjMOJ3opX7rI0
         PvyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxcLKrUtdgry4BMUDGpA7i/cMLFmxwbQcaOjAMAYU5jiDVIicokxZP8+14UkFsKchTuG8jDdFNQ+hvHZijlig==@lists.linux.dev
X-Gm-Message-State: AFuF++n0Hf2xGAQEbwhKQzZuTVoTfyImY7MpxyhUGbAxsDrQr0xLqeCe
	sRNiKX5l98Mvvur7ty/3nD7hdTOniU2j7lqTTVfFEeL4qTQ6y6nS7bKG
X-Gm-Gg: AYBFou3uyON39KCubsfcuPnTPM8QqFbxWh/CVJ3Kkp8uxX7AEIRTl1fkyHuycoDv3+v
	zfbsOXpxS658ybgnmyXI6PI2W59ERuvEbnamffPeQL4JQsY/tmE4r3cDVWpen4A9RppxFU5tIFV
	i3gMm2gx9qlNeg41Hb2i/wCLqpbqv++81Z8KiqMC6iL7vfey96vY06zlTtffwiSOlFbWXcUyEL3
	kNnKs/0KmCrFDalOJTVBmWiH2KghRagYPJmSGi9Bp+PjH6px+RlbkovFvv9nD+SkW/L4TPXaWPc
	D10E1dsAnnauW2h6Sr5PFHHZDtJXjfoU31PPQne6K+kxwX+t9fSdlY6XCbs0K2AgJpLbxP3r/fd
	6vhiwY7QXcLl+xlN96F0FPwzrEmdwuXx5OebTggfrN2qUfEMZM8+yrDYFK5ZRDV4VA4B6fHDDdl
	wOQ31vx+Z8ODDiaILv3zMBD3yIgV2Ewgi8oGpSryKgXmnkKWks8+GI9zvFAWQ9WiVF8xQSAjgnm
	5Trv0KRRZQw+52EVyU0
X-Received: by 2002:a05:6820:827:b0:6b7:46e9:96fe with SMTP id 006d021491bc7-6c7d3fe8d67mr3338481eaf.46.1789577625513;
        Wed, 16 Sep 2026 09:53:45 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5b::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4842a786574sm2835261fac.16.2026.09.16.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:53:45 -0700 (PDT)
Date: Wed, 16 Sep 2026 09:53:33 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Luigi Leonardi <leonardi@redhat.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] vsock: ignore empty child namespace mode writes
Message-ID: <aqrJjfJHWXJafehx@devvm29614.prn0.facebook.com>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <20260915173050.3176344-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915173050.3176344-1-qwe.aldo@gmail.com>

On Tue, Sep 15, 2026 at 02:30:50PM -0300, Aldo Ariel Panzardo wrote:
> __vsock_net_mode_string() returns success without updating new_mode when
> the transfer length is zero. Its caller then reads the uninitialized enum
> and may permanently store a stack-derived value in the write-once child
> mode.
> 
> Return before calling __vsock_net_mode_string() when *lenp is zero so
> that the helper is never invoked with nothing to parse and new_mode is
> never read uninitialized. This also prevents an empty write from
> locking the current mode.
> 
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
> 
> Changes in v3:
>   - Move the !*lenp early return before __vsock_net_mode_string()
>     instead of after it, as suggested by Stefano Garzarella.
>   - Add missing maintainer CCs per get_maintainer.pl.
>   - Add Luigi's Reviewed-by.
> 
> Changes in v2:
>   - Return early instead of initializing new_mode to the current
>     value, which would silently consume the write-once transition.
> 
>  net/vmw_vsock/af_vsock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 622dbd0467..XXXXXXX 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 
>  	net = container_of(table->data, struct net, vsock.child_ns_mode);
> 
> +	if (!*lenp)
> +		return 0;
> +
>  	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
>  				      vsock_net_child_mode(net), &new_mode);
>  	if (ret)
> 
> --
> 2.43.0

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
