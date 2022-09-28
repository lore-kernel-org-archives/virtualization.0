Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA66C32771
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 05:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E361360B91;
	Wed, 28 Sep 2022 05:59:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E361360B91
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKF+8Hna
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gmQeOq-kepaE; Wed, 28 Sep 2022 05:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 402BC60B5C;
	Wed, 28 Sep 2022 05:59:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 402BC60B5C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08D2DC0032;
	Wed, 28 Sep 2022 05:59:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9577FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 05:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63CEF404C4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 05:59:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 63CEF404C4
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=aKF+8Hna
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BpClZ7Pgm0gn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 05:59:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 474DD40515
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 474DD40515
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 05:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664344769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ux6ESxD86I07b6gSvTxqwQcjLCm9KKX7ZOKJu4UtAwY=;
 b=aKF+8HnamZvrfn2A05E3ZaB0EZYH9QOTwG+zpudK9fwzYQw6VjGE8QiF1DCCSj3mWjfMM3
 iSQ4nRTieLQpmkqAR9tHfhZi3a17SjcbwtrA7wPVheVDekeD8t6ymnTeVEM7TzjdMGWxQN
 VsI/Nqc6LILWMIV6oeyw+PHcCCWx0xg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-bO7ca_BcNL-Twb99DyTxIw-1; Wed, 28 Sep 2022 01:59:25 -0400
X-MC-Unique: bO7ca_BcNL-Twb99DyTxIw-1
Received: by mail-wm1-f71.google.com with SMTP id
 l15-20020a05600c4f0f00b003b4bec80edbso6613996wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 22:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=Ux6ESxD86I07b6gSvTxqwQcjLCm9KKX7ZOKJu4UtAwY=;
 b=yVK6mas7yXgG2NWEQNZqJ+B+fTwh6FLMpaIhfY1yVuZUJwR1yI9SZFPHJnDl/kQFDg
 5EoQaC5Q4BDwt0VREOGt/uvPlZUGV4C3QKMOHQIbb0znSwMGRXul+4RPT01IIWfKmvYx
 WWeC8cFbngDJPQvHodnbL8EMfmznUY66Lyo6VZCQzAKx9pk85pkeG4WAU9R0qz5NEHbN
 JkK3sFjXfDdvU+piulwH48ReEc7kT0J+l3CjR1an9GcW/p28FPc7GguCoV9NcQGBH4lr
 v91LB3YdSg17arQOkYk3j27pFhvsJx/qiiAl9DZNns+VbzZTU8RaxyNGbJjdrhJfns1S
 LV/Q==
X-Gm-Message-State: ACrzQf39b5LL+B9iVguFEcMNsdIabYbnwupKFm8asVjNOdUnrVlCZMi4
 zOsIRpbEN66PTW2slREGGR1YmjjXWhiLq7WH3FDjZTHFbAjvPFLDhBS2pHLGMxqSQSwPCKA29Sz
 HK43vsfmBlHuREWTDbpJ1FfKSR+D4RdJcVCl0rQc4wQ==
X-Received: by 2002:a05:600c:34c2:b0:3b4:7a98:5f5a with SMTP id
 d2-20020a05600c34c200b003b47a985f5amr5328689wmq.156.1664344764366; 
 Tue, 27 Sep 2022 22:59:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7UKR3w+gPq4gH2R4DtnLpTJZ0Es1FfUnbDXa88Vy1h6XPhRWaiY7aMP3aKzQ6yL81cmT8gzg==
X-Received: by 2002:a05:600c:34c2:b0:3b4:7a98:5f5a with SMTP id
 d2-20020a05600c34c200b003b47a985f5amr5328644wmq.156.1664344763132; 
 Tue, 27 Sep 2022 22:59:23 -0700 (PDT)
Received: from redhat.com ([2.55.17.78]) by smtp.gmail.com with ESMTPSA id
 k15-20020adfd22f000000b0021badf3cb26sm3017353wrh.63.2022.09.27.22.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 22:59:22 -0700 (PDT)
Date: Wed, 28 Sep 2022 01:59:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH v2] virtio_pci: avoid to request intx irq if pin is zero
Message-ID: <20220928015402-mutt-send-email-mst@kernel.org>
References: <20220928053522.440-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20220928053522.440-1-angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Thanks! More minor issues to address

