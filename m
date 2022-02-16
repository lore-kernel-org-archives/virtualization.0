Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356DFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 03:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0FBE8316F;
	Wed, 16 Feb 2022 03:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fE_BLC20xPtG; Wed, 16 Feb 2022 03:21:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F23383155;
	Wed, 16 Feb 2022 03:21:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04DC2C0011;
	Wed, 16 Feb 2022 03:21:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2A31C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B413240576
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VagHOQWgt2zv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:21:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67052400D7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:21:35 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id d17so1085773pfl.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 19:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vw8qsUjrvsewVRkefqUfPybP+5Z8VVwo22NfPcxFm0A=;
 b=dgO7FhOY2JfQ2IuLfOG2+6uYTThsWgKj/hMrjHToVTKPrHe2y7HZPfgQon5t2nJupZ
 xE/6oPFfV6H6vhhYCOlncyNL7KmQGjDkC0fK1cN3YOKHm0dC4BT4/WN6CmIIOMNERuHA
 uMVsZRX/f02HrDzFwhUtgY/LAoFOjBHXHOpI3xbcwFnM3HgpTJj/ldRGYzC++aMpFIay
 rwequSDABGFWuBzkdYLmFvdqk3kistFZ9YZce6p+KpDSUs/r5AMaOhO6NgRJNBLoXsJL
 Q4wdnDkA9AJXGBNuFZSCvpC11uUZFWl7dwdCdZk2q5/xG+ErbjgqoFLTJkzOmivOCSr1
 DwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vw8qsUjrvsewVRkefqUfPybP+5Z8VVwo22NfPcxFm0A=;
 b=wa18JSGNAqPewZ+Cxf5S4nYer+OIHaLWLzf5cLR5/xe3W42LGgD0i+LYAygHbLVuc1
 yR2ruigzEXmvHWOZ3CtV+MoNVMU/ltey2bXk1Sgu6LckkYyFmPDw7YfI90mAcc45Xauf
 ijAbdKXdkSktZ7xLPZiZ4HsZvNehvDbEocOvhIEOFRTz3+AtJT1IjVXnLioaC6aGMVJr
 GACnLjGiMf5TQPjPixcQwo91iwcFqISiLIiT/D3y5HdkvSBGPf9gtqeoOCp1eP8L+nmU
 METf3rH+WaV4Y4Z3LDoCWxW3HBWnmgOJ0zRCsK0GGAIALUCZnk3S7/wdjz8zkVe3KqoF
 QpEA==
X-Gm-Message-State: AOAM532uTHTPDNhPsAxkudKb3+YJdlPit+BAJ096Opt6LZH3zAzphpQ5
 AT+JzyBTa8ziPYfRHQBBNkW/Wvug3szWJ6Hze2qfUA==
X-Google-Smtp-Source: ABdhPJyuuPzOEwmW+m5vEZBdWxTnv9HwCvggPR3Bu976gqtuMVGeBifHYjgGPdwjgVlUgB3HcMqCsBka29+qh7hOs/k=
X-Received: by 2002:a63:f011:0:b0:36c:2da3:32bc with SMTP id
 k17-20020a63f011000000b0036c2da332bcmr661337pgh.40.1644981694745; Tue, 15 Feb
 2022 19:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-2-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20220111161937.56272-2-pankaj.gupta.linux@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 Feb 2022 19:21:23 -0800
Message-ID: <CAPcyv4jrVJ_B0N_-vtqgXaOMovUgnSLCNj228nWMRhGAC5PDhA@mail.gmail.com>
Subject: Re: [RFC v3 1/2] virtio-pmem: Async virtio-pmem flush
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Cornelia Huck <cohuck@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, Pankaj Gupta <pankaj.gupta@ionos.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, jmoyer <jmoyer@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>
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

On Tue, Jan 11, 2022 at 8:23 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> Enable asynchronous flush for virtio pmem using work queue. Also,
> coalesce the flush requests when a flush is already in process.
> This functionality is copied from md/RAID code.
>
> When a flush is already in process, new flush requests wait till
> previous flush completes in another context (work queue). For all
> the requests come between ongoing flush and new flush start time, only
> single flush executes, thus adhers to flush coalscing logic. This is

s/adhers/adheres/

s/coalscing/coalescing/

> important for maintaining the flush request order with request coalscing.

s/coalscing/coalescing/

