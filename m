Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CFDECAAD1
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 12:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E1244188C;
	Wed, 31 Aug 2022 12:28:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2E1244188C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GIy0XGpI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qXlw43bMztxA; Wed, 31 Aug 2022 12:28:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F314B4189E;
	Wed, 31 Aug 2022 12:28:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F314B4189E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8868C0032;
	Wed, 31 Aug 2022 12:28:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DEAEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 12:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 528744189E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 12:28:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 528744189E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MBqOd0SMhC5l
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 12:27:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABECE4188C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABECE4188C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661948877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ooRgpP58qRqWweDmSzFv7zXSIZrv3ZdHHKL5JkWXoU=;
 b=GIy0XGpI/+JALXXxBgbskuB1xyCLdQO6A7sk0zd+jt3k8yT9aK3yaNngXJJEmv1nSUQZ/p
 08FIH1Dvx/JWY7uvLSVCq2WFSo8dRT4vp6sW2TwTw+2VSW4zgx6rAqHJkBJPzI+gVwX+zE
 rGOB2flK4U0nTzTxbjXb0sEJIZWUAjs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-gzDyMUvDMdaS0Z5g_8kbMQ-1; Wed, 31 Aug 2022 08:27:56 -0400
X-MC-Unique: gzDyMUvDMdaS0Z5g_8kbMQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 j22-20020a05600c485600b003a5e4420552so11642085wmo.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 05:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=8ooRgpP58qRqWweDmSzFv7zXSIZrv3ZdHHKL5JkWXoU=;
 b=rYLwGYaN0sE3FabSglDVTWDNW85k+rEQt5k9nAaazMUkCQRf4Oaht5dlv4WNwnjzsE
 6u9viVSz8DjKTFYyweFOZ3bcH9kVtPYPgMvQkxpGSKjDkxaTsJPFfd122LciuMJ2qp3G
 aCmEHCtDI62dYJozfSWqTwwW782Mt2hnsqUVjmKvHh6qimkAMZcUT1mMSZjBVle6YSiM
 8D68BtiTWOHaI2OU3m3M+q69Q3bICdjKvQGgeDfDapKY7nDA36zyRreI9Y05/7W6t1c/
 VsTHjsagEvP7btM7MSLpl0uKxLpxo5pUC+BW1jAfhW/fFoO8+Ix6Wq2q39GAzxV4yD/U
 hgRw==
X-Gm-Message-State: ACgBeo0mJHJkHqQPsNjd321OkPdgVB85y//H/ZR7HnoFUqq4WzFeDjdQ
 kDESnpKF1YnnZULV4ieaniGy9tt8q2MQKsEMS+9y23cdMjTYv9o3FEJb9r1LCgocpkIOD5nRRUH
 piABz8bQv5eLvQbj2dzbxa0ac7OWdJcYmgqQvsYUKWQ==
X-Received: by 2002:a1c:4c18:0:b0:3a6:9e0:7c2a with SMTP id
 z24-20020a1c4c18000000b003a609e07c2amr1936016wmf.42.1661948874688; 
 Wed, 31 Aug 2022 05:27:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR43/0O5t7g3PLGlpUN5SaBOfMSuV6q1/p24WfA2v2Aah2kv7kA5cyg5NfKkw+5DNND4jcYX+w==
X-Received: by 2002:a1c:4c18:0:b0:3a6:9e0:7c2a with SMTP id
 z24-20020a1c4c18000000b003a609e07c2amr1936001wmf.42.1661948874472; 
 Wed, 31 Aug 2022 05:27:54 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 h15-20020a5d548f000000b0020e6ce4dabdsm11960999wrv.103.2022.08.31.05.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Aug 2022 05:27:53 -0700 (PDT)
Date: Wed, 31 Aug 2022 08:27:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] virtio_net: Abort driver initialization if device fails
Message-ID: <20220831082047-mutt-send-email-mst@kernel.org>
References: <20220828154820.458007-1-elic@nvidia.com>
 <20220828160106-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54007A124E19FAF1AEA1F9C3AB769@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54007A124E19FAF1AEA1F9C3AB769@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "eperezma@redhat.com" <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Aug 29, 2022 at 04:49:02AM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, August 28, 2022 11:08 PM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: jasowang@redhat.com; eperezma@redhat.com; si-wei.liu@oracle.com;
> > virtualization@lists.linux-foundation.org
> > Subject: Re: [PATCH] virtio_net: Abort driver initialization if device fails
> > 
> > On Sun, Aug 28, 2022 at 06:48:20PM +0300, Eli Cohen wrote:
> > > Read the status bit after virtio_device_ready() to check if device
> > > initialization was successful. If it was not, abort driver
> > > initialization to avoid further attempts to access device resources.
> > >
> > > Abort is required per virtio spec v1.1
> > >
> > > 3.1.1
> > > ...
> > > If any of these steps go irrecoverably wrong, the driver SHOULD set the
> > > FAILED status bit to indicate that it has given up on the device (it can
> > > reset the device later to restart if desired). The driver MUST NOT
> > > continue initialization in that case.
> > 
> > I don't see a requirement to read the status bit though
> > which is what the patch does.
> > 
> 
> No explicit requirement to read the status but we are required to abort in
> case of a failure and reading the status seems legitimate way to detect this situation.

Isn't this supposed to be VIRTIO_CONFIG_S_NEEDS_RESET then?


