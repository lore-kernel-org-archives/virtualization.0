Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B5DC433F5
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 03:16:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15118611ED
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 03:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15118611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D26F040375;
	Wed, 15 Sep 2021 03:16:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kaFStZOmy_qa; Wed, 15 Sep 2021 03:16:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 530A7404FC;
	Wed, 15 Sep 2021 03:16:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D887C0011;
	Wed, 15 Sep 2021 03:16:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EA50C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7258281A23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:16:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KtYUf0sOpRPk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:16:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE981818B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 03:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631675777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhBi60XZ5gaKLAWK00nBpRueTnGa6hTCQPOpH6hLBeE=;
 b=bQUty9yyUvdx7GE2D/QmA7fPj1Tlk97qXLxDSviX+d4Z1L5x31FAsOqeE8NJPslT3iTzgr
 UYR3IUCY1yYqJfXEpeaJ58HShn3Fq6gR0/1uTQx7ZYuFirDZzB5hy5RgkU9UHB7xmm2Ns8
 6Bg8XFLJIrCV7swkYs6vx+K3A4R4Y9g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-c-CuYUBeM0mFRrZs9pJ6dg-1; Tue, 14 Sep 2021 23:16:15 -0400
X-MC-Unique: c-CuYUBeM0mFRrZs9pJ6dg-1
Received: by mail-lf1-f72.google.com with SMTP id
 c15-20020a056512238f00b003f1de3c67e2so493090lfv.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 20:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xhBi60XZ5gaKLAWK00nBpRueTnGa6hTCQPOpH6hLBeE=;
 b=bOTtBQ/agHT4DR2CcNm9DlZH5qeLQYy0tF37drVQGQT6qhaoGbemTjj3218ryaeM/n
 1TcWF1Qehs6qnNMgl4FnFGXZ1r3xKLwqUhww2bvhEmvMC2AYdQD9V58v4YxziZZiLhI5
 AhYqj5Axw6eYdC6EW+QM3400MQlnJ4Wq/MU5c2rBWA/5WzyRVCigIfOvf+7DgjH/nCQM
 vUNSHxC/hVvFHYQJHjg3U1j9txz1UwL8ebIdy+1hkUc1zQ70s30SwLFKOGeukpURxyHb
 +zVDcWCzh9VSOadhRl2pHEpjT/uFISD5FNiySK1DG57Mp5i9UATEfuHFOSs5NiOt4uOQ
 h2Ag==
X-Gm-Message-State: AOAM531YPqNKYMH/9Ai1Awf7U8kY6U5GT9+MOTMvO3cFm+KNHJFPIkus
 jdBrD7fFE2jGnOzzDjgiJR9nZtIbCkX5z4bqP/kRXguRm97ZIIjGnZa8+YuL5EmLPHo+f2yteUp
 O0xPKqsxVK4LojP0VYIQayvW830co9DOItwJRHZiAPq3PemkOqCkpzqZrkw==
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr13646271lfg.498.1631675774329; 
 Tue, 14 Sep 2021 20:16:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmAMIZ/RUY/N9+tz1MMRn3X0t0rUT+N0c7PfKGWVajG2fTgbaSZCgBM2zEw2Vr0V7Vjxk115DO4435li0ub3M=
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr13646256lfg.498.1631675774154; 
 Tue, 14 Sep 2021 20:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <11a491e2200e17319989ff9043b8d58867610197.1631621507.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <11a491e2200e17319989ff9043b8d58867610197.1631621507.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Sep 2021 11:16:03 +0800
Message-ID: <CACGkMEu9udAQ63_1Xx6kNo=OR5Mgkk5fnS5or6E98-vjTpoUkw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vp_vdpa: add vq irq offloading support
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

On Tue, Sep 14, 2021 at 8:25 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This patch implements the get_vq_irq() callback for virtio pci devices
> to allow irq offloading.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(btw, I think I've acked this but it seems lost).

Thanks

> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 5bcd00246d2e..e3ff7875e123 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -76,6 +76,17 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
>         return vp_modern_get_status(mdev);
>  }
>
> +static int vp_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +       int irq = vp_vdpa->vring[idx].irq;
> +
> +       if (irq == VIRTIO_MSI_NO_VECTOR)
> +               return -EINVAL;
> +
> +       return irq;
> +}
> +
>  static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>  {
>         struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> @@ -427,6 +438,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
>         .get_config     = vp_vdpa_get_config,
>         .set_config     = vp_vdpa_set_config,
>         .set_config_cb  = vp_vdpa_set_config_cb,
> +       .get_vq_irq     = vp_vdpa_get_vq_irq,
>  };
>
>  static void vp_vdpa_free_irq_vectors(void *data)
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
