Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEFF4FC
	for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddNayLe6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704961381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FFrOhLqLHBhQK8g4tGHoyZu2BFidPN3Brloj+ylOX7k=;
	b=ddNayLe65n7Z6TbF4bc4laiB6cg/pQ9wcVi9uQePe/0mB+1ttEG1l+63znJQromcGpjWyc
	5lr3qz1qS8Lhz4JD45hXQHRjeXVxwoH5b/HZ6P5uX+PBsyPh6sLtb4ENmo+1B0uOxQU8oc
	Sz1RcgQcYKUpkwpXsyioEuTixu2xeXM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-nsHu_vwoN9eZitYgi9PwfA-1; Thu, 11 Jan 2024 03:22:59 -0500
X-MC-Unique: nsHu_vwoN9eZitYgi9PwfA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33677bbd570so3124084f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jan 2024 00:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704961378; x=1705566178;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFrOhLqLHBhQK8g4tGHoyZu2BFidPN3Brloj+ylOX7k=;
        b=hUhoLYijLMWwspdKk0aj58+T7jkc/fW/ozu9TBUnWmQ5ytTxsZlmnn3XGCPm643b9/
         J3H3ym+rq8bylKELSOFFY0dPrM6l+wgclTPPllEdZI1k/+E4NRm9meBw8iBtlVNDUNSM
         7pbwOC12f5dUe2ZqFzNI2/SpzYIGxn40MnK92vHNoL6dWw52PuDh3Edwhr5ry5TJiljG
         C7SV08AxXKw8R7Ejssr4k6pMKaup+orjHlINqmsjrn4uGLQXA+9junHbgoAgvsPfqbyn
         bITXZaURSejmwGqiQuh/5S6CYj1NrAheQ7/Q6z8NIXVWihRwtFfLgyHlX3mZrJPZCT2Y
         +uDg==
X-Gm-Message-State: AOJu0YxOaqv2mOJ1MSM33ZVNXDWJc2pXGBH6tj/dlE45LAUCgh3rOiX7
	NClMSwnLtiiG/Q3uCnv2GL1Df4zgxml5fRQaf8XdWAXZoiQArqQz6EF/7d4Gw9/p1PgSFpgajSK
	kjE0s0LL62lzWkyKEHk6LDoc1X9TedqCXA8U=
X-Received: by 2002:adf:ffc8:0:b0:337:76ae:34ca with SMTP id x8-20020adfffc8000000b0033776ae34camr400229wrs.77.1704961378409;
        Thu, 11 Jan 2024 00:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEawcpZkYtraT+cyYdKb8F1YNsa2W9psfYa7+2lJDiyznBOcY6bZt6Ki/naLMqjKzSkOlIwCg==
X-Received: by 2002:adf:ffc8:0:b0:337:76ae:34ca with SMTP id x8-20020adfffc8000000b0033776ae34camr400222wrs.77.1704961377953;
        Thu, 11 Jan 2024 00:22:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:f900:6099:1901:b863:450f? (p200300cbc747f90060991901b863450f.dip0.t-ipconnect.de. [2003:cb:c747:f900:6099:1901:b863:450f])
        by smtp.gmail.com with ESMTPSA id q2-20020a056000136200b003373fe3d345sm555704wrz.65.2024.01.11.00.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:22:57 -0800 (PST)
Message-ID: <dfb2662d-900e-4b36-b2a0-78ad7f397861@redhat.com>
Date: Thu, 11 Jan 2024 09:22:56 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver/virtio: Add Memory Balloon Support for SEV/SEV-ES
To: Zheyun Shen <szy0127@sjtu.edu.cn>, Jason Wang <jasowang@redhat.com>,
 mst <mst@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux.dev>,
 xuanzhuo <xuanzhuo@linux.alibaba.com>
References: <1824181559.1228150.1704954908335.JavaMail.zimbra@sjtu.edu.cn>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1824181559.1228150.1704954908335.JavaMail.zimbra@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> For now, SEV pins guest's memory to avoid swapping or
>>> moving ciphertext, but leading to the inhibition of
>>> Memory Ballooning.
>>>
>>> In Memory Ballooning, only guest's free pages will be relocated
>>> in balloon inflation and deflation, so the difference of plaintext
>>> doesn't matter to guest.
> 
>> This seems only true if the page is zeroed, is this true here?
> 
> Sorry, I cannot figure out why the pages should be zeroed. I think
> both host kernel and guest kernel assume that the pages are not
> zeroed and will use kzalloc or manually zero them in real applications,
> which is same as non-SEV environments.

balloon_page_alloc() will not zero the memory (no __GFP_ZERO set). Only 
in some configurations (zero-on-alloc, zero-on-free), the kernel would 
do that implicitly.

So we'd eventually be leaking secrets to the untrusted hypervisor?


> I have tested in SEV-ES, reclaiming memory by balloon inflation and reuse
> them after balloon deflation both works well with the patch. Hypervisor
> can normally give the reclaimed memory from one CVM to another, or give
> back to the origin CVM.

I'll comment on your misconception of memory overcommit separately.

-- 
Cheers,

David / dhildenb

