Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF4CC433F5
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 07:30:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7E4610FC
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 07:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A7E4610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2051F608ED;
	Wed,  3 Nov 2021 07:30:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TbLPXLQE5xSC; Wed,  3 Nov 2021 07:30:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6BE56080C;
	Wed,  3 Nov 2021 07:30:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D373C0019;
	Wed,  3 Nov 2021 07:30:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50BF6C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 07:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44CE240101
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 07:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4j1s4EV-sUA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 07:30:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F764400F2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 07:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635924651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0xpja8WAihX9QgetoK4QXWHOWWctjoZyW/XmFOQd8n4=;
 b=WCwF36Vhsr6AhYP//HwDPAVNS5AwjPZv8wDtCGws+v33EprWNfSsa7Q7SKSFPETdVb6mao
 ZaGF01EfsY6dlm4S7S38OsW3G0wmlh/WwiJLuc5C7owkpDumxn6noNv1fv9PjP6rotED48
 bWCUGQrjClSY0XFl/N1UU+9u/M+egIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-3wlqcyNwORaF132aqw5eUQ-1; Wed, 03 Nov 2021 03:30:47 -0400
X-MC-Unique: 3wlqcyNwORaF132aqw5eUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A05A710B3947;
 Wed,  3 Nov 2021 07:30:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E65C319723;
 Wed,  3 Nov 2021 07:30:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 147151800924; Wed,  3 Nov 2021 08:30:43 +0100 (CET)
Date: Wed, 3 Nov 2021 08:30:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH] drm/virtio: delay pinning the pages till first use
Message-ID: <20211103073043.x7hdnm43zrw7u6j3@sirius.home.kraxel.org>
References: <20211102113139.154140-1-maksym.wezdecki@collabora.com>
 <20211102130308.2s64ghmic5nhj6vu@sirius.home.kraxel.org>
 <CAPaKu7T9-KmmDwNRFzQWM3jH4h-xUwjtfWays20z24dVvROoHw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPaKu7T9-KmmDwNRFzQWM3jH4h-xUwjtfWays20z24dVvROoHw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: David Airlie <airlied@linux.ie>, mwezdeck <maksym.wezdecki@collabora.co.uk>,
 ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
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

On Tue, Nov 02, 2021 at 08:58:55AM -0700, Chia-I Wu wrote:
> On Tue, Nov 2, 2021 at 6:07 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Tue, Nov 02, 2021 at 12:31:39PM +0100, Maksym Wezdecki wrote:
> > > From: mwezdeck <maksym.wezdecki@collabora.co.uk>
> > >
> > > The idea behind the commit:
> > >   1. not pin the pages during resource_create ioctl
> > >   2. pin the pages on the first use during:
> > >       - transfer_*_host ioctl
> > >         - map ioctl
> >
> > i.e. basically lazy pinning.  Approach looks sane to me.
> >
> > >   3. introduce new ioctl for pinning pages on demand
> >
> > What is the use case for this ioctl?
> > In any case this should be a separate patch.
> 
> Lazy pinning can be a nice optimization that userspace does not
> necessarily need to know about.  This patch however skips pinning for
> execbuffer ioctl and introduces a new pin ioctl instead.  That is a
> red flag.

Ah, so the pin ioctl is for buffers which need a pin for execbuffer.

Yep, that isn't going to fly that way, it'll break old userspace.

Lazy pinning must be opt-in, so new userspace which knows about
the pin ioctl can enable lazy pinning.  One possible way would
be to add a flag for the VIRTGPU_RESOURCE_CREATE ioctl, so lazy
pinning can be enabled per resource.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
