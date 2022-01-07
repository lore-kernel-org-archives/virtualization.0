Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D722C433EF
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 02:34:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B87D640186;
	Fri,  7 Jan 2022 02:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cZR6Xk78mxPf; Fri,  7 Jan 2022 02:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A1804040D;
	Fri,  7 Jan 2022 02:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE8AEC0030;
	Fri,  7 Jan 2022 02:34:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3286CC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C8BD42995
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:34:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BcGIJUSi0kLS
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:34:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68FC042986
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641522862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gukSGapSoGJbsOoSIlY9+yDTYqhJluxlGmKYG1ZWqag=;
 b=YI4F8Tne0KXVnOYKUPknt1aIWu7v+wIWPq8F9rMxxb1Wbd3hrkO8f/RMJLxfGz9dnDlJAp
 BBliVjGfzFRLwrrAl6xj9H4L2BB7JbMzSIRCY/onfIgiDB5C8BdCANMndveVL0sXmppSrG
 c//HU+h5oMdXTKPxvIt35JNjxB8Deyg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-QqfxrFDrP4--GtgR-QxPrQ-1; Thu, 06 Jan 2022 21:34:19 -0500
X-MC-Unique: QqfxrFDrP4--GtgR-QxPrQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 f17-20020a05651232d100b00429623cf219so1316803lfg.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 18:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gukSGapSoGJbsOoSIlY9+yDTYqhJluxlGmKYG1ZWqag=;
 b=BMbFVzypjmfrGRX1lRJXA0yCEhNx8/1VFzip05tgj2+l2FT1qKIsy+2xZs2yc75Vsg
 /p/rG//Kic3SdSD1zn9dfHD5lwMmkF8lHhGA2I+nY8lKQk3rCT9rAuUJYsYOlwSdpcIU
 k9pxOxeYzOaro4C3KUKGpFEbw/k4XKVegPInUDhuH7BA8C+/WnYAT52h3z0mqTzOyURe
 CSUee2znPI/35yoP45ypmuZcPAjgLmBZhuCXBsDwgLCxIVsEYzOXozBmZCEJkPru8tDq
 m/oKbf1aY9lTn/uahG46yJXyLK8IA+UWmo/6uJX/C5LSmuCtV7n8oorjrTuRLFDw27jY
 wyEg==
X-Gm-Message-State: AOAM533wrBApglcsCW9jBY+MEGg4fVxo+Q7hdBE9Fj2fggzvB8jvsvBq
 VQ4qa9iPnhMFb8XWxtEtnpw3FrB8aK7kZ4jBZPxbakCAmtinAcfEAd2B9KbiHVz/ugSPyyuO0fc
 SMWkOfEPX+aMmXqoWIVR2Cy5YxcAkZZLewoOuUuOPBYEXcl+xbQLUCv6HDQ==
X-Received: by 2002:ac2:5a4e:: with SMTP id r14mr52548504lfn.498.1641522857286; 
 Thu, 06 Jan 2022 18:34:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB6ZzpEeRHQ37DNlNp3pKZLLyLn7ryO1J7eQBa6wklXIDOHOoLYJpdwYxb3tIpS8fIRfCBixN3t3rxE1aWYtQ=
X-Received: by 2002:ac2:5a4e:: with SMTP id r14mr52548496lfn.498.1641522857110; 
 Thu, 06 Jan 2022 18:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20220106083123.4064853-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220106083123.4064853-1-xianting.tian@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jan 2022 10:34:06 +0800
Message-ID: <CACGkMEuW5po+v-fFPNH6wtVVXD84Bx0UWhe86sHFYXQM39OKRA@mail.gmail.com>
Subject: Re: [PATCH] virtio-pci: fix memory leak of vp_dev
To: Xianting Tian <xianting.tian@linux.alibaba.com>
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

On Thu, Jan 6, 2022 at 4:31 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> In virtio_pci_probe(), vp_dev will not be freed if it goes to
> "err_register" branch. fix it
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>

So we had this:

commit 33635bd976fb4c3ccf0cfbb81a8d29bb87760607
Author: weiping zhang <zhangweiping@didichuxing.com>
Date:   Thu Dec 21 20:40:24 2017 +0800

    virtio_pci: don't kfree device on register failure

    As mentioned at drivers/base/core.c:
    /*
     * NOTE: _Never_ directly free @dev after calling this function, even
     * if it returned an error! Always use put_device() to give up the
     * reference initialized in this function instead.
     */
    so we don't free vp_dev until vp_dev->vdev.dev.release be called.

    Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
    Reviewed-by: Cornelia Huck <cohuck@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Any reason that the above fix is wrong?

Thanks

> ---
>  drivers/virtio/virtio_pci_common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index fdbde1db5..48b5ac15e 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -602,8 +602,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  err_enable_device:
>         if (reg_dev)
>                 put_device(&vp_dev->vdev.dev);
> -       else
> -               kfree(vp_dev);
> +       kfree(vp_dev);
>         return rc;
>  }
>
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
