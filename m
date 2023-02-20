Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0087EC05027
	for <virtualization@archiver.kernel.org>; Mon, 20 Feb 2023 05:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B47F60BBF;
	Mon, 20 Feb 2023 05:38:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B47F60BBF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fktR71Gs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wEzvAXtsNQGp; Mon, 20 Feb 2023 05:37:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 12D5E60DFF;
	Mon, 20 Feb 2023 05:37:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12D5E60DFF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E37CDC0032;
	Mon, 20 Feb 2023 05:37:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12823C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC93C41516
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:37:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC93C41516
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fktR71Gs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Aaq0HM5rnw3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:37:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDC71415DA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDC71415DA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Feb 2023 05:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676871475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5gr/TcBvqvcyZ841Q2p1ezNIoEGOmlD3C1Xmab15n0E=;
 b=fktR71GsmQqA+xr5lGi96+yM/u1tpjy6czUv+i5BLO0N0j3YKBnvyYsqdx8cKRj/46sjvp
 Oy8uN2U1Tg1bXrJJFozPaObd5Xvox9FAXC1lriwr8d181iBuYXjaO48Eg0Jj/iQCCx/aaE
 u0MjYhZIF4X7g+VcmC7WbXjVXp7T63c=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-203-STz5PJcOPuKGB168dITynQ-1; Mon, 20 Feb 2023 00:37:54 -0500
X-MC-Unique: STz5PJcOPuKGB168dITynQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-171f4af1316so373384fac.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Feb 2023 21:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5gr/TcBvqvcyZ841Q2p1ezNIoEGOmlD3C1Xmab15n0E=;
 b=0WG+9vBwPqOg+/7DBTqobwugNujfm5h9riRVdFru7bb6MvhmWNHArCJt4qbX2m3Wdu
 Em4itLbGPM2YE4Y7rh1sKBCSFnx7GsbB1LlCT1CzXUJWI7muceWxIwB50aiDInKa8pyz
 59oMF9aTnUz1U8h92v2o8RDqampCmeoKVHNOHyR0YfzJK700abg1B+Bc0CjRFPddoq8M
 N34hssuwLzPF3Qs+iKRqBgBwySdflsonQjQfshpe4OkC4K3BLDaQJQWoDVb6fS0/XTJK
 49/C63I4x3NKMYhiEi0HDlQtZ7ATZvrP52W1QZbld7gzS0aVH6EtT4r0iziP0lQo+wOf
 EpxA==
X-Gm-Message-State: AO0yUKWOBsAjM/rNNMKfC2iq6eevRObujTlT02B9cyLpCX3uA7l0Rizj
 zD3b7gFRGrmmqNVBOACC9ARirT4WsRkNyc5a/s3KpiWVZV+TzfN9PHoXakw/L5UBauwrcVbzl0R
 QwQY3+9YdjhelOV7yXV+QwlBye4xQz0+gACGP2kb+GOHp61/RYB6NRBsLnA==
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr240535oae.217.1676871473527; 
 Sun, 19 Feb 2023 21:37:53 -0800 (PST)
X-Google-Smtp-Source: AK7set/V51Lmck/DYbYOY0rYpD2KP4S3HOtvSVAKaSb+GAK0JuuaqUExzOteAy3RxUsKXjN9y9D9B/Wk/QBz6fhLUmM=
X-Received: by 2002:a05:6870:610c:b0:171:d1a1:c5cb with SMTP id
 s12-20020a056870610c00b00171d1a1c5cbmr240531oae.217.1676871473144; Sun, 19
 Feb 2023 21:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <20230214072704.126660-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230214072704.126660-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Feb 2023 13:37:41 +0800
Message-ID: <CACGkMEu9f6kTuMXSk=KguqS3rzYHEx72OjFfFzD=Ao4K33G8=A@mail.gmail.com>
Subject: Re: [PATCH vhost 02/10] virtio_ring: packed: separate prepare code
 from virtuque_add_indirect_packed()
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
> Separating the logic of allocating indirect desc and checking queue
> status to the upper layer function.
>
> The proposal of this is convenient to refactor virtqueue_add_packed()
> for premapped.
>

Ok, so this is another hint that we should do the same thing for split.

Thanks


> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 560ee30d942c..42b1ff87518e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1330,25 +1330,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>                                          unsigned int out_sgs,
>                                          unsigned int in_sgs,
>                                          void *data,
> -                                        gfp_t gfp)
> +                                        struct vring_packed_desc *desc)
>  {
> -       struct vring_packed_desc *desc;
>         struct scatterlist *sg;
>         unsigned int i, n, err_idx;
>         u16 head, id;
>         dma_addr_t addr;
>
>         head = vq->packed.next_avail_idx;
> -       desc = alloc_indirect_packed(total_sg, gfp);
> -       if (!desc)
> -               return -ENOMEM;
> -
> -       if (unlikely(vq->vq.num_free < 1)) {
> -               pr_debug("Can't add buf len 1 - avail = 0\n");
> -               kfree(desc);
> -               END_USE(vq);
> -               return -ENOSPC;
> -       }
>
>         i = 0;
>         id = vq->free_head;
> @@ -1470,11 +1459,17 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>         BUG_ON(total_sg == 0);
>
>         if (virtqueue_use_indirect(vq, total_sg)) {
> -               err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> -                                                   in_sgs, data, gfp);
> -               if (err != -ENOMEM) {
> -                       END_USE(vq);
> -                       return err;
> +               desc = alloc_indirect_packed(total_sg, gfp);
> +               if (desc) {
> +                       if (unlikely(vq->vq.num_free < 1)) {
> +                               pr_debug("Can't add buf len 1 - avail = 0\n");
> +                               kfree(desc);
> +                               END_USE(vq);
> +                               return -ENOSPC;
> +                       }
> +
> +                       return virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
> +                                                            in_sgs, data, desc);
>                 }
>
>                 /* fall back on direct */
> --
> 2.32.0.3.g01195cf9f
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
