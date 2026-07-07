Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B037A49D
	for <virtualization@lists.linux.dev>; Tue,  7 Jul 2026 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450880; cv=pass; b=lISc/QF/bzdbursf2V2CvwCsGON9xc1uopbmOP1zXCr0POZRgefpxc8MiCnkubqZBXAB5NcwGvfBd1RprUk0ZYCr7MZgq14HW++eRNCKl9wxUoSIgo/7swM9b1xnmvcRSM/hkQ8NFKUsvhHTyQ02Ua/fLT3nfew45btV3cUFsnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450880; c=relaxed/simple;
	bh=9YILv/b/wrOOopqIQNr3zYUi1Tt5X2/kqpJzZKHDvvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMTvkW+hD9lybSDA0KhNFxIFHraKkJsQ+wj7Kylw6VjSduMK610AnSvSWwLZ/QIy/LVF8dHxgVrPObRluQHC7hXk7g2X0GP9BQw3jNJdQTD/joJTSyDZKgrUPblS2TL/MzvCRCLocjCjnzMAa/Ue7YhkARmEDLmvU4K8Z393ALM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnE7pRMv; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnE7pRMv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cab97c86bdso18745ad.1
        for <virtualization@lists.linux.dev>; Tue, 07 Jul 2026 12:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783450878; cv=none;
        d=google.com; s=arc-20260327;
        b=SqivB0uX8depMM+imdtoC05RTPtXFR4tQiQdBeJ8eJ78dt45ydXrrzbY+WEw2Zmpaz
         nc8F7txH8545JN35YjiqNVat8MczQG9U4PngKLdOjy1JsGeWsgp4ZIL1XA/3ddHOkRV/
         axtPAFpCP+xjEHatbDGPGSeKMzFI6QhCaoG8YBr/2EVwZ3Sfi+g778rbhLVgFRFS4wII
         eGsXqWNLK5YvMHbWRdA1O2181JCMLC+Axn5QApPO6vz4vmMungu+Zx7WsLeso8CV0wk9
         9OXZGDbfG4cl/j3s3dIc8ZGEKzJKw2q/0HcOwSfs5Z3ff71h+CH1WhSplMZc+NF8GJUB
         23/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
        fh=ceU6uYGI4ywc0djIj/+XC0sz44aYTxC9kccatC2p9TE=;
        b=fJBwS7oaCEc1TRa6SXl20lzEnaTpMKw2zu9IPgeEGR38Bzb0MBEe8s6KfMP8nV/qEg
         7DxKRsxj3uXV2KNvHQ+bP21PPFQXawY2n46dlrNZ3ZtvPIQ7X1Uai3IsApF2OMVR7sO6
         OzwsJvAbLNWuanPFNusl2vb9rCgAijC5A8p6f5tuTTN25+LHCHc+feTvak5AJD7GRt8t
         DWG45v58+0Cgk1BVXugQFZ5Elg5UNyJUIhjT6fEmuKA87Jcwt1OQ2Y5Fnw4HCqHri3DU
         ce4LspL1QCK3DykeEL5WQtf2VMAeC/yJWg60hFKm2qOTiGKxEqj2pp9/a1PT8gpfMBu5
         VNsA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783450878; x=1784055678; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
        b=tnE7pRMvDu+SJGfwSG/ZmxgEYpqSqHwUbYm0tIDo54Mfhk5+xfZGJrygGOsjf5b24l
         PV7e5i9FlDuJnXsNpV1rmAxk9ocMz2ay/IkNsBLys9xj3q2p6PMpLTeYzr2pCULiegBb
         Y+F0GtNz58xbCSpC76h1B2IKejaO1GkfzvGwLfW0n+CwtAn9UEOeYoZ5mEZoT3Hlf/30
         l7BVzFdsUsl45ZuMJjwIX/VI8dWVtGCsdvRzCCPH1P5+d7FY3v6wtCHgVy21FEmgZtEt
         5n5IMoGK+Fo820huHqfC6KILypA0EKqgqaLXM+/lu52vIzl4+8ie9o3R2s36NqZzrfrv
         VScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450878; x=1784055678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gEkOp0eGJJxoxP/0omZEt8WDTb/s39aaadPNgZ5krI=;
        b=leZJY9WIhPlg3iRgPBEa6DOa01EH0+rvmrBmrC2LVKavpsgVn1Raa1I2ATEc0sbmOc
         H1zCKJJFdenTfGjgjODeLEgrMyUaWAetYNKM4Kxw1x5poR9EeS83HP7HmI6vH1vAYU/a
         YzGVEZYzXvsYarVv0pm8x5hk6MKEBjt4TxUirpKkSLjF6Ilxk4XaGivaT9NBadB/C+lJ
         VCM+HSOMIL5k8IkEi5b0Cmt8czaIsZKK1Kss0YgibdpfxgVYJYHQkJI2tRPthUywd5hA
         piJJ4qNAXU2/06bLgy4hlC8duRV/E64BF/ijgCaIY6JslMYcNvg3nJ/aE5N78XaqMoRo
         SIbA==
