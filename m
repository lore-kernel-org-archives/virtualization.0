Return-Path: <SRS0=1ME9=CT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1427BC433E2
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 11:19:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417DF20684
	for <virtualization@archiver.kernel.org>; Thu, 10 Sep 2020 11:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417DF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A336586C29;
	Thu, 10 Sep 2020 11:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UViTcpvV8ehC; Thu, 10 Sep 2020 11:19:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C2E4586CED;
	Thu, 10 Sep 2020 11:19:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6CD3C0052;
	Thu, 10 Sep 2020 11:19:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7D2C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 11:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4F508204B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 11:19:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mSUACb5wbEt8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 11:19:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 37778204B0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 11:19:39 +0000 (UTC)
IronPort-SDR: Y40F/+k/0lai/wePAah5Qbbo8YyVxIkyaU1Ya6c0gNgo33FTarATmQ6mpPGrgCSi5xXJmQviAX
 wfLtQFLTAYuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146215936"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="146215936"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 04:19:38 -0700
IronPort-SDR: /YodJdJw+QHAazflo0hTJtkpB22ZUvLnCM9DrgsaEJGiTtbZmWhqIL+Sm/rKP5+iFzNh/JrLAy
 yvJhZ0k+wNNQ==
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="480850194"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.252.39.14])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 04:19:35 -0700
Date: Thu, 10 Sep 2020 13:19:32 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 3/4] rpmsg: update documentation
Message-ID: <20200910111932.GC17698@ubuntu>
References: <20200826174636.23873-1-guennadi.liakhovetski@linux.intel.com>
 <20200826174636.23873-4-guennadi.liakhovetski@linux.intel.com>
 <20200909224521.GC562265@xps15> <20200910071841.GA17698@ubuntu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910071841.GA17698@ubuntu>
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

On Thu, Sep 10, 2020 at 09:18:41AM +0200, Guennadi Liakhovetski wrote:
> On Wed, Sep 09, 2020 at 04:45:21PM -0600, Mathieu Poirier wrote:
> > On Wed, Aug 26, 2020 at 07:46:35PM +0200, Guennadi Liakhovetski wrote:
> > > rpmsg_create_ept() takes struct rpmsg_channel_info chinfo as its last
> > > argument, not a u32 value. The first two arguments are also updated.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > ---
> > >  Documentation/rpmsg.txt | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/rpmsg.txt b/Documentation/rpmsg.txt
> > > index 24b7a9e1a5f9..1ce353cb232a 100644
> > > --- a/Documentation/rpmsg.txt
> > > +++ b/Documentation/rpmsg.txt
> > > @@ -192,9 +192,9 @@ Returns 0 on success and an appropriate error value on failure.
> > >  
> > >  ::
> > >  
> > > -  struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_channel *rpdev,
> > > -		void (*cb)(struct rpmsg_channel *, void *, int, void *, u32),
> > > -		void *priv, u32 addr);
> > > +  struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
> > > +					  rpmsg_rx_cb_t cb, void *priv,
> > > +					  struct rpmsg_channel_info chinfo);
> > 
> > Again I don't see this being used in this set...  It should have been sent on
> > its own to the remoteproc and documentation mailing list.  Note that
> > Documentation/rpmsg.txt is now Documentation/staging/rpmsg.rst

But you haven't pulled that change into your tree yet. Should I send as is for now 
or wait for you to cherry-pick that change?

> Sure, can send it separately.
> 
> Thanks
> Guennadi
> 
> > >  every rpmsg address in the system is bound to an rx callback (so when
> > >  inbound messages arrive, they are dispatched by the rpmsg bus using the
> > > -- 
> > > 2.28.0
> > > 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
