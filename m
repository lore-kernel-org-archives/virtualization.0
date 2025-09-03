Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537520EB
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926804; cv=none; b=OwomcC5ry0HMvmI7ZAy4vPbk/ziqY848Rkw/Jx44SduW9gMHPZSVpCUnWhjdPwbpelzRNevEzOA0gztwsHOpxXcVt4NTuGB2AMZjzgVsRa6uk8Be+y3LR8Yy6HncT8IEBuIPO35IrWzOyKu0K88X0BznOW2y3qAgdXoV5J9HaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926804; c=relaxed/simple;
	bh=cvZljCbBQTZfgguVt6f33/kkq2mvWYKAOGcOw6BfoZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjYJHR9KXE44mPyho4iEDTD8e11bfIK3/KYlpc1qz/3sWJHUc6ECgRs8/ZCzDYq0Hm+uzf7yedMsXZ0emOe+QJJxK4Qg269dOW5YbDdnQ6gMehUQ0CsMZ2k3DfKHGZtI8AmqciUgVzOUXmzlFPwfmPii6xzVEBr/JT7ITh/anfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WU+u29Rt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WU+u29Rt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756926802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P9efZduikSFnzjh5/dSeOTEpOmP3UF4mDaQBviml7j8=;
	b=WU+u29RtJu4lAULgCriIIcl9PQjrVX6KnsDtjGtp69DBiuPnMqGEzuHXfB2c6otv603tBZ
	5a9ZMTXfl10PUlkM0W09nzJTigq2JEeiCq18Dwln7Bupy7Qkr7z/RbvvCB583Hi1Nyoop/
	44t0sMZ0WRLvHx+mHXSegnfv8qzg3KY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-j4l6iooAO5yw18L8ix9WPQ-1; Wed, 03 Sep 2025 15:13:20 -0400
X-MC-Unique: j4l6iooAO5yw18L8ix9WPQ-1
X-Mimecast-MFC-AGG-ID: j4l6iooAO5yw18L8ix9WPQ_1756926800
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3da4c617a95so177617f8f.0
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 12:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926799; x=1757531599;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9efZduikSFnzjh5/dSeOTEpOmP3UF4mDaQBviml7j8=;
        b=YDOUYrOCqoNjSTjAhPvgjWp6IfBkAWu8zzX7CGyi7M1h5CAQHG/jKEthA+wYSmB0YQ
         UR0WVA+Qp0Sv1VCT20FFz69WysbCHaJ0KA0s4OCTbTHH9KO23aUTtrm1YfDcgdrk+QV5
         kMc6XqJwlPscTTlDYmV7Mp2CSRxpoQZZqxwfru5rkiBlEAu+Rcdxl7uLBZQz6rpXavi0
         6ip+ZKPYC4z2AD08/krWaqBslmkAsKDXPIhltvHllBefo6wYmm3DcBAHVCWJTswIyZ8n
         sj+BiOAWI8CoDBL0WcHDDEo3VH2pQMN+/hZOgPGnf5jh+JgoC0qw/4ljVn0x5glJIjBv
         oCYA==
X-Forwarded-Encrypted: i=1; AJvYcCX6R+y7R8hq7X3IQmwVlQBroonHeW5TjCCAY5c9nAj2ObuxHh72WEEqhOs89JJIOQe45u0YfDQMUbralNpb6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUKSBRSJt85II+JXc/eyZQFwhdNZHkvNr+WzHUPz8WiEM6B/nw
	cXzWSEPbx2x/Luad0l/tfHydD9j2NleU4Ah8wi8ytZuXKrD6J3DeNWRff0dJsiSNS4rmurlDKLa
	yyXJv3Q0Hvp8z6QDJ4NulDRVleo9YpzIU54CJoDpXBIfVm+yiMxJhTfYn0Cg21F+q7aAX
X-Gm-Gg: ASbGncvZ+s/0yglho+tOwKMpE80RtLwg3TUSzVp2YbRZkulAC88jdn+fqMKwMrUUbvV
	13ERA0Fr5pB3U7qhjbfLbs40V+TFWf6D8uN64F4l6TTH50BlRj4TR6s7VPl44bmmYInpL8rEzlS
	iMPDLLQUyWxGGaHSFYgtqe88qZFTIyJ/Ht5JRfmsi9AArFmf75HRQFlSsFZ1Xd8eUhJXvT11DBB
	L9tIGbb1evkevTuIFdeapovuLX7FNNa8AuiVG7mxwi5ijbSr/+wS1x/Ki5Uh/uiStlCrYn3eBwb
	YitgRdKPf4N09DQ985L6O1tG6l77XhqyEMcmH+1Q9DdJP9gprp+RBXKN8CuLIJ/WOkioqRKpEcR
	ib8DLHK3rxHe7nq7t/sqxerZTI8e7CbmF/9+wGiwb4lKlfRnnSj46xjMRbB+Em+RmrQs=
X-Received: by 2002:a05:6000:26c4:b0:3d0:e908:a10b with SMTP id ffacd0b85a97d-3d1e0a98afdmr12916666f8f.56.1756926799533;
        Wed, 03 Sep 2025 12:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ/vbJZF7Gnq5OOkQLM1RIJN39KlfIKUtJSN0ttlFYZVmCF5jsL7cMmb4EZqATRVjN+d4Mbg==
X-Received: by 2002:a05:6000:26c4:b0:3d0:e908:a10b with SMTP id ffacd0b85a97d-3d1e0a98afdmr12916642f8f.56.1756926799082;
        Wed, 03 Sep 2025 12:13:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d66b013b7dsm13632800f8f.28.2025.09.03.12.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 12:13:18 -0700 (PDT)
Message-ID: <8ac6e37b-15f0-40ee-b60c-8893156f8cbd@redhat.com>
Date: Wed, 3 Sep 2025 21:13:17 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] virtio_balloon: Stop calling page_address() in
 free_pages()
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-efi@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
 <20250903185921.1785167-8-vishal.moola@gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250903185921.1785167-8-vishal.moola@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MzDmO6erMVOG82Tp83s346_Vh8_NbN0DHYf8a-GBQA4_1756926800
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 20:59, Vishal Moola (Oracle) wrote:
> free_pages() should be used when we only have a virtual address. We
> should call __free_pages() directly on our page instead.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

