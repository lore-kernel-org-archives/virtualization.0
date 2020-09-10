Return-Path: <SRS0=1ME9=CT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A434C43461
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 07:15:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958B62075B
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 07:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958B62075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 151E08765C;
	Thu, 10 Sep 2020 07:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nazQ0b1ymlrF; Thu, 10 Sep 2020 07:15:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5627887661;
	Thu, 10 Sep 2020 07:15:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C815C0859;
	Thu, 10 Sep 2020 07:15:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D65FC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 07:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3817487661
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 07:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wAUCcsv-RVKy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 07:15:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ECEA28765C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 07:15:19 +0000 (UTC)
IronPort-SDR: wHBzkEHLEtesdTStYz7kZxiuksV1zXlFaFqPmQ0GQZz0mvrrb0ohW9W7WIiLnmuo5CQjRmsZAA
 qdo90IGzx1wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="155942994"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="155942994"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 00:15:19 -0700
IronPort-SDR: e6Qaiy2n8PctJP2/CF688WXqm7EvXe1yUUpcy7kkqSeXCMRKgSqQXPf9dioKsgfziB4kkep8yk
 fbFAIxWN4HPw==
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="286478970"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.252.39.14])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 00:15:16 -0700
Date: Thu, 10 Sep 2020 09:15:13 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 1/4] vhost: convert VHOST_VSOCK_SET_RUNNING to a
 generic ioctl
Message-ID: <20200910062144.GA16802@ubuntu>
References: <20200826174636.23873-1-guennadi.liakhovetski@linux.intel.com>
 <20200826174636.23873-2-guennadi.liakhovetski@linux.intel.com>
 <20200909224214.GB562265@xps15>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200909224214.GB562265@xps15>
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

On Wed, Sep 09, 2020 at 04:42:14PM -0600, Mathieu Poirier wrote:
> On Wed, Aug 26, 2020 at 07:46:33PM +0200, Guennadi Liakhovetski wrote:
> > VHOST_VSOCK_SET_RUNNING is used by the vhost vsock driver to perform
> > crucial VirtQueue initialisation, like assigning .private fields and
> > calling vhost_vq_init_access(), and clean up. However, this ioctl is
> > actually extremely useful for any vhost driver, that doesn't have a
> > side channel to inform it of a status change, e.g. upon a guest
> > reboot. This patch makes that ioctl generic, while preserving its
> > numeric value and also keeping the original alias.
> > 
> > Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > ---
> >  include/uapi/linux/vhost.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index 75232185324a..11a4948b6216 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -97,6 +97,8 @@
> >  #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
> >  #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
> >  
> > +#define VHOST_SET_RUNNING _IOW(VHOST_VIRTIO, 0x61, int)
> > +
> 
> I don't see it used in the next patches and as such should be part of another
> series.

It isn't used in the next patches, it is used in this patch - see below.

Thanks
Guennadi

> >  /* VHOST_NET specific defines */
> >  
> >  /* Attach virtio net ring to a raw socket, or tap device.
> > @@ -118,7 +120,7 @@
> >  /* VHOST_VSOCK specific defines */
> >  
> >  #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
> > -#define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
> > +#define VHOST_VSOCK_SET_RUNNING		VHOST_SET_RUNNING
> >  
> >  /* VHOST_VDPA specific defines */
> >  
> > -- 
> > 2.28.0
> > 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
