Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC239C433E6
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 13:33:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF1B2245C
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 13:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF1B2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3C23862F4;
	Wed, 20 Jan 2021 13:33:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DSnf23No969G; Wed, 20 Jan 2021 13:33:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CE86186165;
	Wed, 20 Jan 2021 13:33:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD0BAC088B;
	Wed, 20 Jan 2021 13:33:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 144DFC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E300020410
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MZoLwXeTbE4v
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:33:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 00E7D203C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611149630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TuZhxXX0vx11B3Qj3wPxkPeJCMw+rTZdku7noaOiFM4=;
 b=XSA7EfN7vUqjqjuzrZYo6VdrQNeH6AoYH+KhryY/Wy2h62Xyj7QKjT13tjlvn0dx39+IFI
 gCZLS70oRtpyLKn+dB74SLMYT0QBBneNLk+0PrEPzkM3zmKdO5EDKxzxYGd08co/IBZtmI
 ATDLgGrepUDtOrYg7yBdDyY8hwuAPv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-Cf47LavbMFGCejYLZROe5w-1; Wed, 20 Jan 2021 08:33:48 -0500
X-MC-Unique: Cf47LavbMFGCejYLZROe5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AF84107ACE3;
 Wed, 20 Jan 2021 13:33:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 857A610023B6;
 Wed, 20 Jan 2021 13:33:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E6BAF18000B3; Wed, 20 Jan 2021 14:33:44 +0100 (CET)
Date: Wed, 20 Jan 2021 14:33:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Yiwei Zhang <zzyiwei@android.com>
Subject: Re: [PATCH v2] drm/virtio: Track total GPU memory for virtio driver
Message-ID: <20210120133344.7kln44nbwb5rjjgu@sirius.home.kraxel.org>
References: <CAKB3++adfpdBHFEyGZ3v2V6zyW+ayg86CLDRKx1ty+OytjYFNw@mail.gmail.com>
 <20210118234057.270930-1-zzyiwei@android.com>
 <CAKMK7uE+7S5q8bU0ibyepb8yQL3QYNjZE+Jwf13+bVfAmoSuhw@mail.gmail.com>
 <CAKB3++aNtrjzFoq4icMWSUvXw7bL69FRM+9t69firXHkiuTwDQ@mail.gmail.com>
 <YAfzxS95Yy86qnBi@phenom.ffwll.local>
 <CAKB3++ZYacAN2ZVSGGm0uEDQtowcS9LDPPYCqt6Pj+-WEFxMSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKB3++ZYacAN2ZVSGGm0uEDQtowcS9LDPPYCqt6Pj+-WEFxMSQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Android Kernel Team <kernel-team@android.com>
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

> > > > > +       select TRACE_GPU_MEM

> > > > > +#ifdef CONFIG_TRACE_GPU_MEM

That doesn't make sense btw.

> > > > > +#ifdef CONFIG_TRACE_GPU_MEM
> > > > > +static inline void virtio_gpu_trace_total_mem(struct virtio_gpu_device *vgdev,
> > > > > +                                             s64 delta)
> > > > > +{
> > > > > +       u64 total_mem = atomic64_add_return(delta, &vgdev->total_mem);
> > > > > +
> > > > > +       trace_gpu_mem_total(0, 0, total_mem);

Hmm, so no per process tracking (pid arg hard-coded to zero)?
Any plans for that?
The cgroups patches mentioned by Daniel should address that btw.

The gpu_id is hardcoded to zero too.  Shouldn't that be something like
the minor number of the drm device?  Or maybe something else in case you
need drm and non-drm gpu devices work side-by-side?

> > > Thanks for your reply! Android Cuttlefish virtual platform is using
> > > the virtio-gpu driver, and we currently are carrying this small patch
> > > at the downstream side. This is essential for us because:
> > > (1) Android has deprecated debugfs on production devices already

IIRC there have been discussions about a statfs, so you can export stats
with a sane interface without also enabling all the power provided by
debugfs, exactly because of the concerns to do that on production
systems.

Not sure what the state is, seems to not be upstream yet.  That would be
(beside cgroups) another thing to look at.

> > > Android relies on this tracepoint + eBPF to make the GPU memory totals
> > > available at runtime on production devices, which has been enforced
> > > already. Not only game developers can have a reliable kernel total GPU
> > > memory to look at, but also Android leverages this to take GPU memory
> > > usage out from the system lost ram.

Sounds like you define "gpu memory" as "system memory used to store gpu
data".  Is that correct?  What about device memory?

> > > I'm not sure whether the other DRM drivers would like to integrate
> > > this tracepoint(maybe upstream drivers will move away from debugfs
> > > later as well?), but at least we hope virtio-gpu can take this.

Well, it is basically the same for all drivers using the gem shmem
helpers.  So I see little reason why we should do that at virtio-gpu
level.

> Android GPU vendors have integrated this tracepoint to track gpu
> memory usage total(mapped into the gpu address space), which consists
> of below:
> (1) directly allocated via physical page allocator
> (2) imported external memory backed by dma-bufs
> (3) allocated exportable memory backed by dma-bufs

Hmm, the tracepoint doesn't track which of the three groups the memory
belongs to.  Which I think is important, specifically group (2) because
that might already be accounted for by the exporting driver ...

> Our Android kernel team is leading the other side of effort to help
> remove the dma-bufs overlap(those mapped into a gpu device) as a joint
> effort, so that we can accurately explain the memory usage of the
> entire Android system.

I suspect once you figured that you'll notice that this little hack is
rather incomplete.

> For virtio-gpu, since that's used by our reference platform
> Cuttlefish(Cloud Android), we have to integrate the same tracepoint as
> well to enforce the use of this tracepoint and the eBPF stuff built on
> top to support runtime query of gpu memory on production devices. For
> virtio-gpu at this moment, we only want to track GEM allocations since
> PRIME import is currently not supported/used in Cuttlefish. That's all
> we are doing in this small patch.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
