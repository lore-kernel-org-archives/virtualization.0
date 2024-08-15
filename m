Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44618D65F
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701825; cv=none; b=l2WqnYd4ibgLTlzR35Ssc5x62NUdkQF2HdJwcHmP4bIn4xagSL0Gt156nkoXs+i9FGsyUcJbVvNE7fyZceaJwO9exVrX4KPRcPLA8rK3M/62AFFxehSdOXhgn2/xWTknokAnvT0vzPwoM8X2e1+aq303wSHz8Cb6XaWt4WMJplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701825; c=relaxed/simple;
	bh=GPmCQM5NNtOtJ+QKbX7iV3ZV7O48A4U90cWlAd0yZ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIzgYIsOz9gO6Ay9KeXdXyWIMLceB84In3om+gR3ZfNjCWX5PRH8WffKcPdoF8D+cFbR3DFMc1yBSHuG2wNfGyx9auS0J0BE+xXtuqARrF9TPFNEoqlXS0k/zG/73lkHjTvxlIVHfXF0ZGn1VmxTIoD7l+eeF4cx+BB/sC2AoLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MnCSm4BA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnCSm4BA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723701820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP+XUpr7erg5BEw8ptLFA9XGqDGjBrYwvameBbwmgBo=;
	b=MnCSm4BAZyKohFKFYOryGD9sQH16dXS0Op3xvymDMesu3JMhYYqt8P03HjWYkSzGvIBllW
	jW+Np6IdvDXe2j758DBNNM3DAM32c47mVX7wVWbzegkt6AeWVBPTZuYf1yefE045PCosQo
	5KqifEWw4StywtfG0FKcJuWtsCN7ggQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-cayPxFEWPbWogjlG74Oajg-1; Thu, 15 Aug 2024 02:03:39 -0400
X-MC-Unique: cayPxFEWPbWogjlG74Oajg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3acc5b48bso525378a91.0
        for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 23:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723701818; x=1724306618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nP+XUpr7erg5BEw8ptLFA9XGqDGjBrYwvameBbwmgBo=;
        b=NR5rEuxlrX19y4Cj5LobUBr/D1DLAF6PEQQZEgj49IH4bz+VqM5VOAMOMFo1yjs/gZ
         zpf+I1EojAYJ5sDoJD3BXxt5vsbc/uiHeQ7iXaYa3jYefHQYLxOitM4hEJame6WOKqkF
         OffpB7PFJpcIlPp2Ajzqu3yZcRvSY88Lr0X/J/VzXU9POvf5oR+Op7u8MiRa1nMw1UaI
         GGh/i2fTbMQCh32ITBX+37h6jpgkO8nUAfk3gR2EIXKu6kU05b0G72lMVdsW8cd0wCRk
         DOsbc0X1oCyieOMlfCh1EUtdiP/an0ihlmJaN13Y+HizqVd/7wYNQP0/gkPljNRmMVcY
         MkLw==
X-Forwarded-Encrypted: i=1; AJvYcCWN6eaieW3xztRFejUTYiv1jeT5szuDlzWgLMFvSYbp1gcGZNtbGwFF5ah9asV9CYdG3d/jeiSu2osPMBcMADAHlf5RB4XPv8hzy9sZ0c0=
X-Gm-Message-State: AOJu0Yyraxx8wTK30oYev2xfnk9U0BkahQCnWOx+Rdg+XN1WhVXVX6mH
	DN0XgmZ0f3stEWl2NHmJuOtatc6u8qjx+pQPQLy3w4ORhPc5z5Xxk8Jj3YxDpLVi2ECZquc8d8+
	RhDg//a67U1X2MqVJLxRXKUMACkj4ka7jF5L0xCs5nJkygDQLwwAZr2YfBeO7f7vPYMghfQhwW5
	g967VCYg92RrNOeCv83Eam4E2oq+4IDXmu0N0lmgA=
X-Received: by 2002:a17:90b:fc2:b0:2cb:58e1:abc8 with SMTP id 98e67ed59e1d1-2d3c3a42365mr2924994a91.21.1723701817951;
        Wed, 14 Aug 2024 23:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJMYffQL25EyjWVnQ4NUjaSE8aOAOz8i+jSgGBXnLjj5FeFCVVf+JMIo8QSYAppGmiytb6+co8QXxky2rc1Tc=
