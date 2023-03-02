Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0EEC678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 23:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D4DE612C4;
	Thu,  2 Mar 2023 23:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D4DE612C4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=lN4O5IHR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8wdB8RdYwLB; Thu,  2 Mar 2023 23:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B66AA60EAA;
	Thu,  2 Mar 2023 23:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B66AA60EAA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82750C0035;
	Thu,  2 Mar 2023 23:33:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CD96C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 23:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 342A681313
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 23:33:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 342A681313
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=lN4O5IHR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FmyZNHfS1kue
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 23:33:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 542508130D
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 542508130D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 23:33:19 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-17638494edbso1158178fac.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 15:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1677799998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oWQrOjmlTF/eT/5hix+xLxcrGdhqmVIvOhIR8FuYfOE=;
 b=lN4O5IHRLWyhbSMEcD8F0G8wFR8QiH6oGXMFIJfZTiCWkg7XROh8F8SsG/qP0wNKCe
 d4SHivhy9etlsWR1U8y5/kMeCRe8w5lHrcTALEy7lbd6LtUv2lYr32C/yjBI4Gf+xlRb
 enRjQMho94lsdGs00WCpvhX4YXlG/IKd+cnt/3dPJJzUOPV6ot6s1+Tu7m52rbzbSFOM
 IHkdVS8emNIuPxontdSocYsaudiDw1/JD6xcBFcyOir5AKQ3D0A2Hoo+ANqSynw/aWPv
 hgy4aQjOmZcJf6UXNp1wRnvRFN0iy1L1vtJ45ZNmf+AUo6Z2CGemofvuhFDkPKIHs2k+
 V6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677799998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWQrOjmlTF/eT/5hix+xLxcrGdhqmVIvOhIR8FuYfOE=;
 b=L2XMiww8qcnNz3fJdsjRtfZaHltbwzEH6SvCxSW5ZxL8jXao+DfZrK/l+I9Qe3GomY
 xKQ2sdazesPmegdKtCJfRwoutxJMnokV3yz03ix+8r1UaR7aM0cDlrDu1iznH7hPAK10
 aBZ+DXohbwZiK9FADUJoStNJaT0R6c842S71AeWb5nwqusLZGBIhLpl/CwDHBeIFMiqG
 AW49pc8LHvqWW4xGuNhimoi/SLSN98btjK0XHJ3ue1Ak8HtzYcabWhc+xNWBhk5bboL0
 6FNLyn4IbwLKMg/XnXEgd2nYbOIQLCBYSbLNGbkT2Ri1FwFsqzdA/a/uDbSkoX8l2271
 M01g==
X-Gm-Message-State: AO0yUKUO/8Mt1pKdX0hn6+MByQ+Vw625Wny0Lkc2tXsEMiJLkfig9Xj6
 x1i8ON4TpTohmDn/8GNhDKDzAGuGxAQWYgW61UE=
X-Google-Smtp-Source: AK7set8T8UHOZvlKDyCHvWaZjZeVjVEqLrtjJRHYusFiiklAQLDMFXAgieBae3bnu4+f7KLJ3bIMqyww1KsFqKWgDSk=
X-Received: by 2002:a05:6871:6ba1:b0:176:6af1:1122 with SMTP id
 zh33-20020a0568716ba100b001766af11122mr31222oab.3.1677799998081; Thu, 02 Mar
 2023 15:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20230301185432.3010939-1-robdclark@gmail.com>
 <6eb2cde8-f548-73ba-6091-131c1848690c@collabora.com>
 <20230302072531.375i6xetk72nis75@sirius.home.kraxel.org>
In-Reply-To: <20230302072531.375i6xetk72nis75@sirius.home.kraxel.org>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 2 Mar 2023 15:33:07 -0800
Message-ID: <CAF6AEGtzdty5m9ccRZqYNN=+OCa0KogNQxR41AD-LWC5fjbujw@mail.gmail.com>
Subject: Re: [PATCH v5] drm/virtio: Add option to disable KMS support
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Rob Clark <robdclark@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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

On Wed, Mar 1, 2023 at 11:25 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Mar 02, 2023 at 12:39:33AM +0300, Dmitry Osipenko wrote:
> > On 3/1/23 21:54, Rob Clark wrote:
> > >  /* virtgpu_display.c */
> > > +#if defined(CONFIG_DRM_VIRTIO_GPU_KMS)
> > >  int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev);
> > >  void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev);
> > > +#else
> > > +static inline int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
> > > +{
> > > +   return 0;
> > > +}
> > > +static inline void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
> > > +{
> > > +}
> > > +#endif
> >
> > In v4 Gerd wanted to keep building the virtgpu_display.o and instead add
> > the KSM config check to virtio_gpu_modeset_init/fini().
>
> The main point is that the code workflow should be the same in both
> cases.  The patch does that for virtio_gpu_modeset_init() but doesn't
> for virtio_gpu_modeset_fini().
>
> Return early in the functions (and drop the #ifdef here) is how I would
> implement this, but I wouldn't insist on that, there are other ways to
> solve this too ;)

Ahh, true, I guess omitting that one file doesn't save anything and
early return makes for a bit simpler/smaller patch

BR,
-R
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
