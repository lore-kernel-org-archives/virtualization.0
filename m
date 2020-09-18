Return-Path: <SRS0=+sYM=C3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F922C43463
	for <virtualization@archiver.kernel.org>; Fri, 18 Sep 2020 10:39:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766F521D24
	for <virtualization@archiver.kernel.org>; Fri, 18 Sep 2020 10:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="jnZjx1sZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766F521D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13EAC87316;
	Fri, 18 Sep 2020 10:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yeDzbxXXgac9; Fri, 18 Sep 2020 10:39:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3569C8730F;
	Fri, 18 Sep 2020 10:39:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F858C0888;
	Fri, 18 Sep 2020 10:39:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B068CC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 975AB20377
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDSsnuGQmQbn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by silver.osuosl.org (Postfix) with ESMTPS id AE1B9203A0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=2468; q=dns/txt; s=axis-central1;
 t=1600425551; x=1631961551;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dfHnCSDcQJsHwmC06UCTmcgXTK9CGBepW1LnH1PWlIk=;
 b=jnZjx1sZJvloAAOfayj3jKPhLgg4wH75yEcyjlm9D9L3QVqZqVS4pTaf
 Anp1mndfi/6g3OSRDEjL8QiOrX8izqWfznpoxJC6LW5cT+dFprv9HBSJ7
 TyP1ZFKljabYLt/FcvjPI/RhiVUaXv6BhIvLciuHauTj5jY9JGOruqqdP
 EST0FGaRzJ8a9WgDkzbq7+qWCz1U7qUvLBruP3dJgGwg8EMy+ijA2ET9z
 J/SBt3/BYQ6n//o0ynhEIt8JxZRHj2/OPomVEfdANRocK57AzFMDEG9e7
 9uB04L57R/nW/YF3Ktvio/Bds8yiWPKJn1eRgOWoQekoxYghqkp4A1A6t w==;
IronPort-SDR: doNySO46aU7fpJx9Wb/YAZM9E8th1TVYK39QygX4h1SShuVKErS025dPWgD27AIlM77ydSAhwj
 AnrzCp0kYOml32Cs9FJH4Lt/Vwf+ysIas/4JFaqA6mHr1yDnG9JiX+WygQCK4Kxh/dDdvIHWmI
 6Ik0qxLpcA7wl8SjN+o0jduO3uuWxHI+BPhshHZnLZakGN0EWdLzMEJ6pCHWq7TPiQP/DqoOV/
 p7J/naBBMaHIL362CU6ydYLN+et06Nu1oInTwz5RnBzezJ0+8rKCL8gUFqEtWDVBjTtPBGZ8XS
 z0c=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; d="scan'208";a="12633924"
Date: Fri, 18 Sep 2020 12:39:07 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v6 0/4] Add a vhost RPMsg API
Message-ID: <20200918103907.2ts4l5xiwm4542rs@axis.com>
References: <20200901151153.28111-1-guennadi.liakhovetski@linux.intel.com>
 <9433695b-5757-db73-bd8a-538fd1375e2a@st.com> <20200917054705.GA11491@ubuntu>
 <47a9ad01-c922-3b1c-84de-433f229ffba3@st.com> <20200918054420.GA19246@ubuntu>
 <0b7d9004-d71b-8b9a-eaed-f92833ce113f@st.com> <20200918094719.GD19246@ubuntu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918094719.GD19246@ubuntu>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
 "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
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

On Fri, Sep 18, 2020 at 11:47:20AM +0200, Guennadi Liakhovetski wrote:
> On Fri, Sep 18, 2020 at 09:47:45AM +0200, Arnaud POULIQUEN wrote:
> > IMO, as this API is defined in the Linux documentation [5] we should respect it, to ensure
> > one generic implementation. The RPMsg sample client[4] uses this user API, so seems to me
> > a good candidate to verify this. 
> > 
> > That's said, shall we multiple the RPMsg implementations in Linux with several APIs,
> > With the risk to make the RPMsg clients devices dependent on these implementations?
> > That could lead to complex code or duplications...
> 
> So, no, in my understanding there aren't two competing alternative APIs, you'd never have 
> to choose between them. If you're writing a driver for Linux to communicate with remote 
> processors or to run on VMs, you use the existing API. If you're writing a driver for 
> Linux to communicate with those VMs, you use the vhost API and whatever help is available 
> for RPMsg processing.
> 
> However, I can in principle imagine a single driver, written to work on both sides. 
> Something like the rpmsg_char.c or maybe some networking driver. Is that what you're 
> referring to? I can see that as a fun exercise, but are there any real uses for that? 

I hinted at a real use case for this in the previous mail thread[0].
I'm exploring using rpmsg-char to allow communication between two chips,
both running Linux.  rpmsg-char can be used pretty much as-is for both
sides of the userspace-to-userspace communication and (the userspace
side of the) userspace-to-kernel communication between the two chips.

> You could do the same with VirtIO, however, it has been decided to go with two 
> distinct APIs: virtio for guests and vhost for the host, noone bothered to create a 
> single API for both and nobody seems to miss one. Why would we want one with RPMsg?

I think I answered this question in the previous mail thread as well[1]:
| virtio has distinct driver and device roles so the completely different
| APIs on each side are understandable.  But I don't see that distinction
| in the rpmsg API which is why it seems like a good idea to me to make it
| work from both sides of the link and allow the reuse of drivers like
| rpmsg-char, instead of imposing virtio's distinction on rpmsg.

[0] https://www.spinics.net/lists/linux-virtualization/msg43799.html
[1] https://www.spinics.net/lists/linux-virtualization/msg43802.html
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
