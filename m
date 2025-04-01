Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CC202C38
	for <virtualization@lists.linux.dev>; Tue,  1 Apr 2025 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743510465; cv=none; b=rFgyi9tJ2IuOXkhmfwPooNt33JXG7jNL6JMveYmWQg6Akpss6+gJoU7fhrx2jnrVyWUgowvyQwhO+WYHj9X3eLR+P+WE6UJRvXeNHdFlAJz7gGM6YVo1gHIKjIurC1rSKYSNFbhgc0jNXZlVLmOfFWA4kulbcImEa+h1V3l/eps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743510465; c=relaxed/simple;
	bh=BClutkQpqyZvckcjwzWJ1OK2iF2XXQt7os9vtNK7sKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c30MuhNjummuPVPRAkDUp+eri5Z0lq05g1lUpJLixkX7T+6WHOICIP1goJuDv8Smv0klXifk3o8l8UrwGRvimtDJ9lqZcVNSlZDOKXs/olz9fep7sGr1zGNYeUlQ7k3U4DFXcxn6Bbt63KTibjRZXO8swX1av/YejausHiuMSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMZCx7oX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMZCx7oX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743510462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNoSdGtyM+b9K0jvjiDPZCfEnjTJKg0RDqC1m3p719E=;
	b=RMZCx7oXPL6mzK1uawX4LFnJAxZzjpl2wJqxmUi5RBHgwvnON+kKpHsnf3cx9+2RJXpZzt
	Ubhca//dd+xQ6jf6NfU9AB/xNvCu7doNEJNrZrc6SREu9ommwYTMIIHldUy6iGX15fJsrv
	H5DRH4KO3Dp59ssOHhVkXoG9p4o+qP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-OzohHjFZN0OKF729X3oBLw-1; Tue, 01 Apr 2025 08:27:41 -0400
X-MC-Unique: OzohHjFZN0OKF729X3oBLw-1
X-Mimecast-MFC-AGG-ID: OzohHjFZN0OKF729X3oBLw_1743510460
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391459c0395so2236711f8f.2
        for <virtualization@lists.linux.dev>; Tue, 01 Apr 2025 05:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743510460; x=1744115260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNoSdGtyM+b9K0jvjiDPZCfEnjTJKg0RDqC1m3p719E=;
        b=LYjKrTAwmk/wS4QohE7cZCGqtGDTgNVQs1TNi1OZSzMevjVWCP0QZcXkgiUKbbRb6S
         RRlQ+5mQwOiosojUM2tZFJLFXGupAWo+TrA40gS5uOEt68qYmzHXeZsWXEferDG4e4dG
         fDVUyD9lZoqhTXXwNk4Mbv8Nc7TC95Fhx2/YpCyneCY8RvK05IMp687OkpNuV7KkFUx+
         +8k5Ua5j0N5WMu2sCqB4ZpT6m7LR1tX+puKqwy9IXqDxMxEdbCM/CS6fL9EKq7dk6EDG
         p3yK6pkhM28+VAPrBL5Hc21fYj6Xi67AzURSxdcjjSI4W0R7bHdsJirAfizCQaWF3dM2
         hVsg==
X-Forwarded-Encrypted: i=1; AJvYcCXqk/D+qpeFLWUKa8VzGSsQyJ3Vdgu5OfJ0iRv3KZMHApOHrUYPFD+4k8g8gYa/C8fsOcdDB86uYvy5gfAP8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6MDlOXAYYNwfLF8E2OdPZ7ncA+dzGclNPxd63hEUP6lb8sfXj
	dL1HF0Jhl/z5MBiRUCJT/9vcUmDYRh2WAccwn+NhU2QzeyMvxrzW5k9ALBxjrLZuPiVhgy+mjbZ
	X8NmK3kM5Ow4GBwU+YnF6DovTYhv1YuDzxOwEy+QxNezfZcyWFjrMnSi8w1N9BeoU
