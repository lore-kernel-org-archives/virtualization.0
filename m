Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D805C433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:42:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293DB604DA
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 04:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 293DB604DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C790F404B5;
	Tue, 26 Oct 2021 04:42:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxXNt7rbgOCN; Tue, 26 Oct 2021 04:42:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 75E8A404AB;
	Tue, 26 Oct 2021 04:42:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54A52C0019;
	Tue, 26 Oct 2021 04:42:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 751FBC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DADC80FFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:42:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GcNK3Vck9Acc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:42:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3428C80EF9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 04:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635223321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aqjO2zU/25UEIyy0nM2px/ntQerARAVZfBrLiW6eI5I=;
 b=Z5vv2pdnIAUdVHXwdhu5jieKnMoBWagp4/QzC3RECA3387u2hGlfn8lpoggYosZ06TFqWJ
 PERP/RL+x/QmZ7vg0u5XmROrO96LamzTCfdhDoSwCRceH017qNLxcnenaXz5SELMWX67Ea
 QcNWyz9pWhaaZecNy4D0ZCLxZVeRDao=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-uYRuIjrPPAeCHprzjzoN7w-1; Tue, 26 Oct 2021 00:41:59 -0400
X-MC-Unique: uYRuIjrPPAeCHprzjzoN7w-1
Received: by mail-lf1-f69.google.com with SMTP id
 z7-20020a0565120c0700b003ffb3da4283so213245lfu.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 21:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aqjO2zU/25UEIyy0nM2px/ntQerARAVZfBrLiW6eI5I=;
 b=lnKrWh24//HVfy0CoFZKqfTtF2PNYpyqUrnMhcWnbsGjGVEhpOxVmvxxtrYCMoND5I
 S8RNc/z1WGIdM3egwaoK/ffc0ThB150Xn4ivQY5WqYh5VnNboED64Qup0tuW/gayWDAJ
 Q06MnElYZwIHQsWKZZ+SCzFvQ8DTev/5VOl9VCTjVtWF4VTaSiWwcZjxKNi2Fcw2YaEt
 ddMEsLYBbOqsfAz7RpjTgqzRx4urtXLb/dxNXacPZ3Kl0mxMdqrfTs80CYKhfV5YnCra
 AJqEWV2Rt7apf4qdXu78SDiBUK2gaZ9z/dlK7WG7hlpXDxSDSrjlwkSBceueun3Sjbcu
 R3cQ==
X-Gm-Message-State: AOAM5314UHLjxnLwYSXaIJVDByt3UtpNu3su+Ci6F58zbZsh8VONJwDV
 PnDRiEwot4Be8hwqepr98ZDq/HEjvBN9gqZPG6VokBl+xKYQ28tD90zTkfWo4SCR2Dr8CqoPVu1
 1wSMn9IucglaaEpkWjZZwCeGfenzkB72aFi1eeNW4siozgKi4IAs/WgFXMA==
X-Received: by 2002:a2e:8605:: with SMTP id a5mr4832667lji.107.1635223318011; 
 Mon, 25 Oct 2021 21:41:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhBUrLrGkrgB1yPRLALBD2sN4GQjQAwKYR9S4o58PDSHxoybsZIT8tkvnEx4edZQAzxkZe7XGOFh9gKFHWQ6Y=
X-Received: by 2002:a2e:8605:: with SMTP id a5mr4832648lji.107.1635223317869; 
 Mon, 25 Oct 2021 21:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211025075825.1603118-1-mst@redhat.com>
In-Reply-To: <20211025075825.1603118-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 12:41:47 +0800
Message-ID: <CACGkMEucDHon_2uBqZpcSc8hNdOzJGRCz6U_ZmFaP6pbU5sBQw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: corrent types for status handling
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 kernel test robot <lkp@intel.com>, Israel Rukshin <israelr@nvidia.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Feng Li <lifeng1519@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Mon, Oct 25, 2021 at 3:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
> back to a blk_status_t variable. blk_status_t is either u32 or (more
> typically) u8 so it works, but is inelegant and causes sparse warnings.
>
> Pass the status in blk_status_t in a consistent way.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c336d9bb9105..c7d05ff24084 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -208,8 +208,9 @@ static void virtblk_cleanup_cmd(struct request *req)
>                 kfree(bvec_virt(&req->special_vec));
>  }
>
> -static int virtblk_setup_cmd(struct virtio_device *vdev, struct request *req,
> -               struct virtblk_req *vbr)
> +static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
> +                                     struct request *req,
> +                                     struct virtblk_req *vbr)
>  {
>         bool unmap = false;
>         u32 type;
> @@ -317,14 +318,15 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>         unsigned long flags;
>         unsigned int num;
>         int qid = hctx->queue_num;
> -       int err;
>         bool notify = false;
> +       blk_status_t status;
> +       int err;
>
>         BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>
> -       err = virtblk_setup_cmd(vblk->vdev, req, vbr);
> -       if (unlikely(err))
> -               return err;
> +       status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> +       if (unlikely(status))
> +               return status;
>
>         blk_mq_start_request(req);
>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
