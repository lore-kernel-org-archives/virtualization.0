Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85237C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 14:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20AE260B3B;
	Wed,  2 Mar 2022 14:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qsHSzXis255a; Wed,  2 Mar 2022 14:15:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 412C760A6B;
	Wed,  2 Mar 2022 14:15:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04990C0012;
	Wed,  2 Mar 2022 14:15:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3459C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABF2481772
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dt1Kf_QClBP3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B662C81454
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646230550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2N/IlzGyjMOglJgTyOGfwxfmg2/yQAmnahVF4RnYydE=;
 b=WQ+/vxiPPNgqYL4BKNejYCI/1c6wvAOO8ozNR8n15iTnkfL3NkB4rSvRMMKQUlioske7z1
 kUCi5RFC2+G/VnA7REn9UJ5WJ8T2pI/0/f9O4TAb0bjxGbz8d1v70hni8u/cJggfTI7hxW
 o4KE398drP+i+YwjtkNnkGRjGPBalEM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-e97IVfMgNg-Ih3fSyT0pYQ-1; Wed, 02 Mar 2022 09:15:49 -0500
X-MC-Unique: e97IVfMgNg-Ih3fSyT0pYQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 q12-20020adfbb8c000000b001ea938f79e9so676861wrg.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 06:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2N/IlzGyjMOglJgTyOGfwxfmg2/yQAmnahVF4RnYydE=;
 b=Zx7amKdZLb6fJAy8KGvMTYZ9MyKlXdfkw4vm7PcXxICSsGyZZTiauIDhsrDzP+TMWt
 6ulnzae2S+WQrwt90lWzA68TVuZ45N5LajyfevFysh0H97V06ZUD8nJhZWiZQUotmkC+
 LeL0AxjLEtRYSb/hmjhZIaLGE7Xzy0NBycriy8wWxTEr5T5sWA1XA58a2CgChSvwjnbZ
 bappehm9jCbYnf5wS7mSJQ7OLmBoexXsWdrNmWMkOCp/4e+v1mF2MTsyloZ+U3eF9j9H
 Dl/tvTbJkvcBSSZXXnWp/ak9hmbPh6yr+jGEupU5402yM3Pc99QI5AgJEK6MDdqaMyYN
 IXJA==
X-Gm-Message-State: AOAM532Mbzql6nEnGsTYMLxyXzNCSOb4G1PB9NqcGMH62cEAXLMjdghc
 HihndtwTf5MIWasuz7G5WKYSDoXSaYjoOvlDKFfiV4Mk0KpCaV34PFlX4Tvr4ch7+8nVhbVzuZP
 Oxv/xF0iukVY4d5DK5VrqIGkTANgwqy4KoLcZJHKpgg==
X-Received: by 2002:a05:6000:15cf:b0:1f0:44b9:b916 with SMTP id
 y15-20020a05600015cf00b001f044b9b916mr1806328wry.86.1646230548432; 
 Wed, 02 Mar 2022 06:15:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJze6YulJFuarXC9cemliWPtlNBmwiwnvxdYpuAHM3IqXDAykNjmrhcy744TOT0f+rdwqJ9aJQ==
X-Received: by 2002:a05:6000:15cf:b0:1f0:44b9:b916 with SMTP id
 y15-20020a05600015cf00b001f044b9b916mr1806308wry.86.1646230548113; 
 Wed, 02 Mar 2022 06:15:48 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 k15-20020adff5cf000000b001e4b8fde355sm16619182wrp.73.2022.03.02.06.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 06:15:44 -0800 (PST)
Date: Wed, 2 Mar 2022 09:15:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302085132-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
 <20220302081542-mutt-send-email-mst@kernel.org>
 <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com>
 <20220302083112-mutt-send-email-mst@kernel.org>
 <808fbd57-588d-03e3-2904-513f4bdcceaf@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <808fbd57-588d-03e3-2904-513f4bdcceaf@nvidia.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Mar 02, 2022 at 03:45:10PM +0200, Max Gurtovoy wrote:
> =

> On 3/2/2022 3:33 PM, Michael S. Tsirkin wrote:
> > On Wed, Mar 02, 2022 at 03:24:51PM +0200, Max Gurtovoy wrote:
> > > On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
> > > > > On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> > > > > > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > > > > > Currently we have a BUG_ON() to make sure the number of sg
> > > > > > > list does not exceed queue_max_segments() in virtio_queue_rq(=
).
> > > > > > > However, the block layer uses queue_max_discard_segments()
> > > > > > > instead of queue_max_segments() to limit the sg list for
> > > > > > > discard requests. So the BUG_ON() might be triggered if
> > > > > > > virtio-blk device reports a larger value for max discard
> > > > > > > segment than queue_max_segments().
> > > > > > Hmm the spec does not say what should happen if max_discard_seg
> > > > > > exceeds seg_max. Is this the config you have in mind? how do you
> > > > > > create it?
> > > > > I don't think it's hard to create it. Just change some registers =
in the
> > > > > device.
> > > > > =

