Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B074ECAAD3
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 07:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15BF7403A4;
	Wed, 31 Aug 2022 07:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15BF7403A4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LvDRdt3D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JQmfA5TfAS2A; Wed, 31 Aug 2022 07:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5BC55400AF;
	Wed, 31 Aug 2022 07:03:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BC55400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 111B3C0033;
	Wed, 31 Aug 2022 07:03:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77D8FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 07:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5965340354
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 07:03:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5965340354
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J0YT1odeqOuA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 07:03:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B932400AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B932400AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 07:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661929403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ycHVJomc+adSIDwiGKF9BYvAAlFomFD/xT89B+Pt//Y=;
 b=LvDRdt3DYOR9AP4cvnNRB2xjCLdwpJtKlkSt15NC/vAybe6AWRhv3vHgS/jf1IjT7kSzv8
 LRrq7v/YEYT1otlFbXC1DeoN3+z8g8rqL+6PUi6WmyPrsYWku5ZEzWEQWfejjchhsasS2h
 14BkAU3Vof3yWmgWpFAFtPUZW70JaW8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-428-a4iUPafWMl-ar805oAJQzw-1; Wed, 31 Aug 2022 03:03:21 -0400
X-MC-Unique: a4iUPafWMl-ar805oAJQzw-1
Received: by mail-lj1-f197.google.com with SMTP id
 y15-20020a2e7d0f000000b0025ec5be5c22so3697737ljc.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 00:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=ycHVJomc+adSIDwiGKF9BYvAAlFomFD/xT89B+Pt//Y=;
 b=QRFybha8bYQrimPbJSklOt+dJRXNAzqJE4b/P/vq1e4ziEIz4FzwM1xDtfqOQo7HW3
 GIw0lIdRwnBNNGYhIKQNC27JJb5oCoK1l1MDbmzJ6N0K6IlWt7IMYxw65aDgYAQ8GJBG
 EnnaMFXj98HbNL7J7pr1kWzQO8vARzWYz8RO++xIlmJTND756BodpwOUvRQhCUZPrjDN
 10CO+A6D6einE2QXQssLqKxXSHedXEqg083QFavKTULr/nIsjsymY2BmUpMzcOJTotBR
 Cg/K1mSbzWJCEhTRWFoQ2A7r5MqasFNjFXeIMiOSxEd1vcmIlMjv2+snMwPxTrndeI0l
 BUyQ==
X-Gm-Message-State: ACgBeo1zhWJqAO5kfgnhciXy48T2mG3b7Wk3BMSQl5Ybt0D9AQP8Sud3
 ZRbKZedOQYFMra+ZurzIE+Y0v8xSUBmwCMhhxo2TEzAuFfMI59WIzJsVJv1Bo0Ao69JALTzdKul
 Rjw+Aw2JYAb8qB0IJhFDd+IjbRZJhSGrxED93XNd4fjWnFwG2TuyioFiwrA==
X-Received: by 2002:a2e:a812:0:b0:261:8f2d:9530 with SMTP id
 l18-20020a2ea812000000b002618f2d9530mr7388596ljq.251.1661929399881; 
 Wed, 31 Aug 2022 00:03:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5G+cornjW5W2zD8V/g95sScqKJ6f2fjvUijctmgl0BG2NfvUSN9RQcsKSjN6Tpl3XYvDRbH/XuC6FBtEZ9SBo=
X-Received: by 2002:a2e:a812:0:b0:261:8f2d:9530 with SMTP id
 l18-20020a2ea812000000b002618f2d9530mr7388585ljq.251.1661929399663; Wed, 31
 Aug 2022 00:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220828154820.458007-1-elic@nvidia.com>
 <20220828160106-mutt-send-email-mst@kernel.org>
 <CACGkMEtubshhZaX4CAjpyiDVSdofW=Mha4HM56FjtK57f1W+Zw@mail.gmail.com>
 <DM8PR12MB54001542CF00A017738C6BC3AB769@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54001542CF00A017738C6BC3AB769@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Aug 2022 15:03:08 +0800
