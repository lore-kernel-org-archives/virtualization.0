Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1E1386DA
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423602; cv=none; b=XbyusK1KB0+B/Cd3NS7aC3ALLxGk4nGy2l3EAV9xGuxChWA7mGdDdbTHrA12da9bHTfHD13Pf0T8dIFPockJ9Bt+f2WLdBr40QE9nWCP4z6g1oLX0Kri7tSpl2inRLSSP3fi2lexV4kckIRkcnNEyHuULMo0ChluZa/+DG+spec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423602; c=relaxed/simple;
	bh=9F5t42L4T7DlrKAbIEzJacTshtoofiMJhhUWO+3Np/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ia1kQ4dHA/nYXZlRjNQtN9u5n6pM6JHuJ/8QN2np3H8xdBoYlN0cbnz6TxsidWZuD2wyj6AlZKFatrWi+St42uCTy/5Lm43n8NtiIXMeDJ6jxewlCG5vjA9r59+C+jWfKqQ+YNvfMFcHacNZGjAEOf0HtR+KC10KVgYmqU88N6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVyV1p0W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVyV1p0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745423599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4vXjdITA2otLqOLfSkM93EoHhrqfeYMofeR1JyUMjL4=;
	b=eVyV1p0W1oiWX0qVNfXRAu3KkmnUI4EKW5BvSJQpXAVQFTHpQzhFg3/bq6XbUbaG5+8Rgt
	hvk51EZJWCDkPFDie9ezHNkztAdu2xzQfcRhhY28CMXjbElksp38735qToG231SOyyLmci
	unMdLwRUsCDYEXJ13u3xluiJyss4TG4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-GAwB5-b6Mrqmi5fpnkMGNw-1; Wed, 23 Apr 2025 11:53:16 -0400
X-MC-Unique: GAwB5-b6Mrqmi5fpnkMGNw-1
X-Mimecast-MFC-AGG-ID: GAwB5-b6Mrqmi5fpnkMGNw_1745423596
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39d917b105bso3174397f8f.2
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 08:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745423595; x=1746028395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vXjdITA2otLqOLfSkM93EoHhrqfeYMofeR1JyUMjL4=;
        b=UdyjIxl3NpaBuokeBewKFYl6R7XdjWVQdKTZsS6Co1NFuA3p9wCXmgImiL9AdVv9vW
         T3oS31oYrQ1UqKR2Voh5GpLDxjwL+kvASMil6qRzBh1spZyYCWEUHuxvyi25oYNm7dvA
         xzAY/5762tNttdUzJrwiypnqAvZRRGLfLOMYdxTVYSryeGFAy9yj7AT0K2qiZhNSrNAD
         1JuRsG8WwvQqFrPjVMdVcVUgX9SEj3Cs/0T5cssSaFgW0Y9DCS6FcDCOrE93fr171acw
         qXwxWly77pHlcSwaNjwAQyoviBWtOiZbHJbl3624/g4IoRuW9V3doRdOmaYmZ/khQQOc
         wl1A==
X-Forwarded-Encrypted: i=1; AJvYcCVwI4KUlEYEAeua56T84IR4nNwe4LU6pa77MpZE2fNcarAYAunOcZQuK9QjpgyljP/jCHfGhPLq6wYqx5Y7hg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywx1DyZLEESxOvmx+4Rpt1Jk3SFxjpDbgTeooqo0mBlOrfh4hSY
	pS1f0LQHfObp8uJMi8socMqvH2RKxxT2DLbHRDACJhHuGcRiFxUzUx7MaTUyRjB7FOX9RoCnbm0
	yqkFyFSGOLj3Twrt+268GA6DgvxUI1jDZXuOdNLoPfNbpINiydbXEVfjEhAW0LcPQ
