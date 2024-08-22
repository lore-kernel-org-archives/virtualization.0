Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475D1C6B5
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315959; cv=none; b=mOHdFYiGCKqcXMdH9ImFGSPLjvmwK1mg48C3Lo7t2hM6f1jWDg33NqbDDSOIt9na4mOA/y/KjK2azPP5jZ1Z869yA/OWZ9yTs6ZAboz/gBG/JRu6cXVffTcQjAfrgrEX7xTktN3fNI6CLCYtfumz6nQxhMpbfLsOlpg7kCytwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315959; c=relaxed/simple;
	bh=R75ZZZtPHq4kE8tTwUwgYSSSGIjft5RsP0QIHrOEEpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mo/MMBpy8gFEAr3QW8yG6sVeWoExUh9AfGaCEfqeE+7BAcA5zca9NRpxDqtMuhts3MFHtKt5+mXXX3XeUB/KyCA7Siy8QkGBtKWHRetDq72LzHCh9wcA3sjsHF0hrz437i+IcC8+/1hCX8TRzLXSZRDgoCU06tT6CfhMUSTeW40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCkKGPA2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCkKGPA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724315956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ct2qgnPCt6ewaR+zraifcgOE/pcTZO6oK31BUAZADaE=;
	b=fCkKGPA22N9pft5H0i9X83SgRrGHc+3jmZbOvhI3ldy+gW08+RcfJICpsJm6bB8GNl6MzM
	k4EtM26XZNoLh150Cb84Y65PQGEvkbnfrlYApk7x6FXGWpz6X0WZCtjbH+djiyNbgRonlr
	/Q3r9LYTMAo/KA7E2nMYEI/gngupJhw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-BUTLpN5JPt6zc_Rfn3y8TQ-1; Thu, 22 Aug 2024 04:39:13 -0400
X-MC-Unique: BUTLpN5JPt6zc_Rfn3y8TQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-371b28fc739so270002f8f.1
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 01:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315952; x=1724920752;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ct2qgnPCt6ewaR+zraifcgOE/pcTZO6oK31BUAZADaE=;
        b=ehRe489tNK5FH3+pweqdCNaVe/Qz4ubXzh6enjUENys+MkbCh4uFR7brEhDsG9P/QX
         gRyRGFZMiZYkqIJUa7oAmLoaxKQiHvJP4fW2XMSaOQemI6WKZMEEyWQfJeeOBcKkwOsV
         Gi5aQYEUSBwAjp/cUI0ZADj7oZiHXuRBRSjtOflSAo8Wg+H2VhB1/E+r+hHR4BZtvibl
         gkvtTGHtNIvdv2rWtU7GA76uG5q0eqQJfITOFPPWknM3p5CrTL2oPNflhurWFSTYRewO
         RgoAz7+AIYL8p3N4LUn2Wwb2kELcY5l79hfMtRhsVBA6XfHllT+1uaJM0iTYXXDh15t2
         EAqg==
X-Forwarded-Encrypted: i=1; AJvYcCUWNlm1f53NUYuUzQTW67yPeeLDJPNJmpG171LSpKF3vwyypLK9HJNAMk19qtj22NjIltlotSMphD6wWmTtmg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjMorwL8LYLDHN/gt1v8/XDi32/QU2kQUWB0hRJAxSQE70ukDu
	jEHygrOfTJEzeHCmHNSuggWmJ5LntGoSvpTuOjatMnf58Ibz96roaz+atR2pCtiJ7lsFyBRCayY
	X1kEr8JORCW+JMV7jCHICoukXMnE4AQdZDzEfBNnIzZYUIWDDXuekFypZIQ+M0EK+
X-Received: by 2002:a05:6000:1b0f:b0:366:dee6:a9ea with SMTP id ffacd0b85a97d-373052dbfedmr1309542f8f.26.1724315952386;
        Thu, 22 Aug 2024 01:39:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyW51WfIMnOusJZRn84Z6nhmbsGct0jVguAsB3K28MEo1sWWFRd3JWZjODH8WvRWREUG9nLQ==
X-Received: by 2002:a05:6000:1b0f:b0:366:dee6:a9ea with SMTP id ffacd0b85a97d-373052dbfedmr1309495f8f.26.1724315951487;
        Thu, 22 Aug 2024 01:39:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:2b00:f928:47d8:c9be:9d87? (p200300cbc70f2b00f92847d8c9be9d87.dip0.t-ipconnect.de. [2003:cb:c70f:2b00:f928:47d8:c9be:9d87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac516252asm16475245e9.26.2024.08.22.01.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 01:39:11 -0700 (PDT)
Message-ID: <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
Date: Thu, 22 Aug 2024 10:39:09 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
To: Michal Hocko <mhocko@suse.com>, Barry Song <21cnbao@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
 v-songbaohua@oppo.com, vbabka@suse.cz, virtualization@lists.linux.dev
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <7050deab-e99c-4c83-b7b9-b5dad42f4e95@redhat.com>
 <CAHk-=wgv2-=Bm16Gtn5XHWj9J6xiqriV56yamU+iG07YrN28SQ@mail.gmail.com>
 <CALOAHbDP9d6GNNhjB30zKiaMh_HvToKDGZ3sO9tkxRu5+HpEZQ@mail.gmail.com>
 <CAHk-=wi9Z4QmmfeYo6aynRFbCA-_+FG83HYxXz2wVWfxjPyXSA@mail.gmail.com>
 <ZsbY5pNhDqGoxJG_@tiehlicka>
 <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zsb1rM-azd_0gFzg@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.24 10:24, Michal Hocko wrote:
> On Thu 22-08-24 19:57:41, Barry Song wrote:
>> Regarding the concern about 'leaving locks
>> behind' you have in that subthread,  I believe there's no difference
>> when returning NULL, as it could still leave locks behind but offers
>> a chance for the calling process to avoid an immediate crash.
> 
> Yes, I have mentioned this risk just for completeness. Without having
> some sort of unwinding mechanism we are doomed to not be able to handle
> this.
> 
> The sole difference between just returning NULL and OOPsing rigth away
> is that the former is not guaranteed to happen and the caller can cause
> an actual harm by derefering non-oopsing addressed close to 0 which
> would be a) much harder to find out b) could cause much more damage than
> killing the context right away.
> 
> Besides that I believe we have many BUG_ON users which would really
> prefer to just call the current context instead, they just do not have
> means to do that so OOPS_ON could be a safer way to stop bad users and
> reduce the number of BUG_ONs as well.

To me that sounds better as well, but I was also wondering if it's easy 
to implement or easy to assemble from existing pieces.


Linus has a point that "retry forever" can also be nasty. I think the 
important part here is, though, that we report sufficient information 
(stacktrace), such that the problem can be debugged reasonably well, and 
not just having a locked-up system.

But then the question is: does it really make sense to differentiate 
difference between an NOFAIL allocation under memory pressure of 
MAX_ORDER compared to MAX_ORDER+1 (Linus also touched on that)? It could 
well take minutes/hours/days to satisfy a very large NOFAIL allocation. 
So callers should be prepared to run into effective lockups ... :/

NOFAIL shouldn't exist, or at least not used to that degree.

I am to blame myself, I made use of it in kernel/resource.c, where there 
is no turning back when completed memory unplug to 99% (even having 
freed the vmemmap), but then we might have to allocate a new node in the 
resource tree, when having to split an existing one. Maybe there would 
be ways to preallocate before starting memory unplug, or to pre-split ...

But then again, sizeof(struct resource) is probably so small that it 
likely would never fail.

-- 
Cheers,

David / dhildenb

