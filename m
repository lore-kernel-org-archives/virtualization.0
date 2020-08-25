Return-Path: <SRS0=1X+q=CD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB98C433DF
	for <virtualization@archiver.kernel.org>; Tue, 25 Aug 2020 13:53:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7794A20738
	for <virtualization@archiver.kernel.org>; Tue, 25 Aug 2020 13:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CINDpSHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7794A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3FF1B87DB2;
	Tue, 25 Aug 2020 13:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqU3MplMHiiG; Tue, 25 Aug 2020 13:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A167387C94;
	Tue, 25 Aug 2020 13:53:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83456C016F;
	Tue, 25 Aug 2020 13:53:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D83F9C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 13:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C0FDF87DAC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 13:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Gm4zHh-BiXN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 13:53:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6ED1287C94
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598363614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=138cvp+YSMgYfNEN+hQF14KPIqzw0MKaD5TwzikQyNY=;
 b=CINDpSHtkLR0/6CJRVRg0cSY8mU1pWmHJ1E6ll7ygG3fQUSxPv7FNnomDsliwkbOtwutI4
 kMXrBxF/g06ILaV0MO8rsO3N2sQ/tKOST1VXXn6MfjwPrrLhoPaNa7LKjV1IrvOGgZK2kF
 8Jv9G1AWzCGS81WCUQaODhu880pC4VI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-BJQ03f86NbCd4zaeI_m07A-1; Tue, 25 Aug 2020 09:53:31 -0400
X-MC-Unique: BJQ03f86NbCd4zaeI_m07A-1
Received: by mail-qk1-f200.google.com with SMTP id y187so4132528qka.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 06:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=138cvp+YSMgYfNEN+hQF14KPIqzw0MKaD5TwzikQyNY=;
 b=BTfnv8xPWiQ4I8uCIBpbnZ7rBkVLiVGlsKXMJn9vbASrehkbZ5DWmFaPapJXEuIsQc
 WGLkWcYDkSjYFNoC9unAERg+9OBjnM+NzZobp82vfg+hdGXmfkuYo4j0tzakguzLFdZ+
 zkWLo97S4Rh2a6jgv1no8Aojlejxx1EUhWBtrSMdWjc7Xf9NX28UPYzTEqNZVOsuGrhc
 vji3Ee2H2t+t+qzY9lQxOXJ38tm3t+kUbIEEtu2eiK+5rVatMBdgDsAkjBbPgzVdDLBU
 uYcj45nFSA5M03LUnR6C9hCW5vLrPWO6qmawhsvnfts76GqEb7IX95Zjh+SY9/TVBpAH
 rVqg==
X-Gm-Message-State: AOAM5320yeq59TfI5Hy9wlPEBN7yxqqA0p1+mY9hGo2DuFHEbZ/E0Blx
 Frr3vN92iTQT9r9H+JEXBnCoJ7nykwSjYXbGvFsSSM/PzVMycRtHJHbyz9E+BrjmhWBaiMDIOu6
 W5kMAUsR8zYvtPlGkFPGlTWZ3UBYsf0WZil4v/zGYtw==
X-Received: by 2002:ac8:564f:: with SMTP id 15mr9428446qtt.54.1598363610799;
 Tue, 25 Aug 2020 06:53:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPrT+ZhqGX/WxO3DdmtRmLzR6D+VgulQzBW64lie1cdwBxPXFdHdxWQdatgY6vKjfkuFcqew==
X-Received: by 2002:ac8:564f:: with SMTP id 15mr9428417qtt.54.1598363610497;
 Tue, 25 Aug 2020 06:53:30 -0700 (PDT)
Received: from redhat.com (bzq-109-64-136-54.red.bezeqint.net. [109.64.136.54])
 by smtp.gmail.com with ESMTPSA id v24sm1877951qtb.13.2020.08.25.06.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 06:53:29 -0700 (PDT)
Date: Tue, 25 Aug 2020 09:53:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v4 4/4] vhost: add an RPMsg API
Message-ID: <20200825095148-mutt-send-email-mst@kernel.org>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
 <20200722150927.15587-5-guennadi.liakhovetski@linux.intel.com>
 <20200804102132-mutt-send-email-mst@kernel.org>
 <20200804151916.GC19025@ubuntu>
 <20200810094013-mutt-send-email-mst@kernel.org>
 <20200812123243.GA10218@ubuntu> <20200825134109.GA9822@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20200825134109.GA9822@ubuntu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
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

On Tue, Aug 25, 2020 at 03:41:10PM +0200, Guennadi Liakhovetski wrote:
> Hi Michael,
> 
> ...back from holidays and still unsure what your preferred solution 
> for the message layout would be:
> 
> On Wed, Aug 12, 2020 at 02:32:43PM +0200, Guennadi Liakhovetski wrote:
> > Hi Michael,
> > 
> > Thanks for a review.
> > 
> > On Mon, Aug 10, 2020 at 09:44:15AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Aug 04, 2020 at 05:19:17PM +0200, Guennadi Liakhovetski wrote:
> 
> [snip]
> 
> > > > > > +static int vhost_rpmsg_get_single(struct vhost_virtqueue *vq)
> > > > > > +{
> > > > > > +	struct vhost_rpmsg *vr = container_of(vq->dev, struct vhost_rpmsg, dev);
> > > > > > +	unsigned int out, in;
> > > > > > +	int head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov), &out, &in,
> > > > > > +				     NULL, NULL);
> > > > > > +	if (head < 0) {
> > > > > > +		vq_err(vq, "%s(): error %d getting buffer\n",
> > > > > > +		       __func__, head);
> > > > > > +		return head;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* Nothing new? */
> > > > > > +	if (head == vq->num)
> > > > > > +		return head;
> > > > > > +
> > > > > > +	if (vq == &vr->vq[VIRTIO_RPMSG_RESPONSE] && (out || in != 1)) {
> > > > > 
> > > > > This in != 1 looks like a dependency on a specific message layout.
> > > > > virtio spec says to avoid these. Using iov iters it's not too hard to do
> > > > > ...
> > > > 
> > > > This is an RPMsg VirtIO implementation, and it has to match the virtio_rpmsg_bus.c 
> > > > driver, and that one has specific VirtIO queue and message usage patterns.
> > > 
> > > That could be fine for legacy virtio, but now you are claiming support
> > > for virtio 1, so need to fix these assumptions in the device.
> > 
> > I can just deop these checks without changing anything else, that still would work. 
> > I could also make this work with "any" layout - either ignoring any left-over 
> > buffers or maybe even getting them one by one. But I wouldn't even be able to test 
> > those modes without modifying / breaking the current virtio-rpmsg driver. What's 
> > the preferred solution?
> 
> Could you elaborate a bit please?
> 
> Thanks
> Guennadi

I'd prefer it that we make it work with any layout.
For testing, there was a hack for virtio ring which
split up descriptors at a random boundary.
I'll try to locate it and post, sounds like something
we might want upstream for debugging.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
