Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17889C433E1
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:46:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3068206DA
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3068206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA2B18626B;
	Tue,  4 Aug 2020 14:46:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QE417DAP7Xhp; Tue,  4 Aug 2020 14:46:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1573B8625D;
	Tue,  4 Aug 2020 14:46:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2F52C0051;
	Tue,  4 Aug 2020 14:46:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37978C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2669F87695
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1aE1hh0PfgIe
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:46:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6C936875BE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:46:47 +0000 (UTC)
IronPort-SDR: Ap6ThIN6YOvbuuc/zkoQ2VGzTUEnEBKNcLjRfGC5qFKhX1Of/DX0wAT0+9IlI+VBfRYVHgYCul
 KnHh9bE85YVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="213857072"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; d="scan'208";a="213857072"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2020 07:46:46 -0700
IronPort-SDR: 5bWjSithPV0Oq0tMhji8wu4ZfDsDLYRZd1SyJ7g4vGMo0Svq57KyLV7M+fbzispGQ0uqn+fsqW
 Wa9dRXsFcJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; d="scan'208";a="324677258"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu)
 ([10.252.37.210])
 by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2020 07:46:43 -0700
Date: Tue, 4 Aug 2020 16:46:42 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/4] Add a vhost RPMsg API
Message-ID: <20200804144642.GB19025@ubuntu>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
 <20200804082250-mutt-send-email-mst@kernel.org>
 <20200804131918.GA19025@ubuntu>
 <20200804100747-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200804100747-mutt-send-email-mst@kernel.org>
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

On Tue, Aug 04, 2020 at 10:10:23AM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 04, 2020 at 03:19:19PM +0200, Guennadi Liakhovetski wrote:
> > Hi Michael,
> > 
> > On Tue, Aug 04, 2020 at 08:26:53AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 22, 2020 at 05:09:23PM +0200, Guennadi Liakhovetski wrote:
> > > > Hi,
> > > > 
> > > > Now that virtio-rpmsg endianness fixes have been merged we can 
> > > > proceed with the next step.
> > > 
> > > OK my attempts to resolve conflicts just created a mess.
> > 
> > You just need to apply my previous patch for virtio-rpmsg first 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/rpmsg/virtio_rpmsg_bus.c?id=111d1089700cdb752681ef44f54ab6137736f5c2
> > Then this series should apply cleanly.
> > 
> > Thanks
> > Guennadi
> 
> Hmm.  Could you test the vhost branch in my tree, and tell me if that looks
> good to you?

Sorry, I'm not sure I understand why you're trying to resolve conflicts 
manually. My previous patch is already in "next," if you don't pull from 
"next" you will have a conflict when pushing to it. What am I missing?

Thanks
Guennadi

> > > I dropped these for now, could you pls rebase on top
> > > of linux-next branch in my tree, and repost?
> > > Thanks!
> > > 
> > > 
> > > > v4:
> > > > - add endianness conversions to comply with the VirtIO standard
> > > > 
> > > > v3:
> > > > - address several checkpatch warnings
> > > > - address comments from Mathieu Poirier
> > > > 
> > > > v2:
> > > > - update patch #5 with a correct vhost_dev_init() prototype
> > > > - drop patch #6 - it depends on a different patch, that is currently
> > > >   an RFC
> > > > - address comments from Pierre-Louis Bossart:
> > > >   * remove "default n" from Kconfig
> > > > 
> > > > Linux supports RPMsg over VirtIO for "remote processor" / AMP use
> > > > cases. It can however also be used for virtualisation scenarios,
> > > > e.g. when using KVM to run Linux on both the host and the guests.
> > > > This patch set adds a wrapper API to facilitate writing vhost
> > > > drivers for such RPMsg-based solutions. The first use case is an
> > > > audio DSP virtualisation project, currently under development, ready
> > > > for review and submission, available at
> > > > https://github.com/thesofproject/linux/pull/1501/commits
> > > > 
> > > > Thanks
> > > > Guennadi
> > > > 
> > > > Guennadi Liakhovetski (4):
> > > >   vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
> > > >   rpmsg: move common structures and defines to headers
> > > >   rpmsg: update documentation
> > > >   vhost: add an RPMsg API
> > > > 
> > > >  Documentation/rpmsg.txt          |   6 +-
> > > >  drivers/rpmsg/virtio_rpmsg_bus.c |  78 +------
> > > >  drivers/vhost/Kconfig            |   7 +
> > > >  drivers/vhost/Makefile           |   3 +
> > > >  drivers/vhost/rpmsg.c            | 375 +++++++++++++++++++++++++++++++
> > > >  drivers/vhost/vhost_rpmsg.h      |  74 ++++++
> > > >  include/linux/virtio_rpmsg.h     |  83 +++++++
> > > >  include/uapi/linux/rpmsg.h       |   3 +
> > > >  include/uapi/linux/vhost.h       |   4 +-
> > > >  9 files changed, 553 insertions(+), 80 deletions(-)
> > > >  create mode 100644 drivers/vhost/rpmsg.c
> > > >  create mode 100644 drivers/vhost/vhost_rpmsg.h
> > > >  create mode 100644 include/linux/virtio_rpmsg.h
> > > > 
> > > > -- 
> > > > 2.27.0
> > > 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
