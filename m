Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8797FC433EF
	for <virtualization@archiver.kernel.org>; Mon,  3 Jan 2022 06:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2E3460B0A;
	Mon,  3 Jan 2022 06:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eV2gut_gJz-5; Mon,  3 Jan 2022 06:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 89E3760AF7;
	Mon,  3 Jan 2022 06:11:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F193C0030;
	Mon,  3 Jan 2022 06:11:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B8E3C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jan 2022 06:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BCD4400FC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jan 2022 06:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3EVzPAnNd814
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jan 2022 06:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F3D49400BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Jan 2022 06:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641190302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eZWdqglEJRBMyWOswue91QGGug+foo23E07h4yycLxk=;
 b=HRL5YnHa1yulGnOA1JzB549mXs0VZGS41FPJu/odPYeDh13i5tKe7lVZVXRCSXAAEcpO16
 OGQAyDzIk3KHK71nS6xhHEVIlvfzZ/l0ceAi/wgS/MSiCWNBCE7qYMkvpmdtEbdxZI8GFR
 mCvbtmJ9JoC0rEXOU7GhWHzAeFLBWO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-jznnFRq4Ox2x6SNXuNadWw-1; Mon, 03 Jan 2022 01:11:36 -0500
X-MC-Unique: jznnFRq4Ox2x6SNXuNadWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB1321006AA9;
 Mon,  3 Jan 2022 06:11:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76F497B9DB;
 Mon,  3 Jan 2022 06:11:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C52A6180039F; Mon,  3 Jan 2022 07:11:27 +0100 (CET)
Date: Mon, 3 Jan 2022 07:11:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [RFC 26/32] drm: handle HAS_IOPORT dependencies
Message-ID: <20220103061127.jrnsfuxbxk2ywmtg@sirius.home.kraxel.org>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-27-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211227164317.4146918-27-schnelle@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Dave Airlie <airlied@redhat.com>,
 Nick Hu <nickhu@andestech.com>, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Greentime Hu <green.hu@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Guo Ren <guoren@kernel.org>,
 linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>,
 spice-devel@lists.freedesktop.org
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

On Mon, Dec 27, 2021 at 05:43:11PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them. There is also a direct and hard coded use in
> cirrus.c which according to the comment is only necessary during resume.
> Let's just skip this as for example s390 which doesn't have I/O port
> support also doesen't support suspend/resume.

>  config DRM_BOCHS
>  	tristate "DRM Support for bochs dispi vga interface (qemu stdvga)"
>  	depends on DRM && PCI && MMU
> +	depends on HAS_IOPORT
>  	select DRM_KMS_HELPER
>  	select DRM_VRAM_HELPER
>  	select DRM_TTM

On devices with an mmio bar the driver works just fine without inb/outb,
see bochs->mmio checks in bochs.c

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
