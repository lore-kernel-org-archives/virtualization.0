Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F171E284F
	for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699532; cv=none; b=ZWG6xs5BIq2lxN0ja7b+oAV/Kie8CcbIEoDryoMnoogTkHgKkrt94De8hQTWt4N68CAKmT/mg4BwvLDw+KXyu5cK+DduuuNAtTQ/e3lFvB+ulfOAO/yoqBse4VVBntW1YA8RSLbY8cTMUtCYl5t3zoen/Pxl/grfmjO4prUmZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699532; c=relaxed/simple;
	bh=CrlGy8AEgKdIqFUxKj6w9vMdT6QAp+On53FXLY7r4t8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bq/I5QS28k0mUJTMyPDJfoNnTi2iOr/q2qaoyGv080WDn8D3yhRrj7l9hyU2+rP1R0/28z++qKwWvu9rLO+TmPgyj/V9Mx+T0HarGD2mLZGDIEMqB6ywPcACoroGqNnS/8OzQwpsLnkwoLCCUPsIEJmnjrcSO4JautIQC/+4jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XhDDiETt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XhDDiETt"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-211c1c144f5so17526485ad.1
        for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 11:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731699529; x=1732304329; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=21XVUqcuDNO4atd7txzRavDI3l/smARzh4SSuCUzANg=;
        b=XhDDiETtGo/5kRgLyTOUrC7QfuhRLRxtYnhi1JfEpkZ8GoMNP4SIbon7/vo/S3lWKv
         8OSbxI+BXpxjJ12EABd/YL+7ZU/b5l7N9WXtVyEfn26j7TjcR3e6PqKiPqbL5yJ589BH
         BQX5ZJYmPhyjk6YhahL7F9idrDK1Leq4U+pdseCPvaVp3eD2HXAF7XUK8VacYDU3G98u
         yLtqZ75DyiCCGejeI8SK9ItjPmAUWmC3ve8TKMH8TSwq2BsgyuTiAac4YJVAW+kFH2SV
         0fX6FK8Tmdwp79ITRlkLvaCaVhQUmnyEICQsyPjxPH5AbvVtIgjLBe5xC0v+zE1bT7ze
         jwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699529; x=1732304329;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21XVUqcuDNO4atd7txzRavDI3l/smARzh4SSuCUzANg=;
        b=J7ccRGvb8YXjqo7zDo3J2g39Uksn9f0kbK7XvOLj5Wk8SKqUjogkYt+V8s6vfYjLMO
         INq67WkiFqIvAR5ExQH/DGIc0B0m2mrzg/yB/E96nuKvD41C8wfMvVli6Aveq7qgGQyg
         8OMyZMZ4omKjgODW3QIX+M2cAtSWe7RoYx60020DGfJD5EHX3wrlmwY7C6iaXEIxJbGM
         vKgQ7n2/77OXxxjHYDPCOrhkfOqHuMxRjND9HdhU1oYZyRIT7SRSftPUPNjQGcI/0uUK
         Ewn3qSHkFRucpgL+eHjMZU89XlxWrOgJ9mkpM5J1RRLbBk6LwwfPvBrLisyEalWIbRu4
         GtUA==
X-Forwarded-Encrypted: i=1; AJvYcCUgCj7K9aUrWOmIClV9pqSlBIuZ4tGZ5/6xVYLbTKYDp+3YGM6JDqtCe+wH7EHWH9ZTK0ywkjavAS9GWl8tag==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR7CAGW9Z3mfJ8RSTWotCaWyXMQyTLUdG+MymZdEr4NG4G3Zxc
	MA1aEz4jU5mgnXIJiub0kvN6PDyn4xen8JrrujS6PUAPf+7ik2wX+Gg2/83JWwA=
X-Google-Smtp-Source: AGHT+IES54wrZ5hHWz7YLdSu6vOgOr+rIrH779oUdaufOW3TN+xRLH1Q3Md1D//toQnJHNLrz6k4hw==
X-Received: by 2002:a17:903:1248:b0:20b:831f:e8f7 with SMTP id d9443c01a7336-211c0f21d06mr109893485ad.11.1731699528961;
        Fri, 15 Nov 2024 11:38:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c04e3sm1791549b3a.102.2024.11.15.11.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:38:48 -0800 (PST)
Message-ID: <be0d06e4-a61a-47e3-8d50-f37f9b6fc719@kernel.dk>
Date: Fri, 15 Nov 2024 12:38:46 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: add a rq_list type
From: Jens Axboe <axboe@kernel.dk>
To: Nathan Chancellor <nathan@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-5-hch@lst.de> <20241114201103.GA2036469@thelio-3990X>
 <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Content-Language: en-US
In-Reply-To: <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 5:49 AM, Jens Axboe wrote:
> On 11/14/24 1:11 PM, Nathan Chancellor wrote:
>> Hi Christoph,
>>
>> On Wed, Nov 13, 2024 at 04:20:44PM +0100, Christoph Hellwig wrote:
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index 65f37ae70712..ce8b65503ff0 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -1006,6 +1006,11 @@ extern void blk_put_queue(struct request_queue *);
>>>  void blk_mark_disk_dead(struct gendisk *disk);
>>>  
>>>  #ifdef CONFIG_BLOCK
>>> +struct rq_list {
>>> +	struct request *head;
>>> +	struct request *tail;
>>> +};
>>> +
>>>  /*
>>>   * blk_plug permits building a queue of related requests by holding the I/O
>>>   * fragments for a short period. This allows merging of sequential requests
>>> @@ -1018,10 +1023,10 @@ void blk_mark_disk_dead(struct gendisk *disk);
>>>   * blk_flush_plug() is called.
>>>   */
>>>  struct blk_plug {
>>> -	struct request *mq_list; /* blk-mq requests */
>>> +	struct rq_list mq_list; /* blk-mq requests */
>>>  
>>>  	/* if ios_left is > 1, we can batch tag/rq allocations */
>>> -	struct request *cached_rq;
>>> +	struct rq_list cached_rqs;
>>>  	u64 cur_ktime;
>>>  	unsigned short nr_ios;
>>>  
>>> @@ -1683,7 +1688,7 @@ int bdev_thaw(struct block_device *bdev);
>>>  void bdev_fput(struct file *bdev_file);
>>>  
>>>  struct io_comp_batch {
>>> -	struct request *req_list;
>>> +	struct rq_list req_list;
>>
>> This change as commit a3396b99990d ("block: add a rq_list type") in
>> next-20241114 causes errors when CONFIG_BLOCK is disabled because the
>> definition of 'struct rq_list' is under CONFIG_BLOCK. Should it be moved
>> out?
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 00212e96261a..a1fd0ddce5cf 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1006,12 +1006,12 @@ extern void blk_put_queue(struct request_queue *);
>>  
>>  void blk_mark_disk_dead(struct gendisk *disk);
>>  
>> -#ifdef CONFIG_BLOCK
>>  struct rq_list {
>>  	struct request *head;
>>  	struct request *tail;
>>  };
>>  
>> +#ifdef CONFIG_BLOCK
>>  /*
>>   * blk_plug permits building a queue of related requests by holding the I/O
>>   * fragments for a short period. This allows merging of sequential requests
>>
> 
> Fix looks fine, but I can't apply a patch that hasn't been signed off.
> Please send one, or I'll just have to sort it out manually as we're
> really close to this code shipping.

I fixed it up myself, it's too close to me sending out 6.13 changes
to let it linger:

https://git.kernel.dk/cgit/linux/commit/?h=for-6.13/block&id=957860cbc1dc89f79f2acc193470224e350dfd03

-- 
Jens Axboe

