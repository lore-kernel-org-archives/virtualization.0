Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC11B4224
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783566844; cv=none; b=rByMj/loZUwy/UR3pvN34m1Aavxm8FomTErPxLPFs/oRafJyXMHR+f+UMaB5unMxAKI0xWD80TnR144X07li4pe0ygDJn7pg7+1eQkDJYrheGN53Zw1LDPneNvDMj3XOWOFu6XNpKA5iec2/vCGRLN34JLKUjjm48f+NFdx48gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783566844; c=relaxed/simple;
	bh=9CEONipD3AvZR6tsRedhxLvjFbTtqI7hTKtGm3oqHJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trvFRBlLr2ZtVRGkWBkmeRgIT93WWZDbNpRxpEd3rT2/DkjpkcuPx8r4qoPM5AAVm8h3eQKPRs3zgl/jGzi4tOMJd/K9uVJFLe8ge0nrBAUvdSRPgKLFEBQP9UaIaQHuvxywDYb211U1gcwM6tzEzVs5aupsZD8zqonFblrYamw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l8/ysjxe; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l8/ysjxe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783566834; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8wHPN7IQZaHg8n89XnceJDrnyL2Gu0ALE2t9+vjJbNA=;
	b=l8/ysjxetBYUds00jnwZ0hyaTmfnAEk3TFAnEjrs4FPt+T6VLECv1CluxF1Qgr8lJhdi2DrNytTqvTOBudqlypT6dkYuJzMn0loG4IAjWzLjLRWQ1GBohgyrroE6vcdRq91odFcvgNp7yblBxeUilbJGNkkFsKjwvAo9iHvIcEk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6jAFkD_1783566832;
Received: from 30.221.145.97(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X6jAFkD_1783566832 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 11:13:53 +0800
Message-ID: <55f7befb-5ef3-4ede-a3ed-4968864c45b7@linux.alibaba.com>
Date: Thu, 9 Jul 2026 11:13:51 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-pmem: use GFP_NOIO for flush bio allocation
To: Christoph Hellwig <hch@lst.de>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Baokun Li <libaokun@linux.alibaba.com>
References: <20260708124238.2817165-1-joseph.qi@linux.alibaba.com>
 <20260708162435.GB2502@lst.de>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260708162435.GB2502@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 12:24 AM, Christoph Hellwig wrote:
> On Wed, Jul 08, 2026 at 08:42:38PM +0800, Joseph Qi wrote:
>> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
>> index 4176046627beb..081370aac6317 100644
>> --- a/drivers/nvdimm/nd_virtio.c
>> +++ b/drivers/nvdimm/nd_virtio.c
>> @@ -117,7 +117,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>>  	if (bio && bio->bi_iter.bi_sector != -1) {
>>  		struct bio *child = bio_alloc(bio->bi_bdev, 0,
>>  					      REQ_OP_WRITE | REQ_PREFLUSH,
>> -					      GFP_ATOMIC);
>> +					      GFP_NOIO);
>>  
>>  		if (!child)
>>  			return -ENOMEM;
> 
> This NULL  check can go away now, and probaby should to avoid confusion.
> 
> Also bio_alloc allocates from fs_bio_set, so if the incoming bio
> is from that, we can still deadlock.  We'll need a separate bio_set
> for this to be deadlock free.  disk->bio_split isn't otherwise
> used for the drivers/nvdimm/ driverss, so you might be able to
> repurpose that if you want to be creative.

Thanks for pointing this out.

Seems it is more proper to use a driver-private bio_set instead of
repurposing bd_disk->bio_split, like raid5-ppl flush_bs.

Pankaj, what's your opinion?

Thanks,
Joseph
