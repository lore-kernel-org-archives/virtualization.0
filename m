Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EF1CC8A3
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974654; cv=none; b=KsdrOEKoaIpoUNJD2KK9xOSk+/pfziSzokQ79gXAkqs1d5FxDqHAjf+SBK0HzcF37+AolNRPhpLdEVbtfGNL2Ebo6EBcq8SS3G5hpldVG/ENp692+9/AdhXvJ7ngXVxpsITam3Wyiv8qPIlNkld3maDeuRNW41IXM2YJGC4Uz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974654; c=relaxed/simple;
	bh=i2bWLU6m00p8TlV+OMcgPPhsJkVRY5pKKD5A+R1u5eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k9FAyatIvmLr0PoYEVkQASg9LdjVCQM3KanEWps5aaAqFELujEL2RPwChkkDQSOWF7Kp90IGo77dFBePvSMg2BW8zKEQIl1rH0NsQyKpVIYid/aymfFcf53muLuarDGJ++RLxyHGn3rXCMweRa+sFJlf0IyVJkpvg2eWERGRKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/Rz6PEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/Rz6PEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730974651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RT+TotpfDd8T0LMPg0eVo1dThYn+tyWQ9cxcGi4C2c0=;
	b=e/Rz6PEjVi1bOVW4nmHgLdA/OS2cCrlPpiTZHWk8MZJwzHntj6GBwggKlOvjEFdVQnde7c
	A2jMQqG1lNT4TrSeBut/huRq2VOQp3vfIi1S0dz81oCqGjscciUDOHeo7Bma28oevF4Y7X
	aeAM4PrUF2PZ6CmPlOWvPDMY/+I4R/Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-3aYgjYylOKqcA6SmteAx2g-1; Thu, 07 Nov 2024 05:17:30 -0500
X-MC-Unique: 3aYgjYylOKqcA6SmteAx2g-1
X-Mimecast-MFC-AGG-ID: 3aYgjYylOKqcA6SmteAx2g
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d19fcb6892so10100636d6.1
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 02:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974650; x=1731579450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RT+TotpfDd8T0LMPg0eVo1dThYn+tyWQ9cxcGi4C2c0=;
        b=sVpVVWy6g1TGxIw9CbHHLngC0K1Q1LkIFGjORj18Y7MZXKZkxS03s4LA+p2buiBz9u
         v+ILCMXu9Awz8TjDNbaeaQGIR4kXsFUamm3pCcg0Ex5+cjegpI0lIRox1Q2J9DNiS3Gx
         ElsZrdZh7G1wn7AZOkfltJmY0q6T5IqD3L/FSjv0yQdTWD94Th22HSiW0SjMnVCy+fEy
         yHHPPwqr1Vw55VEGLJABdanop6XR7lxOFngwE4JAQ7RPSBcnG/NYfUfSCGbsJxWTyM/7
         trI8f1MsSHtU0NRet9DaANCQtZcPiTriQLjKysIY9U5S+VBI3RC22rLff02YwftorZlF
         OwOw==
X-Forwarded-Encrypted: i=1; AJvYcCUYDS9DJObA0KyAHao6rUSdw5WaId7udN/C0Crd99Y8aFf2VjcSscKF9EFj2Xs3vC7fBoFTESkiALevkX3/NA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3ZWCgwIGQk+96eLgps8kNnWFPgiRDeGWMftCthGnIahJJRwPs
	rPYmQgCrw5aWR1OHCVkbdXBpYjoazJ6N454uEm1S/2GAgjxTEq/19qT6NLfcAvU+g3D0a4UNsk0
	sxb4ZSqGi22R8ZOKo+74NCXzqtoz5Ld8dQKcqCIFXxYkxlcMfHxlWrFjFIrHFp4L5
X-Received: by 2002:a05:620a:190c:b0:7b1:3fe8:8f11 with SMTP id af79cd13be357-7b2fb982995mr3303736385a.33.1730974650101;
        Thu, 07 Nov 2024 02:17:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxQk+y8ShdAUuI0XQTmhaMq5PkmFGd1rW8NElHzMk7ilpzQEiLfRkwxbgbYsdg4ZaY/uBVng==
X-Received: by 2002:a05:620a:190c:b0:7b1:3fe8:8f11 with SMTP id af79cd13be357-7b2fb982995mr3303733985a.33.1730974649719;
        Thu, 07 Nov 2024 02:17:29 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac57c9bsm49118885a.54.2024.11.07.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:17:29 -0800 (PST)
Date: Thu, 7 Nov 2024 11:17:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jia He <justin.he@arm.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 2/4] virtio/vsock: Fix sk_error_queue memory leak
Message-ID: <vxc6tv6433tnyfhdq2gsh7edhuskawwh4g6ehafvrt2ca3cqf2@q3kxjlygq366>
References: <20241106-vsock-mem-leaks-v1-0-8f4ffc3099e6@rbox.co>
 <20241106-vsock-mem-leaks-v1-2-8f4ffc3099e6@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241106-vsock-mem-leaks-v1-2-8f4ffc3099e6@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SEFn7RFg0eIub5WcJJnvoinoxChD_VuNNEjdHvgkbuo_1730974650
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 06, 2024 at 06:51:19PM +0100, Michal Luczaj wrote:
>Kernel queues MSG_ZEROCOPY completion notifications on the error queue.
>Where they remain, until explicitly recv()ed. To prevent memory leaks,
>clean up the queue when the socket is destroyed.
>
>unreferenced object 0xffff8881028beb00 (size 224):
>  comm "vsock_test", pid 1218, jiffies 4294694897
>  hex dump (first 32 bytes):
>    90 b0 21 17 81 88 ff ff 90 b0 21 17 81 88 ff ff  ..!.......!.....
>    00 00 00 00 00 00 00 00 00 b0 21 17 81 88 ff ff  ..........!.....
>  backtrace (crc 6c7031ca):
>    [<ffffffff81418ef7>] kmem_cache_alloc_node_noprof+0x2f7/0x370
>    [<ffffffff81d35882>] __alloc_skb+0x132/0x180
>    [<ffffffff81d2d32b>] sock_omalloc+0x4b/0x80
>    [<ffffffff81d3a8ae>] msg_zerocopy_realloc+0x9e/0x240
>    [<ffffffff81fe5cb2>] virtio_transport_send_pkt_info+0x412/0x4c0
>    [<ffffffff81fe6183>] virtio_transport_stream_enqueue+0x43/0x50
>    [<ffffffff81fe0813>] vsock_connectible_sendmsg+0x373/0x450
>    [<ffffffff81d233d5>] ____sys_sendmsg+0x365/0x3a0
>    [<ffffffff81d246f4>] ___sys_sendmsg+0x84/0xd0
>    [<ffffffff81d26f47>] __sys_sendmsg+0x47/0x80
>    [<ffffffff820d3df3>] do_syscall_64+0x93/0x180
>    [<ffffffff8220012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 35681adedd9aaec3565495158f5342b8aa76c9bc..dfd29160fe11c4675f872c1ee123d65b2da0dae6 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -836,6 +836,9 @@ static void vsock_sk_destruct(struct sock *sk)
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>+	/* Flush MSG_ZEROCOPY leftovers. */
>+	__skb_queue_purge(&sk->sk_error_queue);
>+

It is true that for now this is supported only in the virtio transport, 
but it's more related to the core, so please remove `virtio` from the 
commit title.

The rest LGTM.

Thanks,
Stefano

> 	vsock_deassign_transport(vsk);
>
> 	/* When clearing these addresses, there's no need to set the family and
>
>-- 
>2.46.2
>

