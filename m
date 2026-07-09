Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B73859D7
	for <virtualization@lists.linux.dev>; Thu,  9 Jul 2026 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594914; cv=none; b=tnZzaCgb7FZR57QVTRRxXEr3s+lYYul/y/0Ve0hSee1sNRKDzz60bThSduY6Cu8eXxIyEhMcvVomZ+kxcX73gFrlWQMG2wO57lA7nbIuHNYnSanrcsEPRIb4Pm6h+6J2Mk4NmMdC5Ov1ZIBuIs7XpD3pcIj6Jgm/nA715qfRJ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594914; c=relaxed/simple;
	bh=acOPYsQ5t8L0N6qgYlfpWGDnBKp841iAL6aTmuLWoVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0gmW3cbdDJNAC+48ReEHfYqHqdz8UcKjae8sSF86bKK5PuDQ483u3ZxTesyKT+XoWasDVvJPK07Mk7KqJv/cKVhV+2dWXEbg8P6u6dp6X8dE+GElC9CGdj/cHwnmPVkGA/+/7ipjE8OqvrvE+O6iJl1VIUKVey7Fum3j6LcMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JiCtEr/a; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JiCtEr/a"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783594908; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qSyvZ7VwzehdQqU5aTMtSf6gb+Qx3ccdNmccDd5Tlxg=;
	b=JiCtEr/ahhgJ6eYUjrbn/izAvaVzhz6i9MJmuwMoHC+acw4LjGDLg2IkqXb7peDIc+xvcilgwscZxRvq3h4GAe7zRfHMyP3Xd96oe4Ph+S9/c3VCJi1Wl5ze8Xzlaiq/w5iCK7aPYbq+oyr+MlPn3FRCoNFhcZR+vhag4r5rmco=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X6kh0Jt_1783594906;
Received: from 30.221.145.97(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X6kh0Jt_1783594906 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jul 2026 19:01:47 +0800
Message-ID: <f00c5f01-f6cd-491e-af01-49242244773c@linux.alibaba.com>
Date: Thu, 9 Jul 2026 19:01:45 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-pmem: use GFP_NOIO for flush bio allocation
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun@linux.alibaba.com>
References: <20260708124238.2817165-1-joseph.qi@linux.alibaba.com>
 <20260708162435.GB2502@lst.de>
 <55f7befb-5ef3-4ede-a3ed-4968864c45b7@linux.alibaba.com>
 <CAM9Jb+hPmV4KF5xAy0=CPy6yh4=9=aACmLbZ3G5daz7QuAH3hQ@mail.gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <CAM9Jb+hPmV4KF5xAy0=CPy6yh4=9=aACmLbZ3G5daz7QuAH3hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 6:58 PM, Pankaj Gupta wrote:
>> On 7/9/26 12:24 AM, Christoph Hellwig wrote:
>>> On Wed, Jul 08, 2026 at 08:42:38PM +0800, Joseph Qi wrote:
>>>> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
>>>> index 4176046627beb..081370aac6317 100644
>>>> --- a/drivers/nvdimm/nd_virtio.c
>>>> +++ b/drivers/nvdimm/nd_virtio.c
>>>> @@ -117,7 +117,7 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>>>>      if (bio && bio->bi_iter.bi_sector != -1) {
>>>>              struct bio *child = bio_alloc(bio->bi_bdev, 0,
>>>>                                            REQ_OP_WRITE | REQ_PREFLUSH,
>>>> -                                          GFP_ATOMIC);
>>>> +                                          GFP_NOIO);
>>>>
>>>>              if (!child)
>>>>                      return -ENOMEM;
>>>
>>> This NULL  check can go away now, and probaby should to avoid confusion.
>>>
>>> Also bio_alloc allocates from fs_bio_set, so if the incoming bio
>>> is from that, we can still deadlock.  We'll need a separate bio_set
>>> for this to be deadlock free.  disk->bio_split isn't otherwise
>>> used for the drivers/nvdimm/ driverss, so you might be able to
>>> repurpose that if you want to be creative.
>>
>> Thanks for pointing this out.
>>
>> Seems it is more proper to use a driver-private bio_set instead of
>> repurposing bd_disk->bio_split, like raid5-ppl flush_bs.
>>
>> Pankaj, what's your opinion?
> 
> Hi Joseph,
> 
> Thank you for the patch!
> 
> I am not very familiar with the internals of fs_bio_set, so I do not
> have a strong opinion on the implementation details. However, a
> driver-private bio_set sounds reasonable to me, and I would go with
> Christoph's suggestion.
> 
Fine, I'll send out v2 later to address this.

Thanks,
Joseph

