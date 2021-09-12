Return-Path: <SRS0=fv7C=OC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0114C433EF
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 09:07:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6DF61051
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 09:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F6DF61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD70A406B7;
	Sun, 12 Sep 2021 09:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0GuED5yIZ2hB; Sun, 12 Sep 2021 09:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3D7EB405FE;
	Sun, 12 Sep 2021 09:07:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E5BFC0011;
	Sun, 12 Sep 2021 09:07:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2813EC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 09:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0985E40613
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 09:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lxTs_w5i_87H
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 09:07:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 855B5405FE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 09:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631437635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l12vL/VKzgR/djsTuONg86Gvt7zQZ+tzhcbHZ15clCg=;
 b=gykUI1tbQqZQUgBzh4cCs2RUgOmL3dFGSA2hk6Xb5vVY97hLujsJ2gkKYdNHJ4SV4EAuU/
 OZAG8wnL3QwDK0uZpYQTt0roSJqQUu7lGiQSrceQ/9M26xQTjZPdNl/OrZyKtPeYENch1C
 j0DhbT4KOQW/8gaFFwO4rKnK/uGd/eM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-C-QO7T-HOdeXuSeGlUEEvw-1; Sun, 12 Sep 2021 05:07:14 -0400
X-MC-Unique: C-QO7T-HOdeXuSeGlUEEvw-1
Received: by mail-wm1-f72.google.com with SMTP id
 k5-20020a7bc3050000b02901e081f69d80so3383246wmj.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 02:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l12vL/VKzgR/djsTuONg86Gvt7zQZ+tzhcbHZ15clCg=;
 b=yGYQPbtBVoxE7f9x5CwZ+npk6HLuTZB3MU8ZHygVJS8+Hzmw4XWZcEjUYa0Acl3QrI
 +xDukt03Ewb/wk8fSuvb8AZqKKRnuvC2Pqkj9oxWyz+Hi+i56EKUnMF1QsNLPJi7s/68
 aBxwjrQ9Sm4v/u9XDV3OJXeUXLUQMiTYPN6eLIq5skgzSpTzo9Ye3aQiSnKRxra/G6gy
 qHQ9g9+gq5yEJvGiwfG6t9m9PWin7cqAuArrLE8Pc57SqcAtAq7bkGhTaS2ClIPJJYnH
 m5sHG/Ds6Ctl+AfF2963VF/UwUpgP+0kHt/18xTn9aGdIYzdS8k92D+/DkY4oVP2EeR1
 jULQ==
X-Gm-Message-State: AOAM532edl+JvkiGtqj68wWDIV2S6q669fgoqzd3KgPL/PpNFhUQAGdR
 qBhvVvOOK0NIsANQOwSZ+vnoupZDf8o5+k1D4M0OTVxXqgVRX5PhGv8Zd7BHxUbj7YKYbtcCW4v
 joLovQw0a6bYL7SteuXnzJZZZ46BiqSOzQFurKS2jHA==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr6025333wmh.18.1631437633539; 
 Sun, 12 Sep 2021 02:07:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyksgGKu1JHZ/Bk9BSbOgpbFQ2UGfY2aMUP2WBqJnMX3Emu+T8sSJLW3dT/cjiUe/WT9WXMFA==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr6025313wmh.18.1631437633261; 
 Sun, 12 Sep 2021 02:07:13 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
 by smtp.gmail.com with ESMTPSA id m5sm3660162wmi.1.2021.09.12.02.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 02:07:12 -0700 (PDT)
Date: Sun, 12 Sep 2021 05:07:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210912050531-mutt-send-email-mst@kernel.org>
References: <20210906071957-mutt-send-email-mst@kernel.org>
 <1cbbe6e2-1473-8696-565c-518fc1016a1a@nvidia.com>
 <20210909094001-mutt-send-email-mst@kernel.org>
 <456e1704-67e9-aac9-a82a-44fed65dd153@nvidia.com>
 <20210909114029-mutt-send-email-mst@kernel.org>
 <da61fec0-e90f-0020-c836-c2e58d32be27@nvidia.com>
 <20210909123035-mutt-send-email-mst@kernel.org>
 <0cd4ab50-1bb2-3baf-fc00-b2045e8f8eb1@nvidia.com>
 <20210909185525-mutt-send-email-mst@kernel.org>
 <9de9a43a-2d3a-493b-516e-4601778b9237@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <9de9a43a-2d3a-493b-516e-4601778b9237@nvidia.com>
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

