Return-Path: <SRS0=u9Em=C2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71442C433E2
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 08:36:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84642075E
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 08:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=axis.com header.i=@axis.com header.b="fqxZZZZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84642075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8139D2E170;
	Thu, 17 Sep 2020 08:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dOLBQsIqDkRB; Thu, 17 Sep 2020 08:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 43C8F2E169;
	Thu, 17 Sep 2020 08:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26410C0864;
	Thu, 17 Sep 2020 08:36:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C6EAC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 08:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E78248748B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 08:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hBFQdWLEtogP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 08:36:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2AAA28744E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 08:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; l=1732; q=dns/txt; s=axis-central1;
 t=1600331808; x=1631867808;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9NKLIVDraz6+fyMH3+VMwK8eJnp6H6X4d9mocI9g0Kc=;
 b=fqxZZZZ1+hHhktFlPEOZPWzr6yfvyNm1r24FtPUReNcuCMmcF4bO7bAS
 Q5FHlgdofLY4v4mCULMZCWf1OoCAnokzGKNkr/+bKVcA2cPmuRtVqryxh
 lie7tJzUt/KeH5IWFJBbpZPq7QYCavmwnM/zy9gaxDJnCxiS6CGRsw441
 XVTNfxOIlJmMBdtDQvGBV9ES6rHxSWcR9eH4cgO1zWFIy9IxObZebyIbf
 W+a3b3UlqcaaQTCuQyZEfLozk+JPCKBz0iwcLuRqV5nlkTkBujTZn6a+L
 gL0Y5YS/nU3DrOWh9wzcgbSo2U21vjnKOdwN3mY0NlptroNxx8f5vZf6C Q==;
IronPort-SDR: oDhvlA/ddrSklE6SljIF/+4cdbbGS38ZQ1+JfYDEJ16X4ULPtiXAW3r6j9cjc5HVT5P/h+lrsE
 iwnX44zhcc9hyXYUSy9ikb40bCPd5b1n8AI4/vg+P8fSdMofqk+PueLiDv1xopJHbRSlY/1DUQ
 I7EoQa5t/QzxOSTeE7WmmbwuaBpQnzyAe489aj+dYnLPmqgnMqiDFlRTkJe7n5mG7VO80wPAwM
 D5Q+TMautFCVhASARpm2xUGtkJaClGq4lRoOCMBdVhKOLK0Agzf/s6aRSZhMDrF6sEPayskDeC
 Jm4=
X-IronPort-AV: E=Sophos;i="5.76,436,1592863200"; d="scan'208";a="12573765"
Date: Thu, 17 Sep 2020 10:36:44 +0200
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v6 0/4] Add a vhost RPMsg API
Message-ID: <20200917083644.66yjer4zvoiftrk3@axis.com>
References: <20200901151153.28111-1-guennadi.liakhovetski@linux.intel.com>
 <9433695b-5757-db73-bd8a-538fd1375e2a@st.com> <20200917054705.GA11491@ubuntu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917054705.GA11491@ubuntu>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Ohad Ben-Cohen <ohad@wizery.com>, kishon@ti.com,
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

On Thu, Sep 17, 2020 at 07:47:06AM +0200, Guennadi Liakhovetski wrote:
> On Tue, Sep 15, 2020 at 02:13:23PM +0200, Arnaud POULIQUEN wrote:
> > So i would be agree with Vincent[2] which proposed to switch on a RPMsg API
> > and creating a vhost rpmsg device. This is also proposed in the 
> > "Enhance VHOST to enable SoC-to-SoC communication" RFC[3].
> > Do you think that this alternative could match with your need?
> 
> As I replied to Vincent, I understand his proposal and the approach taken 
> in the series [3], but I'm not sure I agree, that adding yet another 
> virtual device / driver layer on the vhost side is a good idea. As far as 
> I understand adding new completely virtual devices isn't considered to be 
> a good practice in the kernel. Currently vhost is just a passive "library" 
> and my vhost-rpmsg support keeps it that way. Not sure I'm in favour of 
> converting vhost to a virtual device infrastructure.

I know it wasn't what you meant, but I noticed that the above paragraph
could be read as if my suggestion was to convert vhost to a virtual
device infrastructure, so I just want to clarify that that those are not
related.  The only similarity between what I suggested in the thread in
[2] and Kishon's RFC in [3] is that both involve creating a generic
vhost-rpmsg driver which would allow the RPMsg API to be used for both
sides of the link, instead of introducing a new API just for the server
side.  That can be done without rewriting drivers/vhost/.

> > [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=338335 
> > [2]. https://www.spinics.net/lists/linux-virtualization/msg44195.html
> > [3]. https://www.spinics.net/lists/linux-remoteproc/msg06634.html  
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
