Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419223C38C
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752634056; cv=none; b=BHUfLFPEA5lxfi2Cv9XJB189QNWtBpfJCRcC3HQLdxWYOvnHXqWRgmnauWynEZI6vs7yrz/oU9A33IlLT8gvNHLGq+iMSJdOo1WY1QfKPyQaYzNMhghHlrvLmVagx3SQdTmd0TLvI1yE6oIl9B25x1WKb4kM+eZixEEnzXOD8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752634056; c=relaxed/simple;
	bh=6tyFQG9ObMR6DQRml1mb/juchm0s9LQKambyFuaWRJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jC9GhQ8ij+wEkO8O0830aCV1tA2fHaKHmzy/iX0J893fpEfkHgZ6w3uSt0dftu7smfoRSvskIPKKhBzbU3TM8G4WaZwmSmQha4B8klooJeJKq5zsR//23dZIMktHiFmMjESGx5bbdjCqFO67q4Ausi1gGTXVASPI9hNmn1G540k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ruo1JzCF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ruo1JzCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752634053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6LOs3KwxAcMoFoSn4gzE7xIJQ2DUSqrbD9QaSjD71I=;
	b=Ruo1JzCFsYgin/C3Ef7SE1zn4IhsRZDjo5uqdmlYk6+QPjh/gJZn/yVcRKPuXhMboAAHAx
	55YmHaz+6ROFaEQnKD9chjyeiQ0SBY3+PRu3s6Dr906bdwmBKWOxR1qXGJ/0UDobUKtTdk
	vWLQrVUtlRF1omLb5tWRjih56/H3+lg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-J5q1xCZeMNavK5SH_PnWsA-1; Tue, 15 Jul 2025 22:47:32 -0400
X-MC-Unique: J5q1xCZeMNavK5SH_PnWsA-1
X-Mimecast-MFC-AGG-ID: J5q1xCZeMNavK5SH_PnWsA_1752634051
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31215090074so10864484a91.0
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 19:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752634051; x=1753238851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6LOs3KwxAcMoFoSn4gzE7xIJQ2DUSqrbD9QaSjD71I=;
        b=T3uD0sSZLWM2f0rKwksj5ohu+o65TFLSQyc3GRPq/eCWYVH6CyoNZ9TuRGlaVB6lF/
         ixzL7LqnkRy//Dzf7zX6uLpCyRNyMgljDECCjVxLRuF0g/EX4tdh6u8aFa0Pxkn2ER8z
         wFJrb8mTKGdiNBjofjTZiFJkElfLjrZgm1+tlGoBpmLedwcdKvsKZJpwlHOYOWSUmjzY
         Yf/VpT2PI+e45kTBgkkzD4vw/x4HwIuBwLbumzSo5dt5gv4CZbBhkVRPs/nL7rD4bsUs
         FDQQwtVykSl0DjN7kJ2gIrSADT18J3KRqk0nU8uunhvbVgHotUEXRZq9Ft8b4g+SR3tF
         KjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVoTCM8mkPbk/R/3Dwrj+T8JN0N072T0CIGpKap6JcuEDTd74ps63iJGpyxM/Z/mH/O3Xvao9uLJ832e/USg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+h8TdMVqiG/e68NiB33oa6iXTrC1/Fk1qGVA4GtYRnpCZKyu8
	OXW4FMswquEgsghOREcsqCbYWbpMxoyvcNGhnqICfA8yCLFdfSDaZAW2jffL5iRvzIQXe3+SATd
	Fk9BhIaM6VFBvMuz1MJjajY7W70LXMPix6Sel4Fk7SuwfHyb+5u9yAjWc0ordfKp6Os4BG7/kl8
	WHt1LJgSG9IonXRi9CX8jTk+qGnWLyakUHmorE4dtm/go=
X-Gm-Gg: ASbGncupo1qOiz3pu2ee9/SK7Le75XsAgm0C2W0K9SbPyAgnk/u14Gq8RvdfAXawg7t
	8J9GaSEOtIzI3HG9iMw9J1+rYNeFW2oXHdDSB5SdRgxYLXCYapSdZLZn0j/rSd4ZtvKh+iUzRtS
	e6BDGMEqfxGluYYxuKx7Q=
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id 98e67ed59e1d1-31c9f43747emr1236227a91.27.1752634050868;
        Tue, 15 Jul 2025 19:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSgy3Q6uvDcv+dh57LPDBZNKo40hU3FNxj6pWecHXujau5F/JesmVv4D6IJmpzKmuDlsaWm5Df3O5TB62z2j0=
