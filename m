Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9481A4E9D
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735562344; cv=none; b=A/p0PcgDiuBHNr6YEyBV+TVB2nI3FpSYDM4zPddToOrjIELJEmA4llz0cGOuAAfd+0kWwrMe1xLANdS1wgiMAh2z+wCz0g53jcReiQXBY08uv3ASQFiUWGxggkA8g4A5+swBWJJyiK87pFV+o91uLB89S9xo4rtWTFHvHej+qCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735562344; c=relaxed/simple;
	bh=zNaBfnIZKPu0apVtwnn/KH+i1YsjpT9qIBWhouoaFIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmY/8GS+S1EaADIHHHOf0NVwFKZg/+JAglzKT2GnazYx6Z02GvJXAgbJACAVxevvYP3A3ZDn74kVNBTjU8/V93Mezle1dn1un5ZmeS4w+BSfS+zxLb1dHMvN/o59EgYyHcMt1pzY/chLK2aYGwD06VTPX0LzFZsQ4OElrRsZMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPNo5GDS; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPNo5GDS"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 010934087B
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:39:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uMWmYGu-RhbM for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Dec 2024 12:39:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C67074087D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C67074087D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cPNo5GDS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C67074087D
	for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735562340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EN5GR/R8rnvHhX9xh4AO6pkHNi8GGSvhfwqYdRHPJsE=;
	b=cPNo5GDSUBgNKVZ0frlVSfB7OmdeG6Ekb27S/kHjTGVRZ1v+UOgHkWGcf1vMAdhNmsX46V
	jV4eSNZre56+wbM44NQDFwj5/axlsPQJHo8Azsqs2RNO8BryRlCKc2USpa+wix1T9jMERF
	L0GjuektKM2TvaXgCWvLd1Qiv0T06KQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-BCUfduvQMXeYR8_OHssCog-1; Mon, 30 Dec 2024 07:38:58 -0500
X-MC-Unique: BCUfduvQMXeYR8_OHssCog-1
X-Mimecast-MFC-AGG-ID: BCUfduvQMXeYR8_OHssCog
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa6a831f93cso962430666b.1
        for <virtualization@lists.linux-foundation.org>; Mon, 30 Dec 2024 04:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735562337; x=1736167137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN5GR/R8rnvHhX9xh4AO6pkHNi8GGSvhfwqYdRHPJsE=;
        b=cOE+e385UFrt/26JHtIbuRfqUtGcVM24hVXzT5RzDnndFwTa5MJTKDuQWcY5iPNcL8
         m8MXLKcqvvt2a/RQw9PDvSzg/QZ71+CtS9O2pPuRrCImTB8uhYQV8ocjvsymzemFSymN
         7tr8+7BfU7kNPP1Etr/yX0KGDj14FHtwFW0u6GZ4CZ27AZSvX0BxuMMokaQV0iLUHBvc
         LQougf7S4vHxaa8G0l9JEduUxF6r6o3aNOqWZKL4ZWb3u2s5kedswn4vE9Y1dLovhVJb
         RtXhqP4WzRTTv2FECSiR/74zH1GvFKG7LX42WPqR3dVeh4uxsYrcYxIvV0b1OurnAI/Q
         UM9g==
X-Forwarded-Encrypted: i=1; AJvYcCXSLMyWwASYUutTRhOxL25B40TvtbcayivO7AAX4RgeHgeLQLbIdBnN6aL4UKkGkUcCvnntRGQ196lLKjBDbw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx8yFHyfFhlB8ibbd86H8KIqlUnIY6rCRfhWUiS2NlsxTkrPav0
	JUw0G4IS+PrexY4un6OSlrYeMUoY5c49pY0xA0+/NmhkEAcHLSeZwN126fvAoE2g2WzwSy1q9ly
	Ol6hgBtRcL0MO4xRRTTbAyq51K7RRlLkp8TIXP29gmUx+wzSZF/zw2yTDSqU+HpalVwi34b28RP
	RKTZgLlnUeL05ghzevQxic+GcVeVXW1ilO/DkObubWPsWUfMjc7FV7og==
