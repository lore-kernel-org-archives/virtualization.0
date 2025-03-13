Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9FB1FBE86
	for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854176; cv=none; b=CK9lKIhl9hn4hXB6/ANKX3JPh0qPzvsA5+Zfq0c1VKxpU6QMlOUhM119VtkCnFcs3P/QybLD9m1KBaXuQfY0Jswgq5bQmASp/LC429yJTH7YBvT1iMAzlpcoNZBAS5ywaXRZJOecNqFRNGcxPZdwqGt4mGGCiZNDVOWkTTAYPaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854176; c=relaxed/simple;
	bh=TJNOeBMjx4/7smApHsBD4VsBRDugKyG6Q4orRPpRGlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFoAWWY5BzZ5idLBhc+lBKtsD7seFXUEVR5OBDEUBn9cuzbWivL8a2YUEm/cvghEirU9axQnCfxwl/GUG95W65zesfI/3nlerlr7GA26YEqFaUKpkyaeMPDQvOLo0Sp9toRa2KLUfNP4kByCxhCL9C1mf6LAE7iSrO2h/l11W48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlJm0ZSH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlJm0ZSH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741854173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JKb8bhfHMFiRwZ59jdxdcm6FlzuySG9mYwbfnUAEPPE=;
	b=TlJm0ZSHDvvyBuIqEMwXf3NU2C5dqdplylthZppcGrda24HB0sneOgwPjpG/DfMu55SWJr
	ZadkpaZCtQ0pRclt1Iem+SZMpqblkN2evxNSRJ8zcBCgwdD5KXSq/PPSu7py+CuxRnkcZ8
	aCGb22ROwwRqxLdk1JSL+eL8bsiwCgE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-HzRGPG9APLC0U0wtqe7mjQ-1; Thu, 13 Mar 2025 04:22:52 -0400
X-MC-Unique: HzRGPG9APLC0U0wtqe7mjQ-1
X-Mimecast-MFC-AGG-ID: HzRGPG9APLC0U0wtqe7mjQ_1741854170
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912a0439afso279002f8f.3
        for <virtualization@lists.linux.dev>; Thu, 13 Mar 2025 01:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741854170; x=1742458970;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JKb8bhfHMFiRwZ59jdxdcm6FlzuySG9mYwbfnUAEPPE=;
        b=CNlK6+1XRaHucUHhXf1hYjcNFKGk76YETCNGa/oMImJsnl+NeeV57G1/X5uqGV2XLU
         JyciV8wRiutudSpzTn64DWEO7BbXjEsoSf7fD9NHQ480lfbqHpUfv0weZl58Ys5LCaZ+
         mNOaYvyp/zH+kxrBtvhtmgRk1pxwHY7AtdzXje2qtEy5aFbgZAMbJHO8O7Np1N7epU1k
         vPWJJH+lpPFKLIKhNrPcAohm9NUShbs7BVBBXOgSBAonWhZOb2altknpVilO87BSo86S
         WXTE/sGJSaW66FBK3hEp+TETBIDzkVvjk8hwTcfZ1uLUssGJHolhSZItkG/TBKfiL9dW
         B0ww==
X-Forwarded-Encrypted: i=1; AJvYcCW11liXlQZcMa0w1vKk7h+L5bH9ZTc/mIumZPld68PRdkpOdKQhIRSo8h96c3AaiXXVWZ+rXK+c69RF/aFaNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvpLziYo+r2p7Bt9EpqLR0BCW9O65BaEkXildrCPRQttNQLzww
	YUHOgqAmMniHUk+pGr8o+SpZOxhgp9aeAmZ6IrsFf5tcZCxAV5AlWor1gP5rYWw+N3zLtCOXg0n
	KmO8GnGhTNT634Mzh9rkol8T+Udyh1WNZZcSn9SkcmExecUVYnaY3+IuTpR9juflY
