Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D3BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 20:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 550C881277;
	Tue, 22 Feb 2022 20:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-ZbOiiVU6G2; Tue, 22 Feb 2022 20:54:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E0E2C80F05;
	Tue, 22 Feb 2022 20:54:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC3A0C001A;
	Tue, 22 Feb 2022 20:54:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0935DC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 20:54:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDCDF402E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 20:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n0eTZQBXBejL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 20:54:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3A4B402C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 20:54:46 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id s14so22538921edw.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SPRBbHRt1jN0bCazBjflxzkMQpBKCrhFsjWbB/Pd2ho=;
 b=d8byAmakXv8TUEk2D3GwlOKX2veEXZG3SWc2Oaanly7GJmSflwIsHiwmAW1Aa2txaX
 AKK3+3n03VecgUvTM1Mi6rNS8aDHCmfVQUJmMiUpE3pmhqDMi+B2xRts9mbJUecdnSbG
 KGIw6911dhsDhVjGLJH1evW17Ycoey+JUh5TO5i48ZRTiLmNOEyzz+TLFuAFVvZ2Enru
 kcmQF9MsPyqrsrMAJOYwyxeyvnskKlFZOzZDgvFJ3RCeQgzMJDZq/ERMFqADAO/5UoLh
 /E8cANGceNrsLPHdXEmGExgir+nUUx1gz+ICKFUCpYPEkJmMkDm7rtspo1sVW7ettc9Q
 y5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SPRBbHRt1jN0bCazBjflxzkMQpBKCrhFsjWbB/Pd2ho=;
 b=faTkuQFXp5DV9M+LLJxefVijphNLejKqtyEcBXxYEkxGCwb7/rwx0+D4tCv81gc6Fr
 GAIS1NPX1K6LxBZglHLYSKDFBfJjh79fK6MGiiI41UuogHI5evmBmWrJcknjZeoUbhdL
 FVDPuaL1D+s3FNyXdhe7l1DL/W6FXIqEyXWdRWd2xtq7QIg63/QV4r19oWL3a+bcMNZH
 1kvLR9pyAgR+Xjd8KIiq6FnyhIH+tyZzJQEQ/ojg3rSEHSf7J0CvZdAFtCUU2iIXnjmd
 qTosOxep7JK+HzssJe2OUdKb9daDm8gtDMVO0hdwGOK93osbU6+hJe1b7otFdqeXVpSa
 t9pg==
X-Gm-Message-State: AOAM532YnjDj1EzRimCQzv7vVpgv4R3312/gCQauHdSzc1ONam0WgCoO
 7kwgDmlam4CFMTUuIkAXYAH87NeL4MhopkmrFq8=
X-Google-Smtp-Source: ABdhPJwdHuLXrwIwpdBJAf4/39epc/M85MPWl0qEVJog5KwT3yV9aX9Lv1vppSRgkpo7O6i4fZ7LtUt34SnQcTuhQQI=
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id
 ds1-20020a0564021cc100b004132b12fc49mr3663984edb.118.1645563285075; Tue, 22
 Feb 2022 12:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20220218155725.487785-1-robdclark@gmail.com>
 <CAPaKu7R+6g9XRzWPk-u0jKWa602z6CJVxhPqgjJPipzY=S-txA@mail.gmail.com>
 <CAF6AEGtrQ7rcK6sEbiaHa72cebGbrdS0RNS22T07XQwCM2sQ0g@mail.gmail.com>
In-Reply-To: <CAF6AEGtrQ7rcK6sEbiaHa72cebGbrdS0RNS22T07XQwCM2sQ0g@mail.gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 22 Feb 2022 12:54:34 -0800
Message-ID: <CAPaKu7TqRBQ6_v2nKCTsc4OySOSeK9_kzKK=HfALL_42qU2WnQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Add USE_INTERNAL blob flag
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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

On Fri, Feb 18, 2022 at 9:51 AM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Feb 18, 2022 at 8:42 AM Chia-I Wu <olvaffe@gmail.com> wrote:
> >
> > On Fri, Feb 18, 2022 at 7:57 AM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > With native userspace drivers in guest, a lot of GEM objects need to be
> > > neither shared nor mappable.  And in fact making everything mappable
> > > and/or sharable results in unreasonably high fd usage in host VMM.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > > This is for a thing I'm working on, a new virtgpu context type that
> > > allows for running native userspace driver in the guest, with a
> > > thin shim in the host VMM.  In this case, the guest has a lot of
> > > GEM buffer objects which need to be neither shared nor mappable.
> > >
> > > Alternative idea is to just drop the restriction that blob_flags
> > > be non-zero.  I'm ok with either approach.
> > Dropping the restriction sounds better to me.
> >
> > What is the use case for such a resource?  Does the host need to know
> > such a resource exists?
>
> There are a bunch of use cases, some internal (like visibility stream
> buffers filled during binning pass and consumed during draw pass),
> some external (tiled and/or UBWC buffers are never accessed on the
> CPU).
For these use cases, it's true that userspace might want internal bos,
and serialize them as res_ids which the host maps to host gem_handles.
But userspace can also skip the internal bos and encode host
gem_handles directly.

But the kernel probably should not dictate what the userspace should
do by requiring non-zero blob flags.

>
> In theory, at least currently, drm/virtgpu does not need to know about
> them, but there are a lot of places in userspace that expect to have a
> gem handle.  Longer term, I think I want to extend virtgpu with
> MADVISE ioctl so we can track DONTNEED state in guest and only release
> buffers when host and/or guest is under memory pressure.  For that we
> will defn need guest side gem handles
MADVICE is a hint that userspace sets and is not based on memory
pressure.  It is the receivers of the hint who take actions when under
memory pressure.  I think it can be between the guest userspace and
the host?


>
> BR,
> -R
>
> > >
> > >  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 7 ++++++-
> > >  include/uapi/drm/virtgpu_drm.h         | 1 +
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > > index 69f1952f3144..92e1ba6b8078 100644
> > > --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> > > @@ -36,7 +36,8 @@
> > >
> > >  #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
> > >                                     VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
> > > -                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
> > > +                                   VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
> > > +                                   VIRTGPU_BLOB_FLAG_USE_INTERNAL)
> > >
> > >  static int virtio_gpu_fence_event_create(struct drm_device *dev,
> > >                                          struct drm_file *file,
> > > @@ -662,6 +663,10 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
> > >         params->size = rc_blob->size;
> > >         params->blob = true;
> > >         params->blob_flags = rc_blob->blob_flags;
> > > +
> > > +       /* USE_INTERNAL is local to guest kernel, don't past to host: */
> > > +       params->blob_flags &= ~VIRTGPU_BLOB_FLAG_USE_INTERNAL;
> > > +
> > >         return 0;
> > >  }
> > >
> > > diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
> > > index 0512fde5e697..62b7483e5c60 100644
> > > --- a/include/uapi/drm/virtgpu_drm.h
> > > +++ b/include/uapi/drm/virtgpu_drm.h
> > > @@ -163,6 +163,7 @@ struct drm_virtgpu_resource_create_blob {
> > >  #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
> > >  #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
> > >  #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> > > +#define VIRTGPU_BLOB_FLAG_USE_INTERNAL     0x0008   /* not-mappable, not-shareable */
> > >         /* zero is invalid blob_mem */
> > >         __u32 blob_mem;
> > >         __u32 blob_flags;
> > > --
> > > 2.34.1
> > >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
