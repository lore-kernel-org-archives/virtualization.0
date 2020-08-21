Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DADC433E1
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 11:59:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEEA20639
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 11:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pprz9GB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEEA20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 729A186BB9;
	Fri, 21 Aug 2020 11:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QO_nSR3cGh8s; Fri, 21 Aug 2020 11:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 95FA286BA9;
	Fri, 21 Aug 2020 11:59:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85191C0889;
	Fri, 21 Aug 2020 11:59:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE18EC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BED6120460
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7w2eJL0+VrIh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:59:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id A8BBD203FA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598011159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXhX/N8GWSH0WBma7AaYD7/6Ls1zDroEUp4iK0a472s=;
 b=Pprz9GB18yLo7N34MsnjMH33xtquWqXOEpcs8SwzZegs2ys9NLQ9DizkDiZ6dFnHUctdNi
 HAx/fSrv3YxY07F7/GavoDyflMF6d2RKHlOI3xj/8J0ocHv993TjTJCDZYB9+3Wf+qyYQ6
 TXQGdbOhkRovEPH76PIvewl/AFLNUBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-k3hyZhTvOxCnLe9Nsh08xw-1; Fri, 21 Aug 2020 07:59:17 -0400
X-MC-Unique: k3hyZhTvOxCnLe9Nsh08xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C82864080;
 Fri, 21 Aug 2020 11:59:15 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEAE27AECB;
 Fri, 21 Aug 2020 11:59:08 +0000 (UTC)
Date: Fri, 21 Aug 2020 13:59:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v9 1/2] virtio: let arch advertise guest's memory access
 restrictions
Message-ID: <20200821135906.1c6bede3.cohuck@redhat.com>
In-Reply-To: <1597854198-2871-2-git-send-email-pmorel@linux.ibm.com>
References: <1597854198-2871-1-git-send-email-pmorel@linux.ibm.com>
 <1597854198-2871-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, linuxram@us.ibm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, thomas.lendacky@amd.com,
 hca@linux.ibm.com, david@gibson.dropbear.id.au
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

On Wed, 19 Aug 2020 18:23:17 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> An architecture may restrict host access to guest memory.

"e.g. IBM s390 Secure Execution or AMD SEV"

Just to make clearer what you are referring to?

> 
> Provide a new Kconfig entry the architecture can select,
> CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, when it provides
> the arch_has_restricted_virtio_memory_access callback to advertise

s/advertise/advertise to/

> VIRTIO common code when the architecture restricts memory access
> from the host.

"The common code can then fail the probe for any device where
VIRTIO_F_IOMMU_PLATFORM is required, but not set."

?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/virtio/Kconfig        |  6 ++++++
>  drivers/virtio/virtio.c       | 15 +++++++++++++++
>  include/linux/virtio_config.h |  9 +++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 5809e5f5b157..509f3b4d8ba1 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -6,6 +6,12 @@ config VIRTIO
>  	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>  	  or CONFIG_S390_GUEST.
>  
> +config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> +	bool
> +	help
> +	  This option is selected by any architecture enforcing
> +	  VIRTIO_F_IOMMU_PLATFORM

"This option is selected if the architecture may need to enforce
VIRTIO_F_IOMMU_PLATFORM."

?

> +
>  menuconfig VIRTIO_MENU
>  	bool "Virtio drivers"
>  	default y

(...)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
