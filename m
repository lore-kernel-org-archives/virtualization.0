Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB538F248;
	Sun, 10 May 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421715; cv=none; b=uP+Ye/aKcydEEh1Z4l7rFOqqcPyhaKy96Vum2GWeG8z9XGybexTBtr6XuV95uP73pdxeeIywDtMs31pgLMaUWsxLEWAmfnEcYwxwJSHa+uWF6LcNQ/Rz3LIqcBK1q42GzHjAuDE4Oke/hZWolIY6QAKy7ADIJ5AZz6yihemdDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421715; c=relaxed/simple;
	bh=pw/uO6m0Sg2bglCT9rAWris8gNtorzr200PzIc8N47E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUPWNN+8SWCPvXu5BezComBnOjiUaGnqRGgGh2Z84z/p2OCrZCUmsaXGG5/h5jSEtzqOqCpC//un+TXUyFygaqv4tf+DfqnljRZMQsRKhvPVnyR/8u3EhHFfhzCP6yQ0kF90jCFtzBHNwEep3QeJl8woDgOoeH3AY+PlfKwwsJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=nEv/p7Eg; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="nEv/p7Eg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778421701;
	bh=pw/uO6m0Sg2bglCT9rAWris8gNtorzr200PzIc8N47E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nEv/p7EgjFYW6Q54yovVjH8J+5O91CXq0eC6Tl+VYu5Ah7pGQOhku3C1iYXcSb7wd
	 SMiCA3gXFsb/cp4uvQpMglqLjaPjIhJ+Aqb+HtlJ5+B9Z+mXe1VCkU+uTizJ/3fV75
	 +x9NGCSo370EFkTLKBzqIdTPdyWrcc9ZHCXCO4V8=
Received: from [192.168.178.127] (pd9eaa57d.dip0.t-ipconnect.de [217.234.165.125])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64AE1eEY013681
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 16:01:40 +0200 (CEST)
Message-ID: <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
Date: Sun, 10 May 2026 16:01:39 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
 <20260510094020-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260510094020-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 15:40, Michael S. Tsirkin wrote:
> On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
>> On 5/10/26 09:03, Simon Schippers wrote:
>>> On 5/10/26 00:44, Michael S. Tsirkin wrote:
>>>> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
>>>>> On 5/8/26 17:10, Simon Schippers wrote:
>>>>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
>>>>>>  {
>>>>>>  	void *ptr;
>>>>>>  
>>>>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
>>>>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
>>>>>>  		tun_ptr_free(ptr);
>>>>>>  
>>>>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
>>>>>
>>>>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
>>>>> operates on a tfile that is being torn down. Its queue_index is no
>>>>> longer valid. After the swap in __tun_detach(), it points to the
>>>>> netdev subqueue of a different tfile.
>>>>> --> We should not wake there.
>>>>
>>>> Does it not exactly point at ntfile which is what we want to wake?
>>>>
>>>
>>> I see your point. But calling tun_ring_consume() as done here is
>>> wrong, because it does not wake if the tx_ring of the tfile 
>>> (that is currently torn down) is empty. We could change
>>> tun_ring_consume() to call __tun_wake_queue()
>>> with consumed=0 if !ptr but I think this would slow down the consumer
>>> path.
>>>
>>
>> My statement is wrong:
>> There is no way that the tx_ring is empty and the queue is stopped
>> at the same time. So we do not need to touch tun_ring_consume() and
>> this works just fine.
>>
>>>>
>>>>> I will swap tun_ring_consume() with ptr_ring_consume() again and
>>>>> submit a v12 :)
>>>>
>>>> If so then maybe
>>>> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
>>>>
>>>
>>> But we should only do this if there is space in the ntfile.
>>> My approach:
>>>
>>> @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
>>>  		BUG_ON(index >= tun->numqueues);
>>>  
>>>  		rcu_assign_pointer(tun->tfiles[index],
>>>  				   tun->tfiles[tun->numqueues - 1]);
>>>  		ntfile = rtnl_dereference(tun->tfiles[index]);
>>> +		spin_lock(&ntfile->tx_ring.consumer_lock);
>>>  		ntfile->queue_index = index;
>>>  		ntfile->xdp_rxq.queue_index = index;
>>> +		ntfile->cons_cnt = 0;
>>> +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
>>> +			netif_wake_subqueue(tun->dev, index);
>>> +		}
>>> +		spin_unlock(&ntfile->tx_ring.consumer_lock);
>>>  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
>>>  				   NULL);
>>>
>>> ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
>>> That is the reason why I reset it to 0.
>>
>> However, I still prefer this approach because the code is easier to
>> understand.
> 
> 
> So do you want me to finish review of this one and ack, or want to
> post v12?
> 

I will post a v12 with the proposed changes for patch 1.
No other changes.

Thanks!

