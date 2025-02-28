Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1D274242
	for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761032; cv=none; b=Ac8J2CBbBQi/7sOEMKC3BnEOSNQWOBzHAyK2RBC6KDPBr/BkoXeAU9qmiunvp/ihih9skf/IuNKV40jxgoUMV+OUgiCNmDgpWQOg+yrQ7IiUEbP0MTOUVpEKYXNzVL2d693/waEzY1VVWeRaNHIrwUPOXEPIaHnezmpEKfgxjts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761032; c=relaxed/simple;
	bh=wvv9KqhZwUsWb+lgfSj2l4+bwKH8+JdHivJEOBV4+Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDXYW6FEmPsG8n2Pv75Wi+2w1FFzadYfmI52/6Pm9Gd3NYZ/Mt98ikAnzi+cw/5Hk9SI/YJAvbkE7bIFihE9ZScbaykHwplxAJDMhfyvwsT9vAJgqIE9CbXPpEKFYlxZpRq3l2gB+WQqINzvJs9Jkz935RVkQrYQPvXlFeGR5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H01R1soP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H01R1soP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740761030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F0QGo9HdSucNqODk69QyhyvARJ/ftblyHDK9MmTLa3Q=;
	b=H01R1soPGSQW3NdIfX+ViLectb1zo8uE0GSFOXIBHNqQGJxeC0f36IFyL0zalQdqh84168
	bRi3j5g4wk6uAh/pxLEKfUmvHnoaZTHLoUkZaq7enobVoujgIyMPHf3ls2iJt/WROcj1a+
	zklIHPoDmxJ2JLnRrmJylV6JFTg6pgE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-xWFOpWqDM4yf-wTvM8Ueeg-1; Fri, 28 Feb 2025 11:43:46 -0500
X-MC-Unique: xWFOpWqDM4yf-wTvM8Ueeg-1
X-Mimecast-MFC-AGG-ID: xWFOpWqDM4yf-wTvM8Ueeg_1740761025
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390e8df7ab6so661725f8f.3
        for <virtualization@lists.linux.dev>; Fri, 28 Feb 2025 08:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761025; x=1741365825;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0QGo9HdSucNqODk69QyhyvARJ/ftblyHDK9MmTLa3Q=;
        b=LCf/XKM67kwxotQNhzd3Ai5b1XP7Uj6n9JsJcx4co7xdjqimrSr/tnpIpGnuSqsqRa
         wB+JNwnhH0DZma11ac9CQ1mwCIl2KEi9f7Vl6qtBvX+mrGQhfxH3CWeYJBS7n2v777OC
         DXuEgPsys85ZvxZ4qvdCzaC1iffuhm7J6qiHLldHvOGUASLSoNGrXbzDbrX5fCct7v7F
         mjXNDrkRMAEhQVYz6wb16ie7S84FOK3SAPuKU/MS/cVlpEoZG6nXrdDKgZ5UCQYXUXjR
         CVx2gSq58Y7v5uuGIsvgohYQUv7+y8sqT82yp7pnistk18V2k2KPyF+55xqdQJFFihZc
         myiA==
X-Forwarded-Encrypted: i=1; AJvYcCUyvdqXkDVjUzcoDnOiGuSSbGvdzZdRACQDbicnMD0k1Vl/xiWC14augXMPNr9Tm0RtoF76GBxfKPeoUoP/lw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzam6OYFNGdUKSr83e5RbjKaQaM3SjpFiF6uFVaUEf+qWxfPqdL
	+FA4w4G4DQobT7Uv0DDn3t+b9ns0byRjZwRnwdPF/AD2cGUP+L2KaPUHRpUgiq1zIfnYXGADGus
	7mLbCwfcwFzSybWvuxYbd/ftgpsfYOZvYharuw0rcObjlwtCc+w8glvr8nqH2yh9p
