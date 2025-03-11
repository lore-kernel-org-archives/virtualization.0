Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F71C54AF
	for <virtualization@lists.linux.dev>; Tue, 11 Mar 2025 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700970; cv=none; b=BqmDwAQiwBhgitq//7Q/yUZoo48RtBF/b2zsTcRHRvIiEFlTEj6kpfFKNGYg+WOPQ5RkYumkSP63SUS0lbtAl/qgVUAnEw73BdEu2G+AnGX1utS+xjY89FqgyvFza4TlHLbtuIzAW52ob5PVIcS8NNYfDKbvIosZTq47OXGEsxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700970; c=relaxed/simple;
	bh=szBVGBATHmAoxSvkaJnA2k09xrdAhYDfUBkWPhXAyTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RV6SH1GmwNytRhYspzVQIcxc8CQlmmJZqICoxNos5Y6imNa/liY1BKf5tw5vhckPmg4WF2zLPBw2H31FZyr7KlrFFo4qxa328ctm8+ynwYf2ymce0lnXgfZMHfPoRqirDPJOD0v26J4rWZQ4M1aYF2Mtg/3bJdV7Sr23QA4hI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lIlgsK+R; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lIlgsK+R"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d442a77a03so12081945ab.1
        for <virtualization@lists.linux.dev>; Tue, 11 Mar 2025 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741700967; x=1742305767; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15FhpTy16DxiOxuCUjxYZ7HE8WR5eqNgpOkZavgiv/I=;
        b=lIlgsK+RwbXxeWdHXTEzf9PiPHb78GcjaXUQgc9+ghXO5WxUAZIO+FlzZZLzYdea4r
         FrCGHtl3u2O/HSEBb7gObXAhk4NuVUDTkUxMqBPDFBmQXm9KqBXjgCku8R3WamxXlwaC
         6cn2ggPpJ+0iUPBpGR0V/eixa2tn7s5erMW9T6/WtHtFadmd+ZpO0bDblcie1Q0NM+wO
         bQ1hyuRkmiRNTpejQ49qCX1PlVS7rjP4OB4dBG1yNSFr/191FotO2GVUJPFrn3NqGmH3
         eljFqzyAWAnL+LnrdI5P0MbIfbOq3f3ImzgFViZAV2LLeSnDqW9zrfCY4WvKovhsxbxR
         OWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700967; x=1742305767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15FhpTy16DxiOxuCUjxYZ7HE8WR5eqNgpOkZavgiv/I=;
        b=EeaFgy72mp4qqx6EKhS17oZ0Qf6Y5VR3G9JQ/BvskdupdQZB4OH6ep85riHsuf037k
         2Wlaptyb0aNsmIaoY7PTRUwe5l3y1NasPfoXWXZkg0rzOPBxM7ETbCmhWIIo5PezuyuH
         3yFy9h4QUK5Au4D1SMvTqPt4w1u6XR8OJYUfCQBZW2BE7bnIgerWWeLakJ/RbkFWWsCA
         jzReZ5GW4exl57IUTpe/H8tsSkyisoZZR2mZiEg5KPzcz7HXYnjsHvaGynBq8WDr6gba
         /uRHFMfq9wCe1XEVnnPmX8BejROmSHemFeq+JPJX7anqZMpIvlTuxnZRIyAlPWD7gDiq
         fqEg==
X-Gm-Message-State: AOJu0YyypX8Mqf/dMyuLYMCGrOfF4zY3I4FAW643D/kPhgKfJZhq/rY7
	YXMd7A5jpYAE4iATzu1hIsNiaOn9MB6S3YJ5lPPe4qjsElnpQHHvUqEtsjZvbLI=
X-Gm-Gg: ASbGncuOC7QUsdcBJhnZ6LN+gPx05pp8dKC9g/hkpK5WJSp5QGyDB8aRpANEh8fnQaQ
	DkdGCcnas1ajAx/HxWZuodpVsm7dEufFA1EMp9h5naFJpKEz3CA/5veQIB4E94fZyMMv3RvqZOM
	xZ1K0nuyOYD6XPsl9YSkLR6YhIs5IEdv4Q9PS3QcT3oytp6kogLeGHyNuL8yxs5kASCw77SU4CE
	+2L7jeDPd0zSIzGDSqPHWEeY17yjc6V+U7BKVp/+Wulzz3Sjit5UqrJlk4B4BhTz9ghinlBfZbn
	bryOM3Orm55RlRjk8YQ99vjcsogqArDEXWFggqZr
X-Google-Smtp-Source: AGHT+IF9VOkMgxNVu1F60lVcFqCfcpKy9OE2LoUEIM37eUdSf+tjRuA17mWqs6+fEo7uJIQmp36ZSA==
X-Received: by 2002:a05:6e02:174b:b0:3d4:2a4e:1272 with SMTP id e9e14a558f8ab-3d441a46c62mr203305475ab.19.1741700967289;
        Tue, 11 Mar 2025 06:49:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2221c1d6dsm1925186173.95.2025.03.11.06.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:49:26 -0700 (PDT)
Message-ID: <3369329c-13ac-4b18-9923-1a24e1243035@kernel.dk>
Date: Tue, 11 Mar 2025 07:49:25 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sven Peter <sven@svenpeter.dev>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 4:43 AM, Shin'ichiro Kawasaki wrote:
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
> failure [1].
> 
> The test case injects errors to the NVMe driver and confirms the errors
> are logged. The first half of the test checks it for non-passthrough
> requests, and the second half checks for passthrough requests. The
> commit made both halves fail.
> 
> This series addresses the test case failure. The first patch covers the
> passthrough requests, and the second patch covers the non-passthrough
> requests.

Looks good to me, and better than the quick fix-up for the problem.
Thanks for taking the time to do it right!

-- 
Jens Axboe