Message-ID: <CACGkMEt9RVL=hSjYMk=iQ7ZvhWvt4Mh8KaKAp0rOhbPXjY=0QQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Abort driver initialization if device fails
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 29, 2022 at 12:52 PM Eli Cohen <elic@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, August 29, 2022 3:33 AM
> > To: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Eli Cohen <elic@nvidia.com>; eperezma <eperezma@redhat.com>; Si-
> > Wei Liu <si-wei.liu@oracle.com>; virtualization <virtualization@lists.linux-
> > foundation.org>
> > Subject: Re: [PATCH] virtio_net: Abort driver initialization if device fails
> >
> > On Mon, Aug 29, 2022 at 4:07 AM Michael S. Tsirkin <mst@redhat.com>
> > wrote:
> > >
> > > On Sun, Aug 28, 2022 at 06:48:20PM +0300, Eli Cohen wrote:
> > > > Read the status bit after virtio_device_ready() to check if device
> > > > initialization was successful. If it was not, abort driver
> > > > initialization to avoid further attempts to access device resources.
> > > >
> > > > Abort is required per virtio spec v1.1
> > > >
> > > > 3.1.1
> > > > ...
> > > > If any of these steps go irrecoverably wrong, the driver SHOULD set the
> > > > FAILED status bit to indicate that it has given up on the device (it can
> > > > reset the device later to restart if desired). The driver MUST NOT
> > > > continue initialization in that case.
> > >
> > > I don't see a requirement to read the status bit though
> > > which is what the patch does.
> > >
> > > > This fixes an issue that was discovered when mlx5_vdpa initialization
> > > > failed due to firmware error
> > >
> > > A bit more detail would be nice. which function failed exactly?
> > >
> > > > and subsequent attempts to send control VQ
> > > > commands failed with a call trace:
> > > >
> > > >  watchdog: BUG: soft lockup - CPU#62 stuck for 26s! [systemd-
> > udevd:2610]
> > > >  Modules linked in: virtio_net(+) net_failover failover virtio_vdpa
> > mlx5_vdpa vringh vhost_iotlb vdpa mlx5_ib ib_uverbs ib_core mlx5_core
> > mlxfw psample tls pci>
> > > >   drm ghash_clmulni_intel serio_raw usb_storage scsi_transport_sas
> > hpwdt wmi target_core_mod [last unloaded: ib_core]
> > > >  CPU: 62 PID: 2610 Comm: systemd-udevd Tainted: G I        6.0.0-rc2+ #7
> > > >  Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS
> > U30 04/08/2020
> > > >  RIP: 0010:virtnet_send_command+0xfa/0x140 [virtio_net]
> > > >  Code: ec f0 80 e0 85 c0 0f 88 0c 68 00 00 48 8b 7b 08 e8 9b d6 80 e0 84 c0
> > 75 11 eb 43 48 8b 7b 08 e8 7c c3 80 e0 84 c0 75 15 f3 90 <48> 8b 7b 08 48 8d
> > 74 24 >
> > > >  RSP: 0018:ffffb6fba2037b78 EFLAGS: 00000246
> > > >  RAX: 0000000000000000 RBX: ffff99c6043a99c0 RCX: 0000000000000000
> > > >  RDX: 0000000000000000 RSI: ffffb6fba2037b7c RDI: ffff99c6042c6500
> > > >  RBP: ffffb6fba2037bc0 R08: 0000000000000001 R09: 0000000000000000
> > > >  R10: 0000000000000003 R11: 0000000000000002 R12:
> > 0000000000000002
> > > >  R13: 0000000000000004 R14: 0000000000000000 R15: ffff99f634258400
> > > >  FS:  00007f5894eefb40(0000) GS:ffff99dd9fb80000(0000)
> > knlGS:0000000000000000
> > > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >  CR2: 000055acd4a80000 CR3: 00000018605a4002 CR4:
> > 00000000007706e0
> > > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > >  PKRU: 55555554
> > > >  Call Trace:
> > > >   <TASK>
> > > >   _virtnet_set_queues+0x7f/0xc0 [virtio_net]
> >
> > Btw the calltrace seems like the driver is waiting for the completion
> > of mq setting command.
> >
>
> Yes, and driver resources may no be available due to the failure.
>
> > There's some recent discussion of using timeout or interrupt for ctrl
> > command which may help to solve this issue.
> >
>
> That could work but why wait for a timeout if you can detect the failure immediately?

