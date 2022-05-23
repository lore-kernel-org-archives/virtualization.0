Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC47C433EF
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 04:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9420404F3;
	Mon, 23 May 2022 04:41:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rq-2wwgEXYUe; Mon, 23 May 2022 04:41:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F422404B3;
	Mon, 23 May 2022 04:41:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F335C0039;
	Mon, 23 May 2022 04:41:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5417C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 04:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACB0060B3A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 04:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e_IJpIlAFr7R
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 04:41:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0362608A5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 04:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653280879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=08y9EJtcz+7a/JcW5CAQJh1vaSn+lYtCa1y1S5/rUOM=;
 b=dOTxSxS1WagJmeEityGz2xpT572VJvoCT4WbLvvORnu5BDY6jQISUTPYdIrYH4AYuXUUO8
 N1LIuyNtz8szUiV6eVVA9lrPQ7kOmH/mYLV9kIs+EiA07gjrG1Xx7WEuGY01ehA8GSKnK+
 8xTBU9F8TGmXOpQrYvaRAnOwh04x8+w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-hmE5kC1tMUmqbhT0A2jcjw-1; Mon, 23 May 2022 00:41:18 -0400
X-MC-Unique: hmE5kC1tMUmqbhT0A2jcjw-1
Received: by mail-lj1-f197.google.com with SMTP id
 m11-20020a2ea88b000000b0024db6246908so2564064ljq.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 May 2022 21:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=08y9EJtcz+7a/JcW5CAQJh1vaSn+lYtCa1y1S5/rUOM=;
 b=Z6IghMotj/vAwrt3ui2GlXon5ZE2TkumE3aQGR696hinVUSUUWQY6m5HtHQzqS89Pp
 /ZlyJ46BB0fcAsTddW4cNVzaLOoCd9PBwjj2y7VXWjtz5k5igipFP+brSyYFdTN0UIGr
 EUcPmgu4jFGU1VTR0hzrp44+XTJ7wmD1vIccnlZdC+3id8pTjijBdOSl0nlfZAgIgiRw
 DVnidud5Nz0vAKMmsvnc0Rh2V/coFgti4DKPM1/qFx6m6XTrfV8gYPT8rteK6e29XQtU
 404kIOSKtUIE3jzaZhe76wz/aeEfUP2qAq+YHQfKqvsRqdDAx2JQURP0S06pO0Y6DrJU
 YhDQ==
X-Gm-Message-State: AOAM533z435UH9AnVW7y/GTOlavKNOh7Bh96dGz5+o1XKhU0Yw9wK9NJ
 QNy9o+l5Y0xyyCSFCrWEo3H6yL0USVWVbWjai53wZz5WkI1LFXoVezCmNGJUxSPruWK9OY5fNTf
 U09TzRsziC7vCXyCXPbYQvyRs3l335XHTmbXEwG8nYHGXxegnJpfDO29/QA==
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr15008565lfb.376.1653280875765; 
 Sun, 22 May 2022 21:41:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqRetp33JcfidVaUk+iFKExKrB3v7QK7jBSPRLyLJwJHS8cGFd1P5dpWd3xCNGBT0hiuY9YQ5gpi2GOTwnZdI=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr15008553lfb.376.1653280875600; Sun, 22
 May 2022 21:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <89ef0ae4c26ac3cfa440c71e97e392dcb328ac1b.1653227924.git.christophe.jaillet@wanadoo.fr>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 23 May 2022 12:41:03 +0800
Message-ID: <CACGkMEtvgL+MxBmhWZ-Hn-QjfS-MBm7gvLoQHhazOiwrLxxUJA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Fix some error handling path in
 vhost_vdpa_process_iotlb_msg()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Gautam Dawar <gautam.dawar@xilinx.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Sun, May 22, 2022 at 9:59 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In the error paths introduced by the commit in the Fixes tag, a mutex may
> be left locked.
> Add the correct goto instead of a direct return.
>
> Fixes: a1468175bb17 ("vhost-vdpa: support ASID based IOTLB API")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> WARNING: This patch only fixes the goto vs return mix-up in this function.
> However, the 2nd hunk looks really spurious to me. I think that the:
> -               return -EINVAL;
> +               r = -EINVAL;
> +               goto unlock;
> should be done only in the 'if (!iotlb)' block.

It should be fine, the error happen if

1) the batched ASID based request is not equal (the first if)
2) there's no IOTLB for this ASID (the second if)

But I agree the code could be tweaked to use two different if instead
of using a or condition here.

Acked-by: Jason Wang <jasowang@redhat.com>

>
> As I don't know this code, I just leave it as-is but draw your attention
> in case this is another bug lurking.
> ---
>  drivers/vhost/vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 1f1d1c425573..3e86080041fc 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1000,7 +1000,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>                 if (!as) {
>                         dev_err(&v->dev, "can't find and alloc asid %d\n",
>                                 asid);
> -                       return -EINVAL;
> +                       r = -EINVAL;
> +                       goto unlock;
>                 }
>                 iotlb = &as->iotlb;
>         } else
> @@ -1013,7 +1014,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>                 }
>                 if (!iotlb)
>                         dev_err(&v->dev, "no iotlb for asid %d\n", asid);
> -               return -EINVAL;
> +               r = -EINVAL;
> +               goto unlock;
>         }
>
>         switch (msg->type) {
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
