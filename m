Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA88C43334
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 01:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D897740B4A;
	Fri,  1 Jul 2022 01:08:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D897740B4A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RiKO2sZY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SkoMGIs8cLq5; Fri,  1 Jul 2022 01:08:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 75F70400FE;
	Fri,  1 Jul 2022 01:08:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75F70400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A9AAC002D;
	Fri,  1 Jul 2022 01:08:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15A63C0011
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EBA940062
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:08:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EBA940062
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RiKO2sZY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uk7dZw7EOmpq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:08:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45E0341B90
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45E0341B90
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656637682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZzUciZDJ7qUGpwrJbdbnvPYQFAmuJY/A8ujZXjUH20=;
 b=RiKO2sZY5OAzT+ZXcHqsD5UjY8OQxjD+yuUUupPW/iK/mwfaalJOQP69J7kcqhtfHhznX/
 EjPo+8flDWlutEIqpfoKIcb5Pp4EH8DmtcWCpsSX9CoA6/sl9KOedAjPBxv0efTjtHkntP
 jzJ7cTObqLVokTYqcEF3+7gdPOgdjEo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-WYT3-YtfOgWVrYxL3N8VQg-1; Thu, 30 Jun 2022 21:08:00 -0400
X-MC-Unique: WYT3-YtfOgWVrYxL3N8VQg-1
Received: by mail-lj1-f200.google.com with SMTP id
 l5-20020a2e8345000000b0025bce6dcde0so53028ljh.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 18:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lZzUciZDJ7qUGpwrJbdbnvPYQFAmuJY/A8ujZXjUH20=;
 b=RPymxVyBk/+iUxn+5uIt/66NT9VY7GiOipM9P6HV3hpduVcsk32DxgfMxUrZPbs11E
 QYP0MjdMy+GQne/9t0Sqn7BCZqKeig30sMdhRupM7rwn6MOro+zwxUFptgCO7n/rodxq
 eF9+ElQihY1gMYTrwvayhTkkDZkTuUkWh8hAGJqoxXxhPygQSo3V9awwucC4wQ+f7Mwt
 c1yhErAxTjz+8Qe9+a2KeFDR9aX+FgmoSs467s8/4eOdfu0pu9gxeYUw29CTQWK4h2z7
 Z67hNwPGB9hy9ZoR7Vw7WIoKAx8/VW7Py61VzB2UvzZKJenB9xL9PFyqj8DzHAsCA3FH
 KLuQ==
X-Gm-Message-State: AJIora9MvDvSE2oPXVy8Jq8MGnUFrq/KMOPYEwKqmLuLqTCG2deSm6Fb
 v/AV5A6Lpn6Djq1pPZkbX7opViCFivi8ty81ywgmE0U5lkVff1XNSagw2s1dNSHWaPBvv9+YBgw
 F+/9oaeggNqiwLnT//kW9LovwvHLdWDqPK0sAcit53c4/NvxguJM3Po83cA==
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7361324lfu.411.1656637679292; 
 Thu, 30 Jun 2022 18:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1toB1nW2NBVDvG6XfbzuIpDkAVyjnOPGmQL5GWlI8LDvk41Vdbw2Hd1Wd+7GUaoZYtT7I7ie0BytPeEGakgxcY=
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7361316lfu.411.1656637679072; Thu, 30
 Jun 2022 18:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220630191559.16738-1-mst@redhat.com>
In-Reply-To: <20220630191559.16738-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Jul 2022 09:07:48 +0800
Message-ID: <CACGkMEsLm=si3a8PiuAnkXxOud719_unNtQ7gbjAVD1ZVquf=A@mail.gmail.com>
Subject: Re: [PATCH] virtio: VIRTIO_HARDEN_NOTIFICATION is broken
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cornelia Huck <cohuck@redhat.com>,
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

On Fri, Jul 1, 2022 at 3:16 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This option doesn't really work and breaks too many drivers.
> Not yet sure what's the right thing to do, for now
> let's make sure randconfig isn't broken by this.
>
> Fixes: c346dae4f3fb ("virtio: disable notification hardening by default")
> Cc: "Jason Wang" <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index e1556d2a355a..afb9051e0125 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -31,11 +31,12 @@ if VIRTIO_MENU
>
>  config VIRTIO_HARDEN_NOTIFICATION
>          bool "Harden virtio notification"
> +        depends on BROKEN
>          help
>            Enable this to harden the device notifications and suppress
>            those that happen at a time where notifications are illegal.
>
> -          Experimental: Note that several drivers still have bugs that
> +          Experimental: Note that several drivers still have issues that
>            may cause crashes or hangs when correct handling of
>            notifications is enforced; depending on the subset of
>            drivers and devices you use, this may or may not work.
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
