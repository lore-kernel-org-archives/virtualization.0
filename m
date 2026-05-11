Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405327B4F7
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515017; cv=none; b=TAl63qTURADtZWOJ3yDplIH7O5HiDKczKJSTRHN1BERuPlBeezA5wzhvxbOWDLobNOkQ6jyBVs+E3nn6TRcgXMoJQReprMSOJ6DXxHddmm0gUo870Jfv3lK1CVO8UBOwQwOwTu5MIZVkixhrlm85M0rLNVi2WD2EovuG2Z6khs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515017; c=relaxed/simple;
	bh=t7ET0rqXtYU0UPQXZE9zBjWgK/qB8ssf7YiQJM1pUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WZNmn711F7qedW7cDVrJ0M1A0JLVsOgKbEhq+P0iF6W6FH6dDOMZyr5V7NwZR3FoethKrtFlN05U9IUE2L+vERUH2Adx09dJfChFdzarz7/Df8VuN5LADxAKrEuiIFYg/Uy/t3xC7c7wBHCedf5WuU55ng7d0n45rsxNKyxwwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNnkr7R4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNnkr7R4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778515015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mqh8HANASsg1dE58rfi+aWvc9+OWR8qHCZSV5rhehOc=;
	b=ZNnkr7R4Xv7+hmqGjPhucsvV2xvhDukqZZNPEZ5CZhL/ZPICFTO5btrp9ZOAxjPGzPPo56
	GcoVosrzTZIU/4+H6hr0c6hfaoEg82MQNPaHj0dvzP0FmDcnUet9KVQqr5ckaLQIPXTIiL
	IHjMHfihSF/jNfsWnlxMtDJ5NBoecxE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-AjHidnt6MTq5aDeit3VqZw-1; Mon, 11 May 2026 11:56:53 -0400
X-MC-Unique: AjHidnt6MTq5aDeit3VqZw-1
X-Mimecast-MFC-AGG-ID: AjHidnt6MTq5aDeit3VqZw_1778515013
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a548b585cso29893705e9.2
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515013; x=1779119813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mqh8HANASsg1dE58rfi+aWvc9+OWR8qHCZSV5rhehOc=;
        b=buOxe/v2Gn2tuNOHEf7GeHcQMkLtWvpVCf0G3fX9/eAAbxVYfSpmaC+AJz2cnBixv/
         rowrV6qAXW/29MlExGKb/kZt2JAeX0zHne42h8Q0eM6Vl+Mob4E0Ic8UIpoO+n+LrFMb
         4TNrfktU8I9Y9AhqYZLvFfXoaDdc6SLeyJCKiKy/J5AqwKiupek58b03FpG9x1MNZ3n+
         BOsuELt2v+PxY6U8ZmRuDPkdaXCyW2gOS5qnH7Hwwg0sAKh6G2YYO5Z9YKYOYXuYYGI8
         Jj9HETxPjgQa2NuoZZ/Yd7T9z9lFGRAL6U+djNS6MdBDYWrQjeYQEfwWnS//RHTtIHep
         aSlg==
X-Forwarded-Encrypted: i=1; AFNElJ/5VXqS9sPPhScmZDo7KF5sZALuqVRVV123mJv1/TO114wHH2c23/iD1b+Nc3AmL9Y3qOomUMlLm3uRsatYIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO3r3W5ZwYGFEZ9djapqcVaQhJ+BN4N3bhgM7iWOVR1PaSAY32
	YuXMKo8MJRsys/U8XPyGPucqrbv3P7yZiU5yG1++KMUwU7fkWEkfc9QjUyZzl8vv26HucuLD+7L
	MHubCfYl5fHYyHWzw+tdZsrtKFC3qnCUxBdo5egnzM79LaWNGoko90BMkyurCfAV8qqBN
X-Gm-Gg: Acq92OGpj878Qo6qwiTsp29nr1AuqzRBePG7vtHDPRERQygQr+YHpy1gPE0mM6BUJrc
	WUpoimvHgyQtwttOOUPeff478anhqDHi+KldUc/xnw1ZU83tTKTc+lDTQ9WQDu6YfkkGTzQ6stA
	Aishp/2SVn9UHBZz2GKgMn6JKoR8qLyuZDtT0b862Fp2ZMBeRJvHuhHJ1yx1XUvcJ/IGAR+E/Af
	kBb9j21RYlUHJ9AbSy+eM9Q5zFNyvUJTWmxv2r0ztM8wRIbhuEvh2FSMeus5ob7vLmo56R3RGza
	wYhqMzduK5qcrW50wwh9cwABZRPjPtACWWNuq3VAr3nWbIvVITaX6FgfLuIUmXFMCW8eu1jD+ro
	KzDGEAN5y2Yr0SZBge8JhBWAWWhwd9f3SN+GqLP2hZo1M4XhacIKNzOq8D6LCz3+g6mWztEnP/y
	eWCXxAckqa
X-Received: by 2002:a05:600c:47d3:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48e51e0bb62mr256258145e9.3.1778515012659;
        Mon, 11 May 2026 08:56:52 -0700 (PDT)
X-Received: by 2002:a05:600c:47d3:b0:48d:c0a:3813 with SMTP id 5b1f17b1804b1-48e51e0bb62mr256257845e9.3.1778515012100;
        Mon, 11 May 2026 08:56:52 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6daf911asm100865105e9.5.2026.05.11.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:56:51 -0700 (PDT)
Date: Mon, 11 May 2026 17:56:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agH3WvJtAsQ_5zx4@sgarzare-redhat>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qH-RCxg4m_-7emvmWa7LGmoYLvGiPN9amH_nNcrseRQ_1778515013
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>When the host initiates an AF_VSOCK connect() to a guest that has not
>yet loaded the virtio-vsock transport (i.e. still booting), the caller
>blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
>vhost_transport_do_send_pkt() silently exits when
>vhost_vq_get_backend(vq) returns NULL.

Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?

>
>If the guest doesn't start listening within this timeout, connect()
>returns ETIMEDOUT.
>
>This delay is usually pointless and it doesn't well align with our
>behavior at other initialization stages: for example, if a connection is
>attempted when the guest driver is already loaded, but when nothing is
>listening yet, it returns ECONNRESET immediately without any wait.
>
>Fix this by checking the RX virtqueue backend in
>vhost_transport_send_pkt() before queuing. If the backend is NULL,
>return -ECONNREFUSED immediately.
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 1d8ec6bed53e..a3f218292c3a 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		return -ENODEV;
> 	}
>
>+	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
>+	 * private_data without vq->mutex is deliberate: even if the backend becomes
>+	 * NULL right after that check, do_send_pkt() checks it under the mutex.
>+	 */
>+	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data))) 

Why not using vhost_vq_get_backend() ?

Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?

>{
>+		rcu_read_unlock();
>+		kfree_skb(skb);
>+		return -ECONNREFUSED;

This is a generic send_pkt, is it okay to return ECONNREFUSED in any 
case?

Thanks,
Stefano

>+	}
>+
> 	if (virtio_vsock_skb_reply(skb))
> 		atomic_inc(&vsock->queued_replies);
>
>
>base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
>-- 
>2.53.0
>

