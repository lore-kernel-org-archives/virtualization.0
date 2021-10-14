Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C5C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:45:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F5861168
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98F5861168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BBDA83168;
	Thu, 14 Oct 2021 02:45:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4WQb5bN3NCK6; Thu, 14 Oct 2021 02:45:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E515883133;
	Thu, 14 Oct 2021 02:45:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5103C000F;
	Thu, 14 Oct 2021 02:45:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DB5FC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 088DB6077E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7r5cTTEtG5ax
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:45:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4558A60770
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634179541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eXsQtbYu8ZrTVNpDyzuEjrd6+BUlfzHFpmt5fkpzD3E=;
 b=XRU9q8FRGSz2fciD9ULj4gNC530Yr5JOydSpAc7aHZxio5lB0t4mCZiIwTml8JOS29TNKy
 50sYGQxLmgeL3tcPTtMojFI9UCbUmJBiVv8shtXj3KudU8IYZtKnQdSObNLIxoJ8fNl06z
 gEgDA43RisG6iiBMv0wpwDvBQfcVbU0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-Pv9qV0G6OCuPAnUM75O5cQ-1; Wed, 13 Oct 2021 22:45:40 -0400
X-MC-Unique: Pv9qV0G6OCuPAnUM75O5cQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 x33-20020a0565123fa100b003fcfd99073dso3374417lfa.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 19:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eXsQtbYu8ZrTVNpDyzuEjrd6+BUlfzHFpmt5fkpzD3E=;
 b=TLNtnSjpDhvGPEJ0wJTImRXK9Fs8H+1elFd2tWH2aOECuvmBasRSltG2wfNwdxgcWA
 J1uLgtkKJ9vQrEUmlIDwsDy+cI7G3dZOEp6i5jS64Ht7HXAvx2Uls7tgHIk0Fn2LNZ8C
 PgMonZS8CkBXxNjq8PyFwDn0jt4iMcMqxRfOFzur+uVQGVj1HKCDictUxc4ZGVwLkIM5
 l7AKEQIjSCuz8Q/j5oiaGBsAUg+P4kfGadZ6ny/XCCHjdbLlTV8/apvMRtdxikBIbezd
 PrTwQigfpURNjalWAxUuEy+JEcVb6hTeYtZrVJFJzMS6imytte9KNPHwLPIDgGpLR4mC
 7SkA==
X-Gm-Message-State: AOAM531BBDidIgccK+08GrLdKYk47O6/mRRwC7/Q05JuPCxc4//kwkMs
 LcoLFpefEDXT7KnlpNfV2BvwxQCm0A3ktiB918qvdCk44eZPWzP1pUgaIFM/+TkSYXRI91AnjD/
 KWHM/3gHpeOP5xWonXXpd/grm8DAWETAJsGIFKH2T3cGtsR7RoFNMsuVFNw==
X-Received: by 2002:a2e:a553:: with SMTP id e19mr3434306ljn.420.1634179538480; 
 Wed, 13 Oct 2021 19:45:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+xgpkEUubYfnpn/vaAsfXQ0rhxqRYeg+wRyCTA86C+jYoPsMcxaiuymric4yv4DqVOdlgczVxxUcTpfzpW1c=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr3434279ljn.420.1634179538228; 
 Wed, 13 Oct 2021 19:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211013124553.23803-1-mst@redhat.com>
In-Reply-To: <20211013124553.23803-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 10:45:25 +0800
Message-ID: <CACGkMEvoE8+FxvX_vJEqEuqHptHu1-0TyM4j1P=cnRiBD6-1vA@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-blk: Add validation for block size in
 config space"
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Oct 13, 2021 at 8:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> It turns out that access to config space before completing the feature
> negotiation is broken for big endian guests at least with QEMU hosts up
> to 6.1 inclusive.  This affects any device that accesses config space in
> the validate callback: at the moment that is virtio-net with
> VIRTIO_NET_F_MTU but since 82e89ea077b9 ("virtio-blk: Add validation for
> block size in config space") that also started affecting virtio-blk with
> VIRTIO_BLK_F_BLK_SIZE.

Ok, so it looks like I need to do something similar in my series to
validate max_nr_ports in probe() instead of validate()? (multi port is
not enabled by default).

I wonder if we need to document this and rename the validate to
validate_features() (since we can do very little thing if we can't
read config in .validate()).

> Further, unlike VIRTIO_NET_F_MTU which is off by
> default on QEMU, VIRTIO_BLK_F_BLK_SIZE is on by default, which resulted
> in lots of people not being able to boot VMs on BE.
>
> The spec is very clear that what we are doing is legal so QEMU needs to
> be fixed, but given it's been broken for so many years and no one
> noticed, we need to give QEMU a bit more time before applying this.
>
> Further, this patch is incomplete (does not check blk size is a power
> of two) and it duplicates the logic from nbd.
>
> Revert for now, and we'll reapply a cleaner logic in the next release.
>
> Cc: stable@vger.kernel.org
> Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in config space")
> Cc: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: jason Wang <jasowang@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9b3bd083b411..303caf2d17d0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -689,28 +689,6 @@ static const struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>
> -static int virtblk_validate(struct virtio_device *vdev)
> -{
> -       u32 blk_size;
> -
> -       if (!vdev->config->get) {
> -               dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -                       __func__);
> -               return -EINVAL;
> -       }
> -
> -       if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> -               return 0;
> -
> -       blk_size = virtio_cread32(vdev,
> -                       offsetof(struct virtio_blk_config, blk_size));
> -
> -       if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> -               __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> -
> -       return 0;
> -}
> -
>  static int virtblk_probe(struct virtio_device *vdev)
>  {
>         struct virtio_blk *vblk;
> @@ -722,6 +700,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>         u8 physical_block_exp, alignment_offset;
>         unsigned int queue_depth;
>
> +       if (!vdev->config->get) {
> +               dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
>         err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
>                              GFP_KERNEL);
>         if (err < 0)
> @@ -836,14 +820,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>         else
>                 blk_size = queue_logical_block_size(q);
>
> -       if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE) {
> -               dev_err(&vdev->dev,
> -                       "block size is changed unexpectedly, now is %u\n",
> -                       blk_size);
> -               err = -EINVAL;
> -               goto out_cleanup_disk;
> -       }
> -
>         /* Use topology information if available */
>         err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
>                                    struct virtio_blk_config, physical_block_exp,
> @@ -1009,7 +985,6 @@ static struct virtio_driver virtio_blk = {
>         .driver.name                    = KBUILD_MODNAME,
>         .driver.owner                   = THIS_MODULE,
>         .id_table                       = id_table,
> -       .validate                       = virtblk_validate,
>         .probe                          = virtblk_probe,
>         .remove                         = virtblk_remove,
>         .config_changed                 = virtblk_config_changed,
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
