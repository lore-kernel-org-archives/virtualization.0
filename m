Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006ABC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 10:39:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826EC64DDA
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 10:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826EC64DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14560867B6;
	Tue, 16 Feb 2021 10:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5io0WT9Fh3rf; Tue, 16 Feb 2021 10:39:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7F05867CF;
	Tue, 16 Feb 2021 10:39:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89024C0174;
	Tue, 16 Feb 2021 10:39:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BBF2C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 10:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 224048499A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 10:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TRwRu1y8FcOw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 10:39:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4F50A848C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 10:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613471955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U42npbqzTNGr7R0PCYCpwdMsQ24QOCgAs5gLci1PKhs=;
 b=HgG27+QT1yRyLH/APp5jif+1f7ec3AlDfvQZ8tLmEyav8x6obDG4/g7DGnbzlOQoYc4p3O
 oYkJMkcfKO42UKfkgkU5buA6w1PbVAFt8MiNny6onpY9G2CeP3Jzvwfm1ZsKq5yCoBYPte
 v8K9O11C6lGFbxA08rCCx+klYVgJsdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-eCZlNYbpOfmgMFGcsIo2-A-1; Tue, 16 Feb 2021 05:39:12 -0500
X-MC-Unique: eCZlNYbpOfmgMFGcsIo2-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DB58184ECC4;
 Tue, 16 Feb 2021 10:39:11 +0000 (UTC)
Received: from gondolin (ovpn-113-145.ams2.redhat.com [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05DB660C15;
 Tue, 16 Feb 2021 10:39:09 +0000 (UTC)
Date: Tue, 16 Feb 2021 11:39:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] virtio/s390: implement virtio-ccw revision 2 correctly
Message-ID: <20210216113907.4e6943a9.cohuck@redhat.com>
In-Reply-To: <20210215195144.7b96b41f.pasic@linux.ibm.com>
References: <20210212170411.992217-1-cohuck@redhat.com>
 <20210215124702.23a093b8.cohuck@redhat.com>
 <20210215195144.7b96b41f.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 Pierre Morel <pmorel@linux.ibm.com>, virtualization@lists.linux-foundation.org
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

On Mon, 15 Feb 2021 19:51:44 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 15 Feb 2021 12:47:02 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri, 12 Feb 2021 18:04:11 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > CCW_CMD_READ_STATUS was introduced with revision 2 of virtio-ccw,
> > > and drivers should only rely on it being implemented when they
> > > negotiated at least that revision with the device.
> > > 
> > > However, virtio_ccw_get_status() issued READ_STATUS for any
> > > device operating at least at revision 1. If the device accepts
> > > READ_STATUS regardless of the negotiated revision (which it is
> > > free to do),    
> > 
> > So, looking at the standard again, the device is actually required to
> > reject the READ_STATUS if only rev 1 had been negotiated... regardless
> > of that, I don't think we should change QEMU's behaviour, as it would
> > affect existing guests (they would lose access to the status bits as
> > observed by the device, including DEVICE_NEEDS_RESET.)  
> 
> Not only that, without READ_STATUS, we can't do device reset which
> is a prerequisite for a proper cleanup, as required by the spec.
> 
> You certainly remember, the driver has may not assume the reset
> was performed (and thus virtqueues are not live) until it reads
> back status 0. But without READ_STATUS virtio_ccw_get_status() will
> keep returning the status the driver last set via
> virtio_ccw_set_status(). And CCW_CMD_VDEV_RESET is of course
> revision 1 material. This looks ugly!

Yes, that problem kind of cascades down.

> 
> >   
> > > everything works as intended; a device rejecting the
> > > command should also be handled gracefully. For correctness, we
> > > should really limit the command to revision 2 or higher, though.
> > > 
> > > We also negotiated the revision to at most 1, as we never bumped
> > > the maximum revision; let's do that now.
> > > 
> > > Fixes: 7d3ce5ab9430 ("virtio/s390: support READ_STATUS command for virtio-ccw")
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > > 
> > > QEMU does not fence off READ_STATUS for revisions < 2, which is probably
> > > why we never noticed this. I'm not aware of other hypervisors that do
> > > fence it off, nor any that cannot deal properly with an unknown command.
> > > 
> > > Not sure whether this is stable worthy?    
> > 
> > Maybe it is, given the MUST reject clause in the standard?
> >   
> 
> Yes, IMHO this must be backported. A device that ain't violating the
> spec would currently reject READ_STATUS. Which would break RESET_VDEV
> like I described above.
> 
> Can we change that MUST to should? There are now good reasons for not
> doing like the spec says in case of READ_STATUS.

Yes. I'm not so sure forcing the device to reject the command was such
a good idea anyway, and relaxing the requirement keeps existing
implementations in compliance.

I've opened https://github.com/oasis-tcs/virtio-spec/issues/96 and will
send a patch for the spec later.

> 
> > > 
> > > ---
> > >  drivers/s390/virtio/virtio_ccw.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > index 5730572b52cd..54e686dca6de 100644
> > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > @@ -117,7 +117,7 @@ struct virtio_rev_info {
> > >  };
> > >  
> > >  /* the highest virtio-ccw revision we support */
> > > -#define VIRTIO_CCW_REV_MAX 1
> > > +#define VIRTIO_CCW_REV_MAX 2
> > >  
> > >  struct virtio_ccw_vq_info {
> > >  	struct virtqueue *vq;
> > > @@ -952,7 +952,7 @@ static u8 virtio_ccw_get_status(struct virtio_device *vdev)
> > >  	u8 old_status = vcdev->dma_area->status;
> > >  	struct ccw1 *ccw;
> > >  
> > > -	if (vcdev->revision < 1)
> > > +	if (vcdev->revision < 2)
> > >  		return vcdev->dma_area->status;  
> 
> I don't think our faking of the status read (i.e. returning the old one)
> is contributing to spec compliance. Especially not if the inability to
> READ is not transient.
> 
> Also return old_status; would tell the story better, but on the
> other hand, that would be an unrelated cosmetic change. Maybe
> a separate patch?

We would also need to actively check for success or failure of the
channel program in that case.

I'm currently looking at the virtio-ccw code anyway, so I can put that
on my list as well.

> 
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

Thanks!

I'll do a v2 with a tweaked commit message and cc:stable.

> 
> Regards,
> Halil
> 
> > >  
> > >  	ccw = ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw));    
> >   
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
