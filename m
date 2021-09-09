Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF860C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 13:42:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A191A60555
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 13:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A191A60555
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6416684A11;
	Thu,  9 Sep 2021 13:42:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lj1ZByKXJTOQ; Thu,  9 Sep 2021 13:42:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3ADD84A1D;
	Thu,  9 Sep 2021 13:42:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4D84C000F;
	Thu,  9 Sep 2021 13:42:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0AE3C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9347040354
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgfeiPKDC8Bt
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:42:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAE2540352
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631194966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9yyglc648zrXRd4AVW4tP74FHofD3/df+6dNncY9Pg=;
 b=CO8vWqg4jxBXqdTdjSJ50KB/h3GlikvsbEYC3bpvdzdV/q9C01hnztEQNm4a5HkzY0w6KO
 nb3oFwG6BUOXu0WESlCH/XgL3989SBe2mtzct2ajLUmCTnJSIG/w5C2qLpJ1YOX8rHJ/yW
 H31BzQ29GN8WOEX69xIZbzsm8Ecbz/8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-aGyxt7d7PMSExReKeXfthA-1; Thu, 09 Sep 2021 09:42:45 -0400
X-MC-Unique: aGyxt7d7PMSExReKeXfthA-1
Received: by mail-ej1-f70.google.com with SMTP id
 yz13-20020a170906dc4d00b005c61ad936f0so825970ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Sep 2021 06:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n9yyglc648zrXRd4AVW4tP74FHofD3/df+6dNncY9Pg=;
 b=5OF7FM+P+sYwuwYw7e+tZxEpvNL3XbwBGLzv+BxFeaPu9OPFnY8357+/YxauPHLOJc
 NH3q0+wcO59Wp8W7OuT3uaW+yAy49MBI2wnkBB3vMZk+OkiptNsWG9qqZY4eDXkbEPIS
 jSVx54higUt6Ccr3dpjGmgi9VqQJZOuRl5WJg76PV50s1Ga/2OSWqltF+YXuHOuiBUHw
 swGpAbtnoVAKA3YiOmpnOTXpxecPmPA7ptAiv3DU82h8Im4RsA5d4st3GCZ/fiEsswS4
 oTq7l02hlwLdPrrPkBmxGAdsVStP4nXUbWfr5rDeUc36T3aSRa+loBAZIajvjws/tIUd
 dN/g==
X-Gm-Message-State: AOAM530rPg6JllGoAOe1oa+s8KXH6XDa3Jo3Wl5A6j43B1Jpz5fqKm1J
 Zt4nJfV88hf40960Y/zbtBki3dNq8BeJ4PCd6oaVxNKfZzJ3+Iu6MYu48WVUhDdhKYLqzc9IvSy
 Vha7KB/zAX+Z71mO2adENUjZllfrr6cQCFS01dTYo7w==
X-Received: by 2002:a17:907:8693:: with SMTP id
 qa19mr3393413ejc.497.1631194964157; 
 Thu, 09 Sep 2021 06:42:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywg/VJhF4XMVecjE+sPO8g/1PS5O4JAqpPXl2kjl3hyVJTihD7bfJVln+dRryMMPsNiUjk1w==
X-Received: by 2002:a17:907:8693:: with SMTP id
 qa19mr3393389ejc.497.1631194963948; 
 Thu, 09 Sep 2021 06:42:43 -0700 (PDT)
Received: from redhat.com ([2.55.145.189])
 by smtp.gmail.com with ESMTPSA id o21sm1078830edc.47.2021.09.09.06.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 06:42:43 -0700 (PDT)
Date: Thu, 9 Sep 2021 09:42:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <20210909094001-mutt-send-email-mst@kernel.org>
References: <20210831135035.6443-1-mgurtovoy@nvidia.com>
 <YTDVkDIr5WLdlRsK@stefanha-x1.localdomain>
 <20210905120234-mutt-send-email-mst@kernel.org>
 <98309fcd-3abe-1f27-fe52-e8fcc58bec13@nvidia.com>
 <20210906071957-mutt-send-email-mst@kernel.org>
 <1cbbe6e2-1473-8696-565c-518fc1016a1a@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1cbbe6e2-1473-8696-565c-518fc1016a1a@nvidia.com>
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

