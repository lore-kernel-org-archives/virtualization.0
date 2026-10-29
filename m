Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310037;
	b=pS455EX6gjXYTb1pUEtoT8TPvE6hdv4OYa9oeIc+FtPAgGPACW7vatYpVnXNxuSFi2X3
	 qb9ZC6IwtzrX/PcqVg1SpdF0UHCp1QimBZcP4XbOe4I1ZFhLPv0AGtpwseo1AcFWH0EFZ
	 DxWurBnposYfu3gwYYy1DbQiM/N7ZQfe010PoEn4xmOXVX1RdXanG0NWlF1AH/tfGgK5g
	 ULtGpepbdr5694Q65tGZsQlMVRjrFsUClLLzJyRavZVp/IXxvOc1l3cLu10+uBXKGaXU5
	 R/F+BVTiIkJujqK+wMXshpvXSJdLNk9tkmM0U13ClPJTqg/qVNc5AMIsmEHliHaOBlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MZvzDpBPwEa2xjmhJpCaescetJXwNLlVXAcXe0UAq8M=;
	b=v8eJODtL/J2WuAftzhjw1PqRroRTw2OTOAN1a+aXmhK96S2DJY0011+0nxC3is2Lop7V
	 ShNxy5wRWJcXF5AY2QBI1wSyCvGHW4Rc6eK02jOYAXP30G6sz25cYxBdf2lu3aHeU/nG4
	 yI0ILOnOXOllf2PU01S2kezR++C/CfbSTpGdgkjwwB7MPK6922M4vbl7r7hIm1lOQHkgV
	 49IAqB27vFKkxKbiS39SCwIzrRkWFROxl73U0yd1li6+VM3kfz50TpFpXMgMZv6FXU75N
	 guDvTryXuJIfoi7ZYxSJk5mhSBM8D/d4VuHIbkWUuDDP7ihnPePzBnov4RHASKq/dsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=DJ9gkgJ2;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B6606A31C;
	Thu, 29 Oct 2026 21:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E61B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=DJ9gkgJ2
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xMXr9-00Gcqs-C6; Thu, 29 Oct 2026 22:40:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=MZvzDpBPwEa2xjmhJpCaescetJXwNLlVXAcXe0UAq8M=; b=DJ9gkgJ2mHgUKKUfDwDDCCU7a2
	fY3qUzdAHPf+1mgtIxttXFG8oYMrGk8IPq37+NOgMbA7ITXr9SeRSTwb7mazn9bnla/u5roR31Zw3
	qu34bdMib+teJwEVATRjhpWBCLDl332CxeCq704J595bVN8Po3498i1F3u9x5kGT7cXmlh62HGYEL
	DPRtHkEcgoH4iY5YsicYidSkk5rKcp0+JVbgxkW7oS9KlIm61ipQqj5a+C2LqUdtSAa68zXic8/Bq
	+z1WmX5Ef/A82aBvUnJ4M1F1Tn/fDZVXZ5Ws8k3XBQj37hfD+iQSNkTr3oXcbSUORSmeSXooj6hjg
	/OW/lTmw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xMXqv-0006P1-3W; Thu, 29 Oct 2026 22:40:05 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xMXqh-001Zdr-J4;
	Thu, 29 Oct 2026 22:39:51 +0100
Message-ID: <d946003a-8bec-4e8b-89a3-05eeb96780cc@rbox.co>
Date: Thu, 29 Oct 2026 22:39:50 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net-next v4 4/7] vsock: add a netlink command to assign
 the g2h device to a netns
To: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me,
 jlinbox@meta.com
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-4-047527cfccfc@meta.com>
 <atjZZP2ebhXKzMxL@sgarzare-redhat>
 <atld3+5LKmGxJ8+s@devvm29614.prn0.facebook.com>
 <atnjOZjKUBagRVWq@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <atnjOZjKUBagRVWq@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/26 12:47, Stefano Garzarella wrote:
