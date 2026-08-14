Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD6335E930
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698245; cv=none; b=ruAVvPqiMawWYUn2DGvGD8Y6QGhvhj6wgUgFhkLI55YoaStophNAMJ4WXLd3JXYS179ODO6/QSWlL2KWh6hYzwWC7NrLBFNDZNoGKYY5uqw5eSk0gkpqlLCSF66hRrsu7vXuUXLwPi7qvLnLSG4fx96wqCNuBYByIJ1VwmY5FHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698245; c=relaxed/simple;
	bh=BJOf/NYSz5FG6Adem09lwkZwKWp2jY+TOiFmVjNC3eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=asLxaTzbXnscApJ4seFIz+7njOhaWtxf5VumEBTodGAYNrJX3nicvtpfWruOabaMLN6x3s+bJ5rDHQPMy6gJsKQIrvfE2uupzpVBloaU50s0UBIF2VD3cu32UK8zZFuKq/sg8LqnX+6ooNFxKImQGverzXv7XYAoC+TNyusRiw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xx/n3Bmp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xx/n3Bmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786698242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2zwZEotU4Mzq+YNLMdkEnsd0V5EVOvlW1UTGUzYHRYk=;
	b=Xx/n3BmpbSn7GiifkMVAcEfFk+prkbP/3cieyqNUwuHbTk2wOfgxltn81SsTEYC5LRUW2H
	VGl2IoH4Nd0+y6gwos7ApgHXHPpMSwKng6yybFdNA2kyxplCY34iZciGVID+X3ES5Y8wH9
	enprjmnR0AlZIOVdFxFQxtNRF/MXD+c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-u2j1vv_hMrWZ6HuNyOkuSw-1; Fri, 14 Aug 2026 05:04:01 -0400
X-MC-Unique: u2j1vv_hMrWZ6HuNyOkuSw-1
X-Mimecast-MFC-AGG-ID: u2j1vv_hMrWZ6HuNyOkuSw_1786698240
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso444031f8f.2
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 02:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698240; x=1787303040;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zwZEotU4Mzq+YNLMdkEnsd0V5EVOvlW1UTGUzYHRYk=;
        b=GaOK8w1DdI29OTj+fYV9ejTKCWPP8c7rDXekvYZ0JcY7q9agPsa/gtcvU696MLUP8g
         PIr4KsEdZvdMyGkttLNfeVT70i2Fo7d/Pb/PF1AgeO9RC08plzSeiwVedSqoqU4hMaPx
         j2fJ67l9J+VEQnMEcfbxUoclyIvUNSX7KoskhjI9plrIS1DM1LiJBUYwX+ZUMMJMnfD6
         E8lM+TJ8UhTy9+wf0YEbnrgVhp99L4U8eodU+Jp6sExsNYRDAH2odzL+4GcaLeyVt7Ly
         QYsJAzLzk/DqZMtrDKSqWhoaRxQOQcOrQ+Q/LAUompTPj8hMX7Rua/sEZ2wDeWtEyIrj
         DtkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrq44TNiNkFmSeCf51oQ8G00WRSLMHlwV0Dm1UnxY9pkWHKYEpLhf7s7H8Wjeum2yis5XYlSy+jdAvR5pJttQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YybK/1/UoXGPdnI/GLq7Rf1hwGG0BB7AKnNGFxrG8ZuavbYg5tp
	MK0YGlrmcNF/ME5sUXRsG75pnDew7NjYOGhMEzhrW23kNPz9wM9fG+KJVBPuokvp8KDJUHk4Nhg
	PNn3SfnR5EfugtB09WDqa1p/aFMdF553HO337ar4/VC0jc2otz/HHTqi2BLRIN/ytoixY
