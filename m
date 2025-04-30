Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E61220689
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005230; cv=none; b=X0hDXQvYwcqlh2r+uLNhtIi7ijTbP5cEJB2GnuB1OU3WG5eWSWkvw5RDp2ZAgLWH2VzhSpJI3Yjon+l/mh31Ev3jnAUzaQp9jBOSp8iLrAR0MgoUvT8gOnTosmAH7iggZ7+81Zd9VKfhhRqupO4H1ADPT/VqiAXc4vChnP/ixcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005230; c=relaxed/simple;
	bh=kjb/2qlRokzw4V64RKekB6zLbCzs3UmMCafUrdMO+5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hMCyujSjLsZznU0MGNWtzc7KiPeKiHn4I5G6plbpyXTMUqqT0n8dEo/Ke69xDHq9yQMxfIASfanKIE9mkgmMAB4o17uXl3h+MiftSn7jy2LA53hngmRA592r7SM3jxR6ZhZGNukbsMlVm3VqU4YM7DP6BnLZ/fKWltp064+kz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pibo+tnp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pibo+tnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnGE355VKh8cwgKuDwR0kb5tI61AXcZQbhXFxQc6RqM=;
	b=Pibo+tnpQS2AmL4YzChF5unANdCDon7pI8mcnAk7va3BN+ztA4AeVa8qjrkh19kducQK+D
	dDQr5MzxU81SXts17mJTVPA3RQJAMgoAM2hdKFv3ZgyX/ZYbLtLauXwKpFt4X25Nz5oXXZ
	H1G3olNPVSEC4KFpasqX6ujLcnQWuCo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-ZUj4H_ukPjCEQvP3JdYDow-1; Wed, 30 Apr 2025 05:27:06 -0400
X-MC-Unique: ZUj4H_ukPjCEQvP3JdYDow-1
X-Mimecast-MFC-AGG-ID: ZUj4H_ukPjCEQvP3JdYDow_1746005225
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac287f28514so578914666b.0
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 02:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005225; x=1746610025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnGE355VKh8cwgKuDwR0kb5tI61AXcZQbhXFxQc6RqM=;
        b=aLa5G5YylvHMVzarkfKSBRkAxVp30AqlTmR+wnAzN6tvp/qJ8g7azVHLmqsmzTPA8H
         0t8X7MLijaBihe7Cl3GVgw7INHENpCCH9d50rhUhAj85i4T7jEqlXKj9pfmDmkbtn1h7
         vu0DOqwFPkmgJZjbo92NmOCikHAxF2fhGfvIiky/eNiqTCdpkqkcIuSWnGabmgGD7QIE
         2T0A8ZCW9nTMnn/2LSmKvzS3/fo9qvxcxbNvkdFpD2L/qpsus/+/R/m3rlACTSVkDAGm
         rjdjCnbkd1OrVNxzhSQLo00px4KDwun6d9bhIkIgQD9mPL0Gtjs7UCYKE56CmmRAn9cc
         w1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVNO26x3G3ATYMZ/wtPaUlQY/z6YCTrlVdwlgkuGAq3lTX4W9J75F2xwgal+890eLGJfo0LcBUYny/S4QKZkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3KK5ASb+mU101y3jl8mOBSj/ttI0DRFYjIM8SCqZOC2kgYow9
	Xw3GO/p3sI1eG7frPmPgZaYfeQxzSWJidgnKNuu9X7ANtTVd0MSsPulnyJKufjh7X8ENJB572n6
	WTB8Sas06O/cFZm9/N2kpPznpCzic9azPyumGljFcGEc64H04udwwO5G7kwnIiIyf
X-Gm-Gg: ASbGncswN1FZR6cpego+2uPxGajXMNvieWGe6vGgB+F6j5lKNOBJ9x6Z2p4SLNq81au
	zEecPV7Bujn352cjX1H2xkYyS9ITjaJilg29bUS29/drBb9E3nzvONdhj4tdaWGur3xt3QNINEr
	U+YK614+sYEZMxBmAw2EbgYDUqBWFQYyyrEZDMqTQ/6EMyqR2xT4T6Xo7UcjOVf/BxgggrYqNp6
	RTDU+BVENucYcTzJgvehduTLJNkCgBtibuZuO6VpZAlP2YJ5tx6HHjbMLInSDbJB/GjRY4r1Y5Z
	+SHN2z13J9X7Yvmpmg==
X-Received: by 2002:a17:907:6d22:b0:acb:6081:14ec with SMTP id a640c23a62f3a-acee26469f2mr167108966b.61.1746005224701;
        Wed, 30 Apr 2025 02:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpWzcCN+MPKS91oqLZ/RURiVcQD7mwDZdTf3RoSbMle6jXy5M9/HSlwH5Kk6tGLLsNJHDLYA==
X-Received: by 2002:a17:907:6d22:b0:acb:6081:14ec with SMTP id a640c23a62f3a-acee26469f2mr167105766b.61.1746005224017;
        Wed, 30 Apr 2025 02:27:04 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e70b0sm895358966b.43.2025.04.30.02.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:27:03 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:26:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock/virtio: Linger on unsent data
Message-ID: <x3kkxnrqujqjkrtptr2qdd3227ncof2vb7jbrcg3aibvwjfqxa@hbinpxjuk3qe>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-1-ddbe73b53457@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250430-vsock-linger-v3-1-ddbe73b53457@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yGofYnOMLL4S3wdcI0Q35m4nDGwj2_oLEFgp3AKMsnA_1746005225
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 30, 2025 at 11:10:27AM +0200, Michal Luczaj wrote:
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
> net/vmw_vsock/virtio_transport_common.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 7f7de6d8809655fe522749fbbc9025df71f071bd..49c6617b467195ba385cc3db86caa4321b422d7a 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1196,12 +1196,16 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
> {
> 	if (timeout) {
> 		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+		ssize_t (*unsent)(struct vsock_sock *vsk);
>+		struct vsock_sock *vsk = vsock_sk(sk);
>+
>+		unsent = vsk->transport->unsent_bytes;

Just use `virtio_transport_unsent_bytes`, we don't need to be generic on 
transport here.

>
> 		add_wait_queue(sk_sleep(sk), &wait);
>
> 		do {
>-			if (sk_wait_event(sk, &timeout,
>-					  sock_flag(sk, SOCK_DONE), &wait))
>+			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0,
>+					  &wait))
> 				break;
> 		} while (!signal_pending(current) && timeout);
>
>
>-- 
>2.49.0
>

