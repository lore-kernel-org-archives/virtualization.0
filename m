Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C83B7A0
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431633; cv=none; b=NRv/PIqE1KvSfgSdQZEZsdjqJWo41Ue9NBvDpZrQXLjyT0pFnrWjOZVXzTjODlBeYgphZxDaFSEC52qBnu/lcJewHvRVyY5hqLT3CqiomteIKxechfNW2+5rq8D21Cdgx4l6/y2U5giYLK/cUrbjOTIegvA5wXhEu/NFkid4MH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431633; c=relaxed/simple;
	bh=p+U0/z6qpWvhxLpDOQ9kwr52CI9MOZsHkOK0yPzOXU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqJoLN1EQTZVNNFu31wXaVwPT+UPi1TrnuSsaYCNj1D8ksVzodFy2UbweaxZsxzajgIfs14IOlRu6wxgthf0ej6dbJc8iLmd0LoSwlsHHjPYrhupljsFj+0lJFefYVWbpYIRXu3uKEEeMHJXU4jChVHD/im9+jQGpBCgIZI5wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0Z2txDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0Z2txDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714431630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTpDjsWrbDelUOoovp9TM5pcXXPdflIY1tu9If4E9h0=;
	b=Y0Z2txDDlfKxwTrCVciAGauorNE/zuHCgs5SYzOWqpBw6Hf4aCZ7N+QFB0b0kZELeaWSHV
	/2oKC+ygObiykzhQpPkfGcpsKDJKNCacLjrz2/fHqEVkdt9v1Xr+pq7BIL/RkpqWoEzTzu
	JZun2MXvcp2MbM6aAk6Ty7BeL9Xec50=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-SHfHIrJmNSWp3XyKxQkdIg-1; Mon, 29 Apr 2024 19:00:28 -0400
X-MC-Unique: SHfHIrJmNSWp3XyKxQkdIg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-613dbdf5c1bso1538592a12.0
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 16:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714431627; x=1715036427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTpDjsWrbDelUOoovp9TM5pcXXPdflIY1tu9If4E9h0=;
        b=txgnH1UwuY6o1o+wYntUVYkEYHoRbWB80pkZznBvw/2M9TgCAKUHonnnuuhmnuHTtJ
         3wyGYZaUZBEeTMTe6OGNp+oJLCw2dunZVMmw4B/ETnVkn2VvIc3gIUvOwvvhUgqhTpWN
         tgkkgTFufY5NpJt/rysJe7p4sC0+Yli8U11KHyK0bzMnTaoxiJMQqC7b1qqNimRwn6+i
         bgz1iHFTMs7w9GZxl2dV5wpyfITgw4zJyqV75B+scPTljw4oehAZb9TAOO5UuG9dZ9bD
         G0DLaVsHe9kA3ixS0H/gGKO2h0dTZ3ZeoN8hHtBdyw9naHvrYcb/0bjSbZdmtvqCerq9
         fQzg==
X-Gm-Message-State: AOJu0Yzjp2A48coLSydaFKVU4T6D1YhZOvDcUEXGQATgNo5pMINq8xmD
	Ld21fOwzp3RQIoqDt61Pc4y+zdS2QU4EiSeJ8Hpclh++HqZn/VqasYUCxa88j4B5BYZlMawJGtZ
	eczFc410/IHciKZhUqMoHsMY6sB6FhnfBNDe0Ub5FPECRINk3Q1fS5eC+jjXA1OlQ
X-Received: by 2002:a05:6a20:4f28:b0:1a9:9547:1145 with SMTP id gi40-20020a056a204f2800b001a995471145mr950600pzb.47.1714431627676;
        Mon, 29 Apr 2024 16:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWb9DI/V+M/teJZ9AwOOl2ERKzxL1dyLl/vajtEN723v38aemsJL9zaCqiW1bIQJH0s9Qj4Q==
X-Received: by 2002:a05:6a20:4f28:b0:1a9:9547:1145 with SMTP id gi40-20020a056a204f2800b001a995471145mr950579pzb.47.1714431627299;
        Mon, 29 Apr 2024 16:00:27 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902780900b001eab1fb1093sm8782186pll.102.2024.04.29.16.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 16:00:26 -0700 (PDT)
Message-ID: <4e133a86-a2e5-43ed-acd0-fe6f1aa9eed2@redhat.com>
Date: Tue, 30 Apr 2024 09:00:21 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] vhost: Drop variable last_avail_idx in
 vhost_get_vq_desc()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, shan.gavin@gmail.com
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-3-gshan@redhat.com>
 <20240429144522-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240429144522-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:45, Michael S. Tsirkin wrote:
> On Mon, Apr 29, 2024 at 08:13:58PM +1000, Gavin Shan wrote:
>> The local variable @last_avail_idx is equivalent to vq->last_avail_idx.
>> So the code can be simplified a bit by dropping the local variable
>> @last_avail_idx.
>>
>> No functional change intended.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/vhost/vhost.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 7aa623117aab..b278c0333a66 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -2524,7 +2524,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>>   {
>>   	struct vring_desc desc;
>>   	unsigned int i, head, found = 0;
>> -	u16 last_avail_idx = vq->last_avail_idx;
>>   	__virtio16 ring_head;
>>   	int ret, access;
>>   
>> @@ -2539,10 +2538,10 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>>   
>>   	/* Grab the next descriptor number they're advertising, and increment
>>   	 * the index we've seen. */
>> -	if (unlikely(vhost_get_avail_head(vq, &ring_head, last_avail_idx))) {
>> +	if (unlikely(vhost_get_avail_head(vq, &ring_head, vq->last_avail_idx))) {
>>   		vq_err(vq, "Failed to read head: idx %d address %p\n",
>> -		       last_avail_idx,
>> -		       &vq->avail->ring[last_avail_idx % vq->num]);
>> +		       vq->last_avail_idx,
>> +		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
>>   		return -EFAULT;
>>   	}
> 
> I don't see the big advantage and the line is long now.
> 

The point is to avoid the local variable @last_avail_idx since it's equivalent
to vq->last_avail_idx, as stated in the commit log. Besides, it paves the way
for PATCH[v2 3/4] where the whole logic fetching the head and sanity check is
moved to vhost_get_avail_head(), so that vhost_get_vq_desc() is simplified

I will drop PATCH[2, 3, 4] as you suggested.

Thanks,
Gavin

