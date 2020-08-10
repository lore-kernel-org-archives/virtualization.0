Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016CAC433E0
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 13:44:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE68E206E9
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 13:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8K1+PHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE68E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 92B2F88296;
	Mon, 10 Aug 2020 13:44:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aUmGt-OEc+Yz; Mon, 10 Aug 2020 13:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C2BA78822B;
	Mon, 10 Aug 2020 13:44:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 944B6C0864;
	Mon, 10 Aug 2020 13:44:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A3B8C004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5FC7B8912C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EpK0u6SUyv9j
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:44:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1EFAF890A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597067065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V1Ht/xtTouLriwLsm/eS0eaCM+WZCELWGcwFNPhIusQ=;
 b=h8K1+PHdIGF7KbDZp6ryytLhWwgvTbYePVIy1i405RmwCBy/lS6TnVUKjMTmc2z6zVKYcT
 9oMjaCl8ytVjBvWhi1DlCJNgMGFdinbBRswlcfD5YeYiiKjrmQFwSOwJ0Q6FmE6mxnZxJ4
 jwRjyyadufnTFPhyoJM6gFVqO/Jaags=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-hhHwvwC3MvuY55tD25NDcA-1; Mon, 10 Aug 2020 09:44:21 -0400
X-MC-Unique: hhHwvwC3MvuY55tD25NDcA-1
Received: by mail-wm1-f70.google.com with SMTP id h7so2880619wmm.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 06:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V1Ht/xtTouLriwLsm/eS0eaCM+WZCELWGcwFNPhIusQ=;
 b=gzoEPvdG1LTlw4e1BS2HJQYSO0BRBnKB0mBLv7aeVWTs3c71DKnfWSX+Q455Y1bpsJ
 nrEOZnwmpRhiTt830rqSgmaZJicEeRndqkwO4kqBDR4I/EDQ2aOHuFLH7+5f5jpDzHgy
 5s/dUpMKMFlJeVaGzCwtrxIv0T3gjXmyQMdqdcPuDHEKgJGkRTIsCO2K15xQ7ovsxfGP
 0EYzZwER6UBAR8kM9s/Q7Lf8ni0OdPDJplHzIEisf81RXHvGFeRWWlPafHeudkRg8+6r
 L0u7Wvzk2uUm4maOlLlEa77RvQS//CojNzOiwVgAH+ZqPr+mrEK3LFAgH0qhVzcZdvD8
 gwyQ==
X-Gm-Message-State: AOAM531GiRrI/8r+EFBngpDlbaNl9eSieX1G/FVV66q+FF8JveamCE0e
 IJ/5LnyNesW8RPQQvLRRMgkRETigCUr/7KuwfWW5Uu1dB73nAFpmvG7wHgnmFG0prR7hsWRwqSP
 TAZpOWLlUZJzirjt2RB4gfTrYQTRBh8gEbHI9NwpLNA==
X-Received: by 2002:adf:bb83:: with SMTP id q3mr1711995wrg.58.1597067060157;
 Mon, 10 Aug 2020 06:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynhZhPGH/raEuBPiKR+cj/1IcMJN4rJhlv/0a7x4pg7k/Q9IZEP+R7MmFeP+iRyWhw2v+v5w==
X-Received: by 2002:adf:bb83:: with SMTP id q3mr1711966wrg.58.1597067059858;
 Mon, 10 Aug 2020 06:44:19 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id g25sm20355599wmh.35.2020.08.10.06.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 06:44:18 -0700 (PDT)
Date: Mon, 10 Aug 2020 09:44:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v4 4/4] vhost: add an RPMsg API
Message-ID: <20200810094013-mutt-send-email-mst@kernel.org>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
 <20200722150927.15587-5-guennadi.liakhovetski@linux.intel.com>
 <20200804102132-mutt-send-email-mst@kernel.org>
 <20200804151916.GC19025@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20200804151916.GC19025@ubuntu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, kvm@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-remoteproc@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 sound-open-firmware@alsa-project.org
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

