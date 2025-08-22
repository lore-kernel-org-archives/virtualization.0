Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392D311595
	for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871208; cv=none; b=l74hnuVXKbDtgnQitPUEf8g0Mi6Xmozi1s5/iPrYO8w5oE9UXbinIu/ympPi195SuxSLwhuXorb/N/E43M+R6CD7AmeoT+kYwMC5H5F0IkbssvL1AVB8ggNbaGGZJJkWxDS67cTcmXXHMecCmx4BBGefuICWJNwnzMp1o8YK6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871208; c=relaxed/simple;
	bh=Uf5BeT2cOeXT45NhomHkgVDa9aHp8Q7A4AmKdNga0dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2D414IYn5N99vSzYM/IeqnPL/st7/Ava++uI4ecEBUc4HEVpPr51dqA7axFXGqLnj0BoVFUSGmdm5CysGhP/K3INd/HOWq+FRI0oel9Y2NHqN/QCMfYlBFnoLGXUQ8dKom1aZdIK5C7UvMaMqdjWelr+XuXq0N1iQX9ETylhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCmjqudW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCmjqudW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755871205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K6aDoQ2nZkjhSfUgeR22UAGAXQBWHHuCN2RUasZyd3Q=;
	b=YCmjqudWouZDwcPprcsi5EiOp8baNdW4RCiornN1k+x2jAWChGhEdUNQk13Yf246OKNKBz
	H1qvkhBxVgiqApxr6pB8UCucLxfJDD5ghYXYmvGgXPORIQn7NKEfjB4yU9m2RXRf3JPonq
	axCkfMIHXPuOxnWWimVTjDuVD3t7Thk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-U3JPCZJ2PjCxKzL8QQ_5Sw-1; Fri, 22 Aug 2025 10:00:01 -0400
X-MC-Unique: U3JPCZJ2PjCxKzL8QQ_5Sw-1
X-Mimecast-MFC-AGG-ID: U3JPCZJ2PjCxKzL8QQ_5Sw_1755871201
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a256a20fcso12451405e9.2
        for <virtualization@lists.linux.dev>; Fri, 22 Aug 2025 07:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871201; x=1756476001;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6aDoQ2nZkjhSfUgeR22UAGAXQBWHHuCN2RUasZyd3Q=;
        b=iJ4ac6LqmjMMjMU88q/qqapChcTF+LRYOiHztY/OnYLLZg3elmM5SwwHyICEiQRMdU
         3zkC1dCFkB7Xr3x0ee/wIw/XkYKT1bGR0u4FpwiiztiHfdnhi+6q5LyGXKBnbawwamjy
         qQO1hccGTIr5rCA9jUaLXxkdiDA/q/ZHvT8zP/IvAKW0J3o58TqDLTb336y7t2ZuC0Tf
         HLZSsK3C4s888Z9DQMOCqvvYtpnbcs1I5BQUFsC/ZcC+j0ssXFa50YturdeDucu00TFr
         8fdQKL7z3ys+s+kekhDFfF8KMn9mZVpuOlvbibjILTSQ9Fkmein9albY0tFCLl+UsBVq
         vUhw==
X-Forwarded-Encrypted: i=1; AJvYcCUps5EtJYiJV7IJKGG1VdjGR7zBMko6pufm8W4uFFK/7yBJbD/ZjfgWen4bxv9yM/Pm8s93DzMNG0j1KJ+xMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOUA6cBz5QMIYDLV2nZZ75YPMcVH0qmpiVapgUk9XJMZT/0K4C
	Nu3L6bl118CNPhMyjBtmudKWkOzysHZBW+QRvxPh0CP6dsn4yUbwqjKtnszKt+rAaDpfkfTLmta
	OT8zI97qrfy6jMPY8SgpqTu/bYnZrYuzhLKM1ABnxSBGtpA/iVg0HSfM1smr1XFqVeo2Z
