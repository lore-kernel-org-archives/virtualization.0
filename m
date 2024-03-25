Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9814F102
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354947; cv=none; b=lSr3qDjWaYZ8WB4+hpquIlAcI+tX0s7yiiRbY58IBRD4hCfASm7GnKWHBCriYOtImCFze349+4SqdkuY9PVC5VdL+9I1b/N38Ids+arJdP3Dy6oCA+IjX8gqF5jRxYwY40eaZDuTZC8pmREK2f2wtYBTFTY0ZKxToAQpxLwtn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354947; c=relaxed/simple;
	bh=b9FmiI9Sq+TCqOP+A6HV/teAqMiEHMNA8KXPT7w4IrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ta47jXrW6RWVh9WCEpOuSSt42XlWZazHmyvDmuDohSP+n2pbqPfAkLtbOqcw1P0XMYXBgHH9UfK8AXMH2IRatCTC7XEufdMgg3Zw5q14XtNLcBRhSw++DDxluszG4oB/kw8jF/Edg9ab/UNPjVFC6Au7UWKarEjo3HfkziSgjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xq+Wc0ec; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xq+Wc0ec"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711354942; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bEzipBhG/k4adub5cfWHCJ/NQav+qWnAiGWpYm5ooOA=;
	b=xq+Wc0ecTjmp7A7yCPoz5OsCeYmD7naJFJYSlrA/7yUf70p7o1a2HoGm8bFSkCBG39hRmcEVCTQy1jRe6yITwebOxOq/U3cxgx6I4c2FZc/rqHFnNrBuMQLsI+Uc4cJweVIs5OWSfFnC2VxKszO7aWGegLPudx5ka9zxInYpMfI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3CFn.C_1711354940;
Received: from 30.221.148.153(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3CFn.C_1711354940)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:22:21 +0800
Message-ID: <36ce2bbf-3a31-4c01-99f3-1875f79e2831@linux.alibaba.com>
Date: Mon, 25 Mar 2024 16:22:17 +0800
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEv88U1_2K2b0KdmH97gfrdOvK_1ajqh=UTK6=KgZ4OYvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/25 下午3:56, Jason Wang 写道:
> On Mon, Mar 25, 2024 at 3:18 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2024/3/25 下午1:57, Jason Wang 写道:
>>> On Mon, Mar 25, 2024 at 10:21 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>
>>>> 在 2024/3/22 下午1:19, Jason Wang 写道:
>>>>> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>> Currently, ctrlq processes commands in a synchronous manner,
>>>>>> which increases the delay of dim commands when configuring
>>>>>> multi-queue VMs, which in turn causes the CPU utilization to
>>>>>> increase and interferes with the performance of dim.
>>>>>>
>>>>>> Therefore we asynchronously process ctlq's dim commands.
>>>>>>
>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>> I may miss some previous discussions.
>>>>>
>>>>> But at least the changelog needs to explain why you don't use interrupt.
>>>> Will add, but reply here first.
>>>>
>>>> When upgrading the driver's ctrlq to use interrupt, problems may occur
>>>> with some existing devices.
>>>> For example, when existing devices are replaced with new drivers, they
>>>> may not work.
>>>> Or, if the guest OS supported by the new device is replaced by an old
>>>> downstream OS product, it will not be usable.
>>>>
>>>> Although, ctrlq has the same capabilities as IOq in the virtio spec,
>>>> this does have historical baggage.
>>> I don't think the upstream Linux drivers need to workaround buggy
>>> devices. Or it is a good excuse to block configure interrupts.
>> Of course I agree. Our DPU devices support ctrlq irq natively, as long
>> as the guest os opens irq to ctrlq.
>>
>> If other products have no problem with this, I would prefer to use irq
>> to solve this problem, which is the most essential solution.
> Let's do that.

Ok, will do.

Do you have the link to the patch where you previously modified the 
control queue for interrupt notifications.
I think a new patch could be made on top of it, but I can't seem to find it.

Thanks,
Heng

>
> Thanks
>
>>> And I remember you told us your device doesn't have such an issue.
>> YES.
>>
>> Thanks,
>> Heng
>>
>>> Thanks
>>>
>>>> Thanks,
>>>> Heng
>>>>
>>>>> Thanks