On Wed, Sep 28, 2022 at 01:35:22PM +0800, Angus Chen wrote:
> The background is that we use dpu in cloud computing,the arch is x86,80
> cores.We will have a lots of virtio devices,like 512 or more.
> When we probe about 200 virtio_blk devices,it will fail and
> the stack is print as follows:
> 
> [25338.485128] virtio-pci 0000:b3:00.0: virtio_pci: leaving for legacy driver
> [25338.496174] genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)
> [25338.503822] CPU: 20 PID: 5431 Comm: kworker/20:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-305.30.1.el8.x86_64
> [25338.516403] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS 4.1.21 08/25/2021
> [25338.523881] Workqueue: events work_for_cpu_fn
> [25338.528235] Call Trace:
> [25338.530687]  dump_stack+0x5c/0x80
> [25338.534000]  __setup_irq.cold.53+0x7c/0xd3
> [25338.538098]  request_threaded_irq+0xf5/0x160
> [25338.542371]  vp_find_vqs+0xc7/0x190
> [25338.545866]  init_vq+0x17c/0x2e0 [virtio_blk]
> [25338.550223]  ? ncpus_cmp_func+0x10/0x10
> [25338.554061]  virtblk_probe+0xe6/0x8a0 [virtio_blk]
> [25338.558846]  virtio_dev_probe+0x158/0x1f0
> [25338.562861]  really_probe+0x255/0x4a0
> [25338.566524]  ? __driver_attach_async_helper+0x90/0x90
> [25338.571567]  driver_probe_device+0x49/0xc0
> [25338.575660]  bus_for_each_drv+0x79/0xc0
> [25338.579499]  __device_attach+0xdc/0x160
> [25338.583337]  bus_probe_device+0x9d/0xb0
> [25338.587167]  device_add+0x418/0x780
> [25338.590654]  register_virtio_device+0x9e/0xe0
> [25338.595011]  virtio_pci_probe+0xb3/0x140
> [25338.598941]  local_pci_probe+0x41/0x90
> [25338.602689]  work_for_cpu_fn+0x16/0x20
> [25338.606443]  process_one_work+0x1a7/0x360
> [25338.610456]  ? create_worker+0x1a0/0x1a0
> [25338.614381]  worker_thread+0x1cf/0x390
> [25338.618132]  ? create_worker+0x1a0/0x1a0
> [25338.622051]  kthread+0x116/0x130
> [25338.625283]  ? kthread_flush_work_fn+0x10/0x10
> [25338.629731]  ret_from_fork+0x1f/0x40
> [25338.633395] virtio_blk: probe of virtio418 failed with error -16
> 
> The log :
> "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> was print because of the irq 0 is used by timer exclusive,and when
> vp_find_vqs call vp_find_vqs_msix and return false twice for
> whatever reason,then it will call vp_find_vqs_intx for the last try.
> Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> flag IRQF_SHARED,we will get a backtrace like above.
> 
> according to PCI spec , Devices (or device functions)
> that do not use an interrupt pin must put a 0 in this register.

Pls add quotes and add "Interrupt Pin:" to make it clear in which register.

> So if vp_dev->pci_dev->pin is zero, maybe we should not request legacy
> interrupt.

and drop "maybe" here pls. I guess it sounds impolite to you but
as the patch author you get to make the tough decisions :)

> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v2:
> - Decide whether to request an intx interrupt by pin instead of irq
> - suggested by mst
> 
> v1:https://lore.kernel.org/virtualization/20220928000228-mutt-send-email-mst@kernel.org/T/#u
> 
>  drivers/virtio/virtio_pci_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index ad258a9d3b9f..81225e503e69 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -362,6 +362,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i, err, queue_idx = 0;
>  
> +	if (vp_dev->pci_dev->pin == 0)
> +		return -EINVAL;
> +

Pls use !pin for brevity.

>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
>  		return -ENOMEM;


So, this is mostly ok. The only issue is this:


int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
                struct virtqueue *vqs[], vq_callback_t *callbacks[],
                const char * const names[], const bool *ctx,
                struct irq_affinity *desc)
{
        int err;

        /* Try MSI-X with one vector per queue. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
        if (!err)
                return 0;
        /* Fallback: MSI-X with one vector for config, one shared for queues. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
        if (!err)
                return 0;
        /* Finally fall back to regular interrupts. */
        return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
}


So the real source of failure to use msix, will be overwritten in err by EINVAL.

How about moving the "if" to vp_find_vqs?
E.g.
	/* Is there an interrupt pin? If not give up. */
	if (!vdev->pci_dev->pin)
		return err;


> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
