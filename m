Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D03C3432
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786468; cv=none; b=VGItYAGQyn49QF+fqFIuYjO0vY9YMLM9ymMLpXuuHaPas/13kGjhjjNI/Tr+8yS8iD4GFCvYHqfySuU+Q+MZacl7dL6/bkdcnX2733rbZ+QK2+zSJJMqakud2dOh/crb7/BXhFoxzCDYu/Po7OJf0tMomQbe3V494wOMPdmZXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786468; c=relaxed/simple;
	bh=x7uOM9e9y9lcTbyFLw11njQTOwdIs7fqQ1pZvRltXsk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zy8PoYNG2XrjOWRCbxW7Dppse+4fPLIVrfYkghXyxXyoHDiomZczvcQ9tI33F5/jARoRPxkfDbK3dsR6VqY0p7rUgtx2NBb7iErAXJFn7i4plRk1yMy3Ott/YqJ00GHsUmFvpGBPoqO9wc7NJPewXAWTwFokfkp1lASzPO7jR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=BVSCmsJW; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="BVSCmsJW"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wmmUB-006aut-NH; Thu, 23 Jul 2026 08:00:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=jQF+B4y7HZPYqfkeEUgOzuij/5UBYjUVxIS9TMC963M=; b=BVSCmsJWTG8M62cRFYiOPcQz+a
	F/5ParowHD0wUVqI8E+ciPDAczTw60o9XlJyrNtjjnJ+Jcf1uVGkHG8GRz46LM6tSdTI7YArm3a12
	GBBickdC+hz4RlZ4a1pD7fXH34XFrgr34FdRAJX1GQ4pHQTAyW/zEUCul2nBwnUyj1x1ftP6wiVyK
	sDvPWmoVXd7muJQBBTnrJL4uKpcXxTY19HUGRIIUobsybLnmXZgRYN2vQBqMVmmfE44eEk5ztXQaa
	kuZ4tw6JLY6wXRaRvC7Vi/Ebrh3OkUGE2cUTS1qTRJGXKVrv9SJCh7HQmjlTia0TWRTO4Gz48PNRI
	bkojMi+A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wmmUA-0006Ff-TW; Thu, 23 Jul 2026 08:00:47 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wmmU1-005PAP-AB;
	Thu, 23 Jul 2026 08:00:37 +0200
Message-ID: <95cd0d4e-58c9-44ab-b94f-fcf57b88583b@rbox.co>
Date: Thu, 23 Jul 2026 08:00:31 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH] vsock: use sock_error() to consume sk_err after connect
 timeout
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260719220103.684489-1-phind.uet@gmail.com>
 <al3UuvBhfxp82krV@sgarzare-redhat>
 <78225425-1ca7-45fb-85cb-9e04f489e68f@gmail.com>
 <amB15TdzPAEk9A9C@sgarzare-redhat>
 <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <b81bfea4-6b19-4cc8-95c0-dcd4ad42476e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/23/26 06:14, Nguyen Dinh Phi [SG] wrote:
> On 22/7/26 15:55, Stefano Garzarella wrote:
>> On Tue, Jul 21, 2026 at 01:34:03AM +0800, Phi Nguyen wrote:
>>> On 7/20/2026 4:17 PM, Stefano Garzarella wrote:
>>>> On Mon, Jul 20, 2026 at 05:57:47AM +0800, Nguyen Dinh Phi wrote:
>>>>> After vsock_connect() exits the wait loop due to sk->sk_err being
>>>>> set, the error was read but not cleared. This left sk->sk_err set
>>>>> for subsequent operations.
>>>>
>>>> So, is this a fix? If yes, we should put a Fixes tag.
>>>>
>>>> Also, can you describe how to trigger the issue?
>>>>
>>>> Because I see this in vsock_connect(), so I thought it was in some 
>>>> way already handled:
>>>>
>>>>         /* sk_err might have been set as a result of an earlier
>>>>          * (failed) connect attempt.
>>>>          */
>>>>         sk->sk_err = 0;
>>>>
>>> This only handles the case where the function following the failed 
>>> connect is another connect() call.
>>
>> So, can we remove that with this patch, or better to leave as defensive
>> action?
>>
> 
> I prefer to keep it here as defensive action

Is changing how vsock_poll() behaves intended?

I.e. if sk_err should be kept after a failed connect(), what about
`sk->sk_err = 0;` in vsock_listen() instead?

>> ...
>> Yeah, we need to handle that part better, I think it's a leftover when 
>> we generalized AF_VSOCK to support more transport than vmci.

Speaking of leftovers, I have trouble understanding where does vsock set
sk_err on listener sockets anyway. If it doesn't, why vsock_accept() checks
for it?

thanks,
Michal
