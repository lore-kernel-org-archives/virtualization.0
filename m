Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DB9C4708E
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 09:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E62B5418A1;
	Thu,  1 Dec 2022 09:02:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E62B5418A1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIiuMntj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I092vidlw08k; Thu,  1 Dec 2022 09:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 14E29417AA;
	Thu,  1 Dec 2022 09:02:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14E29417AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAB4DC0033;
	Thu,  1 Dec 2022 09:02:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8F21C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:02:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF72A400D1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:02:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF72A400D1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIiuMntj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hGGQOdF_8zfD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:02:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0754B400C8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0754B400C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669885332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbYH4zENy89CzwfflFgwIWWGhamSM9hTJZawssPcIIk=;
 b=EIiuMntjLoOIJmbm2u6Q1t5X80cuQxM+djRxWzpRJ3SWGFNyEoJJNfgt34EcB7QWHWXaz+
 Iqwnw3sjxy4iA4Y73dKR1aeXE7bH8vYx08c3v7L6ZU+rvtp2oBxkLVnRVmxkm4OdkyKnrZ
 mJusS7r+ZYx1XjQSnkJxai/6pZ+z6dc=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-48Z6L5-5M2Syl5WIwLHmLg-1; Thu, 01 Dec 2022 04:02:10 -0500
X-MC-Unique: 48Z6L5-5M2Syl5WIwLHmLg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-13ca47a9815so595103fac.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 01:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GbYH4zENy89CzwfflFgwIWWGhamSM9hTJZawssPcIIk=;
 b=JZTtYlafxaabrYPr+nOwjdKxbJWTCjBPcMaqF6mIzdPek/iT6X6kgvUoAsBuFGU+J/
 Wj2gB/JcLMskkhYltFb4endbWu6y6GI+l6b7RUfwuHVMUL/zYaKAQAUbdgxIo9MxFbFq
 xF087e7kvFBe6LmenkFwM81gu1D6GAuYb8cxa2F93fItu3BO7T/vhnXBUZsyYi9A4ReD
 ZZq5oFMpJJhw1i0uXBW0YZGCZENu2NpgPLqdrttHS+fUwqsr4zv3rNgMKTI3xFoFEHJR
 Pcg9XGVLEbHKoFTzrM8wCOOdxh2wR4FWlI2FQhH0krQFMUU8KQAk3ZAVEuK67wL7aqWV
 dfow==
X-Gm-Message-State: ANoB5pkcnAqHRS9TYRDwwBOMGkddfvMUbe5FdcimERa5MjlnZJ9+cTZn
 nvQ2PbWvabu77WYL0ROoLmXDdi2Sx3oaAoFlcZMyde/0mPn8OxWnCXlZFRAHXuqMn9/j58hGfct
 1X11u8xhFWFe8mYofcuJrRVSjXYOX0E3BoHPVuYxZ46Tb2nh7/kQt64ye4w==
X-Received: by 2002:a05:6870:1e83:b0:132:7b3:29ac with SMTP id
 pb3-20020a0568701e8300b0013207b329acmr25998079oab.35.1669885330135; 
 Thu, 01 Dec 2022 01:02:10 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7tUBOklO4FBQwcg/EeqBEyl7DGUatKoKhFtd+FqPjTxyHkl7yQq5uNlEzKseBa4w5SnURhdbimUzdSSGOuqsc=
X-Received: by 2002:a05:6870:1e83:b0:132:7b3:29ac with SMTP id
 pb3-20020a0568701e8300b0013207b329acmr25998067oab.35.1669885329828; Thu, 01
 Dec 2022 01:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
In-Reply-To: <20221123102207.451527-1-asmetanin@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Dec 2022 17:01:58 +0800
Message-ID: <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
To: Andrey Smetanin <asmetanin@yandex-team.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yc-core@yandex-team.ru
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

On Wed, Nov 23, 2022 at 6:24 PM Andrey Smetanin
<asmetanin@yandex-team.ru> wrote:
>
> Fix possible virtqueue used buffers leak and corresponding stuck
> in case of temporary -EIO from sendmsg() which is produced by
> tun driver while backend device is not up.
>
> In case of no-retriable error and zcopy do not revert upend_idx
> to pass packet data (that is update used_idx in corresponding
> vhost_zerocopy_signal_used()) as if packet data has been
> transferred successfully.

Should we mark head.len as VHOST_DMA_DONE_LEN in this case?

Thanks

>
> Signed-off-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> ---
>  drivers/vhost/net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 20265393aee7..93e9166039b9 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -934,13 +934,16 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>
>                 err = sock->ops->sendmsg(sock, &msg, len);
>                 if (unlikely(err < 0)) {
> +                       bool retry = err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS;
> +
>                         if (zcopy_used) {
>                                 if (vq->heads[ubuf->desc].len == VHOST_DMA_IN_PROGRESS)
>                                         vhost_net_ubuf_put(ubufs);
> -                               nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
> -                                       % UIO_MAXIOV;
> +                               if (retry)
> +                                       nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
> +                                               % UIO_MAXIOV;
>                         }
> -                       if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> +                       if (retry) {
>                                 vhost_discard_vq_desc(vq, 1);
>                                 vhost_net_enable_vq(net, vq);
>                                 break;
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
