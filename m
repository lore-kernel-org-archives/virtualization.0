Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6915C4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 03:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 62B384038E;
	Thu, 22 Dec 2022 03:53:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 62B384038E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E0xt4VLM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qyKRkr5Sq5q1; Thu, 22 Dec 2022 03:53:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ABD6E40141;
	Thu, 22 Dec 2022 03:53:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABD6E40141
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 688C5C0071;
	Thu, 22 Dec 2022 03:53:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81D94C0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 03:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5551C418A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 03:53:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5551C418A5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E0xt4VLM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ESXOVYWI0Rsi
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 03:53:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3CAB4184F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3CAB4184F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 03:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671681219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/aaQrcnqGrGUG5gLjgLTSUqfN94uhtyZIfkqQj75bA=;
 b=E0xt4VLMeu+SjZ+mr88row6KVUp2c+lNqdfcZdm7jUl5qD3Lv8eiX0/WAfyw0VD2oURcID
 zGizryI5ZT67/ZLLd1bdYX4CCujjk/Dy+VR2JZOfPW0AI3URZPZpiippz7O24NnMy5TXg2
 j015y3tg/PoQOuPAEv7aazn/jjYMTyY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-W3TFgxLHPlixS78vGyOB0w-1; Wed, 21 Dec 2022 22:53:38 -0500
X-MC-Unique: W3TFgxLHPlixS78vGyOB0w-1
Received: by mail-ot1-f72.google.com with SMTP id
 cr28-20020a056830671c00b006774d5923ddso390776otb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 19:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T/aaQrcnqGrGUG5gLjgLTSUqfN94uhtyZIfkqQj75bA=;
 b=U+9N1nlLjyKwlgXXCt5V1PWTPEAHXIoLGWCeDBQdbwMiB0b5ViOeYfbq+sWpll3dAb
 DtI2gG6PZrCypIuMIl2PpzkgUONk0d8QXyjjqFNDJYNG0T7KZrR6UAbxsDbKz+29onmz
 7hGDY0PSsyZkzudMJAoSxO+dsywII/di6F1UzJsMhyWgrJZ+hEk3Q0g8YPQ1i3FYLZNx
 ailHFw4V3BJNdXDQtU1W7rLQEYTt0h4h5rosiecHI6puqVlNCpNHu3Mn+mCAAV4oL03/
 jAvKGFcZl8Sl/7SZeVzo3r2WvjOgWRm6BesvTtte3pdwAwN5VH46FeJPVMuCtmv8jlsW
 X9QA==
X-Gm-Message-State: AFqh2kpbi99zXpI3/2uCg8Jowk01Hh56r6aAYRJV1CskwLYmk8MpSR8l
 ISqkwkLvpBC67JS5KGgyHjdjbF1GNR9qr0fPScFWwuzHLB4OiDa3I4zfsVOh/FumkxuhqZsOTBO
 4XNuUJZQRullTyzaM7OCwyog4U/29VosK8WXVW7y+zfbktZA9dmzvtZsliw==
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr297900oab.280.1671681217609; 
 Wed, 21 Dec 2022 19:53:37 -0800 (PST)
X-Google-Smtp-Source: AMrXdXscHKlQPIb2sVhSRLl5dtfE2xwJUIor7+S5DYsipQmatwhZni0EDXkJyxUIDegUyrTPehVTvTpR84Qcgwr+X2Q=
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr297893oab.280.1671681217372; Wed, 21
 Dec 2022 19:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20221221072003.551091-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20221221072003.551091-1-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 Dec 2022 11:53:26 +0800
Message-ID: <CACGkMEsqNKVte6b4VAo0PLGjhXDPutg44_=XdqAfBqMp9hHYew@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: fix snprintf size argument in snet_vdpa
 driver
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>,
 mst@redhat.com, Nick Desaulniers <ndesaulniers@google.com>,
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

On Wed, Dec 21, 2022 at 3:20 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> The buffer size and the size passed to snprintf don't match, causing
> clang warnings.
>
> This patch increases a little bit the size of the buffer, and uses
> sizeof() to get the buffer size.
>
> This patch should be applied on top of the following patch:
>
> virtio: vdpa: new SolidNET DPU driver,
> by Alvaro Karsz alvaro.karsz@solid-run.com
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/solidrun/snet_main.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index d438a89b359..9ceacf96de0 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -540,7 +540,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>
>  static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  {
> -       char name[25];
> +       char name[50];
>         int ret, i, mask = 0;
>         /* We don't know which BAR will be used to communicate..
>          * We will map every bar with len > 0.
> @@ -558,7 +558,7 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>                 return -ENODEV;
>         }
>
> -       snprintf(name, SNET_NAME_SIZE, "psnet[%s]-bars", pci_name(pdev));
> +       snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
>         ret = pcim_iomap_regions(pdev, mask, name);
>         if (ret) {
>                 SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> @@ -575,10 +575,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>
>  static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
>  {
> -       char name[20];
> +       char name[50];
>         int ret;
>
> -       snprintf(name, SNET_NAME_SIZE, "snet[%s]-bar", pci_name(pdev));
> +       snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
>         /* Request and map BAR */
>         ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
>         if (ret) {
> --
> 2.32.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
