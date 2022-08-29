Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F07ECAAA2
	for <virtualization@archiver.kernel.org>; Mon, 29 Aug 2022 00:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1599840BC2;
	Mon, 29 Aug 2022 00:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1599840BC2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DxaPf+jh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-DvtrIeWoBs; Mon, 29 Aug 2022 00:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 78E5B4053C;
	Mon, 29 Aug 2022 00:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78E5B4053C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 466DAC0033;
	Mon, 29 Aug 2022 00:33:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 329ACC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 00:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 055DB818C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 00:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 055DB818C2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DxaPf+jh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vA37RQccMfrr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 00:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC94C818C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC94C818C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 00:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661733206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNNho4IE13c6XGtFRhVEnxk0LhGjuNtaNzCNQKnIH+8=;
 b=DxaPf+jhGY1jZOnnlsfQNY/Aub12/9d2yK8KRGx/B5B53y2qlRFeek6J95Jw0Ak9uzFuIv
 Upz9sx02PKKEm1h75SD1isapY1Y4AhjQ6gwBFteFMmR7HNr44hV5s7PFichQ6bjs95Ru7S
 Io4SFoGXyixxBV72hRNSdi7FyKMte88=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-UQydKbMcNhat1iZ-eNXEYg-1; Sun, 28 Aug 2022 20:33:24 -0400
X-MC-Unique: UQydKbMcNhat1iZ-eNXEYg-1
Received: by mail-lf1-f71.google.com with SMTP id
 dt8-20020a0565122a8800b00492f7025810so1546734lfb.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Aug 2022 17:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=yNNho4IE13c6XGtFRhVEnxk0LhGjuNtaNzCNQKnIH+8=;
 b=qmSPPVNUOqTVKfiwugz+5A6KX5z2PeI/UFmw1bJtN9Bzz53s0FnTIx1ecIGRgOBcSA
 RJoBomlKnuPe5WIgzfq5+X6BC0SSa9RAUVAtOxCT/sd/UdxjvaZVjTeu++y0VGfKYhWK
 +6an1ayw/nv68cdR6OoQe2EjT59Ei6LOjL+1A8sDi28kSupTexBnnd6pVvSntTr1h4gl
 TyTFuld1LXNs2Vo8DzoNwyEmuP+wVB7pIiPpOwahE5dCz4K3rWrVGGQ7g5SPn5XzHXlD
 UEeL7LCMjmW9TQBHliO635FDalgERfvHQ9FUjcZNd8A27rUmTfJIOV4tnO5NpCW8LHr8
 skJA==
X-Gm-Message-State: ACgBeo2/htckEDgRnVO07KtvEmbslLKb7jMwx4YNHzrhfeQxX+8ecvDP
 IkdPk8ZTH9/RtXmnDVrgSHvw2JRD83kizHXZ7RZ5qjuc82RhjwL0r2sSLf54V1iC2szwE1+qpVW
 psoC6gadr/ukB9FaRvdNpYU7Nnf78Fk1ziSjWsYY5QRvMAoYbbPg4BdqXfQ==
X-Received: by 2002:a05:6512:6cb:b0:492:da9e:4689 with SMTP id
 u11-20020a05651206cb00b00492da9e4689mr6153423lff.641.1661733202933; 
 Sun, 28 Aug 2022 17:33:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5hLmX4M8UBiM+afM0aKFKs2X5BBe1Vb+43fqlSjUVjA+G77U46rNfKVRuHneLrt8gtLAQfOsPgtfL8pFtH07s=
X-Received: by 2002:a05:6512:6cb:b0:492:da9e:4689 with SMTP id
 u11-20020a05651206cb00b00492da9e4689mr6153419lff.641.1661733202690; Sun, 28
 Aug 2022 17:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220828154820.458007-1-elic@nvidia.com>
 <20220828160106-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220828160106-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Aug 2022 08:33:11 +0800
