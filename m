Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A777AC433EF
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 03:34:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA1B610A3
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 03:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4EA1B610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13A8780C9E;
	Tue,  7 Sep 2021 03:34:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LgQ7s2h9OrCg; Tue,  7 Sep 2021 03:34:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD96E80CB9;
	Tue,  7 Sep 2021 03:34:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83369C0011;
	Tue,  7 Sep 2021 03:34:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 900E5C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 03:34:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CB76402CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 03:34:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZCPLNJL7rYUU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 03:34:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F9DF40294
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 03:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630985638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qozqAbZdT8oBMXjzeSMRm8sIhkC+A5GlfcPc9QaFNI=;
 b=cafBvGanvahWRxZVKLP15TULtBqL1Grq63hE6MmvH18L7hRJoZpq8lcM6KxWUPdlZRVGFT
 Vl+9oowl056zgbNMUIfGb7O4nNJSUY+8dYzLy6kxKGnuZwZjcU1kNwBZJfCOylCGgwKpIF
 ucDLph8Kmt/n0ozCNAozVBw8e6xUhwQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-bZf3mP9xNaq6Tbxyv2ku9Q-1; Mon, 06 Sep 2021 23:33:57 -0400
X-MC-Unique: bZf3mP9xNaq6Tbxyv2ku9Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 x33-20020a0565121321b02903ac51262781so2080024lfu.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Sep 2021 20:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6qozqAbZdT8oBMXjzeSMRm8sIhkC+A5GlfcPc9QaFNI=;
 b=AFargHf5jdC+0qYl/v/nLsLiWpm33m4deJmeLXkGf2Dm0sI7eG1odqh7fW6gJjJ/rm
 L/wzzmaXfyQR7MvJdYAXwUGgwP2IFwNcuVAHhC17abnyr0JXoBIjUQxkkoKgP3OsRdiw
 lyKljG5aMwFCmKbZUMLOox4IgeDwOmDOAxJ6E6O3WA4Cc85MkXPcqYQ8BeUGze688Qsg
 yvMUCNDGCrargYASVzQhQD/StYZAS6jZW4QsYdKHnYPzoYKOdOYdMJNHodH5F//0ouqj
 z+Bv5ioCwICMt8nZguFuDI86eDHYWr0/6PMctUr7PlmpHujNOuV1+4rerxUQHTTVbHhE
 w37g==
X-Gm-Message-State: AOAM530/0AVo0CC19zagpWaSL9VForSEAdFl7MuE3GxVvsLOS87vCitZ
 tOFjqMUxSKYCDWFDQ45njq0a6wS9igmLTzqOEtT6aLcVHtw0dGhSreyZqopAdcji8Q1U2MSONgo
 yjy84okMjWv4zO2e89y4npqNFw96p1oZvF4/X909iUPolaab5g6MOAKah2Q==
X-Received: by 2002:a2e:7018:: with SMTP id l24mr13065597ljc.277.1630985636117; 
 Mon, 06 Sep 2021 20:33:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx69cexoVOtk0lchQNIoBgVFSKES0O/KRMCdMmYPZmDg7gnkeHxmIUhvWGG37UEAcsc08y7SEkZVfrGcXO8U2o=
X-Received: by 2002:a2e:7018:: with SMTP id l24mr13065585ljc.277.1630985635952; 
 Mon, 06 Sep 2021 20:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142158.181-1-xieyongji@bytedance.com>
In-Reply-To: <20210906142158.181-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Sep 2021 11:33:45 +0800
Message-ID: <CACGkMEuSFFvo=6DGKA-beUs0XZiWS3R+OpqcHa8eChf4twt+rQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: Cleanup the old kernel states after reset failure
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Mon, Sep 6, 2021 at 10:22 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> We should cleanup the old kernel states e.g. interrupt callback
> no matter whether the userspace handle the reset correctly or not
> since virtio-vdpa can't handle the reset failure now.
>
> Otherwise, the old state might be used after reset which might
> break something, e.g. the old interrupt callback might be triggered
> by userspace after reset, which can break the virtio device driver.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 59a93e5b967a..61695521066c 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -665,13 +665,11 @@ static void vduse_vdpa_set_config(struct vdpa_device *vdpa, unsigned int offset,
>  static int vduse_vdpa_reset(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -
> -       if (vduse_dev_set_status(dev, 0))
> -               return -EIO;
> +       int ret = vduse_dev_set_status(dev, 0);
>
>         vduse_dev_reset(dev);
>
> -       return 0;
> +       return ret;
>  }
>
>  static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> --
> 2.11.0
>

Acked-by: Jason Wang <jasowang@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
