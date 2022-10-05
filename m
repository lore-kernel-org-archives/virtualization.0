Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676FEC433F5
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 09:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6CC582894;
	Wed,  5 Oct 2022 09:48:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6CC582894
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dh/s9gbr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nrin6BWzS2xX; Wed,  5 Oct 2022 09:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4C3338196A;
	Wed,  5 Oct 2022 09:48:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C3338196A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22C48C0032;
	Wed,  5 Oct 2022 09:48:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8667AC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 09:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B91D40126
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 09:48:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B91D40126
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=dh/s9gbr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9m--rWmI3d9n
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 09:48:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4CA840A4B
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4CA840A4B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 09:48:11 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id h10so12235279plb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Oct 2022 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=uAiOjs73GnPtRWDKlCBYpOmHeG3ElDSPTXYVbLmJn3Y=;
 b=dh/s9gbrJ1NP2il6j7m7392rb5m/0olUhLw6ywfYrwbm+b05mgthbXGVeHCne6faSe
 nEB8FWIww9/Mh3TPJYBTwQxHk9YQhBfOYEWSgISGS3x2V+1PSzpPW0fGwHCNvRUrDmsC
 V4LPjNBP1ZNWd2lWycmQ+cVlk2hOYpk0wbD3BQW90ktRdTfHVQoOGdzFfsVLA+UV8P0L
 yaYjHeb70WMgWdHpn0iX5L8LgNN78O1ThcYXr+GHqSaFRNBAWLFYqLr8IpSUK6wbVOaM
 BO7XUtm7Hdl6sqI52mxM7YweUuOKwjFV07IZc9k6gah2y9PsEzpdZlxqQ3TbFVT9xR+n
 gOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=uAiOjs73GnPtRWDKlCBYpOmHeG3ElDSPTXYVbLmJn3Y=;
 b=Th/tS4kZFRUE8L6Qq3RTzbiOI1km5NDUzaLWjGIJN6nbyQJstzZucoqvJufiRFfo4g
 32ur1xSvGyZfvb/MmTYU4l/iW+W4mvFkzHoAWdoRtYpPOIIbTcaRe7jkQ8vR4veshNti
 r25EmJWW4ZSZbT40p75Ax3i+l6ct8vyY+IUGrXija1pDFZ8VsirEp+dNRBw/Rz6pG6Bn
 bngAAgkE7T4cswq4WjIlJc8Y/ZQEc8wQvWlEJRjEjubDbQnzN6A5ZQIHeurtppBFpw38
 BJohCHVXxaWUDTNBvDCJ/XwFbBJ591ba0CGDklnBV/a5Ur/ZGZWKjgqdj2bp8R4aKPL6
 KeWw==
X-Gm-Message-State: ACrzQf05+jdZohrmkObWOIgE+03Y/Eph+osWaBDYAg6+BF55mODwXUVb
 iqE047ZJU4peCTyui/FsVf3t8G/nlu1u3yYTbv1I0g==
X-Google-Smtp-Source: AMsMyM6eqXlNc1atZOkkKgiG1yV3Y78Coz+AbzCXphLyt0GPdUFcokJxxEDnXeFGnrVe0bHv3fHf9rWqZFSPgK8TTJI=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr4350723pjb.164.1664963290949; Wed, 05
 Oct 2022 02:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
In-Reply-To: <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Oct 2022 11:47:34 +0200
Message-ID: <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
To: Chaitanya Kulkarni <kch@nvidia.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: vincent.fu@samsung.com, hoeppner@linux.ibm.com, vincent.whitchurch@axis.com,
 baolin.wang@linux.alibaba.com, mst@redhat.com,
 linux-remoteproc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, bhelgaas@google.com,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
 agordeev@linux.ibm.com, jinpu.wang@ionos.com, hch@lst.de, alyssa@rosenzweig.io,
 vigneshr@ti.com, linux-s390@vger.kernel.org, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, richard@nod.at, vaibhavgupta40@gmail.com,
 joel@jms.id.au, shinichiro.kawasaki@wdc.com, idryomov@gmail.com,
 jejb@linux.ibm.com, asahi@lists.linux.dev, ohad@wizery.com,
 haris.iqbal@ionos.com, gor@linux.ibm.com, sven@svenpeter.dev,
 hca@linux.ibm.com, john.garry@huawei.com, josef@toxicpanda.com,
 efremov@linux.com, ming.lei@redhat.com, linux-block@vger.kernel.org,
 nbd@other.debian.org, christophe.jaillet@wanadoo.fr, sth@linux.ibm.com,
 stefanha@redhat.com, kbusch@kernel.org, ceph-devel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
 wsa+renesas@sang-engineering.com, johannes.thumshirn@wdc.com,
 andersson@kernel.org, marcan@marcan.st, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dongsheng.yang@easystack.cn,
 christoph.boehmwalder@linbit.com, mcgrof@kernel.org, svens@linux.ibm.com,
 pbonzini@redhat.com
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

On Wed, 5 Oct 2022 at 07:11, Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 10/5/22 12:22, Chaitanya Kulkarni wrote:
> > Add and use the helper to initialize the common fields of the tag_set
> > such as blk_mq_ops, number of h/w queues, queue depth, command size,
> > numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
> > is spread all over the block drivers. This avoids the code repetation of
> > the inialization code of the tag set in current block drivers and any
>
> s/inialization/initialization
> s/repetation/repetition
>
> > future ones.
> >
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > ---
> >  block/blk-mq.c                | 20 ++++++++++++++++++++
> >  drivers/block/null_blk/main.c | 10 +++-------
> >  include/linux/blk-mq.h        |  5 +++++
> >  3 files changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 8070b6c10e8d..e3a8dd81bbe2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4341,6 +4341,26 @@ static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
> >       return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
> >  }
> >
> > +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
> > +             const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
> > +             unsigned int queue_depth, unsigned int cmd_size, int numa_node,
> > +             unsigned int timeout, unsigned int flags, void *driver_data)
>
> That is an awful lot of arguments... I would be tempted to say pack all
> these into a struct but then that would kind of negate this patchset goal.
> Using a function with that many arguments will be error prone, and hard to
> review... Not a fan.

I completely agree.

But there is also another problem going down this route. If/when we
realize that there is another parameter needed in the blk_mq_tag_set.
Today that's quite easy to add (assuming the parameter can be
optional), without changing the blk_mq_init_tag_set() interface.

>
> > +{
> > +     if (!set)
> > +             return;
> > +
> > +     set->ops = ops;
> > +     set->nr_hw_queues = nr_hw_queues;
> > +     set->queue_depth = queue_depth;
> > +     set->cmd_size = cmd_size;
> > +     set->numa_node = numa_node;
> > +     set->timeout = timeout;
> > +     set->flags = flags;
> > +     set->driver_data = driver_data;
> > +}
> > +
>

[...]

Kind regards
Uffe
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