X-Gm-Gg: ASbGncvuzjqiqag7pdj/vC5w+Vw515FmOICc+LKwzmi1eZBElxmWA6lyCk0h9SEn9s+
	E+s9Np5hMsXkkXjPElXhMnv/HDZZ5SH74WU974l8G8VM+2UEdc348yrAaJ99OagWV0fAhmfXfrD
	/bsD1A/Yb14AkYwXndlx9k3yr3T0PprUaEe01o1Uh3StoOpPximTW874VJvy/wZpwNngyqQudMF
	CNSEG0Dh9T+kL8SbyHjjYgPTRedQk/jKQFzScaGSvbUwG8z9CvJTUfbFK0XqLZUIW/qTaqx452D
	D2GNGWGu9vkMd+o+mAkq
X-Received: by 2002:a05:6000:1a8d:b0:390:e7d7:9669 with SMTP id ffacd0b85a97d-390ec7ccfb4mr4812437f8f.21.1740761025573;
        Fri, 28 Feb 2025 08:43:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM+V0QFUXYyh2cfMC6RxPcJOHS8+pixnyA7NNsa8i7lZq3JzDKV8Sj/QMZTwmon1bEt2pH3g==
X-Received: by 2002:a05:6000:1a8d:b0:390:e7d7:9669 with SMTP id ffacd0b85a97d-390ec7ccfb4mr4812401f8f.21.1740761025137;
        Fri, 28 Feb 2025 08:43:45 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e4844adfsm5742245f8f.62.2025.02.28.08.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:43:44 -0800 (PST)
Message-ID: <3b1046fb-962c-4c15-9c4e-9356171532a0@redhat.com>
Date: Fri, 28 Feb 2025 17:43:43 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/2]
To: Keith Busch <kbusch@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Lei Yang <leiyang@redhat.com>, Keith Busch <kbusch@meta.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org,
 netdev@vger.kernel.org
References: <20250227230631.303431-1-kbusch@meta.com>
 <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
 <Z8HE-Ou-_9dTlGqf@google.com> <Z8HJD3m6YyCPrFMR@google.com>
 <Z8HPENTMF5xZikVd@kbusch-mbp> <Z8HWab5J5O29xsJj@google.com>
 <Z8HYAtCxKD8-tfAP@kbusch-mbp>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z8HYAtCxKD8-tfAP@kbusch-mbp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2eK9wE0Ll5FFLIbgGbay9HNL-ITiYy0Tl6epI2hpesQ_1740761025
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 16:36, Keith Busch wrote:
> On Fri, Feb 28, 2025 at 07:29:45AM -0800, Sean Christopherson wrote:
>> On Fri, Feb 28, 2025, Keith Busch wrote:
>>> On Fri, Feb 28, 2025 at 06:32:47AM -0800, Sean Christopherson wrote:
>>>>> @@ -35,10 +35,12 @@ static inline int call_once(struct once *once, int (*cb)(struct once *))
>>>>>                  return 0;
>>>>>   
>>>>>           guard(mutex)(&once->lock);
>>>>> -        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
>>>>> -        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
>>>>> +        if (WARN_ON(atomic_read(&once->state) == ONCE_RUNNING))
>>>>>                   return -EINVAL;
>>>>>   
>>>>> +        if (atomic_read(&once->state) == ONCE_COMPLETED)
>>>>> +                return 0;
>>>>> +
>>>>>           atomic_set(&once->state, ONCE_RUNNING);
>>>>>          r = cb(once);
>>>>>          if (r)
>>>
>>> Possible suggestion since it seems odd to do an atomic_read twice on the
>>> same value.
>>
>> Yeah, good call.  At the risk of getting too cute, how about this?
> 
> Sure, that also looks good to me.

Just to overthink it a bit more, I'm changing "if (r)" to "if (r < 0)". 
Not because it's particularly useful to return a meaningful nonzero 
value on the first initialization, but more because 0+ for success and 
-errno for failure is a more common.

Queued with this change, thanks.

(Keith, I haven't forgotten about AVX by the way).

Paolo

