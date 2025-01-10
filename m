Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1212080D7
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 08:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498369; cv=none; b=fmU+TdQDGrfSWpCBws6vj1b6x9jF89boAoa0Ay6ddo/lBM4y44mbTrc76cz0uFiYCKyNVNHX8vWKr04m9u7dXvexSYh72x6fr0MnEjHSfipRHfnXBLbsFTK/TxvsvmvYpyvVzicjtNFDHsMo63RXCW7ds+Jv1bttWH7FmMmR6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498369; c=relaxed/simple;
	bh=iJsV4mrkuXUAlTF79pi0keywbZpwBmWfcU2SNaEDdkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gsLBpsoWzOcwUN2/55ErzKUv3HNxto27RiLRWIggTbeDWCX98TPI7YwfYSRsVhkKYRcN8jDJkIM5qmlZmWZj5sN2yYiwlGkawOAPIjziLg38m7uKHu7HyGfc7fpwVwifMCzr1Y7gLo1QVRBs0GELIuJG4CsRMLFhhTzmRSOvILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AszaI7Hq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AszaI7Hq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXoL+WQHSf+XTBr1CBk1hX3xSrp4GoYvIVG/Iw0rQu8=;
	b=AszaI7Hq/0fUAxrji5Cyq5+8Eepq96V0RHlXl9i/Zv7TzG3od+5phkE4vkOFHFqfHEX6tP
	nkVLdmLzCxml/Gw579fLK8C49wKRuuClr4pfClc/w4b5zewxweZ4GNgzWqawRDxBROhITV
	C+exrQnfKXyAaBIa2Pmt3nzOLrR6v3c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-W2IiTfUHMky2ws9y52SxJg-1; Fri, 10 Jan 2025 03:39:24 -0500
X-MC-Unique: W2IiTfUHMky2ws9y52SxJg-1
X-Mimecast-MFC-AGG-ID: W2IiTfUHMky2ws9y52SxJg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e1339790so1116069f8f.2
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 00:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498363; x=1737103163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXoL+WQHSf+XTBr1CBk1hX3xSrp4GoYvIVG/Iw0rQu8=;
        b=sq7NOf2pQd02EoVmVMe+Z5pQLGO4wYOzHCDglAG51vjAbS43Ofge8OY4gTTUI41L21
         lkFDOLgR4iCZvdDZb0+qvMXqkl7EiAFE9b30GkS4aDYWzxWusl3zuJQ23Ls3s2ROD09q
         9Ki7WWk13mYhaVlOaiW+/42nFpY8CEBQ0Pqe1Jgj6pVQsXvIb3K5qLmPdu/Qh6Ub3Utk
         ZHORnRJkwbNDN58SD7CTxbVUPAMz3qdIRadSSu1v4x1ZFzuVHLIqLvHvt037PQkpA337
         R+i4SFWOse7bf5Y54WOsWtSSgtgbwa0AXKDkKIrrHvYeojZcAAf7ad0Q4dNRpwQlJ447
         pLnA==
X-Forwarded-Encrypted: i=1; AJvYcCVhMdVSfKRjZJZVtWgCrD8zP0+x9HEB1bBiTlY+soyPPVw1XYfS0WUVlgfonW+st0g7DUlLFrJ8Xnke1JRWvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDu2b0Q8Tju/cG56/SweG44HzmjdFmNQLfWt5BQHPxMIx7vrsK
	4gpkNeq/FMFAXorTakdft2oq2LnulChHzYsOeK4Cetrs5k2f6J+O8Sg9U5UvIDEfo/G86D/35Ik
	gy+aBWXdt5g1uHBMrB1X+9zuxVsWXbk2z8hIx1MtIrcqDAPX1/o+ippKHIY39OKlc
X-Gm-Gg: ASbGncvGN2pRJwqnuSKd6aXFUcpHfg6fTph3q2+rcuyeHso/WQUrUurBy1Cs1JDjQng
	p5x0RpV+V/u0VZqwinEisnx02X3VkhHQMMYtdpkEtoEIO7WkRvzZZN70LRV3ufg5XiB/cndnphw
	fduBTbtFuzF3HyhDEUIXPI1/QyY0wH+vLjZzWWxzOpYtwL9ceZ72IVeuNCc1qJwOn44vamOxqws
	p88A/s22SHkJYdWGIbQYuAxWJJNamcfzLDSCELZfsQnsw+UGpDUCcnD9w==
