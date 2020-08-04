Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66618C433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:10:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3779621744
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 14:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMBUiyPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3779621744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC5BD86912;
	Tue,  4 Aug 2020 14:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zhJVgzc6gFO; Tue,  4 Aug 2020 14:10:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D7DC484E2E;
	Tue,  4 Aug 2020 14:10:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9CC6C0051;
	Tue,  4 Aug 2020 14:10:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AE6FC004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0B15F20492
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:10:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vq3U-hj3uZyV
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:10:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id EEB7220107
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596550232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Buhd+kZycj+/wRI0Hp3Q3IKmTfkuvVjniMvAfWe01oU=;
 b=aMBUiyPAUv/0I75VHS8aqImuc5cxkIs+iWVffvHS3gXe1kwssCd7oNbjOWoLhJJz7MzqFb
 WuamrTEEvYqmTw1KPRv65pkVflXWKwtMlDqeN1mbqkTjIDR5Co81B0LXRLa0qyQMX+5SLq
 WLgMIIuXOEgGD6qbZWCFVHwB3Y2AaIk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-7kZNtOXXOGCyGp4sgi9cKA-1; Tue, 04 Aug 2020 10:10:30 -0400
X-MC-Unique: 7kZNtOXXOGCyGp4sgi9cKA-1
Received: by mail-qt1-f199.google.com with SMTP id u17so26798842qtq.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 07:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Buhd+kZycj+/wRI0Hp3Q3IKmTfkuvVjniMvAfWe01oU=;
 b=a/m3KgYzFMxj+51KNd8vnJrEE/1MzLWOKe/aCytRqLSiTcPYTUCtkFGWrGjlB9rS42
 cRAssd0oLz2NxAU8QuJkLoGvitZUD3fxgd7IJwpmrzPzQOTIw0bx75RSmoX0H2oZyqh+
 VJju3mQWIo7yshOnWY79fPKup3STFpTbh+xyg0XWXxdnDaoHqIGYRdLbbq7o5wErSKsD
 e5YiE3fc6GlYr7ieE0cQ9v1f5VEfTaKwf4d21MwF0fbRQu3EjnH7KtVYnU2Epki2t6y1
 L8b8uFeByTx1BGf0r7DisvOhORKhv5Kzo0w233B95d2N06Cg9sacB/pXol/8X96DV7fE
 ERQg==
X-Gm-Message-State: AOAM530Nl3wLrgARSnNIQvRGd0cux2iWvEJV/1aZ30MR7iMhTZKBx1bg
 tmPIjV7ZNGVNfNwo3+NyPlzaLIevVOruWO6fp95q08g2HJqW4Yx5kld+/Sjnzcat59MsaenFMlr
 YACM2Gi4hD0DS5xQLDkV8rTdu+u6ewVAKtP0AcIcM0Q==
X-Received: by 2002:ac8:5546:: with SMTP id o6mr20933608qtr.211.1596550229556; 
 Tue, 04 Aug 2020 07:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh3pjFBLQIXYiY71oA2fmlEWD9//13DksMw68m8mtIbvj8Tup8wAllZTDQOkR6zg/SeRurDQ==
X-Received: by 2002:ac8:5546:: with SMTP id o6mr20933560qtr.211.1596550229198; 
 Tue, 04 Aug 2020 07:10:29 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id l66sm1076968qte.48.2020.08.04.07.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 07:10:28 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:10:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v4 0/4] Add a vhost RPMsg API
Message-ID: <20200804100747-mutt-send-email-mst@kernel.org>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
 <20200804082250-mutt-send-email-mst@kernel.org>
 <20200804131918.GA19025@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20200804131918.GA19025@ubuntu>
X-Mimecast-Spam-Score: 0
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

On Tue, Aug 04, 2020 at 03:19:19PM +0200, Guennadi Liakhovetski wrote:
> Hi Michael,
> 
> On Tue, Aug 04, 2020 at 08:26:53AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 22, 2020 at 05:09:23PM +0200, Guennadi Liakhovetski wrote:
> > > Hi,
> > > 
> > > Now that virtio-rpmsg endianness fixes have been merged we can 
> > > proceed with the next step.
> > 
> > OK my attempts to resolve conflicts just created a mess.
> 
> You just need to apply my previous patch for virtio-rpmsg first 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/rpmsg/virtio_rpmsg_bus.c?id=111d1089700cdb752681ef44f54ab6137736f5c2
> Then this series should apply cleanly.
> 
> Thanks
> Guennadi

Hmm.  Could you test the vhost branch in my tree, and tell me if that looks
good to you?

> > I dropped these for now, could you pls rebase on top
> > of linux-next branch in my tree, and repost?
> > Thanks!
> > 
> > 
> > > v4:
> > > - add endianness conversions to comply with the VirtIO standard
> > > 
> > > v3:
> > > - address several checkpatch warnings
> > > - address comments from Mathieu Poirier
> > > 
> > > v2:
> > > - update patch #5 with a correct vhost_dev_init() prototype
> > > - drop patch #6 - it depends on a different patch, that is currently
> > >   an RFC
> > > - address comments from Pierre-Louis Bossart:
> > >   * remove "default n" from Kconfig
> > > 
> > > Linux supports RPMsg over VirtIO for "remote processor" / AMP use
> > > cases. It can however also be used for virtualisation scenarios,
> > > e.g. when using KVM to run Linux on both the host and the guests.
> > > This patch set adds a wrapper API to facilitate writing vhost
> > > drivers for such RPMsg-based solutions. The first use case is an
> > > audio DSP virtualisation project, currently under development, ready
> > > for review and submission, available at
> > > https://github.com/thesofproject/linux/pull/1501/commits
> > > 
> > > Thanks
> > > Guennadi
> > > 
> > > Guennadi Liakhovetski (4):
> > >   vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
> > >   rpmsg: move common structures and defines to headers
> > >   rpmsg: update documentation
> > >   vhost: add an RPMsg API
> > > 
> > >  Documentation/rpmsg.txt          |   6 +-
> > >  drivers/rpmsg/virtio_rpmsg_bus.c |  78 +------
> > >  drivers/vhost/Kconfig            |   7 +
> > >  drivers/vhost/Makefile           |   3 +
> > >  drivers/vhost/rpmsg.c            | 375 +++++++++++++++++++++++++++++++
> > >  drivers/vhost/vhost_rpmsg.h      |  74 ++++++
> > >  include/linux/virtio_rpmsg.h     |  83 +++++++
> > >  include/uapi/linux/rpmsg.h       |   3 +
> > >  include/uapi/linux/vhost.h       |   4 +-
> > >  9 files changed, 553 insertions(+), 80 deletions(-)
> > >  create mode 100644 drivers/vhost/rpmsg.c
> > >  create mode 100644 drivers/vhost/vhost_rpmsg.h
> > >  create mode 100644 include/linux/virtio_rpmsg.h
> > > 
> > > -- 
> > > 2.27.0
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
