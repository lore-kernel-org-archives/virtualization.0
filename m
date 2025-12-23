Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB807311589
	for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488204; cv=none; b=koDNEjrucTLbBA+0gwbuRblV3cIed0/OvXKYqqCeeUbhnpiDT6PwAlbHCxL79GbuhcPrF3FYztHzcLs3AnSZBXTUQtwmjmJy5oLbT6HGLYLj+EawIFxJvaX+1dlYEszwVBcbOP/zL/aipRsdYGGT4sNUK0itRLKkwHvNYzgvY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488204; c=relaxed/simple;
	bh=DCzJrlCFPHbdhH4pbfSMyoU+QTjhhTiWeIA0RAA5y+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4ueQiqbG1NKmgg9TgdPhFp/FJtiClj8Teb/fIAUQAyBSGeU3+1Oo6qC5FW0TlO0kN9LnJ6dMsAjjJaapxY4PI5FkoS4cUBrJmRnL8Ii8oKIGOR+ujY9kI9DxSdgUz+2FFC8pMfuDr85Oz4qu4UKMC4iESlIjzMOM7+q7ZC8Ia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=EzID2cVS; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="EzID2cVS"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vY0H5-00BJnP-DH; Tue, 23 Dec 2025 12:09:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=1+u1IBrky6sWhAl4AMkGYqMEEOxNVXZ8krlwQcI38ww=; b=EzID2cVSOXnDT4F1sBDPCMd/z8
	OtqjC5JeuyMVmpkC7R5RSc+QzB4I12FZWJs5jcZmxfCwdLTIl+Im6RxZjTiqUEVlQvqTPrW/ZPuS0
	3vt/Ypyum3r+QnuirYmBxPreInRPgIIcQxVfJuTyhfdeQeQi+ogt3ZXoMEh9ErJ8GzhoDl7rQQ9bs
	5NfMonlaD5Cxo8fqcSGWw/Ve4gcHUEXQ81RM79l0uqKG04TW6MeQoLGaP8lksgw8/ZcXawTzoaD9Y
	lyzKlTF61XkGNl3KGJZ7wUhCR4YH4dlQLXsVXt4WDQy5bHCSNeVWuS5TcvDOIX0ISNzPTJS2GdN2X
	2gkgMG4Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vY0H4-0005Gl-Kj; Tue, 23 Dec 2025 12:09:54 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vY0H2-009YYH-NW; Tue, 23 Dec 2025 12:09:52 +0100
Message-ID: <ff469a0f-091b-4260-8a54-e620024e0ec9@rbox.co>
Date: Tue, 23 Dec 2025 12:09:51 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
 <aUptJ2ECAPbLEZNp@sgarzare-redhat>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <aUptJ2ECAPbLEZNp@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 11:26, Stefano Garzarella wrote:
> On Tue, Dec 23, 2025 at 10:15:28AM +0100, Michal Luczaj wrote:
...
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index adcba1b7bf74..c093db8fec2d 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1787,6 +1787,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
>> 		} else {
>> 			newsock->state = SS_CONNECTED;
>> 			sock_graft(connected, newsock);
>> +			set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
> 
> I was a bit confused about next lines calling set_bit on 
> `connected->sk_socket->flags`, but after `sock_graft(connected, 
> newsock)` they are equivalent.
> 
> So, maybe I would move the new line before the sock_graft() call or use 
> `connected->sk_socket->flags` if you want to keep it after it.
...
>> 			if (vsock_msgzerocopy_allow(vconnected->transport))
>> 				set_bit(SOCK_SUPPORT_ZC,
>> 					&connected->sk_socket->flags);

Hmm, isn't using both `connected->sk_socket->flags` and `newsock->flags` a
bit confusing? `connected->sk_socket->flags` feels unnecessary long to me.
So how about a not-so-minimal-patch to have

	newsock->state = SS_CONNECTED;
	set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
	if (vsock_msgzerocopy_allow(vconnected->transport))
		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
	sock_graft(connected, newsock);

?

