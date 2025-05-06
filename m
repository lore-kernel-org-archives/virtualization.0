Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BCA266576
	for <virtualization@lists.linux.dev>; Tue,  6 May 2025 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524699; cv=none; b=Br1elERuYBP6swz+8MCc9mdcYvY/5BE+zA7jseE4/RuoXoJKi98xljrXaH2JnwHfkaV2OOQQeJDqsByTjmnlR4w3q5d6F48SugieRqnC4lv5Rdyvt0SUMv+gbPSoWuvPUzuCgOVyCd0d7aeAGtdnJI8e0GgXrHaLvnl7RgCKEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524699; c=relaxed/simple;
	bh=XtmhV9BRgG8S3EP7Ij8mgx59xV75hcQcMAEky/2dcT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rjdT0Cui8C54cuoxgywmscAgQM/Kv/rI6KF2Y//nokydDDZ00XVWlKvE/5pAyPUEhfX2hYiOf6XTaBQXfGOZYBHcsqHkqqOXkTaD3tF3tEWdom3kcvjcU3EIJs3iW6Eyno7UmRS65G/QuZ3PilVKm7357M3eUUh0QaTSrf9K2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQ0pfE/N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQ0pfE/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746524696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywb7zRNx3vPc7CyeVZadCCnMzE2V02v3OC1ITxjbuEs=;
	b=FQ0pfE/NEQIx8FZeRMrSAhhLAnPe/ur9KgsT++4OJNIkJ+6GMQhJPSAxsm62WC1/oRGuH3
	C+KJ+mtxWB+0M7kdkmaHRBzqETlFcJIxOnGDqXHAglLVG/JFXV+Twd6E7JPsyexNCpBURs
	If4jIpV28BD8XO9eziDW1OROJFw39M0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-yWwkG1u_OoeRmkGwIXp7oA-1; Tue, 06 May 2025 05:44:55 -0400
X-MC-Unique: yWwkG1u_OoeRmkGwIXp7oA-1
X-Mimecast-MFC-AGG-ID: yWwkG1u_OoeRmkGwIXp7oA_1746524694
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb2fdc6b29so600524266b.1
        for <virtualization@lists.linux.dev>; Tue, 06 May 2025 02:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524694; x=1747129494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywb7zRNx3vPc7CyeVZadCCnMzE2V02v3OC1ITxjbuEs=;
        b=fsv2ra4KKT9Vh8stSK5UcpzT/pkhBoMESA2RaYxao3SggNAjPENJcXgS7EC8OAYv+i
         FNZ+ISC8YYawM3PtwyX2Vw4aFSJIERBRtBSNUP8Ra4E0nJrUquCANbGjov2BTMAadgzz
         M+oKYdef0O9iQUUEECyz/y8geyB3SHUhDcTp9r3HK5neQUTeVRmYTK5e0JbnfPe8CfHB
         gSTLcpxhOGGdbhz4t7dAoG2vsp3xoolf/en3QGFvtpcF1D2tluqs5w5wKIpjh+pA/e/R
         EfimABvMmzTjct6lmw/j4MmwUOdp4umsfHxbo5ZldNJq083AyNz2PPJMI/nJ2EcCbnMJ
         kXWg==
X-Forwarded-Encrypted: i=1; AJvYcCXYBZ2qq42B67NmPhV/8Sj0nOk/acdz3AlZmGplS/ufALMdWhHqyxMNAcGlLowdtIRG6yhDl6Ez0xP07Xsx5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YycpB602pIub0cgcUkt5iDFds/kM4StnbtuqKpnBUY5vTEb+exG
	T2Hg3TUPK/+rdLW/6zMh+8rgaKvhAH3EmS/doQUfz7F1jUtOmM8cZuhNKkyGlo8rcrLKOb8+YGp
	1LEGDo6efib4O6CZMc8ypPQt5tP04fpXYUeA1dIARZsmY8krfvLwf4iBYjLCuELn9
X-Gm-Gg: ASbGncu+D/tOf64BZfLugPrqC1LyeHUB8xfXZE4HDYVPjc5Gi/EnnCw5U4hJMWQ8hYd
	CLOlywhLkJCuAr6SxVfzkYXP8kLGXNxUJtnmY3zsGtkFNX9v6OMUP1jBIhITHgmLxOrbUyQ6Se2
	1+RkB3G1Lr2f4yf/lK2qb1g24T2q4cRGHHpgtSsn1qSSnZy8/0FKQWP8acwKE5Vji66w66lECca
	M/okGOzbXGMt6HiQ1ECM/5CvzQsqsEQto7JKwccW+GVxHbVdPEohcHpCtPEuwEiLeE3tTNG9KRZ
	znsUtZfH3yofPJ+akw==
X-Received: by 2002:a17:907:720e:b0:ace:c47c:d05 with SMTP id a640c23a62f3a-ad1d2edb5a8mr271263466b.17.1746524694205;
        Tue, 06 May 2025 02:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy3Ipkv1JwfR8lsrwW2awsV3Xlbn5tYIVtWI1ItVLrYmS6wlQhRVbeVxW3XdsKsaomx8V8tg==
X-Received: by 2002:a17:907:720e:b0:ace:c47c:d05 with SMTP id a640c23a62f3a-ad1d2edb5a8mr271260366b.17.1746524693669;
        Tue, 06 May 2025 02:44:53 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.219.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189146991sm676458966b.14.2025.05.06.02.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 02:44:53 -0700 (PDT)
Date: Tue, 6 May 2025 11:44:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] vsock/virtio: Linger on unsent data
Message-ID: <2latqq7jrneyimj6okjbarofnksmgwddwq2eie4mforjrjaxwv@jjbru7irkyyi>
References: <20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co>
 <20250501-vsock-linger-v4-1-beabbd8a0847@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250501-vsock-linger-v4-1-beabbd8a0847@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FurjktPd2G-WlaPZLeaUn_vtsXdKczJCkj3VPONG-_k_1746524694
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 01, 2025 at 10:05:22AM +0200, Michal Luczaj wrote:
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
>Note that (some interpretation of) lingering was always limited to
>transports that called virtio_transport_wait_close() on transport release.
>This does not change, i.e. under Hyper-V and VMCI no lingering would be
>observed.
>
>The implementation does not adhere strictly to man page's interpretation of
>SO_LINGER: shutdown() will not trigger the lingering. This follows AF_INET.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7f7de6d8809655fe522749fbbc9025df71f071bd..045ac53f69735e1979162aea8c9ab5961407640c 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1196,12 +1196,14 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
> {
> 	if (timeout) {
> 		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+		struct vsock_sock *vsk = vsock_sk(sk);
>
> 		add_wait_queue(sk_sleep(sk), &wait);
>
> 		do {
> 			if (sk_wait_event(sk, &timeout,
>-					  sock_flag(sk, SOCK_DONE), &wait))
>+					  virtio_transport_unsent_bytes(vsk) == 0,
>+					  &wait))
> 				break;
> 		} while (!signal_pending(current) && timeout);
>
>
>-- 
>2.49.0
>

