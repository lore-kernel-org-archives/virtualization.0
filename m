Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E91F61C
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772028; cv=none; b=IDpi2j8kRXoitKCy1/akRWFYFl6W1aV6aUWQqgMduHaoYeCeGzPcECw9usQ0T0VcGSUVby7Gbx+xa35GcYBTmVrVjiLi815+Y4VKx7yAwcDEE6/WRn1DdE2LDVgxtgSAIS0czLTm6yBvJ2TpSfn+rL4SASEvHGmVtVb57zCGwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772028; c=relaxed/simple;
	bh=A/M54EsLbdpEhtTAZGHPIjfGvTW/Os6fVYqjTxlwATg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cr/D3mSyaxdkA0Ct4RP9f0NWDG/Q2MJ7xpwjeDkBYiVklC1SXQ/sGzZisi9uA82yQENrJiGdWer9dkexzdsVuwIiMtGm7Ju6WxvLSMkw0WglM2S3M7M9M6CNmq5IG5xEOeYUI2HEkZPWX38SkU82LOm831srZQ5ddo+sn5AX0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9XhJ0+q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9XhJ0+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713772025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tAe+40gLKBnN7tnSK2raXsnb43veTPVq2GfkuOlipxU=;
	b=R9XhJ0+q1Olv6NMJMfUnLv8H61TJN0JtDfnsrx1gaY27gPjuwhJajpp9GVAkkJz9KqyVNK
	8INhBg6unO8cIxOvyS4O3IRkQPXEhFhwl8xX9qvFWdAArc/FzXCo7qmJ4EzoqbQNkUqycA
	VKMaULJxKqycr2TUNP9TFB9xWxK9iak=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-iqnRQLboNyGsWfjRyqEvtA-1; Mon, 22 Apr 2024 03:47:04 -0400
X-MC-Unique: iqnRQLboNyGsWfjRyqEvtA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d8781cabdaso30124931fa.2
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 00:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713772023; x=1714376823;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAe+40gLKBnN7tnSK2raXsnb43veTPVq2GfkuOlipxU=;
        b=TP1xLOL/wQ+YU3rZfoGLKB9uCr2G+WC+zUCMkTS/SFjT3cUI+439OGxXCXHfqF1VMr
         aKN6p1nn8/J3EvnbFTvVehvrZbGTAokCJLonPLFViN0FfToytUk0E2095aC+VyPPLUwp
         3OZJ0H/BxPqU0omhT4ihSr3A75pgdCFy6ItsRuzrl0DP3/okAwUwCXfABYt7LqGFWi61
         fGrK2rS6C3PT28vl4KZDFBCenk6okxpVGcq64A57g3KmmjQv3NZkaQh/dgZoAd8rLw++
         iC7i04m0mdgYERAtSPZBjBxckUGNotf53s8IRSoIycRWb374uXBL0JAFXXjB1kWf0gbo
         Iu4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJBYI874xxwJES1BQdyDAWmEQyL1hhaUEBY2SQEW5/+ZfBEU5vTDgEfTwdWSe5L/FzoTvJKtpmAJ2cA20KuvqJmoQMkiPz4bx4aybsMsA=
X-Gm-Message-State: AOJu0Yxkxv126fF5jUwUeGrEJkvmLLmGFQOimk1tmlgbxlKSm6ZdUafR
	qL8yYF52TZ4xzRvOXqQwD8E9BQh86QU2KPqMn+A4XQXu8M2ddJF//BJ6haaaw5t9qsE4NRKZS1N
	XgKecUje5fvhv9loHdNuUl7PnqOGtTHj7fraocIk4lrgem1zSb0snsG3VkczRbBCE
X-Received: by 2002:a2e:b5ac:0:b0:2dc:bd75:41ba with SMTP id f12-20020a2eb5ac000000b002dcbd7541bamr5950595ljn.27.1713772022973;
        Mon, 22 Apr 2024 00:47:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAo1tqA3ykY5PLpoGeei9qubge/Lf9gIc39igTsHUTz7zUKCNO9PFKrc8emn8mdTr0kj8JWA==
X-Received: by 2002:a2e:b5ac:0:b0:2dc:bd75:41ba with SMTP id f12-20020a2eb5ac000000b002dcbd7541bamr5950582ljn.27.1713772022432;
        Mon, 22 Apr 2024 00:47:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c190a00b00418a9961c47sm15670401wmq.47.2024.04.22.00.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:47:01 -0700 (PDT)
Message-ID: <6a182645-1f7f-4b7d-a16a-36e9b1684c58@redhat.com>
Date: Mon, 22 Apr 2024 09:47:00 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio_balloon: separate vm events into a function
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
 <20240422074254.1440457-2-pizhenwei@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240422074254.1440457-2-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.24 09:42, zhenwei pi wrote:
> All the VM events related statistics have dependence on
> 'CONFIG_VM_EVENT_COUNTERS', once any stack variable is required by any
> VM events in future, we would have codes like:
>   #ifdef CONFIG_VM_EVENT_COUNTERS
>        unsigned long foo;
>   #endif
>        ...
>   #ifdef CONFIG_VM_EVENT_COUNTERS
>        foo = events[XXX] + events[YYY];
>        update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
>   #endif
> 
> Separate vm events into a single function, also remove

Why not simply use __maybe_unused for that variable?

-- 
Cheers,

David / dhildenb

