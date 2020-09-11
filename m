Return-Path: <SRS0=G0EF=CU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FCBC43461
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 07:47:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4216F2076C
	for <virtualization@archiver.kernel.org>; Fri, 11 Sep 2020 07:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4216F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AB50187796;
	Fri, 11 Sep 2020 07:47:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zw1ShWp6hBNF; Fri, 11 Sep 2020 07:47:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7ACB68760F;
	Fri, 11 Sep 2020 07:47:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CF73C0052;
	Fri, 11 Sep 2020 07:47:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD8FEC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 97B5A20506
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U7I+vpo4THUG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:47:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 18D4F2050A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:47:09 +0000 (UTC)
IronPort-SDR: l9AR3hrn55PaNotSIVX5SGhiR7UpXW/aNOb1/kFhLZ70W4dTqWuVEuyb7JLx6Hg6FqiCFlDmun
 xDq10xJn/27g==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="220266164"
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; d="scan'208";a="220266164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2020 00:47:08 -0700
IronPort-SDR: Pr6O7tXzxwK7CWMZLtzlDZi/SDcpq1JWIWVSQ1cg2065NjKFQUlNDk5rCJnzRAdmpTjycAQI71
 ub56KP7rP04Q==
X-IronPort-AV: E=Sophos;i="5.76,414,1592895600"; d="scan'208";a="318205567"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu)
 ([10.252.38.203])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2020 00:47:05 -0700
Date: Fri, 11 Sep 2020 09:46:56 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 4/4] vhost: add an RPMsg API
Message-ID: <20200911074655.GA26801@ubuntu>
References: <20200826174636.23873-1-guennadi.liakhovetski@linux.intel.com>
 <20200826174636.23873-5-guennadi.liakhovetski@linux.intel.com>
 <20200909223946.GA562265@xps15> <20200910083853.GB17698@ubuntu>
 <20200910172211.GB579940@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910172211.GB579940@xps15>
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

On Thu, Sep 10, 2020 at 11:22:11AM -0600, Mathieu Poirier wrote:
> Good morning Guennadi,
> 
> On Thu, Sep 10, 2020 at 10:38:54AM +0200, Guennadi Liakhovetski wrote:
> > Hi Mathieu,
> > 
> > On Wed, Sep 09, 2020 at 04:39:46PM -0600, Mathieu Poirier wrote:
> > > Good afternoon,
> > > 
> > > On Wed, Aug 26, 2020 at 07:46:36PM +0200, Guennadi Liakhovetski wrote:
> > > > Linux supports running the RPMsg protocol over the VirtIO transport
> > > > protocol, but currently there is only support for VirtIO clients and
> > > > no support for a VirtIO server. This patch adds a vhost-based RPMsg
> > > > server implementation.
> > > 
> > > This changelog is very confusing...  At this time the name service in the
> > > remoteproc space runs as a server on the application processor.  But from the
> > > above the remoteproc usecase seems to be considered to be a client
> > > configuration.
> > 
> > I agree that this isn't very obvious. But I think it is common to call the 
> > host "a server" and guests "clients." E.g. in vhost.c in the top-of-thefile 
> > comment:
> 
> Ok - that part we agree on.
> 
> > 
> >  * Generic code for virtio server in host kernel.
> > 
> > I think the generic concept behind this notation is, that as guests boot, 
> > they send their requests to the host, e.g. VirtIO device drivers on guests 
> > send requests over VirtQueues to VirtIO servers on the host, which can run 
> > either in the user- or in the kernel-space. And I think you can follow that 
> 
> I can see that process taking place.  After all virtIO devices on guests are
> only stubs that need host support for access to HW.
> 
> > logic in case of devices or remote processors too: it's the main CPU(s) 
> > that boot(s) and start talking to devices and remote processors, so in that 
> > sence devices are servers and the CPUs are their clients.
> 
> In the remote processor case, the remoteproc core (application processor) sets up
> the name service but does not initiate the communication with a remote
> processor.  It simply waits there for a name space request to come in from the
> remote processor.

Hm, I don't see that in two examples, that I looked at: mtk and virtio. In both 
cases the announcement seems to be directly coming from the application processor 
maybe after some initialisation.

> > And yes, the name-space announcement use-case seems confusing to me too - it 
> > reverts the relationship in a way: once a guest has booted and established 
> > connections to any rpmsg "devices," those send their namespace announcements 
> > back. But I think this can be regarded as server identification: you connect 
> > to a server and it replies with its identification and capabilities.
> 
> Based on the above can I assume vhost_rpmsg_ns_announce() is sent from the
> guest?

No, it's "vhost_..." so it's running on the host. The host (the server, an 
analogue of the application processor, IIUC) sends NS announcements to guests.

