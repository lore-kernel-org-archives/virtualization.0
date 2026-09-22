Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6F551981;
	Tue, 22 Sep 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083124; cv=none; b=CPhek7pDvU8nD+CSvCZpIwfh36cYvqvnviSmxlvt8whJlpnYoyg1amYS/WoA5UXHwj8hIeEUhS02kkQvi2EvgspnEusrdu9SX+f5IemEhUfu10SORbf99V2Rcm7qr16uQUTYqGr4uQz0gAO7VthbDupPHF0yfgk8JJCMtyy4Fkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083124; c=relaxed/simple;
	bh=9yuCs3ICIZlrJh2sfuNAqdmLCVu1sxYY38sjHiT2moc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jK1c/EaM0zyg6t+l0dxImw7KIzTBi0oS7BdH1vdvqXByPWrb/6MQI3utWTRKyrXZ+hFA8tRJDJZhgPd1kCVDt8Jpb4nucz6Z+nWW0735JuhhtalPoYFPJH52M60jRvxQecv9k3dZz1VQHym8lBUMFEjSKuOHiFk9uLq+z7C9LrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=l+u1niOC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="l+u1niOC"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90OD-005SZr-My; Tue, 22 Sep 2026 15:18:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=1i2pY8YvcU7k2lAUuqqEj5EdeGuvSv0X4JAnH12lwRs=; b=l+u1niOCpKWaxb2/grmDTst070
	DP1OY/UMkNo7C2z8Dn7imHGLCOngLoIOii5SxJaKz96M1HZsCbhCm4oC1rQCJXtV7X/CR3xJvs0jK
	EhV3yGJ9CTzo3zNKOPdYtTjS65HWUYRgB5Vy3aTcZkKl8CvY4YSybl1ss47o+RNqxWFJzFpSzMut8
	LQ0HxcJzGmLEZeJFbRVHwV9hoeNHoIuBCGHnCxQCoC2IFcmET88U655KykfsxEMALhSCTIfDUkTGq
	WR5ArhqccLAiv8rfmRX25h9ajEQ2YKpU8LqTzRDZpm10GEJUS5swUwhJn73bxAF6Q/iIWn79r8U7a
	IeoCO76w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90O8-00054A-Er; Tue, 22 Sep 2026 15:18:24 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90Ny-00HI7x-W2;
	Tue, 22 Sep 2026 15:18:15 +0200
Message-ID: <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>
Date: Tue, 22 Sep 2026 15:18:13 +0200
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
Content-Language: pl-PL, en-GB
In-Reply-To: <aqp7CV9DnfsG1GJc@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 14:30, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 03:15:14PM +0200, Michal Luczaj wrote:
>> A non-blocking connect() running in parallel with a blocking connect(),
>> combined with a racy listen() that hits right after a connect timeout:
>> TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
>> in progress.
>>
>> Enforce the invariant. Prevent a socket from becoming a listener after
>> acquiring a transport.
> 
> We should improve this comment; it's not entirely clear to me, TBH.

The race I was thinking about:

sk is CLOSE UNCONNECTED
non-blocking connect():
  sk := SYN_SENT CONNECTING
  enqueue vsock_connect_timeout()
                                   blocking connect():
                                     release_sock()
                                     schedule_timeout()
vsock_connect_timeout():
  sk := CLOSE UNCONNECTED
listen():
  sk := LISTEN UNCONNECTED
                                     lock_sock()
                                     sk is TCP_LISTEN UNCONNECTED

It's not really critical (blocking connect() just timeouts), but I thought
the invariant should be enforced once and for all.

>> @@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
>> 		goto out;
>> 	}
>>
>> -	if (sock->state != SS_UNCONNECTED) {
>> +	vsk = vsock_sk(sk);
>> +
>> +	if (sock->state != SS_UNCONNECTED || vsk->transport) {
> 
> Are we changing the behavior when an error occurs?
> 
> If we call `connect()` on a socket (with no others running in parallel), 
> it fails, and then when we call `listen()`, it now fails, whereas before 
> it didn't. Can this happen? Is that what we want?

Ah, true, I didn't consider that. So yeah, we'd changing the behaviour.

> If so, we should mention it at least in the commit description; if not, 
> perhaps we should unassign the transport in the `connect` call.

Do you mean immediately un-assign on every transition from SYN_SENT to
CLOSE (failure, timeout, signal)? Then we could also drop the re-assign
logic. I think that's a nice idea.

---

I've addressed all your other comments for v2 and went through Ashiko's
reports (side effects of lockless peer_shutdown write, imperfect
no-transport TCP_LISTENER enforcement). I've decided to try the
eager-unassign approach. I think/hope this way we sidestep the lockless
writes and enforce the invariant without breaking the API, while fixing the
bugs.

This should probably be RFC, but I'm posting as v3[1] so netdev's LLM can
have a go (too). Hope I'm not breaking any workflow. Let me know what you
think.

[1]:
https://lore.kernel.org/netdev/20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co/

thanks,
Michal
