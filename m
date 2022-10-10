Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FED8C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 17:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28E3C81CD0;
	Mon, 10 Oct 2022 17:13:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28E3C81CD0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gpWA8ORb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qQMWEpqDH-Lq; Mon, 10 Oct 2022 17:13:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD8BF81BB4;
	Mon, 10 Oct 2022 17:13:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD8BF81BB4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 823FEC0032;
	Mon, 10 Oct 2022 17:13:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27C26C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E890A81BB4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:13:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E890A81BB4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Igo4G9VEhv40
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:13:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16D5E81B72
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16D5E81B72
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665421989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sESpiz/VYjM9A5daJfiZvP9J2Ij2OUidDn+tRHUstHw=;
 b=gpWA8ORbdVFEKHtEduPS7K9HT9yVUnEgvD+XzlwPca1nJRnr0AEW9ImsMBopIe5Ch2ydnt
 cAFaLqGi/sroxMvYTR1i/QJipDF1MHuA2/EqQsQDdHOik6QtW1i88TMrU6M0ovPjg2Nue7
 KRp0TNOeK1+yx3bn5EdxWcZ1C1rhVvk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-RmpB7kPuNAGmSu9tamJ7xw-1; Mon, 10 Oct 2022 13:13:07 -0400
X-MC-Unique: RmpB7kPuNAGmSu9tamJ7xw-1
Received: by mail-wm1-f70.google.com with SMTP id
 n6-20020a7bc5c6000000b003c6bbe5d5cfso1384854wmk.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 10:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sESpiz/VYjM9A5daJfiZvP9J2Ij2OUidDn+tRHUstHw=;
 b=Pby2ESwd7pHccmwvlD6gzG74pd1p3qvkEVn97X0iBsh9ahHZOhu6na5Gw10y0qQ5Or
 vLDR1Bzm4KaOki7v3BvKdB0tPyNoQK2/y7b9bp4ha2xMV5zNNaJP0f4gf1BROKThWO3b
 f00WALnXT0zIGd/5Bo4f7PWsSXtBFMCNpUBVxXqeNB7ojS5T+4pmFpsrX/5lmhL/kbL/
 gJO/RigXoHPGWM9Pmgbb68CBYD24RI1znXldX636QTr4APfmk1/Ien6v1LjsYiAbtnz0
 z3YF4PF+ex9ztSaSz4PvQjNe0wbiTbGm9pLIV5xiUwvJ6DCDTOOtOv3S4vS4o9kDKjez
 uGPA==
X-Gm-Message-State: ACrzQf1E8XerpUdy4WphYMVDY423bAOFT0A8cCaEmqRTtmpwsOdG5r8+
 tydfAQOR6BmJVbXB3IJbURdlz4vYosVeT2fm23pYWP3Ai1YpAwdkj1+nl7/LGQ1UYDpXmptZnMW
 ZXZTHnLwmMfK+vrKuPuXgHuAOssnZtG1hXYsHn7AXHg==
X-Received: by 2002:a05:600c:154e:b0:3b4:bf17:32fc with SMTP id
 f14-20020a05600c154e00b003b4bf1732fcmr20968749wmg.70.1665421986574; 
 Mon, 10 Oct 2022 10:13:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6PDZ1aYGhkTIK39DzMqnDp43BNe6ZWg+0t3wyiifJ9ViKHjYnK6WDmYqEo4HbjNdRuo4g2Mg==
X-Received: by 2002:a05:600c:154e:b0:3b4:bf17:32fc with SMTP id
 f14-20020a05600c154e00b003b4bf1732fcmr20968738wmg.70.1665421986322; 
 Mon, 10 Oct 2022 10:13:06 -0700 (PDT)
Received: from redhat.com ([2.55.183.131]) by smtp.gmail.com with ESMTPSA id
 p1-20020a5d68c1000000b0022cce7689d3sm11823812wrw.36.2022.10.10.10.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Oct 2022 10:13:05 -0700 (PDT)
