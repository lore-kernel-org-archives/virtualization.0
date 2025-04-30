Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5091821B9E4
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005330; cv=none; b=kmlnzSOUtnPpZjSpZnvgXjlZGx6er1zSEnv2SoR1NQnxcRW9OBB1qux6qAOXfdOdHjn2vHFkcJNFADp9FOx/S7t1EpIr2BZUdVaktmG/pAIEwPPWow8WNz3DCMdoYZ/lG8bU3XCCLak0bfJsFaluDlNTcOkQs8cWKIpZ98kpKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005330; c=relaxed/simple;
	bh=CfCKT7csdC6kxz8qRaiEnDt65u+ulhVQn+dGe+7KfZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dOxkC7xBBrSBPD7dLyHkkaM6hfVifjoQPButWQ2QyXWm9pKhDZ6s/O/dYKVFMRD014kQFqJAxraD55zTYEPiVNeIjFJ3VLhr4BcuJ+Uk27edqNeCNjteZr52E5y6bQTBYQF7OmL0lMPapkfMmpAU8Ytq3uk6JCQquGmcLY+kKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGtDhnkG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGtDhnkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746005328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+iRdHR/016I7PiLqqexsMYXzIsBDeKqTco6kET+eEo=;
	b=bGtDhnkGiXcKpQOXTTwAZSU4uSl0TKmejjneENi0Mep5srnOF+ZubCzxZzBXEjGjd2F2ZZ
	9DyIQnyaHh7sSqNfKLGp5iKSjDWBv8fGW3Mniu96tPn1zY05cM5VVHGzmsY7e7sbqXxvV8
	ESXoanh4Bj97ZUgNO3ZyQsDIHJWqYFI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-V1ykpVevPVykaPyj7PesSQ-1; Wed, 30 Apr 2025 05:28:46 -0400
X-MC-Unique: V1ykpVevPVykaPyj7PesSQ-1
X-Mimecast-MFC-AGG-ID: V1ykpVevPVykaPyj7PesSQ_1746005325
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5f525f190adso4544261a12.2
        for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 02:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746005325; x=1746610125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+iRdHR/016I7PiLqqexsMYXzIsBDeKqTco6kET+eEo=;
        b=AEXU6j8cAzSMc4uJ3+5qevtiGY+w8aUPILx5ub2Pj1dU1baatuSrRmPWwutZdN3HPD
         PAziFppN6SXQzP8nASJ4kId5FxMzG9juuxj9gquXzV+EQFkb8KIyxR9Ob5+BxPDv7Oad
         f8d3cqO00UnORMqDHkRkrZ8UOKee4yp1Stomg/jD25454XqfAoAoCpWlcurA970v+ZS6
         DLkYUEz7Vlvhpbyrf7IAOkXwvFPe3hZxY8yZRHYgMvjaQf9+08V9GhEkf4fAdTPc4wK8
         AvS1jI2IKNVKEVv186h3eZJvukxjbF86iusLKC5Bh3sFNMSOKWbeUFWgjOdD+W2JZA6K
         33Bw==
X-Forwarded-Encrypted: i=1; AJvYcCX3vYWk4nFnTmhHu/+G88CHmdmXM6j4Kyddc4rNHrDVcMEW5xH8mRdcJttcZO8uBlhWeumGeHZjcr7jkMHugg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx72StkEot25V4d9LMJpOr9brB2kM9eCY5ng0NP2mrUo7khC0GI
	txmpedKFmNBupJLygJgRsg10msBtmvmhJAikGwm3s8rs5DiLPEK8w8GMKJlvbiFloTbKnJYtRXP
	SoaTZZPAdCdaapr+v8XPDJWPOK8HZphJHO/bPiZ2LxeUU9SW3YSDG0utSSTKN0tgC
