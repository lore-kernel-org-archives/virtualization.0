Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC85C64ED8
	for <virtualization@archiver.kernel.org>; Mon, 27 Feb 2023 18:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EE8781F0B;
	Mon, 27 Feb 2023 18:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EE8781F0B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=lYckM1IR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T_yZyc0w9k3V; Mon, 27 Feb 2023 18:15:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B766381EFE;
	Mon, 27 Feb 2023 18:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B766381EFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 986F8C0033;
	Mon, 27 Feb 2023 18:15:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8FA3C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 18:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 797254179F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 18:15:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 797254179F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=lYckM1IR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xydzNcRclHvG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 18:15:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FEA94179C
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FEA94179C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 18:15:46 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1720600a5f0so8262201fac.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Feb 2023 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kthqGc9HV1+cBVD65tJGeV3icobdW/IXIZ0JuA3FrL8=;
 b=lYckM1IRs9rKTPJansQK12xCrzQqLHSEAEz0U8EQZ5KlEC2GYtPE1Q68T+2aD+Z2/N
 Yg4gtNSULCKaJIHLZV1iFIDGXhEERqdg7mZaQCpKVWD86OIDc20uQDvbtvsZ1wxBh8DR
 vq8RnC5zPZw4yiF8ETZEJDSAxogkEBUchv5yKkf3Rnd14QbEp1u2tlU44b1WkI/r+Lln
 L1ZwoQIlfV8UjJ/VHMAwZPSmY7w5udoGEIlXEYX5F2lqCTE7tKa5b7JxCmKiI8jbKnfY
 D5jZ+prKhJizeyRPaKSIhmuK7T5aTPyFGtx3cX5r2WWV5yJVb738V79OsOPbmVCB2ZfT
 49+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kthqGc9HV1+cBVD65tJGeV3icobdW/IXIZ0JuA3FrL8=;
 b=p/Egmt42gHdMHHNzhxWLmS5aKQcASrffGNea8Hez0/FgMnwwl4fkjczYsQjgeIncJo
 9k/QJVznS8ma1s3+crhEexmZAkngWatFvXx6OX4dCyMWymuvo2drB1mL/28sYar15FPW
 ASEBoP/85+X09sybgRnL1g/hrOz0pCmGetdw2EY3E1w+tb868J+5xCJgEB/LrAATLRKd
 j03Y/kFWds+q8TfLlqFDfMZdaLwVjfGM/4M8P0++Dg1yC+bn2b8v/atd2ZzL66Y9eZ28
 stLLUPCWbZWJU2GdiRqpYPnM31c4cOAxGkd8drskjGDE5ObVlG7L/qNcsBk+0clPFV67
 Rx4w==
X-Gm-Message-State: AO0yUKXhanX45jYVxmcmfTDIMp0aZBblPhxseqFdCpVbSYjwLLy12nQm
 zmRF3ORCVGcfNkqM4sUP54MGDzYNcFmw9PMvt6M=
X-Google-Smtp-Source: AK7set+Ri0pJ646Cs1O36dk7bj0CewKmdMpJW7Ni/DCBcjC1K4lZ/4qSxJJbnKDXx/oHOUK7tOnbal73p58uN1fK7R4=
X-Received: by 2002:a05:6870:5b0a:b0:172:6f4:dcdf with SMTP id
 ds10-20020a0568705b0a00b0017206f4dcdfmr3879299oab.3.1677521746056; Mon, 27
 Feb 2023 10:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20230227173800.2809727-1-robdclark@gmail.com>
 <44e67d88-fce6-a1c1-79a9-a937e64a32bb@collabora.com>
In-Reply-To: <44e67d88-fce6-a1c1-79a9-a937e64a32bb@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 27 Feb 2023 10:15:34 -0800
Message-ID: <CAF6AEGsT8_o+v0vzGu1nyh6Z82pj8FnGUdMFc0Lq+4OWoSjRBQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/virtio: Add option to disable KMS support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
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

On Mon, Feb 27, 2023 at 9:57 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 2/27/23 20:38, Rob Clark wrote:
> ...
> > +     if (IS_ENABLED(CONFIG_DRM_VIRTIO_GPU_KMS)) {
> > +             /* get display info */
> > +             virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
> > +                             num_scanouts, &num_scanouts);
> > +             vgdev->num_scanouts = min_t(uint32_t, num_scanouts,
> > +                                         VIRTIO_GPU_MAX_SCANOUTS);
> > +             if (!vgdev->num_scanouts) {
> > +                     /*
> > +                      * Having an EDID but no scanouts is non-sensical,
> > +                      * but it is permitted to have no scanouts and no
> > +                      * EDID (in which case DRIVER_MODESET and
> > +                      * DRIVER_ATOMIC are not advertised)
> > +                      */
> > +                     if (vgdev->has_edid) {
> > +                             DRM_ERROR("num_scanouts is zero\n");
> > +                             ret = -EINVAL;
> > +                             goto err_scanouts;
> > +                     }
> > +                     dev->driver_features &= ~(DRIVER_MODESET | DRIVER_ATOMIC);
>
> If it's now configurable by host, why do we need the
> CONFIG_DRM_VIRTIO_GPU_KMS?

Because a kernel config option makes it more obvious that
modeset/atomic ioctls are blocked.  Which makes it more obvious about
where any potential security issues apply and where fixes need to get
backported to.  The config option is the only thing _I_ want,
everything else is just a bonus to help other people's use-cases.

BR,
-R
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