X-Received: by 2002:a5d:6483:0:b0:385:fabf:13d5 with SMTP id ffacd0b85a97d-38a8730d55cmr9428506f8f.25.1736498362855;
        Fri, 10 Jan 2025 00:39:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxWFzsARmI1wzAKHZHOe31pA0LmSwGyB/GI2e+cfrQc0ZXGW0pe8rXUAHFnRj3NAhqLwSr2g==
X-Received: by 2002:a5d:6483:0:b0:385:fabf:13d5 with SMTP id ffacd0b85a97d-38a8730d55cmr9428445f8f.25.1736498362219;
        Fri, 10 Jan 2025 00:39:22 -0800 (PST)
Received: from sgarzare-redhat ([5.77.78.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b44sm3942825f8f.90.2025.01.10.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:39:21 -0800 (PST)
Date: Fri, 10 Jan 2025 09:39:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	virtualization@lists.linux.dev, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Luigi Leonardi <leonardi@redhat.com>, bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Hyunwoo Kim <v4bel@theori.io>, kvm@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
Message-ID: <2wsi6sehglavj75jr5gugdq6oqtor7gonx5zhmetzqwvfwc5gn@e3xlsfvygfgj>
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3UtAgfAFDpHMQo_DhPJGh7_D_rCUUOQUxzcoNEZBszM_1736498363
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 09, 2025 at 02:34:28PM +0100, Michal Luczaj wrote:
>On 1/8/25 19:06, Stefano Garzarella wrote:
>> If the socket has been de-assigned or assigned to another transport,
>> we must discard any packets received because they are not expected
>> and would cause issues when we access vsk->transport.
>>
>> A possible scenario is described by Hyunwoo Kim in the attached link,
>> where after a first connect() interrupted by a signal, and a second
>> connect() failed, we can find `vsk->transport` at NULL, leading to a
>> NULL pointer dereference.
>>
>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>> Reported-by: Hyunwoo Kim <v4bel@theori.io>
>> Reported-by: Wongi Lee <qwerty@theori.io>
>> Closes: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9acc13ab3f82..51a494b69be8 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1628,8 +1628,11 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>
>>  	lock_sock(sk);
>>
>> -	/* Check if sk has been closed before lock_sock */
>> -	if (sock_flag(sk, SOCK_DONE)) {
>> +	/* Check if sk has been closed or assigned to another transport before
>> +	 * lock_sock (note: listener sockets are not assigned to any transport)
>> +	 */
>> +	if (sock_flag(sk, SOCK_DONE) ||
>> +	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>>  		(void)virtio_transport_reset_no_sock(t, skb);
>>  		release_sock(sk);
>>  		sock_put(sk);
>
>FWIW, I've tried simplifying Hyunwoo's repro to toy with some tests. Ended
>up with
>
>```
>from threading import *
>from socket import *
>from signal import *
>
>def listener(tid):
>	while True:
>		s = socket(AF_VSOCK, SOCK_SEQPACKET)
>		s.bind((1, 1234))
>		s.listen()
>		pthread_kill(tid, SIGUSR1)
>
>signal(SIGUSR1, lambda *args: None)
>Thread(target=listener, args=[get_ident()]).start()
>
>while True:
>	c = socket(AF_VSOCK, SOCK_SEQPACKET)
>	c.connect_ex((1, 1234))
>	c.connect_ex((42, 1234))
>```
>
>which gives me splats with or without this patch.

Thanks again for the repro, it worked for me, only if a G2H transport
wasn't loaeded (e.g. virtio-vsock driver).

I tested on the v2 I just sent [1], and I can't see the kernel oops
anymore, but please do test/review too.

Thanks,
Stefano

[1] https://lore.kernel.org/netdev/20250110083511.30419-1-sgarzare@redhat.com/

