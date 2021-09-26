Return-Path: <SRS0=w7gG=OQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF3C433EF
	for <virtualization@archiver.kernel.org>; Sun, 26 Sep 2021 02:28:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E78610C9
	for <virtualization@archiver.kernel.org>; Sun, 26 Sep 2021 02:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0E78610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CB256066C;
	Sun, 26 Sep 2021 02:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S6XB__aGGSTT; Sun, 26 Sep 2021 02:28:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 23ECE605DD;
	Sun, 26 Sep 2021 02:28:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08373C000F;
	Sun, 26 Sep 2021 02:28:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89BACC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 02:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BC14828F2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 02:28:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EisUKJtJsBI6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 02:28:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BED74828EF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 02:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632623302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6utoYXVl7KAFm6ihUESvH+1axyBhaT6x5d1Y0AFcQaM=;
 b=Bao6Hcw/CU2Y8OuaSeaxsPUPP7Yhh/GdPgxD09YD4NT/mMlbKflm4Bgt47LEXx8STZ1fVS
 MdI8jSsu3h3K1u8nTyYQcpVhWgkYPJvMMR+fNsh+lRcgFfNH/XX2cuNwVeY1a2tu1EF4Yc
 bDLSd0vpPF1RklaeA9/6Bb9E+VlSHJo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-YMa4JQtrPrOE8lFBRbpxrA-1; Sat, 25 Sep 2021 22:28:21 -0400
X-MC-Unique: YMa4JQtrPrOE8lFBRbpxrA-1
Received: by mail-lf1-f72.google.com with SMTP id
 r14-20020ac25c0e000000b003fc149ed50eso12878021lfp.11
 for <virtualization@lists.linux-foundation.org>;
 Sat, 25 Sep 2021 19:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6utoYXVl7KAFm6ihUESvH+1axyBhaT6x5d1Y0AFcQaM=;
 b=f/Wjlsby86HaK197D5bOZTkvd7M40txXUgh5WvfslHEfYbE+wROMXWRXm9ZB9tJMV3
 S3uY+Ep0VGqIoyIF/m6HZS0Sp7JI+zAXHdCL1iKHrKvN9snWqN7ZSPzoDwh85PYDhKGe
 IrtSjr45giVvbJf/sa0aUm34DoVh+rNEesWlKAkVXT9X2/PIhWmR90ddBKtfZBpHfXi4
 iqMitH0Yluzz2/JDXCbduk1gLd0MkqwrfACg2gxZ7S0p7CSQQ2L0Gz8YywZCly2nMrAv
 MA139yRZeu4o3XDRqRO8iLug39xtyHL0ZrWzYjjbLfrvHhA49dh/6eQSNQuTO4qTkofT
 4Kzg==
X-Gm-Message-State: AOAM5330tGgnPod7s/n8X7QG1w0IwvWyTmh/Qg1l0uFdfHL5xOj8Emim
 cWSNVdfH0LdeY6dHNMJYnz/8b5elf48uTGzSMe9YcbL7TM5Hw3k2LZ5oxjPY46kmQqgv0snh8KH
 UtOpRqpkXFAU3RHgZ2pXuhLBN//kGYE4d9us7nO0j4OyTa3OIcbf3zWDgKQ==
X-Received: by 2002:a05:6512:3b07:: with SMTP id
 f7mr16868081lfv.629.1632623299853; 
 Sat, 25 Sep 2021 19:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFmfr8++tInuLaUQfJ3BP2k9PHmPG0FAjACedaln0TG6qns+0LETxFXBJHNW8uOr5/lIHrtjG2y4Vas7upVd0=
X-Received: by 2002:a05:6512:3b07:: with SMTP id
 f7mr16868073lfv.629.1632623299625; 
 Sat, 25 Sep 2021 19:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210923075722.98-1-xieyongji@bytedance.com>
In-Reply-To: <20210923075722.98-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 26 Sep 2021 10:28:08 +0800
Message-ID: <CACGkMEvgom2033EKH=sAFc+dC-njzVXwTdZRaU5U7Ezzg86nWQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: Disallow injecting interrupt before DRIVER_OK is
 set
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Thu, Sep 23, 2021 at 3:57 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> The interrupt callback should not be triggered before DRIVER_OK
> is set. Otherwise, it might break the virtio device driver.
> So let's add a check to avoid the unexpected behavior.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 29a38ecba19e..972c13a7e5da 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -968,6 +968,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 break;
>         }
>         case VDUSE_DEV_INJECT_CONFIG_IRQ:
> +               ret = -EINVAL;
> +               if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +                       break;
> +

I wonder if we need any synchronization with set_status()?

Thanks

>                 ret = 0;
>                 queue_work(vduse_irq_wq, &dev->inject);
>                 break;
> @@ -1047,6 +1051,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>         case VDUSE_VQ_INJECT_IRQ: {
>                 u32 index;
>
> +               ret = -EINVAL;
> +               if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +                       break;
> +
>                 ret = -EFAULT;
>                 if (get_user(index, (u32 __user *)argp))
>                         break;
> --
> 2.11.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