X-Gm-Gg: ASbGncu0q4vjE9RidzetWeRucvJehaJjsaOxcHltGE5P0pSALcLyh8/BoUlfzvn1gST
	JFEgo2980Tpmcy1n6j1ZNGVcN4AjRd8CPeopobd0=
X-Received: by 2002:a17:906:730f:b0:aab:de31:52d0 with SMTP id a640c23a62f3a-aac2b28ee4dmr3994878766b.18.1735562337348;
        Mon, 30 Dec 2024 04:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOeG8aLdv/SamEPxjMO+a6SoNp9akAxI4C2LKfbhpTR/FoGO/ovccvC1DC9qvCnLAaB9M+8GlyZGGmsYBssOY=
X-Received: by 2002:a17:906:730f:b0:aab:de31:52d0 with SMTP id
 a640c23a62f3a-aac2b28ee4dmr3994876366b.18.1735562336959; Mon, 30 Dec 2024
 04:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <2on4eblmkzkhecpyiwtauel6hxw6upnlh6wunfxgxvfp45cej3@6z5lzdermzeg>
In-Reply-To: <2on4eblmkzkhecpyiwtauel6hxw6upnlh6wunfxgxvfp45cej3@6z5lzdermzeg>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 30 Dec 2024 20:38:19 +0800
Message-ID: <CACLfguW=WciC77tRzfjFNLzrKcxUCBRy_z0V9rpFhEOQhDvhiw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PV0jDDTc-eQOOjLvhil8wJkYHiDPWZf6SEyytAKhqfA_1735562337
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:55=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
> >Add a new UAPI to enable setting the vhost device to task mode.
> >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> >to configure the mode if necessary.
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> > include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > 2 files changed, 39 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 3e9cb99da1b5..12c3bf3d1ed4 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *argp)
> > {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> >-      long r;
> >+      long r =3D 0;
> >       int i, fd;
> >+      u8 inherit_owner;
> >
> >       /* If you are not the owner, you can become one */
> >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >+      if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> >+              /*inherit_owner can only be modified before owner is set*=
/
> >+              if (vhost_dev_has_owner(d)) {
> >+                      r =3D -EBUSY;
> >+                      goto done;
> >+              }
> >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> >+                      r =3D -EFAULT;
> >+                      goto done;
> >+              }
> >+              /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */
> >+              if (inherit_owner > 1) {
> >+                      r =3D -EINVAL;
> >+                      goto done;
> >+              }
> >+
> >+              d->inherit_owner =3D (bool)inherit_owner;
> >
> >+              goto done;
> >+      }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >index b95dd84eef2d..d7564d62b76d 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,22 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,
> > \
> >                                             struct vhost_vring_state)
> >+
> >+/**
> >+ * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vh=
ost device
> >+ *
> >+ * @param inherit_owner: An 8-bit value that determines the vhost threa=
d mode
> >+ *
> >+ * When inherit_owner is set to 1:
> >+ *   - The VHOST worker threads inherit its values/checks from
> >+ *     the thread that owns the VHOST device, The vhost threads will
> >+ *     be counted in the nproc rlimits.
>
> We should mention that this is the default behaviour, so the user does
> not need to call VHOST_SET_INHERIT_FROM_OWNER if the default is okay.
>
sure will fix this
thanks
cindy
> >+ *
> >+ * When inherit_owner is set to 0:
> >+ *   - The VHOST worker threads will use the traditional kernel thread =
(kthread)
> >+ *     implementation, which may be preferred by older userspace applic=
ations that
> >+ *     do not utilize the newer vhost_task concept.
> >+ */
> >+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>
> Do we really need a parameter? I mean could we just have an IOCTL to set
> the old behavior, since the new one is enabled by default?
>
> Not a strong opinion on that, but just an idea to reduce confusion in
> the user. Anyway, if we want the parameter, maybe we can use int instead
> of u8, since we don't particularly care about the length.
>
> Thanks,
> Stefano
>
I think we could keep this, just in case the userspace app needs to
switch back from kthread mode.
Thanks
Cindy
> >+
> > #endif
> >--
> >2.45.0
> >
>

