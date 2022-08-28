Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59286ECAAD5
	for <virtualization@archiver.kernel.org>; Sun, 28 Aug 2022 20:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD804400C6;
	Sun, 28 Aug 2022 20:08:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD804400C6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cQ2nxVGI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2DE_Ehdk7cQ; Sun, 28 Aug 2022 20:08:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31A1E4013B;
	Sun, 28 Aug 2022 20:08:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31A1E4013B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 047FAC0033;
	Sun, 28 Aug 2022 20:08:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3850C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Aug 2022 20:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE24482E14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Aug 2022 20:07:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE24482E14
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cQ2nxVGI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BXjbVPpnI-d0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Aug 2022 20:07:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93E2C82C9C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93E2C82C9C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Aug 2022 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661717275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dkhs9jS97o3xfq+pE4J0bwa09XMh5s6RGPrhLKnfvcY=;
 b=cQ2nxVGIpPzwzvTc3OJ/Gfl1ud3yhywo/JJ20sOux5xeMpsNerM7kru3wXF4v44ux+Pq2J
 UQWhil3MbNiF5cOKe7J3jTZHD4RY0E36LRRcX06BbeQdxD9lM3zzdM9QUJTiMr/aNdnrkD
 YQSiNsaSNA2WHGKe/uXk5n3lPVS8TZE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-399-OgQ-LiGmMzWiB8g7z3kILg-1; Sun, 28 Aug 2022 16:07:54 -0400
X-MC-Unique: OgQ-LiGmMzWiB8g7z3kILg-1
Received: by mail-ed1-f70.google.com with SMTP id
 h17-20020a05640250d100b00446d1825c9fso4387501edb.14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Aug 2022 13:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Dkhs9jS97o3xfq+pE4J0bwa09XMh5s6RGPrhLKnfvcY=;
 b=ks5BtXz6vKhTFyqGXStj6icCQQSiHq5DH/vkFmJjCKWczkEls10x6gwkY/TZZlMIKU
 euZeyazSqhfuDr0cfh6XacVnLi+Q8UqpOmd2DCJ5YMOHp7k5Wmi6VSQGnLO5ZoCqfpvP
 SYzb9dhro9WrjoaxGF/BH26p0o2GV1FuZRw6vKLKCuCHIZCNZ2VCK+1O28raqpWuRATe
 3D+/LSpHLLuXpIL/nCDBKqxXQgkp84a4c+hvSDQXvFHT+ygwAJLxvBm1amuN7rOe21sl
 XhAPzSFRVcQcSr4tqXFicouqGHoSccya5h/T78yutcx78S1WEWIzpv52VaqRfzgDWYq4
 AkgQ==
X-Gm-Message-State: ACgBeo0ReXbZd+eikroiObfLTOjY3CYMya+L+02q8rD+2EDhawE+Sbtr
 IVFc+fJZrCNx2RzcVCYMK7HGoaRRCOl4ng6lIAX9vFBPGLmpIiRQgEHwf6MJSdouD0ONkUJxWGT
 mWHKcHkbBpF8ogo8bJDrAd9pD+0eTWeUznu76UDYcKg==
X-Received: by 2002:aa7:c7da:0:b0:440:d482:36b5 with SMTP id
 o26-20020aa7c7da000000b00440d48236b5mr14377288eds.21.1661717272997; 
 Sun, 28 Aug 2022 13:07:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4NVGbcC3jhyzN2R5KVNmyTIu2lRZAsNis1uvYQYcL6759YhFf7utWgvsRTjYDWivaAn4lWfw==
X-Received: by 2002:aa7:c7da:0:b0:440:d482:36b5 with SMTP id
 o26-20020aa7c7da000000b00440d48236b5mr14377276eds.21.1661717272723; 
 Sun, 28 Aug 2022 13:07:52 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 h5-20020a50cdc5000000b0043b986751a7sm4792361edj.41.2022.08.28.13.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Aug 2022 13:07:52 -0700 (PDT)
Date: Sun, 28 Aug 2022 16:07:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] virtio_net: Abort driver initialization if device fails
Message-ID: <20220828160106-mutt-send-email-mst@kernel.org>
References: <20220828154820.458007-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220828154820.458007-1-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org
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

On Sun, Aug 28, 2022 at 06:48:20PM +0300, Eli Cohen wrote:
> Read the status bit after virtio_device_ready() to check if device
> initialization was successful. If it was not, abort driver
> initialization to avoid further attempts to access device resources.
> 
> Abort is required per virtio spec v1.1
> 
> 3.1.1
> ...
> If any of these steps go irrecoverably wrong, the driver SHOULD set the
> FAILED status bit to indicate that it has given up on the device (it can
> reset the device later to restart if desired). The driver MUST NOT
> continue initialization in that case.

