Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FCEC433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:07:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35AD2075F
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e824Ro8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35AD2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 870FE86824;
	Tue,  4 Aug 2020 14:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K2CnHKtk+-Jm; Tue,  4 Aug 2020 14:07:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E59184E2E;
	Tue,  4 Aug 2020 14:07:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FBD8C0050;
	Tue,  4 Aug 2020 14:07:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3990C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CFFBD867C6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WjgFaxPEWhN7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:07:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E46AF84E2E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596550068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r5VoaR683WhHbTY4KgZuHziRoIAvgy8uF9wmZyYpxKE=;
 b=e824Ro8WpzYzK+Aohdwi3iKxlb6GD7oPvkhBHeS94Gg84qGf+DU0jyLDqwCdu7r1T73OZW
 94TgasJz6vZ0rAtkmXjzaoN/PY8K5YXEdTsvaWO6zKFoC6TvSq1B5LGccF5zDqe3c7goWK
 XkxI459By6Chu3hG1Ru68mIefXl8THU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-0P-_yJAKMjCQdKK3WJJPxA-1; Tue, 04 Aug 2020 10:07:44 -0400
X-MC-Unique: 0P-_yJAKMjCQdKK3WJJPxA-1
Received: by mail-qt1-f200.google.com with SMTP id w30so13861634qte.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 07:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=r5VoaR683WhHbTY4KgZuHziRoIAvgy8uF9wmZyYpxKE=;
 b=oT4jho61ZjfUzAl4bFYm+aU8hg6oun/5ZY9JvtrD/Sv8Wb2NZFzpuAuTslW9nphdGe
 poExeqijKi/29gclLW0Sr787oiJwm4bf5TtADgKkEJQHEdyJ8muewxCXO9+KtLaDdFHu
 1uiLTcWXLvo3Vxb0yJUX3dL0R2l4qI/gCM3CNccGW1TKoB0ofkiSpcPqhx0iX4bUIJ4i
 jmINUPLfqVBwFi1NoqhOCwB99IYX6Y4ho1omGB6CnpB4z6jY3oa4FUzoOSoInjZyciw3
 /ROTI6gUhuRbXdwytDJo0P3sLCl6Ujk7NP1vb8erTxNmpMcRgyADprZrI2YxI5HGICcu
 TRZQ==
X-Gm-Message-State: AOAM530jiV29mV5fsNvSbOZC3JSQC4NDf56JCAdUjETzJljrTyw3ObOS
 QbwojSyJituN5ck/WnH4eG9hzr8E1qOfirEmItYNRL+3OtQGd8I9E2MgLxQ57jj4uVBsCdMo8Dp
 5xOHe3v6KV9lxGHo89N+SiB/qlILDPH0T3i5Gspchmw==
X-Received: by 2002:a0c:9e4e:: with SMTP id z14mr22088423qve.71.1596550060726; 
 Tue, 04 Aug 2020 07:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXZYn2kYoVoPTMxHOlAinXwUHh9e5wf9YCT9UDb/2L0ldClTmNU7M2/9PZQ2lCCvwhHwKVrA==
X-Received: by 2002:a0c:9e4e:: with SMTP id z14mr22088386qve.71.1596550060392; 
 Tue, 04 Aug 2020 07:07:40 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id p4sm21874787qkj.135.2020.08.04.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 07:07:39 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:07:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v4 0/4] Add a vhost RPMsg API
Message-ID: <20200804100640-mutt-send-email-mst@kernel.org>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
 <20200730120805-mutt-send-email-mst@kernel.org>
 <20200731054752.GA28005@ubuntu>
 <CANLsYkxuCf6yeoqJ-T2x3LHvr9+DuxFdcsxJPmrh9A4H8yNr3w@mail.gmail.com>
 <20200803164605-mutt-send-email-mst@kernel.org>
 <CANLsYkx9e=-2dU26Lx5JFrtrbV07Vtwsi3gFphxKW5QRiwqoHg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANLsYkx9e=-2dU26Lx5JFrtrbV07Vtwsi3gFphxKW5QRiwqoHg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Ohad Ben-Cohen <ohad@wizery.com>, kvm@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-remoteproc <linux-remoteproc@vger.kernel.org>,
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

