Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7E4DA11
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773050; cv=none; b=W+T8YiL8ohSxO1bvXJjSWTGUoojxxzW3nzCojgqHe/eqIh+Y401lXShpZxXSi+iALjeLawWvKpETRyajVOYwja2uNk+5dPZOO4q1UwjX5px4zn5yI5DBalhXEkTD5LpH4JCgP3etP4cUeWMjcuSYie5nxImqOqM/krbQkd82NFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773050; c=relaxed/simple;
	bh=Ft0UmClN6RCBfY+eiYChyiMKhrK/KxVHCaG8g5v3cME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFlzRe5Kj41vVx+rXZeUuQsI8AQub8U/2UXjej2hfza1cM+9t1YKl6L2kqHePEMvIumLwwkTFEGWcxDFk9erpE80yI/ZEiZKvb4IqsMoNImX6h6q0rM4H1FNtapgD5a6mxLYXXVVFdqij20oOj1h37Hranyrbg+4klzxG4Ll6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZJA031i7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZJA031i7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so3739650b3a.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713773048; x=1714377848; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxIY4mlELkDh2GdwIVzSWRDbRXxeN/G/HA7ttNCrEzA=;
        b=ZJA031i7zrlTgqbsl2xL6lJ3Re1BH9BvO+H71o9vroQ4VYoy2ueg/EUsauyNzP/6As
         4GRYu+7aXFfgfYbPWbaI2QzZgs6m0UgzZVoq5+yUMhi3pMAT2pRZUIYcIPfRNiN4zglw
         hH8sPH4YiMXKNGgRPEDeohrQJhY3g4bb9RCpHhYZYFmw36fOIVC0d6SYNlIFOg3IrQMT
         YYHiAYIB+JZj7MZ2IAC1fipzcL6/iL6PsUqg0ArNopZoXPocXl23rW/sYFleNBq27lLx
         gcznqdTAhKo41kuTn83MstiGtwBxiex9T9h38Pqpshv5U1oCQri1gKd6gkNfYlWxYP21
         yPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773048; x=1714377848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxIY4mlELkDh2GdwIVzSWRDbRXxeN/G/HA7ttNCrEzA=;
        b=hU8QLrjAcFuuLxC4L9PxBmbaI/pVogVbs64cYchEl6t0g12/0cVcW4Xa0DHqUC1u1z
         8Va6poolMRAqLlOoCfYe8yXaW2wCxSveu3siTHLDSvW9gH2iFcVsGug111BXZ2LWEryo
         pGk6jiUN9mFCFvz19ILhKBT1D0siWTdjizkgzoqmEhBw8X05vuAxgAlmXDvzdahHaUJ/
         JyEXTWyBcV/b8bgZ4ofJ6yuasVlfSeJg3gIYBSviZwo0Ia8Av2O0kQXOeUvyYqqu9m/P
         G3nA8Essm09e1neg3azXFc8jDgJ3bBh0HTVB7MCvm9SKDfndb8UlTxTJcQ9Bbp/IjWQb
         mIrw==
X-Forwarded-Encrypted: i=1; AJvYcCVs8jQxRUk5xgogQPXRMW7N3mKP6exCf3QdoHqtWKSnaO0jkePR+9M+Wfl1ovb4359CdIlPltxPZPiR9a8QDU+/mS4yNowatgk4tFULZsU=
X-Gm-Message-State: AOJu0YzFbcivdwYN2/FGleGzbb2z3x28A5h5wuWNzJfzds7Cn7l+ie5u
	wUC+LJoHl2fa2A+vl2/+HedM4eVPm+gSK40KWNJE+K4WIvJs27Mi6qL/+wcYWGk=
X-Google-Smtp-Source: AGHT+IFL0Rf3zkoXQFjWYIOXV3r1BoXk390Ly+Mv2Fk8sW4e8qQRWGncvCiivj8SXzXosAJVSi3mow==
X-Received: by 2002:a05:6a20:96db:b0:1a9:5e63:501b with SMTP id hq27-20020a056a2096db00b001a95e63501bmr7600090pzc.44.1713773047975;
        Mon, 22 Apr 2024 01:04:07 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b001e5a5ea5287sm7483531plg.208.2024.04.22.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:04:07 -0700 (PDT)
Message-ID: <537ac244-74b2-42ad-97a7-475ec27f2134@bytedance.com>
Date: Mon, 22 Apr 2024 16:04:03 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 1/4] virtio_balloon: separate vm events into a
 function
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
 <20240422074254.1440457-2-pizhenwei@bytedance.com>
 <6a182645-1f7f-4b7d-a16a-36e9b1684c58@redhat.com>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <6a182645-1f7f-4b7d-a16a-36e9b1684c58@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/22/24 15:47, David Hildenbrand wrote:
> On 22.04.24 09:42, zhenwei pi wrote:
>> All the VM events related statistics have dependence on
>> 'CONFIG_VM_EVENT_COUNTERS', once any stack variable is required by any
>> VM events in future, we would have codes like:
>>   #ifdef CONFIG_VM_EVENT_COUNTERS
>>        unsigned long foo;
>>   #endif
>>        ...
>>   #ifdef CONFIG_VM_EVENT_COUNTERS
>>        foo = events[XXX] + events[YYY];
>>        update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
>>   #endif
>>
>> Separate vm events into a single function, also remove
> 
> Why not simply use __maybe_unused for that variable?
> 

1>
static unsigned int update_balloon_stats()
{
     unsigned __maybe_unused long foo;

     ...
#ifdef CONFIG_VM_EVENT_COUNTERS
     foo = events[XXX] + events[YYY];
     update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
#endif
}

2>
static inline unsigned int update_balloon_vm_stats()
{
#ifdef CONFIG_VM_EVENT_COUNTERS
     unsigned long foo;

     foo = events[XXX] + events[YYY];
     update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
#endif
}

 From the point of my view, I don't need to compile code in my brain 
when reading codes for case 2. :)

-- 
zhenwei pi
