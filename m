Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D9242D67
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571916; cv=none; b=LljWLckWZ6Io+htNsp2ZoheNuJsOSy2iZIyfy17GlBWDRW99GUgNFTbSy/DZ/L2lJhLHtlw1NcATzzAnDMKnGqdZ3aM3+E8UsToUljDho4XPKQu5z18w8iHzR5vakFCVEVKUxpyLRkSo0BGIJ7ILrpOKjDLzrwgBr+opRwNVvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571916; c=relaxed/simple;
	bh=vqxH3yKulHDuIXOdXFJhTNF6UBe2AkXbcrkMGEFMK1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikPiJrDDKWgr+6BHGuItW9ir4j8PvfRwaky8ssu8gAVuFbEbP0G0+mGPuq8qSlrusD6T58J2WLZI/dGGL4+VAE45c1BTjJ9C5YP96G5PjBgjCLjyATPR5eM7D922szGf4dfGonOlLT4DvSBwyMVTO9Tfddjzs7M+jQg665m5hHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a0eq5Fh2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0eq5Fh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752571913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ5V5WC/4Bx29YJhMDl17LYcJ252Y7Q79DzUAKHozIs=;
	b=a0eq5Fh2BlcacGLU1lAqf47VbJvrBcfWX/YzCGX/GiY0BE0Pwj8uNeFXKOqnVUNimI/yKE
	wgd4cD0ryVSu9Pus9Z593T960GlQu8rK9oWaUeMf/IttJ9qtKYsar2lnlgqsJokdy/Am4x
	zRNsDdxEDBSUAGyy2N8G8bXu1XMTmPU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Ii8ARNgDMrS-wvEilzFkVg-1; Tue, 15 Jul 2025 05:31:51 -0400
X-MC-Unique: Ii8ARNgDMrS-wvEilzFkVg-1
X-Mimecast-MFC-AGG-ID: Ii8ARNgDMrS-wvEilzFkVg_1752571911
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so9436343a91.2
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 02:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571910; x=1753176710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ5V5WC/4Bx29YJhMDl17LYcJ252Y7Q79DzUAKHozIs=;
        b=A2eQVY7nM6Gy8yJvxgymmAHxywmcCM891Rqfj5S0UiKbybdE+4CsMEj6l0XufrOPvJ
         3nMXMEGj0RAlW1ZIFJd9kW+0VR6bNqF08+05xqzBwuhyZ3K8qZMQf+DNT0oZtHmYqs3D
         QxGudZUnLrNqryzL+7/vOnCn4j2c4Zxaza/d8PPQYt+ImbLzP3wQSf7trDKfoCQ2XFw5
         ZgiRBCzO2b+7yBB7FJa7EfbDkAncYZrqLKN7Hz94fvgE04pH8H/IPyR69Klxd1FsxwUH
         i+J+52oTpDUf9u+pj9p2W1eOnDKQz/nINlVwFm7noVkBCwt7yH7DQASKJT4SRh453KWn
         3S4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXolD3D75FN3NaRTdq2gSEla7xvFbz72n0QQ7A+EgWKeBIXVYNjO8un1RXXHRrjI2D0sI3J0Mn4OBmvQST7ZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO8mRgDlG4qWyXZ761IERQYCX2DCoekA95z2ImhLGpEWqQu40c
	75TkJ3S7oBwMDUFeza8eGFhgHQ9EdRpb0BN/HGbH1nqAqndKBbNRzSzJfQFV8s4XlXLwEzbYitd
	fN20n90IIvtTELKLftAfaEHyp8C833wJjQeEvHIuhIEbSEns4TqC9K5gp4EuUK2BMwE9D7+Xsa/
	r+sWDOEIHNWP9YA3+ESHftnKDiK9y9S98pafKt6G/4QHY=
X-Gm-Gg: ASbGncsQjawimMPXH9+2YXzjOPC+MZT3gteinhMJewJRKF5oFCaHQXj+pYZZJ9NtZyQ
	DJBrRLOBwlQ/y9OLQjOLhoBMUjc5rhAgs7EwfspqQjnNOk+Wxgp7S3bwOJlOE6YQfLaZKp7raKe
	lAbJ2PZOOjbi1g69+irpQ=
X-Received: by 2002:a17:90b:54cb:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-31c4ca84064mr27207117a91.9.1752571910366;
        Tue, 15 Jul 2025 02:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsOC3svVToYzTuTnG2XpjSE05h8Xg9Xk8FAqUV2aDCpHsZDpPq7S42ao1sb0Xk4ytXWsaqgjDKokbucfr5tsI=