X-Forwarded-Encrypted: i=1; AHgh+RodYnmtq5l+HSNNGHkKkVpFgNv8Ar5BMR2Leg4LzQ/vh7cQrSjysbUOxamX1m5pkTdUKM4hgNkwcw70L5UGJw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywog6sM4mMtNPkjYd9bgoCe3S7/zWYQwqnyZwNyNlpnq4nNSGkX
	x6RBKmOuaQLP7JzWWQ8ty3WIRFZmdooY2pyUNI19eO5XVjLhUuo+efYBB/SD5o/YSCWgKV2RlY4
	026FXe9UK/39RAkGT11yeMDj1sdClSLkYzJrfif0=
X-Gm-Gg: AfdE7clJWonFn10uDWZFXYgG7KTQT5+78ql5rOFb+/hZgK384sBjozm9YWBgsRsvnH/
	ICuZgiG7W/30/MvRZa9f4c/9PffyVCHZJuJR/BmSNqgiEqXRsvnXnzzWAQHVQMa3PltlW5A3Jen
	ehrOxTuudrdbHfstRBRxKZSKd4vzxHAc4xAAbu89VNDofWrBq2usbEZrHpJFDtpKoYScMiCocWA
	lbB9fxp1drE8cRLMDrUA8np0SmvMN1I+3YQ/53RBEotXBS482l0BeCpELSKAXgbpmGrO4RDqvh3
	ao46EEoYrzQCLbL3K4DmCKzGtkx1Rw==
X-Received: by 2002:a17:902:f705:b0:2cc:6df5:62a1 with SMTP id
 d9443c01a7336-2ccc9cfe5e8mr4326205ad.20.1783450877735; Tue, 07 Jul 2026
 12:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260625170828.3335431-1-natsu@google.com> <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
In-Reply-To: <7202d2dc-b6fe-440e-88b0-aefb26c38b86@collabora.com>
From: Yiwei Zhang <zzyiwei@google.com>
Date: Tue, 7 Jul 2026 12:01:05 -0700
X-Gm-Features: AVVi8CfqZRK8FjQuAUJC_3d57L43GEZFnnGMpVl0zr846a_sRmyOwX1vUSPqcgA
Message-ID: <CAKT=dD=YecudFK1L9wJ22BO41qXt7V4Qm=nNQQiuwheKejoHdg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Don't detach GEM from a non-created context
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Jason Macnak <natsu@google.com>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 2:39=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Hi,
>
> On 6/25/26 20:08, Jason Macnak wrote:
> > Applies the same treatment as commit 7cf6dd467e87 ("drm/virtio:
> > Don't attach GEM to a non-created context in gem_object_open()")
> > to virtio_gpu_gem_object_close() to avoid trying to detach
> > a resource that was never attached due to a context
> > never being created when context_init is supported.
> >
> > Fixes: 086b9f27f0ab ("drm/virtio: Don't create a context with default p=
aram if context_init is supported")
> > Cc: <stable@vger.kernel.org> # v6.14+
> > Signed-off-by: Jason Macnak <natsu@google.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_gem.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/vir=
tio/virtgpu_gem.c
> > index 435d37d36034..66c3f6f74e9c 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> > @@ -139,13 +139,15 @@ void virtio_gpu_gem_object_close(struct drm_gem_o=
bject *obj,
> >       if (!vgdev->has_virgl_3d)
> >               return;
> >
> > -     objs =3D virtio_gpu_array_alloc(1);
> > -     if (!objs)
> > -             return;
> > -     virtio_gpu_array_add_obj(objs, obj);
> > +     if (vfpriv->context_created) {
> > +             objs =3D virtio_gpu_array_alloc(1);
> > +             if (!objs)
> > +                     return;
> > +             virtio_gpu_array_add_obj(objs, obj);
> >
> > -     virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx_id,
> > -                                            objs);
> > +             virtio_gpu_cmd_context_detach_resource(vgdev, vfpriv->ctx=
_id,
> > +                                                    objs);
> > +     }
> >       virtio_gpu_notify(vgdev);
> >  }
>
> The following scenario still will be troubling:
>
> 1. vgdev->has_context_init =3D true
> 2. virtio_gpu_gem_object_open() invoked, GEM created and not attached to =
ctx
> 3. virtio_gpu_context_init_ioctl() invoked, now vfpriv->context_created
> =3D true
> 4. virtio_gpu_gem_object_close() will detach resource that wasn't attache=
d
>
> Add obj->ctx_attached member to struct virtio_gpu_object. See
> virtio_gpu_object_attach() that uses obj->attached, do the same for
> virtio_gpu_cmd_context_attach_resource().
>
> --
> Best regards,
> Dmitry

Hi Dmitry,

WIth context_init, resource attach/detach is per-context based. So a
simple obj->ctx_attached won't work. One would have to track in the
guest context_init ctx for whether a bo has been attached or not.

Another option is to accept this patch and live with the case you
mentioned. We can consider that "invalid" user behavior.

Best,
Yiwei
