Return-Path: <SRS0=OYIR=C6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA4AC43464
	for <virtualization@archiver.kernel.org>; Mon, 21 Sep 2020 06:23:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2808C20719
	for <virtualization@archiver.kernel.org>; Mon, 21 Sep 2020 06:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2808C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7FA512002B;
	Mon, 21 Sep 2020 06:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4nksVO+EMJt; Mon, 21 Sep 2020 06:23:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 25C1A204E3;
	Mon, 21 Sep 2020 06:23:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF59AC0859;
	Mon, 21 Sep 2020 06:23:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39ABFC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 06:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2036087160
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 06:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WiyMEmJfkq2G
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 06:23:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2AFFE8715F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 06:23:08 +0000 (UTC)
IronPort-SDR: jLI7uabFWBFpBrsLr51b8JuyOkp2sCXgQLGCaWRFIvbB4sG8Z1+Pfcc52i8vSE+Jf9VGOQk9Z7
 /hW2R5H4WBAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="147976138"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; d="scan'208";a="147976138"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2020 23:23:04 -0700
IronPort-SDR: USb2UDAwyWhLJQWxChZgxFvSXc5aD8EZKTgGEeQPUMLqRDIxK9gy3tRuyDpL1OOMSR9aEqeLGv
 UdRLeyUYUhDg==
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; d="scan'208";a="485292430"
Received: from fjanoscz-mobl1.ger.corp.intel.com (HELO ubuntu)
 ([10.249.45.119])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2020 23:23:01 -0700
Date: Mon, 21 Sep 2020 08:22:52 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v7 3/3] vhost: add an RPMsg API
Message-ID: <20200921062251.GA27773@ubuntu>
References: <20200910111351.20526-1-guennadi.liakhovetski@linux.intel.com>
 <20200910111351.20526-4-guennadi.liakhovetski@linux.intel.com>
 <20200917220138.GA97950@xps15> <20200918090229.GC19246@ubuntu>
 <20200918155249.GA200851@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918155249.GA200851@xps15>
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

On Fri, Sep 18, 2020 at 09:52:49AM -0600, Mathieu Poirier wrote:
> Good morning,
> 
> On Fri, Sep 18, 2020 at 11:02:29AM +0200, Guennadi Liakhovetski wrote:
> > Hi Mathieu,
> > 
> > On Thu, Sep 17, 2020 at 04:01:38PM -0600, Mathieu Poirier wrote:
> > > On Thu, Sep 10, 2020 at 01:13:51PM +0200, Guennadi Liakhovetski wrote:
> > > > Linux supports running the RPMsg protocol over the VirtIO transport
> > > > protocol, but currently there is only support for VirtIO clients and
> > > > no support for VirtIO servers. This patch adds a vhost-based RPMsg
> > > > server implementation, which makes it possible to use RPMsg over
> > > > VirtIO between guest VMs and the host.
> > > 
> > > I now get the client/server concept you are describing above but that happened
> > > only after a lot of mental gymnastics.  If you drop the whole client/server
> > > concept and concentrate on what this patch does, things will go better.  I would
> > > personally go with what you have in the Kconfig: 
> > > 
> > > > +	  Vhost RPMsg API allows vhost drivers to communicate with VirtIO
> > > > +	  drivers on guest VMs, using the RPMsg over VirtIO protocol.
> > > 
> > > It is concise but describes exactly what this patch provide.
> > 
> > Ok, thanks, will try to improve.
> > 
> > > > Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > > ---
> > > >  drivers/vhost/Kconfig       |   7 +
> > > >  drivers/vhost/Makefile      |   3 +
> > > >  drivers/vhost/rpmsg.c       | 370 ++++++++++++++++++++++++++++++++++++
> > > >  drivers/vhost/vhost_rpmsg.h |  74 ++++++++
> > > >  4 files changed, 454 insertions(+)
> > > >  create mode 100644 drivers/vhost/rpmsg.c
> > > >  create mode 100644 drivers/vhost/vhost_rpmsg.h

[snip]

> > > > diff --git a/drivers/vhost/rpmsg.c b/drivers/vhost/rpmsg.c
> > > > new file mode 100644
> > > > index 000000000000..0ddee5b5f017
> > > > --- /dev/null
> > > > +++ b/drivers/vhost/rpmsg.c
> > > > @@ -0,0 +1,370 @@

[snip]

> > > > +/*
> > > > + * Return false to terminate the external loop only if we fail to obtain either
> > > > + * a request or a response buffer
> > > > + */
> > > > +static bool handle_rpmsg_req_single(struct vhost_rpmsg *vr,
> > > > +				    struct vhost_virtqueue *vq)
> > > > +{
> > > > +	struct vhost_rpmsg_iter iter;
> > > > +	int ret = vhost_rpmsg_start_lock(vr, &iter, VIRTIO_RPMSG_REQUEST, -EINVAL);
> > > > +	if (!ret)
> > > > +		ret = vhost_rpmsg_finish_unlock(vr, &iter);
> > > > +	if (ret < 0) {
> > > > +		if (ret != -EAGAIN)
> > > > +			vq_err(vq, "%s(): RPMSG processing failed %d\n",
> > > > +			       __func__, ret);
> > > > +		return false;
> > > > +	}
> > > > +
> > > > +	if (!iter.ept->write)
> > > > +		return true;
> > > > +
> > > > +	ret = vhost_rpmsg_start_lock(vr, &iter, VIRTIO_RPMSG_RESPONSE, -EINVAL);
> > > > +	if (!ret)
> > > > +		ret = vhost_rpmsg_finish_unlock(vr, &iter);
> > > > +	if (ret < 0) {
> > > > +		vq_err(vq, "%s(): RPMSG finalising failed %d\n", __func__, ret);
> > > > +		return false;
> > > > +	}
> > > 
> > > As I said before dealing with the "response" queue here seems to be introducing
> > > coupling with vhost_rpmsg_start_lock()...  Endpoints should be doing that.
> > 
> > Sorry, could you elaborate a bit, what do you mean by coupling?
> 
> In function vhost_rpmsg_start_lock() the rpmsg header is prepared for a response
> at the end of the processing associated with the reception of a
> VIRTIO_RPMSG_REQUEST.  I assumed (perhaps wrongly) that such as response was
> sent here.  In that case preparing the response and sending the response should
> be done at the same place.

This will change in the next version, in it I'll remove response preparation from 
request handling.

> But my assumption may be completely wrong... A better question should probably
> be why is the VIRTIO_RPMSG_RESPONSE probed in handle_rpmsg_req_single()?
> Shouldn't this be solely concerned with handling requests from the guest?  If
> I'm wondering what is going on I expect other people will also do the same,
> something that could be alleviated with more comments.

My RPMsg implementation supports two modes for sending data from the host (in 
VM terms) to guests: as responses to their requests and as asynchronous 
messages. If there isn't a strict request-response pattern on a certain endpont, 
you leave the .write callback NULL and then you send your messages as you please 
independent of requests. But you can also specify a .write pointer in which case 
after each request to generate a response.

In principle this response handling could be removed, but then drivers, that do 
need to respond to requests would have to schedule an asynchronous action in 
their .read callbacks to be triggered after request processing has completed.

Thanks
Guennadi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
