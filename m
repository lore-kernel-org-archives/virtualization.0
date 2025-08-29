Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC41DC9B1
	for <virtualization@lists.linux.dev>; Fri, 29 Aug 2025 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468767; cv=none; b=cl9JNU+zqhDHvWn6PKWGrImHPvykYFEoarPEr8hwE46HwH3VCCEel/1Podm28mGn+YSDsrnQ0WHGAnbtdgoyuK0Mz3UvKbhI0WzJsqSbIWv6cr3jrdM4vnaAdmouzsVdqxnCdaKYU+S4c3FeKiPB0d9IYoXPkl+etJuVL137uXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468767; c=relaxed/simple;
	bh=pfZeu45Ptgbg81HsgsSyDPXotbJF6dygoEjrohpNRUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ST/hJnrgnY9KPZGLBWlvtV3ZXa/Vxvpnbr+8ROGod+dMWQYvWaAuz3ZU32vlwLGPx+KNcu63JgYCgvBjRa15aYDYkMX5mM8Zjp8vE6eTfx4fZPi8Gn0oXForakjTWiZ1wAq6NJlWIOdGu+a6uM+NjrZlrHc3zJWSN+SZRLUd7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKJXflju; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKJXflju"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756468765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bF6XoHD5pMX2I9dADLrcLi6kiYTvPDGveY8Ow/uEvrs=;
	b=TKJXfljuBO2SQSW5KQgcc4LJ+TyzUUk7hn6l1Xxqq/pEAN6LuJr9XalBz3RPWBVzxuTFn9
	TVhopZvq8Ekjm0s8x/7R+LBxUrSCwXV6GGDQdLo5NJ1OiW0JafE5s0pVpg91cusYMMaiBg
	1eWFfGz7+o4fF3RhgwYAkIJgseAKSZI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ExnfkpENNv64zeRP7DWJ7g-1; Fri, 29 Aug 2025 07:59:24 -0400
X-MC-Unique: ExnfkpENNv64zeRP7DWJ7g-1
X-Mimecast-MFC-AGG-ID: ExnfkpENNv64zeRP7DWJ7g_1756468763
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso1064193f8f.0
        for <virtualization@lists.linux.dev>; Fri, 29 Aug 2025 04:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756468763; x=1757073563;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bF6XoHD5pMX2I9dADLrcLi6kiYTvPDGveY8Ow/uEvrs=;
        b=WthIMk1OhuOooQYJHyzO9+XVflMj+Ea7geDOaUQ51vNsmqm6l1FuNEvRql2SIG3FZQ
         LGSG2sR4T2Yy88xOgzP/YTkD5IwTZtet7+EJG2POIuPmqcvjNaj+/h3YPui25FI8EB7o
         VLCEEnHhM264orziPX2qVSLy/l6Da5KCLWG8Ck179oAHFLeGJSQVMhyTUqm2OOqLCO6B
         b9Mz3VSUtgLsTtGT3cQr92EFtQQ001AS3M9n1aeM8htm/7rWifJ6r4DsOQJPVgfqV/88
         im9KdoaJmKdboDgVM7MogigbF3g21HrJ6W2H6YLkd5TZoPZn+nMI3KoBc/gTxtwggTES
         Wmig==
X-Forwarded-Encrypted: i=1; AJvYcCV5y9Kt8vyiyPGyU1W+ps5263iIXnjdQbT7ik0VuRCLS0OyBKLqags/3RYqdJ6MX71z+8rbWGzDHBGIeBc5ag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yybk5io01pzBvXdh0BNbnUBuR51A5PFvOt6IFXRzhntGX17eT/Q
	FSsp/bBTYQ07Pnm5FvZYiIlC7m3reAQiEAHobfzIwhUlXfMmYGL16+oy5asPIobQwoiqjUXain8
	JzX2h1+q7Nk6+7iT/pvu+vW4CzsyhSQHPS4bYFkPoFQbiben0NU4UZ1hAtxA9d3Q+GbeT
X-Gm-Gg: ASbGncsHHLk9GJqT5QNB4mUd2mE9NeGByGoLDLEikI0D4VEWTOHQcEN2fjXruCFpStS
	p2yJcA3wl0ah4KH2nwx/wUp/plcQrmHB02YNiPGB9bKq651vPI4NmXt31B4xEw1VqAArt50KbFO
	T9IEryJEkHusUQZfLo12D/WL6OhpvxxRMJzzTP3N4PNndCEv3c40BGWuKoa1taiTVKa6yQSQsXi
	ya90rzj7Fbdflnin4WQAqHPku4XgRNSm0lfHbm/+Yu+GCNPz+NDrkuBDPEXMFvVLvGiXLojpn7C
	xGyGdZimKAoj1v2oFQVKLPUzF/OlWybVjvIWY0P8ihmAErssiRmfB+xHNLmBEYJcGVTyDxamdiz
	Qj/+r6bXxHMZmeuCYX5i6ssviTvSIyAkpO0/I49waBYLricOe5DjsEM+A/roR/S8=
X-Received: by 2002:a05:6000:200e:b0:3d0:820:6814 with SMTP id ffacd0b85a97d-3d008206caamr1378521f8f.30.1756468762685;
        Fri, 29 Aug 2025 04:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmTZMPZLsWUlDoIJtYZ4y1n4323fVpiEEHsVmNFQad1skciXIKlgwtKzfxNR+9KUHASW5nzg==
X-Received: by 2002:a05:6000:200e:b0:3d0:820:6814 with SMTP id ffacd0b85a97d-3d008206caamr1378503f8f.30.1756468762265;
        Fri, 29 Aug 2025 04:59:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0c344f6casm2018873f8f.36.2025.08.29.04.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 04:59:21 -0700 (PDT)
Message-ID: <0dcef56e-0ae7-401b-9453-f6dc6a4dcebf@redhat.com>
Date: Fri, 29 Aug 2025 13:59:19 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/36] mm/hugetlb: cleanup
 hugetlb_folio_init_tail_vmemmap()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-14-david@redhat.com>
 <cebd5356-0fc6-40aa-9bc6-a3a5ffe918f8@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <cebd5356-0fc6-40aa-9bc6-a3a5ffe918f8@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a9HVr8Mzz5G9KgfWyvvHexpv00EXR00cI4j1Vu2VV9s_1756468763
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 17:37, Lorenzo Stoakes wrote:
> On Thu, Aug 28, 2025 at 12:01:17AM +0200, David Hildenbrand wrote:
>> We can now safely iterate over all pages in a folio, so no need for the
>> pfn_to_page().
>>
>> Also, as we already force the refcount in __init_single_page() to 1,
> 
> Mega huge nit (ignore if you want), but maybe worth saying 'via
> init_page_count()'.

Will add, thanks!

-- 
Cheers

David / dhildenb

