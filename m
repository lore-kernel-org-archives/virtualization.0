Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51786C25B08
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 12:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B21F14087F;
	Wed, 10 Aug 2022 12:41:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B21F14087F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YrPo+c8s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s0FdP6S4Fm5D; Wed, 10 Aug 2022 12:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CDDF74089E;
	Wed, 10 Aug 2022 12:41:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDDF74089E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8327DC0032;
	Wed, 10 Aug 2022 12:41:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F4EAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 12:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CE4882660
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 12:41:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CE4882660
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YrPo+c8s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HynAeNtSBlcS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 12:41:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4975A8272C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4975A8272C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660135272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GVGfUW1RKI3FajCNZWPpZsDvCAXWP2hsd5EFJaoYXWQ=;
 b=YrPo+c8sBZsohWX88b68ek3HQ8vFzmyFRgVaqmZu9q9SCqF6gm1ypEwUKuZQcoeZNNaLIC
 0e7VXZRGI78zPAiGhl7B9m+g9denJWsn+t5spZs4ImeJmNGfjaOGBioek++SJNBWRseXKw
 Ciy25fxaNdkWN9IQ0B+OuFwq2rFL6x0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-JuGuUZVfNmSsKcGCPT_cbA-1; Wed, 10 Aug 2022 08:41:11 -0400
X-MC-Unique: JuGuUZVfNmSsKcGCPT_cbA-1
Received: by mail-ed1-f70.google.com with SMTP id
 v19-20020a056402349300b0043d42b7ddefso9051081edc.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 05:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=GVGfUW1RKI3FajCNZWPpZsDvCAXWP2hsd5EFJaoYXWQ=;
 b=aVgmnzT/opp4PZIcVFa/HaScdJlQcOXppPxJXArsUGrX+enJg4G9WGRvwHiHSMvLwA
 Kd+CWP/QVcFF47w3bbUtsuOLULD9cjXPUDqjjh9eBq5aq9iN1U+DEYT74d0Jvprpkd63
 gvGsd4kr5TGfRfUovQxei0up2QllP9BNPPjfU3y6Juh5BmRZJ7CURM0xzRtDMS1DSZto
 ZWqs0ZQ0GEy4JQV4rYOzBfcIlfxCmftBXd20gV0lMS5IF5GvbZp3Czo6iPXmQTw/gl5U
 xnC5xxe/gppqqsUW8ilBwzMGCh+wdRSvPnP2nbFjWqYbwoNX19/I6GQ2gw2xqbe+8s3d
 iAaw==
X-Gm-Message-State: ACgBeo0O3+s5MHRy/79tz/PQyPHJOJUuMazQBI0pfGOO3h2nLYV9ejL0
 BOz4wWnIF/DNGe20IRlh3YoeNJz/sIK/MxSa8PKN+qxnwyaPasZSbB4AS8xuWAtfFZgRDk/xodm
 B6Y2Ut7QjP9Gsqp1LUrhceYXMu4tyF14kWR8zMYkgAg==
X-Received: by 2002:aa7:ce88:0:b0:442:30f5:433f with SMTP id
 y8-20020aa7ce88000000b0044230f5433fmr4995884edv.317.1660135269506; 
 Wed, 10 Aug 2022 05:41:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5/cz4aFbceABg+Osg2Px2SlIV/ktzBNGlPGXbY6O3K6PVCUlBtIy54SKtla4RESUH41xAi2g==
X-Received: by 2002:aa7:ce88:0:b0:442:30f5:433f with SMTP id
 y8-20020aa7ce88000000b0044230f5433fmr4995865edv.317.1660135269288; 
 Wed, 10 Aug 2022 05:41:09 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 kx11-20020a170907774b00b006fe0abb00f0sm2250524ejc.209.2022.08.10.05.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 05:41:08 -0700 (PDT)
Date: Wed, 10 Aug 2022 08:41:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shigeru Yoshida <shigeru.yoshida@gmail.com>
Subject: Re: [PATCH] virtio-blk: Avoid use-after-free on suspend/resume
Message-ID: <20220810084053-mutt-send-email-mst@kernel.org>
References: <20220731070951.196831-1-shigeru.yoshida@gmail.com>
 <20220810.204556.441522765735488771.shigeru.yoshida@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220810.204556.441522765735488771.shigeru.yoshida@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Wed, Aug 10, 2022 at 08:45:56PM +0900, Shigeru Yoshida wrote:
