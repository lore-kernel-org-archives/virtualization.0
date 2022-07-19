Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686FBC433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Jul 2022 10:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE2C44109E;
	Tue, 19 Jul 2022 10:31:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE2C44109E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h63D6aj5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HRN2l1E1YSq; Tue, 19 Jul 2022 10:31:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C711940903;
	Tue, 19 Jul 2022 10:31:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C711940903
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9027AC0033;
	Tue, 19 Jul 2022 10:31:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DBF7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 10:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42A534109E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 10:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42A534109E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cnjgloGvMc-D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 10:31:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F81F40903
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F81F40903
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 10:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658226682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pulf+GTQxk5uin6YUOuCzeis2FI3CtuvGLbmZk5/0oY=;
 b=h63D6aj5gTLJX/X1wLLG07Csoo65t6QHxJGH4TC+Z6Tn0SCZUlPux+GlpS2SzxbRzdZNoY
 Jkf8zLO3OpWf06++QB2Isu5dOVHVu1tYQ7DZFHzBcyACRH0bZwdFZFzlQy/eUo72y2PEr/
 NFQC5hBCLuGS+B/wG0GpqX1mNM//Ed4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-Quqbb-BjMrWIOgrgNYImrA-1; Tue, 19 Jul 2022 06:31:08 -0400
X-MC-Unique: Quqbb-BjMrWIOgrgNYImrA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AC8F8039A2;
 Tue, 19 Jul 2022 10:31:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0460492C3B;
 Tue, 19 Jul 2022 10:31:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 62DE21800098; Tue, 19 Jul 2022 12:31:06 +0200 (CEST)
Date: Tue, 19 Jul 2022 12:31:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
Message-ID: <20220719103106.gttro4tjjbis6pgg@sirius.home.kraxel.org>
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com>
 <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com>
 <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
 <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
 <20220706071301.43fvbioka4iksqup@sirius.home.kraxel.org>
 <05a5608b-899d-71de-a7d7-406334c5604b@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <05a5608b-899d-71de-a7d7-406334c5604b@collabora.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Cc: David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
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

On Wed, Jul 06, 2022 at 10:22:52AM +0300, Dmitry Osipenko wrote:
> On 7/6/22 10:13, Gerd Hoffmann wrote:
> >   Hi,
> > 
> >> Gerd, thank you very much! It's was indeed unclear to me how to test the
> >> MMIO GPU, but yours variant with microvm works! I was looking for trying
> >> aarch64 in the past, but it also was unclear how to do it since there is
> >> no DT support for the VirtIO-GPU, AFAICS.
> > 
> > aarch64 uses acpi by default (can be disabled via 'qemu -no-acpi').
> > Not fully sure about arm(v7).
> > 
> > Even with DT it should work because DT only describes the virtio-mmio
> > 'slots', not the actual virtio devices.
> > 
> >> There is no virgl support because it's a virtio-gpu-device and not
> >> virtio-gpu-device-gl that is PCI-only in Qemu. Hence everything seems good.
> > 
> > It's named 'virtio-gpu-gl-device'
> 
> Ah, thanks again! Just quickly tested virtio-gpu-gl-device and
> everything works too for MMIO GPU on microvm, including virgl and Xorg
> (glamor).
> 
> [drm] features: +virgl +edid -resource_blob -host_visible
> [drm] features: -context_init
> [drm] number of scanouts: 1
> [drm] number of cap sets: 2
> [drm] cap set 0: id 1, max-version 1, max-size 308
> [drm] cap set 1: id 2, max-version 2, max-size 696
> [drm] Initialized virtio_gpu 0.1.0 0 for LNRO0005:01 on minor 0
> virtio-mmio LNRO0005:01: [drm] drm_plane_enable_fb_damage_clips() not called

Cool.  Havn't found the time to try s390x, so I'm taking that as good
enough test that we don't have any unnoticed dependencies on pci.

Queued up.  I'll go over a few more pending patches, and assuming no
issues show up in testing this should land in drm-misc-next in a few
hours.

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
