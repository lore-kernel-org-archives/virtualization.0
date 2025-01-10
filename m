Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE921205ABB
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506670; cv=none; b=uJazdsvrAxwpDGJ4nUHyqoCzwGlwb3xczd4lB4540ktHa6LcF2iyQCXSO+uyAaLVf95EiSy8ufBn6/cLLk5VD25NZFlfPcYlHKENiruvGbI0r4r7gTxqiWywiBizhwduepNNSJTPiqFJKtJm7cX9uC6DtkFT79R6Z4iTLHta41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506670; c=relaxed/simple;
	bh=J08jrPV1Tnjsks3FkDNgHe/lPdv6Q0IvGjCXuEqHoGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BrSBm8yDnhu9PJPn7/npOnnmk7c7DwL3Bdm+dbR7Bcy/BNmYMrfPbOI3Q2/VuHzMkZvwslBjsVs+7ervi9Z94HxYJlRK27rkLYENRNZc7Sf7JF0YGP4EPDTqc9cFQqmJ2ODdbDP3y2mgZJKFgRR30NT3VnyadfGZVw2SYz0CtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya5DnIDC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya5DnIDC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736506667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wTBki0vgAxfifXdgNeBVy0WzwbqroFsqKcMbO7Lm6Oc=;
	b=Ya5DnIDCPSRTMqHSHaqbFediVvJ04vNPm0FvcEpybFDWL5O2AmQklIF/uLpees45BKg6Bk
	xEIPusujuHFcehfT4qKyRKo/RpJ+EAq0sxeLRcedt+ydHYugcx+Jk0jAZyF9p9uulqAKRc
	QwrcCAWupTd2hnauVt/tA8C6/fi7rxs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-kTV6KJNNOUu74zTkJxxEcg-1; Fri, 10 Jan 2025 05:57:46 -0500
X-MC-Unique: kTV6KJNNOUu74zTkJxxEcg-1
X-Mimecast-MFC-AGG-ID: kTV6KJNNOUu74zTkJxxEcg
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa67fcbb549so202024366b.0
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 02:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736506665; x=1737111465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTBki0vgAxfifXdgNeBVy0WzwbqroFsqKcMbO7Lm6Oc=;
        b=JMf10yGFmIkjuBdRptl2ADexlvCoEOrAZnSJMpuxQP5a1rQhTi7nrDin8h1ZyStDfE
         ZTOtE6hHj5A9/E5NXpK6BkPdoxmCJoClcn+opApPRJ70+Z2aucUsvCutoB8zDicwgaKz
         uTqxsDRQyjyE7Vo+lFg+dUlUXuj4VfHVH/BKNUxMOdrIr4VlI2gA6zV3NABqN/9krzZG
         GULlXpndM8tOyX851WWqoa1P/loZLwMQk7DiN8kMhMzmYkov5DaRxxaxIzMbrqX8v1jt
         5EXbUrarhAGVY/c6IpnX7ZDK3IF2dhEc2nU4XZZnCug/UCLuenGrEj6s0YCJQDQOfONt
         Sl2A==
X-Forwarded-Encrypted: i=1; AJvYcCXKz6M0aybH21Wq4VLMzs4CmXKGBELFf1D2BVIcicxEB4BNgf0xuTIrJsgR/16rqQp/4d4ofoZz6z+LqJyjIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUFtB0rT90mm3TZ1GAFCnr8q0X8wYFGmYNCTcZP7/QKA1xfYVb
	yIdwrDhogT7HYNrgnCJnLIlkI61dsOgFu5vcudD812GDpeddtEJUm3Ci3OSYMTUeXLGUlOH9xtl
	fJGlmbqxL+0Q4kk6KPhgZ0IghZSWFCxOB5t5v9aGpS/lPm/cgDtUi/Y3tvoXWKDSZ
X-Gm-Gg: ASbGncsYLcyawEbxiw3gaeM/ih2gkATcnmW5V/Yg/giOHYqsvEZYgFn3d+WUoX7ff94
	Wu9fNClBCx9a735dQg3qvCWuUyAcsOEgu60nx6MseAdcLTk3zwTl54HITQvqQodo0n1pfhZZNAX
	y8uwR7u6R+CfYPJMbznvIuSYp4UEn0RpD1cFE9RE8a3GHxqkxlpl7/4y5ljG+WFAAkdmUv7T0dV
	xEbEUDQ/6z0hME8vskR8oXopwpC7F0qbc0lGwAWJIkt/tVly20d+VIQpfFk
