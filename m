Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA586F2F5
	for <virtualization@lists.linux.dev>; Mon, 10 Jun 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009785; cv=none; b=cgGyLTLeXybtgMkUpYLpVyZddSah2LH+aVRRahDTYkQNMDao9WOA76LrlaGZxe3mHpIRMxLoyRr+1d/RDj72XdvWMSo1oQdalUHvlIZrL8U8YYNAxBmg0gMLrb/8yaq7zhcQ7v419KRj9h5DMrSXHt12tx3VCraff/5jH8KN5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009785; c=relaxed/simple;
	bh=XdPHSSBfm5w8usMR100ncXe5bZyqxqI8EspulDU0vWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OG5lq0XBjhSosoH6P7nQ910zPQtXGSKnb19NUHTjQl+GAsgITaPQgKdMj3YMVwrl13u5Lf/MipP4/77ALegmiR6SICABQg0CC/IrH2Y7kIlDec4HP32QsUtqKeyVwqo4EdUqmU2o+jvOqne+zbUJZ0PEh5BSdJ22gLA801gutTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMif7zRg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMif7zRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718009782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QUbORrAp1NZZYf9SPcpO+7DjP/I7StvG/pRCPWB4lqg=;
	b=RMif7zRgnLO9WMJD8iAc0qaQ+PM+HlhqITH72708T6Z9PbbHcVREBpcPJb2s2y/kWcnlZf
	Axj2ZXOkAKG3NIdOuegDiJ3NuqrXXKQkw0S/P67/zehODr1IAKtmaUq39Y3CWtKXR1IPNO
	sZeo+F8LWpxYLgSmcKv0cUrS3qlztyM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-PL7Z4Gq9Oty1CM2ovaK4iA-1; Mon, 10 Jun 2024 04:56:21 -0400
X-MC-Unique: PL7Z4Gq9Oty1CM2ovaK4iA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4216dbadb75so15926815e9.3
        for <virtualization@lists.linux.dev>; Mon, 10 Jun 2024 01:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718009780; x=1718614580;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QUbORrAp1NZZYf9SPcpO+7DjP/I7StvG/pRCPWB4lqg=;
        b=aTCsgOhYwq1sJ1nx0SBcetURsRr4sxAuCvrNYi+eueP2uYLYkyz4E5BCjyzKqN05ZS
         PxYrPOlSiMiJDsh11ihnBfeQQ60mjdYzdDzfzJwpOw4sNtaq7tqZA7hTbgrClLsQc5xF
         VxiyBiDgJCFt1wTJDQYqhhmhPJSO2jBUv1qszaBjHueN1fVTxCC9gy0s9fShZa4MHuvX
         lde3DaBpabUm8J3N6BiuSvrs2g155gr/4G1FHaSdjMum5pbRcoc6i0FtdBtPWB/aW2mA
         hhHoY/2ZfoeCrliFT3gPbfsRvM7llAt96/ICL63lGxxx6JgBtMhD+i6hm1DskYTC1fve
         7rXg==
X-Forwarded-Encrypted: i=1; AJvYcCVkVvAyM5dcxqp7r+lCR7+xLut1Ij4eo+drYXixATYPBkyOXs/yBubqjV9a66x2IPhashrweD8OlxC9Y3tw+8wEJRu3vaa0jEuIszeksOc=
X-Gm-Message-State: AOJu0Ywwa4SlJxnNUwi4oM5KBsqtIY/Q09GuyMfgeWw8CbR33PAe3Y/l
	2xlqGYrziO6DZuL/VMbfkven+kXIm5qR55d0ucuporugB0nxQ1b++WqoMd5y1M7/cRT3aHdvYhm
	F/rJfDoQ3sMJUCOx8dhcnFARphxQdUVqasuFlh5DikB+JMpdJKpkqVEw1YNPcV6xI
X-Received: by 2002:a05:600c:4f84:b0:421:80d2:9db1 with SMTP id 5b1f17b1804b1-42180d2a37emr34136925e9.25.1718009780258;
        Mon, 10 Jun 2024 01:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCzA4qbOZu38eWA7pCHPb8vQSRCDdVK9WMYWcHk2kUSDfS7dx+PhewtKS0ZxiqzH3kwbKdyQ==
X-Received: by 2002:a05:600c:4f84:b0:421:80d2:9db1 with SMTP id 5b1f17b1804b1-42180d2a37emr34136735e9.25.1718009779932;
        Mon, 10 Jun 2024 01:56:19 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c1aa2f7sm133235285e9.14.2024.06.10.01.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:56:19 -0700 (PDT)
Message-ID: <aa370847-14a6-4806-8a04-d2da0a591014@redhat.com>
Date: Mon, 10 Jun 2024 10:56:18 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] mm/memory_hotplug: skip
 adjust_managed_page_count() for PageOffline() pages when offlining
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 xen-devel@lists.xenproject.org, kasan-dev@googlegroups.com,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>
References: <20240607090939.89524-1-david@redhat.com>
 <20240607090939.89524-4-david@redhat.com>
 <ZmaBGSqchtEWnqM1@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZmaBGSqchtEWnqM1@localhost.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.24 06:29, Oscar Salvador wrote:
> On Fri, Jun 07, 2024 at 11:09:38AM +0200, David Hildenbrand wrote:
>> We currently have a hack for virtio-mem in place to handle memory
>> offlining with PageOffline pages for which we already adjusted the
>> managed page count.
>>
>> Let's enlighten memory offlining code so we can get rid of that hack,
>> and document the situation.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Oscar Salvador <osalvador@suse.de>
> 

Thanks for the review!

-- 
Cheers,

David / dhildenb

