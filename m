Return-Path: <SRS0=ygFP=HO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84276C433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 10:14:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0641A64E6B
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 10:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0641A64E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C5AA58731D;
	Fri, 12 Feb 2021 10:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNDxdx4ihDr4; Fri, 12 Feb 2021 10:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2EA5A87305;
	Fri, 12 Feb 2021 10:14:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B4ADC0174;
	Fri, 12 Feb 2021 10:14:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63AE7C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 10:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 58ECB86B93
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 10:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xr6L_z-EQaTP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 10:14:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C64C486A44
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 10:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613124882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hQ4s2GKq0YTzgoAQssPGg5wIJASO0/s1pAuGBl1EvYw=;
 b=Od3tmThh7HeReUAGemwDtIKFnElSn1pUXWrxFGDlhmAu2LDHrnMFPRdHjeI8nijt2gWrz7
 NZ2kGKG6+35qYUwpm6cMWGzSr/CZOS0qzt9u00WVqyawnQJuyoQkXK4gCiR8yN29xtchg5
 trE9/DH7getVwj5iVd/ynUsjlvOEtms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-lK_x5n1dMNiEVwnPBr3ZVg-1; Fri, 12 Feb 2021 05:14:38 -0500
X-MC-Unique: lK_x5n1dMNiEVwnPBr3ZVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D072801962;
 Fri, 12 Feb 2021 10:14:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-161.ams2.redhat.com
 [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E423A10016F9;
 Fri, 12 Feb 2021 10:14:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B8A5418003AF; Fri, 12 Feb 2021 11:14:33 +0100 (CET)
Date: Fri, 12 Feb 2021 11:14:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Message-ID: <20210212101433.prcjjktmhqyjasnj@sirius.home.kraxel.org>
References: <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
 <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
 <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
 <8ba4ad64be3546bda9a2ed2129bf98e4@intel.com>
 <20210209084453.5oqepy7zdwtxgrpu@sirius.home.kraxel.org>
 <2ef01dc941684a15a4f30e6239ae42df@intel.com>
 <8ac10b1d-3d64-4e39-42e6-6c65b61f0794@amd.com>
 <fd23d4d08ea84ca3b8a7610a8fb866d5@intel.com>
 <e3222c34-31ee-b43e-65b0-6ab01423d52b@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e3222c34-31ee-b43e-65b0-6ab01423d52b@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Vetter, Daniel" <daniel.vetter@intel.com>,
 "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
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

> This is because of the fundamental concept of DMA-buf that the exporter
> needs to setup mappings (both CPU page tables as well as stuff like IOMMU).
> When the guest exports something it would mean that you give the guest
> control over the IOMMU and/or host page tables. And that is not something
> you can do as far as I can see.

Correct.

> You can only export stuff the other way around so that the host is providing
> the memory and the guest is consuming it. If I understand it correctly
> that's exactly what Gerd is suggesting here.

It can also work the other way around (guest allocating and host
consuming).  That is just an implementation detail.  The /important/
thing is that the driver which exports the dma-buf (and thus handles the
mappings) must be aware of the virtualization so it can properly
coordinate things with the host side.

So vdmabuf allocating and exporting dma-bufs works.

But vdmabuf importing dma-bufs doesn't because you can't ask the
exporter to create *host* mappings as Christian outlined above.  Sure,
you can try to sidestep the exporter, fish the list of pages out of the
scatter list and run with that.  That will explode as soon as you meet a
dma-buf which is not backed by pages in the first place.  And even for
page-backed dma-bufs you can run into trouble, for example due to
mapping pages with the wrong caching attributes.  Alternatively you can
double-buffer and copy data from the imported dma-buf to some
host-shared memory, but I guess you don't want that for performance
reasons ...

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
