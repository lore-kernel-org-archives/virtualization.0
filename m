Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87A4BFE7B;
	Thu, 24 Sep 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285240; cv=none; b=e64wGFpIbH83xOi5O3qir8KfHT95+GSVBHZ5x207RYu/e+cNLMHtC2wsvfXYdThrNIRG5YCXqIMWVPFVyiMHzD+ULjeAXC22pYWJAnBJIziD6Qhczp83D5OjZ74qy4D0Z3r3Nblm+fd5IcArT2yXO8V4s4TU7VP0mhooIn0f7k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285240; c=relaxed/simple;
	bh=WeSEsIdrN6td3owWuqmG3fnbCN0BRVTLIdJFtLyExCA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HS8eimaerp6jzq3bTNzJ3/vGBFQYlME7WK5RHsB6Z6gTnjgKoyapvqAq3WRtPPNsNbWVtn1xMLpanRJf1jBb+c0PkFy6DzvnvsqSGELcfNG4i9m6+nQ4fAYq4vXfZTxRq8U3HRRzkHYqBWbXUQzauBtHaplu3ezuSpNBPd95VuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=aXdsXiTg; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="aXdsXiTg"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x9qy6-00Ck8w-HN; Thu, 24 Sep 2026 23:27:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=t/jdVlLaiEn4bqSyNDSfDJ0wbOugkQLM4FXNsmpyMXI=; b=aXdsXiTg3E5IxDpiWMhg5Hw6Bl
	Md49H9PyqTVeSZgC86DQnYIHHYUUSR3sWZMxV6zds6MWEx509Qm0hNGAGLxRqu67bUJPMMlm9XNp6
	A4xWYF5pWUC6CfowqhdsZw10Tu/Z2qihJp5ltAv02jO64Iwe7msUglcO9QLP5fXXy8N18UaAH2VZp
	uj6REykTrXAFPwkTjPE3i2h4NvGy6HkwWam7tABEBIaNM4NPBA74+4VVtF2Tmvw7gmcM5DNx2c4mx
	BNAS+FFQqXJ2u5iA5rIQRnBTbS1rpVfdzDyuWXQpGxT7raHcP0B50M4WlhOPOlLSzQNkakaSV0tGa
	fVd8GvtQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x9qy1-0006Jl-4O; Thu, 24 Sep 2026 23:26:57 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x9qxt-006cN3-1W;
	Thu, 24 Sep 2026 23:26:49 +0200
Message-ID: <6c1516ca-4699-4d9b-af6e-c7762759d495@rbox.co>
Date: Thu, 24 Sep 2026 23:26:47 +0200
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
Content-Language: pl-PL, en-GB
In-Reply-To: <arT3jXoS7OaU6Tsc@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 12:17, Stefano Garzarella wrote:
> On Tue, Sep 22, 2026 at 03:18:13PM +0200, Michal Luczaj wrote:
>> ...
>> I've addressed all your other comments for v2 and went through Ashiko's
>> reports (side effects of lockless peer_shutdown write, imperfect
>> no-transport TCP_LISTENER enforcement). I've decided to try the
>> eager-unassign approach. I think/hope this way we sidestep the lockless
>> writes and enforce the invariant without breaking the API, while fixing the
>> bugs.
>>
>> This should probably be RFC, but I'm posting as v3[1] so netdev's LLM can
>> have a go (too). Hope I'm not breaking any workflow. Let me know what you
>> think.
> 
> I think you can add RFC also on a v3 patch, just to make it clear you 
> are not sure it's ready to be merged.
> 
> That said, thanks for that :-) I'll take a look today or next week 
> because I'm off tomorrow.
> 
> I'm just worried it's becoming too big for net. Anyway, I'll comment 
> there.

Yeah, I get it. Would you rather have a single net.git patch[1] for the
original report + keep all the rest for net-next, or do the whole series as
is, but slowly at net-next?

[1]: Basically
https://lore.kernel.org/netdev/20260915-vsock-connect-reset-closing-v2-4-a1d9abb472f7@rbox.co/
+ your comments addressed + addressing one of Sashiko's comments, and
ignoring the transport-reset-surprise one