Here's my analysis:

	device might set VIRTIO_CONFIG_S_NEEDS_RESET on failure.
	Normally it will assert a config change interrupt allowing
	us to check that.

	However, if failure triggers before DRIVER_OK it set,
	interrupt can not be sent.

	To address this, check after DRIVER_OK.

Maybe add a comment along these lines.

 Also how about doing this check inside virtio_device_ready and
marking device as broken, and returning error code?


> > > This fixes an issue that was discovered when mlx5_vdpa initialization
> > > failed due to firmware error
> > 
> > A bit more detail would be nice. which function failed exactly?
> > 
> > > and subsequent attempts to send control VQ
> > > commands failed with a call trace:
> > >
> > >  watchdog: BUG: soft lockup - CPU#62 stuck for 26s! [systemd-udevd:2610]
> > >  Modules linked in: virtio_net(+) net_failover failover virtio_vdpa
> > mlx5_vdpa vringh vhost_iotlb vdpa mlx5_ib ib_uverbs ib_core mlx5_core
> > mlxfw psample tls pci>
> > >   drm ghash_clmulni_intel serio_raw usb_storage scsi_transport_sas hpwdt
> > wmi target_core_mod [last unloaded: ib_core]
> > >  CPU: 62 PID: 2610 Comm: systemd-udevd Tainted: G I        6.0.0-rc2+ #7
> > >  Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS
> > U30 04/08/2020
> > >  RIP: 0010:virtnet_send_command+0xfa/0x140 [virtio_net]
> > >  Code: ec f0 80 e0 85 c0 0f 88 0c 68 00 00 48 8b 7b 08 e8 9b d6 80 e0 84 c0
> > 75 11 eb 43 48 8b 7b 08 e8 7c c3 80 e0 84 c0 75 15 f3 90 <48> 8b 7b 08 48 8d
> > 74 24 >
> > >  RSP: 0018:ffffb6fba2037b78 EFLAGS: 00000246
> > >  RAX: 0000000000000000 RBX: ffff99c6043a99c0 RCX: 0000000000000000
> > >  RDX: 0000000000000000 RSI: ffffb6fba2037b7c RDI: ffff99c6042c6500
> > >  RBP: ffffb6fba2037bc0 R08: 0000000000000001 R09: 0000000000000000
> > >  R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000002
> > >  R13: 0000000000000004 R14: 0000000000000000 R15: ffff99f634258400
> > >  FS:  00007f5894eefb40(0000) GS:ffff99dd9fb80000(0000)
> > knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 000055acd4a80000 CR3: 00000018605a4002 CR4: 00000000007706e0
> > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >  PKRU: 55555554
> > >  Call Trace:
> > >   <TASK>
> > >   _virtnet_set_queues+0x7f/0xc0 [virtio_net]
> > >   virtnet_probe+0x989/0xae0 [virtio_net]
> > >   virtio_dev_probe+0x1ab/0x260
> > >   really_probe+0xde/0x390
> > >   ? pm_runtime_barrier+0x50/0x90
> > >   __driver_probe_device+0x78/0x180
> > >   driver_probe_device+0x1e/0x90
> > >   __driver_attach+0xc4/0x1e0
> > >   ? __device_attach_driver+0xe0/0xe0
> > >   ? __device_attach_driver+0xe0/0xe0
> > >   bus_for_each_dev+0x61/0x90
> > >   bus_add_driver+0x1a9/0x200
> > >   driver_register+0x8f/0xf0
> > >   ? 0xffffffffc0fdb000
> > >   virtio_net_driver_init+0x70/0x1000 [virtio_net]
> > >   do_one_initcall+0x41/0x210
> > >   ? kmem_cache_alloc_trace+0x16d/0x2c0
> > >   do_init_module+0x4c/0x1f0
> > >   __do_sys_finit_module+0x9f/0x100
> > >   do_syscall_64+0x38/0x90
> > >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >  RIP: 0033:0x7f589510aecd
> > >  Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48
> > 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01
> > >
> > >  RSP: 002b:00007ffde61fb398 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000139
> > >  RAX: ffffffffffffffda RBX: 000055acd48ac950 RCX: 00007f589510aecd
> > >  RDX: 0000000000000000 RSI: 00007f589584332c RDI: 0000000000000012
> > >  RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
> > >  R10: 0000000000000012 R11: 0000000000000246 R12: 00007f589584332c
> > >  R13: 000055acd4867c70 R14: 0000000000000007 R15: 000055acd48980a0
> > >   </TASK>
> > >
> > > Fixes: commit 4baf1e33d084 ("virtio_net: enable VQs early")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >  drivers/net/virtio_net.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 9cce7dec7366..4698d9a28a6f 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3900,6 +3900,11 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > >  	}
> > >
> > >  	virtio_device_ready(vdev);
> > > +	if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_FAILED) {
> > > +		err = -EINVAL;
> > > +		rtnl_unlock();
> > > +		goto unregister_ndev;
> > > +	}
> > >
> > >  	rtnl_unlock();
> > >
> > 
> > I don't get it. What set the failed status?
> > 
> > 
> > > @@ -3934,7 +3939,7 @@ static int virtnet_probe(struct virtio_device
> > *vdev)
> > >
> > >  free_unregister_netdev:
> > >  	virtio_reset_device(vdev);
> > > -
> > > +unregister_ndev:
> > >  	unregister_netdev(dev);
> > >  free_failover:
> > >  	net_failover_destroy(vi->failover);
> > > --
> > > 2.35.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