X-Received: by 2002:a17:907:7b99:b0:aa6:2a17:b54c with SMTP id a640c23a62f3a-ab2ab16b1cbmr782663866b.6.1736506664806;
        Fri, 10 Jan 2025 02:57:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESv2FtstfmeRfNMDHjG83u1YYQu94Q31j0qdyPPj9UJSPP/WkoIPQIVfa4hgWYpj5Nmu9NKg==
X-Received: by 2002:a17:907:7b99:b0:aa6:2a17:b54c with SMTP id a640c23a62f3a-ab2ab16b1cbmr782662166b.6.1736506664375;
        Fri, 10 Jan 2025 02:57:44 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90d7432sm153952766b.49.2025.01.10.02.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:57:44 -0800 (PST)
Date: Fri, 10 Jan 2025 11:57:41 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Wongi Lee <qwerty@theori.io>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, Jakub Kicinski <kuba@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] vsock/virtio: cancel close work in the
 destructor
Message-ID: <f6wv63x75ohn3s3isbbfggnvpfxwx5mbgnpmol4tnw5tthq4nf@wb62fpiplgs4>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250110083511.30419-4-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RhF1zzdHSgWhuvCDxdSjhAw_cdtOtna1UoU7yvlzOr4_1736506665
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jan 10, 2025 at 09:35:09AM +0100, Stefano Garzarella wrote:
>During virtio_transport_release() we can schedule a delayed work to
>perform the closing of the socket before destruction.
>
>The destructor is called either when the socket is really destroyed
>(reference counter to zero), or it can also be called when we are
>de-assigning the transport.
>
>In the former case, we are sure the delayed work has completed, because
>it holds a reference until it completes, so the destructor will
>definitely be called after the delayed work is finished.
>But in the latter case, the destructor is called by AF_VSOCK core, just
>after the release(), so there may still be delayed work scheduled.
>
>Refactor the code, moving the code to delete the close work already in
>the do_close() to a new function. Invoke it during destruction to make
>sure we don't leave any pending work.
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Cc: stable@vger.kernel.org
>Reported-by: Hyunwoo Kim <v4bel@theori.io>
>Closes: https://lore.kernel.org/netdev/Z37Sh+utS+iV3+eb@v4bel-B760M-AORUS-ELITE-AX/
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 29 ++++++++++++++++++-------
> 1 file changed, 21 insertions(+), 8 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 51a494b69be8..7f7de6d88096 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -26,6 +26,9 @@
> /* Threshold for detecting small packets to copy */
> #define GOOD_COPY_LEN  128
>
>+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>+					       bool cancel_timeout);
>+
> static const struct virtio_transport *
> virtio_transport_get_ops(struct vsock_sock *vsk)
> {
>@@ -1109,6 +1112,8 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
> {
> 	struct virtio_vsock_sock *vvs = vsk->trans;
>
>+	virtio_transport_cancel_close_work(vsk, true);
>+
> 	kfree(vvs);
> 	vsk->trans = NULL;
> }
>@@ -1204,17 +1209,11 @@ static void virtio_transport_wait_close(struct sock *sk, long timeout)
> 	}
> }
>
>-static void virtio_transport_do_close(struct vsock_sock *vsk,
>-				      bool cancel_timeout)
>+static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>+					       bool cancel_timeout)
> {
> 	struct sock *sk = sk_vsock(vsk);
>
>-	sock_set_flag(sk, SOCK_DONE);
>-	vsk->peer_shutdown = SHUTDOWN_MASK;
>-	if (vsock_stream_has_data(vsk) <= 0)
>-		sk->sk_state = TCP_CLOSING;
>-	sk->sk_state_change(sk);
>-
> 	if (vsk->close_work_scheduled &&
> 	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
> 		vsk->close_work_scheduled = false;
>@@ -1226,6 +1225,20 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
> 	}
> }
>
>+static void virtio_transport_do_close(struct vsock_sock *vsk,
>+				      bool cancel_timeout)
>+{
>+	struct sock *sk = sk_vsock(vsk);
>+
>+	sock_set_flag(sk, SOCK_DONE);
>+	vsk->peer_shutdown = SHUTDOWN_MASK;
>+	if (vsock_stream_has_data(vsk) <= 0)
>+		sk->sk_state = TCP_CLOSING;
>+	sk->sk_state_change(sk);
>+
>+	virtio_transport_cancel_close_work(vsk, cancel_timeout);
>+}
>+
> static void virtio_transport_close_timeout(struct work_struct *work)
> {
> 	struct vsock_sock *vsk =
>-- 
>2.47.1
>

Thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

