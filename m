Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4612A177
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432650; cv=none; b=N35LtTi3LX4G/G+0ihIhlTo6TVpSfEgjdbVyGJwHt+4QkvaHBQmdEXdu/r7b2OPcKzu4J4pGERsH6a3JBX/3arRpCrxt/ekgWYnpBtdSd6JD1HU9YzituJNrcCvpFeVpZNERENMhBkBsq6lR9agoz9WWqRRM1YnJHewHuWtAlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432650; c=relaxed/simple;
	bh=Z0YNq+eVbjHnxC3tOFviiutyi62Fmp8Ac8QeSDs/8Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2nBIkLhR8dzblUtGAj/n68Pi+aSEaxeB+czA32+QUoj5ECFNvQYEr0aFLcSpRdoNGCXOy2xqU/P5mLjpyxMPW0w8IVkYJuhavmJ5uSWS/Fmv5IkjI7vJH+CaryWSE8VuPsQo2/FBC4iBSDuz2Jm5jn4dwZ4tFxww/27f4TN9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NZkGsIVd; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NZkGsIVd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711432645; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Z0YNq+eVbjHnxC3tOFviiutyi62Fmp8Ac8QeSDs/8Bo=;
	b=NZkGsIVdSSzgSezUUMtV5GosCVuzSeIZAmYeRmL3G35rt6d9w8ZZOqf9z50YYW4TLeMDzCrkBfOudoHBfDY6L7u65P02YXTY9gP/CaeEbhktBhx05qMo3fuuD1XBzVE6WksIS+O04CByeCSY0i3XmjEDjO9ZYL8QG1pby4SOwh0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3JroXV_1711432643;
Received: from 30.221.149.28(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3JroXV_1711432643)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 13:57:24 +0800
Message-ID: <75f1ae35-aeee-404a-be1c-2ffa05126cdb@linux.alibaba.com>
Date: Tue, 26 Mar 2024 13:57:21 +0800
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
 <b54ad370-67bd-4b8c-82fb-54625e68288b@linux.alibaba.com>
 <CACGkMEv88U1_2K2b0KdmH97gfrdOvK_1ajqh=UTK6=KgZ4OYvQ@mail.gmail.com>
 <36ce2bbf-3a31-4c01-99f3-1875f79e2831@linux.alibaba.com>
 <CACGkMEvShZKd7AvMFtmEWBVGQsQrGkQMTEx8yQYYU0uYqp=uMg@mail.gmail.com>
 <62451c11-0957-4d1b-8a34-5e224ea552e0@linux.alibaba.com>
 <CACGkMEsvsmyUaTD35kp=4qJhMdDYG=hGVbT0JGGTwGTb3XRuLg@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEsvsmyUaTD35kp=4qJhMdDYG=hGVbT0JGGTwGTb3XRuLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/26 下午12:08, Jason Wang 写道:
