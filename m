Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC63BC43461
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 14:17:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7075121D90
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 14:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+cwCsX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7075121D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 162DD8692E;
	Tue,  8 Sep 2020 14:17:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zoh4-PgA8E0B; Tue,  8 Sep 2020 14:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3EF61869F5;
	Tue,  8 Sep 2020 14:17:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29429C0052;
	Tue,  8 Sep 2020 14:17:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2060C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 14:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A3887273AC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 14:17:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JOwBTCoHlPYu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 14:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id F1BDB2048A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 14:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599574640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cGbsX/FJObXX4YBouoES7lf5iOTDE5vymSl8SE+mxG0=;
 b=Q+cwCsX+HXrWvsS5vnZ6ENVaPIwFt0WqbwpwLuw38zLJdwdPBJq61p40SX39LvZvflKu2m
 Or8/GN2uy2+CiS/ZqLoGc0vbwkGoFx8ZDerKx1TohCVBM0YUTn//BX4Az9YWkCBRmDebQV
 b0sw/xpF/e8S2FHzppJ8ov6khwKle7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-g_LKuzQIMnmUwUwnDHC2vg-1; Tue, 08 Sep 2020 10:17:03 -0400
X-MC-Unique: g_LKuzQIMnmUwUwnDHC2vg-1
Received: by mail-wm1-f69.google.com with SMTP id b73so3535153wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Sep 2020 07:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cGbsX/FJObXX4YBouoES7lf5iOTDE5vymSl8SE+mxG0=;
 b=Xox1nu/vnwV4fkUtMSKB3huTBtl+S+XDIcdGirfT18kgtncW57Dzcl8m05ul7rp/+s
 0PhKnhHZK/fZKUVO6LnwccZUw4Nx44503uYgZHotHGmTkISN8q7AMAczyo/VaN+vPvG7
 8/dJTQKJVqAEGElyIuD/oYUDSK2XDE5pT4wPvEG1RKBm/kDNq3McxbbhUgNR4p7HUgq2
 DdC4zZo3gusRdv7ERwiDzGYPUNKP3HgCn+A0J2ATIVeg/RTGhp7YYAVAZ8rwjedqZlFP
 XfqXZ83qdQQEtznUOF7Io2GmX885WW2AcebJr2PQupIivMv8cFj0gWYHEaUWZeAegKEQ
 wP1w==
X-Gm-Message-State: AOAM5320Qp+T2OuOOpzpzV9uJN4nFyz9f0nrs/cceMWD6R9H9Mp79/OC
 La/7gS+dKjuSdA+/kxVzF6xVoYA4Qh/qYZF6dKIMXRsclnN4wvaXn+vU/amd7mkNNlVdXWqP6qE
 K4ohV/6iaeiBX8VBNMFciPpnxHa/IZ0/HWKBFus9YIg==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr4450620wmf.37.1599574622328; 
 Tue, 08 Sep 2020 07:17:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy7D775tAAMy+By64OwsXRHSGFwu87xaHXcz8utDT6nVrIQ1MHsq9D7+UOH4H77/ZKCANTdQ==
X-Received: by 2002:a05:600c:2283:: with SMTP id
 3mr4450590wmf.37.1599574622080; 
 Tue, 08 Sep 2020 07:17:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 w7sm34151611wrm.92.2020.09.08.07.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:16:59 -0700 (PDT)
Date: Tue, 8 Sep 2020 10:16:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v5 0/4] Add a vhost RPMsg API
Message-ID: <20200908101617-mutt-send-email-mst@kernel.org>
References: <20200826174636.23873-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20200826174636.23873-1-guennadi.liakhovetski@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
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

On Wed, Aug 26, 2020 at 07:46:32PM +0200, Guennadi Liakhovetski wrote:
> Hi,
> 
> Next update:

OK could we get some acks from rpmsg folks on this please?
It's been quite a while, patchset is not huge.


> v5:
> - don't hard-code message layout
> 
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
>  drivers/vhost/rpmsg.c            | 373 +++++++++++++++++++++++++++++++
>  drivers/vhost/vhost_rpmsg.h      |  74 ++++++
>  include/linux/virtio_rpmsg.h     |  83 +++++++
>  include/uapi/linux/rpmsg.h       |   3 +
>  include/uapi/linux/vhost.h       |   4 +-
>  9 files changed, 551 insertions(+), 80 deletions(-)
>  create mode 100644 drivers/vhost/rpmsg.c
>  create mode 100644 drivers/vhost/vhost_rpmsg.h
>  create mode 100644 include/linux/virtio_rpmsg.h
> 
> -- 
> 2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
