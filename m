Return-Path: <SRS0=1X+q=CD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC5C433E3
	for <virtualization@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFB02075F
	for <virtualization@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFB02075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1DF0C861EE;
	Tue, 25 Aug 2020 13:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dbeEexy5YtuH; Tue, 25 Aug 2020 13:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7CA3B85E85;
	Tue, 25 Aug 2020 13:41:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B852C016F;
	Tue, 25 Aug 2020 13:41:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65E08C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 13:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 492F0869FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 13:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ofVleIiWe8LS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 13:41:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 97D948657C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 13:41:14 +0000 (UTC)
IronPort-SDR: tZ+CPG2Com+vViBTesvwxgmDxh1KQAdzOjsNZXmWnuDqKhTtOc3ptQB6kYDrDB5wKrqEtys/Rl
 7tuNwXL6MOMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="157152942"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; d="scan'208";a="157152942"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 06:41:13 -0700
IronPort-SDR: 15vXcXLW0R3ZxvbOzXHfgHkl51eK0GaGcbh/iSVDLHo9hh998TBv28JBK9iB4gZg035GuYUmg+
 H8EL31jZFJ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; d="scan'208";a="299093769"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.252.54.8])
 by orsmga006.jf.intel.com with ESMTP; 25 Aug 2020 06:41:10 -0700
Date: Tue, 25 Aug 2020 15:41:10 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 4/4] vhost: add an RPMsg API
Message-ID: <20200825134109.GA9822@ubuntu>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
 <20200722150927.15587-5-guennadi.liakhovetski@linux.intel.com>
 <20200804102132-mutt-send-email-mst@kernel.org>
 <20200804151916.GC19025@ubuntu>
 <20200810094013-mutt-send-email-mst@kernel.org>
 <20200812123243.GA10218@ubuntu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812123243.GA10218@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Hi Michael,

...back from holidays and still unsure what your preferred solution 
for the message layout would be:

On Wed, Aug 12, 2020 at 02:32:43PM +0200, Guennadi Liakhovetski wrote:
> Hi Michael,
> 
> Thanks for a review.
> 
> On Mon, Aug 10, 2020 at 09:44:15AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 04, 2020 at 05:19:17PM +0200, Guennadi Liakhovetski wrote:

[snip]

> > > > > +static int vhost_rpmsg_get_single(struct vhost_virtqueue *vq)
> > > > > +{
> > > > > +	struct vhost_rpmsg *vr = container_of(vq->dev, struct vhost_rpmsg, dev);
> > > > > +	unsigned int out, in;
> > > > > +	int head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov), &out, &in,
> > > > > +				     NULL, NULL);
> > > > > +	if (head < 0) {
> > > > > +		vq_err(vq, "%s(): error %d getting buffer\n",
> > > > > +		       __func__, head);
> > > > > +		return head;
> > > > > +	}
> > > > > +
> > > > > +	/* Nothing new? */
> > > > > +	if (head == vq->num)
> > > > > +		return head;
> > > > > +
> > > > > +	if (vq == &vr->vq[VIRTIO_RPMSG_RESPONSE] && (out || in != 1)) {
> > > > 
> > > > This in != 1 looks like a dependency on a specific message layout.
> > > > virtio spec says to avoid these. Using iov iters it's not too hard to do
> > > > ...
> > > 
> > > This is an RPMsg VirtIO implementation, and it has to match the virtio_rpmsg_bus.c 
> > > driver, and that one has specific VirtIO queue and message usage patterns.
> > 
> > That could be fine for legacy virtio, but now you are claiming support
> > for virtio 1, so need to fix these assumptions in the device.
> 
> I can just deop these checks without changing anything else, that still would work. 
> I could also make this work with "any" layout - either ignoring any left-over 
> buffers or maybe even getting them one by one. But I wouldn't even be able to test 
> those modes without modifying / breaking the current virtio-rpmsg driver. What's 
> the preferred solution?

Could you elaborate a bit please?

Thanks
Guennadi
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
