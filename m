Return-Path: <SRS0=ygFP=HO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF54C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 11:01:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401D464E70
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 11:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401D464E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05CD06F614
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 11:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LF1eAKtGRW6G for <virtualization@archiver.kernel.org>;
	Fri, 12 Feb 2021 11:01:56 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 3576C6F66A; Fri, 12 Feb 2021 11:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE8566F5D3;
	Fri, 12 Feb 2021 11:01:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2937C0174;
	Fri, 12 Feb 2021 11:01:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7E46C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 11:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8D3B587266
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 11:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1s8RQxjFhNAZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 11:01:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7CC068706B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 11:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613127707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Gx/mG4h1X8FM7fWz9h2H0rRVjTdjgBag2KkGy2ksa4=;
 b=a936kLDHkqiLjLcwxBJvrNHUMlmLzZdP8Fnjge8SbivYNITkB94rR6cC+URVa8bf4XmrVD
 pDvqQj3Xi3v7lfH6Rj5MLv8ow0ZkqiGQyJkMWdRz/4iqEvfhN3qsYTX1Ucttqv4TC7B77+
 r8qa/ZDOzRM4yYpZZ4QghBbiVjrgTPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-lNMjW9KBPxa8Yl5DPST9Qw-1; Fri, 12 Feb 2021 06:01:45 -0500
X-MC-Unique: lNMjW9KBPxa8Yl5DPST9Qw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF2A2801965;
 Fri, 12 Feb 2021 11:01:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-161.ams2.redhat.com
 [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5255A5C3FD;
 Fri, 12 Feb 2021 11:01:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C438918003AF; Fri, 12 Feb 2021 12:01:40 +0100 (CET)
Date: Fri, 12 Feb 2021 12:01:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Subject: Re: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Message-ID: <20210212110140.gdpu7kapnr7ovdcn@sirius.home.kraxel.org>
References: <20210203073517.1908882-1-vivek.kasireddy@intel.com>
 <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
 <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
 <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
 <8ba4ad64be3546bda9a2ed2129bf98e4@intel.com>
 <20210209084453.5oqepy7zdwtxgrpu@sirius.home.kraxel.org>
 <2ef01dc941684a15a4f30e6239ae42df@intel.com>
 <20210210091641.ahjtgcdalw7viuei@sirius.home.kraxel.org>
 <bad576177eb24085a73570e8ad03d2cc@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bad576177eb24085a73570e8ad03d2cc@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
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

On Fri, Feb 12, 2021 at 08:15:12AM +0000, Kasireddy, Vivek wrote:
> Hi Gerd,
> 
> > > > You don't have to use the rendering pipeline.  You can let the i915
> > > > gpu render into a dma-buf shared with virtio-gpu, then use
> > > > virtio-gpu only for buffer sharing with the host.
> [Kasireddy, Vivek] Just to confirm my understanding of what you are suggesting, are
> you saying that we need to either have Weston allocate scanout buffers (GBM surface/BO)
> using virtio-gpu and render into them using i915; or have virtio-gpu allocate pages and 
> export a dma-buf and have Weston create a GBM BO by calling gbm_bo_import(fd) and
> render into the BO using i915?

Not sure what the difference between the former and the latter is.

> > Hmm, why a big mode switch?  You should be able to do that without modifying the
> > virtio-gpu guest driver.  On the host side qemu needs some work to support the most
> > recent virtio-gpu features like the buffer uuids (assuming you use qemu userspace), right
> > now those are only supported by crosvm.
> [Kasireddy, Vivek] We are only interested in Qemu UI at the moment but if we were to use
> virtio-gpu, we are going to need to add one more vq and support for managing buffers, 
> events, etc.

Should be easy and it should not need any virtio-gpu driver changes.

You can use virtio-gpu like a dumb scanout device.  Create a dumb
bo, create a framebuffer for the bo, map the framebuffer to the crtc.

Then export the bo, import into i915, use it as render target.  When
rendering is done flush (DRM_IOCTL_MODE_DIRTYFB).  Alternatively
allocate multiple bo's + framebuffers and pageflip.

Pretty standard workflow for cases where rendering and scanout are
handled by different devices.  As far I know not uncommon in the arm
world.

Right now this will involve a memcpy() for any display update because
qemu is a bit behind on supporting recent virtio-gpu features.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