On Tue, Aug 04, 2020 at 05:19:17PM +0200, Guennadi Liakhovetski wrote:
> On Tue, Aug 04, 2020 at 10:27:08AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 22, 2020 at 05:09:27PM +0200, Guennadi Liakhovetski wrote:
> > > Linux supports running the RPMsg protocol over the VirtIO transport
> > > protocol, but currently there is only support for VirtIO clients and
> > > no support for a VirtIO server. This patch adds a vhost-based RPMsg
> > > server implementation.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > ---
> > >  drivers/vhost/Kconfig       |   7 +
> > >  drivers/vhost/Makefile      |   3 +
> > >  drivers/vhost/rpmsg.c       | 375 ++++++++++++++++++++++++++++++++++++
> > >  drivers/vhost/vhost_rpmsg.h |  74 +++++++
> > >  4 files changed, 459 insertions(+)
> > >  create mode 100644 drivers/vhost/rpmsg.c
> > >  create mode 100644 drivers/vhost/vhost_rpmsg.h
> > > 
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index d3688c6afb87..602421bf1d03 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -38,6 +38,13 @@ config VHOST_NET
> > >  	  To compile this driver as a module, choose M here: the module will
> > >  	  be called vhost_net.
> > >  
> > > +config VHOST_RPMSG
> > > +	tristate
> > 
> > So this lacks a description line so it does not appear
> > in menuconfig. How is user supposed to set it?
> > I added a one-line description.
> 
> That was on purpose. I don't think there's any value in this API stand-alone, 
> so I let users select it as needed. But we can change that too, id desired.

I guess the patches actually selecting this 
are separate then?

> > > +	depends on VHOST
> > 
> > Other drivers select VHOST instead. Any reason not to
> > do it like this here?
> 
> I have
> 
> +	select VHOST
> +	select VHOST_RPMSG
> 
> in my client driver patch.

Any issues selecting from here so others get it for free?
If this is selected then dependencies are ignored ...

