Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4009468B
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bnSB12l7"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F03DB60B22
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 05:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F03DB60B22
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bnSB12l7
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6oqe34ujGVoa
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 05:24:40 +0000 (UTC)
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C4C960807
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 05:24:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C4C960807
Message-ID: <b6ad5935-eb31-43f6-8573-0f07343876e8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701667477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0n2D/tnKgjpK2IUTwVrFHT+iGyrOIMwpCUFmx4lMTU=;
	b=bnSB12l7yn8qLQ9sVFvz8Gy4jPgIDLSnGlmeiELwTQMNSv1zPVlmP3/sYWhcg+DmjNbscD
	O3RdF1TahhVPmYdEzaPBJydGbmC7cnj0+U7NKN1bRJDsqS+Dw+7/Gx1FUl6ws6oks+SKNZ
	H3sKARcUQk0Zw/ORM1cy6Fie+iJhZkA=
Date: Mon, 4 Dec 2023 13:24:28 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve
 performance
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, pabeni@redhat.com, alexander.duyck@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
 <20231129095825-mutt-send-email-mst@kernel.org>
 <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
 <0c2efe49-03db-4616-a4e5-26ff0434e323@linux.dev>
 <1701311694.1163726-1-xuanzhuo@linux.alibaba.com>
 <c4397388-dc39-4799-b386-93ce5956c106@linux.dev>
 <1701394709.904543-1-xuanzhuo@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1701394709.904543-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/12/1 9:38, Xuan Zhuo 写道:
> On Thu, 30 Nov 2023 13:30:40 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2023/11/30 10:34, Xuan Zhuo 写道:
>>> On Wed, 29 Nov 2023 23:29:10 +0800, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>> 在 2023/11/29 23:22, Zhu Yanjun 写道:
>>>>> 在 2023/11/29 22:59, Michael S. Tsirkin 写道:
>>>>>> On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
>>>>>>> 在 2023/5/26 13:46, Liang Chen 写道:
>>>>>> what made you respond to a patch from May, now?
>>>>> I want to apply page_pool to our virtio_net. This virtio_net works on
>>>>> our device.
>>>>>
>>>>> I want to verify whether page_pool on virtio_net with our device can
>>>>> improve the performance or not.
>>>>>
>>>>> And I found that ethtool is wrong.
>>>>>
>>>>> I use virtio_net on our device. I found that page member variable in
>>>>> rq is not used in recv path.
>>>>>
>>>>> When virtio_net is modprobe, I checked page member variable in rq with
>>>>> kprobe or crash tool.  page member variable in rq is always NULL.
>>>>>
>>>>> But sg in recv path is used.
>>>>>
>>>>> So how to use page member variable in rq? If page member variable in
>>>>> rq is always NULL, can we remove it?
>>>>>
>>>>> BTW, I use ping and iperf tool to make tests with virtio_net. In the
>>>>> tests, page member variable in rq is always NULL.
>>>>
>>>> And I replaced page member variable in rq with page_pool, but the
>>>> statistics of page_pool are always 0.
>>>>
>>>> It is interesting that page_pool member variable in rq is not used in
>>>> ping and iperf tests.
>>>>
>>>> I am not sure what tests can make page member variable not NULL. ^_^
>>> Do you mean rq->pages?
>>>
>>> That is for big mode.
>>
>> Hi, Xuan
>>
>> Got it. What is big mode? Do you mean big packet size? I run iperf with
>> the packet size 2^23.
>>
>> The rq->pages is still NULL.
>>
>> It is interesting.
> 
> You may need to check the code of virtnet_probe().

Thanks a lot. From virtnet_probe, big mode and mergeable mode can be found.

Zhu Yanjun

> 
> Thanks.
> 
> 
>>
>> Zhu Yanjun
>>
>>
>>>
>>> Thanks.
>>>
>>>
>>>> Best Regards,
>>>>
>>>> Zhu Yanjun
>>>>
>>>>
>>>>> It is interesting.
>>>>>
>>>>> Zhu Yanjun
>>>>>

