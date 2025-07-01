Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873A26CE10
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372988; cv=none; b=oYRhew8eXEo5aiGClqxjdoxl4sc4H1hpOj78hd51g+BGmXv1BMY/+brnvNI1dLPrfFqerLldb9wQsL4YpACp+xAIFkZujBe1aoAO2Qxl9aqHS200zxbo2WPYhS3+4puAuGi6U1Ot9ZRD+ACylpEoFIIlj/Q9usbS+ck+v0hPlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372988; c=relaxed/simple;
	bh=HA/IaYAtviTzbiEGMrzWF/n5gDTxFeZ2JLbcBiPxXXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCecBPQOcAgI9d1aH8b174+rJM91OrZExVdoC/OqSo7qQi9LyCklvH7MISAsX2yiqx7x+jTmxj7thEIKMSPyXFHUhULrLbJjYaciaVP7Q9QicqqWzH6fuj5hLT9DCJ85MAYvWveateOAmoUKfjXkas6bP/kF3AiP5saUUatAUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+XFP51X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+XFP51X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751372986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TrbuVM+ppzwgXrUIdBEtP31BskfLOvpW3vqC5pXRcG0=;
	b=H+XFP51XMXNiVBVRKduFIYtRMcpYgBuvGf1RlVIUZA8CbkMgQdLbG6XMkWru8JlrttEliU
	HxnEhKitQjNK+AUXN53jFTyJWQJrYaX0GyG7pZemaw8h/tmBxZWNXM88HE7c8132N5XsCc
	Rg0QY2AVBmaZyyum++sBO1SPwKmx7Nw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-MTN9xzxjNOerUDHMYkaNiA-1; Tue, 01 Jul 2025 08:29:43 -0400
X-MC-Unique: MTN9xzxjNOerUDHMYkaNiA-1
X-Mimecast-MFC-AGG-ID: MTN9xzxjNOerUDHMYkaNiA_1751372982
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45311704cdbso22018555e9.1
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 05:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372982; x=1751977782;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TrbuVM+ppzwgXrUIdBEtP31BskfLOvpW3vqC5pXRcG0=;
        b=Jjnk8S+O3+wN0hIs35YXfCv9d0/CtFXnTkj/yaxHGb+DUuX7YzqEciELVUWN3TBlLI
         2KpE2kdvY/c21b9m7kMcLAyC8kGU+eV2QcvyfmJ98YmIBlh7dM5AXKOKLl8IYrO7vzhP
         Xq+eeEgzd8On072DUtXYX9eYxTbzezHY9xvitbmj8CUZ7eB3Uo8YK3yJaOaTlHjir7Sg
         k83fdrlG0Mg+kDW0SBmjgBnZ8DUGMYUuU06GoOI8NE++m9JePU5j5+sgEsR35dCv08cL
         6EJq4MHeuXPaNvsIuH46Ny5KqkSKukF/7YuA89UbSdzAPSL6Q66+1Exr7pvCo7enUbO6
         W/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9GE8vixuhIY1a08sm5oIgLCdiyIidnjw5seDcnMrKaBZkY1N7Pu5MRNuaMychSIwC9RlUwAR942NPZ+DzwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBVDpeFCR3IXRaL9eeklbt84sMmmiT4+wGKumaVw6u7nUtZBi/
	cvIM37ml7RbIkgwnUz2VFvdRrG5Lo5skY8rqB7yi0gG3pveAhhqD63UMPzcGPBAYZv3/iJLY3up
	qdnpAErwXzrYXvTKbvcVRjGmfHPRH273FqmA+Sf80w28ZVLdyKzEa2POcas66Ese3sR4B9lIWR0
	W+QMc=
X-Gm-Gg: ASbGncubydLsX01lcjbeeN3a4pIMVHP39kHl9hfSQ9FUFJS8kxzWD+O/TcoXMknNoGg
	+HjksY8J7sb2tfDu/K1rapZJ/NhUL3tw0TJUEVEp4dGCtOHPtAZILxjAHPULWi80FXxuDTdXNY+
	LmMFOC/t+vXZlDlV9JYCPu7e+IlnqFB5JTeZWXBXwn/1HJRDi6oMUzv/y33KSL6+oM78PD0TkGG
	8jFP1DSFPF4ScFLjq2q3DRBB5aAavuY2sKoZwRgxF3q/mhsYfSvv753Gs6HIsvRzLTvmAgnflwE
	XJaPXz14G0whODXeIV3FneAf377MNaUM379kktOIBbTv1DSqDAGw0XV4SCxu1KNSylC260te0KI
	xLpuXqCwKYLBceGO+cQKhonzPbL+p4J/rC8OJYEhBshBHKc98zw==
X-Received: by 2002:a05:600c:470a:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-4538ee5d02dmr227232695e9.10.1751372981750;
        Tue, 01 Jul 2025 05:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWGLUM6qAW2QhCkuZ0jAVZEDYU8qdTgiLFCHykWjvjhd9I7XaZDJCAwUz6gENIyzN0qXG81w==
X-Received: by 2002:a05:600c:470a:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-4538ee5d02dmr227232065e9.10.1751372981213;
        Tue, 01 Jul 2025 05:29:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c42e1sm193198075e9.37.2025.07.01.05.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:29:40 -0700 (PDT)
Message-ID: <c476d5e6-8b4a-44ab-91aa-c4cb95a46d62@redhat.com>
Date: Tue, 1 Jul 2025 14:29:38 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/29] mm: rename __PageMovable() to
 page_has_movable_ops()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-17-david@redhat.com>
 <9a6b403e-ac92-4e4a-8d72-86dade5b9653@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9a6b403e-ac92-4e4a-8d72-86dade5b9653@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j6uBsDitz-nIIxtX2_IcOffaETkSVnzoFDq7Bm1F2Jg_1751372982
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 12:59, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:57PM +0200, David Hildenbrand wrote:
>> Let's make it clearer that we are talking about movable_ops pages.
>>
>> While at it, convert a VM_BUG_ON to a VM_WARN_ON_ONCE_PAGE.
> 
> <3
> 
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Great, love it.
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> I noticed that the Simplified Chinese documentation has references for this, but
> again we have to defer to somebody fluent in this of course!
> 
> but also in mm/memory_hotplug.c in scan_movable_pages():
> 
> 		/*
> 		 * PageOffline() pages that are not marked __PageMovable() and
> 
> Trivial one but might be worth fixing that up also?

Ah, yes, missed that, burried under the the Chinese doc occurrences.

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5fad126949d08..69a636e20f7bb 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1763,7 +1763,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
                         goto found;
  
                 /*
-                * PageOffline() pages that are not marked __PageMovable() and
+                * PageOffline() pages that do not have movable_ops and
                  * have a reference count > 0 (after MEM_GOING_OFFLINE) are
                  * definitely unmovable. If their reference count would be 0,
                  * they could at least be skipped when offlining memory.


-- 
Cheers,

David / dhildenb

