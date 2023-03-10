Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188E9C64EC4
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 08:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C2E840151;
	Fri, 10 Mar 2023 08:50:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C2E840151
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XqOAHipQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nze6aATDfF7o; Fri, 10 Mar 2023 08:50:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA7604014E;
	Fri, 10 Mar 2023 08:50:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CA7604014E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1183C0071;
	Fri, 10 Mar 2023 08:50:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBB9FC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 923F582115
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:50:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 923F582115
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XqOAHipQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7eK_5pKjou4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:50:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2C4382103
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2C4382103
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 08:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678438203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KelRWLQTWMjx8GcYyMjPPoMBBlYGGT9NTkc93ApFAc=;
 b=XqOAHipQLKW9/VHDUm/ygnzO0kd8YYeLtdzFTiSmS7WCmlcrAfN0yoGS7A4rubEcCe05cc
 NCRxq0Dqypj9EYnv1HbqCpv5pjHckWUnutRobvSfjuta261VA7vNH42VM5B9V1OSUSqwek
 gh3wgqIK6ymgLVB8hwzAPToGD5sIS90=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-988-wDYoOFO1WLGB0UuSVg-1; Fri, 10 Mar 2023 03:50:02 -0500
X-MC-Unique: 988-wDYoOFO1WLGB0UuSVg-1
Received: by mail-wm1-f72.google.com with SMTP id
 z6-20020a7bc7c6000000b003e0107732f4so1540975wmk.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 00:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678438201;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KelRWLQTWMjx8GcYyMjPPoMBBlYGGT9NTkc93ApFAc=;
 b=CQLtkjVkSd1OfFDzrrbOg5bzMqWlw65JTVohpLEWtsZmPkTdWMnM5BQnXlP00ETH3k
 AB8Sw7Wg2ugmop674VK5QdFKzBj9rMd1p25xdDeTTp4LsWjYwpn33VaGKhk2Wi7n8jrk
 DKIPwydir8ueZf09lmNpPdHV9HcIV8TDWpU/mAHhNSjFRJdB6X4PnVgaatYJFxEw4pr9
 4PoNGYtl4OuokEabtupXfflgXCemu4QpPgNlvs0FwA2T88FcKGVecu31oMxtX93zlZpg
 Sj242QklN6J4Z+zqVkyh3hmXU206vYZr7+prqjWgdf3NL0IoeK420RFZp99g5BsgJojH
 ZGyw==
X-Gm-Message-State: AO0yUKVoUcZqkd1zQy4g6J6Bv0RiL4h0lD8Vmbp69LwKYsWRYeaTAK+K
 Rt1KmuSBuqhIyWccbPP8AenjK8sGBbURn5vJAOJ2rRpFb6P2FdnKyq6Cwu9Ti6kpZNzzufKiAVe
 qxN+Yrvnf7NUgvIH/J+1QIjZYBPVBLkS6SyVl/nJpPg==
X-Received: by 2002:a5d:4892:0:b0:2c9:640f:635b with SMTP id
 g18-20020a5d4892000000b002c9640f635bmr14163895wrq.56.1678438201022; 
 Fri, 10 Mar 2023 00:50:01 -0800 (PST)
X-Google-Smtp-Source: AK7set9d+6elrGhQTW0gxJkTHKMPcUvYTIFaPaPg479KAOvU5rhCWCnoThdgBezbkiwy+Ifg/iNjqg==
X-Received: by 2002:a5d:4892:0:b0:2c9:640f:635b with SMTP id
 g18-20020a5d4892000000b002c9640f635bmr14163886wrq.56.1678438200746; 
 Fri, 10 Mar 2023 00:50:00 -0800 (PST)
Received: from redhat.com ([2.52.9.88]) by smtp.gmail.com with ESMTPSA id
 e36-20020a5d5964000000b002c3f81c51b6sm1560093wri.90.2023.03.10.00.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 00:50:00 -0800 (PST)
Date: Fri, 10 Mar 2023 03:49:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v3 00/11] VDUSE: Improve performance
Message-ID: <20230310034934-mutt-send-email-mst@kernel.org>
References: <20230228094110.37-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230228094110.37-1-xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de, hch@lst.de
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

On Tue, Feb 28, 2023 at 05:40:59PM +0800, Xie Yongji wrote:
> Hi all,
> 
> This series introduces some ways to improve VDUSE performance.


Pls fix warnings reported by 0-day infra, dropping this for now.


> Patch 1 ~ 6 bring current interrupt affinity spreading mechanism
> to vduse device and make it possible for the virtio-blk driver
> to build the blk-mq queues based on it. This would be useful to
> mitigate the virtqueue lock contention in virtio-blk driver. In
> our test, with those patches, we could get ~50% improvement (600k
> iops -> 900k iops) when using per-cpu virtqueue.
> 
> Patch 7 adds a sysfs interface for each vduse virtqueue to change
> the affinity for IRQ callback. It would be helpful for performance
> tuning when the affinity mask contains more than one CPU.
> 
> Patch 8 ~ 9 associate an eventfd to the vdpa callback so that
> we can signal it directly during irq injection without scheduling
> an additional workqueue thread to do that.
> 
> Patch 10, 11 add a sysfs interface to support specifying bounce
> buffer size in virtio-vdpa case. The high throughput workloads
> can benefit from it. And we can also use it to reduce the memory
> overhead for small throughput workloads.
> 
> Please review, thanks!
> 
> V2 to V3:
> - Rebased to newest kernel tree
> - Export group_cpus_evenly() instead of irq_create_affinity_masks() [MST]
> - Remove the sysfs for workqueue control [Jason]
> - Associate an eventfd to the vdpa callback [Jason]
> - Signal the eventfd directly in vhost-vdpa case [Jason]
> - Use round-robin to spread IRQs between CPUs in the affinity mask [Jason]
> - Handle the cpu hotplug case on IRQ injection [Jason]
> - Remove effective IRQ affinity and balance mechanism for IRQ allocation
> 
> V1 to V2:
> - Export irq_create_affinity_masks()
> - Add set/get_vq_affinity and set_irq_affinity callbacks in vDPA
>   framework
> - Add automatic irq callback affinity support in VDUSE driver [Jason]
> - Add more backgrounds information in commit log [Jason]
> - Only support changing effective affinity when the value is a subset
>   of the IRQ callback affinity mask
> 
> Xie Yongji (11):
>   lib/group_cpus: Export group_cpus_evenly()
>   vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
>   vdpa: Add set_irq_affinity callback in vdpa_config_ops
>   vduse: Refactor allocation for vduse virtqueues
>   vduse: Support automatic irq callback affinity
>   vduse: Support set/get_vq_affinity callbacks
>   vduse: Add sysfs interface for irq callback affinity
>   vdpa: Add eventfd for the vdpa callback
>   vduse: Signal interrupt's eventfd directly in vhost-vdpa case
>   vduse: Delay iova domain creation
>   vduse: Support specifying bounce buffer size via sysfs
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 490 +++++++++++++++++++++++++----
>  drivers/vhost/vdpa.c               |   2 +
>  drivers/virtio/virtio_vdpa.c       |  33 ++
>  include/linux/vdpa.h               |  25 ++
>  lib/group_cpus.c                   |   1 +
>  5 files changed, 488 insertions(+), 63 deletions(-)
> 
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
