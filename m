Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F62D0C62;
	Mon,  5 Oct 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187162; cv=none; b=p43jZClCM/MDXBOJPeO+vw/cIOUmq4UKJ+lfbuAEDZWIVsHVPeGBUmm6FarO/Oh2t823SYK3skcB+xTp4Jg78s77oa53RkS8GwfHR6svmLBIjhYI1G+555blq/YwjY2O5+aMgw0kH5GYnhltLau1Ngl2BWlVlc7jqBWXb0tbNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187162; c=relaxed/simple;
	bh=3adjiKAH+6HaJMTW85vT+6EBnWOE9GxWCepkhgKsSlw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H2NjVHtKhqyM2yEyKuEdnqU473O2Qq+MFkjJVpr4MIHD5bOQ6nLT77LfspgfCGK41mmgBkFxYbEme+Z5xI8vlZA5rVfR+64B/KiFHfCSWAi/UusfZvLLMFj7IvqSGFEYYjmSzACDArR1C53m+rAPFG5dAS3DFp82niw5mIi2OwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=RWukGX3q; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="RWukGX3q"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xDdbH-00CVxw-9i; Mon, 05 Oct 2026 09:59:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=NBTyedRxjJcnKdZU6ILSCqu2r4jMC+wfZ9g+5/uELAA=; b=RWukGX3qR13xJbHx6oaAvPVfel
	nGK72deOiiNns8sxv1aObpQrN5DEND9gmM2ckw846WVy6Mmd2EbfpZetXkbFUlNjDLWdbZyg9h1dW
	jPGabVf2EEm8WHL8xNSLspsnJkw0ct6c/ekvJlGssxd5pgi3Qn8pSijs/ZmQLy5CaONs+GYsp7kS/
	B/cwSLkjcwALyIw3hwZH6YgBd7kcsz3b0solnHVB6zRpvDBLWTr2w+MfeeQNIJ+hjaLRXxviWBVYR
	CeBAtaqXjrUB5NYivcewCD09Pm+WXqETTxCvvZPPOL4gCUWRYTcG6S6r+uZQIpZkmQvC8rj2W8vlb
	cw7G5a1Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xDdb5-0005h3-AQ; Mon, 05 Oct 2026 09:58:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xDdat-00BZ6W-UX;
	Mon, 05 Oct 2026 09:58:44 +0200
Message-ID: <1f07aa52-7820-40ac-b2ec-0e498ee841e6@rbox.co>
Date: Mon, 5 Oct 2026 09:58:37 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Asias He <asias@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
 <aqp7CV9DnfsG1GJc@sgarzare-redhat>
 <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>
 <arT3jXoS7OaU6Tsc@sgarzare-redhat>
 <6c1516ca-4699-4d9b-af6e-c7762759d495@rbox.co>
 <arpBYXWb9pohx-8v@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <arpBYXWb9pohx-8v@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/26 12:31, Stefano Garzarella wrote:
> On Thu, Sep 24, 2026 at 11:26:47PM +0200, Michal Luczaj wrote:
>> On 9/24/26 12:17, Stefano Garzarella wrote:
>>> On Tue, Sep 22, 2026 at 03:18:13PM +0200, Michal Luczaj wrote:
>>>> ...
>>>> I've addressed all your other comments for v2 and went through Ashiko's
>>>> reports (side effects of lockless peer_shutdown write, imperfect
>>>> no-transport TCP_LISTENER enforcement). I've decided to try the
>>>> eager-unassign approach. I think/hope this way we sidestep the lockless
>>>> writes and enforce the invariant without breaking the API, while fixing the
>>>> bugs.
>>>>
>>>> This should probably be RFC, but I'm posting as v3[1] so netdev's LLM can
>>>> have a go (too). Hope I'm not breaking any workflow. Let me know what you
>>>> think.
>>>
>>> I think you can add RFC also on a v3 patch, just to make it clear you 
>>> are not sure it's ready to be merged.
>>>
>>> That said, thanks for that :-) I'll take a look today or next week 
>>> because I'm off tomorrow.
>>>
>>> I'm just worried it's becoming too big for net. Anyway, I'll comment 
>>> there.
>>
>> Yeah, I get it. Would you rather have a single net.git patch[1] for the
>> original report + keep all the rest for net-next, or do the whole series as
>> is, but slowly at net-next?
> 
> I'd go with the first option. Let's try to get the fix into net first, 
> and then move the rest to net-next at a reasonable pace. WDYT?

Sure, there it is:
https://lore.kernel.org/netdev/20261005-vsock-connect-reset-closing-v4-0-15d41cfda3ed@rbox.co/

thanks,
Michal

