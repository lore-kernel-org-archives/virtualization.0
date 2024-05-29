Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD443D6B
	for <virtualization@lists.linux.dev>; Wed, 29 May 2024 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947533; cv=none; b=rbVqLtIPPatTBvaYyfqe82Ff6QzJ1uHGB/3UxbR5SPYJC/zIyh9SD9eFchjuJSVYAc19plgfToCUhBHjhpPEAMavdO0f/x60RHK8sEzPSyTWLrmYhmTLJ6IrfPiE6fmWEalMwYPR0fF+Z2c9IAOc5tM3wwe8yfFJ8wpuOEgFgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947533; c=relaxed/simple;
	bh=qrVXyEJVBi8QWTH24/zpE6HgWAlyGbYmVuCwbt4NoG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3xxJwVBJnpsKibt3WVeRwQ/VbepEGV+KsAr2aS3KirNXN8mjdnMpVw1rwnafJ0H9Lcuq1PNtJq2l5hc3H8kFIV6CS/iMf3NcSoF3Y5uoT9BOtQ6+8BrvGhY+AmpZWps3sZ3R7uTMWWbsjVUoELLrSfkR9Xoh68+HuoTD46Mzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JhwJ5jbm; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JhwJ5jbm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716947528; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jz7mIWn8uWV++X1z/yTVLP2NYmS4KSlf6sBMcPWTZCY=;
	b=JhwJ5jbmGpumm0tjHme815VYLFrDMufRkz8n9046Xcim1xH8+aruX1vPejQYCpP5fiVZAjgFegaI90OMlrTrkphs/Hugt5gZ+m8oJZ7aDiCWRDzYZYceebEY9LQu4NR/BesX1O7BBrmmJNM4PAP8VauqZC7g/BEiCeLSNjLvxtA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W7R4szv_1716947527;
Received: from 30.221.147.251(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7R4szv_1716947527)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 09:52:08 +0800
Message-ID: <2a095e1a-a3f0-40d5-9dc4-68e60a5a3e9c@linux.alibaba.com>
Date: Wed, 29 May 2024 09:52:06 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-fs: add multi-queue support
To: Peter-Jan Gootzen <pgootzen@nvidia.com>,
 "miklos@szeredi.hu" <miklos@szeredi.hu>
Cc: "vgoyal@redhat.com" <vgoyal@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, Yoray Zack <yorayz@nvidia.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
 <20240501153817.540855-3-pgootzen@nvidia.com>
 <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com>
 <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
 <1672df38-7b97-41f5-802d-ee50f83a885f@linux.alibaba.com>
 <33d6f262b9c5c7c2d23bd0062a88262b597abc84.camel@nvidia.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <33d6f262b9c5c7c2d23bd0062a88262b597abc84.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/28/24 10:21 PM, Peter-Jan Gootzen wrote:
> On Tue, 2024-05-28 at 21:35 +0800, Jingbo Xu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 5/28/24 7:59 PM, Miklos Szeredi wrote:
>>> On Tue, 28 May 2024 at 10:52, Jingbo Xu <jefflexu@linux.alibaba.com>
>>> wrote:
>>>>
>>>> Hi Peter-Jan,
>>>>
>>>> Thanks for the amazing work.
>>>>
>>>> I'd just like to know if you have any plan of making fiq and fiq-
>>>>> lock
>>>> more scalable, e.g. make fiq a per-CPU software queue?
>>>
>>> Doing a per-CPU queue is not necessarily a good idea: async requests
>>> could overload one queue while others are idle.
>>
>> It is in FUSE scenarios (instead of virtiofs). There's no 1:1 mapping
>> between CPUs and daemon threads.  All requests submitted from all CPUs
>> are enqueued in one global pending list, and all daemon threads fetch
>> request to be processed from this global pending list.
> Virtiofsd also works in this thread pool manner with a global pending
> list and many daemon threads fetching from said list.
> 
>>
>>>
>>> One idea is to allow request to go through a per-CPU fast path if
>>> the
>>> respective listener is idle.  Otherwise the request would enter the
>>> default slow queue, where idle listeners would pick requests (like
>>> they do now).
>>
>> I guess "listener" refers to one thread of fuse daemon.
>>
>>
>> When coming to virtiofs scenarios, there's 1:1 mapping between CPUs
>> and
>> hardware queues.  The requests will only be routed to the hardware
>> queue
>> to which the submitter CPU maps, and thus there's no meaning still
>> managing pending requests in one global pending list.  In this case,
>> the
>> per-CPU pending list theoretically can reduce the lock contention on
>> the
>> global pending list.
>>
>>
>> I guess we have an internal RFC on per-CPU pending list for virtiofs.
>> Let me see if this really improves the performance from test.
> I am a bit confused about the software layers we are talking about now.
> We have:
> - FUSE driver (so the kernel FUSE fs driver)
> - virtio-fs driver
> - virtiofsd as a software virtio-fs device
> - Hardware virtio-fs device implementations (e.g. BlueField)
> - libfuse (connecting /dev/fuse and a FS implementation)
> - File systems that build upon: libfuse, virtiofsd or some hardware
> virtio-fs implementation
> 
> So you have a patch at hand that fixes this fiq and fiq->lock bottleneck
> in the FUSE driver, correct? In the virtio-fs driver there is no pending
> list, it just pops from the pending list of the FUSE driver.

I mean fiq->pending list (struct fuse_iqueue) when I refer to software
pending list.

__fuse_request_send
  spin_lock(&fiq->lock) <-- lock contention if multiple CPUs submit IOs
  queue_request_and_unlock
    # enqueue request to fiq->pending list
    fiq->ops->wake_pending_and_unlock(),
    i.e. virtio_fs_wake_pending_and_unlock() for virtiofs
      # fetch one request from fiq->pending list
    spin_unlock(&fiq->lock)

Both the regular /dev/fuse interface and virtiofs use "struct
fuse_iqueue" as the pending list.

-- 
Thanks,
Jingbo
