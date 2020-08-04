Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE87C433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 12:27:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C392C22BED
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 12:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGPYheDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C392C22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 77E9B226A9;
	Tue,  4 Aug 2020 12:27:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bm3frExDOw8N; Tue,  4 Aug 2020 12:27:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 342F02265B;
	Tue,  4 Aug 2020 12:27:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15634C0051;
	Tue,  4 Aug 2020 12:27:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD1F7C004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 12:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C506E2265B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 12:27:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNSy3EyDBBBB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 12:27:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 77ED522654
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596544024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9vhPgMDKcGi9ZPslRrds1Rb1iUgXvAPxw94iDlV9Esw=;
 b=hGPYheDXg6fSDy7KwvRkrOLaqf4hGeG6V3reRKN9F4g0mgpxEA2jFDLg3jdLQT1x13XfYq
 FOtWpk/GuMCHpNX9Ax1ykQZAprKbjbiVsRr9RKBDI6751hvuYecZwcnueuA/PPnUTYjSgn
 ksnZHwGMTr29xLo1R6oAS5jPGOa2/os=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-8Qb9SilyNjmHx4ci6BAVgA-1; Tue, 04 Aug 2020 08:27:01 -0400
X-MC-Unique: 8Qb9SilyNjmHx4ci6BAVgA-1
Received: by mail-qk1-f198.google.com with SMTP id a130so27530442qkg.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Aug 2020 05:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9vhPgMDKcGi9ZPslRrds1Rb1iUgXvAPxw94iDlV9Esw=;
 b=V+b23a0SEowBtcBXbw90aLb4PgbmxPXdP7r6EvTm2q4lLWakzHjSq8XDxI5aPt8/DI
 mnzfgqMvG2oBAo3c6XaC23WAUU3S1tae9+yFIv3+YApW/L5B0Op/NAb8QVTVgPtEX8IN
 qNIb1bjj5PrRqLik4XOVdTfB3wP6I/idbR3xgHWR40qR055qE2SeiiBxieLHbusk/F7R
 vXfBMkLzQvrzeI8BfC5yvKk7jHh8NLFOVEkQKftfC+CopZAM5CQpD+o1aOL/4nmlzVnI
 HpebnEqju8+s624gsaogMWJdMMzxRZbPFz9Uha9QZet4Yh8cckNfDRH+TSv7d3u6gyF1
 0jTw==
X-Gm-Message-State: AOAM533HA7GkViUiFAsDhr0CXw42AixnkjsORp1A8d6AeNchoYxhXYM6
 HS9hUwZZtGOKXX/ejihWLBFCnaLGwt0/TNVTPRmhrkS/1YxjDeShxxAtl/JlL7HN5jFrqfjRvWN
 xeEzTJ5D0Z/sKSetQ/acqPQePMvK1WJj9eTOWeRv4rA==
X-Received: by 2002:ac8:586:: with SMTP id a6mr21323486qth.391.1596544020888; 
 Tue, 04 Aug 2020 05:27:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGMj+9fSab5vOUQnGujXpnk+obUr+jaJXm5QnWgBc4+EfOvLlsgeBJv/ur3ycUhBN2ervlkA==
X-Received: by 2002:ac8:586:: with SMTP id a6mr21323472qth.391.1596544020661; 
 Tue, 04 Aug 2020 05:27:00 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id e21sm21251091qkl.88.2020.08.04.05.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 05:26:59 -0700 (PDT)
Date: Tue, 4 Aug 2020 08:26:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v4 0/4] Add a vhost RPMsg API
Message-ID: <20200804082250-mutt-send-email-mst@kernel.org>
References: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20200722150927.15587-1-guennadi.liakhovetski@linux.intel.com>
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

On Wed, Jul 22, 2020 at 05:09:23PM +0200, Guennadi Liakhovetski wrote:
> Hi,
> 
> Now that virtio-rpmsg endianness fixes have been merged we can 
> proceed with the next step.

OK my attempts to resolve conflicts just created a mess.

I dropped these for now, could you pls rebase on top
of linux-next branch in my tree, and repost?
Thanks!


> v4:
> - add endianness conversions to comply with the VirtIO standard
> 
> v3:
> - address several checkpatch warnings
> - address comments from Mathieu Poirier
> 
> v2:
> - update patch #5 with a correct vhost_dev_init() prototype
> - drop patch #6 - it depends on a different patch, that is currently
>   an RFC
> - address comments from Pierre-Louis Bossart:
>   * remove "default n" from Kconfig
> 
> Linux supports RPMsg over VirtIO for "remote processor" / AMP use
> cases. It can however also be used for virtualisation scenarios,
> e.g. when using KVM to run Linux on both the host and the guests.
> This patch set adds a wrapper API to facilitate writing vhost
> drivers for such RPMsg-based solutions. The first use case is an
> audio DSP virtualisation project, currently under development, ready
> for review and submission, available at
> https://github.com/thesofproject/linux/pull/1501/commits
> 
> Thanks
> Guennadi
> 
> Guennadi Liakhovetski (4):
>   vhost: convert VHOST_VSOCK_SET_RUNNING to a generic ioctl
>   rpmsg: move common structures and defines to headers
>   rpmsg: update documentation
>   vhost: add an RPMsg API
> 
>  Documentation/rpmsg.txt          |   6 +-
>  drivers/rpmsg/virtio_rpmsg_bus.c |  78 +------
>  drivers/vhost/Kconfig            |   7 +
>  drivers/vhost/Makefile           |   3 +
>  drivers/vhost/rpmsg.c            | 375 +++++++++++++++++++++++++++++++
>  drivers/vhost/vhost_rpmsg.h      |  74 ++++++
>  include/linux/virtio_rpmsg.h     |  83 +++++++
>  include/uapi/linux/rpmsg.h       |   3 +
>  include/uapi/linux/vhost.h       |   4 +-
>  9 files changed, 553 insertions(+), 80 deletions(-)
>  create mode 100644 drivers/vhost/rpmsg.c
>  create mode 100644 drivers/vhost/vhost_rpmsg.h
>  create mode 100644 include/linux/virtio_rpmsg.h
> 
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
