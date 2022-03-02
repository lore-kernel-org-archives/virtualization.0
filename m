Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9731AC433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 13:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4E8FF40498;
	Wed,  2 Mar 2022 13:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mb5LXeA1LFTZ; Wed,  2 Mar 2022 13:33:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9668E4047F;
	Wed,  2 Mar 2022 13:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F702C0082;
	Wed,  2 Mar 2022 13:33:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BEAAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0777C40184
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VJiluZxYeOtg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB8E84047F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646227990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DM/3qI59VEjTwy5btQ2SWKnDFr1qeE7i2m9AXknhXPo=;
 b=TC0KK+oygk3UNrVTQFj3HG93iNBc3foVENItUZnAAVxMe5NTvMykDHJ2KDYFB2ucA7LifF
 VdNVvtuvdzD6HMV4ob0kZsG8e5SuNT6M4whTqgB73u8oxJgH74BETIfCDjFNGOZbG+1B3I
 3crOpiPIGKXQirp2PSaEYN5RoAuDHqg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-4rQkSyGXMrqv2fO4GKMrGA-1; Wed, 02 Mar 2022 08:33:09 -0500
X-MC-Unique: 4rQkSyGXMrqv2fO4GKMrGA-1
Received: by mail-wr1-f71.google.com with SMTP id
 c5-20020adffb05000000b001edbbefe96dso649191wrr.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 05:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DM/3qI59VEjTwy5btQ2SWKnDFr1qeE7i2m9AXknhXPo=;
 b=LlfD3lO3TstOM7idv36yfEX+D+kXfOCGUIB+NrWDRKr+k5dkVGz/4LW1+iNIwl0ZAX
 jth2O09SVmhwoFJjYluH3h1D8K0uCC0ZH2iK+54k0vScYS+PGVeutXMST9L3aPBPgMCU
 hF+mYI/WwXneClJ8Ft5aDsciO8jPMs+l5+FlW3B1b+GtdfHwXNFKmyOmaQeuBfAHtF/h
 0YjUA4Mz3oUggxTxDMWkUSt7KXbs07yQJBB0mqz7CoMKNi+nkR8+iJJjeBSQL80MJ8Dq
 AC/e0c4KjfzERe69wKbWYa5cId4Kf7etTvMBPt325X/RLNKd1GDQWtrG0s2uaH0Cq/rR
 OdUA==
X-Gm-Message-State: AOAM533jf04sdLIrKcs7ykhzwSvwwNk7ZXWqw2StI1EASAPDi5FA5mgT
 41AvRS+6nSzveeFOgGU2JBjthJujdyllpHsvEzLdaCHKMy6p71+0V7/U1P/ETwsUD6q4B3BbSmX
 ePMuTAXYTmdJb2hjx3uR+RVExCwR+qwn60LpPRTWehw==
X-Received: by 2002:adf:cd0d:0:b0:1f0:2250:79ab with SMTP id
 w13-20020adfcd0d000000b001f0225079abmr4570251wrm.623.1646227988549; 
 Wed, 02 Mar 2022 05:33:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1/y9vLbQLKO9lAkFtZhCNP7wUIUpr2SMNSaN+tGwRXdfW47JhUdC6qfbZRG3Rrwn/wCaqeQ==
X-Received: by 2002:adf:cd0d:0:b0:1f0:2250:79ab with SMTP id
 w13-20020adfcd0d000000b001f0225079abmr4570229wrm.623.1646227988304; 
 Wed, 02 Mar 2022 05:33:08 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a7bcb54000000b0037fa63db8aasm5886078wmj.5.2022.03.02.05.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 05:33:07 -0800 (PST)
Date: Wed, 2 Mar 2022 08:33:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302083112-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
 <20220302081542-mutt-send-email-mst@kernel.org>
 <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, hch@infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>
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

On Wed, Mar 02, 2022 at 03:24:51PM +0200, Max Gurtovoy wrote:
> 
> On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
> > On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
> > > On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > > > Currently we have a BUG_ON() to make sure the number of sg
> > > > > list does not exceed queue_max_segments() in virtio_queue_rq().
> > > > > However, the block layer uses queue_max_discard_segments()
> > > > > instead of queue_max_segments() to limit the sg list for
> > > > > discard requests. So the BUG_ON() might be triggered if
> > > > > virtio-blk device reports a larger value for max discard
> > > > > segment than queue_max_segments().
> > > > Hmm the spec does not say what should happen if max_discard_seg
> > > > exceeds seg_max. Is this the config you have in mind? how do you
> > > > create it?
> > > I don't think it's hard to create it. Just change some registers in the
> > > device.
> > > 
> > > But with the dynamic sgl allocation that I added recently, there is no
> > > problem with this scenario.
> > Well the problem is device says it can't handle such large descriptors,
> > I guess it works anyway, but it seems scary.
> 
> I don't follow.
> 
> The only problem this patch solves is when a virtio blk device reports
> larger value for max_discard_segments than max_segments.
> 

No, the peroblem reported is when virtio blk device reports
max_segments < 256 but not max_discard_segments.
I would expect discard to follow max_segments restrictions then.

> Probably no such devices, but we need to be prepared.

Right, question is how to handle this.

> > 
> > > This commit looks good to me, thanks Xie Yongji.
> > > 
> > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > 
> > > > > To fix it, let's simply
> > > > > remove the BUG_ON() which has become unnecessary after commit
> > > > > 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
> > > > > And the unused vblk->sg_elems can also be removed together.
> > > > > 
> > > > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > > > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > ---
> > > > >    drivers/block/virtio_blk.c | 10 +---------
> > > > >    1 file changed, 1 insertion(+), 9 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > > index c443cd64fc9b..a43eb1813cec 100644
> > > > > --- a/drivers/block/virtio_blk.c
> > > > > +++ b/drivers/block/virtio_blk.c
> > > > > @@ -76,9 +76,6 @@ struct virtio_blk {
> > > > >    	 */
> > > > >    	refcount_t refs;
> > > > > -	/* What host tells us, plus 2 for header & tailer. */
> > > > > -	unsigned int sg_elems;
> > > > > -
> > > > >    	/* Ida index - used to track minor number allocations. */
> > > > >    	int index;
> > > > > @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > > > >    	blk_status_t status;
> > > > >    	int err;
> > > > > -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > > > > -
> > > > >    	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> > > > >    	if (unlikely(status))
> > > > >    		return status;
> > > > > @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > > >    	/* Prevent integer overflows and honor max vq size */
> > > > >    	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
> > > > > -	/* We need extra sg elements at head and tail. */
> > > > > -	sg_elems += 2;
> > > > >    	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
> > > > >    	if (!vblk) {
> > > > >    		err = -ENOMEM;
> > > > > @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > > >    	mutex_init(&vblk->vdev_mutex);
> > > > >    	vblk->vdev = vdev;
> > > > > -	vblk->sg_elems = sg_elems;
> > > > >    	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> > > > > @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > > >    		set_disk_ro(vblk->disk, 1);
> > > > >    	/* We can handle whatever the host told us to handle. */
> > > > > -	blk_queue_max_segments(q, vblk->sg_elems-2);
> > > > > +	blk_queue_max_segments(q, sg_elems);
> > > > >    	/* No real sector limit. */
> > > > >    	blk_queue_max_hw_sectors(q, -1U);
> > > > > -- 
> > > > > 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