X-Gm-Gg: ASbGncthP+2WI/n6VMeBXGNHeOY6X25dWr7KFTQBIEGm0NfxhOxW2j2NGBEQnh3vfuq
	5nBS9SPZu2M+7Z0/3ko2tOi+lUAsm2JNTFTe4RxjnKAUllyIKHUdKq0tOWMBtgVQ/Ffe+L8/OjT
	aIZzUCtKk0D3QCYylLB13T+Z12V7QOGl5jtMWQEVnbzx0A8nd7j26yXA/LOXDXdPitFTGzf1upI
	wLOuSbRHHIqIZua3POgLUz0dnqcLkEoPOYYtlNHyeYCbkpFJ3msIF36f1WCFzepb3UXFLcYrra/
	8lxfUaSZqGxytcaVPbRJnf1Ks13NWuyOPfUOT9yAs3yVOhxYRKzT+5ftByntPvOFPNgg5QSEerZ
	lI1/XcRtPTFnOmeJrbjqimI/GkBCP/cEXKSQKrvyUC+eFTznBVHDrB70piiHGcn+W9r4=
X-Received: by 2002:a05:600c:1554:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45b5179b4fcmr28181855e9.4.1755871200676;
        Fri, 22 Aug 2025 07:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwWP+gcyHz5PASikvY9eCVK8ixT+7ngDF6OHjbY0O7J0DLjuT/QVU1ki3KQXQcrTer6FnpTg==
X-Received: by 2002:a05:600c:1554:b0:459:e06b:afb4 with SMTP id 5b1f17b1804b1-45b5179b4fcmr28181195e9.4.1755871200176;
        Fri, 22 Aug 2025 07:00:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:6100:d9da:ae87:764c:a77e? (p200300d82f2e6100d9daae87764ca77e.dip0.t-ipconnect.de. [2003:d8:2f2e:6100:d9da:ae87:764c:a77e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57498d9csm82525e9.22.2025.08.22.06.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 06:59:59 -0700 (PDT)
Message-ID: <473f3576-ddf3-4388-aeec-d486f639950a@redhat.com>
Date: Fri, 22 Aug 2025 15:59:57 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 18/35] io_uring/zcrx: remove "struct io_copy_cache"
 and one nth_page() usage
To: Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 John Hubbard <jhubbard@nvidia.com>, kasan-dev@googlegroups.com,
 kvm@vger.kernel.org, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-19-david@redhat.com>
 <b5b08ad3-d8cd-45ff-9767-7cf1b22b5e03@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <b5b08ad3-d8cd-45ff-9767-7cf1b22b5e03@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T-eH5T0smaN4SttWaJePa_8Ev3jGU6IKvmMfH8RJlh8_1755871201
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 13:32, Pavel Begunkov wrote:
> On 8/21/25 21:06, David Hildenbrand wrote:
>> We always provide a single dst page, it's unclear why the io_copy_cache
>> complexity is required.
> 
> Because it'll need to be pulled outside the loop to reuse the page for
> multiple copies, i.e. packing multiple fragments of the same skb into
> it. Not finished, and currently it's wasting memory.

Okay, so what you're saying is that there will be follow-up work that 
will actually make this structure useful.

> 
> Why not do as below? Pages there never cross boundaries of their folios. > Do you want it to be taken into the io_uring tree?

This should better all go through the MM tree where we actually 
guarantee contiguous pages within a folio. (see the cover letter)

> 
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index e5ff49f3425e..18c12f4b56b6 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -975,9 +975,9 @@ static ssize_t io_copy_page(struct io_copy_cache *cc, struct page *src_page,
>    
>    		if (folio_test_partial_kmap(page_folio(dst_page)) ||
>    		    folio_test_partial_kmap(page_folio(src_page))) {
> -			dst_page = nth_page(dst_page, dst_offset / PAGE_SIZE);
> +			dst_page += dst_offset / PAGE_SIZE;
>    			dst_offset = offset_in_page(dst_offset);
> -			src_page = nth_page(src_page, src_offset / PAGE_SIZE);
> +			src_page += src_offset / PAGE_SIZE;

Yeah, I can do that in the next version given that you have plans on 
extending that code soon.

-- 
Cheers

David / dhildenb

