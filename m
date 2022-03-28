Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E710C433EF
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 21:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A20760F4C;
	Mon, 28 Mar 2022 21:08:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4pezklLG8x0; Mon, 28 Mar 2022 21:08:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E5B760899;
	Mon, 28 Mar 2022 21:08:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 818C9C001D;
	Mon, 28 Mar 2022 21:08:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95AFDC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7604681313
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ixFSr7Q_RYn9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:08:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC867812DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 21:08:33 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id bg10so31227261ejb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gy52q0hk0EOe2yARL7BLFUrhC07yc/LGzLY5hvJWd9Q=;
 b=PspVM/NGsYmmepvwb7RIAfO4OVL1acnHrWJHnRYbUv5gXs6ulNmvXMW2TyCbx5Q7Yk
 RcTiAFURzmyQiGtT6oGZjLVWGifIlTDuAhMA1jenOe/Ptz3rorytIwMJ6Y9H0kribuVR
 NjaBTSekKRGEvfLcvBKtlgYJu4sjoYMv/TRgRND2J+PaeJymdZeJEpUm2ndWoLA12z6a
 0+BxKzfI8SwJ521yviTn1P6Xfn9uwZ9Dc2knM62zK++NGw1xu9YpOev6kwIoarH0ywVl
 C5/NNpMFgBtOIpU4gEwMOduyuUFvYSMvVNeWJBoPg0SXvoZ4uLz5BOXexjGT8HlcE05X
 kcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gy52q0hk0EOe2yARL7BLFUrhC07yc/LGzLY5hvJWd9Q=;
 b=GmYXI1dWil2lfASobZfT/lbWRBMcalxyzTBSg5pA8hukiue7B7aJk0WtD/YSl2ztiS
 giwJbKdqHZBKlJ/muEsFzWhKLK4waTdIkdXb/nalM/ZVW1Dsy+5oHedyUm1ylJ0xprvb
 FtuR6S0KEBZa5v/sJiXasSHL2gB1MtEHD5WYTEJE84U7XdRjWfonGKRJQHOJluIpZgWB
 B8s2a05ZByQt97T3Q5LKfIxg8wRMxeiYDOy7MVH4weUKH4wfT1DLkQv2GzrN3GhcG+j0
 UtWia3+scRfwD17EvMnb1psJTirzZKWRXHnLQFmozQmmkb7ZiIKQ9oFGebejv9Vn4dvQ
 B/+g==
X-Gm-Message-State: AOAM530GdpW6jLce2IjqnbgbwSBHHG6d00pW/gHdIZO+zW/+suahDCQ4
 H83fKkSxVHxipYzBJBmat9WuCiCSKJbApLcdJH8=
X-Google-Smtp-Source: ABdhPJzF/ITADHePLd7Kqd1BNDEpYjsT1pDu1lP5yP42YMsGsMH5XWm/84sNviYmE9deBAzqOUwNaIpmQ1r5e4feVGc=
X-Received: by 2002:a17:907:3e92:b0:6df:cb08:14f5 with SMTP id
 hs18-20020a1709073e9200b006dfcb0814f5mr31124556ejc.308.1648501711578; Mon, 28
 Mar 2022 14:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220327050945.1614-1-xiam0nd.tong@gmail.com>
In-Reply-To: <20220327050945.1614-1-xiam0nd.tong@gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Mon, 28 Mar 2022 14:08:20 -0700
Message-ID: <CAPaKu7Q54aumxEjih3v=xiW3NG7ct1O5UBzyqMQ0bug4svy-5g@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: fix a missing check to avoid NULL dereference
To: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, "open list:VIRTIO CORE,
 NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
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

On Sat, Mar 26, 2022 at 10:09 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> 'cache_ent' could be set NULL inside virtio_gpu_cmd_get_capset()
> and it will lead to a NULL dereference by a lately use of it
> (i.e., ptr = cache_ent->caps_cache). Fix it with a NULL check.
>
> Fixes: 62fb7a5e10962 ("virtio-gpu: add 3d/virgl support")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c708bab555c6..b0f1c4d8fd23 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -579,8 +579,10 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
>         spin_unlock(&vgdev->display_info_lock);
>
>         /* not in cache - need to talk to hw */
> -       virtio_gpu_cmd_get_capset(vgdev, found_valid, args->cap_set_ver,
> +       ret = virtio_gpu_cmd_get_capset(vgdev, found_valid, args->cap_set_ver,
>                                   &cache_ent);
> +       if (ret)
> +               return ret;
>         virtio_gpu_notify(vgdev);
>
>  copy_exit:
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> --
> 2.17.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
