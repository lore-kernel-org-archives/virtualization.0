Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1C21CC7D
	for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199830; cv=none; b=sRjCtWTwdlrLg33rpV8W7oF9rOP1NHPw7adTWDOOGM+2TR+dv7cJdZcdxu0nZlhwR35F76m2TzBW/jMWG4mPo0v54JW2Wk8Q8w50Vhn+p4ctuEtmeOGyMdWGHMZcWCyvbJhXcMRW7TwYT4q6LONpNx6gMA6LXTY0wxK/WctDP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199830; c=relaxed/simple;
	bh=6F6vk/bCuTRFj9sHasYFtzBPnP8c9sLQfBUMl+1ThkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tArJA8Nw5smm1+B6X/NHbbaZ7IR/xGk3+bjTolEt1fQ0eSQjy9wKyloG8AVQV1+Et7mCU2CI9NUzR3aIt8H60hXKGraN2sGHAKyG1AA2k+tmWbWsX517VHfifZ/S3Cm5jFEqG3mAMAfO/82+ukz1ErWHmx9gCBSITVjCdy003UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3H1ktej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3H1ktej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742199828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
	b=T3H1ktejRD0Vh4sK7aDZUzpjaMS6nV/QZlHsgMGOhKwzEOcZyEmPPXxLsqEWE0kvvJNao1
	GQjq2qyskoAOvH0vUjUQdkF6YA/l7stQRNnnNv9H1Ucs+EBRVN4tNaYlBz5nZELtZiDJ61
	VGj5psdB1Ws2uXfqA6vvTstPhiMrijU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-IgmkfAkvMIKVFxUeMzRJeQ-1; Mon, 17 Mar 2025 04:23:46 -0400
X-MC-Unique: IgmkfAkvMIKVFxUeMzRJeQ-1
X-Mimecast-MFC-AGG-ID: IgmkfAkvMIKVFxUeMzRJeQ_1742199825
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so9124075e9.2
        for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 01:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199825; x=1742804625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rC5lK1FxM1eWQXOh9AroE9tnp2td4VImfPnxc4mu+rg=;
        b=SOsrqqKiofBqUH/pBYxa/Fj04ZxwdyDZUppnCPl3vA8Ge0CnKKlii/+KxAKdfaLuYH
         Wh9fy+B7GBbV5maztvM8/VPkNDcZKbtSQRTyiFC77mJ09O6er0DXCEUTObinhXM45SEn
         0SSjO8beP+v6mTVVUC83T47vAIB8z2kzWP7XD+gGNsTB35nNRPmm7DqxcgwNbMblrwG7
         LANpy8jikN2Ul3Dp+YaGxIWy3OkFc2CkVKr2OyKY2mkOWLtXhtZwh2huBBcdeNMLexRK
         u4iz+6GIRyq5Unnb5FifgbhN5feyoIgDPUexuzDlmwcvcbWtmpqayD1RriEi2Hw/jtS0
         PstA==
X-Forwarded-Encrypted: i=1; AJvYcCV4f13Enj097DwGsj6o0IuHB5v4Ktg1D9SzRFeUccT7UPc9LiywBe53tGAfdJ3gOk7Vxv31d4cKpzKOzTXUIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlfPiXYqBYmjIrx693462kAreUr/xzJWZhiGSaI8AQsYP3Ky5S
	24W9NDwgbcmoCmnSWi/nugT13LE22GfQWPfhKl0B9DtmGNV2q/gqR5KNNZMxVL5b9fAirIRUT9G
	LXPRJCvD2YkviaHVD0iE8Zb0OG0vPmTo9pbrh7hWdG3ojqVwLkZB3uR/ssWB29dfP
X-Gm-Gg: ASbGncsMna4OO3dXXCKdlWvGPCAb48yu/BIoPut+rlprgUpRjwrPqXTQtc0o1AzcsNg
	kIGUU1lGdohi4g76/Xj9B/HLg63iOoVj+rWEFDB1VK9exYFB8LSeMvQ532b02yORPmBnX60NfVu
	+MMZlaHQ3o7qESU5SuFaVtgdsh0lduNufpcUVS4B1MV4soLZDxpf6GaORxVsRGBjbUtGBu/jK3C
	8wjWfm6O0Le8ocJTqus7xKVAvXjQnLVD4efYmBMhDQOyWC7ZrSSLnL4+wjp4mKtgpzkTtfSxUCL
	F87YjZf8YL7JUiYHPp6AD9+VYolUfi5bOEjoTrbSyv3b3Q==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892995e9.28.1742199825101;
        Mon, 17 Mar 2025 01:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXGGv6tXY3ajGLLrOXr011xmJAYRLTHi8JZasNx5okT9lH6f9KisDDn8lGridr/hz5ZTMqg==
X-Received: by 2002:a05:600c:511c:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-43d1ecd60c1mr109892625e9.28.1742199824734;
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010de59sm96734785e9.33.2025.03.17.01.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:23:44 -0700 (PDT)
Message-ID: <981a871f-e0c0-4741-8e7e-4a4e5d93541d@redhat.com>
Date: Mon, 17 Mar 2025 09:23:42 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
To: Michal Luczaj <mhal@rbox.co>, Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
 <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250316-vsock-trans-signal-race-v3-2-17a6862277c9@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RK-p6jzFZR-5XddEtyQGqxZpg9k9BihDNAfznsjknLg_1742199825
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/25 11:45 PM, Michal Luczaj wrote:
> Racing signal-interrupted connect() and sockmap update may result in an
> unconnected (and missing vsock transport) socket in a sockmap.
> 
> Test spends 2 seconds attempting to reach WARN_ON_ONCE().
> 
> connect
>   / state = SS_CONNECTED /
>                                 sock_map_update_elem
>   if signal_pending
>     state = SS_UNCONNECTED
> 
> connect
>   transport = NULL
>                                 vsock_bpf_recvmsg
>                                   WARN_ON_ONCE(!vsk->transport)
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

This is apparently causing some bpf self-test failure. (Timeout? the
self-test failure output is not clear to me.)

Could you please have a look?

Thanks!

Paolo

