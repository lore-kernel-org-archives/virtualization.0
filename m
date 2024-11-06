Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91B1DE2BA;
	Wed,  6 Nov 2024 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730887764; cv=none; b=tcwXvqcS9QhloZ/VpmMumjHFN02OBEDybY/JWcLNQnY3Hd/ivtjbIHBE85pf49PK9JSJHhIzofTGWSLU4XWYKwxCaKPz3SKShHwG6/gn0pWFtU/7RTEGg4sBvPOTp120ihQqDy23L4moeNq2Ggppiua3cKHZCTV87+ddFjXiK2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730887764; c=relaxed/simple;
	bh=ZXjtkaFmt4U5PUsxfs5KDb85QQBjEtLWcblweYD/SMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqiuahcPsRo3b23k6TFQz6KULS6hJ4MPDIVNyjvniP+f5yoSZQeMlzHmthTvPcNLFmGdzV8nx1w01yxJ8ewxn2JlyVzszNAFs0rX7/jJKRmRTakjYJ9OmlvW7mCUOe25K6hRd4a6NP3FgKZ6PDtB38Hv7zIhMn4U5yBb10/JoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jzs8NDcv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jzs8NDcv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=nGFeHOlSP+QwIymN7Hl23pOChbDXLiumQcA5mZ6uMxA=;
	t=1730887762; x=1731319762; b=jzs8NDcvqsQVlZjiLrfDeAkAW9qE+LZDU4z/s7pxiD5QAkT
	Qg4V6BnOyiChOrxLrvshtgY+ix1uTKvGpJgMe+uVNQhWjnQFcLOHWPDGy23llOmd+xtdIKpBmkB2K
	lTQPbGP+3PqjDLQOIbkIXCJWWv+vQ+DG7CcfMMLl1O8E1cKyfa5PJA8ztsmAdc/4Lqp9qo0XBxfY2
	og5/tK9gNaeQcrl2kOwCJO2xI7kUy3nyMM/iLc5qHLp8igB259U9BWIXIqeOTVLJoJY10JB/MBEKh
	yt2tqYKYsdEp/9MCjaOmI22KZvX8aVSsQ6uIRaWsnLbVuE82yQU7IMG5X3NlL/yA==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t8cyW-0002vU-4b; Wed, 06 Nov 2024 11:09:20 +0100
Message-ID: <35b03c6d-a083-407e-a0db-85d5dedcd335@leemhuis.info>
Date: Wed, 6 Nov 2024 11:09:17 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net] with 6.10.7 and
 packed virtqueues
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 virtualization@lists.linux.dev,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
References: <CAK8fFZ6qVutPWxquHg7NEvFqYqDP5BwEdO81hqW8iMFxJFuLSQ@mail.gmail.com>
 <CAK8fFZ5N7EbU=uLbfyeSkQ273NSm+GELWUu1O1OBCpaSwjv6FA@mail.gmail.com>
 <422f35b3-7834-4df7-bcea-e3be12707aef@leemhuis.info>
 <1726216954.7439098-1-xuanzhuo@linux.alibaba.com>
 <565a9204-362d-458d-8b8e-11c5aada7b98@leemhuis.info>
 <CAK8fFZ6W2ZfwTa4nYz8ORTgb0mOTysg89LEEz7cHGtdqwpsvmA@mail.gmail.com>
 <20240913103753-mutt-send-email-mst@kernel.org>
 <CAK8fFZ4ONa_LYsyPN1E6QvUz4uUbzm35yfh6_dHUMDSxzySm3A@mail.gmail.com>
 <20241106035955-mutt-send-email-mst@kernel.org>
 <1730883874.818401-4-xuanzhuo@linux.alibaba.com>
 <20241106044241-mutt-send-email-mst@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-MW
In-Reply-To: <20241106044241-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1730887762;7b527112;
X-HE-SMSGID: 1t8cyW-0002vU-4b

On 06.11.24 10:43, Michael S. Tsirkin wrote:
> On Wed, Nov 06, 2024 at 05:04:34PM +0800, Xuan Zhuo wrote:
>> On Wed, 6 Nov 2024 04:01:43 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>> On Mon, Sep 16, 2024 at 09:32:38AM +0200, Jaroslav Pulchart wrote:
>>>>> On Fri, Sep 13, 2024 at 11:21:11AM +0200, Jaroslav Pulchart wrote:
>>>>>>
>>>>>> 1/ I was able to "do a reproducer" and hit the "random memory
>>>>>> corruption" issue with vanila 6.10.10 in our setup in ~28m of uptime
>>>>>> see attached 6.10.10-1.gdc.el9.x86_64.log.
>>>>>> 2/ I reverted these commits
>>>>>> "virtio_net: rx remove premapped failover code":
>>>>>> defd28aa5acb0fd7c15adc6bc40a8ac277d04dea
>>>>>> "virtio_net: big mode skip the unmap check":
>>>>>> a377ae542d8d0a20a3173da3bbba72e045bea7a9
>>>>>> "virtio_ring: enable premapped mode whatever use_dma_api":
>>>>>> f9dac92ba9081062a6477ee015bd3b8c5914efc4
>>>>>> in our next build and so far the environment is stable and not
>>>>>> crashing under same conditions like the previous crash.
>>>>>
>>>>> Automated backport failed:
>>>>>
>>>>> http://lore.kernel.org/all/2024091336-family-daffodil-541d@gregkh
>>>>>
>>>>> Since you have done the revert, and actually tested it, feel free
>>>>> to post, I will ack.
>>>>
>>>> What I did is:
>>>> git checkout linux-6.10.y
>>>> git revert defd28aa5acb0fd7c15adc6bc40a8ac277d04dea
>>>> git revert a377ae542d8d0a20a3173da3bbba72e045bea7a9
>>>> git revert f9dac92ba9081062a6477ee015bd3b8c5914efc4
>>>> (no changes nor fixing conflicts was needed)
>>>>
>>>> I'm newbie in posting the changes to upstream, Can you help me with
>>>> some simple steps on how to do it?
>>>
>>> Basically in this case, I think it is enough
>>> to reply to the revert patches and CC stable.
>>
>> Oh, I am ok.
>>
>> If need me to do something, please let me know.
>>
>> Thanks.
> 
> yes, pls reply and CC stable ;)

I see that ";)", but it seems I'm missing something here:

Why did this thread resurface? 6.10.y is EOL since a while now, so that
reverting ship has sailed. And the commit in question is in 6.11 afaics.

Ciao, Thorsten