Date: Mon, 10 Oct 2022 13:13:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gongwei <gongwei833x@gmail.com>
Subject: Re: [PATCH] virtio_pci: don't hang when vf dev is disabled
Message-ID: <20221009151308-mutt-send-email-mst@kernel.org>
References: <20221008143656.154616-1-gongwei833x@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20221008143656.154616-1-gongwei833x@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Sat, Oct 08, 2022 at 02:36:56PM +0000, gongwei wrote:
> according to sriov's protocol specification vendor_id and
> device_id field in all VFs return FFFFh when read
> so when vf devs is in the pci_device_is_present,it will be
> misjudged as surprise removeal
> 
> when io is issued on the vf, normally disable virtio_blk vf
> devs,at this time the disable opration will hang. and virtio
> blk dev io hang.
> 
> task:bash            state:D stack:    0 pid: 1773 ppid:  1241 flags:0x00004002
> Call Trace:
>  <TASK>
>  __schedule+0x2ee/0x900
>  schedule+0x4f/0xc0
>  blk_mq_freeze_queue_wait+0x69/0xa0
>  ? wait_woken+0x80/0x80
>  blk_mq_freeze_queue+0x1b/0x20
>  blk_cleanup_queue+0x3d/0xd0
>  virtblk_remove+0x3c/0xb0 [virtio_blk]
>  virtio_dev_remove+0x4b/0x80
>  device_release_driver_internal+0x103/0x1d0
>  device_release_driver+0x12/0x20
>  bus_remove_device+0xe1/0x150
>  device_del+0x192/0x3f0
>  device_unregister+0x1b/0x60
>  unregister_virtio_device+0x18/0x30
>  virtio_pci_remove+0x41/0x80
>  pci_device_remove+0x3e/0xb0
>  device_release_driver_internal+0x103/0x1d0
>  device_release_driver+0x12/0x20
>  pci_stop_bus_device+0x79/0xa0
>  pci_stop_and_remove_bus_device+0x13/0x20
>  pci_iov_remove_virtfn+0xc5/0x130
>  ? pci_get_device+0x4a/0x60
>  sriov_disable+0x33/0xf0
>  pci_disable_sriov+0x26/0x30
>  virtio_pci_sriov_configure+0x6f/0xa0
>  sriov_numvfs_store+0x104/0x140
>  dev_attr_store+0x17/0x30
>  sysfs_kf_write+0x3e/0x50
>  kernfs_fop_write_iter+0x138/0x1c0
>  new_sync_write+0x117/0x1b0
>  vfs_write+0x185/0x250
>  ksys_write+0x67/0xe0
>  __x64_sys_write+0x1a/0x20
>  do_syscall_64+0x61/0xb0
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f21bd1f3ba4
> RSP: 002b:00007ffd34a24188 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f21bd1f3ba4
> RDX: 0000000000000002 RSI: 0000560305040800 RDI: 0000000000000001
> RBP: 0000560305040800 R08: 000056030503fd50 R09: 0000000000000073
> R10: 00000000ffffffff R11: 0000000000000202 R12: 0000000000000002
> R13: 00007f21bd2de760 R14: 00007f21bd2da5e0 R15: 00007f21bd2d99e0
> 
> when virtio_blk is performing io, as long as there two stages of:
> 1. dispatch io. queue_usage_counter++;
> 2. io is completed after receiving the interrupt. queue_usage_counter--;
> 
> disable virtio_blk vfs:
>   if(!pci_device_is_present(pci_dev))
>     virtio_break_device(&vp_dev->vdev);
> virtqueue for vf devs will be marked broken.
> the interrupt notification io is end. Since it is judged that the
> virtqueue has been marked as broken, the completed io will not be
> performed.
> So queue_usage_counter will not be cleared.
> when the disk is removed at the same time, the queue will be frozen,
> and you must wait for the queue_usage_counter to be cleared.
> Therefore, it leads to the removeal of hang.
> 
> Signed-off-by: gongwei <gongwei833x@gmail.com>

Hmm I think this is wrong. First is_physfn is only set for SRIOV.
Second it seems to me the bug is really in the pci core.
I just sent a patch for that - can you help test please?
Third can you pls sign patches with your full name?

Forth - I could not figure out if there is still a bug
in virtio besides that. Does surprise removal work ok for you?


> ---
>  drivers/virtio/virtio_pci_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index fdbde1db5ec5..8cbc529fb582 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -616,7 +616,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	 * Device is marked broken on surprise removal so that virtio upper
>  	 * layers can abort any ongoing operation.
>  	 */
> -	if (!pci_device_is_present(pci_dev))
> +	if (!pci_device_is_present(pci_dev) && pci_dev->is_physfn)
>  		virtio_break_device(&vp_dev->vdev);
>  
>  	pci_disable_sriov(pci_dev);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
