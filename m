Return-Path: <SRS0=C+E9=BJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F686C433E1
	for <virtualization@archiver.kernel.org>; Thu, 30 Jul 2020 16:08:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5157620829
	for <virtualization@archiver.kernel.org>; Thu, 30 Jul 2020 16:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9Is4vT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5157620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2BD7420358;
	Thu, 30 Jul 2020 16:08:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7qo-jXmYCWBd; Thu, 30 Jul 2020 16:08:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1995D2047E;
	Thu, 30 Jul 2020 16:08:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E88AFC0050;
	Thu, 30 Jul 2020 16:08:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70B9DC004D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 16:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6665C87CB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 16:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id svIY4Bre5GDH
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 16:08:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A207687C9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596125319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qUqXLll+NefydSj//AgmT8C1K6WHp8sxKqjeN68cy/c=;
 b=P9Is4vT31V72vfeftlCYxg4ElT/PZqdeIhRNrDLXfh12ZGmDjwWXEGz2bFayvoz6IyLLrw
 UX5bpUYZD2XZ8xKTJnTJlLOf1x1lM5W24jXHBPk8Hr9huB6HdV2ObLTS+7GmJSUK95HFS/
 AZ+sJEgX6i0uFXlFDP7kaRbEAGjOtMo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-tfpUkiPaPba_2xRJS-f-YQ-1; Thu, 30 Jul 2020 12:08:35 -0400
X-MC-Unique: tfpUkiPaPba_2xRJS-f-YQ-1
Received: by mail-wr1-f70.google.com with SMTP id t3so7075836wrr.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jul 2020 09:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qUqXLll+NefydSj//AgmT8C1K6WHp8sxKqjeN68cy/c=;
 b=Ux3qFFaOiL0PI1WdJwt1xX1V7SUoO1BndMT7brTAdsRJeF0ytxYM/iZ7AN7RJkQrFa
 1qSCgmzS1GW9XT9ZciWLVGk2QqHlU3pkqaIS5rM91ZKkv+wYmAMJHV7LG+tj0N9lPS4Z
 PM3eEUYuuWpsWcvHy3Z3AQLVKPbrxdv8d8NEDbYz2yFigmKoLhFpvMu2RtDqTDp5HSg9
 pOFxkPxHMdnzJSd/96eayNDVXOZq9gmIN8SvKZyi4ZZbZIBed/X1bZIXPNI3cJBnfWGl
 vO+Co1LdM9NnSIX42pwkhrpx3WTsLM8QaMUDNs9eVH3UCzIinDnmJ65c/2ZWqYbQG5E5
 qPrw==
X-Gm-Message-State: AOAM533rFblotr9j7vlLxp/i89kxAfgHFr4Ktfplk+/4PW+80aNloCoz
 G2d3At8dw+hxICzLIsL70MY7CTvy4mY1AkJaf3L9Pb4jMR3hS0ai+OrgNPiZU4A86DMef3zXNih
 HSB7nbG3KL1Us2mCjrvuYOJuFoUxLRtWLfbVP6vk93Q==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr36505wmg.78.1596125314309;
 Thu, 30 Jul 2020 09:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8EEO1xnALZftyrn6Van6xavkoUdqm7ncbftjelxThfdJiLZtzyAchyb3bUf7eXUGwTaOiKg==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr36424wmg.78.1596125313141;
 Thu, 30 Jul 2020 09:08:33 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id g7sm10167067wrv.82.2020.07.30.09.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 09:08:32 -0700 (PDT)
Date: Thu, 30 Jul 2020 12:08:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v4 0/4] Add a vhost RPMsg API
Message-ID: <20200730120805-mutt-send-email-mst@kernel.org>
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

Which tree is this for?


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
