Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FDDC433F5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 05:55:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BB2610A5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 05:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18BB2610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA93D40231;
	Mon,  8 Nov 2021 05:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qfSb2xVwQ8ZE; Mon,  8 Nov 2021 05:55:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5BE464022D;
	Mon,  8 Nov 2021 05:55:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DF1EC0012;
	Mon,  8 Nov 2021 05:55:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E98B1C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 05:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAB1280DE6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 05:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kpBzySudpj9W
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 05:55:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9686B80DE4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 05:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636350944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fzvPwnGXA3h5EZi2ibTfew9w6/2FA8/r0v3M/EP4Gh0=;
 b=U6Ok4z9IvHNPloMn7VLrQt80RiVskQpUTD0gl7dA+6GA8Zdp182ozYkz3PcJWHDm++s3xV
 8pOMGhz+0XlVQtx1KuPrF/cTp9AgVYQjJCihTgHQ8nlBOYsAyqwmXNmJN8mbKPlfPmpGNG
 qcwxbvMMo8RhPDG3zgz8HDbrUh8maIo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-bVsaiUHxNu-lLIVlG-8JUQ-1; Mon, 08 Nov 2021 00:55:42 -0500
X-MC-Unique: bVsaiUHxNu-lLIVlG-8JUQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 d20-20020a05651c111400b00218c6372b7eso1051097ljo.16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Nov 2021 21:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fzvPwnGXA3h5EZi2ibTfew9w6/2FA8/r0v3M/EP4Gh0=;
 b=KU2qi5Fwjp9PM0amV7fk7bNF0Hr0RQPOTiHk+1fmMJWK8pVqbmGrVD8+UIKlxQq5bs
 wsIzByaKxc798U9rFa0Cw9/+phtbeN3Zlz7biPHd1/L0G9THh7VFWsBwIiA0pnxotN8a
 Fjj//wGdhoMQqREDqqn0I1q0OhwYlVQgpSdVq0I17w6aSN8zVb4gyALQitK0W646ZuIC
 WRs46I7pn0AUZbTlhzWiFgATltoUmkaa5y5pLpEm3BbT48a+ySl9D/8NL9irWwxFFKNt
 War9AY770pHBeuOSNCmnxt0siEx/Pn9HeFVEJqYcnspVgVpvTa0iMaf1Bj1Y9GWIEhrO
 jdMw==
X-Gm-Message-State: AOAM530fNu4scJ3Vb+/Qdwx+qTqAwrMVOeIs3I54e3LFhclM967/KxZd
 kmo8rpGKpnj4MLhqdBWNZSQ1ArGgyRXpa7TD1UdLQeKX2I8lZezUANuUivddg/cbJlsIxrcFdRh
 XGXSwq2LHmgWh289BXYigALSGe7MciFmLMdMQXo4xMif7dRCRqqFZt96KFQ==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr6836792ljw.217.1636350941043; 
 Sun, 07 Nov 2021 21:55:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3lSpSSMCv7dMxS5lq0/3OAj+jWYK7U1ch54eUhXxUZl6MgULvuouLWNTS6gkZZ90PPE2R4k32ct3AcZUdXTU=
X-Received: by 2002:a2e:3012:: with SMTP id w18mr6836770ljw.217.1636350940870; 
 Sun, 07 Nov 2021 21:55:40 -0800 (PST)
MIME-Version: 1.0
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Nov 2021 13:55:30 +0800
Message-ID: <CACGkMEvN0cgFQhJmLF3xDXHt_EyZ-TnfBM8CnpNwA9sKcwpzBg@mail.gmail.com>
Subject: Re: [PATCH 1/2] eni_vdpa: Fix an error handling path in
 'eni_vdpa_probe()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Arnd Bergmann <arnd@arndb.de>, mst <mst@redhat.com>,
 kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Wu Zongyong <wuzongyong@linux.alibaba.com>
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

On Mon, Nov 8, 2021 at 12:15 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In the error handling path, a successful 'vp_legacy_probe()' should be
> balanced by a corresponding 'vp_legacy_remove()' call, as already done in
> the remove function.
>
> Add the missing call and update gotos accordingly.
>
> Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 3f788794571a..12b3db6b4517 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -501,7 +501,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         if (!eni_vdpa->vring) {
>                 ret = -ENOMEM;
>                 ENI_ERR(pdev, "failed to allocate virtqueues\n");
> -               goto err;
> +               goto err_remove_vp_legacy;
>         }
>
>         for (i = 0; i < eni_vdpa->queues; i++) {
> @@ -513,11 +513,13 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         ret = vdpa_register_device(&eni_vdpa->vdpa, eni_vdpa->queues);
>         if (ret) {
>                 ENI_ERR(pdev, "failed to register to vdpa bus\n");
> -               goto err;
> +               goto err_remove_vp_legacy;
>         }
>
>         return 0;
>
> +err_remove_vp_legacy:
> +       vp_legacy_remove(&eni_vdpa->ldev);

Won't vp_legacy_remove() be triggered by the put_devic() below?

Thanks

>  err:
>         put_device(&eni_vdpa->vdpa.dev);
>         return ret;
> --
> 2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
