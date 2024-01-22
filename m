Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7363C
	for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889544; cv=none; b=fP1SCB79dIojBivyAb9JBDdouMDaQSgMnlSuP8RuN98lGBQKlbAjnf4PaZukxMfEO/68A4vfOr1UsHFg7NrTcJBMJ2+FHlCXUy08a/RzVT5LyXZhXQwmtYC7sU/ls+AOnAbS15uHIVeeheIydv38IW4Ivc9fjldmh9hnLnAd2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889544; c=relaxed/simple;
	bh=oNv4o9o9tRfsG+JGqIYZXTByroNF80ULNbCLqByX5AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDG1Vvy8Z9sz+GFC1BCemP3DuQUU+aE9KAwcews1WEWmz8BwOO1LRo+0xaYJvF8dUSZXMYQRbmK7rDBtXwoDQ1oG1EHg4wb42segsqDSug9noVp7l05UBCwnj1Edlumc0TUl8BxSNzDkG+/mZKD6tMJLeQK2BK3zoEJNWoWE7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nTAto0eb; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nTAto0eb"
Message-ID: <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705889540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9Z8zlhSyhWT9mMG7D9a1D7Qu+r3YhbOg1Qrk4gn5M=;
	b=nTAto0ebANGTNSyu8hi3jEJnozM3/m9YZYNi4YBF5k5jmlPPJ8CxKixhsQL8ilQ5a5imOh
	AMnk/pTzlmMw6jLeTaeARWDLCpeu86j3W7ZbDh3kdKRN6vdHX8v/NDkDyRBGBINo1wg+t5
	H1bye+kGwTGSnCLX1OEMUnW8RuhTwZk=
Date: Mon, 22 Jan 2024 10:12:15 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev>
 <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
 <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/1/20 1:29, Andrew Lunn 写道:
>>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>>>>> -           !virtqueue_is_broken(vi->cvq))
>>>>> +           !virtqueue_is_broken(vi->cvq)) {
>>>>> +        if (timeout)
>>>>> +            timeout--;
>>>> This is not really a timeout, just a loop counter. 200 iterations could
>>>> be a very short time on reasonable H/W. I guess this avoid the soft
>>>> lockup, but possibly (likely?) breaks the functionality when we need to
>>>> loop for some non negligible time.
>>>>
>>>> I fear we need a more complex solution, as mentioned by Micheal in the
>>>> thread you quoted.
>>> Got it. I also look forward to the more complex solution to this problem.
>> Can we add a device capability (new feature bit) such as ctrq_wait_timeout
>> to get a reasonable timeout？
> The usual solution to this is include/linux/iopoll.h. If you can sleep
> read_poll_timeout() otherwise read_poll_timeout_atomic().

I read carefully the functions read_poll_timeout() and 
read_poll_timeout_atomic(). The timeout is set by the caller of the 2 
functions.

As such, can we add a module parameter to customize this timeout value 
by the user?

Or this timeout value is stored in device register, virtio_net driver 
will read this timeout value at initialization?

Zhu Yanjun

>
> 	Andrew
