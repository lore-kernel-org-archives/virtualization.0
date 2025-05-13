Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B71283FFE
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747143876; cv=none; b=RRysDZjD+JGuQXj0l7weiQidAtEYI/WWn/hR+JRK3WZ2ixUjelNsk73UOw2I13X5dECrEPqOOXxHI6Jx4V7ZVOkk31txhiYXfxXj1mpHbYgfCMcvh3R4Ai0t4hoxBZ1pCzpXnoav39WaQr+jLhVV/CaD9wQA7us9si3IQcKIYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747143876; c=relaxed/simple;
	bh=e4eJ1305I+EgHcEaP7lZEmnVbMFKKOUHcQqiW/2DwFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o0Z4ZjT6LrcnLMa7JP0X5fjRHogg0QA6y/qZiCBIrhMdh2d8jKOcqIiAFY7/cFTOSMkqFSqlI96w4Z3NCbastc0U4tDk/NQIf70O9plgAk5W5rcEhcWePuV4TrpDhJsFR9ztXx06d690tY2F5nAQp9o3z8ejYZyNhkfWDRY0vnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPUf4DXB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPUf4DXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747143873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jguUTZh5JvRuhjXFBXsB5gTRN4crP6ONtuEb+MxDCd0=;
	b=ZPUf4DXBVOWcr2iIAKf3IPRQUtoRfceIt4lULHS1OQZUip4YIoaz5UArdIUCOIY8BH5DVE
	Q3Q1o4lSr7vdqFu+XDZWBCylFjzFZdr4yZAi+ORBwDUdifQu875LZ8TGptgN7ZV8LT7C6e
	kHdCEg/cEqhQSCEouF9L1csxo2+2NE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-scgR0vLVM2e6ckReFpeOZw-1; Tue, 13 May 2025 09:44:31 -0400
X-MC-Unique: scgR0vLVM2e6ckReFpeOZw-1
X-Mimecast-MFC-AGG-ID: scgR0vLVM2e6ckReFpeOZw_1747143871
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a1f6c5f54cso1636862f8f.3
        for <virtualization@lists.linux.dev>; Tue, 13 May 2025 06:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747143871; x=1747748671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jguUTZh5JvRuhjXFBXsB5gTRN4crP6ONtuEb+MxDCd0=;
        b=v90G1e5Mv35IDAcwQ+Rcwfo2vHeQwWkT05J4zEvLYcJUbuhx/L+nU9TAL9OjPex9Yo
         DbnJAsfRJyJDB6Z8A1JxNMjbLBZkSo/jKTDd1uGCkgmvpXxnmTv2Rth2rm2nE8bFdkE+
         NI90415Vvg3na7B4RxwJn0X/ZaH6f0MZLzZIOADOtEahSDtHIK3ldRQ8l8fpScAfIFF/
         fBd8g3fmO7RevEJb6zvmpRMqj+wmuOdiGmyj1tEzMVGSwWIHEL/7430urgONHHJMslfT
         aope2PKBcEDRh5OcdcaiWD0Pr0+LIcMUiLBevuWXLE+/4B6hRFQV/p3zidYiq5PKFT6B
         IIHw==
X-Forwarded-Encrypted: i=1; AJvYcCU1BzqP5EbT26aIkFplgb78LgKkvWnAUAYCjpv1hgWdRAKOLOpA6p+U2oRy6z2QowgQtlkPBi9wHSPK45Wy7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YysOE9hmeIodqvanM1YjOd/Io8zBBtgm0qo5tRJRDSggPB2Kvj9
	BRRvOjzlx1Zv7gaM3Lb2K5I2ezsoKzGOsBN+Ev5SJ/SZkvQbUatxUhjMolCBAiqLZBoKCrj1rT9
	BalRkJV1FOEnfrHwIOR98O310jq0B2VZAI/ihOuAocLl7oAdtKk+azefZADHHxE2/
X-Gm-Gg: ASbGncuYAwjcWBocwEaN/SfjIQO0lzG7U8YUhVQWdCaNlCL2ugVFR2+7zkeD3lofc/T
	rmLyKE58mHoAvZtjHJvDRwVxyTx0dT+YLNqyMnDJC7eAVSJqYNyXJxVgqOrxsdDTnEQkgoZIbsC
	D31av6mz8E7NhS2s3kxicwDAga2mrFaHYaxJoUvmxPZkEPPzK9ySlOg219hRq+ACaKN3BOkeaQd
	6xHhXaHTPrAZqukQy6jZVZjZHND+TNOT3UYn1RPvQLbovv+dYgB7L42EL+AFfFy9oMlCGz3bYNw
	T9lynsKXPtIrk8M=
X-Received: by 2002:a05:6000:1a87:b0:3a2:6b2:e558 with SMTP id ffacd0b85a97d-3a206b2e7cbmr6897539f8f.28.1747143870785;
        Tue, 13 May 2025 06:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJPvRc2d/tScX3zj2Zy4dIA1+zH01wyvfnGBVZQ5VJgZ3BSnWeMNjMYPwqRM4uUjlqx7Agqg==
X-Received: by 2002:a05:6000:1a87:b0:3a2:6b2:e558 with SMTP id ffacd0b85a97d-3a206b2e7cbmr6897501f8f.28.1747143870216;
        Tue, 13 May 2025 06:44:30 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ee95asm16433764f8f.11.2025.05.13.06.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 06:44:29 -0700 (PDT)
Date: Tue, 13 May 2025 15:44:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mjrosato@linux.ibm.com
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ
 tests
Message-ID: <2lh2s2nnhiyqjlwl3xgkh3ujjipaggi3isjgrhgi27s62exh7m@bwyn34knronr>
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
 <2d2a92d2-1844-49de-a869-4caf2677b099@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2d2a92d2-1844-49de-a869-4caf2677b099@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wuvaaMjy0kGsRJSc6q1WrlYzfagSWEiFWJud5xIgwwc_1747143871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, May 13, 2025 at 10:46:35AM +0200, Paolo Abeni wrote:
>On 5/7/25 5:14 PM, Konstantin Shkolnyy wrote:
>> These tests:
>>     "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>>     "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
>> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
>>
>> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
>> have been received by the other side. However, sometimes there is a delay
>> in updating this "unsent bytes" counter, and the test fails even though
>> the counter properly goes to 0 several milliseconds later.
>>
>> The delay occurs in the kernel because the used buffer notification
>> callback virtio_vsock_tx_done(), called upon receipt of the data by the
>> other side, doesn't update the counter itself. It delegates that to
>> a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
>> more than the test expects.
>>
>> Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>
>Could you please provide a suitable fixes tag?
>
>No need to repost, just reply here.

I always get confused whether to use Fixes tags for tests, but I saw 
this patch target `net`, so it makes sense. BTW IMHO it can go 
eventually through net-next, which is the target tree I usually use for 
new tests but also test fixes.

In any case, the tag should be this one:

Fixes: 18ee44ce97c1 ("test/vsock: add ioctl unsent bytes test")

Thanks,
Stefano