> > > > > But with the dynamic sgl allocation that I added recently, there =
is no
> > > > > problem with this scenario.
> > > > Well the problem is device says it can't handle such large descript=
ors,
> > > > I guess it works anyway, but it seems scary.
> > > I don't follow.
> > > =

> > > The only problem this patch solves is when a virtio blk device reports
> > > larger value for max_discard_segments than max_segments.
> > > =

> > No, the peroblem reported is when virtio blk device reports
> > max_segments < 256 but not max_discard_segments.
> =

> You mean the code will work in case device report max_discard_segments=A0=
 >
> max_segments ?
> =

> I don't think so.

I think it's like this:


        if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {

		....

                virtio_cread(vdev, struct virtio_blk_config, max_discard_se=
g,
                             &v);
                blk_queue_max_discard_segments(q,
                                               min_not_zero(v,
                                                            MAX_DISCARD_SEG=
MENTS));

	}

so, IIUC the case is of a device that sets max_discard_seg to 0.

Which is kind of broken, but we handled this since 2018 so I guess
we'll need to keep doing that.


> This is exactly what Xie Yongji mention in the commit message and what I =
was
> seeing.
> =

> But the code will work if VIRTIO_BLK_F_DISCARD is not supported by the
> device (even if max_segments < 256) , since blk layer set
> queue_max_discard_segments =3D 1 in the initialization.
> =

> And the virtio-blk driver won't change it unless VIRTIO_BLK_F_DISCARD is
> supported.
> =

> > I would expect discard to follow max_segments restrictions then.
> > =

> > > Probably no such devices, but we need to be prepared.
> > Right, question is how to handle this.
> > =

> > > > > This commit looks good to me, thanks Xie Yongji.
> > > > > =

> > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > =

> > > > > > > To fix it, let's simply
> > > > > > > remove the BUG_ON() which has become unnecessary after commit
> > > > > > > 02746e26c39e("virtio-blk: avoid preallocating big SGL for dat=
a").
> > > > > > > And the unused vblk->sg_elems can also be removed together.
> > > > > > > =

> > > > > > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroe=
s support")
> > > > > > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > > ---
> > > > > > >     drivers/block/virtio_blk.c | 10 +---------
> > > > > > >     1 file changed, 1 insertion(+), 9 deletions(-)
> > > > > > > =

> > > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virti=
o_blk.c
> > > > > > > index c443cd64fc9b..a43eb1813cec 100644
> > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > @@ -76,9 +76,6 @@ struct virtio_blk {
> > > > > > >     	 */
> > > > > > >     	refcount_t refs;
> > > > > > > -	/* What host tells us, plus 2 for header & tailer. */
> > > > > > > -	unsigned int sg_elems;
> > > > > > > -
> > > > > > >     	/* Ida index - used to track minor number allocations. */
> > > > > > >     	int index;
> > > > > > > @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(struc=
t blk_mq_hw_ctx *hctx,
> > > > > > >     	blk_status_t status;
> > > > > > >     	int err;
> > > > > > > -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > > > > > > -
> > > > > > >     	status =3D virtblk_setup_cmd(vblk->vdev, req, vbr);
> > > > > > >     	if (unlikely(status))
> > > > > > >     		return status;
> > > > > > > @@ -783,8 +778,6 @@ static int virtblk_probe(struct virtio_de=
vice *vdev)
> > > > > > >     	/* Prevent integer overflows and honor max vq size */
> > > > > > >     	sg_elems =3D min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEM=
S - 2);
> > > > > > > -	/* We need extra sg elements at head and tail. */
> > > > > > > -	sg_elems +=3D 2;
> > > > > > >     	vdev->priv =3D vblk =3D kmalloc(sizeof(*vblk), GFP_KERNE=
L);
> > > > > > >     	if (!vblk) {
> > > > > > >     		err =3D -ENOMEM;
> > > > > > > @@ -796,7 +789,6 @@ static int virtblk_probe(struct virtio_de=
vice *vdev)
> > > > > > >     	mutex_init(&vblk->vdev_mutex);
> > > > > > >     	vblk->vdev =3D vdev;
> > > > > > > -	vblk->sg_elems =3D sg_elems;
> > > > > > >     	INIT_WORK(&vblk->config_work, virtblk_config_changed_wor=
k);
> > > > > > > @@ -853,7 +845,7 @@ static int virtblk_probe(struct virtio_de=
vice *vdev)
> > > > > > >     		set_disk_ro(vblk->disk, 1);
> > > > > > >     	/* We can handle whatever the host told us to handle. */
> > > > > > > -	blk_queue_max_segments(q, vblk->sg_elems-2);
> > > > > > > +	blk_queue_max_segments(q, sg_elems);
> > > > > > >     	/* No real sector limit. */
> > > > > > >     	blk_queue_max_hw_sectors(q, -1U);
> > > > > > > -- =

> > > > > > > 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
