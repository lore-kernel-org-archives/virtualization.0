Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAEDC433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 14:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABDBC403E9;
	Wed,  2 Mar 2022 14:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6tFNoRysUyPM; Wed,  2 Mar 2022 14:49:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2EA74023D;
	Wed,  2 Mar 2022 14:49:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92622C0012;
	Wed,  2 Mar 2022 14:49:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 929A7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81A0781332
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:49:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u2Uf5lA2vJuJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:49:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94B1D81329
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646232546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHHQjXlT6tUt0Lss/rsnIUmQeXIsRrXfl5Haz5wji5M=;
 b=KLL2koRgQYd8TWObRxbpFk7KiEdoEhq3t3F+zy39hfydlHaBWj0Hyy0ofoz54IgbAKPds7
 YHfAkrAxpedu2RrUHqVgybKPXyqDUqX5f3/jywonJkQcD5iDxDxE6JFe4J7b+vPiwy+Bg0
 t9qvjEzUVN1Gdab4f7tMWduz1Adr4hY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-I-p3fDCTN3-KvcsXX-iVxw-1; Wed, 02 Mar 2022 09:49:05 -0500
X-MC-Unique: I-p3fDCTN3-KvcsXX-iVxw-1
Received: by mail-wm1-f70.google.com with SMTP id
 j42-20020a05600c1c2a00b00381febe402eso1574986wms.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 06:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wHHQjXlT6tUt0Lss/rsnIUmQeXIsRrXfl5Haz5wji5M=;
 b=7SULgVISEkDX4RQr3pHiOBZlDXglYV70pUJZyZeBDQ5VMY5IEZ5RY8rxLeZQZyEj+C
 L47rLxD0vUpe1wGaBmyzGd/SZrG8/b4TEKXg4vWYX/LG5phZYnFKavFQjcjoFsbkzoUw
 zgag5jASX2KV75RayAB5wzpBpU5vQH/z+S954YvU9z7UFZNU5hepIUxdoXdRV6ryNq4i
 t2PMIQI7rMinmTcsOPgCI2MClX1rBpGkeDkaW6LhZk89M3aM5XGuSCvjDdHWFooWhK0+
 wgwBUhcIX+lh7d49eOykXPweYO6488jGXBM05/AmOWUOn0Q9VqfIoe/fiH4oG5uLjX3M
 F//Q==
X-Gm-Message-State: AOAM530Owvya40h/RR/0Qc/hwMjUBK3w7TsZw+QlSDf40pPa215KXVyc
 hPn/phemqN3+oW4yS1gN32D3PTgUCRunsK5udLbkBKIxPi7iNaFS2I9aaSbKbnCCAuWokTYu3yS
 NPmR2K1QhcvQ7U7qUvyOvRylOgmvEnldlonFMlyvsNw==
X-Received: by 2002:a05:600c:350f:b0:381:738e:d678 with SMTP id
 h15-20020a05600c350f00b00381738ed678mr111835wmq.124.1646232543987; 
 Wed, 02 Mar 2022 06:49:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuTmZVcJrQP/d/f139cG8iFYYX3GPIlF1MI4SjHfgaw2CyO3pVi7ZRR9cj841RZf2dkATnBQ==
X-Received: by 2002:a05:600c:350f:b0:381:738e:d678 with SMTP id
 h15-20020a05600c350f00b00381738ed678mr111811wmq.124.1646232543681; 
 Wed, 02 Mar 2022 06:49:03 -0800 (PST)
Received: from redhat.com ([2a10:8006:355c:0:48d6:b937:2fb9:b7de])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a7bcb8c000000b003811afe1d45sm5726051wmi.37.2022.03.02.06.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 06:49:03 -0800 (PST)
Date: Wed, 2 Mar 2022 09:48:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
Message-ID: <20220302094804-mutt-send-email-mst@kernel.org>
References: <20220228065720.100-1-xieyongji@bytedance.com>
 <20220301104039-mutt-send-email-mst@kernel.org>
 <85e61a65-4f76-afc0-272f-3b13333349f1@nvidia.com>
 <20220302081542-mutt-send-email-mst@kernel.org>
 <bd53b0dc-bef6-cd1a-ac5c-68766089a619@nvidia.com>
 <20220302083112-mutt-send-email-mst@kernel.org>
 <808fbd57-588d-03e3-2904-513f4bdcceaf@nvidia.com>
 <20220302085132-mutt-send-email-mst@kernel.org>
 <fe42c787-700c-d136-75b9-5a3e1b6d1b4f@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <fe42c787-700c-d136-75b9-5a3e1b6d1b4f@nvidia.com>
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

