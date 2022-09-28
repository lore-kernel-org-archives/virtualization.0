Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D56CC32771
	for <virtualization@archiver.kernel.org>; Wed, 28 Sep 2022 04:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF86840176;
	Wed, 28 Sep 2022 04:03:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF86840176
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XiCXbqb6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SGigLIV2ll8p; Wed, 28 Sep 2022 04:03:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D96AA400FE;
	Wed, 28 Sep 2022 04:03:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D96AA400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 959D6C0032;
	Wed, 28 Sep 2022 04:03:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57D33C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 04:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29B8581A30
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 04:03:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29B8581A30
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XiCXbqb6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L9mcPOmOG5Va
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 04:03:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D5CB81A2B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D5CB81A2B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Sep 2022 04:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664337790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V9NHV03tTrkp6hRe5QgHW9x/cWZQBABbNm3WP+xD5NE=;
 b=XiCXbqb69eRBAdaAjmwOihRoTL+Ps5xFyk5hskIhE1XZ/c0KhGWVVtO7KkiOtNMOQ2WSv0
 fKI7IWZzX8KSiHz9ucAlOZXIRDL+vpZST8VseQxJjSWUuwNRFZzsuy5yuaNvzEWo5EJERe
 rG9HUsf2NjwEVGtrQG0W+shIF5XrBYI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-48RUyS18MTG8nZFNe7TWqg-1; Wed, 28 Sep 2022 00:03:08 -0400
X-MC-Unique: 48RUyS18MTG8nZFNe7TWqg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5-20020a05600c028500b003b4d2247d3eso1356097wmk.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 21:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=V9NHV03tTrkp6hRe5QgHW9x/cWZQBABbNm3WP+xD5NE=;
 b=4lGf9/b38KxQTDcgDSukirLMB00hvzt5th8vPJdH98RPeA4EdSO9NCkKzYvqTt/L90
 67Y22KjealfoUB1dlZC3v/dFRU46Da3DRNilsJoKcUby8OPRV9B3xw17Jr7WDoYth7Bw
 /T5lCLV5AfU5XU6GgXGGNHXjW7gZQ+RG17jtOU+tcrQxBvCReHERaCl3dzIdp074uYWq
 +mpuBk6C1l5QRTtJcBES+rAGwj27cY2MkMLipkZrqJ2rWmKVUHF3jcjVTLRgRRfP5sl5
 PD+cNdE2Lk8bF63cBrs/iV5yQo8GqYcI5XvocAd7fwshgemM5oPVfShc5O0RyDiaFgWO
 AeVg==
X-Gm-Message-State: ACrzQf0A4yDkuQQhXIuOlxuS6482qi7x8VL3l7Po5peGO6rM0ayJ+07C
 WMl6ktGbR2FDFE9PlXN1LavaeFaQf5S8U32RpFW4p0HVUM7yI8aq+QSWgxjqUSH8KCRbQFu9FMS
 jVU61WtRkBAogN8voO/GC33KfjIYu4tFhcu+gRG+oFQ==
X-Received: by 2002:a05:600c:5490:b0:3b4:8db0:54d7 with SMTP id
 iv16-20020a05600c549000b003b48db054d7mr5107006wmb.62.1664337787647; 
 Tue, 27 Sep 2022 21:03:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5xZYexFcBsYk6b0JjWdOi5XDG1biUEXSCrUXgghEnfzeKX/Tfylth1hVUyJoaXXB+5D2JL2Q==
X-Received: by 2002:a05:600c:5490:b0:3b4:8db0:54d7 with SMTP id
 iv16-20020a05600c549000b003b48db054d7mr5106986wmb.62.1664337787339; 
 Tue, 27 Sep 2022 21:03:07 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c4e8e00b003b47e75b401sm507557wmq.37.2022.09.27.21.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 21:03:06 -0700 (PDT)
Date: Wed, 28 Sep 2022 00:03:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH] virtio_pci: avoid to request intx irq if irq is zero
Message-ID: <20220928000228-mutt-send-email-mst@kernel.org>
References: <20220928035706.419-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20220928035706.419-1-angus.chen@jaguarmicro.com>
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

On Wed, Sep 28, 2022 at 11:57:06AM +0800, Angus Chen wrote:
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
> When the pci device is vf,the intx
> is not allowed and it will be 0.Even if the pci device is a pf,
> we should remind that
> irq 0 is almost be reserved or used for some device fixed


Where does it say irq 0 is reserved on all platforms?
I am not sure this is right.


> like timer in x86 without IRQF_SHARED,so we can avoid call it.
> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index ad258a9d3b9f..3208a2b149b9 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -362,6 +362,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i, err, queue_idx = 0;
>  
> +	if (vp_dev->pci_dev->irq == 0)
> +		return -EINVAL;
> +


Pls read the PCI spec:

Interrupt Pin
The Interrupt Pin register tells which interrupt pin the device (or device function) uses. A
value of 1 corresponds to INTA#. A value of 2 corresponds to INTB#. A value of 3
corresponds to INTC#. A value of 4 corresponds to INTD#. Devices (or device functions)
that do not use an interrupt pin must put a 0 in this register.


Please check vp_dev->pci_dev->pin accordingly.




>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
>  		return -ENOMEM;
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
