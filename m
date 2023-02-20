Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D29C64EC4
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 05:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9413B400FE;
	Mon, 20 Feb 2023 05:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9413B400FE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KQ/RDdw+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rebMckBHEryj; Mon, 20 Feb 2023 05:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4761B40B86;
	Mon, 20 Feb 2023 05:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4761B40B86
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11752C0032;
	Mon, 20 Feb 2023 05:38:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE366C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96FA260C2C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96FA260C2C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KQ/RDdw+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ks8ZbTHT2UtE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDB0A60AE6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DDB0A60AE6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676871520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=suC+HaliQaSgsRkgvalQUPVg1pbBf7+UTFGhnpw2uP0=;
 b=KQ/RDdw+0mPHqblR74M9jEe5GWq9a9yce+qbkvC4L4Bwc0OVTZVP3eIsOfplGsJS+o3hmV
 8qp05bgnDd+BfJzIVanvTYMnoVuSSi5+ccfeHRSg4zCpHNVUc/Vc3ALEc7R0LpRnBOFuZl
 bAgy4HR7Wy53vvFdy+OH/oQpff7h+Ak=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-13-sCBZ_3SEM1-J1IeImEuM5g-1; Mon, 20 Feb 2023 00:38:39 -0500
X-MC-Unique: sCBZ_3SEM1-J1IeImEuM5g-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-171dc4cffd1so615164fac.15
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 21:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=suC+HaliQaSgsRkgvalQUPVg1pbBf7+UTFGhnpw2uP0=;
 b=8Nxa/KGW/UVQg5XA0Lrot1JPmH5Im69Qz5cl0PUGFz0Vf41QOm58c2T3UztlpN1yZy
 LdUkjP15uWBuUxsibnfOwUtV2pIzjB726llsam4Y/xLtllL6MwJJd0qEkL9I2engPkOF
 FRzVK7/b5GiAu5QVXOxs+5BsoVJrekAiO1I2KfKY0aG0fA/qE0R+xkKplgp7vwqPf8v4
 EL62uNmJpcyBwZD2ICB1//v27/GcOQTroMCmgDlDQG7ApuIj3GWc7NyND9hs7qRJweAh
 clRFnLQXIiKoEqz4uGKdvzK1zRtP1r+vAPWXgybvLwBo1MG8wXaf1VSz0erdl6ebMNR1
 hraw==
X-Gm-Message-State: AO0yUKXcaQAbBGesEHYhcZPNX5GfSv2wsMP4CCf6MdoX8RahBEGO4JZ5
 O/CphoIJxi/8IFHoMVXE2MYTHuW3oN2b0ApZH6Tw00+eLNTxclPCRSMiTgv9JKO03efZTe8z/mr
 xq8FyVE+e7GssnP/exBrQ0YLxYkwLleS3us2RyYlVIjYZAjGM57BMbD0Ap570mhBfTA==
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr240636oae.217.1676871518511; 
 Sun, 19 Feb 2023 21:38:38 -0800 (PST)
X-Google-Smtp-Source: AK7set9GWR7uo/nSK05NV/nfKEvC9BuDq7jbJJV32ZPMfMBj902dj9R3J3nzM9b8iISm9wjCXaxYVYWwiEPkJwQtyGk=
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr240634oae.217.1676871518264; Sun, 19
 Feb 2023 21:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 13:38:27 +0800
Message-ID: <CACGkMEt2rg7Pe+H-sFyAFRV7KZWHNm4K0NQOZCtNdDVGCyMBjA@mail.gmail.com>
Subject: Re: [PATCH vhost 09/10] virtio_ring: correct the expression of the
 description of virtqueue_resize()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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

On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Modify the "useless" to a more accurate "unused".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 84129b8c3e2a..2ba60a14f557 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2865,7 +2865,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
>   * virtqueue_resize - resize the vring of vq
>   * @_vq: the struct virtqueue we're talking about.
>   * @num: new ring num
> - * @recycle: callback for recycle the useless buffer
> + * @recycle: callback to recycle unused buffers
>   *
>   * When it is really necessary to create a new vring, it will set the current vq
>   * into the reset state. Then call the passed callback to recycle the buffer
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
