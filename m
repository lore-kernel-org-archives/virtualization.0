Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4716C47099
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:37:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959BC6100B
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959BC6100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7509660B50;
	Thu,  3 Jun 2021 15:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CMtmi60uE2Ly; Thu,  3 Jun 2021 15:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4E566068B;
	Thu,  3 Jun 2021 15:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD707C000E;
	Thu,  3 Jun 2021 15:37:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE76FC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC99540537
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IwJBcd2duOay
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:37:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12B05400FC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:37:23 +0000 (UTC)
Received: by mail-ua1-x930.google.com with SMTP id l12so3566082uai.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7DKVf+GiS9951bpd4cfEBh88PiRutTQ//wVEud26id8=;
 b=XGhrfqnzBbfnTVSNkFDv5GHmpnKX09udhfIYlIGvsHf5udWupM3hEeaCuAp1/iGcK2
 itxazCeDLeGnN0Ew9V7mjQKrXGASjKXLT43xef2dS4qB5N1wZq329ew5d1FZXKKcqiVw
 6FD/vr0CrXQkvA5Vx5CUZuiBjtgVFz1ZbiUU7kgR3MEWuPhMcO948V0XjU30zv2QSu9a
 tohz+jrjUWOtrbk55SyLep3Y8Ie2TFo0EIpc+U1g5ZdabSEhCf2ga/7pzz9IJem82LbC
 xz7dKg0/t3XaDdcBysnSaVg/DwjADlBkyj4crHUSmvNFlYRf/JXspkWoLbMUskTXooPD
 5/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7DKVf+GiS9951bpd4cfEBh88PiRutTQ//wVEud26id8=;
 b=W5hqx0JjhgaR8vUoRta92bdXlma5zLktlIbHuV4Em+bAO+uLmwkPxSG3vtrmp5z76k
 wdjVPsVwvgXHovkzN1lXJaUh44FNhB+9C0x8a7N5pO+cgUcLCktVqbccpZmvev49TkBR
 QfU4z1pQyxg0x/MhDGcCinlVQ+/i0pIow6x7UuMcQweCCgLGu0n2AmvjF5sujIzNjZBP
 Jucp+Yct1AAe9QzD/V0SzLZuOWLz5wBP5DRGVBccdXCwOcXgZgHJRqJ00YRdttDZ5XLi
 dwBZhiK8hkvUn9YtkwZ6vkRT13PC8Z2Ydd2bQarSYD6nSfXcBgtRTV5pON6avuOHNezb
 Jygg==
X-Gm-Message-State: AOAM530uNpO3eUThBb8VxCzMt/8ZAoMA4Lcn2a5w0dMG35OAv2ElSBJU
 pLLZz2En1MlAa6RUm2FYDWZ9MWni/EcMLduizLAjNA==
X-Google-Smtp-Source: ABdhPJyc/MDglzj7ZqHuKLnfpO6vVPHNJJJjAhghObYaMjdvGQtxzeGy+jhwPjnJIpGZowWwyMtWi1MuD2fSyYUnfEo=
X-Received: by 2002:ab0:7c5b:: with SMTP id d27mr407242uaw.15.1622734642855;
 Thu, 03 Jun 2021 08:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210602065345.355274-1-hch@lst.de>
 <20210602065345.355274-9-hch@lst.de>
In-Reply-To: <20210602065345.355274-9-hch@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jun 2021 17:36:45 +0200
Message-ID: <CAPDyKFoh6HKx2rHHRXvw--Ou53TR2wLFGrKCDuetigxQ8QbvfQ@mail.gmail.com>
Subject: Re: [PATCH 08/30] mspro: use blk_mq_alloc_disk
To: Christoph Hellwig <hch@lst.de>
Cc: Justin Sanders <justin@coraid.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Mike Snitzer <snitzer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jack Wang <jinpu.wang@ionos.com>,
 Tim Waugh <tim@cyberelk.net>, linux-s390@vger.kernel.org,
 Maxim Levitsky <maximlevitsky@gmail.com>, Richard Weinberger <richard@nod.at>,
 Christian Borntraeger <borntraeger@de.ibm.com>, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alex Dubov <oakad@yahoo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>,
 Denis Efremov <efremov@linux.com>, nbd@other.debian.org,
 linux-block <linux-block@vger.kernel.org>, ceph-devel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Geoff Levand <geoff@infradead.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
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

On Wed, 2 Jun 2021 at 08:54, Christoph Hellwig <hch@lst.de> wrote:
>
> Use the blk_mq_alloc_disk API to simplify the gendisk and request_queue
> allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/memstick/core/mspro_block.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index cf7fe0d58ee7..22778d0e24f5 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -1205,21 +1205,17 @@ static int mspro_block_init_disk(struct memstick_dev *card)
>         if (disk_id < 0)
>                 return disk_id;
>
> -       msb->disk = alloc_disk(1 << MSPRO_BLOCK_PART_SHIFT);
> -       if (!msb->disk) {
> -               rc = -ENOMEM;
> +       rc = blk_mq_alloc_sq_tag_set(&msb->tag_set, &mspro_mq_ops, 2,
> +                                    BLK_MQ_F_SHOULD_MERGE);
> +       if (rc)
>                 goto out_release_id;
> -       }
>
> -       msb->queue = blk_mq_init_sq_queue(&msb->tag_set, &mspro_mq_ops, 2,
> -                                               BLK_MQ_F_SHOULD_MERGE);
> -       if (IS_ERR(msb->queue)) {
> -               rc = PTR_ERR(msb->queue);
> -               msb->queue = NULL;
> -               goto out_put_disk;
> +       msb->disk = blk_mq_alloc_disk(&msb->tag_set, card);
> +       if (IS_ERR(msb->disk)) {
> +               rc = PTR_ERR(msb->disk);
> +               goto out_free_tag_set;
>         }
> -
> -       msb->queue->queuedata = card;
> +       msb->queue = msb->disk->queue;
>
>         blk_queue_max_hw_sectors(msb->queue, MSPRO_BLOCK_MAX_PAGES);
>         blk_queue_max_segments(msb->queue, MSPRO_BLOCK_MAX_SEGS);
> @@ -1228,10 +1224,10 @@ static int mspro_block_init_disk(struct memstick_dev *card)
>
>         msb->disk->major = major;
>         msb->disk->first_minor = disk_id << MSPRO_BLOCK_PART_SHIFT;
> +       msb->disk->minors = 1 << MSPRO_BLOCK_PART_SHIFT;
>         msb->disk->fops = &ms_block_bdops;
>         msb->usage_count = 1;
>         msb->disk->private_data = msb;
> -       msb->disk->queue = msb->queue;
>
>         sprintf(msb->disk->disk_name, "mspblk%d", disk_id);
>
> @@ -1247,8 +1243,8 @@ static int mspro_block_init_disk(struct memstick_dev *card)
>         msb->active = 1;
>         return 0;
>
> -out_put_disk:
> -       put_disk(msb->disk);
> +out_free_tag_set:
> +       blk_mq_free_tag_set(&msb->tag_set);
>  out_release_id:
>         mutex_lock(&mspro_block_disk_lock);
>         idr_remove(&mspro_block_disk_idr, disk_id);
> --
> 2.30.2
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