> I saw your V7, something I will look into.  In the mean time I need to bring
> your attention to this set [1] from Arnaud.  Please have a look as it will
> impact your work.
> 
> https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335

Yes, I've had a look at that series, thanks for forwarding it to me. TBH I 
don't quite understand some choices there, e.g. creating a separate driver and 
then having to register devices just for the namespace announcement. I don't 
think creating virtual devices is taken easily in Linux. But either way I 
don't think our series conflict a lot, but I do hope that I can merge my 
series first, he'd just have to switch to using the header, that I'm adding. 
Hardly too many changes otherwise.

> > > And I don't see a server implementation per se...  It is more like a client
> > > implementation since vhost_rpmsg_announce() uses the RESPONSE queue, which sends
> > > messages from host to guest.
> > > 
> > > Perhaps it is my lack of familiarity with vhost terminology.
> > > 
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > > ---
> > > >  drivers/vhost/Kconfig       |   7 +
> > > >  drivers/vhost/Makefile      |   3 +
> > > >  drivers/vhost/rpmsg.c       | 373 ++++++++++++++++++++++++++++++++++++
> > > >  drivers/vhost/vhost_rpmsg.h |  74 +++++++
> > > >  4 files changed, 457 insertions(+)
> > > >  create mode 100644 drivers/vhost/rpmsg.c
> > > >  create mode 100644 drivers/vhost/vhost_rpmsg.h
> > > > 
> > > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > > index 587fbae06182..046b948fc411 100644
> > > > --- a/drivers/vhost/Kconfig
> > > > +++ b/drivers/vhost/Kconfig
> > > > @@ -38,6 +38,13 @@ config VHOST_NET
> > > >  	  To compile this driver as a module, choose M here: the module will
> > > >  	  be called vhost_net.
> > > >  
> > > > +config VHOST_RPMSG
> > > > +	tristate
> > > > +	select VHOST
> > > > +	help
> > > > +	  Vhost RPMsg API allows vhost drivers to communicate with VirtIO
> > > > +	  drivers, using the RPMsg over VirtIO protocol.
> > > 
> > > I had to assume vhost drivers are running on the host and virtIO drivers on the
> > > guests.  This may be common knowledge for people familiar with vhosts but
> > > certainly obscur for commoners  Having a help section that is clear on what is
> > > happening would remove any ambiguity.
> > 
> > It is the terminology, yes, but you're right, the wording isn't very clear, will 
> > improve.
> > 
> > > > +
> > > >  config VHOST_SCSI
> > > >  	tristate "VHOST_SCSI TCM fabric driver"
> > > >  	depends on TARGET_CORE && EVENTFD
> > > > diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> > > > index f3e1897cce85..9cf459d59f97 100644
> > > > --- a/drivers/vhost/Makefile
> > > > +++ b/drivers/vhost/Makefile
> > > > @@ -2,6 +2,9 @@
> > > >  obj-$(CONFIG_VHOST_NET) += vhost_net.o
> > > >  vhost_net-y := net.o
> > > >  
> > > > +obj-$(CONFIG_VHOST_RPMSG) += vhost_rpmsg.o
> > > > +vhost_rpmsg-y := rpmsg.o
> > > > +
> > > >  obj-$(CONFIG_VHOST_SCSI) += vhost_scsi.o
> > > >  vhost_scsi-y := scsi.o
> > > >  
> > > > diff --git a/drivers/vhost/rpmsg.c b/drivers/vhost/rpmsg.c
> > > > new file mode 100644
> > > > index 000000000000..c26d7a4afc6d
> > > > --- /dev/null
> > > > +++ b/drivers/vhost/rpmsg.c
> > > > @@ -0,0 +1,373 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright(c) 2020 Intel Corporation. All rights reserved.
> > > > + *
> > > > + * Author: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > > + *
> > > > + * Vhost RPMsg VirtIO interface. It provides a set of functions to match the
> > > > + * guest side RPMsg VirtIO API, provided by drivers/rpmsg/virtio_rpmsg_bus.c
> > > 
> > > Again, very confusing.  The changelog refers to a server implementation but to
> > > me this refers to a client implementation, especially if rpmsg_recv_single() and
> > > rpmsg_ns_cb() are used on the other side of the pipe.  
> > 
> > I think the above is correct. "Vhost" indicates, that this is running on the host. 
> > "match the guest side" means, that you can use this API on the host and it is 
> > designed to work together with the RPMsg VirtIO drivers running on guests, as 
> > implemented *on guests* by virtio_rpmsg_bus.c. Would "to work together" be a better 
> > description than "to match?"
> 
> Lets forget about this part now and concentrate on the above conversation.
> Things will start to make sense at one point.

I've improved that description a bit, it was indeed rather clumsy.

[snip]

