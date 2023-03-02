Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279A7C678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 07:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3B3341A52;
	Thu,  2 Mar 2023 07:25:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3B3341A52
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GQoAXgAU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OLo4tckCUFcC; Thu,  2 Mar 2023 07:25:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0B6B441772;
	Thu,  2 Mar 2023 07:25:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B6B441772
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB9DAC0071;
	Thu,  2 Mar 2023 07:25:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8576C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 07:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B097260A6D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 07:25:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B097260A6D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GQoAXgAU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CcYo7HKkAfog
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 07:25:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3F7B60C01
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3F7B60C01
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 07:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677741937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iUNoRnZ2khkkla6l3VKfRN3P5S1CmE7QZ6Fs397Sj+8=;
 b=GQoAXgAUOG7tRlXLv6t6c+mcYkCKJPz2OXb5l3ulPLZt2vg7IBPbbfqwDlJ7rNlZgoYq7u
 rnHl3WbuFmoUEHtLmd2BDjwoK4BiSatV1XMixVjtppi0/pJKeKMVjFALPEwXCfv6lLbSlj
 omazrzyqIS9Ze+f9x0vVAAwZnD2SeE4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-Es-Toy1WPRu27aB2s7YMkw-1; Thu, 02 Mar 2023 02:25:33 -0500
X-MC-Unique: Es-Toy1WPRu27aB2s7YMkw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E787538041C1;
 Thu,  2 Mar 2023 07:25:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 986A7492C3E;
 Thu,  2 Mar 2023 07:25:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3CED71800084; Thu,  2 Mar 2023 08:25:31 +0100 (CET)
Date: Thu, 2 Mar 2023 08:25:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v5] drm/virtio: Add option to disable KMS support
Message-ID: <20230302072531.375i6xetk72nis75@sirius.home.kraxel.org>
References: <20230301185432.3010939-1-robdclark@gmail.com>
 <6eb2cde8-f548-73ba-6091-131c1848690c@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6eb2cde8-f548-73ba-6091-131c1848690c@collabora.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Rob Clark <robdclark@gmail.com>,
 Ryan Neph <ryanneph@chromium.org>, David Airlie <airlied@redhat.com>,
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

On Thu, Mar 02, 2023 at 12:39:33AM +0300, Dmitry Osipenko wrote:
> On 3/1/23 21:54, Rob Clark wrote:
> >  /* virtgpu_display.c */
> > +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
> >  int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
> >  void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
> > +#else
> > +static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> > +{
> > +	return 0;
> > +}
> > +static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
> > +{
> > +}
> > +#endif
> 
> In v4 Gerd wanted to keep building the virtgpu_display.o and instead add
> the KSM config check to virtio_gpu_modeset_init/fini().

The main point is that the code workflow should be the same in both
cases.  The patch does that for virtio_gpu_modeset_init() but doesn't
for virtio_gpu_modeset_fini().

Return early in the functions (and drop the #ifdef here) is how I would
implement this, but I wouldn't insist on that, there are other ways to
solve this too ;)

take care,
  Gerd

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
