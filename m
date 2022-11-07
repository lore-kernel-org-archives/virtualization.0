Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCE2C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 07:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 378448149B;
	Mon,  7 Nov 2022 07:44:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 378448149B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jOIr9JL4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CnWggTx-ec0; Mon,  7 Nov 2022 07:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A448181495;
	Mon,  7 Nov 2022 07:44:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A448181495
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7928AC0032;
	Mon,  7 Nov 2022 07:44:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 910E9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5064560AB1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:44:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5064560AB1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jOIr9JL4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MtrooUeR-EU0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2713460A99
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2713460A99
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 07:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667807056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BOakKuOc5QKaCrlWc07vXO968J4uiDQ2dBwbOnh8eLM=;
 b=jOIr9JL4k+i23n3/nCR1J+R1dhFNyVh251bocZRaCmJVDnJ6P5wJgV7/wHJYmHT7ZJH4LJ
 9alwyWJDW+qyXbDMpU0GKQ7bj5tqgg1pIJyre4UU1mMYHrMGb8L1OG4yC5bjEpOzmyldY2
 gmKj5I9YIWF2qaGnFyf2Wy3rLthf8BE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-207-Sza_a-ZGOXqclYAGiKvqmg-1; Mon, 07 Nov 2022 02:44:07 -0500
X-MC-Unique: Sza_a-ZGOXqclYAGiKvqmg-1
Received: by mail-oo1-f72.google.com with SMTP id
 x6-20020a4a2a46000000b0049ca27b1507so2544193oox.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 06 Nov 2022 23:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BOakKuOc5QKaCrlWc07vXO968J4uiDQ2dBwbOnh8eLM=;
 b=KaUJ/w7Oh9y/7AMHHMoDEsvGYz4P/A9iC9WfTK93nTlAPSfUMxszcUg9hTFOIklNmO
 9fRy+AgbsD1XUk8/83q13AHaIKEieFWzZKGhak9dDjKi1YuNAlC3xhETEy22dKnbW4s2
 5ZDqr0NlneC2e8gmEPXLdXlFmqMZDxSs/x0ezjylV+fZviZIyxzvM8OjoaHrV+vwaQ3H
 iGAik49xgpegkSqhuIhkmrHTw36uo5+mIWgtWS2UF7N3bF3R8Qd45hIbplTcJ8DfB0Ih
 /2iyfKfbbUPnuHwchZbu/d4md12IHg4C8Gs2/KEbm/KS6P8fbiiQ3WNOblZGmx51/m6V
 k8ew==
X-Gm-Message-State: ACrzQf1UHMZEGLRLeOSN/vRu6J/xDlY0rgaxxhKow1G3wPwiJLiM9hID
 wTkoRm+IrkC1YwwOpB1u2oiYusupDrvPfvilIyD2Se6cA2Htekn0KLJviFpNrruhoRUPsiExQAA
 zWtmhPtEB9ddPlxqjciCP5iRzcBF6BTfJLzr6E54HwWuxzL4xVDunuH68fA==
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr9461201oib.35.1667807046574; 
 Sun, 06 Nov 2022 23:44:06 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4N4jUfu9pMYeA80Eddf3Hun8DW8URGbJXrQnAHwv6j7MUq23+WDOdMNbHNlB6W/+EqKmTNSP64CeIhwDv3++Q=
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id
 bh30-20020a056808181e00b0035a59595909mr9461192oib.35.1667807046341; Sun, 06
 Nov 2022 23:44:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1666796792.git.sebastien.boeuf@intel.com>
 <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
In-Reply-To: <d8c405c150c6eb25acab58718c38e0ef4c3c0293.1666796792.git.sebastien.boeuf@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Nov 2022 15:43:54 +0800
Message-ID: <CACGkMEt93LU009MVK3cDKAU1fv3ZoaDskWp4hakmeTZyBQa=fg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] vdpa_sim: Implement resume vdpa op
To: sebastien.boeuf@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Oct 26, 2022 at 11:09 PM <sebastien.boeuf@intel.com> wrote:
>
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
>
> Implement resume operation for vdpa_sim devices, so vhost-vdpa will
> offer that backend feature and userspace can effectively resume the
> device.
>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 28 ++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..84fee8bb2929 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -357,6 +357,11 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>         struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>
> +       if (!vdpasim->running) {
> +               vdpasim->pending_kick = true;
> +               return;

I think we may hit here when the driver kicks vq before DRIVER_OK. Do
we need to check device status in this case and resume?

Thanks

> +       }
> +
>         if (vq->ready)
>                 schedule_work(&vdpasim->work);
>  }
> @@ -527,6 +532,27 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         return 0;
>  }
>
> +static int vdpasim_resume(struct vdpa_device *vdpa)
> +{
> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +       int i;
> +
> +       spin_lock(&vdpasim->lock);
> +       vdpasim->running = true;
> +
> +       if (vdpasim->pending_kick) {
> +               /* Process pending descriptors */
> +               for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
> +                       vdpasim_kick_vq(vdpa, i);
> +
> +               vdpasim->pending_kick = false;
> +       }
> +
> +       spin_unlock(&vdpasim->lock);
> +
> +       return 0;
> +}
> +
>  static size_t vdpasim_get_config_size(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> @@ -717,6 +743,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> @@ -750,6 +777,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .set_status             = vdpasim_set_status,
>         .reset                  = vdpasim_reset,
>         .suspend                = vdpasim_suspend,
> +       .resume                 = vdpasim_resume,
>         .get_config_size        = vdpasim_get_config_size,
>         .get_config             = vdpasim_get_config,
>         .set_config             = vdpasim_set_config,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 0e78737dcc16..a745605589e2 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -67,6 +67,7 @@ struct vdpasim {
>         u64 features;
>         u32 groups;
>         bool running;
> +       bool pending_kick;
>         /* spinlock to synchronize iommu table */
>         spinlock_t iommu_lock;
>  };
> --
> 2.34.1
>
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris,
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 5 208 026.16 Euros
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
