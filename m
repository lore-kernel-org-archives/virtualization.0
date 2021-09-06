Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330BBC433F5
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 11:21:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAC26103B
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 11:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CAAC26103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88A3B40440;
	Mon,  6 Sep 2021 11:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k1mYA_nfqKoi; Mon,  6 Sep 2021 11:20:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 074AD40409;
	Mon,  6 Sep 2021 11:20:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC300C001C;
	Mon,  6 Sep 2021 11:20:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 399F3C001B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 11:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24DE481036
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 11:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iuQJ_dOZglAe
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 11:20:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D201C81013
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630927255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PwCcwobqarvdp7b4ZxKmDRuHy822IrmJf431Zj87HGM=;
 b=c8VndKIXRd3uk4l/vu4ezfYK7J6KNb0Du+QtllfoiroG7oy8SwZ5+hyF2SrGCYDxLuV/Ql
 zcHohVvcsFXhk/2YAsJnKZUrSd9gJBp40zD5ZI72ZIIdNmFrboxR9CZxwYuz8qU/BvdLrI
 4YpWkmsd8VLqyRiDxAjh9InDSaMipyM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-QneELQ7sMei9_bW-W-1mZQ-1; Mon, 06 Sep 2021 07:20:54 -0400
X-MC-Unique: QneELQ7sMei9_bW-W-1mZQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 o14-20020a1709062e8e00b005d37183e041so2177412eji.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Sep 2021 04:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PwCcwobqarvdp7b4ZxKmDRuHy822IrmJf431Zj87HGM=;
 b=XQWtA3zcq+WJdNc4HdyU6mAszyovRS4QlWR2/XitYLzBeT8QM+u+6WKMzLGaYSxCsH
 Y6i/y/IfqNQdK96TiUC9TVmrxFW44Z8Pe5qchQ9a2ofepQxbPVMUnUiHt04pkpY+M1EO
 N9JwMKzV0oC1cWHzphrngUaJ14h9OKK1oFBr0xDusjIM1LruA7VoSGrnrvK4oYXseaoL
 fMeaZmxRPwQpdWKnRIfoCshQixaaycazfZ8M9qEgrMmooPiOU6HKMYDklbVN4w2ri6BB
 DOTeFoIiHKx++Gu8sFqXv2teb+8B2TWBffqioHxJJnns/aMl1s/VYEsdpjhSJOIYWli3
 Dblw==
X-Gm-Message-State: AOAM5312Vk3mqKFACqUi4OEp565pjBADdR1Z+QWrjoMjq4k/Fu2TzyJK
 moZrnxyac0e+zg/sBs3b4zix01c5+CSTETL1TJc0xEQEYPi0lxVLV/n/GMafc4ibslCe7tqWwfN
 9qAyUD+PsVc8zbcJZZnzDwCODwGOukGoyefV0be3m0A==
X-Received: by 2002:a50:fb08:: with SMTP id d8mr12725041edq.160.1630927253392; 
 Mon, 06 Sep 2021 04:20:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnXiZkAIDU73uVyPn+3O20GkHTxFw7vX6uAGTN6zNHOCvY8p6FyX/5L/Q7XXf2IlUH+ouktQ==
X-Received: by 2002:a50:fb08:: with SMTP id d8mr12725016edq.160.1630927253147; 
 Mon, 06 Sep 2021 04:20:53 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id f1sm4406891edq.89.2021.09.06.04.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 04:20:51 -0700 (PDT)
Date: Mon, 6 Sep 2021 07:20:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210906071957-mutt-send-email-mst@kernel.org>
References: <20210831135035.6443-1-mgurtovoy@nvidia.com>
 <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
 <20210905120234-mutt-send-email-mst@kernel.org>
 <98309fcd-3abe-1f27-fe52-e8fcc58bec13@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <98309fcd-3abe-1f27-fe52-e8fcc58bec13@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, Stefan Hajnoczi <stefanha@redhat.com>,
 oren@nvidia.com
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

On Mon, Sep 06, 2021 at 01:31:32AM +0300, Max Gurtovoy wrote:
> 
> On 9/5/2021 7:02 PM, Michael S. Tsirkin wrote:
> > On Thu, Sep 02, 2021 at 02:45:52PM +0100, Stefan Hajnoczi wrote:
> > > On Tue, Aug 31, 2021 at 04:50:35PM +0300, Max Gurtovoy wrote:
> > > > Sometimes a user would like to control the amount of IO queues to be
> > > > created for a block device. For example, for limiting the memory
> > > > footprint of virtio-blk devices.
> > > > 
> > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > ---
> > > > 
> > > > changes from v1:
> > > >   - use param_set_uint_minmax (from Christoph)
> > > >   - added "Should > 0" to module description
> > > > 
> > > > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > > > ---
> > > >   drivers/block/virtio_blk.c | 20 +++++++++++++++++++-
> > > >   1 file changed, 19 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index 4b49df2dfd23..9332fc4e9b31 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -24,6 +24,22 @@
> > > >   /* The maximum number of sg elements that fit into a virtqueue */
> > > >   #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> > > > +static int virtblk_queue_count_set(const char *val,
> > > > +		const struct kernel_param *kp)
> > > > +{
> > > > +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > +}


Hmm which tree is this for?

> > > > +
> > > > +static const struct kernel_param_ops queue_count_ops = {
> > > > +	.set = virtblk_queue_count_set,
> > > > +	.get = param_get_uint,
> > > > +};
> > > > +
> > > > +static unsigned int num_io_queues;
> > > > +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> > > > +MODULE_PARM_DESC(num_io_queues,
> > > > +		 "Number of IO virt queues to use for blk device. Should > 0");



better:

+MODULE_PARM_DESC(num_io_request_queues,
+                "Limit number of IO request virt queues to use for each device. 0 for now limit");


> > > > +
> > > >   static int major;
> > > >   static DEFINE_IDA(vd_index_ida);
> > > > @@ -501,7 +517,9 @@ static int init_vq(struct virtio_blk *vblk)
> > > >   	if (err)
> > > >   		num_vqs = 1;
> > > > -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > +	num_vqs = min_t(unsigned int,
> > > > +			min_not_zero(num_io_queues, nr_cpu_ids),
> > > > +			num_vqs);
> > > If you respin, please consider calling them request queues. That's the
> > > terminology from the VIRTIO spec and it's nice to keep it consistent.
> > > But the purpose of num_io_queues is clear, so:
> > > 
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > I did this:
> > +static unsigned int num_io_request_queues;
> > +module_param_cb(num_io_request_queues, &queue_count_ops, &num_io_request_queues, 0644);
> > +MODULE_PARM_DESC(num_io_request_queues,
> > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> 
> The parameter is writable and can be changed and then new devices might be
> probed with new value.
> 
> It can't be zero in the code. we can change param_set_uint_minmax args and
> say that 0 says nr_cpus.
> 
> I'm ok with the renaming but I prefer to stick to the description we gave in
> V3 of this patch (and maybe enable value of 0 as mentioned above).

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