X-Gm-Gg: ASbGncsmtbjY4ixCeIG1n3YOu+INUjErPnGhnFCkV0HuzZzo230CiPLUq+bii84NyRg
	63bUzde6ku7uertBw8cfQsiW3ZLuu1nGpmWY2FFVzH+w+0uofsSF836q83behvXZ+UUvYoYeECr
	28GpWGxxGbDE8assIk4wi7Fhbz4YyLkYaS6R4hhQZg5404vqzcOoonpti1mT2F3REMrSbSbLuBy
	TTdtRKYDzv85mKc5aXY4S/Lg7JecZI7JeNBsOpUer8LpWcOQqUBGQpoL+ywDv/Ee6ZP/0YWlXS8
	wzFWI3Ip5Lz3cTN5pA==
X-Received: by 2002:a05:6402:3490:b0:5f7:eaf1:acd1 with SMTP id 4fb4d7f45d1cf-5f8aef99451mr1459108a12.10.1746005324749;
        Wed, 30 Apr 2025 02:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE81eWc8aL2LbvtLmC3j27kWn9yssNrgLAfG68UpEapDAHpJ7zaXyuHj+dnHphj20qrinwPqA==
X-Received: by 2002:a05:6402:3490:b0:5f7:eaf1:acd1 with SMTP id 4fb4d7f45d1cf-5f8aef99451mr1459078a12.10.1746005324176;
        Wed, 30 Apr 2025 02:28:44 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7e7e47be3sm5249067a12.30.2025.04.30.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:28:43 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:28:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock/virtio: Reduce indentation in
 virtio_transport_wait_close()
Message-ID: <dlk4swnprv52exa3xs5omo76ir7e3x5u7bwlkkuecmrrn2cznm@smxggyqjhgke>
References: <20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co>
 <20250430-vsock-linger-v3-2-ddbe73b53457@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250430-vsock-linger-v3-2-ddbe73b53457@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a4R0J8bvufPfOEArkzP139fBl7jkuYS1KyiDqcJ-kyU_1746005325
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Apr 30, 2025 at 11:10:28AM +0200, Michal Luczaj wrote:
>Flatten the function. Remove the nested block by inverting the condition:
>return early on !timeout.

IIUC we are removing this function in the next commit, so we can skip 
this patch IMO. I suggested this change, if we didn't move the code in 
the core.

Thanks,
Stefano

>
>No functional change intended.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 26 +++++++++++++-------------
> 1 file changed, 13 insertions(+), 13 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 49c6617b467195ba385cc3db86caa4321b422d7a..4425802c5d718f65aaea425ea35886ad64e2fe6e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1194,23 +1194,23 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
>
> static void virtio_transport_wait_close(struct sock *sk, long timeout)
> {
>-	if (timeout) {
>-		DEFINE_WAIT_FUNC(wait, woken_wake_function);
>-		ssize_t (*unsent)(struct vsock_sock *vsk);
>-		struct vsock_sock *vsk = vsock_sk(sk);
>+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+	ssize_t (*unsent)(struct vsock_sock *vsk);
>+	struct vsock_sock *vsk = vsock_sk(sk);
>
>-		unsent = vsk->transport->unsent_bytes;
>+	if (!timeout)
>+		return;
>
>-		add_wait_queue(sk_sleep(sk), &wait);
>+	unsent = vsk->transport->unsent_bytes;
>
>-		do {
>-			if (sk_wait_event(sk, &timeout, unsent(vsk) == 0,
>-					  &wait))
>-				break;
>-		} while (!signal_pending(current) && timeout);
>+	add_wait_queue(sk_sleep(sk), &wait);
>
>-		remove_wait_queue(sk_sleep(sk), &wait);
>-	}
>+	do {
>+		if (sk_wait_event(sk, &timeout, unsent(vsk) == 0, &wait))
>+			break;
>+	} while (!signal_pending(current) && timeout);
>+
>+	remove_wait_queue(sk_sleep(sk), &wait);
> }
>
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
>
>-- 
>2.49.0
>