X-Received: by 2002:a17:90b:55cb:b0:312:959:dc41 with SMTP id
 98e67ed59e1d1-31c9f43747emr1236201a91.27.1752634050348; Tue, 15 Jul 2025
 19:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250702103722.576219-1-zuozhijie@bytedance.com>
 <CACGkMEvjXBZ-Q77-8YRyd_EV0t9xMT8R8-FT5TKJBnqAOed=pQ@mail.gmail.com> <d5ad1b10-f485-4939-b9de-918b378362b9@bytedance.com>
In-Reply-To: <d5ad1b10-f485-4939-b9de-918b378362b9@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Jul 2025 10:47:19 +0800
X-Gm-Features: Ac12FXwY0618meZM7op6lRwCQ2ykvxYxmr5LBy2rowmHFXBgfqqUkpEG1gaprFg
Message-ID: <CACGkMEvZ5dqjc6+1uwoq98x-78eymGFHXpOJtbViG3U9mOyn8g@mail.gmail.com>
Subject: Re: Re: [PATCH net v2] virtio-net: fix a rtnl_lock() deadlock during probing
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3nu-WY39r9FnrSBs__7NoEYCpVjsVu9pO1Jsudj53b8_1752634051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zigit:

On Tue, Jul 15, 2025 at 7:00=E2=80=AFPM Zigit Zo <zuozhijie@bytedance.com> =
wrote:
>
> On 7/15/25 5:31 PM, Jason Wang wrote:
> > On Wed, Jul 2, 2025 at 6:37=E2=80=AFPM Zigit Zo <zuozhijie@bytedance.co=
m> wrote:
> >>
> >> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request whil=
e
> >> the virtio-net driver is still probing with rtnl_lock() hold, this wil=
l
> >> cause a recursive mutex in netdev_notify_peers().
> >>
> >> Fix it by temporarily save the announce status while probing, and then=
 in
> >> virtnet_open(), if it sees a delayed announce work is there, it starts=
 to
