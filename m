Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD913C4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 09:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31A0D40234;
	Thu, 10 Nov 2022 09:14:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31A0D40234
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkoocLIN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IhNOYu0cDGLp; Thu, 10 Nov 2022 09:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B781414E6;
	Thu, 10 Nov 2022 09:14:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B781414E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 268C0C0032;
	Thu, 10 Nov 2022 09:14:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEFC3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C939B40126
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:14:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C939B40126
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkoocLIN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sulQnE-xWbeu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:14:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06B23400BF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06B23400BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668071669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xcao/PqbCDd3mW4vvxXtcV3kVRYEc6SH+zTFTbxv0YQ=;
 b=QkoocLINRtTmXMAWossQvvRdnIeGThI7PJnybYwGgKxPBd+ieExtongDkKrGICDyAK7876
 y4Ja+5AvOV9TWXUun5UgeDfRpRDvz8Sdkwsuf1b/5SI1omzT3aAK+gnZvzwAvwstBnaJ9X
 VMsssG4eLfmuCxxAzro2d6E/LfdO8u0=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-442-lsT_sCgLM-ecWwMAbTU1sA-1; Thu, 10 Nov 2022 04:14:27 -0500
X-MC-Unique: lsT_sCgLM-ecWwMAbTU1sA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-13bce9d5633so768847fac.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 01:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xcao/PqbCDd3mW4vvxXtcV3kVRYEc6SH+zTFTbxv0YQ=;
 b=vBIG+DeBFKX3kjm5+sQ6AAbhcrBZxGGjffK9MfdZwv/MF6h1/ALq8r5YFxVDn1hhfo
 BkMwv6LNg9h0c1o2gH9HIMivi8F9Yr1JlKDj7bwfZGACyHCs3a8/jpbLIk+BmDJFzooy
 scJxgjNbZmRZ3vAkcKxH9mHbOnWfFIQfDuV37AXFaHiQplObusKUsWf+B/EqjBk28geZ
 IU1dU/nb88OxL+86mL63DmXwRRkgQ7XALNmNti4YtbNd/25z6ZqckWMG3pfWRn7JB0Hs
 rgYCBVHSu8w5ojm8UCP0BDEAzDVApmMicD03xvSZocOH5BLQVrTblLrsQ3om3qSdiA9u
 lo6A==
X-Gm-Message-State: ACrzQf0PfwQo/a/1X+o9iHbK6Mnha9SeADtpxVbZ845b1W3WG4kUhQQz
 Zt3lrkFGNxLIckPGIOmWu7CFVF3T+8HsdZAGA6Mst5Q66ShZLFdenuESFtbfSmaeC1H2aaPJQek
 /sr4hSrdcXwS2QejpAhTJ15VsaDzZMon67f+oNeFhQD+o0u+2UsGQ5cMdag==
X-Received: by 2002:a05:6870:9595:b0:132:7b3:29ac with SMTP id
 k21-20020a056870959500b0013207b329acmr1260432oao.35.1668071664155; 
 Thu, 10 Nov 2022 01:14:24 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7yhstRl6FSx3BzstYBqH9xt9jlKlqXg+p6H0IkT5AEZO+FdX25kmAF9Vd/tew9SdATkdsvQ79C+yUJ/ecZFhU=
X-Received: by 2002:a05:6870:9595:b0:132:7b3:29ac with SMTP id
 k21-20020a056870959500b0013207b329acmr1260423oao.35.1668071663899; Thu, 10
 Nov 2022 01:14:23 -0800 (PST)
MIME-Version: 1.0
References: <20221110082348.4105476-1-ruanjinjie@huawei.com>
In-Reply-To: <20221110082348.4105476-1-ruanjinjie@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Nov 2022 17:14:12 +0800
Message-ID: <CACGkMEvMuBge8LnQbdQHS86RVx8CkwSyMjR4md7Qs0uranTPuA@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa_sim: fix possible memory leak in
 vdpasim_net_init() and vdpasim_blk_init()
To: ruanjinjie <ruanjinjie@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 gautam.dawar@xilinx.com, elic@nvidia.com
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

On Thu, Nov 10, 2022 at 4:27 PM ruanjinjie <ruanjinjie@huawei.com> wrote:
>
> Inject fault while probing module, if device_register() fails in
> vdpasim_net_init() or vdpasim_blk_init(), but the refcount of kobject is
> not decreased to 0, the name allocated in dev_set_name() is leaked.
> Fix this by calling put_device(), so that name can be freed in
> callback function kobject_cleanup().
>
> (vdpa_sim_net)
> unreferenced object 0xffff88807eebc370 (size 16):
>   comm "modprobe", pid 3848, jiffies 4362982860 (age 18.153s)
>   hex dump (first 16 bytes):
>     76 64 70 61 73 69 6d 5f 6e 65 74 00 6b 6b 6b a5  vdpasim_net.kkk.
>   backtrace:
>     [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>     [<ffffffff81731d53>] kstrdup+0x33/0x60
>     [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>     [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>     [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>     [<ffffffffa0270013>] 0xffffffffa0270013
>     [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>     [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>     [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>     [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>     [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>     [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> (vdpa_sim_blk)
> unreferenced object 0xffff8881070c1250 (size 16):
>   comm "modprobe", pid 6844, jiffies 4364069319 (age 17.572s)
>   hex dump (first 16 bytes):
>     76 64 70 61 73 69 6d 5f 62 6c 6b 00 6b 6b 6b a5  vdpasim_blk.kkk.
>   backtrace:
>     [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>     [<ffffffff81731d53>] kstrdup+0x33/0x60
>     [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>     [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>     [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>     [<ffffffffa0220013>] 0xffffffffa0220013
>     [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>     [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>     [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>     [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>     [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>     [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> Fixes: 899c4d187f6a ("vdpa_sim_blk: add support for vdpa management tool")
> Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")
>
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v3:
> - add fix tag
> v2:
> - add fault inject message
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index c6db1a1baf76..f745926237a8 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -427,8 +427,10 @@ static int __init vdpasim_blk_init(void)
>         int ret;
>
>         ret = device_register(&vdpasim_blk_mgmtdev);
> -       if (ret)
> +       if (ret) {
> +               put_device(&vdpasim_blk_mgmtdev);
>                 return ret;
> +       }
>
>         ret = vdpa_mgmtdev_register(&mgmt_dev);
>         if (ret)
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index c3cb225ea469..11f5a121df24 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -305,8 +305,10 @@ static int __init vdpasim_net_init(void)
>         int ret;
>
>         ret = device_register(&vdpasim_net_mgmtdev);
> -       if (ret)
> +       if (ret) {
> +               put_device(&vdpasim_net_mgmtdev);
>                 return ret;
> +       }
>
>         ret = vdpa_mgmtdev_register(&mgmt_dev);
>         if (ret)
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
