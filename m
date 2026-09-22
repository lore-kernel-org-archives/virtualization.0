Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A054A7F8;
	Tue, 22 Sep 2026 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083078; cv=none; b=VcWopd2AZQ46d0m7aP58l3HPNX5kQsTDNMsT4wy+8xz6u3eA3sktHxrHzBmXND3M1P0BqopGzAJfESYNLQ1XeGh97Ytw0h1VJDNYCIMxaP5j0+TBHqc2KtHMT6WihJoB92cymZRMCo5RnxCikdyPv0D0CqEahrxW9c3npETIWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083078; c=relaxed/simple;
	bh=1uKRcd9NMn91qOdAZj5WcwnXstLzQG0SGAicwnPoqd8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pGhMc+zJyZo9bfEdw85tTiGv9IfS6GW/Td1eL69ProRfiNOOpSwoH+W3yOrTOd7v/uRO9NXiwD0rgYw2kRxquZ9Vzzd3+Q+kQinMEsjeRn9wehsOJV4I+Iy4ESxiPlvsXYBkbP08l+Pnyk1sP49hAZRpuMcRnU7r5bvmREUYO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ovMIxglN; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ovMIxglN"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90NT-0038c9-Qr; Tue, 22 Sep 2026 15:17:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=qEjOCDuzftnW4hHA+txGH4FrRbluoXZlUP7Ct88k2oY=; b=ovMIxglNWODgD/GRCCe/MJWyT4
	/yhH9yvDjFos7SC5xI7IAxwLtawW6KiNegP/C969aHl/k2ddi1WJ/0pbw5C+lXzCh8NzJUQY6eXMs
	sIKr70eEygU2stVQhpYWReITGYtRdZLmB4UBLYVERxhHA/K/9yiap3OONdCIuk9nOwsXfrEOWsJeN
	Djqce4k5IyxgjeICMR+x2frwjRrtqGL9fXK+UOgsjyXtxw5YoMJ01qGFQLZRTmCjqPtVtrMMAeM4G
	qJJo6+0tGLSrcs/n/mXuECHrs6DFUTVKN1lm/uej7PwsLQ1HQkX2tafS1tiu11pFHenvf8u21K7Qe
	OvERZ/Wg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90NT-0006eX-5u; Tue, 22 Sep 2026 15:17:43 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90NK-00HI2N-Qc;
	Tue, 22 Sep 2026 15:17:34 +0200
Message-ID: <3cbeb82a-60ff-4129-b630-5404df1f689e@rbox.co>
Date: Tue, 22 Sep 2026 15:17:30 +0200
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
Content-Language: pl-PL, en-GB
In-Reply-To: <aqp3Po7OcubJboM_@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/26 14:30, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 03:15:13PM +0200, Michal Luczaj wrote:
>> Follow vhost's vhost_vsock_reset_orphans() and VMCI's
>> vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
>> later in the series.
> 
> IMO it would be better to include the reason here as well. Every commit 
> should explain why doing a change.

Sure, will do.

>> static void virtio_vsock_reset_sock(struct sock *sk)
>> {
>> +	struct vsock_sock *vsk = vsock_sk(sk);
>> +
>> 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>> 	 * under vsock_table_lock so the sock cannot disappear while we're
>> 	 * executing.
>> 	 */
>>
>> +	vsk->peer_shutdown = SHUTDOWN_MASK;
> 
> In all other places we use WRITE_ONCE/READ_ONCE on vsk->peer_shutdown, 
> should we do the same here?

Right, we should. Isn't this also the case for sk_state and sk_err?

thanks,
Michal