X-Received: by 2002:a17:90b:54cb:b0:313:1e60:584e with SMTP id
 98e67ed59e1d1-31c4ca84064mr27207074a91.9.1752571909800; Tue, 15 Jul 2025
 02:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250702103722.576219-1-zuozhijie@bytedance.com>
In-Reply-To: <20250702103722.576219-1-zuozhijie@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Jul 2025 17:31:38 +0800
X-Gm-Features: Ac12FXzqS2yugIsiVYHHsa2PvrFnPXaaMDU-eOr_I18y87iRV_Pt5Q-EGyJeHKI
Message-ID: <CACGkMEvjXBZ-Q77-8YRyd_EV0t9xMT8R8-FT5TKJBnqAOed=pQ@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock during probing
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KxLQOnKJPiAKi3HMepmazU8yVTIvbyiqzIWpXmL5-bM_1752571911
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:37=E2=80=AFPM Zigit Zo <zuozhijie@bytedance.com> w=
rote:
>
> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
> the virtio-net driver is still probing with rtnl_lock() hold, this will
> cause a recursive mutex in netdev_notify_peers().
>
> Fix it by temporarily save the announce status while probing, and then in
> virtnet_open(), if it sees a delayed announce work is there, it starts to
> schedule the virtnet_config_changed_work().
>
> Another possible solution is to directly check whether rtnl_is_locked()
> and call __netdev_notify_peers(), but in that way means we need to relies
> on netdev_queue to schedule the arp packets after ndo_open(), which we
> thought is not very intuitive.
>
> We've observed a softlockup with Ubuntu 24.04, and can be reproduced with
> QEMU sending the announce_self rapidly while booting.
>
> [  494.167473] INFO: task swapper/0:1 blocked for more than 368 seconds.
> [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
> [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid:1 =
    ppid:0      flags:0x00004000
> [  494.168260] Call Trace:
> [  494.168329]  <TASK>
> [  494.168389]  __schedule+0x27c/0x6b0
> [  494.168495]  schedule+0x33/0x110
> [  494.168585]  schedule_preempt_disabled+0x15/0x30
> [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
> [  494.168835]  __mutex_lock_slowpath+0x13/0x20
> [  494.168949]  mutex_lock+0x3c/0x50
> [  494.169039]  rtnl_lock+0x15/0x20
> [  494.169128]  netdev_notify_peers+0x12/0x30
> [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
> [  494.169377]  virtnet_probe+0xa48/0xe00
> [  494.169484]  ? vp_get+0x4d/0x100
> [  494.169574]  virtio_dev_probe+0x1e9/0x310
> [  494.169682]  really_probe+0x1c7/0x410
> [  494.169783]  __driver_probe_device+0x8c/0x180
> [  494.169901]  driver_probe_device+0x24/0xd0
> [  494.170011]  __driver_attach+0x10b/0x210
> [  494.170117]  ? __pfx___driver_attach+0x10/0x10
> [  494.170237]  bus_for_each_dev+0x8d/0xf0
> [  494.170341]  driver_attach+0x1e/0x30
> [  494.170440]  bus_add_driver+0x14e/0x290
> [  494.170548]  driver_register+0x5e/0x130
> [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
> [  494.170788]  register_virtio_driver+0x20/0x40
> [  494.170905]  virtio_net_driver_init+0x97/0xb0
> [  494.171022]  do_one_initcall+0x5e/0x340
> [  494.171128]  do_initcalls+0x107/0x230
> [  494.171228]  ? __pfx_kernel_init+0x10/0x10
> [  494.171340]  kernel_init_freeable+0x134/0x210
> [  494.171462]  kernel_init+0x1b/0x200
> [  494.171560]  ret_from_fork+0x47/0x70
> [  494.171659]  ? __pfx_kernel_init+0x10/0x10
> [  494.171769]  ret_from_fork_asm+0x1b/0x30
> [  494.171875]  </TASK>
>
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state =
on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> ---
> v1 -> v2:
> - Check vi->status in virtnet_open().
> v1:
> - https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@byteda=
nce.com/
> ---
>  drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..859add98909b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3151,6 +3151,10 @@ static int virtnet_open(struct net_device *dev)
>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>                 if (vi->status & VIRTIO_NET_S_LINK_UP)
>                         netif_carrier_on(vi->dev);
> +               if (vi->status & VIRTIO_NET_S_ANNOUNCE) {
> +                       vi->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
> +                       schedule_work(&vi->config_work);
> +               }
>                 virtio_config_driver_enable(vi->vdev);

Instead of doing tricks like this.

I wonder if the fix is as simple as calling
virtio_config_driver_disable() before init_vqs()?

Thanks