>>>> +/* Move @vsk to TCP_ESTABLISHED and into the connected table, unless the device
>>>> + * has moved to a namespace @vsk cannot reach. Returns false without doing
>>>> + * either in that case.
>>>> + *
>>>> + * The reset sweep walks the same table under the same lock, so an assign
>>>> + * cannot land between the check and the insert: either the sweep finds @vsk
>>>> + * and closes it, or @vsk is never added.
>>>> + */
>>>> +bool vsock_maybe_set_connected(struct vsock_sock *vsk)
>>>> +{
>>>> +	struct list_head *list;
>>>> +	bool reachable;
>>>> +
>>>> +	list = vsock_connected_sockets(&vsk->remote_addr, &vsk->local_addr);
>>>> +
>>>> +	spin_lock_bh(&vsock_table_lock);
>>>> +	reachable = vsock_g2h_reachable_sk(vsk);
>>>> +	if (reachable) {
>>>> +		sk_vsock(vsk)->sk_state = TCP_ESTABLISHED;
>>>> +		__vsock_insert_connected(list, vsk);
>>>> +	}
>>>> +	spin_unlock_bh(&vsock_table_lock);
>>>> +
>>>> +	return reachable;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(vsock_maybe_set_connected);
>>>> +
>>>> +static bool vsock_g2h_should_reset(struct vsock_sock *vsk,
>>>> +				   const struct vsock_transport *t)
>>>> +{
>>>> +	return vsk->transport == t &&
>>>> +	       READ_ONCE(sk_vsock(vsk)->sk_state) != TCP_CLOSE &&
>>>> +	       !READ_ONCE(vsk->close_work_scheduled) &&
>>>> +	       !vsock_g2h_reachable_sk(vsk);
>>>> +}
>>>> +
>>>> +static struct vsock_sock *
>>>> +vsock_g2h_next_unreachable(const struct vsock_transport *t, unsigned int *i)
>>>> +{
>>>> +	struct vsock_sock *vsk;
>>>> +
>>>> +	spin_lock_bh(&vsock_table_lock);
>>>> +
>>>> +	for (; *i < ARRAY_SIZE(vsock_connected_table); (*i)++) {
>>>> +		list_for_each_entry(vsk, &vsock_connected_table[*i],
>>>> +				    connected_table) {
>>>> +			if (vsock_g2h_should_reset(vsk, t)) {
>>>> +				sock_hold(sk_vsock(vsk));
>>>> +				spin_unlock_bh(&vsock_table_lock);
>>>> +				return vsk;
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +
>>>> +	spin_unlock_bh(&vsock_table_lock);
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +/* Close every connected socket of @t that can no longer reach the g2h device.
>>>> + */
>>>> +static void vsock_g2h_reset_unreachable(const struct vsock_transport *t)
>>>> +{
>>>> +	struct vsock_sock *vsk;
>>>> +	unsigned int i = 0;
>>>> +	struct sock *sk;
>>>> +	bool reset;
>>>> +
>>>> +	lockdep_assert_held(&vsock_g2h_assign_mutex);
>>>> +	lockdep_assert_not_held(&vsock_register_mutex);
>>>> +
>>>> +	while ((vsk = vsock_g2h_next_unreachable(t, &i))) {
>>>
>>> can we reuse vsock_for_each_connected_socket() ?
>>>
>>> If not, maybe a comment here will be nice and maybe I'll try to merge
>>> vsock_g2h_next_unreachable() here if it's not used somewhere else.
>>
>> I think we would need a variant that returns the socket, since we need
>> to be able to acquire the lock_sock after releasing the
>> vsock_table_lock.
> 
> That would be nice if it's not too complicated.
> 
>>
>> Maybe the callback could return a bool, if true then return socket
>> otherwise skip. Then the cb could also grab the sock_hold ref under the
>> table lock.
> 
> Yeah, looks promising to me!
> 
>>
>>>
>>> I find these functions a bit hard to read.
>>
>> Yeah its all kind of a pain. The problem is that we need to hold
>> sock_lock to set sk_state and sk_err, but can't acquire it under the
>> table lock. Instead, we grab the socket ref sock_hold under the table
>> lock to guarantee it stays alive between releasing the table lock and
>> grabbing the socket lock.
>>
>> I was really tempted to not do this lock_sock dance though. The race
>> condition I'm avoiding here is that if this reset races with an RST
>> receive, then the socket could end up with TCP_CLOSING + sk_err
>> ECONNRESET... but I'm not sure this actually propagates up into a real
>> problem for any potential user.

Right, vsock_connect() is fragile. Two things to be cautious about:
1. Don't let it reset the already connected socket. Because that would
allow user to "re-connect()" and make mess in connected_table.
2. Don't let it re-assign transport of an already connected socket. Because
that breaks the contract in few places.

State 1 is not an issue: vsock_g2h_reset_unreachable() calls
__vsock_remove_connected().

State 2 may be problematic: if vsock_g2h_reset_unreachable() sets TCP_CLOSE
when connect() is scheduled out, then after the wake-up sock may get reset
to SS_UNCONNECTED. Then user re-connect()s and hits the transport
re-assignment logic. I'm worried that, as we re-assign, someone may be
holding a reference to such "connected" (even if not in connected_table
anymore) vsock.

So I don't know, maybe it's vsock_connect() that should be fixed/hardened
instead?

Or at least disallow transport *re*-assignment? Does the "re-" part have a
use case?

Hope it's not too off-topic.

>> It also avoided some racing with the tx path, but now that send_pkt()
>> also checks reachability I think that path is safe.
>>
>> What do you think about doing the below hunk (TCP_CLOSE, ECONNRESET,
>> sk_error_report) with no lock_sock?
> 
> Looking at the code, it seems that in all the places where we close all 
> connections (virtio_vsock_reset_sock, vhost_vsock_reset_orphans) we do 
> with no lock_sock but with vsock_table_lock.
> 
> So, makes sense to me.

virtio_vsock_reset_sock() and vhost_vsock_reset_orphans() are my pet
peeves: state switcheroo without taking lock_sock(). Which, again, races
vsock_connect().