> On Tue, Mar 26, 2024 at 10:46 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2024/3/25 下午4:42, Jason Wang 写道:
>>> On Mon, Mar 25, 2024 at 4:22 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>
>>>> 在 2024/3/25 下午3:56, Jason Wang 写道:
>>>>> On Mon, Mar 25, 2024 at 3:18 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>> 在 2024/3/25 下午1:57, Jason Wang 写道:
>>>>>>> On Mon, Mar 25, 2024 at 10:21 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>>>> 在 2024/3/22 下午1:19, Jason Wang 写道:
>>>>>>>>> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>>>>>> Currently, ctrlq processes commands in a synchronous manner,
>>>>>>>>>> which increases the delay of dim commands when configuring
>>>>>>>>>> multi-queue VMs, which in turn causes the CPU utilization to
>>>>>>>>>> increase and interferes with the performance of dim.
>>>>>>>>>>
>>>>>>>>>> Therefore we asynchronously process ctlq's dim commands.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>>>>>> I may miss some previous discussions.
>>>>>>>>>
>>>>>>>>> But at least the changelog needs to explain why you don't use interrupt.
>>>>>>>> Will add, but reply here first.
>>>>>>>>
>>>>>>>> When upgrading the driver's ctrlq to use interrupt, problems may occur
>>>>>>>> with some existing devices.
>>>>>>>> For example, when existing devices are replaced with new drivers, they
>>>>>>>> may not work.
>>>>>>>> Or, if the guest OS supported by the new device is replaced by an old
>>>>>>>> downstream OS product, it will not be usable.
>>>>>>>>
>>>>>>>> Although, ctrlq has the same capabilities as IOq in the virtio spec,
>>>>>>>> this does have historical baggage.
>>>>>>> I don't think the upstream Linux drivers need to workaround buggy
>>>>>>> devices. Or it is a good excuse to block configure interrupts.
>>>>>> Of course I agree. Our DPU devices support ctrlq irq natively, as long
>>>>>> as the guest os opens irq to ctrlq.
>>>>>>
>>>>>> If other products have no problem with this, I would prefer to use irq
>>>>>> to solve this problem, which is the most essential solution.
>>>>> Let's do that.
>>>> Ok, will do.
>>>>
>>>> Do you have the link to the patch where you previously modified the
>>>> control queue for interrupt notifications.
>>>> I think a new patch could be made on top of it, but I can't seem to find it.
>>> Something like this?
>> YES. Thanks Jason.
>>
>>> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.com/t/
>>>
>>> Note that
>>>
>>> 1) some patch has been merged
>>> 2) we probably need to drop the timeout logic as it's another topic
>>> 3) need to address other comments
>> I did a quick read of your patch sets from the previous 5 version:
>> [1]
>> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.com/t/
>> [2] https://lore.kernel.org/all/20221226074908.8154-1-jasowang@redhat.com/
>> [3] https://lore.kernel.org/all/20230413064027.13267-1-jasowang@redhat.com/
>> [4] https://lore.kernel.org/all/20230524081842.3060-1-jasowang@redhat.com/
>> [5] https://lore.kernel.org/all/20230720083839.481487-1-jasowang@redhat.com/
>>
>> Regarding adding the interrupt to ctrlq, there are a few points where
>> there is no agreement,
>> which I summarize below.
>>
>> 1. Require additional interrupt vector resource
>> https://lore.kernel.org/all/20230516165043-mutt-send-email-mst@kernel.org/
> I don't think one more vector is a big problem. Multiqueue will
> require much more than this.
>
> Even if it is, we can try to share an interrupt as Michael suggests.
>
> Let's start from something that is simple, just one more vector.

OK, that puts my concerns to rest.

>
>> 2. Adding the interrupt for ctrlq may break some devices
>> https://lore.kernel.org/all/f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.com/
> These devices need to be fixed. It's hard to imagine the evolution of
> virtio-net is blocked by buggy devices.

Agree.

>
>> 3. RTNL breaks surprise removal
>> https://lore.kernel.org/all/20230720170001-mutt-send-email-mst@kernel.org/
> The comment is for indefinite waiting for ctrl vq which turns out to
> be another issue.
>
> For the removal, we just need to do the wakeup then everything is fine.

Then I will make a patch set based on irq and without timeout.

>
>> Regarding the above, there seems to be no conclusion yet.
>> If these problems still exist, I think this patch is good enough and we
>> can merge it first.
> I don't think so, poll turns out to be problematic for a lot of cases.
>
>> For the third point, it seems to be being solved by Daniel now [6], but
>> spink lock is used,
>> which I think conflicts with the way of adding interrupts to ctrlq.
>>
>> [6] https://lore.kernel.org/all/20240325214912.323749-1-danielj@nvidia.com/
> I don't see how it conflicts with this.

I'll just make changes on top of it. Can I?

Thanks,
Heng

>
> Thanks
>
>>
>> Thanks,
>> Heng
>>
>>> THanks
>>>
>>>
>>>> Thanks,
>>>> Heng
>>>>
>>>>> Thanks
>>>>>
>>>>>>> And I remember you told us your device doesn't have such an issue.
>>>>>> YES.
>>>>>>
>>>>>> Thanks,
>>>>>> Heng
>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Heng
>>>>>>>>
>>>>>>>>> Thanks

