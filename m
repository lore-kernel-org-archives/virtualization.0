Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C1C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 07:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7B8381496;
	Mon,  7 Nov 2022 07:42:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7B8381496
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HrCDpjAM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xx1Bi-kzXYOu; Mon,  7 Nov 2022 07:42:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3405D81469;
	Mon,  7 Nov 2022 07:42:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3405D81469
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1575DC0032;
	Mon,  7 Nov 2022 07:42:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7106C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AC0D60A99
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:41:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AC0D60A99
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HrCDpjAM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BSV344kTXeMx
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:41:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 82BFF60585
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82BFF60585
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667806916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vzzqd2jio4AZxTd7QQW36f88T5gwDOYUqqpTsVWYFf0=;
 b=HrCDpjAM3uu5/eO9OUQprJffXz09I61gaLgg0Zr2XEuwE1j81iOczfioQmczfQYa1yok0h
 SHqooVqK57vEiuR84KzlLqLYMc5b61j2E4usMbZ/1kexvxQ0Geb3gUfscSWqk6EdDCCLfJ
 7qp8lEEyWBaL4e4H51xNBfvO1v+A1Ag=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-WqI60U5aOW6rv0aiqZ9cqw-1; Mon, 07 Nov 2022 02:41:54 -0500
X-MC-Unique: WqI60U5aOW6rv0aiqZ9cqw-1
Received: by mail-ot1-f69.google.com with SMTP id
 s5-20020a9d7585000000b0066c7a3ddf59so5289129otk.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Nov 2022 23:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vzzqd2jio4AZxTd7QQW36f88T5gwDOYUqqpTsVWYFf0=;
 b=MYH9oE6QxSv08hybS/eKdtXjlr4oQBRCD8rMBxd6yC/peI8fOeDcTRSMh1URds0s38
 S7qXCRIYyeZnzaMR+mza22qUpZ5UHsLU+VsdAxe7m6QZCj8g1CSi7ZIsS35T771LfMgb
 msdnVXV0obhWUAeJ8+dpTu7NJaR1EfNnIM6TTRH1pT4rm6jZ/SvRqR7aZ61w13eapz9w
 x9G2VFtA4Zrea6pODric1Ib08WLgexWAGWPPqWSqZwUUVLSWVD7anM3bXKrJkjpSnRp3
 sojwXnpH0FtMsIy5lpMukeTO3pMHAbqxaqbQbB/QQjimLcbSYtIxAAH1wwj+4wx/p2u4
 eyQA==
X-Gm-Message-State: ACrzQf1OTM8mtyLXy/9ddQlzScYl3AqVybu3XCg/NwMoi/m2SZNjDjqJ
 6587e8o2Hl4HhvzujZaBKfBU2qtwK2qojL3yrBkmZqYsIWuCvq8CHqZwUUbxGvCISixPMqPdgyG
 uKPgjIJkynty8mRUO3C9ShqV87CreVNGj4OnVbB0Y9gDRXbaDRizsXKPjng==
X-Received: by 2002:a05:6830:16c5:b0:66c:6a63:dd4c with SMTP id
 l5-20020a05683016c500b0066c6a63dd4cmr16042113otr.201.1667806914252; 
 Sun, 06 Nov 2022 23:41:54 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7oOAV+uc9t7s8MBz7qTTD7zfFUiw34yn3qYUKtzP5s1gzgwMA5EfGWNJZz9lHNABJ/rakf5LO5N9ismitfWQ8=
X-Received: by 2002:a05:6830:16c5:b0:66c:6a63:dd4c with SMTP id
 l5-20020a05683016c500b0066c6a63dd4cmr16042098otr.201.1667806913996; Sun, 06
 Nov 2022 23:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20221104083423.2090463-1-ruanjinjie@huawei.com>
In-Reply-To: <20221104083423.2090463-1-ruanjinjie@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Nov 2022 15:41:42 +0800
Message-ID: <CACGkMEuxfB+9m1WW34L3sF6_F1iKCF9CSs9_P2V9jLh4sFXyAA@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: fix possible memory leak in vdpasim_net_init()
 and vdpasim_blk_init()
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

On Fri, Nov 4, 2022 at 4:41 PM ruanjinjie <ruanjinjie@huawei.com> wrote:
>
> If device_register() returns error in vdpasim_net_init() or
> vdpasim_blk_init(), name of kobject which is allocated in dev_set_name()
> called in device_add() is leaked.
>
> As comment of device_add() says, it should call put_device() to drop
> the reference count that was set in device_initialize() when it fails,
> so the name can be freed in kobject_cleanup().
>
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Should we have a fixes tag and cc stable?

Thanks

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
