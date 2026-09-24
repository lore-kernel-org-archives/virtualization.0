Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437774D0A02;
	Thu, 24 Sep 2026 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285295; cv=none; b=LrfnlJiBzsP7FYSO8GjeIE9DxS1xhz3a9f7E4CmS29s7oOgBQUiNV5mXI/f1/G6kSg6Q4T2haFql6YM7EIxTJF8YQ1hDblZjO/5N6otdlqhO+PcMqJnd8RC76Iyo2c+aYiwcjq06mLOw3L8fF0E6mK4F64hxUSA4A4le5WgwKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285295; c=relaxed/simple;
	bh=S5p/lNPC0mG0bGwmIlQLsdpVl8nS+nYRBT2t+Eh2Dac=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LdpawBKf3Xv+5a0P1+R7aiyCE3INdGTAZrzTsY6muMA4vtjcEEKIfIGNXKkCvNjUNuWEgrhHK7y1xvs6XhOuLLpw6XXdoC9/izyFjM/by0u9Z6BvEYlcUCo8/itMkLd6tAvq2Wf9xE/hSOWgSM19YhMSy+7AJKtFgx7RF90H6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=SrHWO8pP; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="SrHWO8pP"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x9qz6-00A1zP-4M; Thu, 24 Sep 2026 23:28:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=FYPB90yl8vkL2P4192GPkRB2M0vxyTrX0YakhJCZa+A=; b=SrHWO8pP2owdgPzako/FtuOleE
	XRToSVb0rQ2p8XkMtMcJrOO31O3GIaaaFFSt8hpFF20nXdwU6m/bS1oxiWs7VuCA83gIAJNl7vMYc
	CFT/S4gjs5zFoqT+Oj7AZd+oNKXQitkRFqDdBE+8Hc6vIw1xWF6Cc9rkkjpYACh1yrI6r9FOPENP7
	nxFlAPVuLpBtEU9z3J4Su9IimHpVIVEweVYRZXU6VNWVhza6wdPEFFCTvGHaDmJ/hPJOm5O/vsgPf
	rKNwulE3bNkW4kzgqEGGb5SQlNpD1NVJkN2ybnS7+1t4MKHo70TmD56l1GOV0e0gUG4bXzHqDHdKl
	Dj32tI2Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x9qz0-0006Ny-MD; Thu, 24 Sep 2026 23:27:58 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x9qyl-0058JF-3j;
	Thu, 24 Sep 2026 23:27:43 +0200
Message-ID: <f8f0a708-0474-439d-b37b-9aeaa045bb1c@rbox.co>
Date: Thu, 24 Sep 2026 23:27:42 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v3 5/8] vsock: treat TCP_CLOSING as once-established
To: netdev-bot+sashiko@kernel.org
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260922-vsock-connect-reset-closing-v3-5-78907b8200d4@rbox.co>
 <179025570581.2160803.6664724141686428896@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <179025570581.2160803.6664724141686428896@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 15:15, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> This isn't a bug, but the new short circuit lists only TCP_ESTABLISHED and
> TCP_CLOSING as "once established", while an established socket can also be
> taken straight to TCP_CLOSE by a transport event while connect() is
> scheduled out:
> ...
> The cleanup side of that case is covered by the follow-up patch in this
> series, "vsock: handle socket bricking due to transport event", which adds
> an early return to vsock_unconnected_reset() for sock->state ==
> SS_CONNECTED or SS_DISCONNECTING, and neither of the two transport paths
> above modifies sk->sk_socket->state.
> 
> Is the remaining difference in the connect() return value for the TCP_CLOSE
> case the intended behaviour?

Should I use a specific return value for a socket that got bricked by
transport event?

>> @@ -1877,8 +1881,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>>  out_wait:
>>  	finish_wait(sk_sleep(sk), &wait);
>>  out_reset:
>> -	if (err)
>> -		vsock_unconnected_reset(sk);
>> +	vsock_unconnected_reset(sk);
> 
> [Severity: High]
> With this call now unconditional, can a VMCI detach during the handshake
> turn this cleanup into a silent no-op plus a warning backtrace?
Addresses in comments to patch #3.

