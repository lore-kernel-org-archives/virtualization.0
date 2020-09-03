Return-Path: <SRS0=9O9Z=CM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A57C433E2
	for <virtualization@archiver.kernel.org>; Thu,  3 Sep 2020 05:52:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C1320665
	for <virtualization@archiver.kernel.org>; Thu,  3 Sep 2020 05:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C1320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1251587324;
	Thu,  3 Sep 2020 05:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M8d+xmda4EKg; Thu,  3 Sep 2020 05:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9778887321;
	Thu,  3 Sep 2020 05:52:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7811CC0052;
	Thu,  3 Sep 2020 05:52:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EEFCC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 05:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 316F92E0EA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 05:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4h8FLoL5+Mg
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 05:51:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 0850A20450
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 05:51:54 +0000 (UTC)
IronPort-SDR: lqrsnC+vrLWVLpNrkEZEGscMGr5gbQ4bBSpKXXx+p7KGYgASAbSOe/uZyYxgdT7GL4qQ93fYPB
 qrutfAe2DnCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="158508365"
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; d="scan'208";a="158508365"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 22:51:53 -0700
IronPort-SDR: mPuXkLFk1WWA/cEIsIVsDzv1uH/WmGbeWjT4VWMoPcNwaJrJF5e8FNwQmIkp9Cr77Yabt2YVsv
 7d0nquKeB13Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; d="scan'208";a="283977472"
Received: from vmabille-mobl1.ger.corp.intel.com (HELO ubuntu) ([10.252.54.65])
 by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2020 22:51:49 -0700
Date: Thu, 3 Sep 2020 07:51:48 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 2/4] rpmsg: move common structures and defines to
 headers
Message-ID: <20200903055148.GA7573@ubuntu>
References: <20200901151153.28111-1-guennadi.liakhovetski@linux.intel.com>
 <20200901151153.28111-3-guennadi.liakhovetski@linux.intel.com>
 <20200901172321.GC236120@xps15> <20200902053527.GA31486@ubuntu>
 <20200902172437.GC280378@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200902172437.GC280378@xps15>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ohad Ben-Cohen <ohad@wizery.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

Hi Mathieu,

On Wed, Sep 02, 2020 at 11:24:37AM -0600, Mathieu Poirier wrote:
> On Wed, Sep 02, 2020 at 07:35:27AM +0200, Guennadi Liakhovetski wrote:
> > Hi Mathew,
> > 
> > On Tue, Sep 01, 2020 at 11:23:21AM -0600, Mathieu Poirier wrote:
> > > On Tue, Sep 01, 2020 at 05:11:51PM +0200, Guennadi Liakhovetski wrote:
> > > > virtio_rpmsg_bus.c keeps RPMsg protocol structure declarations and
> > > > common defines like the ones, needed for name-space announcements,
> > > > internal. Move them to common headers instead.
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > 
> > > I already reviewed this patch and added my RB to it.  Please carry it in your
> > > next revision.
> > 
> > But only as long as the patch doesn't change, right? And in fact it did change 
> > this time - I renamed the header, moving it under include/linux/rpmsg, actually 
> 
> Patch 2/4 in V5 was identical to what was submitted in V4 and my RB tag was not
> added, nor was the entry for virtio_rpmsg.h added to the MAINTAINERS file.

Right, yes, I forgot about that your request when creating v5, sorry about that, 
that's why I made a v6 with the header moved to include/linux/rpmsg/.

> > also following your suggestion. Still, formally the patch has changed, so, I 
> > didn't include your "Reviewed-by" in this version. And you anyway would be 
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> > reviewing the other patches in this series to, right?
> 
> As much as I'd like to reviewing the other patches in this series won't be
> possible at this time. 

Ok, understand, I'm wondering then what the path to upstreaming would be then?

Thanks
Guennadi

