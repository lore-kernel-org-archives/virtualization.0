Return-Path: <SRS0=bZ0l=OF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767C2C433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 08:34:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E406611AF
	for <virtualization@archiver.kernel.org>; Wed, 15 Sep 2021 08:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E406611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB0D581CDB;
	Wed, 15 Sep 2021 08:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cv3E6OmvkjxE; Wed, 15 Sep 2021 08:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A39D081C93;
	Wed, 15 Sep 2021 08:34:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 704D5C0011;
	Wed, 15 Sep 2021 08:34:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0A3BC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA26D81CBA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PNBmofEiFGDw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D932481C93
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 08:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631694888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Calh83N3mQvO0vV6rtapTNlgbimD7jhmGtdFhVLLmTc=;
 b=N6IQLXS88rTdgXxzx37vVXN4Gckf8N6UsLAkMJDS3K2PwERGTcBi0uKz8Uy8/ookFauSY2
 84yzVZVpGOY1udQWg786cp/i4GP6NivqUtjjz0zoMRJXnqNsHhuaoLSGpDDYYmwfOZYOha
 3bvAxBEYF0aNN/AE7kAamkhD6IHg1Ws=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-fqZlqc6fOnOOuUaYF30J5Q-1; Wed, 15 Sep 2021 04:34:47 -0400
X-MC-Unique: fqZlqc6fOnOOuUaYF30J5Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 v2-20020a2e5042000000b001def54ff19eso1164504ljd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 01:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Calh83N3mQvO0vV6rtapTNlgbimD7jhmGtdFhVLLmTc=;
 b=HRtOoK77jTlTCkgLhsTizIsG+U5aV1CRMWLUhtE1XdC6fbI86y3ZCRu1Wa+C11Ujob
 yi31FFqyJ1mGNZbtoP8ksPXLIn+jACyHLzfCG0MIvN0Nku4buVvtfEUT2mykut4Mr79e
 RrXWzLz6gv0WmOBOZPRTXoojW88R9GdrE3CiNfeBfNPMnz2UE1LTVIQVed5c5lIJgRXb
 ktWdzQ4HeRLRz2bHc9TxYn/fBvAt4q725eW/RIsf08pAFt1IKA95y/bjsufBCQfZ3xJx
 FIVmqiJ2DKWL+usxgbQnJv39NZbhnUhOzgaCtRvuuPbbNx/X3atpMRjqw2JHb++VZh1S
 Gxzg==
X-Gm-Message-State: AOAM533KrQAtuqivZElnFyStTcxSj54O8nLFm8AUBHrqUHLhXPzpqs6N
 sa1s/KmDW860+k7wUu7VFGyH4C5KWyAcj97+ZD7B7ZCSlfRrGz3bciJTkh6UcHm6G6TSQD9nvNR
 IEBzui7vTVT+mnGs73RQNvskdbIl6bAMVfH+N+8C8RBwhITZElytXSGzwzA==
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr14431614lfg.498.1631694885844; 
 Wed, 15 Sep 2021 01:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5T2fCC4WDDyvm7zt30dXfSgqUOh45aXS5KM/cPFmSoMTgX0M9wgyPpewRx4S6ju6OZ//YROQwKAJl9EmHr4Y=
X-Received: by 2002:a05:6512:32ca:: with SMTP id
 f10mr14431604lfg.498.1631694885678; 
 Wed, 15 Sep 2021 01:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Sep 2021 16:34:34 +0800
Message-ID: <CACGkMEvnG40752Ksw7AMQrg9NpkYz_0Hmw8nKEskLNNOuKNTGw@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: unset vq irq before freeing irq
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, tiwei.bie@intel.com,
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

On Wed, Sep 15, 2021 at 2:39 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Currently we unset vq irq after freeing irq and that will result in
> error messages:

Nit: I think for 'we', it actually means the parent driver can free
the irq during reset, set_status(0). vp_vdpa is one example for this.

>
>   pi_update_irte: failed to update PI IRTE
>   irq bypass consumer (token 000000005a07a12b) unregistration fails: -22
>
> This patch solves this.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index f41d081777f5..15bae2290bf9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -173,6 +173,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>         if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
>                 return -EINVAL;
>
> +       if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> +               for (i = 0; i < nvqs; i++)
> +                       vhost_vdpa_unsetup_vq_irq(v, i);
> +
>         if (status == 0) {
>                 ret = ops->reset(vdpa);
>                 if (ret)
> @@ -184,10 +188,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>                 for (i = 0; i < nvqs; i++)
>                         vhost_vdpa_setup_vq_irq(v, i);
>
> -       if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> -               for (i = 0; i < nvqs; i++)
> -                       vhost_vdpa_unsetup_vq_irq(v, i);
> -
>         return 0;
>  }
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
