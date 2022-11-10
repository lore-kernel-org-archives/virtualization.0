Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401BAC4332F
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 08:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C185D818E8;
	Thu, 10 Nov 2022 08:02:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C185D818E8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SD2S+KXz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28dMAsLJL-lh; Thu, 10 Nov 2022 08:02:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F06181854;
	Thu, 10 Nov 2022 08:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F06181854
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30D6BC0032;
	Thu, 10 Nov 2022 08:02:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D40ACC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 08:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A01214014A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 08:02:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A01214014A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SD2S+KXz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n9RW3-IDgJkl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 08:02:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC933400AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC933400AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668067328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9i8OhydFba5DJ5WEoqEn0GpBo7XQiRyZXUoAQZSKXw=;
 b=SD2S+KXzKTPqcp7UWuS9T8PESR3rLMhNLFkNvD2gyB5Oz6DLS0BK8p2z3mTqfOz11ikTMS
 Uz2GVzf0h1JKa0XhiA/sVjmEIMCEyU0s2MJQHMK43g6xUQz3mCp/ud9InKYTU7XMbBNh9G
 77oomUAALvp1XMMloPBDwetLUvB/4x8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-150-lhg_SU1zOqC3kU2CDsmCFA-1; Thu, 10 Nov 2022 03:02:07 -0500
X-MC-Unique: lhg_SU1zOqC3kU2CDsmCFA-1
Received: by mail-pl1-f198.google.com with SMTP id
 q10-20020a170902f34a00b00186c5448b01so910685ple.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 00:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9i8OhydFba5DJ5WEoqEn0GpBo7XQiRyZXUoAQZSKXw=;
 b=VU8l/tR3fQadgYU0AavltnsJZEB9C91lOcG31xZmfxM4XZ8eOnoX6iyxO2SC8ancq3
 fwSi3bGH+qqK04LWzIGt3JCBX3FlXCKt6UfVQ/5RzH+IGRAXGE5NiqRSCLYL+jY31xSJ
 vGgApkRmyem5r2TyCRIPYrHELH9Iugdtz5SIhM/ek8sRT+af84e2f6Ve2x0fhlAf+hM2
 jrAgARyoWxzIg4dOYtF0QNYkTkyAd4oTJJP9oDEFAjF6smoBAkpd7xViJ2rMC1QYwziY
 h1QZ+Uz+X1hGc13aWY9aVM3CsQ2ngDk/RWKpeF71MXuzRTi9/uJAns9QeOB4hjAfQgUB
 Ny7A==
X-Gm-Message-State: ACrzQf0wm/PZjCyNQM1yfRXZBWBe06ol0cagVL3zCnVet4UGG3BvBBc7
 noV99xFH8pOzCdNHgm4xejyWdcISeLJd68naBdwYYIcGHbwUzomybX01BFNeZW8SLKJyQyNEuE4
 QfaY7PRYRS2BeMNWPiHb0Ouq2L1dbJdhyOrbrxtq90w==
X-Received: by 2002:a05:6a00:16c1:b0:563:177f:99ee with SMTP id
 l1-20020a056a0016c100b00563177f99eemr64280774pfc.7.1668067325729; 
 Thu, 10 Nov 2022 00:02:05 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5yslBGXty4dTanvbKMrVsTvIZV2WFd1TRSIO+dOGiek5G+4D1x1sy9QxNs7SJbmVNIyKMaXA==
X-Received: by 2002:a05:6a00:16c1:b0:563:177f:99ee with SMTP id
 l1-20020a056a0016c100b00563177f99eemr64280762pfc.7.1668067325347; 
 Thu, 10 Nov 2022 00:02:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 j12-20020a170902da8c00b0017eb2d62bbesm10572248plx.99.2022.11.10.00.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Nov 2022 00:02:04 -0800 (PST)
Date: Thu, 10 Nov 2022 09:01:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: ruanjinjie <ruanjinjie@huawei.com>
Subject: Re: [PATCH v2] vdpa_sim: fix possible memory leak in
 vdpasim_net_init() and vdpasim_blk_init()
Message-ID: <20221110080147.bpfumiab2yt7nehf@sgarzare-redhat>
References: <20221110050446.3932031-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221110050446.3932031-1-ruanjinjie@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 elic@nvidia.com, gautam.dawar@xilinx.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

On Thu, Nov 10, 2022 at 01:04:46PM +0800, ruanjinjie wrote:
>Inject fault while probing module, if device_register() fails in
>vdpasim_net_init() or vdpasim_blk_init(), but the refcount of kobject is
>not decreased to 0, the name allocated in dev_set_name() is leaked.
>Fix this by calling put_device(), so that name can be freed in
>callback function kobject_cleanup().
>
>(vdpa_sim_net)
>unreferenced object 0xffff88807eebc370 (size 16):
>  comm "modprobe", pid 3848, jiffies 4362982860 (age 18.153s)
>  hex dump (first 16 bytes):
>    76 64 70 61 73 69 6d 5f 6e 65 74 00 6b 6b 6b a5  vdpasim_net.kkk.
>  backtrace:
>    [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>    [<ffffffff81731d53>] kstrdup+0x33/0x60
>    [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>    [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>    [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>    [<ffffffffa0270013>] 0xffffffffa0270013
>    [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>    [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>    [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>    [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>    [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>    [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
>(vdpa_sim_blk)
>unreferenced object 0xffff8881070c1250 (size 16):
>  comm "modprobe", pid 6844, jiffies 4364069319 (age 17.572s)
>  hex dump (first 16 bytes):
>    76 64 70 61 73 69 6d 5f 62 6c 6b 00 6b 6b 6b a5  vdpasim_blk.kkk.
>  backtrace:
>    [<ffffffff8174f19e>] __kmalloc_node_track_caller+0x4e/0x150
>    [<ffffffff81731d53>] kstrdup+0x33/0x60
>    [<ffffffff83a5d421>] kobject_set_name_vargs+0x41/0x110
>    [<ffffffff82d87aab>] dev_set_name+0xab/0xe0
>    [<ffffffff82d91a23>] device_add+0xe3/0x1a80
>    [<ffffffffa0220013>] 0xffffffffa0220013
>    [<ffffffff81001c27>] do_one_initcall+0x87/0x2e0
>    [<ffffffff813739cb>] do_init_module+0x1ab/0x640
>    [<ffffffff81379d20>] load_module+0x5d00/0x77f0
>    [<ffffffff8137bc40>] __do_sys_finit_module+0x110/0x1b0
>    [<ffffffff83c4d505>] do_syscall_64+0x35/0x80
>    [<ffffffff83e0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
>Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>---
>v2:
>- add fault inject message
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 +++-
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 4 +++-
> 2 files changed, 6 insertions(+), 2 deletions(-)

Thanks for the v2 of this patch!
It LGTM, just a couple of comments about the submit process.

Usually when you get A-b R-b's and the patch doesn't change, it's better 
to bring them in later versions.

Also, we had suggested reporting the Fixes tag, because usually when we 
fix a bug it's good to identify which patch introduced the problem, so 
it's easier to backport this fix into stable versions of the kernel.
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes

In this case we should use the following tags:

Fixes: 899c4d187f6a ("vdpa_sim_blk: add support for vdpa management tool")
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

With them:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