X-Gm-Gg: AR+sD11A6bTOxc4h1w3gyNphv02cDEjt/SlVsy7O+of8UmhasyZmst9IDlxksIL82Di
	XrPB6TjxsVRSiIwYnYGzSXooYJHXD6zdH7DtO5DcYjma7ith4Yxd6vjOv1AG+u809da5GE5Eiyo
	jS8hs40V7BHckWoWLo4/nO7QmMUn9mG1vmS7xubycz80N50egCZbLEA1xZDUpLFZjDI1x1Wekfp
	qOw2NUgLT+bhuJw1cG+JKePrixtCt5PD7Vwzm2EN3ftVRP3WB3pohusscLktrk1QLDNNSKSJhp7
	GcWdz/tgKFMcWEJ05LXG7JGQPkEB+Qyzd0qpbdhFDGBa+l0LhFET9+4FYHSecU2C8vWQUi6IbWX
	Z0c9xTAsniZfGqCUTMKZbnnmjpt/hnwsFUZkXI3V/DmMcHl6MJ21U
X-Received: by 2002:a05:600c:4688:b0:499:8807:345f with SMTP id 5b1f17b1804b1-49988073627mr38667075e9.13.1786698240070;
        Fri, 14 Aug 2026 02:04:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4688:b0:499:8807:345f with SMTP id 5b1f17b1804b1-49988073627mr38665965e9.13.1786698239643;
        Fri, 14 Aug 2026 02:03:59 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b24746sm58416435e9.12.2026.08.14.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:03:58 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:03:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] vsock: don't check the listener's sk_err in
 vsock_accept()
Message-ID: <an7ZiFM2nmb6kn2_@sgarzare-redhat>
References: <20260813173024.2362935-1-phind.uet@gmail.com>
 <20260813173024.2362935-2-phind.uet@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260813173024.2362935-2-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: arOTzVcn9MjkARWDUCRoPkXb8N7ZO1MEC1_25L1UhfQ_1786698240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Aug 14, 2026 at 01:30:18AM +0800, Nguyen Dinh Phi wrote:
>Syzbot reported an issue which can be reproduced with these steps:
>	r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>	bind(r0, {VMADDR_CID_ANY, PORT})
>	connect(r0, {VMADDR_CID_LOCAL, PORT}) -> -1, EPROTO (self-connect)
>	listen(r0, backlog)                   -> 0
>	r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>	connect(r1, {VMADDR_CID_LOCAL, PORT}) -> 0
>	accept(r0)                            -> -1, EPROTO (stale sk_err)
>
>Basically, it creates a socket (r0) and triggers a self-connect after
>binding it. This self-connect fails with EPROTO because it loops back
>to r0 while the socket is still in the TCP_SYN_SENT state, causing it
>to be incorrectly dispatched to the connecting-client path. The
>unexpected packet type encountered there sets sk_err to EPROTO.
>
>After that, it invokes a listen() call on the same socket. This
>listen() call succeeds because the kernel's listening path never
>inspects or clears sk_err. Then, a new socket (r1) is created as a
>normal client and connects to r0. However, vsock_accept() rejects this
>incoming connection because the listener's sk_err still holds the
>EPROTO error from the earlier failed self-connect.
>
>This rejection causes the child socket created for r1's connection to
>never be freed on virtio or hyperv transports; only the VMCI transport
>implements pending_work to revisit and clean up a rejected socket.
>
>For a non-blocking connect(), vsock_connect() may return -EINPROGRESS
>immediately, and vsock_connect_timeout() can later set sk->sk_err
>asynchronously.
>
>Since no vsock transport ever sets sk_err on a socket while it is in
>TCP_LISTEN state, checking it in vsock_accept() serves no purpose and
>only carries forward errors left behind by earlier, unrelated
>connection attempts on the same socket. Remove the checks so accept()
>no longer rejects valid incoming connections because of a stale
>error, which also avoids the resource leak described above.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>Suggested-by: Michal Luczaj <mhal@rbox.co>
>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd046799..3cd5c3561be3 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1893,7 +1893,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>
> 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>-	       listener->sk_err == 0 && timeout != 0) {
>+		timeout != 0) {
                 ^
nit: I think the alignment is wrong, maybe if you need to respin you can 
fix it

Anyway, this LGTM

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

