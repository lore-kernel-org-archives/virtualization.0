Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB34C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 07:58:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129C264E78
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 07:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C264E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5BFCB858B6;
	Mon,  8 Feb 2021 07:58:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8PeCHZMXh3nt; Mon,  8 Feb 2021 07:57:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 872018562A;
	Mon,  8 Feb 2021 07:57:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64BBDC0891;
	Mon,  8 Feb 2021 07:57:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81B5AC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 07:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 66F8D86FD1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 07:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mfXekJh9fKcm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 07:57:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7DCF586FCC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 07:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612771076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3awWSy5e6riy2O68pZN3zZ2GQr/MiEbcpjT4NcEwmQ=;
 b=Vx+sFP5LwVsS+EeLy+XFMpSav652lQqoVE333Yl9JsRM+9As1690zT5W2exmr3CahrPyok
 k2jyGPbmzt/ou35dRVgHIHbYjbDXEc2LiEaHaMeWuY0/3DPhf9IVYsfLogorCR7aTfRVVq
 NAzWjNq9SuvTEZeLlkwdhjYJ1JhblKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-XTrgxfrMO46qeBaXVqHbnw-1; Mon, 08 Feb 2021 02:57:52 -0500
X-MC-Unique: XTrgxfrMO46qeBaXVqHbnw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6244B91284;
 Mon,  8 Feb 2021 07:57:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-170.ams2.redhat.com
 [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D36F91A86F;
 Mon,  8 Feb 2021 07:57:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4195E18000AF; Mon,  8 Feb 2021 08:57:48 +0100 (CET)
Date: Mon, 8 Feb 2021 08:57:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Message-ID: <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
References: <20210203073517.1908882-1-vivek.kasireddy@intel.com>
 <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YB1sRx1GrT8rATEg@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: dongwon.kim@intel.com, christian.koenig@amd.com, daniel.vetter@ffwll.ch,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 daniel.vetter@intel.com, sumit.semwal@linaro.org, linux-media@vger.kernel.org
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

  Hi,

> > +/* extract pages referenced by sgt */
> > +static struct page **extr_pgs(struct sg_table *sgt, int *nents, int *last_len)
> 
> Nack, this doesn't work on dma-buf. And it'll blow up at runtime when you
> enable the very recently merged CONFIG_DMABUF_DEBUG (would be good to test
> with that, just to make sure).

> Aside from this, for virtio/kvm use-cases we've already merged the udmabuf
> driver. Does this not work for your usecase?

udmabuf can be used on the host side to make a collection of guest pages
available as host dmabuf.  It's part of the puzzle, but not a complete
solution.

As I understand it the intended workflow is this:

  (1) guest gpu driver exports some object as dma-buf
  (2) dma-buf is imported into this new driver.
  (3) driver sends the pages to the host.
  (4) hypervisor uses udmabuf to create a host dma-buf.
  (5) host dma-buf is passed on.

And step (3) is the problematic one as this will not
work in case the dma-buf doesn't live in guest ram but
in -- for example -- gpu device memory.

Reversing the driver roles in the guest (virtio driver
allocates pages and exports the dma-buf to the guest
gpu driver) should work fine.

Which btw is something you can do today with virtio-gpu.
Maybe it makes sense to have the option to run virtio-gpu
in render-only mode for that use case.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