On Wed, Mar 02, 2022 at 04:27:15PM +0200, Max Gurtovoy wrote:
> =

> On 3/2/2022 4:15 PM, Michael S. Tsirkin wrote:
> > On Wed, Mar 02, 2022 at 03:45:10PM +0200, Max Gurtovoy wrote:
> > > On 3/2/2022 3:33 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Mar 02, 2022 at 03:24:51PM +0200, Max Gurtovoy wrote:
> > > > > On 3/2/2022 3:17 PM, Michael S. Tsirkin wrote:
> > > > > > On Wed, Mar 02, 2022 at 11:51:27AM +0200, Max Gurtovoy wrote:
> > > > > > > On 3/1/2022 5:43 PM, Michael S. Tsirkin wrote:
> > > > > > > > On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > > > > > > > > Currently we have a BUG_ON() to make sure the number of sg
> > > > > > > > > list does not exceed queue_max_segments() in virtio_queue=
_rq().
> > > > > > > > > However, the block layer uses queue_max_discard_segments()
> > > > > > > > > instead of queue_max_segments() to limit the sg list for
> > > > > > > > > discard requests. So the BUG_ON() might be triggered if
> > > > > > > > > virtio-blk device reports a larger value for max discard
> > > > > > > > > segment than queue_max_segments().
> > > > > > > > Hmm the spec does not say what should happen if max_discard=
_seg
> > > > > > > > exceeds seg_max. Is this the config you have in mind? how d=
o you
> > > > > > > > create it?
> > > > > > > I don't think it's hard to create it. Just change some regist=
ers in the
> > > > > > > device.
> > > > > > > =

> > > > > > > But with the dynamic sgl allocation that I added recently, th=
ere is no
> > > > > > > problem with this scenario.
> > > > > > Well the problem is device says it can't handle such large desc=
riptors,
> > > > > > I guess it works anyway, but it seems scary.
> > > > > I don't follow.
> > > > > =

> > > > > The only problem this patch solves is when a virtio blk device re=
ports
> > > > > larger value for max_discard_segments than max_segments.
> > > > > =

> > > > No, the peroblem reported is when virtio blk device reports
> > > > max_segments < 256 but not max_discard_segments.
> > > You mean the code will work in case device report max_discard_segment=
s=A0 >
> > > max_segments ?
> > > =

> > > I don't think so.
> > I think it's like this:
> > =

> > =

> >          if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> > =

> > 		....
> > =

> >                  virtio_cread(vdev, struct virtio_blk_config, max_disca=
rd_seg,
> >                               &v);
> >                  blk_queue_max_discard_segments(q,
> >                                                 min_not_zero(v,
> >                                                              MAX_DISCAR=
D_SEGMENTS));
> > =

> > 	}
> > =

> > so, IIUC the case is of a device that sets max_discard_seg to 0.
> > =

> > Which is kind of broken, but we handled this since 2018 so I guess
> > we'll need to keep doing that.
> =

> A device can't state VIRTIO_BLK_F_DISCARD and set max_discard_seg to 0.
> =

> If so, it's a broken device and we can add a quirk for it.

Well we already have min_not_zero there, presumably for some reason.

> Do you have such device to test ?

Xie Yongji mentioned he does.

> > =

> > > This is exactly what Xie Yongji mention in the commit message and wha=
t I was
> > > seeing.
> > > =

> > > But the code will work if VIRTIO_BLK_F_DISCARD is not supported by the
> > > device (even if max_segments < 256) , since blk layer set
> > > queue_max_discard_segments =3D 1 in the initialization.
> > > =

