Return-Path: <SRS0=p/QF=D6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8E9C4363A
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:49:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEB320878
	for <virtualization@archiver.kernel.org>; Fri, 23 Oct 2020 15:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JN953Toc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEB320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63FC087913;
	Fri, 23 Oct 2020 15:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GV9s1xfQfSO3; Fri, 23 Oct 2020 15:49:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C20BE878FC;
	Fri, 23 Oct 2020 15:49:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF5FC088B;
	Fri, 23 Oct 2020 15:49:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DF2CC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 386558762C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:49:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LLabeCAP8LEL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:49:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 96AFC87619
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603468177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zS3zbQ5mAxcqTA2ta8PP08q3tCi2hmU1sAmncCGoD2s=;
 b=JN953TocI8oI0jgKiEYyKTNV75xd9dlT7oVd0Zzq8zPdZ6NdAIBI5TaC/QIlqlKQZ8JAZz
 zkI2h+OWEGll95r52HYxP/5CoeaEL6E2EsbWsJlnrNNp8WcvjH71ZV0ycuUN8mjGg4pWAq
 yUXnxOFWt0gyXokOWIv6LxLA0fKuKTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-gk1zow5MORGzXBTcJSg6wQ-1; Fri, 23 Oct 2020 11:49:35 -0400
X-MC-Unique: gk1zow5MORGzXBTcJSg6wQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED5F107465C;
 Fri, 23 Oct 2020 15:49:33 +0000 (UTC)
Received: from redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65FC35C1CF;
 Fri, 23 Oct 2020 15:49:31 +0000 (UTC)
Date: Fri, 23 Oct 2020 11:49:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Hofmann <sebastian@kaemmelot.de>
Subject: Re: [PATCH] virtio_ring: use DMA when memory encryption is active
Message-ID: <20201023114903-mutt-send-email-mst@kernel.org>
References: <1075010014.50900.1603293266000@office.mailbox.org>
 <20201022073716-mutt-send-email-mst@kernel.org>
 <1419750420.56704.1603443654667@office.mailbox.org>
MIME-Version: 1.0
In-Reply-To: <1419750420.56704.1603443654667@office.mailbox.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Fri, Oct 23, 2020 at 11:00:54AM +0200, Sebastian Hofmann wrote:
> > Michael S. Tsirkin <mst@redhat.com> hat am 22.10.2020 13:39 geschrieben:
> > =

> >  =

> > On Wed, Oct 21, 2020 at 05:14:25PM +0200, Sebastian Hofmann wrote:
> > > virtio_ring does not work with active memory encryption because the h=
ost cannot read it. Fix this by enforcing the use of DMA which uses shared =
(unencrypted) memory pages.
> > > =

> > > Signed-off-by: Sebastian Hofmann <sebastian@kaemmelot.de>
> > =

> > =

> > Sorry, no.
> > host which can not access all of driver memory must set VIRTIO_F_ACCESS=
_PLATFORM.
> > =

> > Not worth it to work around broken hosts.
> > =

> > Xen is an exception we carry around since it predates the
> > introduction of VIRTIO_F_ACCESS_PLATFORM.
> > =

> > =

> =

> Thanks for pointing out VIRTIO_F_ACCESS_PLATFORM which I was not aware of=
. Maybe that patch was a bit na=C3=AFve.
> =

> Basically I'm looking for a way to use vsock with qemu on AMD SEV. When I=
 try to use IOMMU for vsock I get an EOPNOTSUPP out of vhost_vsock_set_feat=
ures.
> =

> Is there a reason why vhost_vsock_set_features doesn't use vhost_init_dev=
ice_iotlb as done in the net device? Because that would have been my next a=
ttempt.
> I would appreciate a short comment on this idea or a recommendation for a=
nother solution that is better than the patch below.

Not sure I understand the problem. Are you using qemu? If so just add
iommu_platform=3Don and you are done.


> > > ---
> > >  drivers/virtio/virtio_ring.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > =

> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index becc77697960..8c68c475ec21 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/hrtimer.h>
> > >  #include <linux/dma-mapping.h>
> > >  #include <xen/xen.h>
> > > +#include <linux/mem_encrypt.h>
> > >  =

> > >  #ifdef DEBUG
> > >  /* For development, we want to crash whenever the ring is screwed. */
> > > @@ -255,6 +256,10 @@ static bool vring_use_dma_api(struct virtio_devi=
ce *vdev)
> > >  	if (xen_domain())
> > >  		return true;
> > >  =

> > > +	/* Memory encryption requires DMA */
> > > +	if (mem_encrypt_active())
> > > +		return true;
> > > +
> > >  	return false;
> > >  }
> > >  =

> > > -- =

> > > 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
