Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FAEC47089
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 14:34:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589626113D
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 14:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589626113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16DB440262;
	Wed, 26 May 2021 14:34:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mwjLndrf_hZp; Wed, 26 May 2021 14:34:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DAF840424;
	Wed, 26 May 2021 14:34:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF066C000E;
	Wed, 26 May 2021 14:34:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3D3DC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 14:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D06C64044C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 14:34:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ajr5_ad4AHCn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 14:34:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1BC64044D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 14:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622039668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cqBPgPyUlAbZ7Kk+oGgbHiAKQDgT/aGEeIFiCp5+zq4=;
 b=AJIPNQODLzMGr5LmdNbow5R7RhEeEg6wAx/xDimQus7OZurLrX51Rd+iJ6ITph27YvNQjC
 toSjRPgc7Vx+Gfr+gGw2ikKPfKzwFG/gESYQItGC90GBN9kb+iwf2yQbutae0Hwb3n67Qq
 vgLr7mg603rT37TDIDxLdFlOkUwECvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-D2hxjXQtPpStZr2pCmQUGA-1; Wed, 26 May 2021 10:34:25 -0400
X-MC-Unique: D2hxjXQtPpStZr2pCmQUGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3911A107AD35;
 Wed, 26 May 2021 14:34:24 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-79.ams2.redhat.com [10.36.113.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C85BA1037F21;
 Wed, 26 May 2021 14:34:22 +0000 (UTC)
Date: Wed, 26 May 2021 16:34:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 0/2] virtio-ccw: allow to disable legacy virtio
Message-ID: <20210526163420.4620f342.cohuck@redhat.com>
In-Reply-To: <20210304132715.1587211-1-cohuck@redhat.com>
References: <20210304132715.1587211-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
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

On Thu,  4 Mar 2021 14:27:13 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

Just found this old series sitting there... does anyone have an opinion
on the general approach?

> Unlike virtio-pci, virtio-ccw is currently always a transitional
> driver (i.e. it always includes support for legacy devices.) The
> differences between legacy and virtio-1+ virtio-ccw devices are not
> that big (the most interesting things are in common virtio code
> anyway.)
> 
> It might be beneficial to make support for legacy virtio generally
> configurable, in case we want to remove it completely in a future
> where we all have flying cars. As a prereq, we need to make it
> configurable for virtio-ccw.
> 
> Patch 1 introduces a parameter; now that I look at it, it's probably
> not that useful (not even for testing), so I'm inclined to drop it
> again.
> 
> Patch 2 adds a new config symbol for generic legacy virtio support,
> which currently does not do anything but being selected by the
> legacy options for virtio-pci and virtio-ccw. A virtio-ccw driver
> without legacy support will require a revision of 1 or higher to
> be supported by the device.
> 
> A virtio-ccw driver with legacy turned off works well for me with
> transitional devices and fails onlining gracefully for legacy devices
> (max_revision=0 in QEMU).
> 
> (I also have some code that allows to make devices non-transitional
> in QEMU, but I haven't yet found time to polish the patches.)
> 
> Cornelia Huck (2):
>   virtio/s390: add parameter for minimum revision
>   virtio/s390: make legacy support configurable
> 
>  arch/s390/Kconfig                       |  11 ++
>  drivers/s390/virtio/Makefile            |   1 +
>  drivers/s390/virtio/virtio_ccw.c        | 179 ++++++++----------------
>  drivers/s390/virtio/virtio_ccw_common.h | 113 +++++++++++++++
>  drivers/s390/virtio/virtio_ccw_legacy.c | 138 ++++++++++++++++++
>  drivers/virtio/Kconfig                  |   8 ++
>  6 files changed, 330 insertions(+), 120 deletions(-)
>  create mode 100644 drivers/s390/virtio/virtio_ccw_common.h
>  create mode 100644 drivers/s390/virtio/virtio_ccw_legacy.c
> 
> 
> base-commit: cf6acb8bdb1d829b85a4daa2944bf9e71c93f4b9

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
