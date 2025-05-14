Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3BD29346F
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747252643; cv=none; b=dFInNKvfzo11QIvUjM+zmr+6qL2rXWORHJoBDfkj577QlK0II/5+LxtIzYK9khbrYYj14wz4onnIkq1gp5XBUbQWp6FA4vmaULsaH0VJz21pJdufH9rk0emUle7R9QSVhkw+57nTN6CYsGlndtZbNolrGl8VfFnXSrCzlnEdEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747252643; c=relaxed/simple;
	bh=G4r7l7bGGrgOPxVZ5jSwQFr8DJcJpkNR7+13/BrUy0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rs85cOSo+Dyddccc89o9EHGDMvCZdr17T9mPVkFNQVrqiHCGfpwPQ+1R+lfvbDZnrINfaK9DvtwtiyRqWoo7CpWO5BefggnzRwi+nZ++7UCQEcPoTzpSeW6csV6SKlklGUEtXmI1DZ0iMFHwET6wgT5cmoq/G3Hx9eK+yRakIx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsGpZHGr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsGpZHGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747252638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/HQ8qR6osfBxrwmsNfgAt5dvj7Kw18nbvrMfafMSslo=;
	b=CsGpZHGrxYZy0dJKG7qDmUmThuFTG8OFsH+GqAzJojnNgtaGqGPHvsLsHheY8QygdiloFN
	j+/AniEGAV/JNKWeHxTjJ3uBxTXoo6l73XVLOP9sJ1ZX2POtvaI67GZV2h1ZJ6AJSkZ7T3
	8MySWKvDfA3sHYLgffrr7OLbBYL+oXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-sjM4QkDnOEGnP4RVNRs6ig-1; Wed, 14 May 2025 15:57:17 -0400
X-MC-Unique: sjM4QkDnOEGnP4RVNRs6ig-1
X-Mimecast-MFC-AGG-ID: sjM4QkDnOEGnP4RVNRs6ig_1747252636
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso1172665e9.0
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 12:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747252636; x=1747857436;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/HQ8qR6osfBxrwmsNfgAt5dvj7Kw18nbvrMfafMSslo=;
        b=mdV0Y1dw8+7rE4X0n1GlBKxhp4PLcGSclCooUa9zo9iHhut9WBZGhAH3O7Bk3nu4rQ
         wfg5EcrL97uoAeHSDkZYl3M/UmA7HjaSsFEeeF4J7fKrWlqKsznNbirSOs1SKUkt/rC7
         GtcEuHfrAV0F4rQLOD9uFpWRwoaI3V15Z5UdAnxCxq89qquwO9hCy8bpfrtndVOu4arX
         B+bp47aKYYB32Ec2kAUKj/wQK+KxL2kfPLu29wKMv37L5InyeztBWrjh5qUsFW+A/OJf
         +Hn6neqCUcZcP2l3hoJTZCZgZdFc1OzWdRKzg/myQCS9YaG2b68fRB10SEPizu7VsOXS
         iaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2YcGgJkfKVdFLGmRG8C3Duq8GRWh7wm7vBLm2s1Eq3qKpjDDVEXWrl0g+09GWY7sn+FAR3281qgUmKROj4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbQOna7nnUVAjZb1YtRPtyRdsEJhGVxQ8ET8FYrwkKEvMhaxWP
	7YNHlkdMsBkpSgwaywFEfarw4xEfEku5K5FXqbuq5UFusbC6E9Defm8oFlsZejUXvmXiFywXUgc
	vVgTUS0syiHdDCxsNip7uco4m26r9JPrwe24B31wbS7BftvNE8oo6wUCUBEH5xJDd
X-Gm-Gg: ASbGncs2VvGT/CWRh5yTpkItnzD6+z1iZMqzy8BQb/gxxfV601xv0yw64zbaUnkrHIa
	/J2DryBEZEG5Pnq7DOPhq5ghoRfk9PUb8h1tGb+Jqbj2F4s3slj1OBhSSzC+6qpYn9IVVqo2oPe
	sMXOnvlSYQQj8qcBQA4m1MYVPQWct4CMtQsJIGZclqqN3SKjwKxaTuKferVCyG5QgoyRmyvAnRO
	RbLG56taW0gkzJCoUqQv4Ee/0xNaob/5lgDvXDFbULDCqG0wD/y3ynqi4Z9hiRqs2wKxqr9MrUA
	87xDROcaUQZxAJqJ65kInTnDnYHdd3Bby8MSWswWQtr7IswDohJ1XSxyBKze65Y/kC9g6e6UgTp
	sPY2cZwp7VEUlR1dkEragzYncO3n/09MYR9qpmDA=
X-Received: by 2002:a05:600c:3e08:b0:43d:b33:679c with SMTP id 5b1f17b1804b1-442f850c54amr7418875e9.14.1747252635919;
        Wed, 14 May 2025 12:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlb0J3692FHeLltBMPddwsHcQQKYuL1jq9K15qHO8quLnVObfi8tEqOJXFEm2JgNK6bTieaw==
X-Received: by 2002:a05:600c:3e08:b0:43d:b33:679c with SMTP id 5b1f17b1804b1-442f850c54amr7418665e9.14.1747252635530;
        Wed, 14 May 2025 12:57:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3369138sm45340745e9.8.2025.05.14.12.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 12:57:15 -0700 (PDT)
Message-ID: <19683dac-3e21-462a-8957-78a0b28b57c4@redhat.com>
Date: Wed, 14 May 2025 21:57:13 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/memory_hotplug: remove -EBUSY handling from
 scan_movable_pages()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20250514111544.1012399-1-david@redhat.com>
 <20250514111544.1012399-3-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250514111544.1012399-3-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d_8RXQc0BKMJBDHdNkv8o0SQg3htSZQ7QoPwcvelucE_1747252636
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.25 13:15, David Hildenbrand wrote:
> Now that we can reliably identify PageOffline() pages that allow for
> memory offlining in has_unmovable_pages(), start_isolate_page_range()
> will fail on PageOffline() pages that would prevent memory offlining, and
> we no longer have to detect them in scan_movable_pages() anymore.
> 
> Note that the previous mechanism relied on MEM_GOING_OFFLINE, whereby we
> were not able to distinguish the types of PageOffline() before
> MEM_GOING_OFFLINE.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Hmm, I'm having second thoughts about this patch.

With hyper-v, I think we can hotplug partial memory blocks (e.g., 64 
MiB) and online it to ZONE_MOVABLE. These blocks cannot get offlined so 
far -- in contrast to virtio-mem -- and has_unmovable_pages() would not 
identify that.

So probably best to keep that in for now.

-- 
Cheers,

David / dhildenb

