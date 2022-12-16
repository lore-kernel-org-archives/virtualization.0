Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C914C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 03:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23632400D1;
	Fri, 16 Dec 2022 03:58:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23632400D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5FGe97I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WEuJePxY7nl1; Fri, 16 Dec 2022 03:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 81D744018A;
	Fri, 16 Dec 2022 03:58:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81D744018A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 595FDC0033;
	Fri, 16 Dec 2022 03:58:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A960C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C4FD41BAF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:58:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C4FD41BAF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5FGe97I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EcD4Qapgx1KE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:58:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69BBD41BAE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69BBD41BAE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671163108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZDZbw5KBbPfiS0aQTncakmGLck0pebaODb2v7fHtSkU=;
 b=K5FGe97IkNjfXBTxF0LGNcaYuRAQXLRE2YGPtaytDeklxN0OjL/Eg97aGBLesHMsClLcYU
 mEsqk0VIma13L3cMXeSmNeOecdg96LnFFbEckTrFK8R6tlkKFEiONYgMXuyxlmgfjlh58E
 1ZMQ4dcRsWgsTS52NBX3ceQTQTxOy3s=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-RCrQ8BLLPCKzn0UN6w8bTg-1; Thu, 15 Dec 2022 22:58:26 -0500
X-MC-Unique: RCrQ8BLLPCKzn0UN6w8bTg-1
Received: by mail-oo1-f70.google.com with SMTP id
 c6-20020a4ad206000000b004a33f36aa4dso644979oos.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 19:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZDZbw5KBbPfiS0aQTncakmGLck0pebaODb2v7fHtSkU=;
 b=cpzrkx1CAMHEGaM3FIlBeR5TopgBrkUy3YpwOHhivP3OqoHtSBkUrPcowOg7jj5vY3
 sMsx6Jeb9OM2JYjYO0m0zvgkX6pnOQIPkVt4NBDhDVgDu9t/cYv+n4If7EPI+b5xOTvD
 whOyg+d0Ec6pZGv560CidKl7A/Lq//SV+lqh45rx9TdZ1LbYVEPOuBqHSAcJOkZZJ672
 Cljs91fZD7nBRNqkMpt/2VmFV5Ply6iZBSRLkfYJB7du8TiBgBTC/JILLZeU4vwooqBl
 gWp/M+HnVWufTqwHIPm2XIRCjqM9SXsEhxc1yECgf5xYXl8lZALe5ORpJW8VgzSf+cC6
 r9hQ==
X-Gm-Message-State: ANoB5pmwIXkHczZSqCY49K4MspSuyaQXSd3QkEbpFpnzVdD6oocTifPV
 GTsANpAgUKdunphdr72tnEgWptVKM7bm6KG87IUwqSdldgHmXh9hi6gTo25HN5WwiLVw7IdCHt6
 sKQaemPo6j4+7mM7l3pVDTQH8dahP4QEHCMHkXFUFzobVCwx9ffY9PDntAQ==
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr321072oab.35.1671163106200; 
 Thu, 15 Dec 2022 19:58:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7cNko4F3UygPQf9wPv8PFtFKeyAZAHrVVoEXi20rnQdjjtfEEnI4fzMXo4e3lRKZM1aSUXRIBpmnGfmOssvfY=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr321067oab.35.1671163106015; Thu, 15
 Dec 2022 19:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-4-xieyongji@bytedance.com>
In-Reply-To: <20221205084127.535-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 11:58:15 +0800
Message-ID: <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in
 vdpa_config_ops
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces set_irq_affinity callback in
> vdpa_config_ops so that vdpa device driver can
> get the interrupt affinity hint from the virtio
> device driver. The interrupt affinity hint would
> be needed by the interrupt affinity spreading
> mechanism.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/virtio/virtio_vdpa.c | 4 ++++
>  include/linux/vdpa.h         | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 08084b49e5a1..4731e4616ee0 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
>         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>         const struct vdpa_config_ops *ops = vdpa->config;
> +       struct irq_affinity default_affd = { 0 };
>         struct vdpa_callback cb;
>         int i, err, queue_idx = 0;
>
> +       if (ops->set_irq_affinity)
> +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);

I wonder if we need to do this in vhost-vDPA. Or it's better to have a
default affinity by the vDPA parent itself.

(Looking at virtio-pci, it doesn't do something like this).

Thanks

> +
>         for (i = 0; i < nvqs; ++i) {
>                 if (!names[i]) {
>                         vqs[i] = NULL;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 0ff6c9363356..482ff7d0206f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -256,6 +256,12 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns the irq affinity mask
> + * @set_irq_affinity:          Pass the irq affinity hint from the virtio
> + *                             device driver to vdpa driver (optional).
> + *                             Needed by the interrupt affinity spreading
> + *                             mechanism.
> + *                             @vdev: vdpa device
> + *                             @desc: irq affinity hint
>   * @set_group_asid:            Set address space identifier for a
>   *                             virtqueue group (optional)
>   *                             @vdev: vdpa device
> @@ -344,6 +350,8 @@ struct vdpa_config_ops {
>                                const struct cpumask *cpu_mask);
>         const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev,
>                                                  u16 idx);
> +       void (*set_irq_affinity)(struct vdpa_device *vdev,
> +                                struct irq_affinity *desc);
>
>         /* DMA ops */
>         int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
