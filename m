Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC38C07E9D
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 20:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 21E3D40167;
	Tue, 27 Sep 2022 20:47:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21E3D40167
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B+xXsn6a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yy749J7atmKt; Tue, 27 Sep 2022 20:47:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 178C1400DA;
	Tue, 27 Sep 2022 20:47:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 178C1400DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE53CC0033;
	Tue, 27 Sep 2022 20:47:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 807F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 20:47:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54CD381446
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 20:47:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54CD381446
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B+xXsn6a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CFmTUGQAwRIB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 20:47:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05CF181443
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05CF181443
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 20:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664311648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+doqp2PWkPaWef/nK0555GwMqR1Pj4yFwRvcRH93o04=;
 b=B+xXsn6a4BZUOVIVWmipx7jNKaMG7aIlGRehtQp1XR0oAGVXEMPxYykQDVwjPN/p050r63
 jbdPIf6owVHSxt644Yi8+IXqwmj884h0u8eOjubH7mFr8j8LjT7bkh1DkyBI6ynFfIJ1BM
 85QIbUDJnOicfoD7/6LCXNbAkTMjeoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-PU3iq8QXMO-sXCalGc0d2w-1; Tue, 27 Sep 2022 16:47:27 -0400
X-MC-Unique: PU3iq8QXMO-sXCalGc0d2w-1
Received: by mail-wm1-f72.google.com with SMTP id
 p24-20020a05600c1d9800b003b4b226903dso9123312wms.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 13:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=+doqp2PWkPaWef/nK0555GwMqR1Pj4yFwRvcRH93o04=;
 b=pF7/3lcCDQgVunXtomkzTIThJW7vdrlhJhnN9h9IlNln5TZ2vp46FWiunP/Bs3hqKL
 nvmPxujqHJz3r/1joiolIKLSPYFPeMpVl0h1+Qfjf+79SEIqNBxxX1jZNRDTdgYVcho7
 qCKpUHeW9nPzDt2tZQgD5whbwtBwQCSS+9/ox3N48YJ2pcGKu/g4xTxTgdgrkCxVyF5p
 6n2jA1WMekNJQmxyls2XGnHW7TnCtKAW9Qh65Ik6wmHni0adcvfLXDdfDfnCS2r8Nt4z
 EOGamSfVs2ky4ai3ATwsDbXx7DuhAsOhBcw3pOe4mB5vOMrN4hcKl41ZhceCuog1MBio
 mvOA==
X-Gm-Message-State: ACrzQf1+zAWbctUwVkRHlp5Zksk8ysinKbIcCBhblM4jpMsTkczxb6EF
 XHY04Yz5xVHIYtTMh5whTKcHKEltPNPQMNGsv90xA5eEoPHU89I8dUhMDS4AyllAld3Z1Jz7RHf
 PmgT81OJWMcclS0+jjed2WiVOhwcodRsYhinK6MFUAg==
X-Received: by 2002:a5d:4741:0:b0:22c:c1a2:812d with SMTP id
 o1-20020a5d4741000000b0022cc1a2812dmr2792101wrs.220.1664311645775; 
 Tue, 27 Sep 2022 13:47:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5bYMVR2w3eieGGL9lQFZMOQ2OqTGSRs+aC998aQOq6zhwWnATJ4jozbFIhU5o1210eApxqrQ==
X-Received: by 2002:a5d:4741:0:b0:22c:c1a2:812d with SMTP id
 o1-20020a5d4741000000b0022cc1a2812dmr2792088wrs.220.1664311645460; 
 Tue, 27 Sep 2022 13:47:25 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c414900b003b4e009deb2sm3189435wmm.41.2022.09.27.13.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Sep 2022 13:47:24 -0700 (PDT)
Date: Tue, 27 Sep 2022 16:47:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH v1] virtio_blk: should not use IRQD_AFFINITY_MANAGED in
 init_rq
Message-ID: <20220927163723-mutt-send-email-mst@kernel.org>
References: <20220924034854.323-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
In-Reply-To: <20220924034854.323-1-angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 Liming Wu <liming.wu@jaguarmicro.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com, Christoph Hellwig <hch@lst.de>
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

On Sat, Sep 24, 2022 at 11:48:54AM +0800, Angus Chen wrote:
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
> After I did some work of this stack,took stap and crash to get more
> information,I found that the auto irq_affinity affect this.
> When "vp_find_vqs" call "vp_find_vqs_msix" failed,it will be go back
> to call vp_find_vqs_msix again with ctx be false, and when it failed again,
> we will call vp_find_vqs_intx,if the vp_dev->pci_dev->irq is zero,
> we will get a backtrace like above.
> 
> The log :
> "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> was print because of the irq 0 is used by timer exclusive,and when
> vp_find_vqs called vp_find_vqs_msix and return false twice,then it will
> call vp_find_vqs_intx for the last try.
> Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> flag IRQF_SHARED.

