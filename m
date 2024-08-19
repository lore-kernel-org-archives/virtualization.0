Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821B1E4AB
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072545; cv=none; b=lmZsfoGMZbELZPdfl5GHjgKMBLTMndpuXkGS9UOb2xFV+vRBL29aNd07FJhYa3/wKPbCNTjrWcsmnFbal/Z4fbcds1+y1z+bcTKOxkwazg8tR2dkrORByRHKmT0ljZfMJSdQovnljcIFC+ytdZFWP5FAKVwCu20MpZtrdnFTymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072545; c=relaxed/simple;
	bh=dHmrJzaIu3zJPHmzEliv1ewgMJ0RhbsWGUgRz+av7po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoOHcY78caUdkOJT4APhjWNdxH6Y3GoKg0FQ3R6WtNO3XPdsWVCjEqobnl4BFW1kh025CRslSKtsII4P8NO4nlUQ5vKpqF0oHPYhSDmkWV9y6JRHmEp9dkWhhAisFKMQuaYNEGrv67eWIIhwk0p+d4+iRqdipqn3Nz1GN3CFikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDhuakCb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDhuakCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724072542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L354KTrWlkNo1VjLcWMmjkcbCq1FC6RNhOfHs0/qCLE=;
	b=UDhuakCbGzEkF/nnumJS8A2oITUTdgTc7G+aazXdZBX+jeJvnluxbaToaDZUNYjZfs7VNn
	0IbUiIhNwqcN9v0dtNc9QlDMvSqjrwaD9Oh5IhZiDjBUcOfNKqz+0R9KDVJmSInYeylmW5
	kCPzzLqjAWD2HoAyvvjkhkYrZe7DKms=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-rX17HhXkOtOi7Aghl1ZDGw-1; Mon, 19 Aug 2024 09:02:14 -0400
X-MC-Unique: rX17HhXkOtOi7Aghl1ZDGw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bee6a8843eso1362866a12.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 06:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072533; x=1724677333;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L354KTrWlkNo1VjLcWMmjkcbCq1FC6RNhOfHs0/qCLE=;
        b=F+6yTEpBfTkIc+WqoG5kMuH+4nQ+ygoVhkUBV/byomNUVtGx8U4eA/VmQUA0W2S/Cv
         2e6dbm1oto67L8usQuWJmM/UuNOzg4qplWHlz6RSGdHx4RZEBRrV1PaX42rg9bnctLP8
         p4S0yEsqI57I6xnnd9vWCWMVgUcS6vkjvfL3byMOSLAyMjS5hNQUXH8fiZuvmXHFgGXH
         Aph+5F64qOVf3ctDMskqBESLh7Z9Ue4sJkKnJjtxggqkiPzmxaA/nQuik4h5j8i0Hx4V
         AeKfNWbsvOkXVH83mGzm6PxVAkOqY9bGNaO/LCpCCeYTCqPYNn8Bojb20C4nmztYDinn
         35Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVGEnNNJdKdCQbEZdCwUP5YEYSwrCLTY4XsGkvlexkRIFLCKZHfvcQ4zYxif1Ee7kX1G1+WEq/haWqUSYpRXlTPChzXMTsUIfCfKFpho1A=
X-Gm-Message-State: AOJu0Yz3AwWwOUQij0K7JDdYsKASPx/IoKGG4kRH2kWUq+WknVy+1iPT
	IEm8NLtHnjefVbQlRynGJfGP1uBYdth0EanGbLVtfVCiDOlX5/vjFZjZ23lX/KrFxwucs2WkylL
	BW/mcHPHHiWBRk6UTgO/dUZ3x9myzc7m3UGdjPB6RK5eQjAjxzKL1RPdU2aDRjfU6
X-Received: by 2002:a17:907:efc8:b0:a77:b054:ba7d with SMTP id a640c23a62f3a-a8392a16e10mr708417466b.46.1724072532882;
        Mon, 19 Aug 2024 06:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFsI/qcbeC1kjFjNC+nNC2bP7hj4GMAq8MQVyUzyGIecz8LTuHFghb/ciBsBvB7Wxq1q6tAQ==
X-Received: by 2002:a17:907:efc8:b0:a77:b054:ba7d with SMTP id a640c23a62f3a-a8392a16e10mr708414066b.46.1724072532329;
        Mon, 19 Aug 2024 06:02:12 -0700 (PDT)
Received: from [100.81.188.195] (ipb218f908.dynamic.kabel-deutschland.de. [178.24.249.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394669esm641589566b.143.2024.08.19.06.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 06:02:11 -0700 (PDT)
Message-ID: <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
Date: Mon, 19 Aug 2024 15:02:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, mhocko@suse.com,
 penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, virtualization@lists.linux.dev
References: <20240817062449.21164-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240817062449.21164-1-21cnbao@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.08.24 08:24, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> -v3:
>   * collect reviewed-by, acked-by etc. Michal, Christoph, Vlastimil, Davidlohr,
>     thanks!
>   * use Jason's patch[1] to fix vdpa and refine his changelog.
>   * refine changelogs
> [1] https://lore.kernel.org/all/20240808054320.10017-1-jasowang@redhat.com/
> 
> -v2:
>   https://lore.kernel.org/linux-mm/20240731000155.109583-1-21cnbao@gmail.com/
> 
>   * adjust vpda fix according to Jason and Michal's feedback, I would
>     expect Jason to test it, thanks!
>   * split BUG_ON of unavoidable failure and the case GFP_ATOMIC |
>     __GFP_NOFAIL into two patches according to Vlastimil and Michal.
>   * collect Michal's acked-by for patch 2 - the doc;
>   * remove the new GFP_NOFAIL from this series, that one would be a
>     separate enhancement patchset later on.
> 
> -v1:
>   https://lore.kernel.org/linux-mm/20240724085544.299090-1-21cnbao@gmail.com/
> 
> __GFP_NOFAIL carries the semantics of never failing, so its callers
> do not check the return value:
>    %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
>    cannot handle allocation failures. The allocation could block
>    indefinitely but will never return with failure. Testing for
>    failure is pointless.
> 

You should have called this series "mm: clarify nofail and BUG_ON on 
with invalid arguments with nofail"

I was a bit surprised to find that many BUG_ON in this series ;)

> However, __GFP_NOFAIL can sometimes fail if it exceeds size limits
> or is used with GFP_ATOMIC/GFP_NOWAIT in a non-sleepable context.
> This can expose security vulnerabilities due to potential NULL
> dereferences.

Which code is that that we are concerned about? Some OOT driver? Some 
untested in-tree driver? Just trying to understand what we are afraid 
about here. I'm afraid we cannot safe the world with some OOT drivers :(

Are we aware of such security vulnerabilities (out of pure interest!)?

Is the expectation that these code paths are never triggered during 
early testing where a WARN_ON_ONCE() would just highlight -- in addition 
to a likely crash -- that something is very wrong?

> 
> Since __GFP_NOFAIL does not support non-blocking allocation, we introduce
> GFP_NOFAIL with inclusive blocking semantics and encourage using GFP_NOFAIL
> as a replacement for __GFP_NOFAIL in non-mm.

I still wonder if specifying GFP_NOFAIL should not simply come with the 
semantics "implies direct reclaim. If called for non-blocking 
allocations, bad things will happen (no security bad things though)." ;)

> 
> If we must still fail a nofail allocation, we should trigger a BUG rather
> than exposing NULL dereferences to callers who do not check the return
> value.

I am not convinced that BUG_ON is the right tool here to save the world, 
but I see how we arrived here.

-- 
Cheers,

David / dhildenb