X-Received: by 2002:a17:90b:fc2:b0:2cb:58e1:abc8 with SMTP id
 98e67ed59e1d1-2d3c3a42365mr2924951a91.21.1723701817365; Wed, 14 Aug 2024
 23:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240814122500.1710279-1-jiri@resnulli.us> <20240814082835-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240814082835-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 15 Aug 2024 14:03:26 +0800
Message-ID: <CACGkMEs3X8KH3zHLkT74COqHa6N9noKT8TaUj-KRLkaok4Pv_w@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: move netdev_tx_reset_queue() call before
 RX napi enable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, m.szyprowski@samsung.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Aug 14, 2024 at 02:25:00PM +0200, Jiri Pirko wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > During suspend/resume the following BUG was hit:
> > ------------[ cut here ]------------
> > kernel BUG at lib/dynamic_queue_limits.c:99!
> > Internal error: Oops - BUG: 0 [#1] SMP ARM
> > Modules linked in: bluetooth ecdh_generic ecc libaes
> > CPU: 1 PID: 1282 Comm: rtcwake Not tainted
> > 6.10.0-rc3-00732-gc8bd1f7f3e61 #15240
> > Hardware name: Generic DT based system
> > PC is at dql_completed+0x270/0x2cc
> > LR is at __free_old_xmit+0x120/0x198
> > pc : [<c07ffa54>]    lr : [<c0c42bf4>]    psr: 80000013
> > ...
> > Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c5387d  Table: 43a4406a  DAC: 00000051
> > ...
> > Process rtcwake (pid: 1282, stack limit =3D 0xfbc21278)
> > Stack: (0xe0805e80 to 0xe0806000)
> > ...
> > Call trace:
> >   dql_completed from __free_old_xmit+0x120/0x198
> >   __free_old_xmit from free_old_xmit+0x44/0xe4
> >   free_old_xmit from virtnet_poll_tx+0x88/0x1b4
> >   virtnet_poll_tx from __napi_poll+0x2c/0x1d4
> >   __napi_poll from net_rx_action+0x140/0x2b4
> >   net_rx_action from handle_softirqs+0x11c/0x350
> >   handle_softirqs from call_with_stack+0x18/0x20
> >   call_with_stack from do_softirq+0x48/0x50
> >   do_softirq from __local_bh_enable_ip+0xa0/0xa4
> >   __local_bh_enable_ip from virtnet_open+0xd4/0x21c
> >   virtnet_open from virtnet_restore+0x94/0x120
> >   virtnet_restore from virtio_device_restore+0x110/0x1f4
> >   virtio_device_restore from dpm_run_callback+0x3c/0x100
> >   dpm_run_callback from device_resume+0x12c/0x2a8
> >   device_resume from dpm_resume+0x12c/0x1e0
> >   dpm_resume from dpm_resume_end+0xc/0x18
> >   dpm_resume_end from suspend_devices_and_enter+0x1f0/0x72c
> >   suspend_devices_and_enter from pm_suspend+0x270/0x2a0
> >   pm_suspend from state_store+0x68/0xc8
> >   state_store from kernfs_fop_write_iter+0x10c/0x1cc
> >   kernfs_fop_write_iter from vfs_write+0x2b0/0x3dc
> >   vfs_write from ksys_write+0x5c/0xd4
> >   ksys_write from ret_fast_syscall+0x0/0x54
> > Exception stack(0xe8bf1fa8 to 0xe8bf1ff0)
> > ...
> > ---[ end trace 0000000000000000 ]---
> >
> > After virtnet_napi_enable() is called, the following path is hit:
> >   __napi_poll()
> >     -> virtnet_poll()
> >       -> virtnet_poll_cleantx()
> >         -> netif_tx_wake_queue()
> >
> > That wakes the TX queue and allows skbs to be submitted and accounted b=
y
> > BQL counters.
> >
> > Then netdev_tx_reset_queue() is called that resets BQL counters and
> > eventually leads to the BUG in dql_completed().
> >
> > Move virtnet_napi_tx_enable() what does BQL counters reset before RX
> > napi enable to avoid the issue.
> >
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Closes: https://lore.kernel.org/netdev/e632e378-d019-4de7-8f13-07c572ab=
37a9@samsung.com/
> > Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