First this is a bug. We can fix that so it will fail more cleanly.

We should check pci_dev->pin and if 0 do not try to use INT#x
at all.
It will still fail, just with a nicer backtrace.




> without config CONFIG_GENERIC_IRQ_DEBUGFS,
> I found that we called vp_find_vqs_msix failed twice because of
> the irq resource was exhausted.

I see. I don't know enough about how this work, but roughly
I think the issue is at a high level

- because of auto affinity, we try to reserve an interrupt on all CPUs
- as there are 512 devices with a single vector per VQ we would
  have no issue as they would be spread between CPUs,
  but allocating on all CPUs fails.


I don't think the issue should be fixed at blk level - it is not
blk specifix - but yes this looks like a problem.
Christoph, any idea?



> crash> irq_domain.name,parent 0xffff9bff87d4dec0
>   name = 0xffff9bff87c1fd60 "INTEL-IR-MSI-1-2"
>   parent = 0xffff9bff87400000
> crash> irq_domain.name,parent 0xffff9bff87400000
>   name = 0xffff9bff87c24300 "INTEL-IR-1"
>   parent = 0xffff9bff87c6c900
> crash> irq_domain.name,parent 0xffff9bff87c6c900
>   name = 0xffff9bff87c3ecd0 "VECTOR"
>   parent = 0x0----------------------the highest level
> 
> and stap irq_matrix_alloc_managed get return value -ENOSPC.
> 
> When no virtio_blk device probe,the vctor_matrix is:
> crash>  p *vector_matrix
> $1 = {
>   matrix_bits = 256,
>   alloc_start = 32,
>   alloc_end = 236,
>   alloc_size = 204,
>   global_available = 15593,
>   global_reserved = 149,
>   systembits_inalloc = 3,
>   total_allocated = 409,
>   online_maps = 80,
>   maps = 0x2ff20,
>   scratch_map = {1161063342014463, 0, 1, 18446726481523507200,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
>   system_map = {1125904739729407, 0, 1, 18446726481523507200,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
> }
> 
> When the dump stack occur,the vector_matrix of system is exhausted.
> crash> p *vector_matrix
> $82 = {
>   matrix_bits = 256,
>   alloc_start = 32,
>   alloc_end = 236,
>   alloc_size = 204,
>   global_available = 0,//caq:irq left
>   global_reserved = 151,
>   systembits_inalloc = 3,
>   total_allocated = 1922,//caq:irq that allocated
>   online_maps = 80,
>   maps = 0x2ff20,
>   scratch_map = {18446744069952503807, 18446744073709551615,
>  18446744073709551615, 18446735277616529407, 0, 0, 0, 0, 0,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
>   system_map = {1125904739729407, 0, 1, 18446726481523507200,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
> }
> 
> And we tested the virtio_blk device which request irq success,
> we found that in a system with 80 cores and two numa ,one
> virtio_blk device with just two data queues consume 81 irqs capacity,
> Although it just only three irqs in /proc/interrupt,80 irqs capacity 
> is effected by function "irq_build_affinity_masks" with 2*40.
> 
> before one virtio_blk device hotplug out:
> crash> p *vector_matrix
> $2 = {
>   matrix_bits = 256,
>   alloc_start = 32,
>   alloc_end = 236,
>   alloc_size = 204,
>   global_available = 15215,
>   global_reserved = 150,
>   systembits_inalloc = 3,
>   total_allocated = 553,
>   online_maps = 80,
>   maps = 0x2ff20,
>   scratch_map = {1179746449752063, 0, 1, 18446726481523507200, 0, 0, 0,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
>  0, 0, 0, 0, 0},
>   system_map = {1125904739729407, 0, 1, 18446726481523507200, 0, 0, 0,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  0, 0, 0, 0, 0}
> }
> 
> after one virtio_blk device hotplug out:
> crash> p *vector_matrix
> $3 = {
>   matrix_bits = 256,
>   alloc_start = 32,
>   alloc_end = 236,
>   alloc_size = 204,
>   global_available = 15296,---it increase 81,include 1 config irq.
>   global_reserved = 150,
>   systembits_inalloc = 3,
>   total_allocated = 550,------it just decrease 3.
>   online_maps = 80,
>   maps = 0x2ff20,
>   scratch_map = {481036337152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  0, 0, 0, 0},
>   system_map = {1125904739729407, 0, 1, 18446726481523507200, 0, 0, 0,
>  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>  0, 0, 0, 0, 0}
> }
> 
> We test the new kernel also,it occur the same result.
> [Fri Sep 23 04:51:42 2022] genirq: Flags mismatch irq 0. 00000080 (virtio608) vs. 00015a00 (timer)
> [Fri Sep 23 04:51:42 2022] CPU: 0 PID: 5749 Comm: kworker/0:0 Kdump: loaded Tainted: G        W  OE      6.0.0-rc6+ #5
> [Fri Sep 23 04:51:42 2022] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS 4.1.19 06/16/2021
> [Fri Sep 23 04:51:42 2022] Workqueue: events work_for_cpu_fn
> [Fri Sep 23 04:51:42 2022] Call Trace:
> [Fri Sep 23 04:51:42 2022]  <TASK>
> [Fri Sep 23 04:51:42 2022]  dump_stack_lvl+0x33/0x46
> [Fri Sep 23 04:51:42 2022]  __setup_irq+0x705/0x770
> [Fri Sep 23 04:51:42 2022]  request_threaded_irq+0x109/0x170
> [Fri Sep 23 04:51:42 2022]  vp_find_vqs+0xc4/0x190
> [Fri Sep 23 04:51:42 2022]  init_vqs+0x348/0x580 [virtio_net]
> [Fri Sep 23 04:51:42 2022]  virtnet_probe+0x54d/0xa80 [virtio_net]
> [Fri Sep 23 04:51:42 2022]  virtio_dev_probe+0x19c/0x240
> [Fri Sep 23 04:51:42 2022]  really_probe+0x106/0x3e0
> [Fri Sep 23 04:51:42 2022]  ? pm_runtime_barrier+0x4f/0xa0
> [Fri Sep 23 04:51:42 2022]  __driver_probe_device+0x79/0x170
> [Fri Sep 23 04:51:42 2022]  driver_probe_device+0x1f/0xa0
> [Fri Sep 23 04:51:42 2022]  __device_attach_driver+0x85/0x110
> [Fri Sep 23 04:51:42 2022]  ? driver_allows_async_probing+0x60/0x60
> [Fri Sep 23 04:51:42 2022]  ? driver_allows_async_probing+0x60/0x60
> [Fri Sep 23 04:51:42 2022]  bus_for_each_drv+0x67/0xb0
> [Fri Sep 23 04:51:42 2022]  __device_attach+0xe9/0x1b0
> [Fri Sep 23 04:51:42 2022]  bus_probe_device+0x87/0xa0
> [Fri Sep 23 04:51:42 2022]  device_add+0x59f/0x950
> [Fri Sep 23 04:51:42 2022]  ? dev_set_name+0x4e/0x70
> [Fri Sep 23 04:51:42 2022]  register_virtio_device+0xac/0xf0
> [Fri Sep 23 04:51:42 2022]  virtio_pci_probe+0x101/0x170
> [Fri Sep 23 04:51:42 2022]  local_pci_probe+0x42/0xa0
> [Fri Sep 23 04:51:42 2022]  work_for_cpu_fn+0x13/0x20
> [Fri Sep 23 04:51:42 2022]  process_one_work+0x1c2/0x3d0
> [Fri Sep 23 04:51:42 2022]  ? process_one_work+0x3d0/0x3d0
> [Fri Sep 23 04:51:42 2022]  worker_thread+0x1b9/0x360
> [Fri Sep 23 04:51:42 2022]  ? process_one_work+0x3d0/0x3d0
> [Fri Sep 23 04:51:42 2022]  kthread+0xe6/0x110
> [Fri Sep 23 04:51:42 2022]  ? kthread_complete_and_exit+0x20/0x20
> [Fri Sep 23 04:51:42 2022]  ret_from_fork+0x1f/0x30
> [Fri Sep 23 04:51:42 2022]  </TASK>
> [Fri Sep 23 04:51:43 2022] virtio_net: probe of virtio608 failed with error -16
> 
> Fixes: ad71473d9c43 ("virtio_blk: use virtio IRQ affinity")
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Tested-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  drivers/block/virtio_blk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index a8bcf3f664af..075de30a9bb4 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -513,7 +513,6 @@ static int init_vq(struct virtio_blk *vblk)
>  	struct virtqueue **vqs;
>  	unsigned short num_vqs;
>  	struct virtio_device *vdev = vblk->vdev;
> -	struct irq_affinity desc = { 0, };
>  
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
>  				   struct virtio_blk_config, num_queues,
> @@ -548,7 +547,7 @@ static int init_vq(struct virtio_blk *vblk)
>  	}
>  
>  	/* Discover virtqueues and write information to configuration.  */
> -	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
> +	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, NULL);
>  	if (err)
>  		goto out;
>  
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
