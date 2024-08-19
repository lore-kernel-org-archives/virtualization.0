Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB716BE27
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071692; cv=none; b=eOFYSshAkMR9QGbzxWI5xbfJqYYewlP7S6+BGPHEmq/8NOF/hju66wLww3Xo9fvQnMo/t5lBUAYIqP5SHsX3ZoFSSI+MKW3JdVBbNqpdT7EIE2/bR5uaBdzIdwpPOBFWT3NFv8ALWHVkD+B7s5FDtZr4BKg0uYoSB0jqFrE/8GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071692; c=relaxed/simple;
	bh=PvBwEcC1BLKNbg58VgJu2WEhfJTKkTGIKh8ULgIW5jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCWQ+qOgx/BhsQzXXuvPuLkylMEoBuAIwlOoVxupTHmv8lrJqeFDij49HFt3pVAsMoEb53CWSYTxlHvv1RW8h59pixAJwiyar/utLSYQv5LxXNUHc5eepIZ+RN6M/q5e3dbWl6pxJSsoJS8hS2ji8TKS7pNTFNHmcvjXYB5SPWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQlSCfzx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQlSCfzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724071689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6cnLigIF8WNHcn5SfScIsaxo8J6+32tnMuHO31dS1Wg=;
	b=BQlSCfzxiaUMc9Fc2ItP8kNcQbscTTUgfkpY7S+n4RRUXzA0+eTsJEkrGzwCp1pchXxyfN
	2XDhcnAFXQD/+RLDDMieUWKE1OLB77jd/udsBeHKQuXigBngbnkBnZ5MLFohpvgeiqqMSe
	753j+1fqq6CcL1+HhALyIcEmBbnx1wg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-PR_TcqyjMUCF5Z4BMxMO1Q-1; Mon, 19 Aug 2024 08:48:07 -0400
X-MC-Unique: PR_TcqyjMUCF5Z4BMxMO1Q-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bec367475bso4971842a12.1
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 05:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071687; x=1724676487;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6cnLigIF8WNHcn5SfScIsaxo8J6+32tnMuHO31dS1Wg=;
        b=Gb2Dj1K3Qm8mAeAVwmFO3pjCIhtfY96mFPYlzI1o1bd4GYDno+Ce+jiSLdfd1eGyS9
         TBrNrglXNoNhONWbsrDySj256hpNoqBl2Vegb2EVkpCUOjubyYZkWLE4mSAMuEcF43Z0
         s7XXakhJYCI5PoRwcDiSFLuM9nP7mHf8gzHgKtmqYr7bkONz3fsXp7Rcgu/hv7A/vDZ8
         IwyVSocm90KS9t0jsRDTbxzgreLaGcfvf2n3YEWECsJidm63g5t9khI9zM1SNyz7P5x7
         ivi6khg/qjNnSuNpMsX4YkH/GrfK7DetOoGxqCSYp1vNUQz9n1OnCh36KA2+WI3LX0hf
         JvHw==
X-Forwarded-Encrypted: i=1; AJvYcCW81rc0KqNAGpzVxOzS4OyZEZ9WkDUfB/eSwY/Xlhkox8tXGoE1L/MkBumPKsaKmoBMOmjZD7nQLrDwpDPIGvuVOnN8CyvAEiJPST1T7L8=
X-Gm-Message-State: AOJu0YzmQMs08f/nUpLGdI9uI7TF32994WLeSR7r/5m+keJpJK0xlQmp
	7w6Z6/KAtWqChNTfv83pnP9H0UD/1RXbY2SNY/k3TbFwucB70tu8tSeCE/JvZR5WYvtwPuUOJ5j
	Eor9wve1WPQwZEi4D9w8GEhAz53M75as8BXPGE8fNSF+1B9axDDbH9GEElfIX4PWt
X-Received: by 2002:a05:6402:321a:b0:58c:b2b8:31b2 with SMTP id 4fb4d7f45d1cf-5becb688bd7mr10888702a12.17.1724071686648;
        Mon, 19 Aug 2024 05:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVCpNSjERjleZbjseB16FVrb3s7+73GMssQypUoBb3CTZGcicorr2xGm4pvDfOokOwUyjUSQ==
X-Received: by 2002:a05:6402:321a:b0:58c:b2b8:31b2 with SMTP id 4fb4d7f45d1cf-5becb688bd7mr10888653a12.17.1724071686108;
        Mon, 19 Aug 2024 05:48:06 -0700 (PDT)
Received: from [100.81.188.195] (ipb218f908.dynamic.kabel-deutschland.de. [178.24.249.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bec82e5eacsm4747177a12.19.2024.08.19.05.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 05:48:05 -0700 (PDT)
Message-ID: <dde5d7f0-6229-4333-9575-b3732155a061@redhat.com>
Date: Mon, 19 Aug 2024 14:48:03 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
To: Michal Hocko <mhocko@suse.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com, hailong.liu@oppo.com,
 hch@infradead.org, iamjoonsoo.kim@lge.com, penberg@kernel.org,
 rientjes@google.com, roman.gushchin@linux.dev,
 torvalds@linux-foundation.org, urezki@gmail.com, v-songbaohua@oppo.com,
 vbabka@suse.cz, virtualization@lists.linux.dev,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-5-21cnbao@gmail.com>
 <c27716a2-3e9c-4b16-9c4b-7b7d1bee9ce9@redhat.com>
 <ZsMcMognA6DiOLW3@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZsMcMognA6DiOLW3@tiehlicka>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.24 12:19, Michal Hocko wrote:
> On Mon 19-08-24 11:44:39, David Hildenbrand wrote:
> [...]
>>>    	if (gfp_mask & __GFP_NOFAIL) {
>>>    		/*
>>> -		 * All existing users of the __GFP_NOFAIL are blockable, so warn
>>> -		 * of any new users that actually require GFP_NOWAIT
>>> +		 * All existing users of the __GFP_NOFAIL are blockable
>>> +		 * otherwise we introduce a busy loop with inside the page
>>> +		 * allocator from non-sleepable contexts
>>>    		 */
>>> -		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
>>> -			goto fail;
>>> +		BUG_ON(!can_direct_reclaim);
>>
>> No new BUG_ON(), WARN_ON_ONCE() is good enough for something that should be
>> found during ordinary testing.
> 
> Do you mean
> 	if (WARN_ON_ONCE_GFP(...))
> 		goto retry?

Not really ...

but now I read the description more carefully and I am not sure why we 
are so into throwing around BUG_ONs here, for something that is simply 
not allowed and doesn't make sense.

If __GFP_NOFAIL is documented to

"
+ * It _must_ be blockable and used together with __GFP_DIRECT_RECLAIM.
+ * It should _never_ be used in non-sleepable contexts.
"

Why not document

"__GFP_NOFAIL always implies __GFP_DIRECT_RECLAIM" and do exactly that?

-- 
Cheers,

David / dhildenb

