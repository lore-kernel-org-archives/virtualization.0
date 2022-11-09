Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E2AC4332F
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 03:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E05781EA4;
	Wed,  9 Nov 2022 03:29:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E05781EA4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V3juxFVu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SkVyKXg4w8C1; Wed,  9 Nov 2022 03:28:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8CE381EA7;
	Wed,  9 Nov 2022 03:28:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8CE381EA7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96A28C0033;
	Wed,  9 Nov 2022 03:28:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED2F2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7BB981EA7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:28:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7BB981EA7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4u4U_KqO4O94
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:28:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A95381EA4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A95381EA4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 03:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667964535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vD224Hogxka5wNQa91Zymh6Ygmv+WpD4Z+GDd/Nec64=;
 b=V3juxFVuGEJHf/bS3/DHOMDIyh1qnJYhQ28drjtFqQKq07137+nMovEBFR79A9OvKyGZTg
 F6pOxv5sJnesbPpOQ8OnK7cMzEvHsUCaw9M1SRQ6QCmOPOlmO+X7lI7p/NXsQxSUNsOt4J
 S9BBKpoJSUFKKGsLTDJsSIgn35fVNjk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-a8IBpNF9PSCmH94W70PvkQ-1; Tue, 08 Nov 2022 22:28:54 -0500
X-MC-Unique: a8IBpNF9PSCmH94W70PvkQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 s5-20020a9d7585000000b0066c7a3ddf59so7788227otk.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 19:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vD224Hogxka5wNQa91Zymh6Ygmv+WpD4Z+GDd/Nec64=;
 b=ckWrWACTtPbtQgf3ts6IMInijfddb59uMwr1Jyy/UcJ0AeqLCqEAjBdesG69TO3UFH
 7FvFqcjMDAP4/sVJ17DWlUMgc0E6VA56FJ800U9rnjJSXDQKC4Agy2ZeJvmg/gJn66cf
 ZsRv3tMvxAR54DAHRr5WrtGFmtqBfxtuoWF0EAODumr2h4abTOckA4qvVmnOLisgHw/I
 5d0qu2mx6GgVVDFRguykf/kftEWuLqrXgqJqsev2bN/4x97Yf/tT3pZqaZjGry3MLmD8
 oyXpYg2xfQ4vEkYTn9XDkkzAYay3ipwPzoKoGK3ppD5N/Zz0FlXMi7ParduwSs7JZUhX
 S53A==
X-Gm-Message-State: ACrzQf0KWUMz+dx6BptSMV2RhTLGlxMibKvuL+M6H+IIbxzBEJwFKhWT
 dbCqAl/9+CQIGdwZlYO59FXKi7LoKjmvUU7gys2iVAa+Xz2tL+Y3hqTewEi6qNRXQmr3TMtWFAw
 9ZDpyvanvlF/0UCzRuw62IhjznHRwZAnVHUVe5Os4yFl5iLdsjrGtyCFf2A==
X-Received: by 2002:a4a:2ccf:0:b0:49e:b502:3a2b with SMTP id
 o198-20020a4a2ccf000000b0049eb5023a2bmr9793075ooo.57.1667964533310; 
 Tue, 08 Nov 2022 19:28:53 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7F+ESUW02GevhFXeHeZiWN+C8qmGvnQrxAgchRgTHWuxrTWr/5I2RPYR7pW6CVQHNQHYEXuWSbcbl1kJXQxyk=
X-Received: by 2002:a4a:2ccf:0:b0:49e:b502:3a2b with SMTP id
 o198-20020a4a2ccf000000b0049eb5023a2bmr9793067ooo.57.1667964533083; Tue, 08
 Nov 2022 19:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20221108103437.105327-1-sgarzare@redhat.com>
 <20221108103437.105327-3-sgarzare@redhat.com>
In-Reply-To: <20221108103437.105327-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Nov 2022 11:28:41 +0800
Message-ID: <CACGkMEuRnqxESo=V2COnfUjP5jGLTXzNRt3=Tp2x-9jsS-RNGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vhost: fix range used in translate_desc()
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

On Tue, Nov 8, 2022 at 6:34 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> vhost_iotlb_itree_first() requires `start` and `last` parameters
> to search for a mapping that overlaps the range.
>
> In translate_desc() we cyclically call vhost_iotlb_itree_first(),
> incrementing `addr` by the amount already translated, so rightly
> we move the `start` parameter passed to vhost_iotlb_itree_first(),
> but we should hold the `last` parameter constant.
>
> Let's fix it by saving the `last` parameter value before incrementing
> `addr` in the loop.
>
> Fixes: 0bbe30668d89 ("vhost: factor out IOTLB")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>
> I'm not sure about the fixes tag. On the one I used this patch should
> apply cleanly, but looking at the latest stable (4.9), maybe we should
> use
>
> Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")

I think this should be the right commit to fix.

Other than this

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Suggestions?
> ---
>  drivers/vhost/vhost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 40097826cff0..3c2359570df9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2053,7 +2053,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>         struct vhost_dev *dev = vq->dev;
>         struct vhost_iotlb *umem = dev->iotlb ? dev->iotlb : dev->umem;
>         struct iovec *_iov;
> -       u64 s = 0;
> +       u64 s = 0, last = addr + len - 1;
>         int ret = 0;
>
>         while ((u64)len > s) {
> @@ -2063,7 +2063,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
>                         break;
>                 }
>
> -               map = vhost_iotlb_itree_first(umem, addr, addr + len - 1);
> +               map = vhost_iotlb_itree_first(umem, addr, last);
>                 if (map == NULL || map->start > addr) {
>                         if (umem != dev->iotlb) {
>                                 ret = -EFAULT;
> --
> 2.38.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
