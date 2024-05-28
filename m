Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F413D88B
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887612; cv=none; b=g/H1Xe8KfpNdDtFd2+3zhfrZVH0C2ou+qw4TgCB6QYKfTLbadNws+TjzQt91TPib3ySMxYw92Euo1fXCV3lb38N0Iqu0JwAiCDXCmDMWDGkmJVVybI9kkT20ADIeYbJnbgIHdx+MkOgtO/68j5QNyNYhW4371SFPxp7qirJuyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887612; c=relaxed/simple;
	bh=wK7yc9Vfmv5WMGzVoYJuIthKIvC5Cy2YTl1niLd95Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQsmpZvR5hBC086pt8+yoG8LGnby7+wiKY2Gw6A8B74seu8XgJCc8T6Ygwkuw1S0YbBKkk6kvHzetUus2I/Vj1uoc+jvY3pifH4VvHxjmWeTgZiZmAoepU6dlEcEL40eBEgpr2k8rru4gDrVITvgTbjI6CINyZBE4VPs7Lh0NOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X2uhNJ37; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X2uhNJ37"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716887606; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CMmkg1OSNi03F/ITbkU/Lkg43wmG0NVov6lqkB+jhEg=;
	b=X2uhNJ37/InH7CxUYYPiJjJ1ZFiQlX6COqBcBc2BdRk99K+VkSx0QBFxQF4WXUfOGxB1BiklldbKiRCTYc8ERdf2DqkXbWbNIMKdGc62d7fhJBWz7LOjYrbzdzs3EuXRryVTiy+VD0iocHE5yh0yvLfs0ebLLpfnh/c5m2zdogg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W7P5.X8_1716887604;
Received: from 30.221.144.199(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7P5.X8_1716887604)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 17:13:26 +0800
Message-ID: <cfcaeedc-e375-4024-8abd-8a88aa4e4014@linux.alibaba.com>
Date: Tue, 28 May 2024 17:13:24 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-fs: limit number of request queues
To: Peter-Jan Gootzen <pgootzen@nvidia.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "miklos@szeredi.hu" <miklos@szeredi.hu>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, Yoray Zack <yorayz@nvidia.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
 <20240501153817.540855-2-pgootzen@nvidia.com>
 <6798df13-4db3-4165-a6f7-d8a7201b7093@linux.alibaba.com>
 <91722cfc27ff57a0963d4f55f5ac241a5e407f84.camel@nvidia.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <91722cfc27ff57a0963d4f55f5ac241a5e407f84.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/28/24 5:05 PM, Peter-Jan Gootzen wrote:
> Hi Jingbo,
> 
> On Tue, 2024-05-28 at 16:40 +0800, Jingbo Xu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Peter-Jan,
>>
>> Thanks for the amazing work! Glad to see it is upstreamed.  We are
>> also
>> planning distribute virtiofs on DPU.
> Great to hear that virtio-fs is getting more attention with this
> powerful approach :)
> 
>>
>> BTW I have some questions when reading the patch, appreciate if you
>> could give a hint.
>>
>>
>> On 5/1/24 11:38 PM, Peter-Jan Gootzen wrote:
>>> Virtio-fs devices might allocate significant resources to virtio
>>> queues
>>> such as CPU cores that busy poll on the queue. The device indicates
>>> how
>>> many request queues it can support and the driver should initialize
>>> the
>>> number of queues that they want to utilize.
>>
>> I'm okay with truncating the num_request_queues to nr_cpu_ids if the
>> number of the available queues exceeds nr_cpu_ids, as generally 1:1
>> mapping between cpus and queues is enough and we can not make use more
>> queues in this case.
>>
>> I just don't understand the above commit message as how this relates
>> to
>> the resource footprint at the device side.  When the the number of the
>> queues actually used by the driver (e.g. nr_cpu_ids is 6) is less than
>> the amount (e.g. 8) that is advertised by the driver, will the device
>> side reclaim the resources allocated for the remaining unused queues?
>> The driver has no way notifying how many queues it actually utilizes.
> 
> The device resources allocated to queues is device implementation
> specific. So the cost of the driver creating more queues than it will
> ultimately use, is dependent on how the specific device handles these
> unsused queues.
> A smart device could at some point decide to spend less polling
> resources on a queue if it sees that it is unused (reclaiming the
> resources as you put it).
> 
> But in my opinion, the driver should not allocate more than it will use.
> The new scheme tries to map every core to a queue, so we know that we
> will not use >nr_cpu_ids queues.


Okay got it.  Many thanks for the reply.


-- 
Thanks,
Jingbo
