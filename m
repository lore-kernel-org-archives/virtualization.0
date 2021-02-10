Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF83C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 09:16:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E8364DD5
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 09:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E8364DD5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E68D986715;
	Wed, 10 Feb 2021 09:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-4l+g0T-3ff; Wed, 10 Feb 2021 09:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BC8BC866A3;
	Wed, 10 Feb 2021 09:16:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 809AAC0891;
	Wed, 10 Feb 2021 09:16:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 992D2C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 94E3687227
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 71f8tdRj76hl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:16:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F0C5887144
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 09:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612948609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KajS67I+i5BpKQ99uXSNDjgQPmQkOT9qLUWTp/ktN+o=;
 b=cd6GH2HE5uGBHOqAy3AqfVwBYdT2c71usiDKFdrs5aV2MvkiD5+qfC5XE24uQgOxD4ooon
 42j3sHSyhcvR2bp1kgz8uH+/cEFkDY7cMoLerBcWDmrOM5FOuVQ9RwLXqNMZ5ZdQv9gbhE
 vY0iSV68M9+AsHlg3s4oSoJ0ExmQL7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-1xqaUBcyOBi7KIZWJaDH_w-1; Wed, 10 Feb 2021 04:16:45 -0500
X-MC-Unique: 1xqaUBcyOBi7KIZWJaDH_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC397BBEE4;
 Wed, 10 Feb 2021 09:16:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-161.ams2.redhat.com
 [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B68C10016F6;
 Wed, 10 Feb 2021 09:16:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B59A418000AB; Wed, 10 Feb 2021 10:16:41 +0100 (CET)
Date: Wed, 10 Feb 2021 10:16:41 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Subject: Re: [RFC v3 2/3] virtio: Introduce Vdmabuf driver
Message-ID: <20210210091641.ahjtgcdalw7viuei@sirius.home.kraxel.org>
References: <20210203073517.1908882-1-vivek.kasireddy@intel.com>
 <20210203073517.1908882-3-vivek.kasireddy@intel.com>
 <YB1sRx1GrT8rATEg@phenom.ffwll.local>
 <20210208075748.xejgcb4il2egow2u@sirius.home.kraxel.org>
 <YCEGrrT0/eqqz/ok@phenom.ffwll.local>
 <8ba4ad64be3546bda9a2ed2129bf98e4@intel.com>
 <20210209084453.5oqepy7zdwtxgrpu@sirius.home.kraxel.org>
 <2ef01dc941684a15a4f30e6239ae42df@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ef01dc941684a15a4f30e6239ae42df@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

> > You don't have to use the rendering pipeline.  You can let the i915 gpu
> > render into a dma-buf shared with virtio-gpu, then use virtio-gpu only for
> > buffer sharing with the host.
> [Kasireddy, Vivek] Is this the most viable path forward? I am not sure how complex or 
> feasible it would be but I'll look into it.
> Also, not using the rendering capabilities of virtio-gpu and turning it into a sharing only
> device means there would be a giant mode switch with a lot of if() conditions sprinkled
> across. Are you OK with that?

Hmm, why a big mode switch?  You should be able to do that without
modifying the virtio-gpu guest driver.  On the host side qemu needs
some work to support the most recent virtio-gpu features like the
buffer uuids (assuming you use qemu userspace), right now those
are only supported by crosvm.

It might be useful to add support for display-less virtio-gpu, i.e.
"qemu -device virtio-gpu-pci,max_outputs=0".  Right now the linux
driver throws an error in case no output (crtc) is present.  Should
be fixable without too much effort though, effectively the sanity
check would have to be moved from driver initialization to commands
like SET_SCANOUT which manage the outputs.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