On Sat, Sep 11, 2021 at 03:56:45PM +0300, Max Gurtovoy wrote:
> 
> On 9/10/2021 1:57 AM, Michael S. Tsirkin wrote:
> > On Thu, Sep 09, 2021 at 07:45:42PM +0300, Max Gurtovoy wrote:
> > > On 9/9/2021 7:31 PM, Michael S. Tsirkin wrote:
> > > > On Thu, Sep 09, 2021 at 06:51:56PM +0300, Max Gurtovoy wrote:
> > > > > On 9/9/2021 6:40 PM, Michael S. Tsirkin wrote:
> > > > > > On Thu, Sep 09, 2021 at 06:37:37PM +0300, Max Gurtovoy wrote:
> > > > > > > On 9/9/2021 4:42 PM, Michael S. Tsirkin wrote:
> > > > > > > > On Mon, Sep 06, 2021 at 02:59:40PM +0300, Max Gurtovoy wrote:
> > > > > > > > > On 9/6/2021 2:20 PM, Michael S. Tsirkin wrote:
> > > > > > > > > > On Mon, Sep 06, 2021 at 01:31:32AM +0300, Max Gurtovoy wrote:
> > > > > > > > > > > On 9/5/2021 7:02 PM, Michael S. Tsirkin wrote:
> > > > > > > > > > > > On Thu, Sep 02, 2021 at 02:45:52PM +0100, Stefan Hajnoczi wrote:
> > > > > > > > > > > > > On Tue, Aug 31, 2021 at 04:50:35PM +0300, Max Gurtovoy wrote:
> > > > > > > > > > > > > > Sometimes a user would like to control the amount of IO queues to be
> > > > > > > > > > > > > > created for a block device. For example, for limiting the memory
> > > > > > > > > > > > > > footprint of virtio-blk devices.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > changes from v1:
> > > > > > > > > > > > > >        - use param_set_uint_minmax (from Christoph)
> > > > > > > > > > > > > >        - added "Should > 0" to module description
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >        drivers/block/virtio_blk.c | 20 +++++++++++++++++++-
> > > > > > > > > > > > > >        1 file changed, 19 insertions(+), 1 deletion(-)
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > > > > > > > > > > index 4b49df2dfd23..9332fc4e9b31 100644
> > > > > > > > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > > > > > > > @@ -24,6 +24,22 @@
> > > > > > > > > > > > > >        /* The maximum number of sg elements that fit into a virtqueue */
> > > > > > > > > > > > > >        #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> > > > > > > > > > > > > > +static int virtblk_queue_count_set(const char *val,
> > > > > > > > > > > > > > +		const struct kernel_param *kp)
> > > > > > > > > > > > > > +{
> > > > > > > > > > > > > > +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > > > > > > > > > > > +}
> > > > > > > > > > Hmm which tree is this for?
> > > > > > > > > I've mentioned in the note that it apply on branch for-5.15/drivers. But now
> > > > > > > > > you can apply it on linus/master as well.
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +static const struct kernel_param_ops queue_count_ops = {
> > > > > > > > > > > > > > +	.set = virtblk_queue_count_set,
> > > > > > > > > > > > > > +	.get = param_get_uint,
> > > > > > > > > > > > > > +};
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > > +static unsigned int num_io_queues;
> > > > > > > > > > > > > > +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> > > > > > > > > > > > > > +MODULE_PARM_DESC(num_io_queues,
> > > > > > > > > > > > > > +		 "Number of IO virt queues to use for blk device. Should > 0");
> > > > > > > > > > better:
> > > > > > > > > > 
> > > > > > > > > > +MODULE_PARM_DESC(num_io_request_queues,
> > > > > > > > > > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> > > > > > > > > You proposed it and I replied on it bellow.
> > > > > > > > Can't say I understand 100% what you are saying. Want to send
> > > > > > > > a description that does make sense to you but
> > > > > > > > also reflects reality? 0 is the default so
> > > > > > > > "should > 0" besides being ungrammatical does not seem t"
> > > > > > > > reflect what it does ...
> > > > > > > if you "modprobe virtio_blk" the previous behavior will happen.
> > > > > > > 
> > > > > > > You can't "modprobe virtio_blk num_io_request_queues=0" since the minimal
> > > > > > > value is 1.
> > > > > > > 
> > > > > > > So your description is not reflecting the code.
> > > > > > > 
> > > > > > > We can do:
> > > > > > > 
> > > > > > > MODULE_PARM_DESC(num_io_request_queues, "Number of request virt queues to use for blk device. Minimum value is 1 queue");
> > > > > > What's the default value? We should document that.
> > > > > default value for static global variables is 0.
> > > > > 
> > > > > MODULE_PARM_DESC(num_io_request_queues, "Number of request virt queues to
> > > > > use for blk device. Minimum value is 1 queue. Default and Maximum value is
> > > > > equal to the total number of CPUs");
> > > > So it says it's the # of cpus but yoiu inspect it with
> > > > sysfs and it's actually 0. Let's say that's confusing
> > > > at the least. why not just let users set it to 0
> > > > and document that?
> > > > 
> > > Setting it by the user to 0 makes no sense.
> > > 
> > > We can say "if not set, the value equals to the total number of CPUs".
> > the value is 0. it seems to mean "no limit". the actual # of queues is
> > then te smaller between # of cpus and # of hardware queues.
> > I see no reason not to allow user to set that especially if
> > it was originally the value then user changed it
> > and is trying to change it back.
> 
> I fine with that.
> 
> MODULE_PARM_DESC(num_io_request_queues, "Number of request virt queues to use for blk device. 0 value means no limitation");
> 

OK and the second distinction is that it's a limit on the
number, not the actual number. It's never more than what's provided
by the hypervisor.

> > 
> > > The actual value of the created queues can be seen in /sys/block/vda/mq/ as
> > > done today.
> > > > > > > > > > > > > > +
> > > > > > > > > > > > > >        static int major;
> > > > > > > > > > > > > >        static DEFINE_IDA(vd_index_ida);
> > > > > > > > > > > > > > @@ -501,7 +517,9 @@ static int init_vq(struct virtio_blk *vblk)
> > > > > > > > > > > > > >        	if (err)
> > > > > > > > > > > > > >        		num_vqs = 1;
> > > > > > > > > > > > > > -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > > > > > > > > > > > +	num_vqs = min_t(unsigned int,
> > > > > > > > > > > > > > +			min_not_zero(num_io_queues, nr_cpu_ids),
> > > > > > > > > > > > > > +			num_vqs);
> > > > > > > > > > > > > If you respin, please consider calling them request queues. That's the
> > > > > > > > > > > > > terminology from the VIRTIO spec and it's nice to keep it consistent.
> > > > > > > > > > > > > But the purpose of num_io_queues is clear, so:
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > > > > > > I did this:
> > > > > > > > > > > > +static unsigned int num_io_request_queues;
> > > > > > > > > > > > +module_param_cb(num_io_request_queues, &queue_count_ops, &num_io_request_queues, 0644);
> > > > > > > > > > > > +MODULE_PARM_DESC(num_io_request_queues,
> > > > > > > > > > > > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> > > > > > > > > > > The parameter is writable and can be changed and then new devices might be
> > > > > > > > > > > probed with new value.
> > > > > > > > > > > 
> > > > > > > > > > > It can't be zero in the code. we can change param_set_uint_minmax args and
> > > > > > > > > > > say that 0 says nr_cpus.
> > > > > > > > > > > 
> > > > > > > > > > > I'm ok with the renaming but I prefer to stick to the description we gave in
> > > > > > > > > > > V3 of this patch (and maybe enable value of 0 as mentioned above).

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
