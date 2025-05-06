Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5144D217F54
	for <virtualization@lists.linux.dev>; Tue,  6 May 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746571672; cv=none; b=gwsFt6fVEJdP9jeMzzHrYS0vnhpqJ1EYzTym43xBgNiiGu1lb71ZToAwZ0VlRC332AumKknjid6+iH3+i9BQPKAfnkQJcnBVuoYPuwo8BU/QXma6Lyt9BiT/8wZcdiD7uxTiWZPE/vV11BzQBjA1J8DT/1vRny/sUJrkC/mRpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746571672; c=relaxed/simple;
	bh=0APPBYsT8cIqi0gvG0DV20fanKAT7WzukD/B32mb0z4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aReNHH3eTxDikJbIESBQkUTT2YGvVtbjILZIhJQmANc4GJcI4EYyLBFjqKNdIeDY7hYtS6OLSZJfTbUJWNJhsdSDOAiH65/kk/YZEgXjmU7g/Isk1oHpn8bM69Zyra6iZrfl9aoljJLNv4c5vTgDbtbrZKURXZlrvySx1sq+3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QfaO9SCT; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QfaO9SCT"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uCR4T-00AXE6-3W; Wed, 07 May 2025 00:47:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=BMq0rqR/Z/Nu+2i3yDlis9NI97iG+saHQkwWMHw8sw0=; b=QfaO9SCT4A3ryrokVq0tNv2Ie2
	Jb8lnps96YvimNQOJvx9Nl8/eT8AFAFTYBlN95CQfx3p2oG4EvTHjvie1JPaOplGPfmetkwP2ZWvy
	3d13IpFuEusdcv35+zYSAaB2J+429FqjE5otK1KCXupg5PqLIRfqSs5buokqa4Y8kNRY6tTSF9lcj
	rKBFnADYjurMWzlu2WpsrxiTy4+jSDEWlazkUiuM29/h1wHoWAe5GPdzrDlA3Y07fNeLmb2s4KEzP
	3F5mk8nExShIi/bWKum/TISh5BngU6aXcSKaz4tCIdl+545PBUGAFykCSPdREnA8oxFr6WiziKbu/
	SI72Cj5Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uCR4R-0006Gd-Rg; Wed, 07 May 2025 00:47:28 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uCR4A-00FMcb-5o; Wed, 07 May 2025 00:47:10 +0200
Message-ID: <6a818cc6-f26c-417b-ad06-0686b698b2fe@rbox.co>
Date: Wed, 7 May 2025 00:47:08 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v4 2/3] vsock: Move lingering logic to af_vsock
 core
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-2-beabbd8a0847@rbox.co>
 <hcme242wm3h33zvbo6g6xinhbsjkeaawhsjjutxrhkjoh6xhin@gm5yvzv4ao7k>
Content-Language: pl-PL, en-GB
In-Reply-To: <hcme242wm3h33zvbo6g6xinhbsjkeaawhsjjutxrhkjoh6xhin@gm5yvzv4ao7k>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 11:53, Stefano Garzarella wrote:
> On Thu, May 01, 2025 at 10:05:23AM +0200, Michal Luczaj wrote:
>> Lingering should be transport-independent in the long run. In preparation
>> for supporting other transports, as well the linger on shutdown(), move
>> code to core.
>>
>> Generalize by querying vsock_transport::unsent_bytes(), guard against the
>> callback being unimplemented. Do not pass sk_lingertime explicitly. Pull
>> SOCK_LINGER check into vsock_linger().
>>
>> Flatten the function. Remove the nested block by inverting the condition:
>> return early on !timeout.
>>
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> include/net/af_vsock.h                  |  1 +
>> net/vmw_vsock/af_vsock.c                | 30 ++++++++++++++++++++++++++++++
>> net/vmw_vsock/virtio_transport_common.c | 23 ++---------------------
>> 3 files changed, 33 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> index 9e85424c834353d016a527070dd62e15ff3bfce1..d56e6e135158939087d060dfcf65d3fdaea53bf3 100644
>> --- a/include/net/af_vsock.h
>> +++ b/include/net/af_vsock.h
>> @@ -221,6 +221,7 @@ void vsock_for_each_connected_socket(struct vsock_transport *transport,
>> 				     void (*fn)(struct sock *sk));
>> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock 
>> *psk);
>> bool vsock_find_cid(unsigned int cid);
>> +void vsock_linger(struct sock *sk);
>>
>> /**** TAP ****/
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index fc6afbc8d6806a4d98c66abc3af4bd139c583b08..a31ad6b141cd38d1806df4b5d417924bb8607e32 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1013,6 +1013,36 @@ static int vsock_getname(struct socket *sock,
>> 	return err;
>> }
>>
>> +void vsock_linger(struct sock *sk)
>> +{
>> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>> +	ssize_t (*unsent)(struct vsock_sock *vsk);
>> +	struct vsock_sock *vsk = vsock_sk(sk);
>> +	long timeout;
>> +
>> +	if (!sock_flag(sk, SOCK_LINGER))
>> +		return;
>> +
>> +	timeout = sk->sk_lingertime;
>> +	if (!timeout)
>> +		return;
>> +
>> +	/* unsent_bytes() may be unimplemented. */
> 
> This comment IMO should be enriched, as it is now it doesn't add much to 
> the code. I'm thinking on something like this:
>      Transports must implement `unsent_bytes` if they want to support
>      SOCK_LINGER through `vsock_linger()` since we use it to check when
>      the socket can be closed.

OK, will do.

Thanks,
Michal

