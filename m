Return-Path: <SRS0=SKE2=N3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35100C433FE
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 16:02:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8A360F4A
	for <virtualization@archiver.kernel.org>; Sun,  5 Sep 2021 16:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF8A360F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9024B40495;
	Sun,  5 Sep 2021 16:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOP8jioKkny6; Sun,  5 Sep 2021 16:02:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C83C40443;
	Sun,  5 Sep 2021 16:02:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5B48C001D;
	Sun,  5 Sep 2021 16:02:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94AB8C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 16:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8324640210
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 16:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o232qVR5erlF
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 16:02:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99EFD40274
 for <virtualization@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630857769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFUKBgO0Ri1xXVfSTLwQQ6n1EXRj/R2St3GRxbwUsHQ=;
 b=Nn5pFIVIdlJ6NotAlB5EAfRI2LZOW4UaEnOgbU8hzBUVxDALLZ0U29VC0Gw8t5ewDdSXi0
 uoC1xLYYYasDX6bfG1gOZwYrfYmCJcZfpxlyIpPXFEOpzsfc23yTuWKXIuKHJVTRRxVyNH
 PNNgkzu9rvbOUfUpAP5wvX03QWG4Xsc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-TFMVzpCyNDqRY2lycWi4Ig-1; Sun, 05 Sep 2021 12:02:48 -0400
X-MC-Unique: TFMVzpCyNDqRY2lycWi4Ig-1
Received: by mail-wm1-f70.google.com with SMTP id
 m22-20020a7bca56000000b002e7508f3faeso1441087wml.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 09:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UFUKBgO0Ri1xXVfSTLwQQ6n1EXRj/R2St3GRxbwUsHQ=;
 b=Pc5UQUk+H1O++j23J8U4EPvM9BHu0bg2/ScS6ecXpcdbYz0KBw+lgYIy5uKnbydO31
 R9Aw9wYMPIncVxzcOxERnWvxv0rwBwib0+ovAQYANKONU2VqebJgEZJgPGMIcqxjFyRi
 zeCuPhUWatoJY+8wRmoOj6yG3a3tmV10NYUx9NAMQO2lIFoufgP+0Q+mcqNSp5XPu46l
 CYoa3x6zwrn+IomhZsSd1vzw2v2CWNPt8gOjGPm3epXp/c0JMmT90hMl9RYE/zr9A0se
 KFEdosfGKMkGoHKFGF6qUCJAsCyNKaSkzZQ6VbotbDY8wCn5u22+vIFCHTHC3rO+Us2p
 GTlQ==
X-Gm-Message-State: AOAM532CO17FmfDCnNSXVO8gSiKM3Jz9M7eFTv4IEpGLsQnL9ZRtj7TI
 wkqMHPNnqhq8QGi/GJGKivLk9VR1NUH3zQ/NqjS0KmE8lxM5LYYkWvoNefppIHksGDWU2DHAYDW
 BVCoP4fhg+UMb/tyOy4jJArz1rZQoY9vWk3sVpvOOVg==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr7425503wmc.129.1630857767102; 
 Sun, 05 Sep 2021 09:02:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+jYdy0uL4WaJOpJ4iOFHt6H+cjCfQhzErPuJ1lH4FMlns0HOWIVet2jX9qnAP00mbt8+/SQ==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr7425490wmc.129.1630857766939; 
 Sun, 05 Sep 2021 09:02:46 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id q11sm4833205wmc.41.2021.09.05.09.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 09:02:46 -0700 (PDT)
Date: Sun, 5 Sep 2021 12:02:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210905120234-mutt-send-email-mst@kernel.org>
References: <20210831135035.6443-1-mgurtovoy@nvidia.com>
 <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-block@vger.kernel.org,
 kvm@vger.kernel.org, israelr@nvidia.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 nitzanc@nvidia.com, axboe@kernel.dk, oren@nvidia.com
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

On Thu, Sep 02, 2021 at 02:45:52PM +0100, Stefan Hajnoczi wrote:
> On Tue, Aug 31, 2021 at 04:50:35PM +0300, Max Gurtovoy wrote:
> > Sometimes a user would like to control the amount of IO queues to be
> > created for a block device. For example, for limiting the memory
> > footprint of virtio-blk devices.
> > 
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > ---
> > 
> > changes from v1:
> >  - use param_set_uint_minmax (from Christoph)
> >  - added "Should > 0" to module description
> > 
> > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > ---
> >  drivers/block/virtio_blk.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4b49df2dfd23..9332fc4e9b31 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -24,6 +24,22 @@
> >  /* The maximum number of sg elements that fit into a virtqueue */
> >  #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> >  
> > +static int virtblk_queue_count_set(const char *val,
> > +		const struct kernel_param *kp)
> > +{
> > +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > +}
> > +
> > +static const struct kernel_param_ops queue_count_ops = {
> > +	.set = virtblk_queue_count_set,
> > +	.get = param_get_uint,
> > +};
> > +
> > +static unsigned int num_io_queues;
> > +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> > +MODULE_PARM_DESC(num_io_queues,
> > +		 "Number of IO virt queues to use for blk device. Should > 0");
> > +
> >  static int major;
> >  static DEFINE_IDA(vd_index_ida);
> >  
> > @@ -501,7 +517,9 @@ static int init_vq(struct virtio_blk *vblk)
> >  	if (err)
> >  		num_vqs = 1;
> >  
> > -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > +	num_vqs = min_t(unsigned int,
> > +			min_not_zero(num_io_queues, nr_cpu_ids),
> > +			num_vqs);
> 
> If you respin, please consider calling them request queues. That's the
> terminology from the VIRTIO spec and it's nice to keep it consistent.
> But the purpose of num_io_queues is clear, so:
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

I did this:
+static unsigned int num_io_request_queues;
+module_param_cb(num_io_request_queues, &queue_count_ops, &num_io_request_queues, 0644);
+MODULE_PARM_DESC(num_io_request_queues,
+                "Limit number of IO request virt queues to use for each device. 0 for now limit");

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