>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>  drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
>  drivers/nvdimm/virtio_pmem.c | 10 +++++
>  drivers/nvdimm/virtio_pmem.h | 16 ++++++++
>  3 files changed, 83 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 10351d5b49fa..179ea7a73338 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -100,26 +100,66 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  /* The asynchronous flush callback function */
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>  {
> -       /*
> -        * Create child bio for asynchronous flush and chain with
> -        * parent bio. Otherwise directly call nd_region flush.
> +       /* queue asynchronous flush and coalesce the flush requests */
> +       struct virtio_device *vdev = nd_region->provider_data;
> +       struct virtio_pmem *vpmem  = vdev->priv;
> +       ktime_t req_start = ktime_get_boottime();
> +       int ret = -EINPROGRESS;
> +
> +       spin_lock_irq(&vpmem->lock);

Why a new lock and not continue to use ->pmem_lock?

Have you tested this with CONFIG_PROVE_LOCKING?

Along those lines do you have a selftest that can be added to the
kernel as well so that 0day or other bots could offer early warnings
on regressions?

> +       /* flush requests wait until ongoing flush completes,
> +        * hence coalescing all the pending requests.
>          */
> -       if (bio && bio->bi_iter.bi_sector != -1) {
> -               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> -
> -               if (!child)
> -                       return -ENOMEM;
> -               bio_copy_dev(child, bio);
> -               child->bi_opf = REQ_PREFLUSH;
> -               child->bi_iter.bi_sector = -1;
> -               bio_chain(child, bio);
> -               submit_bio(child);
> -               return 0;
> +       wait_event_lock_irq(vpmem->sb_wait,
> +                           !vpmem->flush_bio ||
> +                           ktime_before(req_start, vpmem->prev_flush_start),
> +                           vpmem->lock);
> +       /* new request after previous flush is completed */
> +       if (ktime_after(req_start, vpmem->prev_flush_start)) {
> +               WARN_ON(vpmem->flush_bio);
> +               vpmem->flush_bio = bio;
> +               bio = NULL;
> +       }
> +       spin_unlock_irq(&vpmem->lock);
> +
> +       if (!bio)
> +               queue_work(vpmem->pmem_wq, &vpmem->flush_work);
> +       else {
> +       /* flush completed in other context while we waited */
> +               if (bio && (bio->bi_opf & REQ_PREFLUSH))
> +                       bio->bi_opf &= ~REQ_PREFLUSH;
> +               else if (bio && (bio->bi_opf & REQ_FUA))
> +                       bio->bi_opf &= ~REQ_FUA;
> +
> +               ret = vpmem->prev_flush_err;
>         }
> -       if (virtio_pmem_flush(nd_region))
> -               return -EIO;
>
> -       return 0;
> +       return ret;
>  };
>  EXPORT_SYMBOL_GPL(async_pmem_flush);
> +
> +void submit_async_flush(struct work_struct *ws)

This name is too generic to be exported from drivers/nvdimm/nd_virtio.c

...it strikes me that there is little reason for nd_virtio and
virtio_pmem to be separate modules. They are both enabled by the same
Kconfig, so why not combine them into one module and drop the exports?

> +{
> +       struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
> +       struct bio *bio = vpmem->flush_bio;
> +
> +       vpmem->start_flush = ktime_get_boottime();
> +       vpmem->prev_flush_err = virtio_pmem_flush(vpmem->nd_region);
> +       vpmem->prev_flush_start = vpmem->start_flush;
> +       vpmem->flush_bio = NULL;
> +       wake_up(&vpmem->sb_wait);
> +
> +       if (vpmem->prev_flush_err)
> +               bio->bi_status = errno_to_blk_status(-EIO);
> +
> +       /* Submit parent bio only for PREFLUSH */
> +       if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
> +               bio->bi_opf &= ~REQ_PREFLUSH;
> +               submit_bio(bio);
> +       } else if (bio && (bio->bi_opf & REQ_FUA)) {
> +               bio->bi_opf &= ~REQ_FUA;
> +               bio_endio(bio);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(submit_async_flush);
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 726c7354d465..75ed9b7ddea1 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
>                 return PTR_ERR(vpmem->req_vq);
>
>         spin_lock_init(&vpmem->pmem_lock);
> +       spin_lock_init(&vpmem->lock);
>         INIT_LIST_HEAD(&vpmem->req_list);
>
>         return 0;
> @@ -57,7 +58,14 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>                 dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
>                 goto out_err;
>         }
> +       vpmem->pmem_wq = alloc_workqueue("vpmem_wq", WQ_MEM_RECLAIM, 0);
> +       if (!vpmem->pmem_wq) {
> +               err = -ENOMEM;
> +               goto out_err;
> +       }
>
> +       INIT_WORK(&vpmem->flush_work, submit_async_flush);
> +       init_waitqueue_head(&vpmem->sb_wait);
>         virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
>                         start, &vpmem->start);
>         virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> @@ -90,10 +98,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>                 goto out_nd;
>         }
>         nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
> +       vpmem->nd_region = nd_region;
>         return 0;
>  out_nd:
>         nvdimm_bus_unregister(vpmem->nvdimm_bus);
>  out_vq:
> +       destroy_workqueue(vpmem->pmem_wq);
>         vdev->config->del_vqs(vdev);
>  out_err:
>         return err;
> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> index 0dddefe594c4..495dc20e1cdb 100644
> --- a/drivers/nvdimm/virtio_pmem.h
> +++ b/drivers/nvdimm/virtio_pmem.h
> @@ -35,9 +35,24 @@ struct virtio_pmem {
>         /* Virtio pmem request queue */
>         struct virtqueue *req_vq;
>
> +       struct bio *flush_bio;
> +       /* last_flush is when the last completed flush was started */
> +       ktime_t prev_flush_start, start_flush;
> +       int prev_flush_err;
> +
> +       /* work queue for deferred flush */
> +       struct work_struct flush_work;
> +       struct workqueue_struct *pmem_wq;
> +
> +       /* Synchronize flush wait queue data */
> +       spinlock_t lock;
> +       /* for waiting for previous flush to complete */
> +       wait_queue_head_t sb_wait;
> +
>         /* nvdimm bus registers virtio pmem device */
>         struct nvdimm_bus *nvdimm_bus;
>         struct nvdimm_bus_descriptor nd_desc;
> +       struct nd_region *nd_region;
>
>         /* List to store deferred work if virtqueue is full */
>         struct list_head req_list;
> @@ -52,4 +67,5 @@ struct virtio_pmem {
>
>  void virtio_pmem_host_ack(struct virtqueue *vq);
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> +void submit_async_flush(struct work_struct *ws);
>  #endif
> --
> 2.25.1
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
