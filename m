Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AB8C433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 03:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4757A82C61;
	Tue,  5 Jul 2022 03:15:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4757A82C61
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YI2rSS0a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NUVWzdkDB3HC; Tue,  5 Jul 2022 03:15:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2C3182C89;
	Tue,  5 Jul 2022 03:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2C3182C89
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79CE0C0032;
	Tue,  5 Jul 2022 03:15:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07BE0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 03:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4DB141710
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 03:15:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4DB141710
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YI2rSS0a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w2wyQuXaRIL9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 03:15:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9813C415FD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9813C415FD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 03:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656990912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MPiLYuaQHJ/dNIyImBUJeFklEe+TyW/wfcZITbRD1eI=;
 b=YI2rSS0aZkJKff79sKa8cJsbhM9xSs5ZFvATUpJh9Y43HKEL7Xr2bw4kk0QNw8RfJ1b61i
 5SouEEYvZDnacIOGuaeyhmUhu+oQoNugMNB3FDYFoH0hTlhjpSUpCrVB096fSexxyUeXT4
 Z7Okt2y8wgOSyr7aHc2hKdVY7S+/lvk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-QUIAkN07MKeYguU7q49GOA-1; Mon, 04 Jul 2022 23:15:11 -0400
X-MC-Unique: QUIAkN07MKeYguU7q49GOA-1
Received: by mail-lj1-f198.google.com with SMTP id
 g25-20020a2e9e59000000b0025baf0470feso3165690ljk.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 20:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MPiLYuaQHJ/dNIyImBUJeFklEe+TyW/wfcZITbRD1eI=;
 b=j4fSIYeB22JDRQeUjk/am+RZcj0/fyCnD6cIITAyW85unqCqgpF6TLp0PbYmG+fCgn
 NL4Ok0MlC2S9AqTL16JsOLWMD1x+PR4F1Q+rahNNz0tT3EHOqtdh6JXwrnyHwUe6wHMP
 jw5VA2ha8HStVWV2D9S2Xv6+4PuO8a836+RprihfZnf7uLHvpvM5RoaiPIpGLhlLqu8F
 8+VXTCNXOz7eAqHZ6v7PBdY7p9buLrTGNhBvr+lxlpfbWI5OLiLycFXCxKD4Ia+8N8lz
 MtTwYcw6r1gG2L52txqB1oRXBzso32rYmvMDaF8VYcVfXqbx+9rnCYRlo4GyHEgJWXpl
 wz0g==
X-Gm-Message-State: AJIora8RNCPdmUqPW2ZmV38oiKT7CdTuKnkvKXDdKWNk3X1o6LK8SsYF
 VBD6B6Ej2NadEkSwrQZY/blT4hVErtWeNxNQmeteZ16yShnM20GpzxUz7BoHnIo7goUhIaF1zns
 FMvTcwK16sUcmRMCThijOnP4n4Jd9ofmW6+FiqNlkdjrdVkqUlcwsN3UIng==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr19728901lfa.124.1656990909241; 
 Mon, 04 Jul 2022 20:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tza1pmpMAWjNhoieZO4QqKWL1/YPqUOvpoVjPyKy0BY4OsaLw+4a3jzDRxrl7JkPP/xB1zCm2drjENV6/171U=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr19728895lfa.124.1656990909097; Mon, 04
 Jul 2022 20:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220704190456.593464-1-colin.i.king@gmail.com>
In-Reply-To: <20220704190456.593464-1-colin.i.king@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Jul 2022 11:14:58 +0800
Message-ID: <CACGkMEsEZjmG8JV6hz4=a=hWLFxeGom6sGs7LSYzTZnoC-M7jQ@mail.gmail.com>
Subject: Re: [PATCH] vDPA/ifcvf: remove duplicated assignment to pointer cfg
To: Colin Ian King <colin.i.king@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
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

On Tue, Jul 5, 2022 at 3:05 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> The assignment to pointer cfg is duplicated, the second assignment
> is redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 48c4dadb0c7c..47b94091733c 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -29,7 +29,6 @@ u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
>
> -       cfg = hw->common_cfg;
>         vp_iowrite16(vector,  &cfg->msix_config);
>
>         return vp_ioread16(&cfg->msix_config);
> --
> 2.35.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
