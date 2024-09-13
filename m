Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA11714CD;
	Fri, 13 Sep 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217478; cv=none; b=kz0jVl0pTy9Ii94fQoi9sWfqCoyNcPsHx7Mo+B7zx59ayjK0QNSC57Hhp3pl/dkgn63kNlptlLrb2aOiHd91z9F4CuN2lfWdMuJdfq4RqfXcs10U8guLqwwrEYw4itZpUjy29qwADM3KDh48Q/u6Cya0LO/vPy25QqmkORqpXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217478; c=relaxed/simple;
	bh=97ZJj155pPVt3SnzWh0WiQqwiwVMu+5hqWaAFSyD0zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFZA6rPRvrb4xb+wqcY28DWezZy0QlEZ/BPRlZ0kSlvovbdyFUn/+G8a4U92TrqPBIYXqwK7FePeRBlMMNNo9RzZqhAC2rG/xP35b5Ie2i9udTZp1Agny5iRb47E7uUktdFGztkMX0WZUFNCUyZ7tBxktym6/pTTJd8OFf9+zsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=mi9/1yg+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="mi9/1yg+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=sGN0IuZ4IfKJQw/gcUFwuEj+P9esbptY/aab7KCpmdI=;
	t=1726217477; x=1726649477; b=mi9/1yg+p+fxHr47bBH7Lz5pXqWCoASqabJ8epYVON+Gerp
	SG8dqeRw0lrUNIojvNLfmVC1g0XOoDnxd3F4KNTpv+vdDrtp/K/tJNTbdtes370BPyZdh4HQnnsGw
	NLGJjx3R0DYE+aShoCx6MoK2T5rNBW+5u1SjjOkF9cZiiMs7595z6B9rRe8BVE7agAvhFD+ibM6gV
	wbng15WMmKffBLV0We1aVM95EfNkwPWZIzqssV1VRMjwsNjeWqBt3OSZ3erBP6w/ZNCJhdXXTHBRQ
	oscxZwGZVPt9Cr9xD6woifY2vYSTZhpxwGdENc+LN7ttu7cmulsTNoI260gP9LEg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sp21L-0002Mi-1W; Fri, 13 Sep 2024 10:51:15 +0200
Message-ID: <565a9204-362d-458d-8b8e-11c5aada7b98@leemhuis.info>
Date: Fri, 13 Sep 2024 10:51:14 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 0010:virtnet_rq_alloc+0x8f/0x1b0 [virtio_net] with 6.10.7 and
 packed virtqueues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>
References: <CAK8fFZ6qVutPWxquHg7NEvFqYqDP5BwEdO81hqW8iMFxJFuLSQ@mail.gmail.com>
 <CAK8fFZ5N7EbU=uLbfyeSkQ273NSm+GELWUu1O1OBCpaSwjv6FA@mail.gmail.com>
 <422f35b3-7834-4df7-bcea-e3be12707aef@leemhuis.info>
 <1726216954.7439098-1-xuanzhuo@linux.alibaba.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US, de-DE
In-Reply-To: <1726216954.7439098-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1726217477;aa9be024;
X-HE-SMSGID: 1sp21L-0002Mi-1W

On 13.09.24 10:42, Xuan Zhuo wrote:
> On Fri, 13 Sep 2024 10:26:57 +0200, "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
>> [CCing a few people that know more about this stuff than I do]
>>
>> On 13.09.24 09:50, Jaroslav Pulchart wrote:
>>>
>>> actually I'm getting random memory corruption related crashes after
>>> updating to 6.10.y. My expectation is that it relates to this issue:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=219154
>>> It looks like it is almost 1 month ago
>>
>> A lot of developer ignore bugzilla.
>>
>>> already from the last comment
>>> there, However the patches fixing the regression are not reverted from
>>> the 6.10.y tree which surprises me.
>>>
>>> I will try to revert them from our builds and see if it helps to avoid
>>> random daily happening crashes.
>>
>> Not my area of expertise, but to me it sounds like the problem will be
>> resolved my "Revert "virtio_net: rx enable premapped mode by default"":
>> https://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com/
> 
> YES. That is merged into net.

Well, yes, but TWIMC to avoid confusion, it's already one step further,
as mentioned:

>> That set just landed in mainline. 

See
https://git.kernel.org/torvalds/c/48aa361c5db0b380c2b75c24984c0d3e7c1e8c09
or
https://git.kernel.org/torvalds/c/111fc9f517cb293c4213673733b980123c3b0209

Ciao, Thorsten
