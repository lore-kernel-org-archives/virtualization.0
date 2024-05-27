Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0E4779F
	for <virtualization@lists.linux.dev>; Mon, 27 May 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799260; cv=none; b=JU2ngfzncpfEVxJHQbcYKvocJNaNmbQZXBi6rRynhV0JEvdgVUZP4H9Jb+cWFsav83euoB2DULQBU0P0quU70vPw+oudeemwh+lxL0VEPPg3U8f8IeX5WLnCbojchdEl5i5JteqhAbKUGVeoK/B9gJ146SplUno2D4EmF7eFOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799260; c=relaxed/simple;
	bh=LnRnA2Jjmv5v1wzM1P4UEYWuVqzhiZ8cKDv1xenj3pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hu0i8upIwf2wcNUGvqhvWLKoKTpXj0Lv6eK3MoAQd+3cKLBGljMbvS6lUv0CyEYzxMHhrq/UBB0VLOFAdjNRMLDs+Cdg7LJmoZoRcDsPuuTsO8NPi9cG60kqd6+J1ICnd3X+3NFi+o+uv8HokzijzsY06Xp16bXhGmxgsHQeDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj1MjTjq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj1MjTjq"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8eba8f25eso2358686b3a.3
        for <virtualization@lists.linux.dev>; Mon, 27 May 2024 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716799258; x=1717404058; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwVuXWQUZEgL6e/tw+iGOXe1aznzrrLjd63ykG2zqqQ=;
        b=Kj1MjTjqYcSfmafiA3HooP99V6owldf3aTutKJ8gZ0SixUnB+ECP++T2NVgL0j+TwP
         uDU18JCmOLJgJEb5/B3e3pERLn64vEXVqwzJUBFZk4f01AxyI6Fzj6VH5bxoTb1Zvg5g
         nLjEJh6uzV5xF3kHoZbmR6fU/q9bD2C4pldgifh+ovjOvr5eLWCgacPSyJuQM/jdgSMm
         zIcod2EeQ/y/9uBvqtNu3qfosY/qeguIWlbP1X3H8tcJ9626EMAl+fkgpGILKLAX6wR0
         eDoAcuS//4DVOtqGftjuwMXgBAHsSkCvZmzbcozV1r8z68CtZevCeGjYN03xJvxAR+L4
         La5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799258; x=1717404058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwVuXWQUZEgL6e/tw+iGOXe1aznzrrLjd63ykG2zqqQ=;
        b=K+e3qMlxh4r590GYwr6jDGUBtsHsw1bU+Nl5BanwSmBMdRg+FSg6TQBk0aDstt1OiA
         p2pnKmA4HzfAQOjy5ReDkh4nSzvCvNvkyG8EOUYyPfNoLOCOwnzb5HCS6XiR2OYW4/yS
         uOaYav2lZgNRtlqJo1jFUEe2bw3Nf2NPjj0ATw/8hgSRoVTfVcY2BRhAOHXQVb9uCTMK
         YHSSdguB42OocRt1WhNYMlbKmErjQDjDg2Eru+B8E6GRHwHs01C5xzUgXuuubr1ZK4hL
         OEdPLj25a2xLFXBYcmend7kldeUoDjj9h+ZA0R+jOjYQCXiFfn1WjW8RDDPhGMBSCXEF
         nBjA==
X-Forwarded-Encrypted: i=1; AJvYcCWwpqmY6/jCO0KFFxlv0DBDnCTt9r19a+xhDEDoDFvX9D86Uj9ae/SEI+9mL/1V/t8cZwlo9zdwFr6/o966DE8nLX7H6WUyP3fDGG2q2Hg=
X-Gm-Message-State: AOJu0Ywt7bCYwiN4Gw0w5L4UdwjXndFmZYIRRvmSEta3Gh5NRMOACr86
	4rBQtYKzW/6+YwSj69H/9B49GsmwUhANBmOefV5x1PbpnT6oYjGYiHHx5BA1nJs=
X-Google-Smtp-Source: AGHT+IFE9T0rPP7MwtRJUQicZehQa9jFlvSRFoYunB9B4Qz+S1VqJZB9Znj1JzGeT9hBbKTDRlVOxw==
X-Received: by 2002:a05:6a20:3d88:b0:1af:b86d:b6dc with SMTP id adf61e73a8af0-1b212f63dfdmr9828343637.55.1716799258547;
        Mon, 27 May 2024 01:40:58 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbea891sm4452567b3a.126.2024.05.27.01.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 01:40:58 -0700 (PDT)
Message-ID: <694d1a9c-4e2d-4fd1-8b04-1c753c414761@gmail.com>
Date: Mon, 27 May 2024 17:40:54 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/virtio: pipe assertion in vring_test.c
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 skhan@linuxfoundation.org, Austin Kim <austindh.kim@gmail.com>,
 shjy180909@gmail.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240527071330.105268-1-yskelg@gmail.com>
 <20240527035009-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <20240527035009-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/27/24 4:52 오후, Michael S. Tsirkin wrote:
> On Mon, May 27, 2024 at 04:13:31PM +0900, yskelg@gmail.com wrote:
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> The virtio_device need to fail checking when create the geust/host pipe.
> 
> typo

Thank you for code review Michael.

Sorry, there was a typo in my message.

I'll fix it and send you patch version 2.

>>
>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> 
> 
> I guess ... 
> 
>> ---
>>  tools/virtio/vringh_test.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
>> index 98ff808d6f0c..b1af8807c02a 100644
>> --- a/tools/virtio/vringh_test.c
>> +++ b/tools/virtio/vringh_test.c
>> @@ -161,8 +161,8 @@ static int parallel_test(u64 features,
>>  	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>>  	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>>  
>> -	pipe(to_guest);
>> -	pipe(to_host);
>> +	assert(pipe(to_guest) == 0);
>> +	assert(pipe(to_host) == 0);
> 
> 
> I don't like == 0, prefer ! .
> Also, calling pipe outside assert is preferable, since in theory
> assert can be compiled out.
> Not an issue here but people tend to copy/paste text.

I agree, it's uncomfortable even if I did it.

I'll fix it as you suggested and send it to patch 2.

Thank you!


Warm Regards,

Yunseong Kim


>>  	CPU_ZERO(&cpu_set);
>>  	find_cpus(&first_cpu, &last_cpu);
>> -- 
>> 2.34.1
> 
