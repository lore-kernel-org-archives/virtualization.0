Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9281C7B99
	for <virtualization@lists.linux.dev>; Tue, 15 Oct 2024 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980189; cv=none; b=IcKqtrC6HsTrKgr/kmdxBIh4dHFqfRGLnpance7bGCDA13yvaPCru+Ulx4pPpPre1XPmDUCEm+7OTBJOeUDfuMwGyil/9ekslZENaZcgrdOGZwoTl3adOGIiXeKmdToh9+Yuw2TtvkbSotaV8dLbq9NQRnl0D2CeNaxvbiMzSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980189; c=relaxed/simple;
	bh=1kwNNBBrAxFUwkigXre5cgHMKcP/9uMr2mQlkZOq2eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=go9mtk3lN6gMT47MLw+7Tk5pXRyj3kIwp1UPfq9KwjkoLcXHonlglxZDkDcrExD6mjwf0K9SJ/kLCmryvt0KqEgP59P3jKNxDpFADWoGgI1MzuNz8UDk7LoNwURCAPtZ1K66kFu5ve+3D8dHcNo+j5wTCc7Xu4WwzWBB+iYZr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJwrvoMt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJwrvoMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728980185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Y3qaJxVISZGKPtAe1Txr62rhPQYoQyPl/3xNbSM7RfA=;
	b=KJwrvoMtW9vb/ifpJ/L2ESefCfccqNb6fosD2ecSaEZ0PIiR2eeccnC+mlO7El9HWKFmiC
	MHJ54Pu1+FbO/fAVMQHyctHLIcmRn2nvfpv3ZLjb7pkdyMY7VMxnUVXxNAY34+Ks5Tb6Ck
	a7dQ9on/wx69H/AU5SBy5VkNgCVLOOs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-6kHUavk8N1uaU-nQMhtabA-1; Tue, 15 Oct 2024 04:16:24 -0400
X-MC-Unique: 6kHUavk8N1uaU-nQMhtabA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539e13b8143so2613093e87.0
        for <virtualization@lists.linux.dev>; Tue, 15 Oct 2024 01:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980183; x=1729584983;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y3qaJxVISZGKPtAe1Txr62rhPQYoQyPl/3xNbSM7RfA=;
        b=cf7iRpOr3isnQXsUHFHswi4gNEiX0Y7dtRgr4Xgs76589hrdnwB5OfAfta3xS7u88f
         XUa7PHjsGCI6MOEzRfXlJS3gXqt2RKy8WEecdrW+Njo8tliTeCmB28fQHQYWLSooYk4m
         Ir7okHqAsYB4Jr/UGR587/oGIm+zTiRwJQUmODrxXRzhLwkam4/f9rOY9r6UkbDAACEE
         TBBmtPOoKzc46mC6IWWUBq0aEJmLBzMBMKJxQ1LWJz3gY9fUwiTJbl4V93k7/LF9WeNC
         +BE0D7tcuCGfbscW0/MBOoiXRXwpN6ef7qFRrfGhVcGid8ukF8vgA3B+7F6jUI0Ac/dB
         lRxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3dYj1uo3Sd33qJIjdW5D2gATivGI2b0fFrySAFgGKCxu7wrrUkGwAhp/s+MtgwpKDURDfAKlhclOEc3m7mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxnq7hm5AFP/qcR6BcKNa1DkIEKcCnOQmYJCbDcivuv7GBxxF4
	0aywNU5DXZjVT1yw+ML9lNiLCD3+eW4/gUAVQr+wWnSEvNXji+iy0zKFgXAZ81Xzvf1UQnk721h
	87Ofiyho72Mufq8kdpn8UWwOdCehdG+H8RKU6+AAAYrME2/MCWhdtQ5yfI98A8Kgx
X-Received: by 2002:a05:6512:138a:b0:539:e911:d20e with SMTP id 2adb3069b0e04-539e911d2d5mr4301451e87.47.1728980183034;
        Tue, 15 Oct 2024 01:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGONdNBejOBFAKiCA308e8Vr2A7//3b+LsytzSBJyDurciY5f5xqFdG4CvlVFIh1Pfw4fq3aA==
X-Received: by 2002:a05:6512:138a:b0:539:e911:d20e with SMTP id 2adb3069b0e04-539e911d2d5mr4301421e87.47.1728980182494;
        Tue, 15 Oct 2024 01:16:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c730:9700:d653:fb19:75e5:ab5c? (p200300cbc7309700d653fb1975e5ab5c.dip0.t-ipconnect.de. [2003:cb:c730:9700:d653:fb19:75e5:ab5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm913160f8f.113.2024.10.15.01.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 01:16:21 -0700 (PDT)
Message-ID: <8e39522c-2853-4d1f-b5ec-64fabcca968b@redhat.com>
Date: Tue, 15 Oct 2024 10:16:20 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] Documentation: s390-diag.rst: make diag500 a
 generic KVM hypercall
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20241014144622.876731-1-david@redhat.com>
 <20241014144622.876731-3-david@redhat.com>
 <20241014180410.10447-C-hca@linux.ibm.com>
 <78e8794a-d89f-4ded-b102-afc7cea20d1d@redhat.com>
 <20241015081212.7641-A-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241015081212.7641-A-hca@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.24 10:12, Heiko Carstens wrote:
> On Mon, Oct 14, 2024 at 09:35:27PM +0200, David Hildenbrand wrote:
>> On 14.10.24 20:04, Heiko Carstens wrote:
>>> On Mon, Oct 14, 2024 at 04:46:14PM +0200, David Hildenbrand wrote:
>>> If so, it would be nice to document that too; but that is not
>>> necessarily your problem.
>>
>> I can squash:
>>
>> diff --git a/Documentation/virt/kvm/s390/s390-diag.rst b/Documentation/virt/kvm/s390/s390-diag.rst
>> index d9b7c6cbc99e..48a326d41cc0 100644
>> --- a/Documentation/virt/kvm/s390/s390-diag.rst
>> +++ b/Documentation/virt/kvm/s390/s390-diag.rst
>> @@ -50,6 +50,9 @@ Upon completion of the DIAGNOSE instruction, general register 2 contains
>>   the function's return code, which is either a return code or a subcode
>>   specific value.
>> +If the specified subfunction is not supported, a SPECIFICATION exception
>> +will be triggered.
>> +
> 
> Looks good. Thanks!
> 
>>> I guess we won't see too many new diag 500 subcodes, or would it make
>>> sense to implement some query subcode?
>>
>> In the context of STORAGE LIMIT, a "query" subfunction is not really beneficial:
>>
>> it's either one invocation of "query", conditionally followed by one invocation of "STORAGE LIMIT"
>> vs. one invocation of "STORAGE LIMIT".
>>
>> Once there might be a bunch of other subfunctions, a "query" might make more sense.
> 
> "If only there would be a query subcode available, so that the program
> check handling would not be necessary; but in particular my new subcode
> is not worth adding it" :)
> 
> Anyway, I do not care too much.
> 

Okay, I see your point: it would allow for removing the program check 
handling from the STORAGE LIMIT invocation.

... if only we wouldn't need the exact same program check handling for 
the new query subfunction :P

-- 
Cheers,

David / dhildenb

