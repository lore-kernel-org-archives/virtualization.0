Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DC14A8E
	for <virtualization@lists.linux.dev>; Wed, 28 May 2025 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748465225; cv=none; b=hoanoFD7k8cQlVVMaEXyT6gsU/jBiLdWB+EE2KHgl8pyfIM80U05P9taA5k9vWOwVAkeLhWaslZdCUXrr/VmHN1HWQBIScp5oRoRJOHwQHZmU2voBx2NkaQmyu3lgZ6OTy+bJwZ6txuu7KXgW8n4/GYX+ft9hc/OO7i2bCN9TIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748465225; c=relaxed/simple;
	bh=fVp99q/7nR/2Qu8kOa163BQ8/bMTec7kquQzdJRIRwg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eKeTInWVrS6h2fwfUhHtYR5mrML/lt2ia6vCkYLqAOX9uXgtEEsjxxWBLLW1CFnInS2FCh4+sIlLsGjafeeZckbtIeJEqROnr9FPRlkRsdakCmz+IcPVpV4LBQhPAB+P8VlEoLQka8K4CFNv/yppmPrxDMB2P2GvzkGfRIkWkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=d5usDPDZ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="d5usDPDZ"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uKNfw-006aPP-PW
	for virtualization@lists.linux.dev; Wed, 28 May 2025 22:47:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=mHGbDnTnT+lOyuS9ni4kZmOkuGfOKTTj/i53GQlfiKA=; b=d5usDPDZ82aCjqem6aXrDuz4pd
	GCzPX05k0anzYyu3ogAhKHm719fu9E0pDSswit8b2N/i3B2zfTlYleOIHJ7Qzw9QAWjAOeVz+AnJV
	/4I8DH8W9xJp8EP2FDd4MGZofmtiAqGPoMZYE9lsNbhqbKkzi9t/mMcYranG5hr8tIy2m4Ob3YRK+
	5gzZbHJnH9hmOoN6Tk8w7d28wJn0o4FHup7DtZRNO/L1ZQKWP/kdE9ebrCf4tC1xtyJVYm22hbZga
	xju4WjWu/zg/oLdPuTdIlaXEPYa6loK66DK9G5JedE8ZQoSgQi/DEd8la4IunHkRcdUuHTGEc40Yp
	e2HuW1EA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uKNfw-0005OQ-C3; Wed, 28 May 2025 22:47:00 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uKNfg-00GL99-0q; Wed, 28 May 2025 22:46:44 +0200
Message-ID: <1ed7b81c-4c7f-4c4b-9fb5-d231aeeeb5b6@rbox.co>
Date: Wed, 28 May 2025 22:46:43 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
 <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
 <1f5cc46a-de4c-4361-a706-fc7fe06a7068@rbox.co>
 <gfmoupl72tjyymhwxcstwpgaabbfaz6f4v6vj4lwwzwssg577c@urkmgn7rapnj>
 <151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co>
 <skvayogoenhntikkdnqrkkjvqesmpnukjlil6reubrouo45sat@j7zw6lfthfrd>
 <54959090-440e-49e8-80b3-8eee0ef4582c@rbox.co>
 <7zqv5toj2qjucy7fvaebbpwj6pth53uunsbapwhgrhwbr5pq5t@gp7h6klhr5sj>
Content-Language: pl-PL, en-GB
In-Reply-To: <7zqv5toj2qjucy7fvaebbpwj6pth53uunsbapwhgrhwbr5pq5t@gp7h6klhr5sj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/25 11:08, Stefano Garzarella wrote:
> On Wed, May 28, 2025 at 10:58:28AM +0200, Michal Luczaj wrote:
>> Administrative query: while net-next is closed, am I supposed to mark this
>> series as "RFC" and post v2 for a review as usual, or is it better to just
>> hold off until net-next opens?
> 
> Whichever you prefer, if you are uncertain about the next version and 
> want to speed things up with a review while waiting, then go with RFC, 
> but if you think all comments are resolved and the next version is ready 
> to be merged, wait for the reopening.
> Thanks for asking!

All right then, I gave RFC a try:
https://lore.kernel.org/netdev/20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co/

>>>>>>>> +static void test_stream_transport_uaf_client(const struct test_opts *opts)
>>>>>>>> +{
>>>>>>>> +	bool tested = false;
>>>>>>>> +	int cid;
>>>>>>>> +
>>>>>>>> +	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>>>>>>>
>>>>>>>> +		tested |= test_stream_transport_uaf(cid);
>>>>>>>> +
>>>>>>>> +	if (!tested)
>>>>>>>> +		fprintf(stderr, "No transport tested\n");
>>>>>>>> +
>>>>>>>> 	control_writeln("DONE");
>>>>>>>
>>>>>>> While we're at it, I think we can remove this message, looking at
>>>>>>> run_tests() in util.c, we already have a barrier.
>>>>>>
>>>>>> Ok, sure. Note that console output gets slightly de-synchronised: server
>>>>>> will immediately print next test's prompt and wait there.
>>>>>
>>>>> I see, however I don't have a strong opinion, you can leave it that way
>>>>> if you prefer.
>>>>
>>>> How about adding a sync point to run_tests()? E.g.
>>>
>>> Yep, why not, of course in another series :-)
>>>
>>> And if you like, you can remove that specific sync point in that series
>>> and check also other tests, but I think we have only that one.
>>
>> OK, I'll leave that for later.
> 
> Yep, feel free to discard my suggestion, we can fix it later.

I was thinking about doing a console-output-beautification series
with: 1) drop the redundant sync in test_stream_transport_uaf_*, 2) add a
sync in run_tests(). But I guess we can have the sync dropping part here.
Definitely less churn this way.

Thanks,
Michal