X-Gm-Gg: ASbGncv91xClCbzaDxe8w52XpgJemlmgl5L7h1U1xJZgTzrFyZDKWdtU377DovzXe06
	IYvyssLtk4KzeKUrUYlsNzNlYoVZIF3S8AHu98YcBm0U46SWOQOP2a0+Ob5TPiEVzCU7agQMMpu
	zkbwC9uPVirJkwQ7QavbNeJUggQOpun0uVLyUgGrNWHB4ETTyiXiOe0NJlaALV4hnqhtS//XAmN
	fh8ek1tY0fb3eTmxD8dOr06BgwrBQ7D1f4cuBvaxIJouClNCaDcwrdB52iByz+8hhAWG+QadW6Q
	1vlohsDXanr1wKmHaUUl7yFJkIJ3nT0O76HZNGK2xIkHdZDjuSvu85yo2bH5znC5cDjlqpZfEiP
	uurXPLYdy0cOLQlw67gj/lB45s36s9OU7aP9BLwOtGCI=
X-Received: by 2002:a5d:59a7:0:b0:391:1139:2653 with SMTP id ffacd0b85a97d-39132de145bmr19688699f8f.52.1741854170236;
        Thu, 13 Mar 2025 01:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE43rHs3WgvOTi5LsVwj2SLALb9R3gJ6Te0W53zkDxInnxOJ+3GIwgQhD4YjNmuEA7ot9BSDw==
X-Received: by 2002:a5d:59a7:0:b0:391:1139:2653 with SMTP id ffacd0b85a97d-39132de145bmr19688649f8f.52.1741854169787;
        Thu, 13 Mar 2025 01:22:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f? (p200300d82f1a7c004ac1c2c441678a0f.dip0.t-ipconnect.de. [2003:d8:2f1a:7c00:4ac1:c2c4:4167:8a0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm1308783f8f.51.2025.03.13.01.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 01:22:49 -0700 (PDT)
Message-ID: <e9570319-a766-40f6-a8ea-8d9af5f03f81@redhat.com>
Date: Thu, 13 Mar 2025 09:22:47 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/5] meminfo: add a per node counter for balloon drivers
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, jerrin.shaji-george@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
 sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com,
 alexander.atanasov@virtuozzo.com
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-2-npache@redhat.com>
 <c4229ea5-d991-4f5e-a0ff-45dce78a242a@redhat.com>
 <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAA1CXcCv20TW+Xgn18E0Jn1rbT003+3gR-KAxxE9GLzh=EHNmQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -UQJglhY0YU56TUnIEIc6ASp3jqEkEUmduasX_dCnaU_1741854170
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.03.25 00:04, Nico Pache wrote:
> On Wed, Mar 12, 2025 at 4:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 12.03.25 01:06, Nico Pache wrote:
>>> Add NR_BALLOON_PAGES counter to track memory used by balloon drivers and
>>> expose it through /proc/meminfo and other memory reporting interfaces.
>>
>> In balloon_page_enqueue_one(), we perform a
>>
>> __count_vm_event(BALLOON_INFLATE)
>>
>> and in balloon_page_list_dequeue
>>
>> __count_vm_event(BALLOON_DEFLATE);
>>
>>
>> Should we maybe simply do the per-node accounting similarly there?
> 
> I think the issue is that some balloon drivers use the
> balloon_compaction interface while others use their own.
> 
> This would require unifying all the drivers under a single api which
> may be tricky if they all have different behavior

Why would that be required? Simply implement it in the balloon 
compaction logic, and in addition separately in the ones that don't 
implement it.

That's the same as how we handle PageOffline today.

In summary, we have

virtio-balloon: balloon compaction
hv-balloon: no balloon compaction
xen-balloon: no balloon compaction
vmx-balloon: balloon compaction
pseries-cmm: balloon compaction

So you'd handle 3 balloon drivers in one go.

(this series didn't touch pseries-cmm)

-- 
Cheers,

David / dhildenb

