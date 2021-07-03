Return-Path: <SRS0=GbdO=L3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45090C07E97
	for <virtualization@archiver.kernel.org>; Sat,  3 Jul 2021 08:31:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE51613C9
	for <virtualization@archiver.kernel.org>; Sat,  3 Jul 2021 08:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE51613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7470040E59;
	Sat,  3 Jul 2021 08:31:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8NoKhkedJGKl; Sat,  3 Jul 2021 08:31:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8FE6402DB;
	Sat,  3 Jul 2021 08:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5143C001A;
	Sat,  3 Jul 2021 08:31:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31164C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0634A42483
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F2CFILdPObJT
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:31:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F5564247F
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jul 2021 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625301071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A5pLvLjSYytl9fxuQeHwRO0qsjIw9mqvaKkb7Y9O3i8=;
 b=OM8Xesgo2gzvEtyKXLIpGN3qSWG7LbUwIjQ5hWgOLAJd5UIoGuI/J0hb5Rl/5CUbvgbFLd
 +wmfzOH1nZJ0f86yHYB95iS2+EtgYq5q32JCZA9+34LMD0PEnEafPTC5WfXPMMfR/D1+UD
 cqYLH+X8vDgOVmyeopAd6rWyqeOjRSE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-HjuLD6JPPnWNj91U4q2nLw-1; Sat, 03 Jul 2021 04:31:10 -0400
X-MC-Unique: HjuLD6JPPnWNj91U4q2nLw-1
Received: by mail-wm1-f69.google.com with SMTP id
 j38-20020a05600c1c26b02901dbf7d18ff8so7497888wms.8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 03 Jul 2021 01:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A5pLvLjSYytl9fxuQeHwRO0qsjIw9mqvaKkb7Y9O3i8=;
 b=TO0mRBv6M5KX5JUBqW9VKq2sUpisRp06fp8NfaOh/1DMdejrpEJkBsTg6Q9019eSvu
 W51kdLJpHnmVfaNnehkKW9fsNjxKCiEhkiz+Iit+VLyXW8WNASyf/XpWkkB3IJN3ojlR
 cLxs5y+5zMpm3E/omDPGh3KANqM+ahmDiagl2nE9gsXfWE8e7U3zghAYTuIhyanr1IkH
 WeQgXBleaZ3xUv67HU3IOwB5XVPezUdpxPJoi8mtaTCH94skbsVtxq2ePTk5pbMO6XaN
 FUfnl0W/ediW4ki64/mCGhzB67tfSg0TuDyfCUzbv6heAbt/zOp8kS2yJuWmluOy5j9Q
 UJiQ==
X-Gm-Message-State: AOAM532Y2Zqfl6aCBknbPq5h8bfVOeTMx2wUp8yq3vx8nRgHvQK/vjvb
 wVYFIjm8bTnA0yrHeTJbUelF6133XN903mkjV67TrWgK3nmqQYWKJEz/PXk7njxtsOVuI+WY72y
 g0l7GNGg76ucbcc1Gxn70jEKulYIDUyB74LvExkyFrw==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr3900757wmk.17.1625301069177; 
 Sat, 03 Jul 2021 01:31:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrvv4LtZcQ7zdL29oxvTkKz5qNfM0qWp0wXMltlMPDTMTgPHfjYLGKI6BE2STBxqHT1590MA==
X-Received: by 2002:a05:600c:296:: with SMTP id
 22mr3900747wmk.17.1625301069032; 
 Sat, 03 Jul 2021 01:31:09 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id k5sm5943632wmk.11.2021.07.03.01.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jul 2021 01:31:08 -0700 (PDT)
Date: Sat, 3 Jul 2021 04:31:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: He Zhe <zhe.he@windriver.com>
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20210703043039-mutt-send-email-mst@kernel.org>
References: <CACycT3t1Dgrzsr7LbBrDhRLDa3qZ85ZOgj9H7r1fqPi-kf7r6Q@mail.gmail.com>
 <20210618084412.18257-1-zhe.he@windriver.com>
MIME-Version: 1.0
In-Reply-To: <20210618084412.18257-1-zhe.he@windriver.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 christian.brauner@canonical.com, qiang.zhang@windriver.com, corbet@lwn.net,
 willy@infradead.org, hch@infradead.org, xieyongji@bytedance.com,
 dan.carpenter@oracle.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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

On Fri, Jun 18, 2021 at 04:44:12PM +0800, He Zhe wrote:
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than zero, to avoid potential deadlock and stack
> overflow.
> 
> However sometimes different eventfds may be used in parallel. Specifically,
> when heavy network load goes through kvm and vhost, working as below, it
> would trigger the following call trace.
> 
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
> 
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
> 
> This patch enlarges the limit to 1 which is the maximum recursion depth we
> have found so far.
> 
> The credit of modification for eventfd_signal_count goes to
> Xie Yongji <xieyongji@bytedance.com>
> 

And maybe:

Fixes: b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")

who's merging this?

> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  fs/eventfd.c            | 3 ++-
>  include/linux/eventfd.h | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index e265b6dd4f34..add6af91cacf 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -71,7 +71,8 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>  	 * it returns true, the eventfd_signal() call should be deferred to a
>  	 * safe context.
>  	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count) >
> +	    EFD_WAKE_COUNT_MAX))
>  		return 0;
>  
>  	spin_lock_irqsave(&ctx->wqh.lock, flags);
> diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
> index fa0a524baed0..74be152ebe87 100644
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -29,6 +29,9 @@
>  #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
>  #define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
>  
> +/* This is the maximum recursion depth we find so far */
> +#define EFD_WAKE_COUNT_MAX 1
> +
>  struct eventfd_ctx;
>  struct file;
>  
> @@ -47,7 +50,7 @@ DECLARE_PER_CPU(int, eventfd_wake_count);
>  
>  static inline bool eventfd_signal_count(void)
>  {
> -	return this_cpu_read(eventfd_wake_count);
> +	return this_cpu_read(eventfd_wake_count) > EFD_WAKE_COUNT_MAX;
>  }
>  
>  #else /* CONFIG_EVENTFD */
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
