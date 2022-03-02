Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CDCC433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 13:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27C848149C;
	Wed,  2 Mar 2022 13:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SdOzzN9G3TbO; Wed,  2 Mar 2022 13:17:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C298D8148A;
	Wed,  2 Mar 2022 13:17:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A9F7C0082;
	Wed,  2 Mar 2022 13:17:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5BD7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B520140465
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VUHrpqAJd1KY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:17:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 417CC40184
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646227050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpoZwqDiyWyouUNfFZ1KMMACwgAnA6JVdey+IK2PuMU=;
 b=gKPhowhEHN/x03Bzt9EAXOc8T2e5PozCPaSBrnW8qz40s43R8Qq5/TsCcn6eeSl+5qYVYS
 nr3ygxrfRKsIT5PshxTzHEWeeSv9p6+ZjX039WrFCBEkdhoV1nBs0HAohKhg3bmu0Ga0LT
 N4Xn5kr1wXy1vvbuzgtzcOTMYUMg+GQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-V6nupIzYNi2ZtwOuNb8VJg-1; Wed, 02 Mar 2022 08:17:29 -0500
X-MC-Unique: V6nupIzYNi2ZtwOuNb8VJg-1
Received: by mail-wm1-f72.google.com with SMTP id
 h206-20020a1c21d7000000b003552c13626cso1917359wmh.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 05:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IpoZwqDiyWyouUNfFZ1KMMACwgAnA6JVdey+IK2PuMU=;
 b=5MRuoEoAC0fk7jB79NKSWxUYeFB+kMRJNtzmE54HS+t6hMii2C1WngmdEQK8kF91R5
 mnRlsL1c05f4QeT6G8hj0dEFO1TxX4v/Lsc+NBB1D2hrEJWWW6zPslfRzPzkgBbW55TW
 aQWjpbsA2towpRP4qvBnqe+MJgLZAOz1LX9f3sA+P1RIQHZ3hqkm+cE7WR7mOIrt/N+t
 15I8zigg34K87ofnAkvJ0bb8aIgYeukS+iwgIv3Z/9KPsm/Xe3sEKsZVSD2tgeD6ix13
 80O8KPocLXZllVpZcCPbvQUQkO8MsN7nhhoaGND3sZjnRbrU+rH+YoeLzL+YgNHSqNgm
 y9+g==
X-Gm-Message-State: AOAM532yRD7e58bKCLyqhqEUVCTP5exxM/9IjjO/iGPhB1/nPtSvi4Ab
 zCvSBN/gLBRbTvgrS1cPGIIqTNLgSX2TIqYSt+aZPomFbanOmzMIoYuiIpYLlydpsEHiTh2aeJA
 dRNrgtB/4EOKHLcbqpdYtkj8yDU/OxEFtrjrUIo1ftg==
X-Received: by 2002:a05:6000:1883:b0:1f0:44f6:4bc0 with SMTP id
 a3-20020a056000188300b001f044f64bc0mr1550994wri.659.1646227047894; 
 Wed, 02 Mar 2022 05:17:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbot4giXhot64z2wqmSUyiUo5F/crURpMZGOqzGXQd0aA2SQbWCMa1E2G7Iwrvrk+r1P4Wgw==
X-Received: by 2002:a05:6000:1883:b0:1f0:44f6:4bc0 with SMTP id
 a3-20020a056000188300b001f044f64bc0mr1550979wri.659.1646227047692; 
 Wed, 02 Mar 2022 05:17:27 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a5d5228000000b001ea76210986sm16329531wra.58.2022.03.02.05.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 05:17:27 -0800 (PST)
Date: Wed, 2 Mar 2022 08:17:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302081542-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
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

On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
> 
> On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > Currently we have a BUG_ON() to make sure the number of sg
> > > list does not exceed queue_max_segments() in virtio_queue_rq().
> > > However, the block layer uses queue_max_discard_segments()
> > > instead of queue_max_segments() to limit the sg list for
> > > discard requests. So the BUG_ON() might be triggered if
> > > virtio-blk device reports a larger value for max discard
> > > segment than queue_max_segments().
> > Hmm the spec does not say what should happen if max_discard_seg
> > exceeds seg_max. Is this the config you have in mind? how do you
> > create it?
> 
> I don't think it's hard to create it. Just change some registers in the
> device.
> 
> But with the dynamic sgl allocation that I added recently, there is no
> problem with this scenario.

Well the problem is device says it can't handle such large descriptors,
I guess it works anyway, but it seems scary.

> This commit looks good to me, thanks Xie Yongji.
> 
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> 
> > > To fix it, let's simply
> > > remove the BUG_ON() which has become unnecessary after commit
> > > 02746e26c39e("virtio-blk: avoid preallocating big SGL for data").
> > > And the unused vblk->sg_elems can also be removed together.
> > > 
> > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >   drivers/block/virtio_blk.c | 10 +---------
> > >   1 file changed, 1 insertion(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index c443cd64fc9b..a43eb1813cec 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -76,9 +76,6 @@ struct virtio_blk {
> > >   	 */
> > >   	refcount_t refs;
> > > -	/* What host tells us, plus 2 for header & tailer. */
> > > -	unsigned int sg_elems;
> > > -
> > >   	/* Ida index - used to track minor number allocations. */
> > >   	int index;
> > > @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
> > >   	blk_status_t status;
> > >   	int err;
> > > -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > > -
> > >   	status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> > >   	if (unlikely(status))
> > >   		return status;
> > > @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >   	/* Prevent integer overflows and honor max vq size */
> > >   	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
> > > -	/* We need extra sg elements at head and tail. */
> > > -	sg_elems += 2;
> > >   	vdev->priv = vblk = kmalloc(sizeof(*vblk), GFP_KERNEL);
> > >   	if (!vblk) {
> > >   		err = -ENOMEM;
> > > @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >   	mutex_init(&vblk->vdev_mutex);
> > >   	vblk->vdev = vdev;
> > > -	vblk->sg_elems = sg_elems;
> > >   	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> > > @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> > >   		set_disk_ro(vblk->disk, 1);
> > >   	/* We can handle whatever the host told us to handle. */
> > > -	blk_queue_max_segments(q, vblk->sg_elems-2);
> > > +	blk_queue_max_segments(q, sg_elems);
> > >   	/* No real sector limit. */
> > >   	blk_queue_max_hw_sectors(q, -1U);
> > > -- 
> > > 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