> > > +	help
> > > +	  Vhost RPMsg API allows vhost drivers to communicate with VirtIO
> > > +	  drivers, using the RPMsg over VirtIO protocol.
> > > +
> > 
> > >  config VHOST_SCSI
> > >  	tristate "VHOST_SCSI TCM fabric driver"
> > >  	depends on TARGET_CORE && EVENTFD
> > > diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> > > index f3e1897cce85..9cf459d59f97 100644
> > > --- a/drivers/vhost/Makefile
> > > +++ b/drivers/vhost/Makefile
> > > @@ -2,6 +2,9 @@
> > >  obj-$(CONFIG_VHOST_NET) += vhost_net.o
> > >  vhost_net-y := net.o
> > >  
> > > +obj-$(CONFIG_VHOST_RPMSG) += vhost_rpmsg.o
> > > +vhost_rpmsg-y := rpmsg.o
> > > +
> > >  obj-$(CONFIG_VHOST_SCSI) += vhost_scsi.o
> > >  vhost_scsi-y := scsi.o
> > >  
> > > diff --git a/drivers/vhost/rpmsg.c b/drivers/vhost/rpmsg.c
> > > new file mode 100644
> > > index 000000000000..d7ab48414224
> > > --- /dev/null
> > > +++ b/drivers/vhost/rpmsg.c
> > > @@ -0,0 +1,375 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright(c) 2020 Intel Corporation. All rights reserved.
> > > + *
> > > + * Author: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > + *
> > > + * Vhost RPMsg VirtIO interface. It provides a set of functions to match the
> > > + * guest side RPMsg VirtIO API, provided by drivers/rpmsg/virtio_rpmsg_bus.c
> > > + * These functions handle creation of 2 virtual queues, handling of endpoint
> > > + * addresses, sending a name-space announcement to the guest as well as any
> > > + * user messages. This API can be used by any vhost driver to handle RPMsg
> > > + * specific processing.
> > > + * Specific vhost drivers, using this API will use their own VirtIO device
> > > + * IDs, that should then also be added to the ID table in virtio_rpmsg_bus.c
> > > + */
> > > +
> > > +#include <linux/compat.h>
> > > +#include <linux/file.h>
> > > +#include <linux/miscdevice.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/vhost.h>
> > > +#include <linux/virtio_rpmsg.h>
> > > +#include <uapi/linux/rpmsg.h>
> > > +
> > > +#include "vhost.h"
> > > +#include "vhost_rpmsg.h"
> > > +
> > > +/*
> > > + * All virtio-rpmsg virtual queue kicks always come with just one buffer -
> > > + * either input or output
> > > + */
> > > +static int vhost_rpmsg_get_single(struct vhost_virtqueue *vq)
> > > +{
> > > +	struct vhost_rpmsg *vr = container_of(vq->dev, struct vhost_rpmsg, dev);
> > > +	unsigned int out, in;
> > > +	int head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov), &out, &in,
> > > +				     NULL, NULL);
> > > +	if (head < 0) {
> > > +		vq_err(vq, "%s(): error %d getting buffer\n",
> > > +		       __func__, head);
> > > +		return head;
> > > +	}
> > > +
> > > +	/* Nothing new? */
> > > +	if (head == vq->num)
> > > +		return head;
> > > +
> > > +	if (vq == &vr->vq[VIRTIO_RPMSG_RESPONSE] && (out || in != 1)) {
> > 
> > This in != 1 looks like a dependency on a specific message layout.
> > virtio spec says to avoid these. Using iov iters it's not too hard to do
> > ...
> 
> This is an RPMsg VirtIO implementation, and it has to match the virtio_rpmsg_bus.c 
> driver, and that one has specific VirtIO queue and message usage patterns.

That could be fine for legacy virtio, but now you are claiming support
for virtio 1, so need to fix these assumptions in the device.


> > > +		vq_err(vq,
> > > +		       "%s(): invalid %d input and %d output in response queue\n",
> > > +		       __func__, in, out);
> > > +		goto return_buf;
> > > +	}
> > > +
> > > +	if (vq == &vr->vq[VIRTIO_RPMSG_REQUEST] && (in || out != 1)) {
> > > +		vq_err(vq,
> > > +		       "%s(): invalid %d input and %d output in request queue\n",
> > > +		       __func__, in, out);
> > > +		goto return_buf;
> > > +	}
> > > +
> > > +	return head;
> > > +
> > > +return_buf:
> > > +	/*
> > > +	 * FIXME: might need to return the buffer using vhost_add_used()
> > > +	 * or vhost_discard_vq_desc(). vhost_discard_vq_desc() is
> > > +	 * described as "being useful for error handling," but it makes
> > > +	 * the thus discarded buffers "unseen," so next time we look we
> > > +	 * retrieve them again?
> > 
> > 
> > Yes. It's your decision what to do on error. if you also signal
> > an eventfd using vq_err, then discarding will
> > make it so userspace can poke at ring and hopefully fix it ...
> 
> I assume the user-space in this case is QEMU. Would it be the safest to use 
> vhost_add_used() then?

Your call.

> > > +	 */
> > > +	return -EINVAL;
> > > +}
> 
> [snip]
> 
> > > +	return 0;
> > > +
> > > +return_buf:
> > > +	/*
> > > +	 * FIXME: vhost_discard_vq_desc() or vhost_add_used(), see comment in
> > > +	 * vhost_rpmsg_get_single()
> > > +	 */
> > 
> > What's to be done with this FIXME?
> 
> This is the same question as above - I just wasn't sure which error handling 
> was appropriate here, don't think many vhost drivers do any od this...
> 
> Thanks
> Guennadi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
