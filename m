Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43618C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:22:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE43960EBC
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 02:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE43960EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D11140322;
	Mon, 25 Oct 2021 02:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Zper4qChW61; Mon, 25 Oct 2021 02:22:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2E23C40310;
	Mon, 25 Oct 2021 02:22:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA7EC0012;
	Mon, 25 Oct 2021 02:22:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1F66C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A2D440312
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6BoYDxODy1ta
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:22:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56E4340310
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635128564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KyuFm/8mAjQNFS23VkPEB01/D6yLisum1kkP7ofok3s=;
 b=Kv0lQB43fLy35kR/sL0J/s64m4O50XT06yN8zt/f0pySYsF5U6FZF+PJn/32I0odkOm1zt
 5AbtwnHrrmkRAJHDxPth3xL0/Dst91pW611cIhGZ6UWXK8ZFcTlN31Yn+jurl0IKo42tDQ
 XcxNmop3I1SM0Zv5rFhEDtWnu3SGOAo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-QkE3fjY9PJS9iRkuvF_oIg-1; Sun, 24 Oct 2021 22:22:42 -0400
X-MC-Unique: QkE3fjY9PJS9iRkuvF_oIg-1
Received: by mail-lj1-f198.google.com with SMTP id
 f13-20020a05651c02cd00b00210dee0c36eso2238285ljo.23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 19:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KyuFm/8mAjQNFS23VkPEB01/D6yLisum1kkP7ofok3s=;
 b=Lk+2RT/rY42Odkqw49ddUwK0pWoyWxEDn0kNgJ2x981EiqX6h5EvZ27nYTCPrm7YWf
 r7XbUMcPuyv12LJ5mRrQhdztvcdwAy2RIDPKf6Gb46mPWkkeG2qamI1ucy6sZv2JuFzk
 px3nRgPETPd9o7/q0sdXDltJAXOh6ll+yWMqY6OhyWhBFu64bT3mhUFvoI5ovNykTd1N
 IjXTukprJs1CXS6GLNLFDJ9VJUXLYQHzzjVdzAnkjohr3IvwM2wUi7l7GSE9ZHwN+G/+
 BQ1YpU7bcwLMdI8xjBC0PkCw4SyaD1zR4qCN9Fy6bofQc6sVjNlYqNsQUugA3pEc1xjb
 sjvQ==
X-Gm-Message-State: AOAM5319PD29KLk3CgpKLFOLCVjrprxOzrPEVgD1WLA/vL0Q/6LWbFq9
 UGiwW9b/5mxOSCRvCXzVe3CjQvVpEfIiP5m/Wc+LeXGXm+7D0oUZkm+t1S/h8nycZBAHadWUz3s
 XgXU9h0HgxFPVfcYm0BQsI2sHY1M1AR/CsMNqE/dGVA3+MeE0MrdgT4qSJQ==
X-Received: by 2002:a2e:7105:: with SMTP id m5mr16376148ljc.420.1635128561275; 
 Sun, 24 Oct 2021 19:22:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4utO5eZEoQTVrJtOjRrLjeX8X5Tdh3Qp+l8Pwh0LwpxH7OqWbDoVbH0crY/JRbeIOJQoAgUe2Ap4AeHH6X0s=
X-Received: by 2002:a2e:7105:: with SMTP id m5mr16376134ljc.420.1635128561062; 
 Sun, 24 Oct 2021 19:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com>
 <c75b4499f7ead922daa19bf67b32eed6f185d260.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <c75b4499f7ead922daa19bf67b32eed6f185d260.1634870456.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Oct 2021 10:22:30 +0800
Message-ID: <CACGkMEtNECAUtpEvLvEpTFKfbYRC7YQKnHDnjxR3k9Hap1tmig@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] virtio_vdpa: setup correct vq size with callbacks
 get_vq_num_{max, min}
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Fri, Oct 22, 2021 at 10:45 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> For the devices which implement the get_vq_num_min callback, the driver
> should not negotiate with virtqueue size with the backend vdpa device if
> the value returned by get_vq_num_min equals to the value returned by
> get_vq_num_max.
> This is useful for vdpa devices based on legacy virtio specfication.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_vdpa.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 72eaef2caeb1..e42ace29daa1 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -145,7 +145,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>         /* Assume split virtqueue, switch to packed if necessary */
>         struct vdpa_vq_state state = {0};
>         unsigned long flags;
> -       u32 align, num;
> +       u32 align, max_num, min_num = 0;
> +       bool may_reduce_num = true;
>         int err;
>
>         if (!name)
> @@ -163,22 +164,32 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>         if (!info)
>                 return ERR_PTR(-ENOMEM);
>
> -       num = ops->get_vq_num_max(vdpa);
> -       if (num == 0) {
> +       max_num = ops->get_vq_num_max(vdpa);
> +       if (max_num == 0) {
>                 err = -ENOENT;
>                 goto error_new_virtqueue;
>         }
>
> +       if (ops->get_vq_num_min)
> +               min_num = ops->get_vq_num_min(vdpa);
> +
> +       may_reduce_num = (max_num == min_num) ? false : true;
> +
>         /* Create the vring */
>         align = ops->get_vq_align(vdpa);
> -       vq = vring_create_virtqueue(index, num, align, vdev,
> -                                   true, true, ctx,
> +       vq = vring_create_virtqueue(index, max_num, align, vdev,
> +                                   true, may_reduce_num, ctx,
>                                     virtio_vdpa_notify, callback, name);
>         if (!vq) {
>                 err = -ENOMEM;
>                 goto error_new_virtqueue;
>         }
>
> +       if (virtqueue_get_vring_size(vq) < min_num) {
> +               err = -EINVAL;
> +               goto err_vq;
> +       }

I wonder under which case can we hit this?

Thanks

> +
>         /* Setup virtqueue callback */
>         cb.callback = virtio_vdpa_virtqueue_cb;
>         cb.private = info;
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
