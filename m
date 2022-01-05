Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854C8C433EF
	for <virtualization@archiver.kernel.org>; Wed,  5 Jan 2022 03:20:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 044BB8293F;
	Wed,  5 Jan 2022 03:20:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y0YrkVNNmjCy; Wed,  5 Jan 2022 03:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F7E7828B5;
	Wed,  5 Jan 2022 03:20:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5C3C002F;
	Wed,  5 Jan 2022 03:20:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F740C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 03:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62911415FB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 03:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DpKv4IRd_xRm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 03:20:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A050415FA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Jan 2022 03:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641352835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EV+4L4V3EbdXjbiDS2bLBmpAyubhZUkCxgXn/7JcQ3s=;
 b=FRlknS2CovWQ50MnffuSrJU62pPgJ0YzsGz49CXCq6Pz+KV3hXneZT4QCelH5TZWiwxMni
 eZCes2eRP/0OtWvTFLS4T0+cSRnedC54tEQJXFojLlcUQtvPihXvqyIKL7LzW/uTh3Hr/5
 dpuT0N4ruZy49AtAD8B2n5rmnKUcooI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-kZSw5m2POBKS10Gc1Lrpmw-1; Tue, 04 Jan 2022 22:20:34 -0500
X-MC-Unique: kZSw5m2POBKS10Gc1Lrpmw-1
Received: by mail-lf1-f70.google.com with SMTP id
 r21-20020ac25f95000000b004259e6ab262so8821243lfe.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jan 2022 19:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EV+4L4V3EbdXjbiDS2bLBmpAyubhZUkCxgXn/7JcQ3s=;
 b=LOkKw6xhFYPXje7x7dMDHxFNKI/MM6tcxbmbSWVPCsnQ5+uu5AhqCBctp2v3lGPw1+
 wf6CZ69HJ8z126eNkscvLUOq1sh5nwnt73JNx3xsKxNgzOE/9xnXWF13h5ujSWJu1twF
 fHeGwPCR34VLuTR6asxhPDJWrWwEq8Sg8bTX1LyowkvQVFfk/s+4WB3nyqKMtb9fjz2U
 7Tw+J2lpqcpRfmmC3wvWk5c19e6O1p7GZGyUyV3vnzQhjdPk+gHkRM9BYPrsTKa3U5tE
 g6e70PL6LPF6yEfj5uwgM2flTyabsqHx+meq9HynTCJVFxb/Ld8l1ybOz7Mh7retM8S7
 GrQg==
X-Gm-Message-State: AOAM533XRpmXpEKp1z8NK5CTJ0XYS/JmHZu/FJKjemoMiw7cPFfw4fmG
 qcFO+v/boHUfObiegTYonhx1BAZtEYV2n/Q7GXYsQK+SoDtEXhgYFTDdNdLYgwl5mylSiahbr4+
 SJ5bAf2wHYe7pQDmT7QZo2xDixPQMPel8/biURbbAqEAWwFm6fY0cFKxhMg==
X-Received: by 2002:a2e:a177:: with SMTP id u23mr16009625ljl.217.1641352832658; 
 Tue, 04 Jan 2022 19:20:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUQbE7b2+xQ4lqIM1r/2/rFDsfrFuYo71pp02AsvjbJyrfkhtBFuB2kvLjfNaqo/yGETaXf2YgGdMIUwsDKZY=
X-Received: by 2002:a2e:a177:: with SMTP id u23mr16009618ljl.217.1641352832413; 
 Tue, 04 Jan 2022 19:20:32 -0800 (PST)
MIME-Version: 1.0
References: <20220104151251.1988036-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20220104151251.1988036-1-jiasheng@iscas.ac.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 5 Jan 2022 11:20:21 +0800
Message-ID: <CACGkMEtZsBPnzLiTnMGAwrbC2Sjqj2mh6+L56BR4qqLyDXrxTQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_ring: Check null pointer
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

On Tue, Jan 4, 2022 at 11:13 PM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>
> As the alloc_indirect_packed() returns kmalloc_array() that could
> allocation fail and return null pointer, it should be check in order to
> prevent the dereference of null pointer.
>
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> v2: Remove the redundant empty line.
> ---
>  drivers/virtio/virtio_ring.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..2923d8a68dc3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -992,6 +992,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>
>         head = vq->packed.next_avail_idx;
>         desc = alloc_indirect_packed(total_sg, gfp);
> +       if (!desc) {
> +               END_USE(vq);
> +               return -ENOMEM;

Just notice this:

My tree contains this commit: fc6d70f40b3d0 ("virtio_ring: check desc
== NULL when using indirect with packed"). It has fixed the wrong
error value but not the END_USE().

Thanks

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
