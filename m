Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B414A088
	for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674976; cv=none; b=Q5Kyi3296V/W9lKDjucM52su7yb53dhOAVXWU9/dIbXXz6OGQEj+Wu4Wj9e8WhHGEqO51MrvK1euyMEUn90FLKUm5nbZ7TPta+9Gr7tMq9NJoAYAF7nkJair/8XoTE79cucM6karsVPqK4d7zsx0OgD7K7Sjgr0DVzhkRsFEkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674976; c=relaxed/simple;
	bh=+UYApFnT9UM37KTNXTpn2LxWwTjTgga79QdwKc3PiHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9pXX7JD19PZYLeOE9WrefPquSykLSijJC6zs7cnKbMJLqFxHgx39QHpMJZ1nOR1+g7U9NHosUp0uaCPbsSOa09OWDMmmn5AuNNR2ksgagVmEvWFmqVvwdXCA9WaqP85Q3au39JUge53Vxv6bRKU4a2RJi7YerX2iIL0bUvQ8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Bgcqmicm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Bgcqmicm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c77459558so15983205ad.0
        for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 04:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731674971; x=1732279771; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwJVxt+nzxze2SmN7f33ZKdyuGZOFXgYv9MV7GcQNWA=;
        b=BgcqmicmDDO9HMeF5RCszPZqAo5yUQfTObtAWIBaO6dks7WB48ZUA7MhvUHV5JIngh
         8gcbTU0AZuVI/zaQpR2KJg3Eb6yE0K22pZlM2o9YX2KRl5xk3x6CCPKwN9b0urBGIrpm
         9BtAh0p3HXpqY2G3dL31l1EL7mjA+cjkaXQaB/BQG4g+t0Ole3rK899xLCL+LhrVY2bW
         C93YcxadXzeru2ryhrG0hXyiHu07gl0qkcEew6+tCkQSJ5rYdVULF2zfqj99u17tPt4r
         dkSNCWc6CPLdPbmUGSgXcXZ92OnAovOrHQPWT/Jc7owzQaZJNdpwPiKekL94+szBNkjw
         bOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731674971; x=1732279771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwJVxt+nzxze2SmN7f33ZKdyuGZOFXgYv9MV7GcQNWA=;
        b=A48yed3j5kYAMyWiriX8cVbXWg/IuVR+p4Mg+h/vXb8x+ni54w5iTbL2bg1d83P+78
         A1Ig9F6NhbN4o/0TPxrzy/xiZGaBT+wyzat+etjxTO3xUQ+6PLnFNmiJkE5I1w46BJrV
         EKEvvKKFXvUcA+IZ6YaSP9+rWjFZG0YHsD96TjLjq7bx39+UGd6jRUb7QOT8OkIC0ERP
         qgljm9+oGANSM2amUwgcGfCzAabcKcKC0YNMUKeJSv8TAFwISPaYRJhjIEASrCtHjuX6
         OvQhwApa82Wj+dtx1NfIq53qmXS5rlpzA3L0GBRl8sYdL7ihv9Hh9F9hVmRMqPLAXI4K
         tg2g==
X-Forwarded-Encrypted: i=1; AJvYcCWJscDlet/17CnbuLIUu0Ez0AtXg9x6LKeykftvb6W7qgKZ32W6XHRvK06FJlGH6qC2jAtcV3GhwLlxtnc2nA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxJH1jTA5mXYIxM/gomWKKml1sO0sY8tnFrj/C1MpjFJ/ORgd8
	onnLY4N7f2dx5KDdKMjAAeq16yayQGyjndzEcvMqpN90t1+Fr8SM9SuDl2Mqu8Y=
X-Google-Smtp-Source: AGHT+IHLsm4F8XGgt+dNqMlncEMHZaB6TNbve2F3AL5DPq8Q+6a6Bwd0d1gK0LzJt/GKxZcrS9AoKQ==
X-Received: by 2002:a17:902:e74c:b0:20f:b5d1:8805 with SMTP id d9443c01a7336-211d0ca73admr34323225ad.0.1731674971420;
        Fri, 15 Nov 2024 04:49:31 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34609sm11080105ad.121.2024.11.15.04.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 04:49:30 -0800 (PST)
Message-ID: <9f646b56-ebbf-4f2d-bceb-6ce1deb5d515@kernel.dk>
Date: Fri, 15 Nov 2024 05:49:29 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] block: add a rq_list type
To: Nathan Chancellor <nathan@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-5-hch@lst.de> <20241114201103.GA2036469@thelio-3990X>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241114201103.GA2036469@thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 1:11 PM, Nathan Chancellor wrote:
> Hi Christoph,
> 
> On Wed, Nov 13, 2024 at 04:20:44PM +0100, Christoph Hellwig wrote:
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 65f37ae70712..ce8b65503ff0 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1006,6 +1006,11 @@ extern void blk_put_queue(struct request_queue *);
>>  void blk_mark_disk_dead(struct gendisk *disk);
>>  
>>  #ifdef CONFIG_BLOCK
>> +struct rq_list {
>> +	struct request *head;
>> +	struct request *tail;
>> +};
>> +
>>  /*
>>   * blk_plug permits building a queue of related requests by holding the I/O
>>   * fragments for a short period. This allows merging of sequential requests
>> @@ -1018,10 +1023,10 @@ void blk_mark_disk_dead(struct gendisk *disk);
>>   * blk_flush_plug() is called.
>>   */
>>  struct blk_plug {
>> -	struct request *mq_list; /* blk-mq requests */
>> +	struct rq_list mq_list; /* blk-mq requests */
>>  
>>  	/* if ios_left is > 1, we can batch tag/rq allocations */
>> -	struct request *cached_rq;
>> +	struct rq_list cached_rqs;
>>  	u64 cur_ktime;
>>  	unsigned short nr_ios;
>>  
>> @@ -1683,7 +1688,7 @@ int bdev_thaw(struct block_device *bdev);
>>  void bdev_fput(struct file *bdev_file);
>>  
>>  struct io_comp_batch {
>> -	struct request *req_list;
>> +	struct rq_list req_list;
> 
> This change as commit a3396b99990d ("block: add a rq_list type") in
> next-20241114 causes errors when CONFIG_BLOCK is disabled because the
> definition of 'struct rq_list' is under CONFIG_BLOCK. Should it be moved
> out?
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 00212e96261a..a1fd0ddce5cf 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1006,12 +1006,12 @@ extern void blk_put_queue(struct request_queue *);
>  
>  void blk_mark_disk_dead(struct gendisk *disk);
>  
> -#ifdef CONFIG_BLOCK
>  struct rq_list {
>  	struct request *head;
>  	struct request *tail;
>  };
>  
> +#ifdef CONFIG_BLOCK
>  /*
>   * blk_plug permits building a queue of related requests by holding the I/O
>   * fragments for a short period. This allows merging of sequential requests
> 

Fix looks fine, but I can't apply a patch that hasn't been signed off.
Please send one, or I'll just have to sort it out manually as we're
really close to this code shipping.


-- 
Jens Axboe