On Tue, Aug 04, 2020 at 07:37:49AM -0600, Mathieu Poirier wrote:
> On Mon, 3 Aug 2020 at 14:47, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 03, 2020 at 07:25:24AM -0600, Mathieu Poirier wrote:
> > > On Thu, 30 Jul 2020 at 23:47, Guennadi Liakhovetski
> > > <guennadi.liakhovetski@linux.intel.com> wrote:
> > > >
> > > > Hi Michael,
> > > >
> > > > On Thu, Jul 30, 2020 at 12:08:29PM -0400, Michael S. Tsirkin wrote:
> > > > > On Wed, Jul 22, 2020 at 05:09:23PM +0200, Guennadi Liakhovetski wrote:
> > > > > > Hi,
> > > > > >
> > > > > > Now that virtio-rpmsg endianness fixes have been merged we can
> > > > > > proceed with the next step.
> > > > >
> > > > > Which tree is this for?
> > > >
> > > > The essential part of this series is for drivers/vhost, so, I presume
> > > > that should be the target tree as well. There is however a small part
> > > > for the drivers/rpmsg, should I split this series in two or shall we
> > > > first review is as a whole to make its goals clearer?
> > >
> > > I suggest to keep it whole for now.
> >
> >
> > Ok can I get some acks please?
> 
> Yes, as soon as I have the opportunity to review the work.  There is a
> lot of volume on the linux-remoteproc mailing list lately and
> patchsets are reviewed in the order they have been received.

Well the merge window is open, I guess I'll merge this and
any issues can be addressed later then?

> > Also, I put this in my linux-next branch on
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
> >
> > there were some conflicts - could you pls test and report it's ok?
> >
> > > >
> > > > Thanks
> > > > Guennadi
> > > >
> > > > > > v4:
> > > > > > - add endianness conversions to comply with the VirtIO standard
> > > > > >
> > > > > > v3:
> > > > > > - address several checkpatch warnings
> > > > > > - address comments from Mathieu Poirier
> > > > > >
> > > > > > v2:
> > > > > > - update patch #5 with a correct vhost_dev_init() prototype
> > > > > > - drop patch #6 - it depends on a different patch, that is currently
> > > > > >   an RFC
> > > > > > - address comments from Pierre-Louis Bossart:
> > > > > >   * remove "default n" from Kconfig
> > > > > >
> > > > > > Linux supports RPMsg over VirtIO for "remote processor" / AMP use
> > > > > > cases. It can however also be used for virtualisation scenarios,
> > > > > > e.g. when using KVM to run Linux on both the host and the guests.
> > > > > > This patch set adds a wrapper API to facilitate writing vhost
> > > > > > drivers for such RPMsg-based solutions. The first use case is an
> > > > > > audio DSP virtualisation project, currently under development, ready
> > > > > > for review and submission, available at
> > > > > > https://github.com/thesofproject/linux/pull/1501/commits
> > > > > >
> > > > > > Thanks
> > > > > > Guennadi
> > > > > >
> > > > > > Guennadi Liakhovetski (4):
> > > > > >   vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
> > > > > >   rpmsg: move common structures and defines to headers
> > > > > >   rpmsg: update documentation
> > > > > >   vhost: add an RPMsg API
> > > > > >
> > > > > >  Documentation/rpmsg.txt          |   6 +-
> > > > > >  drivers/rpmsg/virtio_rpmsg_bus.c |  78 +------
> > > > > >  drivers/vhost/Kconfig            |   7 +
> > > > > >  drivers/vhost/Makefile           |   3 +
> > > > > >  drivers/vhost/rpmsg.c            | 375 +++++++++++++++++++++++++++++++
> > > > > >  drivers/vhost/vhost_rpmsg.h      |  74 ++++++
> > > > > >  include/linux/virtio_rpmsg.h     |  83 +++++++
> > > > > >  include/uapi/linux/rpmsg.h       |   3 +
> > > > > >  include/uapi/linux/vhost.h       |   4 +-
> > > > > >  9 files changed, 553 insertions(+), 80 deletions(-)
> > > > > >  create mode 100644 drivers/vhost/rpmsg.c
> > > > > >  create mode 100644 drivers/vhost/vhost_rpmsg.h
> > > > > >  create mode 100644 include/linux/virtio_rpmsg.h
> > > > > >
> > > > > > --
> > > > > > 2.27.0
> > > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
