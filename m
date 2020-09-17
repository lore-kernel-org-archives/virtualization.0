Return-Path: <SRS0=u9Em=C2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67546C43461
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 05:47:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060F2206C9
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 05:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060F2206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C28A87591;
	Thu, 17 Sep 2020 05:47:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jWY2SMTeiSrk; Thu, 17 Sep 2020 05:47:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1558586F9A;
	Thu, 17 Sep 2020 05:47:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02B6DC0859;
	Thu, 17 Sep 2020 05:47:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D9FBC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 05:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 635C286F6A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 05:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TPlZfhzkpTAv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 05:47:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A2D8E86F50
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 05:47:19 +0000 (UTC)
IronPort-SDR: 7D0uJEGa8qKm2ESx3IlPtsrqB5CXbtzfzyBqdfky4es13pzxAQl8UErdkjEIvjQoxk/3aWnDWy
 vQXuP2Mp6tNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="223812726"
X-IronPort-AV: E=Sophos;i="5.76,435,1592895600"; d="scan'208";a="223812726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 22:47:18 -0700
IronPort-SDR: XpdV1MzY+SyHHCYUXCbH836XGXYTLIrE/VhIuegEe72MNZOvagwXjQMneyNk5IgxQqFMVxW91S
 +Um4f8oKtPkw==
X-IronPort-AV: E=Sophos;i="5.76,435,1592895600"; d="scan'208";a="483608658"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu)
 ([10.249.45.143])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2020 22:47:15 -0700
Date: Thu, 17 Sep 2020 07:47:06 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v6 0/4] Add a vhost RPMsg API
Message-ID: <20200917054705.GA11491@ubuntu>
References: <20200901151153.28111-1-guennadi.liakhovetski@linux.intel.com>
 <9433695b-5757-db73-bd8a-538fd1375e2a@st.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9433695b-5757-db73-bd8a-538fd1375e2a@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
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

Hi Arnaud,

On Tue, Sep 15, 2020 at 02:13:23PM +0200, Arnaud POULIQUEN wrote:
> Hi  Guennadi,
> 
> On 9/1/20 5:11 PM, Guennadi Liakhovetski wrote:
> > Hi,
> > 
> > Next update:
> > 
> > v6:
> > - rename include/linux/virtio_rpmsg.h -> include/linux/rpmsg/virtio.h
> > 
> > v5:
> > - don't hard-code message layout
> > 
> > v4:
> > - add endianness conversions to comply with the VirtIO standard
> > 
> > v3:
> > - address several checkpatch warnings
> > - address comments from Mathieu Poirier
> > 
> > v2:
> > - update patch #5 with a correct vhost_dev_init() prototype
> > - drop patch #6 - it depends on a different patch, that is currently
> >   an RFC
> > - address comments from Pierre-Louis Bossart:
> >   * remove "default n" from Kconfig
> > 
> > Linux supports RPMsg over VirtIO for "remote processor" / AMP use
> > cases. It can however also be used for virtualisation scenarios,
> > e.g. when using KVM to run Linux on both the host and the guests.
> > This patch set adds a wrapper API to facilitate writing vhost
> > drivers for such RPMsg-based solutions. The first use case is an
> > audio DSP virtualisation project, currently under development, ready
> > for review and submission, available at
> > https://github.com/thesofproject/linux/pull/1501/commits
> 
> Mathieu pointed me your series. On my side i proposed the rpmsg_ns_msg
> service[1] that does not match with your implementation.
> As i come late, i hope that i did not miss something in the history...
> Don't hesitate to point me the discussions, if it is the case.

Well, as you see, this is a v6 only of this patch set, and apart from it 
there have been several side discussions and patch sets.

> Regarding your patchset, it is quite confusing for me. It seems that you
> implement your own protocol on top of vhost forked from the RPMsg one.
> But look to me that it is not the RPMsg protocol.

I'm implementing a counterpart to the rpmsg protocol over VirtIO as 
initially implemented by drivers/rpmsg/virtio_rpmsg_bus.c for the "main 
CPU" (in case of remoteproc over VirtIO) or the guest side in case of 
Linux virtualisation. Since my implementation can talk to that driver, 
I don't think, that I'm inventing a new protocol. I'm adding support 
for the same protocol for the opposite side of the VirtIO divide.

> So i would be agree with Vincent[2] which proposed to switch on a RPMsg API
> and creating a vhost rpmsg device. This is also proposed in the 
> "Enhance VHOST to enable SoC-to-SoC communication" RFC[3].
> Do you think that this alternative could match with your need?

As I replied to Vincent, I understand his proposal and the approach taken 
in the series [3], but I'm not sure I agree, that adding yet another 
virtual device / driver layer on the vhost side is a good idea. As far as 
I understand adding new completely virtual devices isn't considered to be 
a good practice in the kernel. Currently vhost is just a passive "library" 
and my vhost-rpmsg support keeps it that way. Not sure I'm in favour of 
converting vhost to a virtual device infrastructure.

Thanks for pointing me out at [3], I should have a better look at it.

Thanks
Guennadi

> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335 
> [2]. https://www.spinics.net/lists/linux-virtualization/msg44195.html
> [3]. https://www.spinics.net/lists/linux-remoteproc/msg06634.html  
> 
> Thanks,
> Arnaud
> 
> > 
> > Thanks
> > Guennadi
> > 
> > Guennadi Liakhovetski (4):
> >   vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
> >   rpmsg: move common structures and defines to headers
> >   rpmsg: update documentation
> >   vhost: add an RPMsg API
> > 
> >  Documentation/rpmsg.txt          |   6 +-
> >  drivers/rpmsg/virtio_rpmsg_bus.c |  78 +------
> >  drivers/vhost/Kconfig            |   7 +
> >  drivers/vhost/Makefile           |   3 +
> >  drivers/vhost/rpmsg.c            | 373 +++++++++++++++++++++++++++++++
> >  drivers/vhost/vhost_rpmsg.h      |  74 ++++++
> >  include/linux/rpmsg/virtio.h     |  83 +++++++
> >  include/uapi/linux/rpmsg.h       |   3 +
> >  include/uapi/linux/vhost.h       |   4 +-
> >  9 files changed, 551 insertions(+), 80 deletions(-)
> >  create mode 100644 drivers/vhost/rpmsg.c
> >  create mode 100644 drivers/vhost/vhost_rpmsg.h
> >  create mode 100644 include/linux/rpmsg/virtio.h
> > 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
