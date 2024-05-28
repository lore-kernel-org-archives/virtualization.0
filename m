Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CF131E3C
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903332; cv=none; b=VC1zsUna2lMmWgfE0SgVcG5rn0OZn6Qegtzvp4a2NMWgfc7OwZzY+1OLWL1Zfl5BiFLALnMa2szKe0g17VxYoCPpPlMsJ1ymI3WXqa2sQC+9n+ziNV7r1z2uO0XpXwsSB5hip8mGx31BmS5lusTtLkJD5P26cnuYKzNNIa2880Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903332; c=relaxed/simple;
	bh=8hBCJACxkY5nfCzznIHz2vBbX2ZQuN1gsZDFCwpPT2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyHBWEr0DTydYh4EZXopBp9aIUbVkxue/obviMLFZOnsXOlaTuaqP8DE0V8F3gO61BRbq++Iw1Ez3sCafuYH8wl1TzxOfAWgjTi9LICaz15GXFWvBa8QkmXVgagg4MlVFdyKwiOBNHW+nZsq+2kN4ujl7w75dDJwKxCeRjTx5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oGm5E8Rt; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oGm5E8Rt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716903326; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OZLSV2t9eunU4nfd1YdBUuXiC5UgCpD+d7zNosGc0Zg=;
	b=oGm5E8RtdaO7L1mMCLIOXvwOUPDGPby4z58nWQGSYvCPxgPLDSLvCmmagpY7P7/oUSGETIOnywvDhAbQnbD4TzhVAlPK1ZHnGKkXjhTNOlzuL3BlhRQ8PhBz4Lng9s9SyBT5KLwsuqnhGT/EClmiO9YopEkogqDzsC1a6cVHmk4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W7PmGLl_1716903324;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7PmGLl_1716903324)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 21:35:25 +0800
Message-ID: <1672df38-7b97-41f5-802d-ee50f83a885f@linux.alibaba.com>
Date: Tue, 28 May 2024 21:35:22 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-fs: add multi-queue support
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Peter-Jan Gootzen <pgootzen@nvidia.com>, virtualization@lists.linux.dev,
 vgoyal@redhat.com, stefanha@redhat.com, mst@redhat.com, dgilbert@redhat.com,
 yorayz@nvidia.comm, gurtovoy@nvidia.com, Yoray Zack <yorayz@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
 <20240501153817.540855-3-pgootzen@nvidia.com>
 <08795907-fb19-47d7-a8c9-3db0ecc91889@linux.alibaba.com>
 <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegs7Dgn1++gYU5jNmCbiJwDFxWShgH_0fkaSN13nmbiY-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/24 7:59 PM, Miklos Szeredi wrote:
> On Tue, 28 May 2024 at 10:52, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi Peter-Jan,
>>
>> Thanks for the amazing work.
>>
>> I'd just like to know if you have any plan of making fiq and fiq->lock
>> more scalable, e.g. make fiq a per-CPU software queue?
> 
> Doing a per-CPU queue is not necessarily a good idea: async requests
> could overload one queue while others are idle.

It is in FUSE scenarios (instead of virtiofs). There's no 1:1 mapping
between CPUs and daemon threads.  All requests submitted from all CPUs
are enqueued in one global pending list, and all daemon threads fetch
request to be processed from this global pending list.

> 
> One idea is to allow request to go through a per-CPU fast path if the
> respective listener is idle.  Otherwise the request would enter the
> default slow queue, where idle listeners would pick requests (like
> they do now).

I guess "listener" refers to one thread of fuse daemon.


When coming to virtiofs scenarios, there's 1:1 mapping between CPUs and
hardware queues.  The requests will only be routed to the hardware queue
to which the submitter CPU maps, and thus there's no meaning still
managing pending requests in one global pending list.  In this case, the
per-CPU pending list theoretically can reduce the lock contention on the
global pending list.


I guess we have an internal RFC on per-CPU pending list for virtiofs.
Let me see if this really improves the performance from test.


-- 
Thanks,
Jingbo
