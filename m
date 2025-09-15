Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A92727F5
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934475; cv=none; b=uHe5hXsNcOJWcZnVlOBd6aMa6vQeu9IkVV/iXuogE7nAYdJvtMrYoHdstTULcKn+cuno83GxHlFqrc2qN8oSm1x2h2ONHzFi27U4UfHaIK8glfN+vDkp7Hmgqq4rCbfBMy4krRh4zoOxs1RNhFyPXAUAcfxcMmU3BHe49JdTVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934475; c=relaxed/simple;
	bh=jn1UDMrVa2RkwDackfdvSPicrQA1mPEJmzSV+2yR/3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKXk2QSu5eZAxALNFiVg/+q1ff1l0yRj//LPjMmktCD7XWgHjzCNCyKF09Hm4OdcFpsPwuWEK2PaQdKOdRHt5yNhC581o3RXC3Km6oV/12yTm9AmKKV97/wVA4YuonqMQr2G0a1R7S+VzOQHoXWJ41YPDHa80ZaOChSRsrmZ8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h4VehND5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h4VehND5"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7741991159bso5286133b3a.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757934473; x=1758539273; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdq8TPOWgd9r2bHucRGGKVjUvkEbkZsPHnW8zymhVdQ=;
        b=h4VehND5pxmg0PIVmODxStn3IkKJD6J4HIWTciF2BHOh5jzaN9nJFyQnO14DKqFLGC
         eKP8EvmhvWspg7kBvMaGlM91N3w2fIJkcGU+3gs7nfyi7i/3ckHKh2BnnGkd86jWVndy
         XbTOggUEPCzfq0+gcOB99j+dfBE+ptkr6DFyfkF+61oaannqwjjYAhZ9UndbOTPLoPbp
         OqRYQgMWpeHM3l1LjXpDQ+joW1UXr4G443V5q87J+SX9KqOYuu2ooGGEvJ+YrA++LZW5
         t4GIzA8b9GcNpAiBsGlKKLszwBCysj1MVhHcdjIe9NqXKSFcanEjR7kU/VHmmyFD5QgZ
         XWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934473; x=1758539273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdq8TPOWgd9r2bHucRGGKVjUvkEbkZsPHnW8zymhVdQ=;
        b=EoksY38SQULL3MX6OfpDyusSfbGRHJ9dAnkL51DbsEQ++MS/JjetZkZ7fcj7AgbWzr
         +6n8GY7MGBhlu5W1nBp/x3bNpyeIcmR/UTnR/kaW1ngMqUu1z4TUoqcCkr6/eyyM3YiF
         kQkzl17q+bUmn2LOdU0+BXQtr1IlxWAEV4u5oLPq22KATGT8gNhK3adt0kbhZHzJFSqS
         7q6/Bb00bF7cykuRAD/SG+SCJRp5xEvr9uT4hnchjrzzysvlodWdjd3pv7NZ0hstDmZi
         282QUzusvQrzdPu4lpCcpOpWmxWwjmL7/7AsdPyI0s4MxaRXxvCRka8ikTtTjHoANJ4f
         y4qw==
X-Forwarded-Encrypted: i=1; AJvYcCWQeCcowonNMY3D1334AfORDcrxLY4EpBasSwuMzX1aaQcTjmLuS1wZ6ShhLuEtGgsOSPQAZjJExi7cXDiJ1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNe08w+/nHyiofJ0jnUkqB6CP6QbCGyf6a2ESLW6ccSs3Slr7N
	HAcaVgmRbZPGfOPVH2K4Rfq5Yp1Ve25oZzuOLI1VXOHfwrRfO3EXkBv2v7I8yiAFbKQ=
X-Gm-Gg: ASbGnctwsT4T9ewc2JkMTkoyZYp42YpfWy/zF5p9dPTknCu+SsH5JfMHvaZMTKqSq5W
	Ok8D8zYYyO1DRnX7NtWpoXbbhhuzVOTv9ZCFSj3ryJ6qf21hqDbZNApvZ65b0V3uOea+RqY0Z1y
	R6yXzcU5fEZQkpmpLO/49yuHy9/pg9bRQ5BKoEoL9/vAqHOZReejlj3FzWvJCxYzo6grP4TxgE9
	+Jzoyyr0wP9Fk7ARdhN7ZbrgYP2xkw3akPwVfSsHy39dA6KJdHfSCx1kpcYtthQ7vjKTNbWVqnP
	GgxbM2/u6DBXgxrnAkUty3Vuh5OruIwXmqb+FPTVGWNSmSx8tBjFclv2BdGXf2RRX8S9wMBFpIA
	3SAVAvD4aMtoy3Q0f8HOrAx+9yayBDL0fnz5AUXkADO0IIfpX42/zzKkNpcDwbiknZHgv/yg=
X-Google-Smtp-Source: AGHT+IFuRcr6hgmXMe2zsK7e+8P2AmK5zY9xr9VyAWEQkmImnrWVnmovPW/VnBl1d66Hj0mNNBFu+A==
X-Received: by 2002:a05:6a00:8015:b0:776:19f6:5d35 with SMTP id d2e1a72fcca58-77619f66ccbmr12225524b3a.31.1757934472854;
        Mon, 15 Sep 2025 04:07:52 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1a3fesm13209375b3a.56.2025.09.15.04.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:07:52 -0700 (PDT)
Message-ID: <328b3f8f-cca7-4d8f-9335-24341b40b2d5@bytedance.com>
Date: Mon, 15 Sep 2025 19:07:47 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] vduse: Use fixed 4KB bounce pages for
 arm64 64KB page size
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 xieyongji@bytedance.com
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEvWNOjFU0pgiS=LF2B+yEC-y_RU3w_P5_dr10RPH+5xrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/15 16:21, Jason Wang 写道:
> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>
>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>
>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>> even small IO requests to occupy an entire bounce page exclusively.
> 
> This sounds more like an issue of the IOVA allocating that use the
> wrong granular?
> 

Sorry, the previous email has a slight formatting issue.

The granularity of the IOVA allocator is customized during the 
initialization of the vduse domain, and this value is also modified in
this commit.

Thanks

>> The
>> kind of memory waste will be more significant on arm64 with 64KB pages.
>>
>> So, optimize it by using fixed 4KB bounce pages.
>>
>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> 
> Thanks
> 

