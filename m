Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE0270EAC
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757374; cv=none; b=exCGQ4K5eAp7SzJgEQKlnU9FWv4wR4Wwp1y+FyRPuHZG4+NQgzc0hYFjFzI77UjRM0IHMBi4VqR3sdSmnlilRFZh48JQiIAIDkyO8FBBWplEyf9X70P5CaC976l9vbxRlvsSpHVcWRDa11NJUc2F0xvEpXPki8+d+AiHgVW9f2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757374; c=relaxed/simple;
	bh=4Y7jAPvp7RkAHwsvtdLYvU0N11A+iSh5DBiVZdL5nDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy4OoJ7oOXUwbAYMHZJmxfqosU2BKBOyvOrbvMEn6oDlAIp61MxM/3Istyh7trSwTPyQL7+iuumyiXEX3umO6xtqwHH5syZAuKswn0q1re4/WTVC4xapCMn4isajYj7+lCBUrlCSMyQ2CrNMv+egWNh3Mcs4LQyD72LIv0hY9/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOQbLx+B; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOQbLx+B"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b26c5fd40a9so5498692a12.1
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747757372; x=1748362172; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RJbvV7JdvyCORj2i+In/wTPSbv06vMfn69rfjvMw4mk=;
        b=BOQbLx+BoyF8y1qu+ARHCfGkSVZEmnFthBBDxbv4Ibe2gOvT9ZgGDf4c0WcmXIOu1J
         l2ocbYD8USjjqZgadmyajnm1nvvbt6shydfTbaUX0NuQx00MtOAcZC8EJY6uBNI+vMBl
         WVGSzqFQCbFhC8Bn9FytBSwBDMuljzUhmGLOmaKi5vqCqLyOG7Gx3K8zwfV0Og2jWNPZ
         gxaGclNXXfjeAFnEsJvjs671DWQLJUTU//U8RX5adc19V2pH9M3no60Eoq18DMKW7Kxw
         u1ymEEga2S2GcPueipdZ1W9pxXzYvdufzJyn4n6JPRe8OrbQQNTDo785XpBmUalOJZF5
         0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757372; x=1748362172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJbvV7JdvyCORj2i+In/wTPSbv06vMfn69rfjvMw4mk=;
        b=Vw2uyf7L5xaZs9h/rO+jec8Rqdtk0Nj5NXPS0lPrRC9tVIyB3su6rxuZz4HLIQ9suw
         heAiUTF0Z8zwchYUbtwFZvGFv87S4jKNT6AxTvGg5zQ799c8Amxm+oHbzpWXhnCUsIUY
         3qeK4b0aEKuZCDqT0AFHV/ZVIIUVR7wsTXyXUT9cHxtw0uC5GTHNSeL8qPysTvESPyHu
         mvjbRdCtscqVn7oSHS51otfr/nh5hDc1VbhIf/RgI23xeGfVTqWd8iyPXxrqp3DtmXow
         nN4xGY8efl7e4PnJmVdyFy/KLsVm1FVZfOSkjShYrYiuGl55UAjYIJd3eFFoRjss8uIe
         KAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWld2TO1RNq9H4gv7F2YtLnbMP0GFOddTP9YsWshXrhMtxvIWD1wndgkVsURy4xOv+Mywy24sYnf6wtZDcmOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYb3Ulk2Yhj2AZl426h2CqGDZSfM5ldQBYiSV2DxOQWaQiwkxm
	HWlYJSu4DVJJvSdvZuF1ggNKG0ILzTcUQvQeU82qo+aRB9XVjZsgC8T2
X-Gm-Gg: ASbGncv47nhs626Qxh5pustfDCaMRhmNxFbL3NgeOrh9VUkS9l3lyXPk2CplIWB1h0k
	8BXYzANKziWdZQZuJ7qamomPuka3u6R2zIVt0F5LHFiOmroGk2F0a9UUW3WLMpZMCse9KPhgYQS
	si/Hcgc197WFE26heYHlx3wj4E7VAaYSMK/jlrT2txGeU4IJOgi7Jh1GWYBpjTCec84Amk0GOWq
	AaXwA7W5Xp429RcafVdGZIk5X2EHAzgU/8upkSMCxIFH8Rwi1W44FZdjIPr69w/vAOQALD4w27A
	r5tFbHKXPfZu5CVutMcFhS6/SdKys7B9z6/whUTxl5bnXZ3BJdmtPitSxE8QqT14yI1M9jNH
X-Google-Smtp-Source: AGHT+IEz0kuJ8dqHy5xsovdOQCep+1sxQFLFFXzvnTwQtTvX+/bZldVprSyeTrsT6Ae+mpDb+9592g==
X-Received: by 2002:a17:903:187:b0:231:9817:6ec1 with SMTP id d9443c01a7336-231d4e55359mr236562605ad.17.1747757372052;
        Tue, 20 May 2025 09:09:32 -0700 (PDT)
Received: from devbig793.prn5.facebook.com ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba368sm78700895ad.200.2025.05.20.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:09:31 -0700 (PDT)
Date: Tue, 20 May 2025 09:09:28 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7] selftests/vsock: add initial vmtest.sh for
 vsock
Message-ID: <aCypOHoB4fxHW/Di@devbig793.prn5.facebook.com>
References: <20250515-vsock-vmtest-v7-1-ba6fa86d6c2c@gmail.com>
 <0d3a3a42-4141-4c4d-b25a-3c9181d5842e@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3a3a42-4141-4c4d-b25a-3c9181d5842e@redhat.com>

On Tue, May 20, 2025 at 01:24:43PM +0200, Paolo Abeni wrote:
> On 5/16/25 12:00 AM, Bobby Eshleman wrote:
> > +tap_prefix() {
> > +	sed -e "s/^/${TAP_PREFIX}/"
> > +}
> 
> I think there is no need to the tap prefix to the output you intend to
> 'comment out', the kselftest infra should already add the tap prefix
> mark to each line generated by the test,
> 
> > +
> > +tap_output() {
> > +	if [[ ! -z "$TAP_PREFIX" ]]; then
> 
> AFAICS TAP_PREFIX is a not empty string constant, so this function is
> always a no op. If so it should be dropped.
> 
> Otherwise LGTM, thanks,
> 
> Paolo
> 

That sounds good to me. I originally copied that over from
mm/run_vmtests.sh because their they do have an option for disabling TAP
output (if running as non-kselftest)... but I didn't add the knob to do
that here and am not sure when that might be used so might as well
remove it.

I'll go ahead and remove all of the tap style output.

Best,
Bobby
