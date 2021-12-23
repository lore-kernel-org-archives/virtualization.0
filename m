Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17550C4332F
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 05:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E84B405BE;
	Thu, 23 Dec 2021 05:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bYAFjjTJdgL; Thu, 23 Dec 2021 05:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0660A400AF;
	Thu, 23 Dec 2021 05:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC7AFC001E;
	Thu, 23 Dec 2021 05:59:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F47EC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 05:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 03E5A40936
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 05:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hGrj0IWRElJO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 05:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8B3740930
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 05:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640239140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eP5DWolnVEj7zO24iHvs8bq5q4izn4uLMYYf6eLn4i0=;
 b=XvYAOk2A12rReilZ+lcRPS767nl+l++VyFgU0cr9nlkFDJEAv9VeHXMyj7BNsSAG9bHV2F
 8/+7cfftCDQ7IcVnUryzDuFRDf+alqdIjQKajMFRlQ/55nidNgiI2lGGrbUieCKY50aoNU
 vaavkZIXw49Ta1u8h6Clcwm1Ww1J958=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-v1pvmpZuMjCc9_UCycoOtA-1; Thu, 23 Dec 2021 00:58:59 -0500
X-MC-Unique: v1pvmpZuMjCc9_UCycoOtA-1
Received: by mail-lj1-f197.google.com with SMTP id
 i123-20020a2e2281000000b0021cfde1fa8eso1008959lji.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 21:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eP5DWolnVEj7zO24iHvs8bq5q4izn4uLMYYf6eLn4i0=;
 b=1JTMgDoDrsIVutpyQKOL3XiEq9QT/Y6HqUYpB+KhwgipMw1ujIqdW2i8VvYILVkK0f
 J6VIVRlduPfw65HkC07sgHzQieISexBShLV1G7sheVEj8dDEYFLMBzuTYZI7kwMFWyYN
 h4iQ4/0tGdJhAl80a9td/NwfeC1AJsAesi+hc4enXHueUBOK9IaThPJfhMT2aK/+0w/C
 xRjRsvOO4moVp6aZROt+GNj6l8lZu+B+jaLofFRoRmSmuw+ePyk3hprRU1r4+eqb3X/r
 samOIeSuegyq+oHS0viktjFous+l3142TNmGY5C2CFpHQCMFQUCth2bJ65rOD1iQVNfV
 O1gw==
X-Gm-Message-State: AOAM532babMBtk7b3Xk2Z6+fhIoF+JyOB1fWP7bdz4od13miR963VXim
 ItPkEtgacCbdwaO2niTcnpVzADyluJcqrzE7fVbeG+6w2lpLCXU2ukofdCiljo0veB2RG2Ad/CD
 r/byRB6s7ana+X1689U8wfH9JBcqNfh3h90sy9F/YvazdO1RgHPv7I5KcQw==
X-Received: by 2002:a05:6512:108b:: with SMTP id
 j11mr769776lfg.629.1640239137629; 
 Wed, 22 Dec 2021 21:58:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze+1MRfxRzVt2CRB2uJgLx/trRKa/yExHXWTRkPp/1cU/SLHMDcUhLNuYita2ff2D4n+sLWZqCbiovDS0Kl8I=
X-Received: by 2002:a05:6512:108b:: with SMTP id
 j11mr769767lfg.629.1640239137443; 
 Wed, 22 Dec 2021 21:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20211222112014.87394-1-flyingpeng@tencent.com>
In-Reply-To: <20211222112014.87394-1-flyingpeng@tencent.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Dec 2021 13:58:46 +0800
Message-ID: <CACGkMEszTmn1nO=qkzqGawtjq1f6AJK_U63Tw96+PU02C3Cdew@mail.gmail.com>
Subject: Re: [PATCH] virtio/virtio_pci_legacy_dev: ensure the correct return
 value
To: Peng Hao <flyingpenghao@gmail.com>
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

On Wed, Dec 22, 2021 at 7:21 PM Peng Hao <flyingpenghao@gmail.com> wrote:
>
> When pci_iomap return NULL, the return value is zero.
>
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/virtio/virtio_pci_legacy_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
> index 9b97680dd02b..677d1f68bc9b 100644
> --- a/drivers/virtio/virtio_pci_legacy_dev.c
> +++ b/drivers/virtio/virtio_pci_legacy_dev.c
> @@ -45,8 +45,10 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
>                 return rc;
>
>         ldev->ioaddr = pci_iomap(pci_dev, 0, 0);
> -       if (!ldev->ioaddr)
> +       if (!ldev->ioaddr) {
> +               rc = -EIO;
>                 goto err_iomap;
> +       }
>
>         ldev->isr = ldev->ioaddr + VIRTIO_PCI_ISR;
>
> --
> 2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