> > > > diff --git a/drivers/vhost/vhost_rpmsg.h b/drivers/vhost/vhost_rpmsg.h
> > > > new file mode 100644
> > > > index 000000000000..30072cecb8a0
> > > > --- /dev/null
> > > > +++ b/drivers/vhost/vhost_rpmsg.h
> > > > @@ -0,0 +1,74 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Copyright(c) 2020 Intel Corporation. All rights reserved.
> > > > + *
> > > > + * Author: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > > + */
> > > > +
> > > > +#ifndef VHOST_RPMSG_H
> > > > +#define VHOST_RPMSG_H
> > > > +
> > > > +#include <linux/uio.h>
> > > > +#include <linux/virtio_rpmsg.h>
> > > > +
> > > > +#include "vhost.h"
> > > > +
> > > > +/* RPMsg uses two VirtQueues: one for each direction */
> > > > +enum {
> > > > +	VIRTIO_RPMSG_RESPONSE,	/* RPMsg response (host->guest) buffers */
> > > > +	VIRTIO_RPMSG_REQUEST,	/* RPMsg request (guest->host) buffers */
> > > > +	/* Keep last */
> > > > +	VIRTIO_RPMSG_NUM_OF_VQS,
> > > > +};
> > > > +
> > > > +struct vhost_rpmsg_ept;
> > > > +
> > > > +struct vhost_rpmsg_iter {
> > > > +	struct iov_iter iov_iter;
> > > > +	struct rpmsg_hdr rhdr;
> > > > +	struct vhost_virtqueue *vq;
> > > > +	const struct vhost_rpmsg_ept *ept;
> > > > +	int head;
> > > > +	void *priv;
> > > 
> > > I don't see @priv being used anywhere.
> > 
> > That's logical: this is a field, private to the API users, so the core shouldn't 
> > use it :-) It's used in later patches.
> 
> That is where structure documentation is useful.  I will let Michael decide what
> he wants to do.

I can add some kerneldoc documentation there, no problem.

> Thanks for the feedback,

Thanks for your reviews! I'd very much like to close all the still open points 
and merge the series ASAP.

Thanks
Guennadi

> Mathieu
> 
> > 
> > > 
> > > > +};
> > > > +
> > > > +struct vhost_rpmsg {
> > > > +	struct vhost_dev dev;
> > > > +	struct vhost_virtqueue vq[VIRTIO_RPMSG_NUM_OF_VQS];
> > > > +	struct vhost_virtqueue *vq_p[VIRTIO_RPMSG_NUM_OF_VQS];
> > > > +	const struct vhost_rpmsg_ept *ept;
> > > > +	unsigned int n_epts;
> > > > +};
> > > > +
> > > > +struct vhost_rpmsg_ept {
> > > > +	ssize_t (*read)(struct vhost_rpmsg *, struct vhost_rpmsg_iter *);
> > > > +	ssize_t (*write)(struct vhost_rpmsg *, struct vhost_rpmsg_iter *);
> > > > +	int addr;
> > > > +};
> > > > +
> > > > +static inline size_t vhost_rpmsg_iter_len(const struct vhost_rpmsg_iter *iter)
> > > > +{
> > > > +	return iter->rhdr.len;
> > > > +}
> > > 
> > > Again, I don't see where this is used.
> > 
> > This is exported API, it's used by users.
> >
> > > > +
> > > > +#define VHOST_RPMSG_ITER(_vq, _src, _dst) {			\
> > > > +	.rhdr = {						\
> > > > +			.src = cpu_to_vhost32(_vq, _src),	\
> > > > +			.dst = cpu_to_vhost32(_vq, _dst),	\
> > > > +		},						\
> > > > +	}
> > > 
> > > Same.
> > 
> > ditto.
> > 
> > Thanks
> > Guennadi
> > 
> > > Thanks,
> > > Mathieu
> > > 
> > > > +
> > > > +void vhost_rpmsg_init(struct vhost_rpmsg *vr, const struct vhost_rpmsg_ept *ept,
> > > > +		      unsigned int n_epts);
> > > > +void vhost_rpmsg_destroy(struct vhost_rpmsg *vr);
> > > > +int vhost_rpmsg_ns_announce(struct vhost_rpmsg *vr, const char *name,
> > > > +			    unsigned int src);
> > > > +int vhost_rpmsg_start_lock(struct vhost_rpmsg *vr,
> > > > +			   struct vhost_rpmsg_iter *iter,
> > > > +			   unsigned int qid, ssize_t len);
> > > > +size_t vhost_rpmsg_copy(struct vhost_rpmsg *vr, struct vhost_rpmsg_iter *iter,
> > > > +			void *data, size_t size);
> > > > +int vhost_rpmsg_finish_unlock(struct vhost_rpmsg *vr,
> > > > +			      struct vhost_rpmsg_iter *iter);
> > > > +
> > > > +#endif
> > > > -- 
> > > > 2.28.0
> > > > 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
