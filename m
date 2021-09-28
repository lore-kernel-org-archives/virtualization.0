Return-Path: <SRS0=Y9jr=OS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA87C433EF
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 03:15:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8738F61279
	for <virtualization@archiver.kernel.org>; Tue, 28 Sep 2021 03:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8738F61279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AB77406FA;
	Tue, 28 Sep 2021 03:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8eEkg7KWMrTX; Tue, 28 Sep 2021 03:15:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD116406F5;
	Tue, 28 Sep 2021 03:15:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9454C0011;
	Tue, 28 Sep 2021 03:15:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 949B3C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76FCB406F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M5gWeFHsjR_c
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:15:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7DCF406F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 03:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632798901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZSY+vcJW5NdCU6PAh3xBtVmIDzT9CkSN9jgG+3LcBnI=;
 b=C1jAQT1UQdyK7XDznTiBpyy2hisfyT9LMoH5ENmbRvLxVhP+is5aw+eYTiI6osGazZiOcC
 5mJGFtVjPYBPwOS6e6DgJoUh2cY1ulKbuO/ciPh4HAdKJIWxLGfZv1O+rlj1f4g/IDb6A/
 GL667YYHJ8t0tjdSr5iRds+EHIwDLd8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-mUG9l4A_NmeOLJaQ0f4HJw-1; Mon, 27 Sep 2021 23:15:00 -0400
X-MC-Unique: mUG9l4A_NmeOLJaQ0f4HJw-1
Received: by mail-lf1-f70.google.com with SMTP id
 t187-20020a19c3c4000000b003fc1361fb20so17904266lff.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 20:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZSY+vcJW5NdCU6PAh3xBtVmIDzT9CkSN9jgG+3LcBnI=;
 b=vXCETMm5ewi3/ocXdSNyHoy7NEsRVs+2Ery9nFINYO2B9KKSupqS9LoAGCm7/8IHsp
 6ZEupCsufWVYqXKNHARnDA4XfCQwc54AvbmwS/Cx5imvmQrjw4Y1Y1aPnP0+dCPNeF+T
 W3vcM32ymOnBusXZPyDFTCZZC7TQ+C4/us/X7H4NmZGWCdBYM6MC02ojRKoSYgzjc/b7
 UCTM6jmk3lRYq1WUXvFbqX3PBRXnoAjLAB5Ry+Etci9XxlVlJc3nIzG6Owd8xkS/ON4C
 xoqU93RdPNKmtt4Joul1GalYUstUoi52BVnRvQHJOk9OqXeE5NzsbG7YFxWTH7RexzTq
 wFIw==
X-Gm-Message-State: AOAM533gds5k5uZPS5HopQONOrjNzTiAxbkpYRGysjTUK6FOGIElAyko
 lLPc6CZNdlnXuE5ObfRKM0T1gPtFvFZ8yi1dfvRUQwdRFGRAb8dQ7dh9rFbcAfDNxmNnC1n7mNn
 cMOurXZTYoD6JXCUMGo/tjdZ7gWw2eCJ7Wl7q0VNQE1vgM438WIEg0M3jcw==
X-Received: by 2002:a2e:b88a:: with SMTP id r10mr3437078ljp.362.1632798898749; 
 Mon, 27 Sep 2021 20:14:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgpZOzUWbd8nE1miZ2csPVIHVmhla0Npo/7IX/kvR5wcIFc/7yCjVNIlSP3sR6Tg9cMSH0fKVJ2/NbnJQqPdA=
X-Received: by 2002:a2e:b88a:: with SMTP id r10mr3437065ljp.362.1632798898598; 
 Mon, 27 Sep 2021 20:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210927105412.18579-1-xuanzhuo@linux.alibaba.com>
 <20210927105412.18579-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210927105412.18579-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 28 Sep 2021 11:14:47 +0800
Message-ID: <CACGkMEvA4GjbFyftndGVAWnPWP6pMy4o35xKtVhrjmmNE-uLvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] virtio_ring: fix style of
 virtqueue_add_indirect_packed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
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

On Mon, Sep 27, 2021 at 6:54 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Fix the style problem of virtqueue_add_indirect_packed(). The next patch
> involves the modification of this function.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Jason Wang <jasowang@redhat.com>

>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd95dfd85e98..91a46c4da87d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1050,12 +1050,12 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
>  }
>
>  static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
> -                                      struct scatterlist *sgs[],
> -                                      unsigned int total_sg,
> -                                      unsigned int out_sgs,
> -                                      unsigned int in_sgs,
> -                                      void *data,
> -                                      gfp_t gfp)
> +                                        struct scatterlist *sgs[],
> +                                        unsigned int total_sg,
> +                                        unsigned int out_sgs,
> +                                        unsigned int in_sgs,
> +                                        void *data,
> +                                        gfp_t gfp)
>  {
>         struct vring_packed_desc *desc;
>         struct scatterlist *sg;
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
