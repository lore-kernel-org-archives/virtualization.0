Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56320C433E0
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:47:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51135207DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXch8zKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51135207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A42E820502;
	Mon,  3 Aug 2020 20:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id paEKXCpawMnw; Mon,  3 Aug 2020 20:47:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A29262010F;
	Mon,  3 Aug 2020 20:47:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80C69C0050;
	Mon,  3 Aug 2020 20:47:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64000C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:47:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4CBE48739E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pcw0dUNp5RLQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:47:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 861EA86DCA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596487622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YWSXpH5LufLhcUK5++dpDgIe+PU/a2RiJP9vO4xSyb8=;
 b=IXch8zKfr1HMFS+ToTrnJQ6JGtKpZahN7oe/bHcBKOfOwzskNfEYCmWm+JYA65MqVD9kSN
 vF6Eey6lhgLOjZXBCH0z3EWBKUWIW7Y9VqbkAAPuZIbCZ9S1fPXu+fmEsntknU9VTTr6FS
 rjtxjZ5GbYxOvK1TA0B/XArNwLbk4cw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-aexK-zDOPAO5b6ZI7apWFQ-1; Mon, 03 Aug 2020 16:46:58 -0400
X-MC-Unique: aexK-zDOPAO5b6ZI7apWFQ-1
Received: by mail-qk1-f199.google.com with SMTP id 1so27067251qkm.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YWSXpH5LufLhcUK5++dpDgIe+PU/a2RiJP9vO4xSyb8=;
 b=ihHm4IvySereW0Rux1H9Qv/8JnULFJHsErLONakInD/qcJZQ6b5OZ6gz8cpxqhqDaj
 Qg2y4Mdy3k0YPGOkZ+o0Y08+6a/fuhTSXyTGBGQ28wqbwR3JLyzT0shvLpKByIjOpnE/
 15vRQtAyxaBy6bEecAgviGLxfSly9v3uec2laXIbZgF6v3mO0cUYhC/lZ8jQDsZO+X4B
 nBtXVJvYeM9/7t+sKfMylg24K4RAuPtryxJ2QDXZzMvZVEyHM4ROhqIfPO9LECWakP46
 SLxlCnokx0TB8eDwTb207I0ZpIvZJSL59j/XhGs0uu1lncy7HMrK5e8PMzuXPg9be7Uw
 78AQ==
X-Gm-Message-State: AOAM532SlRBGcy2Q6hnkZPeUQHFIZgvj82QNJaYgdUz/b+FGoiSPcnXN
 I53ScIgRpUC4B2yBv3dRHJPjjzDOCbtDLMx+b4iTpHbwDU/e8/vwCMRBphSM24r0gRwyD662hQg
 ZhtQNbVvsaHdiliWbPmYjshlqsk6Cdkv5lE0kq4edmQ==
X-Received: by 2002:ac8:7a95:: with SMTP id x21mr18296175qtr.135.1596487618311; 
 Mon, 03 Aug 2020 13:46:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5fxnaL6Ri46pS/AV+1q2qnTh3NBSJWvAJ/JhDs1vxf+Hn61PqhkFs+LWvi9B3V915cqgzgQ==
X-Received: by 2002:ac8:7a95:: with SMTP id x21mr18296141qtr.135.1596487617954; 
 Mon, 03 Aug 2020 13:46:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id w44sm23855273qtj.86.2020.08.03.13.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:46:56 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:46:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v4 0/4] Add a vhost RPMsg API
Message-ID: <20200803164605-mutt-send-email-mst@kernel.org>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
 <20200730120805-mutt-send-email-mst@kernel.org>
 <20200731054752.GA28005@ubuntu>
 <CANLsYkxuCf6yeoqJ-T2x3LHvr9+DuxFdcsxJPmrh9A4H8yNr3w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANLsYkxuCf6yeoqJ-T2x3LHvr9+DuxFdcsxJPmrh9A4H8yNr3w@mail.gmail.com>
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

On Mon, Aug 03, 2020 at 07:25:24AM -0600, Mathieu Poirier wrote:
> On Thu, 30 Jul 2020 at 23:47, Guennadi Liakhovetski
> <guennadi.liakhovetski@linux.intel.com> wrote:
> >
> > Hi Michael,
> >
> > On Thu, Jul 30, 2020 at 12:08:29PM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 22, 2020 at 05:09:23PM +0200, Guennadi Liakhovetski wrote:
> > > > Hi,
> > > >
> > > > Now that virtio-rpmsg endianness fixes have been merged we can
> > > > proceed with the next step.
> > >
> > > Which tree is this for?
> >
> > The essential part of this series is for drivers/vhost, so, I presume
> > that should be the target tree as well. There is however a small part
> > for the drivers/rpmsg, should I split this series in two or shall we
> > first review is as a whole to make its goals clearer?
> 
> I suggest to keep it whole for now.


Ok can I get some acks please?
Also, I put this in my linux-next branch on 

https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git

there were some conflicts - could you pls test and report it's ok?

> >
> > Thanks
> > Guennadi
> >
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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