> ping?
> 
> On Sun, 31 Jul 2022 16:09:51 +0900, Shigeru Yoshida wrote:
> > hctx->user_data is set to vq in virtblk_init_hctx().  However, vq is
> > freed on suspend and reallocated on resume.  So, hctx->user_data is
> > invalid after resume, and it will cause use-after-free accessing which
> > will result in the kernel crash something like below:
> > 
> > [   22.428391] Call Trace:
> > [   22.428899]  <TASK>
> > [   22.429339]  virtqueue_add_split+0x3eb/0x620
> > [   22.430035]  ? __blk_mq_alloc_requests+0x17f/0x2d0
> > [   22.430789]  ? kvm_clock_get_cycles+0x14/0x30
> > [   22.431496]  virtqueue_add_sgs+0xad/0xd0
> > [   22.432108]  virtblk_add_req+0xe8/0x150
> > [   22.432692]  virtio_queue_rqs+0xeb/0x210
> > [   22.433330]  blk_mq_flush_plug_list+0x1b8/0x280
> > [   22.434059]  __blk_flush_plug+0xe1/0x140
> > [   22.434853]  blk_finish_plug+0x20/0x40
> > [   22.435512]  read_pages+0x20a/0x2e0
> > [   22.436063]  ? folio_add_lru+0x62/0xa0
> > [   22.436652]  page_cache_ra_unbounded+0x112/0x160
> > [   22.437365]  filemap_get_pages+0xe1/0x5b0
> > [   22.437964]  ? context_to_sid+0x70/0x100
> > [   22.438580]  ? sidtab_context_to_sid+0x32/0x400
> > [   22.439979]  filemap_read+0xcd/0x3d0
> > [   22.440917]  xfs_file_buffered_read+0x4a/0xc0
> > [   22.441984]  xfs_file_read_iter+0x65/0xd0
> > [   22.442970]  __kernel_read+0x160/0x2e0
> > [   22.443921]  bprm_execve+0x21b/0x640
> > [   22.444809]  do_execveat_common.isra.0+0x1a8/0x220
> > [   22.446008]  __x64_sys_execve+0x2d/0x40
> > [   22.446920]  do_syscall_64+0x37/0x90
> > [   22.447773]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > 
> > This patch fixes this issue by getting vq from vblk, and removes
> > virtblk_init_hctx().
> > 
> > Signed-off-by: Shigeru Yoshida <shigeru.yoshida@gmail.com>

Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
Cc: "Suwan Kim" <suwan.kim027@gmail.com>

I assume?

> > ---
> >  drivers/block/virtio_blk.c | 24 ++++++++++--------------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 6fc7850c2b0a..d756423e0059 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -101,6 +101,14 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
> >  	}
> >  }
> >  
> > +static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> > +{
> > +	struct virtio_blk *vblk = hctx->queue->queuedata;
> > +	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> > +
> > +	return vq;
> > +}
> > +
> >  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
> >  {
> >  	struct scatterlist hdr, status, *sgs[3];
> > @@ -416,7 +424,7 @@ static void virtio_queue_rqs(struct request **rqlist)
> >  	struct request *requeue_list = NULL;
> >  
> >  	rq_list_for_each_safe(rqlist, req, next) {
> > -		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> > +		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
> >  		bool kick;
> >  
> >  		if (!virtblk_prep_rq_batch(req)) {
> > @@ -837,7 +845,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
> >  static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> >  {
> >  	struct virtio_blk *vblk = hctx->queue->queuedata;
> > -	struct virtio_blk_vq *vq = hctx->driver_data;
> > +	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
> >  	struct virtblk_req *vbr;
> >  	unsigned long flags;
> >  	unsigned int len;
> > @@ -862,22 +870,10 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> >  	return found;
> >  }
> >  
> > -static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> > -			  unsigned int hctx_idx)
> > -{
> > -	struct virtio_blk *vblk = data;
> > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> > -
> > -	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
> > -	hctx->driver_data = vq;
> > -	return 0;
> > -}
> > -
> >  static const struct blk_mq_ops virtio_mq_ops = {
> >  	.queue_rq	= virtio_queue_rq,
> >  	.queue_rqs	= virtio_queue_rqs,
> >  	.commit_rqs	= virtio_commit_rqs,
> > -	.init_hctx	= virtblk_init_hctx,
> >  	.complete	= virtblk_request_done,
> >  	.map_queues	= virtblk_map_queues,
> >  	.poll		= virtblk_poll,
> > -- 
> > 2.37.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
