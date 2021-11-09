Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A481C433FE
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 02:56:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC48F6120A
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 02:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC48F6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58FB6400D1;
	Tue,  9 Nov 2021 02:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9mW6lcw4VE1Y; Tue,  9 Nov 2021 02:56:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 426CE400E4;
	Tue,  9 Nov 2021 02:56:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 251EFC0019;
	Tue,  9 Nov 2021 02:56:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 600BFC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 02:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C0E180DFE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 02:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WHf4B-syH9ct
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 02:56:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AA4D80DFD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 02:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636426603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JHvu3XTSxpKAPKxPraFsC3ipd6AaaaqYJT0sjfs7xH0=;
 b=CjO3vo9mYaY5yJSC+yRaVMuldWvkokjEiBYNmtvHDKnbL7Ht+FPe6zERSRgtWwFpDyM2PN
 bwHowuel5OGNWCv4cwi5fbBrQ+zETAP137Uw6dBFUkt7XDaNEErQObJiGEflv0bybDmTon
 QVMmlm2DqNqlOPwOFppwzzncoBpmLHI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-c-C2PgBWNCyPlF4OMVuMyQ-1; Mon, 08 Nov 2021 21:56:40 -0500
X-MC-Unique: c-C2PgBWNCyPlF4OMVuMyQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 i1-20020a056512318100b003ffd4e89eb9so7363937lfe.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Nov 2021 18:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JHvu3XTSxpKAPKxPraFsC3ipd6AaaaqYJT0sjfs7xH0=;
 b=7LjvQGh3Lp+DBfbjCPFjzgZLD+tAZYkYyv/TDyiodJ0yuWvi9j/JqCvFn7A0pYtHf+
 +YT0BIdruPX03G3S8UCERdn6Ii7HdU3ZpEOFvnPQoKG0cRmPvcogIxVZoLNk5WwA3TY3
 9tQJuuVj+R+CPUnByyEJ8dsLuXWed322+sN6RWT/uHd+VbhjXrluBSUfMXbX5bhqg5ul
 kLORG73YDbaRR9fI/D5Fhl9s7KxsvGdBEXFlD76CPmS0mvbc7QRLwHuyYAwqZJSHArGG
 9T7ZgH2Plsh9Y2m21QuCmgDMVcVvTnHxOalausqTbGTfsA8bQsP8B7uItJyWOBs0UKVR
 r88Q==
X-Gm-Message-State: AOAM530AFPGB5R/JNyV5dHg6C2lGSLk5W0qLxoTY4oGd7v2W67u3KoC0
 jp6wjDEWCkBldXsnyU8KFVVFEFufqIbjA6jqVkVHJyYnPJln5y5iLP8BgjWvQ4Nsk23GWGVYYlN
 qxa5vM7jRV9os7LM1pc/dwtw8gdsIeQIYRDBe4jgt8zzslh5VV4S+swA0Nw==
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr4053544ljk.107.1636426598723; 
 Mon, 08 Nov 2021 18:56:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwS0xouPIEbcfGrEIA1f9+MGc01Gw65/pL0zQKLFQYgTcVajy8bhK7Y9nb5RTP7yGFat3VCFBGMoT19gfnMt34=
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr4053522ljk.107.1636426598529; 
 Mon, 08 Nov 2021 18:56:38 -0800 (PST)
MIME-Version: 1.0
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
 <02045bdcbbb25f79bae4827f66029cfcddc90381.1636301587.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <02045bdcbbb25f79bae4827f66029cfcddc90381.1636301587.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Nov 2021 10:56:27 +0800
Message-ID: <CACGkMEuimP8dcWrBk01P-bU-L-xPH=gN4=qAY_tAqnMHqpW+rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] eni_vdpa: Simplify 'eni_vdpa_probe()'
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
> When 'pcim_enable_device()' is used, some resources become automagically
> managed.
> There is no need to call 'pci_free_irq_vectors()' when the driver is
> removed. The same will already be done by 'pcim_release()'.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> Leaving the 'pci_free_irq_vectors()' call is harmless.
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 12b3db6b4517..3db686436628 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -450,11 +450,6 @@ static u16 eni_vdpa_get_num_queues(struct eni_vdpa *eni_vdpa)
>         return num;
>  }
>
> -static void eni_vdpa_free_irq_vectors(void *data)
> -{
> -       pci_free_irq_vectors(data);
> -}
> -
>  static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>         struct device *dev = &pdev->dev;
> @@ -488,13 +483,6 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         eni_vdpa->vdpa.dma_dev = &pdev->dev;
>         eni_vdpa->queues = eni_vdpa_get_num_queues(eni_vdpa);
>
> -       ret = devm_add_action_or_reset(dev, eni_vdpa_free_irq_vectors, pdev);
> -       if (ret) {
> -               ENI_ERR(pdev,
> -                       "failed for adding devres for freeing irq vectors\n");
> -               goto err;
> -       }
> -
>         eni_vdpa->vring = devm_kcalloc(&pdev->dev, eni_vdpa->queues,
>                                       sizeof(*eni_vdpa->vring),
>                                       GFP_KERNEL);
> --
> 2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