> > > And the virtio-blk driver won't change it unless VIRTIO_BLK_F_DISCARD=
 is
> > > supported.
> > > =

> > > > I would expect discard to follow max_segments restrictions then.
> > > > =

> > > > > Probably no such devices, but we need to be prepared.
> > > > Right, question is how to handle this.
> > > > =

> > > > > > > This commit looks good to me, thanks Xie Yongji.
> > > > > > > =

> > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > =

> > > > > > > > > To fix it, let's simply
> > > > > > > > > remove the BUG_ON() which has become unnecessary after co=
mmit
> > > > > > > > > 02746e26c39e("virtio-blk: avoid preallocating big SGL for=
 data").
> > > > > > > > > And the unused vblk->sg_elems can also be removed togethe=
r.
> > > > > > > > > =

> > > > > > > > > Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write z=
eroes support")
> > > > > > > > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/block/virtio_blk.c | 10 +---------
> > > > > > > > >      1 file changed, 1 insertion(+), 9 deletions(-)
> > > > > > > > > =

> > > > > > > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/v=
irtio_blk.c
> > > > > > > > > index c443cd64fc9b..a43eb1813cec 100644
> > > > > > > > > --- a/drivers/block/virtio_blk.c
> > > > > > > > > +++ b/drivers/block/virtio_blk.c
> > > > > > > > > @@ -76,9 +76,6 @@ struct virtio_blk {
> > > > > > > > >      	 */
> > > > > > > > >      	refcount_t refs;
> > > > > > > > > -	/* What host tells us, plus 2 for header & tailer. */
> > > > > > > > > -	unsigned int sg_elems;
> > > > > > > > > -
> > > > > > > > >      	/* Ida index - used to track minor number allocatio=
ns. */
> > > > > > > > >      	int index;
> > > > > > > > > @@ -322,8 +319,6 @@ static blk_status_t virtio_queue_rq(s=
truct blk_mq_hw_ctx *hctx,
> > > > > > > > >      	blk_status_t status;
> > > > > > > > >      	int err;
> > > > > > > > > -	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > > > > > > > > -
> > > > > > > > >      	status =3D virtblk_setup_cmd(vblk->vdev, req, vbr);
> > > > > > > > >      	if (unlikely(status))
> > > > > > > > >      		return status;
> > > > > > > > > @@ -783,8 +778,6 @@ static int virtblk_probe(struct virti=
o_device *vdev)
> > > > > > > > >      	/* Prevent integer overflows and honor max vq size =
*/
> > > > > > > > >      	sg_elems =3D min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG=
_ELEMS - 2);
> > > > > > > > > -	/* We need extra sg elements at head and tail. */
> > > > > > > > > -	sg_elems +=3D 2;
> > > > > > > > >      	vdev->priv =3D vblk =3D kmalloc(sizeof(*vblk), GFP_=
KERNEL);
> > > > > > > > >      	if (!vblk) {
> > > > > > > > >      		err =3D -ENOMEM;
> > > > > > > > > @@ -796,7 +789,6 @@ static int virtblk_probe(struct virti=
o_device *vdev)
> > > > > > > > >      	mutex_init(&vblk->vdev_mutex);
> > > > > > > > >      	vblk->vdev =3D vdev;
> > > > > > > > > -	vblk->sg_elems =3D sg_elems;
> > > > > > > > >      	INIT_WORK(&vblk->config_work, virtblk_config_change=
d_work);
> > > > > > > > > @@ -853,7 +845,7 @@ static int virtblk_probe(struct virti=
o_device *vdev)
> > > > > > > > >      		set_disk_ro(vblk->disk, 1);
> > > > > > > > >      	/* We can handle whatever the host told us to handl=
e. */
> > > > > > > > > -	blk_queue_max_segments(q, vblk->sg_elems-2);
> > > > > > > > > +	blk_queue_max_segments(q, sg_elems);
> > > > > > > > >      	/* No real sector limit. */
> > > > > > > > >      	blk_queue_max_hw_sectors(q, -1U);
> > > > > > > > > -- =

> > > > > > > > > 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
