Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A73C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 08:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC9D140B7C;
	Wed,  8 Jun 2022 08:15:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lw7x-Uk_RGJ9; Wed,  8 Jun 2022 08:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6FC1740B6D;
	Wed,  8 Jun 2022 08:15:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 497A0C0039;
	Wed,  8 Jun 2022 08:15:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F6A1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F40640B77
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rmceB23anwJo
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:15:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6AA440B6D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654676112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jz5q+YjZAkyfToJ2c95DtkbkAjaLs7+ZTPGj5+BkvEk=;
 b=hIhH6/xQo1/T2Awc5xQd/WVFiiy7RYOog6kfsyjIXxGBX4t9mLzU78c1VU4XNaew3zf+/4
 nlRgS9E3eRU9zDCDV7FrUiD3GmAdjLovFlGLt+4yG1EDhZGL6wM/k8tFmDrDHOryQ0fBO4
 WBu7O5dmaxtEZVLo5EbMjNNt2lJv7MA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-_NHKGJSjPUOyOCF69VRvLA-1; Wed, 08 Jun 2022 04:15:09 -0400
X-MC-Unique: _NHKGJSjPUOyOCF69VRvLA-1
Received: by mail-lf1-f71.google.com with SMTP id
 u5-20020a056512128500b00479784f526cso987535lfs.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Jun 2022 01:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jz5q+YjZAkyfToJ2c95DtkbkAjaLs7+ZTPGj5+BkvEk=;
 b=pYxsNH7cNbDUBouXk5DEX67uyP4qGm9wvbzJtL6O+2at501vWQw6CMYyZtrTIIqADt
 OfNYhQ6+Dq2eYmxGbt/S9N6GWL9k+MwyZlGmZLkPPonx+Eacb3drnj5fTUYlKigoe9UO
 2s0AbcK/+tVVqrEW2guboc2yePATIO005Bo11IPNbFz0AyFJipUVAw0svapW/CI+CZ3A
 7Fi3fTEpfE7zEEIW+cUjKAREBMavnhtDZwrDuODWg+OUBDefMAW9SSsxzskHt4CDYGAo
 KA1iW+Xx1/00EXbP/LINw6l+11D0nLzwvvd6j5CYdZ7JRL6X6Zm0GdsrhnhL9ImeObPF
 Ieug==
X-Gm-Message-State: AOAM533onSPeqa8VGKMz2OtMZ0V0rwxiUAUiH2C8s+DIKy43UMbV2IH+
 OwnSMLxVNPK6B4Mi7hl6LFu9lpvQvEzBhrHuODY906IKiJB29tPC/BlRkvhQ7XMvAgvoHFCOyuK
 ie3BnvyJZZT3DRT3F3KTkLh8lqHUe+PPovhX4QmKBO5ByDJDh0HQsqUdNpg==
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id
 o12-20020a05651205cc00b0047a0bf7f1abmr521607lfo.397.1654676108374; 
 Wed, 08 Jun 2022 01:15:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY1+iIQeufl0PI6M0pxOr2OD+lyDsrI90C2L8v6cQJkrGmLHN5yVXtHbpPbGCBoud3azvKXHalfitf8gmL8hg=
X-Received: by 2002:a05:6512:5cc:b0:47a:bf7:f1ab with SMTP id
 o12-20020a05651205cc00b0047a0bf7f1abmr521603lfo.397.1654676108211; Wed, 08
 Jun 2022 01:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220604143858.16073-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220604143858.16073-1-wangxiang@cdjrlc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Jun 2022 16:14:57 +0800
Message-ID: <CACGkMEsL513A2Wq2y9GS0yF-FB85gEqJABAULUAjF0aQb0Fmmw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix syntax errors in comments
To: Xiang wangx <wangxiang@cdjrlc.com>
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

On Sat, Jun 4, 2022 at 10:40 PM Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> Delete the redundant word 'is'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index dcca782c698e..3569c782c8a0 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -105,7 +105,7 @@ struct mlx5_vdpa_virtqueue {
>
>         /* Resources for implementing the notification channel from the device
>          * to the driver. fwqp is the firmware end of an RC connection; the
> -        * other end is vqqp used by the driver. cq is is where completions are
> +        * other end is vqqp used by the driver. cq is where completions are
>          * reported.
>          */
>         struct mlx5_vdpa_cq cq;
> --
> 2.36.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
