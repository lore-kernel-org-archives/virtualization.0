Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77570C433F5
	for <virtualization@archiver.kernel.org>; Tue,  4 Jan 2022 03:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00B1A401CE;
	Tue,  4 Jan 2022 03:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cjFHqgKEPqVV; Tue,  4 Jan 2022 03:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 989154018B;
	Tue,  4 Jan 2022 03:42:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7ACB9C0030;
	Tue,  4 Jan 2022 03:42:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2929C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 03:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEC83400F5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 03:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8hBVBk3jXAJ7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 03:42:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11218400BA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 03:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641267735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwFXhGn57Ik/8yv+mERRlVV9PBTKn9DgoCqspftrb0U=;
 b=a8pJqXHPzDmTB6PBuBnPCPBYPUIkfewqfGlMHZqXtDM+f2GJ4b/0Kn9iQhToWzJIusdOAp
 8nla3y5ZbYd0MEOfioO7ZljY4SgUFLXahA78b3jWVmws3m+4P00vysqiKxoaGbwpATGGiX
 mnX1+09FlqnGMiH3dJXihGLJQIk/Ey0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-QGp3HS3_P_2iwbS_z6Fpqg-1; Mon, 03 Jan 2022 22:42:14 -0500
X-MC-Unique: QGp3HS3_P_2iwbS_z6Fpqg-1
Received: by mail-lf1-f72.google.com with SMTP id
 t196-20020a19c3cd000000b0042a2598bebaso2990052lff.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jan 2022 19:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SwFXhGn57Ik/8yv+mERRlVV9PBTKn9DgoCqspftrb0U=;
 b=LmjNqAJoPpvzX9B2Wp71vDlSZ9I0+HdnHCS9YN4XaKedHUbHiR9/S+q3ohTe+35+9G
 EN1Nj2YouyZNItS85JgKKCeVDveT/JHJgwKBaaxlDHpgeGUk2RwSNWPkS22NDHBOtGFq
 7vvwOIPwl7/Qwgm58WrOUsLiTEqikdTqNOgO8vQm7gxm4oYgV4XzoTE7FW5mPlfAj6QI
 TGaL82qwIzNKZpQrg9JI+X8f5SN9hAUfPL8o2yIoJdjz7d2KQ9hRFpCUuzEOAdg6ONCD
 vc03fU4WlT1XsnfSen3jF+jE42Pnd78IbGzB9DwUI0cHT9UvYqgkNk42nJRGbv35uKCJ
 JRiA==
X-Gm-Message-State: AOAM533/uHgmHXnL/zaRYcii2ZvZX5Rj/n2ddA516sys15Rm/BQmdRV0
 rANnH1Y8HM20XVyuv9TBg/C9whj5rSD8Cbt/Uho+80wLNbIv6xpXQGh8/lGPpHi5aKBFDIqCMiM
 q17agCRlFemLFiG+7qo3eBh44gkKgMBUXn17rYeeDK8vdWm9bZSjE5Ks0Kw==
X-Received: by 2002:a05:651c:1a0d:: with SMTP id
 by13mr31580403ljb.107.1641267733037; 
 Mon, 03 Jan 2022 19:42:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx90ph1BuLv80bniEX7O6j0IQH75tTw6Q0lIGjPvVyZoAE/LEns1b2VVRYEkf3ISCOL4yV/IMQfDl7AdFba/cw=
X-Received: by 2002:a05:651c:1a0d:: with SMTP id
 by13mr31580400ljb.107.1641267732858; 
 Mon, 03 Jan 2022 19:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20211224101007.1635703-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211224101007.1635703-1-jiasheng@iscas.ac.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Jan 2022 11:42:01 +0800
Message-ID: <CACGkMEuTn4uaS5dfudF-X-Y0Rw0wH9VXcTkVsZJ_TUtxXGMBVw@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Check null pointer
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
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

On Fri, Dec 24, 2021 at 6:10 PM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the alloc_indirect_packed() returns kmalloc_array() that could
> allocation fail and return null pointer, it should be check in order to
> prevent the dereference of null pointer.
>
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/virtio/virtio_ring.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..30fd925165ac 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -991,7 +991,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>         dma_addr_t addr;
>
>         head = vq->packed.next_avail_idx;
> +

Unnecessary changes.

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

>         desc = alloc_indirect_packed(total_sg, gfp);
> +       if (!desc) {
> +               END_USE(vq);
> +               return -ENOMEM;
> +       }
>
>         if (unlikely(vq->vq.num_free < 1)) {
>                 pr_debug("Can't add buf len 1 - avail = 0\n");
> --
> 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