> > > Thanks,
> > > Mathieu
> > > 
> > > > ---
> > > >  drivers/rpmsg/virtio_rpmsg_bus.c | 78 +-----------------------------
> > > >  include/linux/rpmsg/virtio.h     | 83 ++++++++++++++++++++++++++++++++
> > > >  include/uapi/linux/rpmsg.h       |  3 ++
> > > >  3 files changed, 88 insertions(+), 76 deletions(-)
> > > >  create mode 100644 include/linux/rpmsg/virtio.h
> > > > 
> > > > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > index 9006fc7f73d0..f39c426f9c5e 100644
> > > > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > @@ -19,6 +19,7 @@
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/of_device.h>
> > > >  #include <linux/rpmsg.h>
> > > > +#include <linux/rpmsg/virtio.h>
> > > >  #include <linux/scatterlist.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/sched.h>
> > > > @@ -27,6 +28,7 @@
> > > >  #include <linux/virtio_ids.h>
> > > >  #include <linux/virtio_config.h>
> > > >  #include <linux/wait.h>
> > > > +#include <uapi/linux/rpmsg.h>
> > > >  
> > > >  #include "rpmsg_internal.h"
> > > >  
> > > > @@ -70,58 +72,6 @@ struct virtproc_info {
> > > >  	struct rpmsg_endpoint *ns_ept;
> > > >  };
> > > >  
> > > > -/* The feature bitmap for virtio rpmsg */
> > > > -#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> > > > -
> > > > -/**
> > > > - * struct rpmsg_hdr - common header for all rpmsg messages
> > > > - * @src: source address
> > > > - * @dst: destination address
> > > > - * @reserved: reserved for future use
> > > > - * @len: length of payload (in bytes)
> > > > - * @flags: message flags
> > > > - * @data: @len bytes of message payload data
> > > > - *
> > > > - * Every message sent(/received) on the rpmsg bus begins with this header.
> > > > - */
> > > > -struct rpmsg_hdr {
> > > > -	__virtio32 src;
> > > > -	__virtio32 dst;
> > > > -	__virtio32 reserved;
> > > > -	__virtio16 len;
> > > > -	__virtio16 flags;
> > > > -	u8 data[];
> > > > -} __packed;
> > > > -
> > > > -/**
> > > > - * struct rpmsg_ns_msg - dynamic name service announcement message
> > > > - * @name: name of remote service that is published
> > > > - * @addr: address of remote service that is published
> > > > - * @flags: indicates whether service is created or destroyed
> > > > - *
> > > > - * This message is sent across to publish a new service, or announce
> > > > - * about its removal. When we receive these messages, an appropriate
> > > > - * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
> > > > - * or ->remove() handler of the appropriate rpmsg driver will be invoked
> > > > - * (if/as-soon-as one is registered).
> > > > - */
> > > > -struct rpmsg_ns_msg {
> > > > -	char name[RPMSG_NAME_SIZE];
> > > > -	__virtio32 addr;
> > > > -	__virtio32 flags;
> > > > -} __packed;
> > > > -
> > > > -/**
> > > > - * enum rpmsg_ns_flags - dynamic name service announcement flags
> > > > - *
> > > > - * @RPMSG_NS_CREATE: a new remote service was just created
> > > > - * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> > > > - */
> > > > -enum rpmsg_ns_flags {
> > > > -	RPMSG_NS_CREATE		= 0,
> > > > -	RPMSG_NS_DESTROY	= 1,
> > > > -};
> > > > -
> > > >  /**
> > > >   * @vrp: the remote processor this channel belongs to
> > > >   */
> > > > @@ -134,27 +84,6 @@ struct virtio_rpmsg_channel {
> > > >  #define to_virtio_rpmsg_channel(_rpdev) \
> > > >  	container_of(_rpdev, struct virtio_rpmsg_channel, rpdev)
> > > >  
> > > > -/*
> > > > - * We're allocating buffers of 512 bytes each for communications. The
> > > > - * number of buffers will be computed from the number of buffers supported
> > > > - * by the vring, upto a maximum of 512 buffers (256 in each direction).
> > > > - *
> > > > - * Each buffer will have 16 bytes for the msg header and 496 bytes for
> > > > - * the payload.
> > > > - *
> > > > - * This will utilize a maximum total space of 256KB for the buffers.
> > > > - *
> > > > - * We might also want to add support for user-provided buffers in time.
> > > > - * This will allow bigger buffer size flexibility, and can also be used
> > > > - * to achieve zero-copy messaging.
> > > > - *
> > > > - * Note that these numbers are purely a decision of this driver - we
> > > > - * can change this without changing anything in the firmware of the remote
> > > > - * processor.
> > > > - */
> > > > -#define MAX_RPMSG_NUM_BUFS	(512)
> > > > -#define MAX_RPMSG_BUF_SIZE	(512)
> > > > -
> > > >  /*
> > > >   * Local addresses are dynamically allocated on-demand.
> > > >   * We do not dynamically assign addresses from the low 1024 range,
> > > > @@ -162,9 +91,6 @@ struct virtio_rpmsg_channel {
> > > >   */
> > > >  #define RPMSG_RESERVED_ADDRESSES	(1024)
> > > >  
> > > > -/* Address 53 is reserved for advertising remote services */
> > > > -#define RPMSG_NS_ADDR			(53)
> > > > -
> > > >  static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept);
> > > >  static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
> > > >  static int virtio_rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len,
> > > > diff --git a/include/linux/rpmsg/virtio.h b/include/linux/rpmsg/virtio.h
> > > > new file mode 100644
> > > > index 000000000000..3ede1a4a68a3
> > > > --- /dev/null
> > > > +++ b/include/linux/rpmsg/virtio.h
> > > > @@ -0,0 +1,83 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +#ifndef _LINUX_RPMSG_VIRTIO_H
> > > > +#define _LINUX_RPMSG_VIRTIO_H
> > > > +
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/virtio_types.h>
> > > > +
> > > > +/**
> > > > + * struct rpmsg_hdr - common header for all rpmsg messages
> > > > + * @src: source address
> > > > + * @dst: destination address
> > > > + * @reserved: reserved for future use
> > > > + * @len: length of payload (in bytes)
> > > > + * @flags: message flags
> > > > + * @data: @len bytes of message payload data
> > > > + *
> > > > + * Every message sent(/received) on the rpmsg bus begins with this header.
> > > > + */
> > > > +struct rpmsg_hdr {
> > > > +	__virtio32 src;
> > > > +	__virtio32 dst;
> > > > +	__virtio32 reserved;
> > > > +	__virtio16 len;
> > > > +	__virtio16 flags;
> > > > +	u8 data[];
> > > > +} __packed;
> > > > +
> > > > +/**
> > > > + * struct rpmsg_ns_msg - dynamic name service announcement message
> > > > + * @name: name of remote service that is published
> > > > + * @addr: address of remote service that is published
> > > > + * @flags: indicates whether service is created or destroyed
> > > > + *
> > > > + * This message is sent across to publish a new service, or announce
> > > > + * about its removal. When we receive these messages, an appropriate
> > > > + * rpmsg channel (i.e device) is created/destroyed. In turn, the ->probe()
> > > > + * or ->remove() handler of the appropriate rpmsg driver will be invoked
> > > > + * (if/as-soon-as one is registered).
> > > > + */
> > > > +struct rpmsg_ns_msg {
> > > > +	char name[RPMSG_NAME_SIZE];
> > > > +	__virtio32 addr;
> > > > +	__virtio32 flags;
> > > > +} __packed;
> > > > +
> > > > +/**
> > > > + * enum rpmsg_ns_flags - dynamic name service announcement flags
> > > > + *
> > > > + * @RPMSG_NS_CREATE: a new remote service was just created
> > > > + * @RPMSG_NS_DESTROY: a known remote service was just destroyed
> > > > + */
> > > > +enum rpmsg_ns_flags {
> > > > +	RPMSG_NS_CREATE		= 0,
> > > > +	RPMSG_NS_DESTROY	= 1,
> > > > +};
> > > > +
> > > > +/*
> > > > + * We're allocating buffers of 512 bytes each for communications. The
> > > > + * number of buffers will be computed from the number of buffers supported
> > > > + * by the vring, upto a maximum of 512 buffers (256 in each direction).
> > > > + *
> > > > + * Each buffer will have 16 bytes for the msg header and 496 bytes for
> > > > + * the payload.
> > > > + *
> > > > + * This will utilize a maximum total space of 256KB for the buffers.
> > > > + *
> > > > + * We might also want to add support for user-provided buffers in time.
> > > > + * This will allow bigger buffer size flexibility, and can also be used
> > > > + * to achieve zero-copy messaging.
> > > > + *
> > > > + * Note that these numbers are purely a decision of this driver - we
> > > > + * can change this without changing anything in the firmware of the remote
> > > > + * processor.
> > > > + */
> > > > +#define MAX_RPMSG_NUM_BUFS	512
> > > > +#define MAX_RPMSG_BUF_SIZE	512
> > > > +
> > > > +/* Address 53 is reserved for advertising remote services */
> > > > +#define RPMSG_NS_ADDR		53
> > > > +
> > > > +#endif
> > > > diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> > > > index e14c6dab4223..d669c04ef289 100644
> > > > --- a/include/uapi/linux/rpmsg.h
> > > > +++ b/include/uapi/linux/rpmsg.h
> > > > @@ -24,4 +24,7 @@ struct rpmsg_endpoint_info {
> > > >  #define RPMSG_CREATE_EPT_IOCTL	_IOW(0xb5, 0x1, struct rpmsg_endpoint_info)
> > > >  #define RPMSG_DESTROY_EPT_IOCTL	_IO(0xb5, 0x2)
> > > >  
> > > > +/* The feature bitmap for virtio rpmsg */
> > > > +#define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
> > > > +
> > > >  #endif
> > > > -- 
> > > > 2.28.0
> > > > 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