> >> schedule the virtnet_config_changed_work().
> >>
> >> Another possible solution is to directly check whether rtnl_is_locked(=
)
> >> and call __netdev_notify_peers(), but in that way means we need to rel=
ies
> >> on netdev_queue to schedule the arp packets after ndo_open(), which we
> >> thought is not very intuitive.
> >>
> >> We've observed a softlockup with Ubuntu 24.04, and can be reproduced w=
ith
> >> QEMU sending the announce_self rapidly while booting.
> >>
> >> [  494.167473] INFO: task swapper/0:1 blocked for more than 368 second=
s.
> >> [  494.167667]       Not tainted 6.8.0-57-generic #59-Ubuntu
> >> [  494.167810] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disa=
bles this message.
> >> [  494.168015] task:swapper/0       state:D stack:0     pid:1     tgid=
:1     ppid:0      flags:0x00004000
> >> [  494.168260] Call Trace:
> >> [  494.168329]  <TASK>
> >> [  494.168389]  __schedule+0x27c/0x6b0
> >> [  494.168495]  schedule+0x33/0x110
> >> [  494.168585]  schedule_preempt_disabled+0x15/0x30
> >> [  494.168709]  __mutex_lock.constprop.0+0x42f/0x740
> >> [  494.168835]  __mutex_lock_slowpath+0x13/0x20
> >> [  494.168949]  mutex_lock+0x3c/0x50
> >> [  494.169039]  rtnl_lock+0x15/0x20
> >> [  494.169128]  netdev_notify_peers+0x12/0x30
> >> [  494.169240]  virtnet_config_changed_work+0x152/0x1a0
> >> [  494.169377]  virtnet_probe+0xa48/0xe00
> >> [  494.169484]  ? vp_get+0x4d/0x100
> >> [  494.169574]  virtio_dev_probe+0x1e9/0x310
> >> [  494.169682]  really_probe+0x1c7/0x410
> >> [  494.169783]  __driver_probe_device+0x8c/0x180
> >> [  494.169901]  driver_probe_device+0x24/0xd0
> >> [  494.170011]  __driver_attach+0x10b/0x210
> >> [  494.170117]  ? __pfx___driver_attach+0x10/0x10
> >> [  494.170237]  bus_for_each_dev+0x8d/0xf0
> >> [  494.170341]  driver_attach+0x1e/0x30
> >> [  494.170440]  bus_add_driver+0x14e/0x290
> >> [  494.170548]  driver_register+0x5e/0x130
> >> [  494.170651]  ? __pfx_virtio_net_driver_init+0x10/0x10
> >> [  494.170788]  register_virtio_driver+0x20/0x40
> >> [  494.170905]  virtio_net_driver_init+0x97/0xb0
> >> [  494.171022]  do_one_initcall+0x5e/0x340
> >> [  494.171128]  do_initcalls+0x107/0x230
> >> [  494.171228]  ? __pfx_kernel_init+0x10/0x10
> >> [  494.171340]  kernel_init_freeable+0x134/0x210
> >> [  494.171462]  kernel_init+0x1b/0x200
> >> [  494.171560]  ret_from_fork+0x47/0x70
> >> [  494.171659]  ? __pfx_kernel_init+0x10/0x10
> >> [  494.171769]  ret_from_fork_asm+0x1b/0x30
> >> [  494.171875]  </TASK>
> >>
> >> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin sta=
te on up/down")
> >> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>
> >> ---
> >> v1 -> v2:
> >> - Check vi->status in virtnet_open().
> >> v1:
> >> - https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@byt=
edance.com/
> >> ---
> >>  drivers/net/virtio_net.c | 43 ++++++++++++++++++++++++---------------=
-
> >>  1 file changed, 26 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index e53ba600605a..859add98909b 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -3151,6 +3151,10 @@ static int virtnet_open(struct net_device *dev)
> >>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> >>                 if (vi->status & VIRTIO_NET_S_LINK_UP)
> >>                         netif_carrier_on(vi->dev);
> >> +               if (vi->status & VIRTIO_NET_S_ANNOUNCE) {
> >> +                       vi->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
> >> +                       schedule_work(&vi->config_work);
> >> +               }
> >>                 virtio_config_driver_enable(vi->vdev);
> >
> > Instead of doing tricks like this.
> >
> > I wonder if the fix is as simple as calling
> > virtio_config_driver_disable() before init_vqs()?
> >
> > Thanks
> >
>
> That might not work as the device like QEMU will set the VIRTIO_NET_S_ANN=
OUNCE
> regardless of most of the driver status, QEMU only checks whether the dri=
ver has
> finalized it's features with VIRTIO_NET_F_GUEST_ANNOUNCE & VIRTIO_NET_F_C=
TRL_VQ.
>
> We've made a little patch to verify, don't know if it matches your though=
t, but
> it does not seem to work :(
>
>     diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>     index e53ba600605a..f309ce3fe243 100644
>     --- a/drivers/net/virtio_net.c
>     +++ b/drivers/net/virtio_net.c
>     @@ -6903,6 +6903,9 @@ static int virtnet_probe(struct virtio_device *=
vdev)
>                     vi->curr_queue_pairs =3D num_online_cpus();
>             vi->max_queue_pairs =3D max_queue_pairs;
>
>     +       /* Disable config change notification until ndo_open. */
>     +       virtio_config_driver_disable(vi->vdev);
>     +
>             /* Allocate/initialize the rx/tx queues, and invoke find_vqs =
*/
>             err =3D init_vqs(vi);
>             if (err)
>     @@ -6965,9 +6968,6 @@ static int virtnet_probe(struct virtio_device *=
vdev)
>                     goto free_failover;
>             }
>
>     -       /* Disable config change notification until ndo_open. */
>     -       virtio_config_driver_disable(vi->vdev);
>     -
>             virtio_device_ready(vdev);
>
>             if (vi->has_rss || vi->has_rss_hash_report) {
>
> For reproduce details,
>
> 1. Spawn qemu with monitor, like `-monitor unix:qemu.sock,server`
> 2. In another window, run `while true; echo "announce_self"; end | socat =
- unix-connect:qemu.sock > /dev/null`
> 3. The boot up will get hanged when probing the virtio_net
>
> The simplest version we've made is to revert the usage of
> `virtnet_config_changed_work()` back to the `schedule_work()`, but as in =
v1,
> we're still trying to understand the impact, making sure that it won't br=
eak
> other things.
>
> Regards,
>

Thanks for the clarification. Now I see the issue.

It looks like the root cause is to call virtio_config_changed_work()
directly during probe().

Let's switch to use virtio_config_changed() instead so that we can
properly check the config_driver_disabled.

Thanks

