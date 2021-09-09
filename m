Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58526C433FE
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 02:53:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC65603E9
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 02:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEC65603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B45E940215;
	Thu,  9 Sep 2021 02:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZlsRIWpt6ob; Thu,  9 Sep 2021 02:53:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 643A4401BF;
	Thu,  9 Sep 2021 02:53:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E819C0011;
	Thu,  9 Sep 2021 02:53:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36DC4C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A272401BF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WdTSVuJFnVkj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A178401BD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631156019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NCU4fELdJJvXy1y+BlFSKK66pAydPKiQ4A8E9zMmeZ0=;
 b=bRjgU66DrKdfpYdDMg8k0c4KmEUqcvJ9T+fCOpPOY3MFoqxzwbcQbi0k7Zu4sN0eCVYxkG
 3Fx7BFWtjEHvPmByFZmYRUDIRrHT5HD1GB5EKUy32rtXSfyNqznRhfVOgiAb70u+z5bNG8
 j0zx91ku0C3YSuU676rdzt1YdPfPFvE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-am7HV4J6MKOoE6sBbw6ukQ-1; Wed, 08 Sep 2021 22:53:38 -0400
X-MC-Unique: am7HV4J6MKOoE6sBbw6ukQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 k6-20020ac24566000000b003f067b5841dso168586lfm.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Sep 2021 19:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NCU4fELdJJvXy1y+BlFSKK66pAydPKiQ4A8E9zMmeZ0=;
 b=HoAGPuFR8sRYapt377rt8GtIJvUJBfKuVu4S2knopNEnjvW5ahAuDF5P3xgEjDG8MM
 h+jbIq3fTBYVqPiy4e5kl9shUIdzNefCCCdtHKaBXlydE8XrFAuShPJGjDeV/86oiWun
 WnucLQC6cPMZY9+QhndJHdj7RUWdx/RJ8qVbprcZFONhT4yyvO5rv+4Z/zy6CbbnW83N
 hruXxHO0csqpGKRt/zcn5D/dX5KYteoNhlbxiYBML1mRuS2JbSiEGKNMAjV5z7kWWaDY
 2w5X115VYYNz4GS2lzvbVSC8chqxVbXmdvNmKaagn7TF1eoRlUV5TD6F3EmHbljotMH0
 80Vg==
X-Gm-Message-State: AOAM530m2y/t5gU5d0Fy0l4Y/NiH7xk9bCCJOi55dxTPo+t9Ux9uMr0z
 GptifDJJI+TDz1KbfxLEImpRhQ8vXFu/ZH1fie3imDvXARnB0GtMHlNhoEc6w7QZZ0Hn9rlO4Gj
 XFsi8mY2nA4ODnZ1pymcRs+2mvDYydCTui4rCVLVneat3QvBNKIhrbIcyJw==
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr590708lfg.629.1631156016686;
 Wed, 08 Sep 2021 19:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwFbRMHWR8KilaJRfeJK8Ht/RveN4kOKwDEooA6v/pHQ/0C03FMr45i1CD5PKOhN0e2+ww6xEmGD0bWv7mMZI=
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr590704lfg.629.1631156016512;
 Wed, 08 Sep 2021 19:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <88701e88ab061f5d1b94bd046afcb9d3588414c3.1631101392.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <88701e88ab061f5d1b94bd046afcb9d3588414c3.1631101392.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Sep 2021 10:53:25 +0800
Message-ID: <CACGkMEuPUy_fYAGLpj2RYkWGvePhtOVWBa1FGXK0he7s54o4kA@mail.gmail.com>
Subject: Re: [PATCH 3/6] vp_vdpa: add vq irq offloading support
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

On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> This patch implements the get_vq_irq() callback for virtio pci devices
> to allow irq offloading.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Jason Wang <jasowang@redhat.com>

>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index fe0527329857..4c512ae1fe01 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -76,6 +76,13 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
>         return vp_modern_get_status(mdev);
>  }
>
> +static int vp_vdpa_get_vq_irq(struct vdpa_device *vdev, u16 idx)
> +{
> +       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdev);
> +
> +       return vp_vdpa->vring[idx].irq;
> +}
> +
>  static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>  {
>         struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> @@ -416,6 +423,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
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
