Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073BFC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 03:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9B68D40B13;
	Wed, 21 Dec 2022 03:25:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B68D40B13
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cIUetd6o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9MnQ04p7psgN; Wed, 21 Dec 2022 03:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37A7C40B23;
	Wed, 21 Dec 2022 03:25:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37A7C40B23
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98190C007D;
	Wed, 21 Dec 2022 03:25:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A306C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:25:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40C1281FCE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:25:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40C1281FCE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cIUetd6o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xgKL2uM-Llw5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:25:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8865A81FCA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8865A81FCA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 03:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671593116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ApfT1mwALCaiaFHayB6WsCpaiiWJaQan2/3pFowjHO0=;
 b=cIUetd6oqW4KFiBEjEiFKr7CYywyZrsW5km7kM8USQb51JAUPy4v8wNvPIgkPZeamWHDsU
 r1mh5llgaJn+5G47H1vmedPRP7AsprWeyAHLfHkM2S6+OPgU1Zi81XOCzFQnHRVTIknVtj
 ZYFsEEYMaVkyRStkNKDgIJNO0SKLgCg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-191-zMk3ZrymO0-SEK23AFD56w-1; Tue, 20 Dec 2022 22:25:14 -0500
X-MC-Unique: zMk3ZrymO0-SEK23AFD56w-1
Received: by mail-oo1-f70.google.com with SMTP id
 y25-20020a4a6519000000b004a398cd439bso6323762ooc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 19:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ApfT1mwALCaiaFHayB6WsCpaiiWJaQan2/3pFowjHO0=;
 b=YMkYAr2j6iwLii8Q/2k901yau6yADpH57o4szm7nvPcYaG+zGMArP4C+lNI3W27OyT
 vv11M1Hc1aApaz/AtIgHyR7tLmaTG5isTt20Ror60wpD8pRoYza9wuaI5FPTpbtYp5dH
 u8/o99HFSX/VIt0+uArn+Z7li736mFmKkCYvN4mmPm6LMYKOT7tc5zLnD9XuAc4DeG8d
 W5S402KmzpbBbRI9hUWnxSRh2Jz+NWlu7hOivWp/1t7UfknfdNezb1pwFEqdIYeN1jBY
 q8Fjk9e0rrU+j/ux1mcmQLGlw0gJ2D1GJ2u6dXv1IZWL0gvNkQwcz9XHMT/ZfY6a7xlx
 9EHQ==
X-Gm-Message-State: AFqh2krqYlTzbmMvTeFyk4S3/xdXdF4tQFhUsnuUqNNhan7m9KUGa6+k
 VgYRQHpM0Hm/cwRcGDydmGvGgqi9Ac5W+v0vyUqGhuhCunDegAmIFTtklfb+WoaQke9elRnPijx
 UEi9ucWAYf/mfEjQw/B40BJlQqf91NriexfFxVv3dObdjsdOOyddpa93EFw==
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr3679oab.280.1671593112829; 
 Tue, 20 Dec 2022 19:25:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtESDdSkXgg8r/t0XugHs8++IS/w1sAL9QIHZ7vn0P3+2zRKMV14ptsVewitum6DIvaXcMfP4cGF4sg1GCkCXQ=
X-Received: by 2002:a05:6870:3d97:b0:144:b22a:38d3 with SMTP id
 lm23-20020a0568703d9700b00144b22a38d3mr3678oab.280.1671593112600; Tue, 20 Dec
 2022 19:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20221220090732.409004-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20221220090732.409004-1-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 Dec 2022 11:25:01 +0800
Message-ID: <CACGkMEtpYomDhJ+oKhXROA8NPMwWKvLfK2TQRZ30g=o_vW8cQw@mail.gmail.com>
Subject: Re: [PATCH] virtio: vdpa: explain the dependency of SNET_VDPA on HWMON
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Tue, Dec 20, 2022 at 5:07 PM Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:
>
> Add a comment in Kconfig explaining the
> "depends on .. && (HWMON || HWMON=n)" part.
>
> This patch should be applied on top of the following patch:
>
> virtio: vdpa: new SolidNET DPU driver,
> by Alvaro Karsz alvaro.karsz@solid-run.com
>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 79625c7cc46..7396e92b485 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -89,6 +89,14 @@ config ALIBABA_ENI_VDPA
>   config SNET_VDPA
>         tristate "SolidRun's vDPA driver for SolidNET"
>         depends on PCI_MSI && PCI_IOV && (HWMON || HWMON=n)
> +
> +       # This driver MAY create a HWMON device.
> +       # Depending on (HWMON || HWMON=n) ensures that:
> +       # If HWMON=n the driver can be compiled either as a module or built-in.
> +       # If HWMON=y the driver can be compiled either as a module or built-in.
> +       # If HWMON=m the driver is forced to be compiled as a module.
> +       # By doing so, IS_ENABLED can be used instead of IS_REACHABLE
> +
>         help
>           vDPA driver for SolidNET DPU.
>           With this driver, the VirtIO dataplane can be
> --
> 2.32.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
