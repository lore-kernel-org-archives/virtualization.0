Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41142DA3F;
	Thu, 24 Sep 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285239; cv=none; b=VzDcDSrEHtVlAc1/jB/FIj64BnEXnUsT7RARqHZaZZR5lnBEo+SLdNjnWsUD/4IUYCjNQedYrDSh3oXu+Arnr0K9oAkw9HfDIMNBOo8z6489LVsg18qGdGTGtDJJWu8h131YzRfRvE4Y5zffFJjwZucSCEEaDhq82lf3543cVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285239; c=relaxed/simple;
	bh=KX6S2KAd9hBLXAzjAvyNvq9yC7dJdXKRN35HJNHvgNI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mEE4UcXhEF5vahrnQJKiHXWZ81fJl1fyel0gV6bDc3icATBbvobhA+QuEHRuefB5lSLn6ieteTqYCWhIpyQGek9JZTn7l0PRBw6E+471TXZNkPd10iw+iaLlzmYR4wmnYzxqqphXLTURitDunc+BvnF3RlDyGz79zv79Sy6CQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=c23E9Zbc; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="c23E9Zbc"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x9qy0-00A1qG-8t; Thu, 24 Sep 2026 23:26:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=zv7elalyRokW/RhgmvtT+jxT3TUvW+OYbEu+/JCpeuA=; b=c23E9Zbc+3EtVBdRgZ5uoqmXv/
	M3j98PPHxR3AfHxcxysTAtiOgY58FRFRO/qsj6+zMKiI4jScJmlcfaWytqzU5cBnyABFIbXadN5bq
	Ru48bFxQonTjD4wWF1MerjbfjjnEOUXEKxGmcKlqrT5VRQiZAjwsW9MEFaX0Vgb8Dd73tP1ew63/w
	A5TMziW0G94VrL8ob584QV5wJTh+BqQTWGtAp7gvnB+XxwHj1gVRTPlWf6FkWtrZPlqk1tmszsABC
	nF5zTbXS1EggneHPP4GZYvATEfh88RNnJMgt9Tk2wkVhmlLLQZKTUjJhG9RGklejJ6qz6uIiDhjaY
	ySfjeR8A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x9qxt-0006Im-Ch; Thu, 24 Sep 2026 23:26:49 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x9qxe-006JSk-M8;
	Thu, 24 Sep 2026 23:26:34 +0200
Message-ID: <6aa976c6-f057-49a6-8ffa-08f7fc002b14@rbox.co>
Date: Thu, 24 Sep 2026 23:26:28 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
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
 <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
 <aqp3Po7OcubJboM_@sgarzare-redhat>
 <3cbeb82a-60ff-4129-b630-5404df1f689e@rbox.co>
 <arTwyyLVU3jM5fTA@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <arTwyyLVU3jM5fTA@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 12:06, Stefano Garzarella wrote:
> On Tue, Sep 22, 2026 at 03:17:30PM +0200, Michal Luczaj wrote:
>> On 9/16/26 14:30, Stefano Garzarella wrote:
>>> On Tue, Sep 15, 2026 at 03:15:13PM +0200, Michal Luczaj wrote:
>>>> Follow vhost's vhost_vsock_reset_orphans() and VMCI's
>>>> vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
>>>> later in the series.
>>>
>>> IMO it would be better to include the reason here as well. Every commit
>>> should explain why doing a change.
>>
>> Sure, will do.
>>
>>>> static void virtio_vsock_reset_sock(struct sock *sk)
>>>> {
>>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>>> +
>>>> 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>>>> 	 * under vsock_table_lock so the sock cannot disappear while we're
>>>> 	 * executing.
>>>> 	 */
>>>>
>>>> +	vsk->peer_shutdown = SHUTDOWN_MASK;
>>>
>>> In all other places we use WRITE_ONCE/READ_ONCE on vsk->peer_shutdown,
>>> should we do the same here?
>>
>> Right, we should. Isn't this also the case for sk_state and sk_err?
> 
> Are those read without the sk_lock?

net/vmw_vsock/diag.c's sk_diag_fill()/vsock_diag_dump() do read sk_state
without the sk_lock. As for sk_err: vsock_poll(). That said, I agree only
WRITE_ONCE(peer_shutdown) would makes sense here. But we're not doing it in
v3 anyway, so no problem.