If I understand the calltrace, it is just waiting for the response, so
it doesn't know whether it succeeds or not?

        /* Spin for a response, the kick causes an ioport write, trapping
         * into the hypervisor, so the request should be handled immediately.
         */
        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
               !virtqueue_is_broken(vi->cvq))
                cpu_relax();

Thanks

> After initializing seems a good point in time to check if things went right or wrong.
>
> > Thanks
> >
> > > >   virtnet_probe+0x989/0xae0 [virtio_net]
> > > >   virtio_dev_probe+0x1ab/0x260
> > > >   really_probe+0xde/0x390
> > > >   ? pm_runtime_barrier+0x50/0x90
> > > >   __driver_probe_device+0x78/0x180
> > > >   driver_probe_device+0x1e/0x90
> > > >   __driver_attach+0xc4/0x1e0
> > > >   ? __device_attach_driver+0xe0/0xe0
> > > >   ? __device_attach_driver+0xe0/0xe0
> > > >   bus_for_each_dev+0x61/0x90
> > > >   bus_add_driver+0x1a9/0x200
> > > >   driver_register+0x8f/0xf0
> > > >   ? 0xffffffffc0fdb000
> > > >   virtio_net_driver_init+0x70/0x1000 [virtio_net]
> > > >   do_one_initcall+0x41/0x210
> > > >   ? kmem_cache_alloc_trace+0x16d/0x2c0
> > > >   do_init_module+0x4c/0x1f0
> > > >   __do_sys_finit_module+0x9f/0x100
> > > >   do_syscall_64+0x38/0x90
> > > >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >  RIP: 0033:0x7f589510aecd
> > > >  Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48
> > 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01
> > >
> > > >  RSP: 002b:00007ffde61fb398 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000139
> > > >  RAX: ffffffffffffffda RBX: 000055acd48ac950 RCX: 00007f589510aecd
> > > >  RDX: 0000000000000000 RSI: 00007f589584332c RDI:
> > 0000000000000012
> > > >  RBP: 0000000000020000 R08: 0000000000000000 R09:
> > 0000000000000002
> > > >  R10: 0000000000000012 R11: 0000000000000246 R12:
> > 00007f589584332c
> > > >  R13: 000055acd4867c70 R14: 0000000000000007 R15:
> > 000055acd48980a0
> > > >   </TASK>
> > > >
> > > > Fixes: commit 4baf1e33d084 ("virtio_net: enable VQs early")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 9cce7dec7366..4698d9a28a6f 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3900,6 +3900,11 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > > >       }
> > > >
> > > >       virtio_device_ready(vdev);
> > > > +     if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_FAILED) {
> > > > +             err = -EINVAL;
> > > > +             rtnl_unlock();
> > > > +             goto unregister_ndev;
> > > > +     }
> > > >
> > > >       rtnl_unlock();
> > > >
> > >
> > > I don't get it. What set the failed status?
> > >
> > >
> > > > @@ -3934,7 +3939,7 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > > >
> > > >  free_unregister_netdev:
> > > >       virtio_reset_device(vdev);
> > > > -
> > > > +unregister_ndev:
> > > >       unregister_netdev(dev);
> > > >  free_failover:
> > > >       net_failover_destroy(vi->failover);
> > > > --
> > > > 2.35.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
