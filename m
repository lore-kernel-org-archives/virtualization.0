Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76001869DF
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351081; cv=none; b=KoFLp5+vTXdX9LyyTmcG6HvMAIXDKI4ttQFJiLm/0eLsloX+FTebOgLX1EQpUi1nojFwI79/KXAothA3GWBoIzWLl1FnjTgyaZyqD5ztLSsW8xyb6l7QjmI63thwR5e6ItDoNBGtpA4lJ/8fDj/rbTEvgA1LyTzxLGYd+aRdBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351081; c=relaxed/simple;
	bh=JtxnzxGrTffDEA0XnqvlYJualvaU/GrEhGNY/kmUU7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtqqUUv9tJ6SwtTPEGyQ6em5XZ/KSdlhU6go97MURJWh4XXtI05FnSnHc7zwU0lWQpFgxqSw5aWRFNK7PdelKIcvUZulMiVzU+PzgAQNmojGNm9mZ/xiXLxhcxEo5AL2NGfbd2Ioav1q3zxcWm8XjZu3yYDBFuxygkaTOAN1wfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iqxWQa4i; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iqxWQa4i"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711351071; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uiAJzlkaILI73D+td4TN5g1wQlkiDXtOcSrE97onzLo=;
	b=iqxWQa4ih7FSTNcCG3hmgk/zPSkYlnjGB4cL9pGH4pypySHC9Igz0RcyPt/ZJQMRQ+AcJQKn9bu9O3c5sZFD3DR9s7KDRG3QN1+FitRighrrHpj+dXdGFa0bw5qp1ARFfdlBUdnMWCV8MvEi4gLvHP7K2gHSJIFT7rLZAUEmJKs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3B4ysg_1711351069;
Received: from 30.221.148.153(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3B4ysg_1711351069)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 15:17:50 +0800
Message-ID: <b54ad370-67bd-4b8c-82fb-54625e68288b@linux.alibaba.com>
Date: Mon, 25 Mar 2024 15:17:47 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
 <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com>
 <CACGkMEu8or7+fw3+vX_PY3Qsrm7zVSf6TS9SiE20NpOsz-or6g@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEu8or7+fw3+vX_PY3Qsrm7zVSf6TS9SiE20NpOsz-or6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/25 下午1:57, Jason Wang 写道:
> On Mon, Mar 25, 2024 at 10:21 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2024/3/22 下午1:19, Jason Wang 写道:
>>> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>> Currently, ctrlq processes commands in a synchronous manner,
>>>> which increases the delay of dim commands when configuring
>>>> multi-queue VMs, which in turn causes the CPU utilization to
>>>> increase and interferes with the performance of dim.
>>>>
>>>> Therefore we asynchronously process ctlq's dim commands.
>>>>
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> I may miss some previous discussions.
>>>
>>> But at least the changelog needs to explain why you don't use interrupt.
>> Will add, but reply here first.
>>
>> When upgrading the driver's ctrlq to use interrupt, problems may occur
>> with some existing devices.
>> For example, when existing devices are replaced with new drivers, they
>> may not work.
>> Or, if the guest OS supported by the new device is replaced by an old
>> downstream OS product, it will not be usable.
>>
>> Although, ctrlq has the same capabilities as IOq in the virtio spec,
>> this does have historical baggage.
> I don't think the upstream Linux drivers need to workaround buggy
> devices. Or it is a good excuse to block configure interrupts.

Of course I agree. Our DPU devices support ctrlq irq natively, as long 
as the guest os opens irq to ctrlq.

If other products have no problem with this, I would prefer to use irq 
to solve this problem, which is the most essential solution.

>
> And I remember you told us your device doesn't have such an issue.

YES.

Thanks,
Heng

>
> Thanks
>
>> Thanks,
>> Heng
>>
>>> Thanks