X-Gm-Gg: ASbGncsTrW7UgE/dGAWwXEVi/Dn39KmGeiSnYUDJo9Cqwcy8Gm8+zuGnCeT5OR6OmPc
	T0wIZIPaw1R41D6JvAd/t9Ql9T8z5bO8DD4UprA0g1xTkO2R61kZDkAq5EB1UB3X/dAL8PxUyp3
	QZDScC0grthFw3jxrWlj2Xg3iCqMXfpfdUQibXhIhPVq6j2VA2scw6qdN3ggZ1JyL2+Mt8PAIy4
	AfYf3G7z53H9SxSTUQhZeODqAwAdKw0iPa5I67qrAOgFP4Nj3+cbsaaoLu2YxYLzIlTOcvwDKIL
	fM6lRVnepY6r+JIzQQ==
X-Received: by 2002:a05:6000:18ad:b0:391:2fe3:24ec with SMTP id ffacd0b85a97d-39c120daf7cmr10194179f8f.14.1743510460014;
        Tue, 01 Apr 2025 05:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNDLZxIYTRL0m7LzO7a9ysoMH6UHZb/pAKwZvCOmabgUAWbDiDNTPAJI1m2fpOK9WDP9gyTw==
X-Received: by 2002:a05:6000:18ad:b0:391:2fe3:24ec with SMTP id ffacd0b85a97d-39c120daf7cmr10194159f8f.14.1743510459607;
        Tue, 01 Apr 2025 05:27:39 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a41b4sm13805481f8f.85.2025.04.01.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 05:27:39 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:27:36 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
	Paolo Abeni <pabeni@redhat.com>, George Zhang <georgezhang@vmware.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Andy King <acking@vmware.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Dmitry Torokhov <dtor@vmware.com>, 
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] vsock: avoid timeout during connect() if the socket
 is closing
Message-ID: <jsq3jgl3fks7uv2v37c2o4m7p6u5vhv3ftklccpr2flcyssdwk@75x4zbey7j3i>
References: <20250328141528.420719-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328141528.420719-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DL8ktiu50aIBCshBc9GHx6tVmveX7RfiUM2XjRZ5B58_1743510460
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 28, 2025 at 03:15:28PM +0100, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>When a peer attempts to establish a connection, vsock_connect() contains
>a loop that waits for the state to be TCP_ESTABLISHED. However, the
>other peer can be fast enough to accept the connection and close it
>immediately, thus moving the state to TCP_CLOSING.
>
>When this happens, the peer in the vsock_connect() is properly woken up,
>but since the state is not TCP_ESTABLISHED, it goes back to sleep
>until the timeout expires, returning -ETIMEDOUT.
>
>If the socket state is TCP_CLOSING, waiting for the timeout is pointless.
>vsock_connect() can return immediately without errors or delay since the
>connection actually happened. The socket will be in a closing state,
>but this is not an issue, and subsequent calls will fail as expected.
>
>We discovered this issue while developing a test that accepts and
>immediately closes connections to stress the transport switch between
>two connect() calls, where the first one was interrupted by a signal
>(see Closes link).
>
>Reported-by: Luigi Leonardi <leonardi@redhat.com>
>Closes: https://lore.kernel.org/virtualization/bq6hxrolno2vmtqwcvb5bljfpb7mvwb3kohrvaed6auz5vxrfv@ijmd2f3grobn/
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/af_vsock.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 7e3db87ae433..fc6afbc8d680 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1551,7 +1551,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 	timeout = vsk->connect_timeout;
> 	prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>
>-	while (sk->sk_state != TCP_ESTABLISHED && sk->sk_err == 0) {
>+	/* If the socket is already closing or it is in an error state, there
>+	 * is no point in waiting.
>+	 */
>+	while (sk->sk_state != TCP_ESTABLISHED &&
>+	       sk->sk_state != TCP_CLOSING && sk->sk_err == 0) {
> 		if (flags & O_NONBLOCK) {
> 			/* If we're not going to block, we schedule a timeout
> 			 * function to generate a timeout on the connection
>-- 
>2.49.0
>

Just tested and fixes the issue! Thanks Stefano!

Tested-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

