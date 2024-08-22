Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4617A588
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320793; cv=none; b=SHmijDl0Yxb2lF3CTaiW3QuKa4W3TtUwnFnK3z6xAIWXQZN/pIsDhmg/S2K/JEPKUT4Cd9fvu1lTtJneGXRAqL/VVwKfA1mEtsvAMarkv5nmVwfiQ9c47su3jwLaPLU13NoIJLsGA5w/48duyfB9PWJG8dyiVXMG0z3gAabxsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320793; c=relaxed/simple;
	bh=hljjcfvO6guBypc/UH3mH8+Gd2bqWG5xM1WaJeV5tH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzSe80GiYEgOBNaGQT259md+jEPwYa3dGgbdQHuhEvxtbboGLZ1kXPzMpVgFULMqmzHIx36by1zP+LbVzPKmTdW/9n2CW8m7O93XJe1UWII4Wb/9ENGilPJdXghT0Z94dQ0hMJcDaxi34HcSVuBx2QIKKQDbk9vc8SdL9jfUfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VUjtdGzt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VUjtdGzt"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso909521a12.3
        for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724320790; x=1724925590; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tv7GaxAkfEXQ8t05QJop9VA8odfl8zw22YqBDqgXCEg=;
        b=VUjtdGztNTwuv6EN3mBcYmjDF3ePWAIPMhUgF8lG3InI0uYDKZ0t/f8h11/y+nv7A/
         kA6YV4mr+FrBosGzd2JnU2g8R7KEyOomOwshDeQWnD0/XzNPaEVKzczoVFPq5kRHYs10
         BGTJy0Q9f/e1JkcuXIXFmhr0AEzX8KZImg9aUQPNGniK/vr6mOkRwHi73pZb1aPgrXMc
         TZG5Q2V+d5A1TNiNk+APHHtn5WMc8u9h4xSoIvonX6fk649G0GPWroQtzquYzXpu5KYi
         fJIb4qNJQ0m4STXAWIhuoN1gk99+Hvrvu9Zo9O0V28MUZybafmiGwtswMgKcdETOa9LK
         mOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724320790; x=1724925590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv7GaxAkfEXQ8t05QJop9VA8odfl8zw22YqBDqgXCEg=;
        b=W4XaKNSzKfd8lAIQQlsP6qeTQsm/d/kYh3F9TBisNiFr0lMCqRttfd0L2y8isC6CmE
         gJaAsYZg6rHbUjmetJfkzpwdbaEnsGkhXbZckR3UCCdDdQZ8mZAkEeh7RVGjWFO1HU2P
         sWGE+TA+gHI7uRDEkVANMvGLX+aSu+A/o9Y/3W8qtWt4yxVLVR3bcnZqdSJGyYgPGEIC
         m8E14A5KRgxvgogVsX7bI2mNhKDiHLhKCLLXtJADuM/2mSLY8WXQQimi8dKKuWbf4x0R
         csn+kY6wIxhtN9zNbcSy/BLKv4qoizNf2dKLW4iat6GvAzni3vKNhcntBjCs4VK6gKnD
         hbIg==
X-Forwarded-Encrypted: i=1; AJvYcCXBKIU4JSzxeJiAmWRMzSOclo4sdkao/ZKqPSEr0Iq9DS5n7Uc79En9AIaCKYJAF1G8CgfClLXM0Fjc208J1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4ox3vw7kIaLBB0+7pmgPHkTXLhb4qacNDkPf9lZKgE/Ln+qa5
	DomTUf08s5wGOAJoYmAj8CdxleOfJf/H2qwOST4Mr3RkMh5+PjMykTQidPgHs8I=
X-Google-Smtp-Source: AGHT+IEioMDSqzHxeIyA549xZj6oJ57Up3qdoEvMcpWaU7wkOdZ75ysLz+JQ+fY4goZiA8CF4a2E2Q==
X-Received: by 2002:a17:907:788:b0:a72:8762:1f5d with SMTP id a640c23a62f3a-a866f8f5165mr328213566b.55.1724320789998;
        Thu, 22 Aug 2024 02:59:49 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f433671sm94947366b.128.2024.08.22.02.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:59:49 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:59:48 +0200
From: Michal Hocko <mhocko@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZscMFIf2H-SlCcsS@tiehlicka>
References: <CAHk-=wgmHOrhCGU=vOkcsZy5rE0rRZcH2U0zg6HkJxzxUEJgTA@mail.gmail.com>
 <CAHk-=wiNCkgsrdNii7EwEXjt_47wF7YBJYWMhdsZJS8yVFDR=Q@mail.gmail.com>
 <ZsbtGClLMtaeakdo@tiehlicka>
 <CAGsJ_4zM4tACW=8FrEVF6fhwke5BLHCXOb0O3xBoVsF9Rb7+9w@mail.gmail.com>
 <Zsb1rM-azd_0gFzg@tiehlicka>
 <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <CAHk-=wjugWbyu3NoZz8AUpUGD4vb9H69X30t5WXWW5Q_bYJ4eA@mail.gmail.com>
 <ZscF4SQzxKv9evmR@tiehlicka>
 <CAHk-=wh-pXKU_+EPMLgdaK62s8Zp3zhcCBtYLDR=LUQqWAUHNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-pXKU_+EPMLgdaK62s8Zp3zhcCBtYLDR=LUQqWAUHNw@mail.gmail.com>

On Thu 22-08-24 17:44:22, Linus Torvalds wrote:
[...]
> And dammit, those kvmalloc() sizes need to be limited too. A number
> like 24kB was mentioned. That sounds fine. Maybe even 64kB. But make
> it *SMALL*.

I am not particularly bothered by exact size for kvmalloc. There should
be a limit all right, but whether that is 1MB or 64kB shouldn't make
much of a difference because we do use 4kB pages to back those
allocations anyway. Sure 32b is a different story because the vmalloc
space itself is a scarce resource but do we care about those?

> And make it clear that it will return NULL if somebody misuses it.

What do you expect users do with the return value then?

-- 
Michal Hocko
SUSE Labs
