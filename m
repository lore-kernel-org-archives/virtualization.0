Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AFFC4332F
	for <virtualization@archiver.kernel.org>; Wed,  2 Nov 2022 05:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 386A941609;
	Wed,  2 Nov 2022 05:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 386A941609
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ClSQZcDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-NBOkAoe4KJ; Wed,  2 Nov 2022 05:34:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B7ED4160B;
	Wed,  2 Nov 2022 05:34:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B7ED4160B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1BDEC0033;
	Wed,  2 Nov 2022 05:34:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC6BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 05:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9C704026A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 05:34:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9C704026A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ClSQZcDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 036hlK2wdQav
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 05:34:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE9AD400DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE9AD400DD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 05:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667367277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h1I2T+2/Dxfm9YlZ7q9jKIOhGfg+UzZ9X3JKRBk8sZw=;
 b=ClSQZcDFILjUVFRPaoy6FnPnYL7xl1mEIxzuwbCHKfJaO2hYUxJF7GlJdATsFrwv/48IQ4
 vmqB1Tmyfi0cr/DEf+rs022aN7fFx2ZpMD4eZ6uJPXDmKlifA7QNf37bT4+wMyOqL/KPkj
 ODwjkNGmAK+dA3pn+YAlvvjqKP7HTfQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-498-rcB-zIEQPiuItRjmk5u05Q-1; Wed, 02 Nov 2022 01:34:36 -0400
X-MC-Unique: rcB-zIEQPiuItRjmk5u05Q-1
Received: by mail-oi1-f197.google.com with SMTP id
 u18-20020a056808115200b0035a0dff88f9so3594667oiu.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Nov 2022 22:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1I2T+2/Dxfm9YlZ7q9jKIOhGfg+UzZ9X3JKRBk8sZw=;
 b=XPofCNZbenb31KI+8r2Q2WH2zNxrAjSN+DRn19msvGq0z/Wm80c76Zljedi58ySC1c
 2azOwbXjFVLkgOm/Vg4bPV/YmJ/NHno3EyDnIIWshSqmd3Uid3mJd5V2qsQVQ8yVmg23
 cqn0dU265WO3B1afymvyfDwUojAd7MRp7b1VcKNF1KicYrFmQZkdqrUQMxqNSQirpW8S
 AnWqGGC4g1SqRCSlIJZU1giCEX7pAFVKHne1mj2sGr2/A5+/fLnpzdf8DdfcZ9HUGieI
 pXHaSrI9emWpnTh25X146+JuRiRg6lKDL0JUkRwjTFEqTZPaUX/DjA/rmO/rsqQR8rXK
 TfDg==
X-Gm-Message-State: ACrzQf3s+yvdMmuGlSsp5AWdhuaIdNfFWYxlIVzdO8A+DVSYY+JFVS8D
 0AwaOdmyACaD+M6AXbgvi36R3tUTetFsjpjY0xHbgaDdHQgOGfXqIXiN2CHFRZczPeRBUbscApw
 HUtj/IpHwWJRn0u3bMue8ko3YWGrHSwL6b0YDxBLf3E0kbw5jtaGRKqwpBw==
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr22473282oal.35.1667367275364; 
 Tue, 01 Nov 2022 22:34:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5lMHmKVqFfYJ+4BBy6X8pl2zo+yvdvZ342P4QBfqvmiuEti4C3GFtm9zo5CotzTsTk01EWfGY+2IBJSDrtmFw=
X-Received: by 2002:a05:6871:54e:b0:13b:29b7:e2e8 with SMTP id
 t14-20020a056871054e00b0013b29b7e2e8mr22473271oal.35.1667367275173; Tue, 01
 Nov 2022 22:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20221101111655.1947-1-angus.chen@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 2 Nov 2022 13:34:23 +0800
Message-ID: <CACGkMEs6ZTrf0NMXGuM=VYZC+zAujigiTG2CgE8gAdvxHc2Q7A@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci: modify ENOENT to EINVAL
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Tue, Nov 1, 2022 at 7:17 PM Angus Chen <angus.chen@jaguarmicro.com> wrote:
>
> Virtio_crypto use max_data_queues+1 to setup vqs,
> we use vp_modern_get_num_queues to protect the vq range in setup_vq.
> We could enter index >= vp_modern_get_num_queues(mdev) in setup_vq
> if common->num_queues is not set well,and it return -ENOENT.
> It is better to use -EINVAL instead.

I'm not sure I get this. It would be better to describe:

1) what kind of issues can we see if we return -ENOENT
2) why -EINVAL can help in this case

Thanks

>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index c3b9f2761849..edf2e18014cd 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -303,7 +303,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         int err;
>
>         if (index >= vp_modern_get_num_queues(mdev))
> -               return ERR_PTR(-ENOENT);
> +               return ERR_PTR(-EINVAL);
>
>         /* Check if queue is either not available or already active. */
>         num = vp_modern_get_queue_size(mdev, index);
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
