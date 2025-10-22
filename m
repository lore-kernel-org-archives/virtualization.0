Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46A231836
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122281; cv=none; b=o4Yb2V9uIdjwZAZI/NvKMkPmeRgAUz+uuJor9UQlmXehc1kehfcxLjaXs/uuvwTOWvdK51vj2D7lUrrzREknh02s/ZpQo1fN3w4rSODAMnZD5Afnu+DHerOkXmR9ZT/Sd7ok1PYHYABdOhYuhEWYrcMy7yN+mkdySoP+/UWonEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122281; c=relaxed/simple;
	bh=6fqZnvdBCBsePVwAsDuE2G7gXV28Iy/+ugq1JzsiDCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plCqaTnQtqsNZEUbYWZ00MZi8MP6k5THI7BmH53oDdgFAXJ/VxwbP4pzb5sN2HtVq75WaGV6gRHl8tXRr3Yo2yy5iwVf/r/VA4P5ENPj3AlZlSXp323ItlRIAdsZkwlXw5V9tro5eJU443cCrLzG97tKkAFClnvzX7lnzZYageY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8kQSL5F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8kQSL5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761122279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HORYs91dLQQexQDsveH7tAbNx9ev00vg3VpMbAGTK3I=;
	b=b8kQSL5FciQ3K6ACiLOeas4zkEkQi4ZUJCgqCo7jLvSLxBOnFXBkm+TLdsRIaB3Zo8zs3c
	yD4juoQQ7d+UH+zpgG6Stq19QAcQY8hV3MsjgEpWEsA+bKdeVewU0rm38SNtoxrttwRopX
	ksDV2oFV3DZ3yjhPyxFJ1tzh9Te8Zjs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-2ES1uwyjPoa8CRhYCHkiJw-1; Wed, 22 Oct 2025 04:37:57 -0400
X-MC-Unique: 2ES1uwyjPoa8CRhYCHkiJw-1
X-Mimecast-MFC-AGG-ID: 2ES1uwyjPoa8CRhYCHkiJw_1761122277
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso3601325e9.0
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 01:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122276; x=1761727076;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HORYs91dLQQexQDsveH7tAbNx9ev00vg3VpMbAGTK3I=;
        b=ry1bENgaAcCEtGPmYuaLHeB69823VtdhW0+HJpNr6/qNuBnr7637EopYMXiauVlAhN
         Ow8+P9LNoQ9/1crYb9WUwkgXdPDyZuJrRvFMaHehBLAsmyo1jFird2Pob4zzLhWhVyiX
         NIkQF8Q7zovaLzo1zcuoOu1rTS9jWH1QXKXVqOG8s+WjM7ltnQ5us9B3QxC8589eu6js
         DtQbry/675WH0SZuQ4CWCGRHSnzEXEYb538fFrjmfNTrE3hsLeLmHttZXtublm3K+W4j
         WhMa9XhzDWkmtgIrTbQGITocp8q4mhp8/f4X4xutdVMDOjHbnCEZf0VPDy425nTB70WV
         aY9w==
X-Forwarded-Encrypted: i=1; AJvYcCVbDl+JiWuOaDvmDYVkM0LXO8nQDbn6fXJXfNXZxQCSbMr/mRdKK4k5jyk6AyFc26RaZEG+1zFmrWFeas0fBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhEdDz2Y0OejDACCmE+AASuzcvjbx7t9f4QdaOhHOaQ2UPb8ce
	XhKSVb/76oO9hleuyJ0c/xDUBgfc6FrmAEWZOxxfQUASeoo0XjoY/4xBGrO5RFypPbWae48rWx+
	hIBY0vQTcXhAqMeDFVyA7FLRMlA6FkvTWia21Z4NL8FrXUMUsNFf66PyWTHOxkHiyNaE4
X-Gm-Gg: ASbGncvL3kVlwbg15zxduOZuUCOmUKJ6XC4GjDA4jQdZ7rQMnk+zre9mOObOwqaZXRb
	hyQX4VzKKqgRYhPTaCqjBzH7ER/SqgFxuwhqiDPv0dzaT8a6xZ1HMenJw77PLFeha4A+H/vPPJv
	WaFPVQlQ5kG6X6XS+PZ1979jnRhI6TUcTFNn2wrYclcFCFQ/vg/YxoDIY6FSJ+I4lVAr6/oaZkB
	Unox+itqcDtrmUPwRzAAbDf8Lkym9IjPOYy8u7rUG1IJiCLK9xB8sDz2c3P/vnBfZLDVh6JUBd1
	7qOI7MsMmOWTx5dNXiTJFoNC37ntZiho+uIq+TomXcyJ0+b0+Jx9IV3KVazQYr5A8ktjpbZgXkz
	qPJL9PA6J98L5+OPqoZQBx4Jt9vjnM8IlwefKDQnPhjsHNkiWptdFVwpDTfuVEDWwF+Z7L47mvF
	pFdbSIJZiD7YQdiJDuTB0EVl6vys4=
X-Received: by 2002:a05:600c:8b17:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-475c3fe35f4mr18215315e9.16.1761122276473;
        Wed, 22 Oct 2025 01:37:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZox5bLuD2Cm8JqdEWshafSicQuJ3K5TI0WpKQPM9/qTM/uKldxHeAV/RdhcTW+7Drr2Molg==
X-Received: by 2002:a05:600c:8b17:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-475c3fe35f4mr18214965e9.16.1761122276037;
        Wed, 22 Oct 2025 01:37:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428a534sm37256955e9.6.2025.10.22.01.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:37:55 -0700 (PDT)
Message-ID: <2fa9f196-12e4-4c1a-a1f7-cfdded93cc94@redhat.com>
Date: Wed, 22 Oct 2025 10:37:53 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/23] mm/balloon_compaction: centralize basic page
 migration handling
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-5-david@redhat.com>
 <20251021164916-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251021164916-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C-9nbB6ZbKdvpEp1nqho2lhoHaZuMGc-PnNMoqrHLo0_1761122277
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 22:50, Michael S. Tsirkin wrote:
> On Tue, Oct 21, 2025 at 02:59:09PM +0200, David Hildenbrand wrote:
>> Let's update the balloon page references, the balloon page list, the
>> BALLOON_MIGRATE counter and the isolated-pages counter in
>> balloon_page_migrate(), after letting the balloon->migratepage()
>> callback deal with the actual inflation+deflation.
>>
>> Note that we now perform the balloon list modifications outside of any
>> implementation-specific locks: which is fine, there is nothing special
>> about these page actions that the lock would be protecting.
>>
>> The old page is already no longer in the list (isolated) and the new page
>> is not yet in the list.
>>
>> Let's use -ENOENT to communicate the special "inflation of new page
>> failed after already deflating the old page" to balloon_page_migrate() so
>> it can handle it accordingly.
>>
>> While at it, rename balloon->b_dev_info to make it mach the other
> 
> match

Thanks!

-- 
Cheers

David / dhildenb