On Mon, Sep 06, 2021 at 02:59:40PM +0300, Max Gurtovoy wrote:
> 
> On 9/6/2021 2:20 PM, Michael S. Tsirkin wrote:
> > On Mon, Sep 06, 2021 at 01:31:32AM +0300, Max Gurtovoy wrote:
> > > On 9/5/2021 7:02 PM, Michael S. Tsirkin wrote:
> > > > On Thu, Sep 02, 2021 at 02:45:52PM +0100, Stefan Hajnoczi wrote:
> > > > > On Tue, Aug 31, 2021 at 04:50:35PM +0300, Max Gurtovoy wrote:
> > > > > > Sometimes a user would like to control the amount of IO queues to be
> > > > > > created for a block device. For example, for limiting the memory
> > > > > > footprint of virtio-blk devices.
> > > > > > 
> > > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > ---
> > > > > > 
> > > > > > changes from v1:
> > > > > >    - use param_set_uint_minmax (from Christoph)
> > > > > >    - added "Should > 0" to module description
> > > > > > 
> > > > > > Note: This commit apply on top of Jens's branch for-5.15/drivers
> > > > > > ---
> > > > > >    drivers/block/virtio_blk.c | 20 +++++++++++++++++++-
> > > > > >    1 file changed, 19 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > > index 4b49df2dfd23..9332fc4e9b31 100644
> > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > @@ -24,6 +24,22 @@
> > > > > >    /* The maximum number of sg elements that fit into a virtqueue */
> > > > > >    #define VIRTIO_BLK_MAX_SG_ELEMS 32768
> > > > > > +static int virtblk_queue_count_set(const char *val,
> > > > > > +		const struct kernel_param *kp)
> > > > > > +{
> > > > > > +	return param_set_uint_minmax(val, kp, 1, nr_cpu_ids);
> > > > > > +}
> > 
> > Hmm which tree is this for?
> 
> I've mentioned in the note that it apply on branch for-5.15/drivers. But now
> you can apply it on linus/master as well.
> 
> 
> > 
> > > > > > +
> > > > > > +static const struct kernel_param_ops queue_count_ops = {
> > > > > > +	.set = virtblk_queue_count_set,
> > > > > > +	.get = param_get_uint,
> > > > > > +};
> > > > > > +
> > > > > > +static unsigned int num_io_queues;
> > > > > > +module_param_cb(num_io_queues, &queue_count_ops, &num_io_queues, 0644);
> > > > > > +MODULE_PARM_DESC(num_io_queues,
> > > > > > +		 "Number of IO virt queues to use for blk device. Should > 0");
> > 
> > 
> > better:
> > 
> > +MODULE_PARM_DESC(num_io_request_queues,
> > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> 
> You proposed it and I replied on it bellow.


Can't say I understand 100% what you are saying. Want to send
a description that does make sense to you but
also reflects reality? 0 is the default so
"should > 0" besides being ungrammatical does not seem t"
reflect what it does ...

> 
> > 
> > 
> > > > > > +
> > > > > >    static int major;
> > > > > >    static DEFINE_IDA(vd_index_ida);
> > > > > > @@ -501,7 +517,9 @@ static int init_vq(struct virtio_blk *vblk)
> > > > > >    	if (err)
> > > > > >    		num_vqs = 1;
> > > > > > -	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> > > > > > +	num_vqs = min_t(unsigned int,
> > > > > > +			min_not_zero(num_io_queues, nr_cpu_ids),
> > > > > > +			num_vqs);
> > > > > If you respin, please consider calling them request queues. That's the
> > > > > terminology from the VIRTIO spec and it's nice to keep it consistent.
> > > > > But the purpose of num_io_queues is clear, so:
> > > > > 
> > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > I did this:
> > > > +static unsigned int num_io_request_queues;
> > > > +module_param_cb(num_io_request_queues, &queue_count_ops, &num_io_request_queues, 0644);
> > > > +MODULE_PARM_DESC(num_io_request_queues,
> > > > +                "Limit number of IO request virt queues to use for each device. 0 for now limit");
> > > The parameter is writable and can be changed and then new devices might be
> > > probed with new value.
> > > 
> > > It can't be zero in the code. we can change param_set_uint_minmax args and
> > > say that 0 says nr_cpus.
> > > 
> > > I'm ok with the renaming but I prefer to stick to the description we gave in
> > > V3 of this patch (and maybe enable value of 0 as mentioned above).

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
