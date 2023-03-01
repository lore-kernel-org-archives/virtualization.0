Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138E1C64EC7
	for <virtualization@archiver.kernel.org>; Wed,  1 Mar 2023 05:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 978C941608;
	Wed,  1 Mar 2023 05:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 978C941608
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HbzrjoxD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4k_upEjIpfR7; Wed,  1 Mar 2023 05:50:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BE1D4160A;
	Wed,  1 Mar 2023 05:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BE1D4160A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 092B4C0077;
	Wed,  1 Mar 2023 05:50:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB2ABC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 05:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 920844160A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 05:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 920844160A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J4V71ANYig9x
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 05:50:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2340D41675
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2340D41675
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Mar 2023 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677649811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckGumOJdLFih87T5un7JUmXQL9qObNSTxVhiK7Kwu5M=;
 b=HbzrjoxDIJLiVGrOIEejdFwF2gD10ZA3Quu30Uo4IJhfCDOofj485KOPjXesCqx9Rri2nD
 ZtTFXhdzOs7+yMDUQ03l2kBncXmwGdCEtrWCguZIfFW14ZpWFSSew4qAzws+Rkl822xUpu
 I/Ae3fcGmQ+qt4tY9hpP6s5h4s2NHk4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-qUFLjPVjMimadptElzBKVw-1; Wed, 01 Mar 2023 00:50:07 -0500
X-MC-Unique: qUFLjPVjMimadptElzBKVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94DC180D104;
 Wed,  1 Mar 2023 05:50:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B6C62166B26;
 Wed,  1 Mar 2023 05:50:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 50B7C180309B; Wed,  1 Mar 2023 06:50:03 +0100 (CET)
Date: Wed, 1 Mar 2023 06:50:03 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4] drm/virtio: Add option to disable KMS support
Message-ID: <20230301055003.ondht4o2ojajxt74@sirius.home.kraxel.org>
References: <20230228155406.2881252-1-robdclark@gmail.com>
 <583bf774-5594-5553-f5e2-45ccf7babff7@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <583bf774-5594-5553-f5e2-45ccf7babff7@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: Rob Clark <robdclark@chromium.org>, Ryan Neph <ryanneph@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@redhat.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

On Wed, Mar 01, 2023 at 03:37:24AM +0300, Dmitry Osipenko wrote:
> On 2/28/23 18:54, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Add a build option to disable modesetting support.  This is useful in
> > cases where the guest only needs to use the GPU in a headless mode, or
> > (such as in the CrOS usage) window surfaces are proxied to a host
> > compositor.
> > 
> > As the modesetting ioctls are a big surface area for potential security
> > bugs to be found (it's happened in the past, we should assume it will
> > again in the future), it makes sense to have a build option to disable
> > those ioctls in cases where they serve no legitimate purpose.
> > 
> > v2: Use more if (IS_ENABLED(...))
> > v3: Also permit the host to advertise no scanouts
> > v4: Spiff out commit msg
> > 
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> 
> Gerd, to give you some context on the v4.. we've chatted a bit more on
> the #dri-devel and concluded that config option is the most robust way
> of having KMS disabled from a security stand point. We would also want
> to have a per-driver option (and not global) because there are scenarios
> of using passthrough GPU + virtio-gpu in a guest, hence we would only
> want to toggle KMS for a particular driver.

IMHO both ways options to disable the KMS bits should work the same way.
With the current patch modeset_init() runs with num_scanouts == 0 but
doesn't with CONFIG_KMS=n.  There are also two different ways to tweak
driver_features.  Can we get rid of that please, for robustness reasons?

I'd suggest to have a is_kms_enabled() helper function (probably best as
inline so gcc can figure it is constant false for CONFIG_KMS=n and throw
away unreachable code).  Add "if (!is_kms_enabled()) return;" to
modeset_init() and modeset_fini() instead of stubbing them out.  Use the
drm_device->driver_features override in both cases.

Also the edid check can go away.  As already mentioned this is about a
device feature not a edid being present.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