I don't see a requirement to read the status bit though
which is what the patch does.

> This fixes an issue that was discovered when mlx5_vdpa initialization
> failed due to firmware error

A bit more detail would be nice. which function failed exactly?

> and subsequent attempts to send control VQ
> commands failed with a call trace:
> 
>  watchdog: BUG: soft lockup - CPU#62 stuck for 26s! [systemd-udevd:2610]
>  Modules linked in: virtio_net(+) net_failover failover virtio_vdpa mlx5_vdpa vringh vhost_iotlb vdpa mlx5_ib ib_uverbs ib_core mlx5_core mlxfw psample tls pci>
>   drm ghash_clmulni_intel serio_raw usb_storage scsi_transport_sas hpwdt wmi target_core_mod [last unloaded: ib_core]
>  CPU: 62 PID: 2610 Comm: systemd-udevd Tainted: G I        6.0.0-rc2+ #7
>  Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 04/08/2020
>  RIP: 0010:virtnet_send_command+0xfa/0x140 [virtio_net]
>  Code: ec f0 80 e0 85 c0 0f 88 0c 68 00 00 48 8b 7b 08 e8 9b d6 80 e0 84 c0 75 11 eb 43 48 8b 7b 08 e8 7c c3 80 e0 84 c0 75 15 f3 90 <48> 8b 7b 08 48 8d 74 24 >
>  RSP: 0018:ffffb6fba2037b78 EFLAGS: 00000246
>  RAX: 0000000000000000 RBX: ffff99c6043a99c0 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffffb6fba2037b7c RDI: ffff99c6042c6500
>  RBP: ffffb6fba2037bc0 R08: 0000000000000001 R09: 0000000000000000
>  R10: 0000000000000003 R11: 0000000000000002 R12: 0000000000000002
>  R13: 0000000000000004 R14: 0000000000000000 R15: ffff99f634258400
>  FS:  00007f5894eefb40(0000) GS:ffff99dd9fb80000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055acd4a80000 CR3: 00000018605a4002 CR4: 00000000007706e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   _virtnet_set_queues+0x7f/0xc0 [virtio_net]
>   virtnet_probe+0x989/0xae0 [virtio_net]
>   virtio_dev_probe+0x1ab/0x260
>   really_probe+0xde/0x390
>   ? pm_runtime_barrier+0x50/0x90
>   __driver_probe_device+0x78/0x180
>   driver_probe_device+0x1e/0x90
>   __driver_attach+0xc4/0x1e0
>   ? __device_attach_driver+0xe0/0xe0
>   ? __device_attach_driver+0xe0/0xe0
>   bus_for_each_dev+0x61/0x90
>   bus_add_driver+0x1a9/0x200
>   driver_register+0x8f/0xf0
>   ? 0xffffffffc0fdb000
>   virtio_net_driver_init+0x70/0x1000 [virtio_net]
>   do_one_initcall+0x41/0x210
>   ? kmem_cache_alloc_trace+0x16d/0x2c0
>   do_init_module+0x4c/0x1f0
>   __do_sys_finit_module+0x9f/0x100
>   do_syscall_64+0x38/0x90
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>  RIP: 0033:0x7f589510aecd
>  Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 >
>  RSP: 002b:00007ffde61fb398 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>  RAX: ffffffffffffffda RBX: 000055acd48ac950 RCX: 00007f589510aecd
>  RDX: 0000000000000000 RSI: 00007f589584332c RDI: 0000000000000012
>  RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000002
>  R10: 0000000000000012 R11: 0000000000000246 R12: 00007f589584332c
>  R13: 000055acd4867c70 R14: 0000000000000007 R15: 000055acd48980a0
>   </TASK>
> 
> Fixes: commit 4baf1e33d084 ("virtio_net: enable VQs early")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9cce7dec7366..4698d9a28a6f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3900,6 +3900,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  
>  	virtio_device_ready(vdev);
> +	if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_FAILED) {
> +		err = -EINVAL;
> +		rtnl_unlock();
> +		goto unregister_ndev;
> +	}
>  
>  	rtnl_unlock();
>  

I don't get it. What set the failed status?


> @@ -3934,7 +3939,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  
>  free_unregister_netdev:
>  	virtio_reset_device(vdev);
> -
> +unregister_ndev:
>  	unregister_netdev(dev);
>  free_failover:
>  	net_failover_destroy(vi->failover);
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
