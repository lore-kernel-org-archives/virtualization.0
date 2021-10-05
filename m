Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F3C433FE
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 07:42:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C2F61507
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 07:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39C2F61507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F07E083CD2;
	Tue,  5 Oct 2021 07:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S63uORcfQwcL; Tue,  5 Oct 2021 07:42:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8441983CC8;
	Tue,  5 Oct 2021 07:42:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BEA8C000F;
	Tue,  5 Oct 2021 07:42:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A55DEC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EF8940215
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZW4kYoMM8aVD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 732E340185
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633419755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hdh6ajdDzhpIekGGpi0K51OPld4n6Pfnxhu7uKZt4wQ=;
 b=Z3gstj0VNnBLGQFitCieCemRexZh2Qsi5TPeI8Kyj16rB/HxBRGklfm8VDCTgIpPe8JSJ+
 Dx9IzYr87sHPqeZzfFZHvSP5zivmhtJrjofSMcWwR9f1281okIBVRpQM4cbCCT2GkO5YfR
 vPHKWR7uGMlH0V0udniEdHm08UPNw54=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-7TAlf3YQMtCJb8tqlWlfRw-1; Tue, 05 Oct 2021 03:42:34 -0400
X-MC-Unique: 7TAlf3YQMtCJb8tqlWlfRw-1
Received: by mail-ed1-f70.google.com with SMTP id
 ec14-20020a0564020d4e00b003cf5630c190so19897532edb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 00:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hdh6ajdDzhpIekGGpi0K51OPld4n6Pfnxhu7uKZt4wQ=;
 b=uZtt3eYBMLnX0IqI/ZUi5sDOFP8jHpe6FpYjI1e9F7qIlDiU21psbBGT2wvAgY5JwS
 +B294fkOP3bY+XCsPj51yXaqIkPEUlplSy28qjYLqa4oy0hYDHYC2VV/+b6gbH9CdY3W
 Vx2qNpr+WVIrznpYEIMHO5jc1JBPyNbFS36O4kYJQXe00XVIfirSn/OZMUad45uzEuUf
 3rzJFKzcq3htPOIF1m/GKW49akAv/r/88H8DFycmoDMPUAKeoXSUvb+ZDWlKC5PrtDut
 FHqYx40H1N2zAFd1Ww3OjGSf24+/8DUSQH7oyLv9YTBXAdXfPTtcYv3/cwPkMtrjxtby
 X/zA==
X-Gm-Message-State: AOAM530N2m/7WrZGTq6CEtG1kAyyGv6pkwCCzOw6qnAsNIIBiISv1+X0
 LiUgTYoHl4ylm1k06h0YIux6+01u238ZtjZNIrkQ2BSpPAi6As4wjatz4BgZQKl8rZYP5AIZD2O
 qxmHFREpsKQHATzF3hZ6fSoHIpNly4JPylaVBxt4IqA==
X-Received: by 2002:a50:da8f:: with SMTP id q15mr24812770edj.139.1633419753316; 
 Tue, 05 Oct 2021 00:42:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6gJQrrFofN/nnKlla94Bn55mQ1vSe2CTR69P0rD4NoYrvXgQ7h0i+F77LXOMSwecauICbcQ==
X-Received: by 2002:a50:da8f:: with SMTP id q15mr24812754edj.139.1633419753121; 
 Tue, 05 Oct 2021 00:42:33 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id q17sm8347882edd.57.2021.10.05.00.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 00:42:32 -0700 (PDT)
Date: Tue, 5 Oct 2021 03:42:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/9] More virtio hardening
Message-ID: <20211005032924-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
 virtualization@lists.linux-foundation.org
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

On Mon, Sep 13, 2021 at 01:53:44PM +0800, Jason Wang wrote:
> Hi All:
> 
> This series treis to do more hardening for virito.
> 
> patch 1 validates the num_queues for virio-blk device.
> patch 2-4 validates max_nr_ports for virito-console device.
> patch 5-7 harden virtio-pci interrupts to make sure no exepcted
> interrupt handler is tiggered. If this makes sense we can do similar
> things in other transport drivers.
> patch 8-9 validate used ring length.
> 
> Smoking test on blk/net with packed=on/off and iommu_platform=on/off.
> 
> Please review.
> 
> Thanks

So I poked at console at least, and I think I see
an issue: if interrupt handler queues a work/bh,
then it can still run while reset is in progress.

I sent a patch to fix it for console removal specifically,
but I suspect it's not enough e.g. freeze is still broken.
And note this has been reported without any TDX things -
it's not a malicious device issue, can be triggered just
by module unload.

I am vaguely thinking about new APIs to disable/enable callbacks.
An alternative:

1. adding new remove_nocb/freeze_nocb calls
2. disabling/enabling interrupts automatically around these
3. gradually moving devices to using these
4. once/if all device move, removing the old callbacks

the advantage here is that we'll be sure calls are always
paired correctly.





> Jason Wang (9):
>   virtio-blk: validate num_queues during probe
>   virtio: add doc for validate() method
>   virtio-console: switch to use .validate()
>   virtio_console: validate max_nr_ports before trying to use it
>   virtio_config: introduce a new ready method
>   virtio_pci: harden MSI-X interrupts
>   virtio-pci: harden INTX interrupts
>   virtio_ring: fix typos in vring_desc_extra
>   virtio_ring: validate used buffer length
> 
>  drivers/block/virtio_blk.c         |  3 +-
>  drivers/char/virtio_console.c      | 51 +++++++++++++++++++++---------
>  drivers/virtio/virtio_pci_common.c | 43 +++++++++++++++++++++----
>  drivers/virtio/virtio_pci_common.h |  7 ++--
>  drivers/virtio/virtio_pci_legacy.c |  5 +--
>  drivers/virtio/virtio_pci_modern.c |  6 ++--
>  drivers/virtio/virtio_ring.c       | 27 ++++++++++++++--
>  include/linux/virtio.h             |  1 +
>  include/linux/virtio_config.h      |  6 ++++
>  9 files changed, 118 insertions(+), 31 deletions(-)
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
