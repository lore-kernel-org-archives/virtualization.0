Return-Path: <SRS0=Lrx6=QC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF01C433F5
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 04:09:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9499463236
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 04:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9499463236
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A6AE40200;
	Mon, 15 Nov 2021 04:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bpEn7iyQIcrn; Mon, 15 Nov 2021 04:09:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9634F401FE;
	Mon, 15 Nov 2021 04:09:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D427C002E;
	Mon, 15 Nov 2021 04:09:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D637C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 04:09:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 834724015B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 04:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IKAMbcMvD62M
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 04:09:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B38C40015
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 04:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636949349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GDAF3NtZ/86J1Ftc0UQ/+Vj8njFq7ueV2mkeczZKUzE=;
 b=IfxiT28Qx9NrNvHSH+a3CZO2ZSkyBQ7KX9DmdNf4g4a6BaZa48Q9yXmEteVaL3jKkM7i2U
 IyuZPOq+U17cKTBJslKCzOxggJNPlioRo3xeFCu7zGHUQ89SOwEf7dxPzlM7Ov8bgIuZXZ
 TeTRibPrjfUb1I0Ksd5KO9QQOfYs+ss=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-VG19byhUM-ixxEL1bZLLVw-1; Sun, 14 Nov 2021 23:09:07 -0500
X-MC-Unique: VG19byhUM-ixxEL1bZLLVw-1
Received: by mail-lj1-f200.google.com with SMTP id
 q64-20020a2e2a43000000b00218c94eab9bso4716060ljq.18
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 Nov 2021 20:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GDAF3NtZ/86J1Ftc0UQ/+Vj8njFq7ueV2mkeczZKUzE=;
 b=Rr7VMBAvUkhngkRKP/PgownlPAdnMzx5XQIKhwrrr4AyVOtGk6mx8jO+kL4TxXU0YS
 H2t/I04fx2ghEsebi22BQyL5qwPdSFgJsWZN3KhHbQFt0h5cFVwJszU6iiCWVsNTFg/z
 xYEjhOvLRmtzLbeIrgqpKPScSg1kJaOU1ERK+WIBt2SNdlyw/Hr8dclCs07LgatZ6t//
 36+5dsL3BFCecHn++zdkJ1fssTaUsoCxlATcYKjisZuStxGooGjiQqomvJvO4Kjfb6qJ
 gfzZtKTcDLthnOM7L1bDWqpRlzjunPF8fEq5npBuwv6AOavMHtsdnRmKrdq9fMNE0AVR
 nsNQ==
X-Gm-Message-State: AOAM530vn4A2hgtjyG9l0n0HGed+Oi/qbb+fKePjZ+3MSfBWu3IEPL9E
 iE739PswUBHtw9o1QejB68hG9h4LVTtctLQXv94xoUIQ35/ZvFmo61GARiVk6B1xYP41H6bDMYn
 9bu23NcgAb3wlPyqOQc/OqwrMD/1cShCrytZASdJf5bq/2naUuFh5iAM1pQ==
X-Received: by 2002:ac2:5310:: with SMTP id c16mr33615199lfh.580.1636949346449; 
 Sun, 14 Nov 2021 20:09:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwE9coqJRdnLJdem0vLatbGaWrTJuFC0rOu/AfdVlgUfFR0+IoO2LQrJtU0qqF5e3cZ1/fSrO7KGhIAgTtdV0s=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr33615170lfh.580.1636949346199; 
 Sun, 14 Nov 2021 20:09:06 -0800 (PST)
MIME-Version: 1.0
References: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Nov 2021 12:08:55 +0800
Message-ID: <CACGkMEuEkyqAD+sb3FpHMoM1FHnpFMLH-wgeen53c81VAUAzVg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: clean irqs before reseting vdpa device
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

On Mon, Nov 15, 2021 at 11:17 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Vdpa devices should be reset after unseting irqs of virtqueues, or we
> will get errors when killing qemu process:
>
> >> pi_update_irte: failed to update PI IRTE
> >> irq bypass consumer (token 0000000065102a43) unregistration fails: -22
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 01c59ce7e250..29cced1cd277 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1014,12 +1014,12 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
>
>         mutex_lock(&d->mutex);
>         filep->private_data = NULL;
> +       vhost_vdpa_clean_irq(v);
>         vhost_vdpa_reset(v);
>         vhost_dev_stop(&v->vdev);
>         vhost_vdpa_iotlb_free(v);
>         vhost_vdpa_free_domain(v);
>         vhost_vdpa_config_put(v);
> -       vhost_vdpa_clean_irq(v);
>         vhost_dev_cleanup(&v->vdev);
>         kfree(v->vdev.vqs);
>         mutex_unlock(&d->mutex);
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