X-Gm-Gg: ASbGncuycZA9Frs1tEboAc0+frsvBIDLY8r2susLaEt4FK86HVcwkvzyxLSDKBh4oTB
	xmrXK8S7+JAOJTVRX6x1TKgzdV9ax5HLHPRHTy8w21R3Iq1kRNxoc34Ro9gdx2xbZRyiMWcG4ZD
	F5A13vk6h6AM43YKZiDSPdvfgi42QUqFRtE6xux4KRuDHGvZcTXLf9oErL2QfbTY8ihGR7lId1l
	udgt6DManmVKKieGTJFIztVRyRYXiWT4yentSC971Zc4zWf9MEQUXiKal+P5d/v3/JamY+6+tXq
	g8qcC6lCxTD69g==
X-Received: by 2002:a05:6000:402b:b0:39c:e0e:bb46 with SMTP id ffacd0b85a97d-39efba383d1mr15395528f8f.4.1745423595608;
        Wed, 23 Apr 2025 08:53:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Ev46g9NwPjawD8USomZKAsrAiFv9uPuXFN35OxT/qY5CZ5sbL5NV6EP3Ne7VxwIqM91Svg==
X-Received: by 2002:a05:6000:402b:b0:39c:e0e:bb46 with SMTP id ffacd0b85a97d-39efba383d1mr15395506f8f.4.1745423595246;
        Wed, 23 Apr 2025 08:53:15 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493212sm19371776f8f.66.2025.04.23.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:53:14 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:53:12 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] vsock: Linger on unsent data
Message-ID: <km2nad6hkdi3ngtho2xexyhhosh4aq37scir2hgxkcfiwes2wd@5dyliiq7cpuh>
References: <20250421-vsock-linger-v2-0-fe9febd64668@rbox.co>
 <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250421-vsock-linger-v2-1-fe9febd64668@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -59KUhXebQwk8yOGWwMe6wRQGlNtgHlcycg4sMS6IXE_1745423596
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Michal,

On Mon, Apr 21, 2025 at 11:50:41PM +0200, Michal Luczaj wrote:
>Currently vsock's lingering effectively boils down to waiting (or timing
>out) until packets are consumed or dropped by the peer; be it by receiving
>the data, closing or shutting down the connection.
>
>To align with the semantics described in the SO_LINGER section of man
>socket(7) and to mimic AF_INET's behaviour more closely, change the logic
>of a lingering close(): instead of waiting for all data to be handled,
>block until data is considered sent from the vsock's transport point of
>view. That is until worker picks the packets for processing and decrements
>virtio_vsock_sock::bytes_unsent down to 0.
>
>Note that such lingering is limited to transports that actually implement
>vsock_transport::unsent_bytes() callback. This excludes Hyper-V and VMCI,
>under which no lingering would be observed.
>
>The implementation does not adhere strictly to man page's interpretation of
>SO_LINGER: shutdown() will not trigger the lingering. This follows AF_INET.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7f7de6d8809655fe522749fbbc9025df71f071bd..aeb7f3794f7cfc251dde878cb44fdcc54814c89c 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1196,12 +1196,21 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
> {
> 	if (timeout) {
> 		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+		ssize_t (*unsent)(struct vsock_sock *vsk);
>+		struct vsock_sock *vsk = vsock_sk(sk);
>+
>+		/* Some transports (Hyper-V, VMCI) do not implement
>+		 * unsent_bytes. For those, no lingering on close().
>+		 */
>+		unsent = vsk->transport->unsent_bytes;
>+		if (!unsent)
>+			return;

IIUC if `unsent_bytes` is not implemented, virtio_transport_wait_close 
basically does nothing. My concern is that we are breaking the userspace 
due to a change in the behavior: Before this patch, with a vmci/hyper-v 
transport, this function would wait for SOCK_DONE to be set, but not 
anymore.

>
> 		add_wait_queue(sk_sleep(sk), &wait);
>
> 		do {
>-			if (sk_wait_event(sk, &timeout,
>-					  sock_flag(sk, SOCK_DONE), 
>&wait))
>+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 
>0,
>+					  &wait))
> 				break;
> 		} while (!signal_pending(current) && timeout);
>
>
>-- 2.49.0
>

Thanks,
Luigi