Message-ID: <CACGkMEtubshhZaX4CAjpyiDVSdofW=Mha4HM56FjtK57f1W+Zw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Abort driver initialization if device fails
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Aug 29, 2022 at 4:07 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Aug 28, 2022 at 06:48:20PM +0300, Eli Cohen wrote:
> > Read the status bit after virtio_device_ready() to check if device
> > initialization was successful. If it was not, abort driver
> > initialization to avoid further attempts to access device resources.
> >
> > Abort is required per virtio spec v1.1
> >
> > 3.1.1
> > ...
> > If any of these steps go irrecoverably wrong, the driver SHOULD set the
> > FAILED status bit to indicate that it has given up on the device (it can
> > reset the device later to restart if desired). The driver MUST NOT
> > continue initialization in that case.
>
> I don't see a requirement to read the status bit though
> which is what the patch does.
>
> > This fixes an issue that was discovered when mlx5_vdpa initialization
> > failed due to firmware error
>
> A bit more detail would be nice. which function failed exactly?
>
> > and subsequent attempts to send control VQ
> > commands failed with a call trace:
> >
> >  watchdog: BUG: soft lockup - CPU#62 stuck for 26s! [systemd-udevd:2610]
> >  Modules linked in: virtio_net(+) net_failover failover virtio_vdpa mlx5_vdpa vringh vhost_iotlb vdpa mlx5_ib ib_uverbs ib_core mlx5_core mlxfw psample tls pci>
> >   drm ghash_clmulni_intel serio_raw usb_storage scsi_transport_sas hpwdt wmi target_core_mod [last unloaded: ib_core]
> >  CPU: 62 PID: 2610 Comm: systemd-udevd Tainted: G I        6.0.0-rc2+ #7
> >  Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 04/08/2020
> >  RIP: 0010:virtnet_send_command+0xfa/0x140 [virtio_net]
> >  Code: ec f0 80 e0 85 c0 0f 88 0c 68 00 00 48 8b 7b 08 e8 9b d6 80 e0 84 c0 75 11 eb 43 48 8b 7b 08 e8 7c c3 80 e0 84 c0 75 15 f3 90 <48> 8b 7b 08 48 8d 74 24 >
> >  RSP: 0018:ffffb6fba2037b78 EFLAGS: 00000246
> >  RAX: 0000000000000000 RBX: ffff99c6043a99c0 RCX: 0000000000000000
> >  RDX: 0000000000000000 RSI: ffffb6fba2037b7c RDI: ffff99c6042c6500
> >  RBP: ffffb6fba2037bc0 R08: 0000000000000001 R09: 0000000000000000
> >  R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000002
> >  R13: 0000000000000004 R14: 0000000000000000 R15: ffff99f634258400
> >  FS:  00007f5894eefb40(0000) GS:ffff99dd9fb80000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 000055acd4a80000 CR3: 00000018605a4002 CR4: 00000000007706e0
> >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >  PKRU: 55555554
> >  Call Trace:
> >   <TASK>
> >   _virtnet_set_queues+0x7f/0xc0 [virtio_net]

Btw the calltrace seems like the driver is waiting for the completion
of mq setting command.

There's some recent discussion of using timeout or interrupt for ctrl
command which may help to solve this issue.

Thanks

> >   virtnet_probe+0x989/0xae0 [virtio_net]
> >   virtio_dev_probe+0x1ab/0x260
> >   really_probe+0xde/0x390
> >   ? pm_runtime_barrier+0x50/0x90
> >   __driver_probe_device+0x78/0x180
> >   driver_probe_device+0x1e/0x90
> >   __driver_attach+0xc4/0x1e0
> >   ? __device_attach_driver+0xe0/0xe0
> >   ? __device_attach_driver+0xe0/0xe0
> >   bus_for_each_dev+0x61/0x90
> >   bus_add_driver+0x1a9/0x200
> >   driver_register+0x8f/0xf0
> >   ? 0xffffffffc0fdb000
> >   virtio_net_driver_init+0x70/0x1000 [virtio_net]
> >   do_one_initcall+0x41/0x210
> >   ? kmem_cache_alloc_trace+0x16d/0x2c0
> >   do_init_module+0x4c/0x1f0
> >   __do_sys_finit_module+0x9f/0x100
> >   do_syscall_64+0x38/0x90
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >  RIP: 0033:0x7f589510aecd
> >  Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 >
> >  RSP: 002b:00007ffde61fb398 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> >  RAX: ffffffffffffffda RBX: 000055acd48ac950 RCX: 00007f589510aecd
> >  RDX: 0000000000000000 RSI: 00007f589584332c RDI: 0000000000000012
> >  RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
> >  R10: 0000000000000012 R11: 0000000000000246 R12: 00007f589584332c
> >  R13: 000055acd4867c70 R14: 0000000000000007 R15: 000055acd48980a0
> >   </TASK>
> >
> > Fixes: commit 4baf1e33d084 ("virtio_net: enable VQs early")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >  drivers/net/virtio_net.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9cce7dec7366..4698d9a28a6f 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3900,6 +3900,11 @@ static int virtnet_probe(struct virtio_device *vdev)
> >       }
> >
> >       virtio_device_ready(vdev);
> > +     if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_FAILED) {
> > +             err = -EINVAL;
> > +             rtnl_unlock();
> > +             goto unregister_ndev;
> > +     }
> >
> >       rtnl_unlock();
> >
>
> I don't get it. What set the failed status?
>
>
> > @@ -3934,7 +3939,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> >
> >  free_unregister_netdev:
> >       virtio_reset_device(vdev);
> > -
> > +unregister_ndev:
> >       unregister_netdev(dev);
> >  free_failover:
> >       net_failover_destroy(vi->failover);
> > --
> > 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
