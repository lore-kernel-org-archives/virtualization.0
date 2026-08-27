Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498363859F5
	for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849812; cv=pass; b=uyD8Lx6f9LbBt19B2WhpXHrgEZbM5IplNbrxAolAPPM0KwNiCc0O8yDW3g75AO+zw7VcdXCT2LnUKlyK8R+KioLSBzda09DO5oA0uIUt05toUyTYsxumslS1QwFj2lnXb9jtcpAa7kUrTKAnAdI+XDpzS2c+ZLv8IQGfYRQUHKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849812; c=relaxed/simple;
	bh=Ak7PjBzduua1Oy2Dl6eUiKXZBxqtQdY/TA+r9uzqYbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGXk0qvc7+Yf9gJbAj1ETYNg0atKMDVBMq69ME4TookzJ0kxrhOVLR3NgpE5i2Fp6YVXwuPOnluvWgMfFt/DJ0TEwX1ODXaWLZgLSUmUHThdhVAOJlf6MsM/HgjQ4t1tvEdiADw9yPHYKxYz1476Utu8/PcwSepKNO020c9FDj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtmoNq2u; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtmoNq2u"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cede6375caso2545ad.0
        for <virtualization@lists.linux.dev>; Thu, 27 Aug 2026 09:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787849810; cv=none;
        d=google.com; s=arc-20260327;
        b=F5SXqtYirKCkL2oWHnW4ptL0QV27nxChxve+yzaMANT3iHROiArn5xMVWeHdX0gy7H
         v0ujEoQqslhRbwyRLzy8v0EQnpZ6IW6STeGB5uMvuLlA/W+pYz4+h1lLqTyK9QU1eS6F
         14DqxoleP/6iSs63k+TAqSTtXUGuS8mxzHeqVhYQEOBqrWwDO7+zFKY3/zWFRE0UJUMG
         qXihambcjaJatD2JvPiphqiahdJr6IihI+xjlPGyMiQqKSWVb0CLrLxnAbn4NziQUUeC
         LZX5wYUmaExSNKQeG8BuP8ytxslM1MMb9jdj9mIPcU2GeJFJm6xN3SxCvb3UwZgN8tvx
         bjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KuyUZNG+s1o9TzzcnLrhB/jVgu3ZDpA+DKbOjE0PlKc=;
        fh=Hukqeo8pIWi8dTmmG/FnPNd6emNUOgw28IJzdXB0SCw=;
        b=gEwjK/8sSPNoaqbaO3ukoPyov2pjWTfsukFZmAi47447SzwaAG3uY2ZEkDkExofc1B
         NiEWNlNvbnGOD7X15mJiyEuKYSr4Gjm2MRNLFgfNV5O6N8zqun7WFlyaESb6Iws0gJHg
         PwQ1dFau22Cb5ndEsrldCxxE0GdDim4LyQGLAJYr7OeoJTqSuR82f67qatj8RKc079Se
         bmVfIucYjc/SxAkC3rLI2/2CEGXG54F1ZzdZcOsCrtAE+MiEEay0DN/w4XUSySYWwHbJ
         UONHaYSQWqWrO7woPNoejnTwD4HJ8SLiBJRhZ/4G4RwCvw5QjJP6edwh70eKMP22rP3a
         vP7A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787849810; x=1788454610; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KuyUZNG+s1o9TzzcnLrhB/jVgu3ZDpA+DKbOjE0PlKc=;
        b=BtmoNq2u1krKPV5Vpo2XG4yl7pP/OmJWjYjDbutdqpZAD49erygEybiJXYP0o8bPif
         qvOXxBYZsGvYAqBTIs412f8WCTEBFAEhbI108EdvnXQ2WM86L/2zhrO+1VrHdwnv45VS
         CDJ9kd3LqvX17XVyo+yRamUWRlSl61rYwBe94xTgoDoMELAe1ePrXaSJ+MnBMLwWo0R0
         3AiJM4it23R/j3AtRuTlddOTaJ8m0zAiPWpUkpDwx2xGe2vSqJjWhYuMxBFqmYUASQbv
         muFZ/6p8MFWFtWyAlTNg+1KlcwqhCF/iWZb+PC2vzcwQKWtd4t3g8mPjX94KuuT20v/x
         3cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849810; x=1788454610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KuyUZNG+s1o9TzzcnLrhB/jVgu3ZDpA+DKbOjE0PlKc=;
        b=mEgqfMcqJjimgGfWAo0a/w1BuBDBh8mcqlVP60TMSTK6djajIFBlLOO02dQYgYMK8q
         ylOJqwYtoFZ9HM8uPqUyNg3qazSEjYtTrvuo9JjUnoV4/PbV9gm3xW7PKRaaS/MU6apO
         HS+OkpsWEAgEg1A+JGm4cR5zK6Kca1DA2zmLs8C6c9uDITVvZ6pUcQBqlNFx+r2sorGC
         Z3oYqFoDnyr3XbwU7rT/lYjC6nWcekDLapl0j71ykR9525uu1fpWpjZAulwEx+auOszM
         4pw5EXkfhXbkxv8FtgUisREbMef5OJw3Q9EDtdXxJjjqSknUP2tNwUB8SlQ39NVU6Nwv
         xXLw==
X-Forwarded-Encrypted: i=1; AHgh+RqLtyOHOexuq3b6pu2zbur9+jF1YeYorhiSRGWkpXbzhEEXX4q6zTCTSyPyIrnOAKaPwGIizC2Ld6YGgsie4A==@lists.linux.dev
X-Gm-Message-State: AFuF++mJW+xzar3yuxcsXze/g3a6Wg5B+3AK/3FAhfhAyrS1xzz6z9mI
	ISZbpMZcrVns1KCegAtq92SQF+6HjlLJ1RS/EX2HEtVtAdt5rzuvIAptSSpZsK4nR/sCw0LVN8m
	U0heASZeHMX/dIm1G38dHhvpBHAkeA9b6qY4yHdg=
X-Gm-Gg: AR+sD11Sr7oBwoBIoWluIUZt0d/ayd0tBNJ2U//YpLvxyq+JCfNSZF8rIBtPWVDdyJp
	k+aVIGQeS5WwxpjsnFyTLOs+F5duI2p7sAIlCkA6ap+LZU2AqgGIxYqhlCUc8W7BDIxF7DN2/71
	b2kyP9ApOVaD3YyRiJhtFyB0LEFhl2xtc9JuBtNMOyxv8/yvS+kCYF+wuwMTCUx8f1/agi0uoS7
	V6gzbfDZXktaS8x+xu0stHPDSK/yzKIuvFTgMgzU8RpRxw3mf8pqWBMHzVa9+p7XqV8Bor0ub1p
	IvZ9YEkKiz7yB0JspjhmQZzhwPsPoJ2d6ED4Nd2qFRZBqr7Q7C2xxfEBPr458HomFnv88p2NKE4
	=
X-Received: by 2002:a17:902:ef4f:b0:2ce:b436:272a with SMTP id
 d9443c01a7336-2d73350c707mr6416845ad.3.1787849808602; Thu, 27 Aug 2026
 09:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260813180026.2636879-1-briandaniels@google.com>
 <20260813180026.2636879-2-briandaniels@google.com> <CACzuRyzeX9E4VhW7zA=q6md4byzC_+ydB9hU=+mYjui_vkWVig@mail.gmail.com>
 <CACzuRyx7+o9AuqdzkR-EGmWj5_ptbVqUAb6EJbxcpkOWWqwnyQ@mail.gmail.com>
 <CAD4i_GTmgS1=D3CDETjFYcVpBrJfvjb2rNT9qjjWu71neFNjNg@mail.gmail.com> <CACzuRyxfsor1AN1_YoD6=C27Ln36hxiPfQ+iHdda6edKzMR1zg@mail.gmail.com>
In-Reply-To: <CACzuRyxfsor1AN1_YoD6=C27Ln36hxiPfQ+iHdda6edKzMR1zg@mail.gmail.com>
From: Brian Daniels <briandaniels@google.com>
Date: Thu, 27 Aug 2026 12:56:36 -0400
X-Gm-Features: AcwNN1VzUOkLnfmgK69ZkiwCBj9dgoVwAMEoX_fp6zMuvJxfcNkhKM4bwLwOPJ4
Message-ID: <CAD4i_GT6bMazGKG5L+nOc6i_RU5CrjdRAwp5k6idqRkbnpZgdw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] media: virtio: Add skeleton virtio-media driver
To: Dorinda Bassey <dbassey@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, adelva@google.com, aesteve@redhat.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	laurent.pinchart@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 8:15=E2=80=AFAM Dorinda Bassey <dbassey@redhat.com>=
 wrote:
>
> > Is there a specific command to run the uapi header validation? I did
> > some searching and only found the ``scripts/check-uapi.sh`` script,
> > which didn't raise any issues when I ran it. Could you share the
> > command you're using to validate the UAPI headers?
>
> The UAPI header validation happens automatically during the kernel build
> when `CONFIG_UAPI_HEADER_TEST=3Dy` is enabled in the kernel config.
> libkrunfw enables this for aarch64 builds, which is why our CI caught it:
> https://github.com/libkrun/libkrunfw/blob/main/config-libkrunfw_aarch64
>
> This config option is opt-in (not in upstream defconfigs), which is why y=
ou
> didn't catch it.

Thanks for sharing that config option. When I tested locally, it
failed with the following message:

  In file included from ./usr/include/linux/virtio_media.h:13,
                   from <command-line>:
  usr/include/linux/videodev2.h:60:10: fatal error: sys/time.h: No
such file or director
     60 | #include <sys/time.h>
        |          ^~~~~~~~~~~~
  compilation terminated.

Looks like ``videodev2.h`` iteslf is actually excluded by the header
test (see ``no-header-test`` in ``usr/include/Makefile``). Because
``virtio_media.h`` includes `videodev2.h`, I plan to add
``virtio_media.h` to the exclusion list as well in v8.

Thanks again for all the help and testing!

> Thanks for the v8 fix.
>
> BR,
> Dorinda.
>
>
> On Wed, Aug 26, 2026 at 6:47=E2=80=AFPM Brian Daniels <briandaniels@googl=
e.com> wrote:
> >
> > On Tue, Aug 25, 2026 at 11:47=E2=80=AFAM Dorinda Bassey <dbassey@redhat=
.com> wrote:
> > >
> > > Hi Brian,
> > >
> > > I've been backporting the virtio-media v7 patches for libkrunfw and h=
it
> > > some failures on aarch64 when running make on the headers. The v7
> > > patches has UAPI headers issues in include/uapi/linux/virtio_media.h:
> > > 1. It's using `u32`/`u64` instead of `__u32`/`__u64`
> > > UAPI headers exposed to userspace must use the double-underscore
> > > types.
> > >
> > > 2. It's missing `#include <linux/types.h>`
> > > Without this, `__u32`/`__u64` are undefined when the header is includ=
ed
> > > from userspace.
> > >
> > > causing errors like:
> > > ./usr/include/linux/virtio_media.h:27:9: error: unknown type name =E2=
=80=98u32=E2=80=99
> > >   27 |         u32 cmd;
> > >      |         ^~~
> > >
> > > See patterns:
> > >
> > > > +struct virtio_media_cmd_header {
> > > > +       u32 cmd;
> > > > +       u32 __reserved;
> > > > +};
> > >
> > > here
> > >
> > > > +struct virtio_media_sg_entry {
> > > > +       u64 start;
> > > > +       u32 len;
> > > > +       u32 __reserved;
> > > > +};
> > >
> > > here and more.
> >
> > Thanks very much for raising this. I've prepped the corrections in v8.
> >
> > >
> > > I've applied these fixes locally for the backport. These would fail
> > > on any system that runs UAPI header validation during build too.
> >
> > Is there a specific command to run the uapi header validation? I did
> > some searching and only found the ``scripts/check-uapi.sh`` script,
> > which didn't raise any issues when I ran it. Could you share the
> > command you're using to validate the UAPI headers?
> >
> > > BR,
> > > Dorinda.
> > >
> > >
> > > On Wed, Aug 19, 2026 at 12:54=E2=80=AFPM Dorinda Bassey <dbassey@redh=
at.com> wrote:
> > > >
> > > > > From: Alexandre Courbot <gnurou@gmail.com>
> > > > > This patch adds a minimum viable virtio-media driver that binds t=
o the
> > > > > virtio device and registers a V4L2 device and a video device, but=
 lacks
> > > > > any actual functionality.
> > > > > It adds the UAPI header defining the protocol, internal driver he=
aders,
> > > > > Kconfig and Makefile entries, and MAINTAINERS entry. Many of the =
structs
> > > > > in the protocol add reserved bits. These are present to ensure 64=
-bit
> > > > > alignment. They are not intended to be used as reserved expansion=
 for
> > > > > the protocol in the future, so more reserved space is not require=
d.
> > > > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > > > Assisted-by: Antigravity:gemini-3.5-flash
> > > > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > > >
> > > >
> > > > Reviewed-by: Dorinda Bassey <dbassey@redhat.com>
> > > > Tested-by: Dorinda Bassey <dbassey@redhat.com>
> > > >
> > > > Thanks!
> > > >
> > > >
> > > > On Thu, Aug 13, 2026 at 8:00=E2=80=AFPM Brian Daniels <briandaniels=
@google.com> wrote:
> > > > >
> > > > > From: Alexandre Courbot <gnurou@gmail.com>
> > > > >
> > > > > This patch adds a minimum viable virtio-media driver that binds t=
o the
> > > > > virtio device and registers a V4L2 device and a video device, but=
 lacks
> > > > > any actual functionality.
> > > > >
> > > > > It adds the UAPI header defining the protocol, internal driver he=
aders,
> > > > > Kconfig and Makefile entries, and MAINTAINERS entry. Many of the =
structs
> > > > > in the protocol add reserved bits. These are present to ensure 64=
-bit
> > > > > alignment. They are not intended to be used as reserved expansion=
 for
> > > > > the protocol in the future, so more reserved space is not require=
d.
> > > > >
> > > > > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > > > > Assisted-by: Antigravity:gemini-3.5-flash
> > > > > Co-developed-by: Brian Daniels <briandaniels@google.com>
> > > > > Signed-off-by: Brian Daniels <briandaniels@google.com>
> > > > > ---
> > > > >  MAINTAINERS                                |   8 +
> > > > >  drivers/media/Kconfig                      |  13 +
> > > > >  drivers/media/Makefile                     |   2 +
> > > > >  drivers/media/virtio/Makefile              |   7 +
> > > > >  drivers/media/virtio/virtio_media.h        |  95 +++++++
> > > > >  drivers/media/virtio/virtio_media_driver.c | 146 +++++++++++
> > > > >  include/uapi/linux/virtio_media.h          | 287 +++++++++++++++=
++++++
> > > > >  7 files changed, 558 insertions(+)
> > > > >  create mode 100644 drivers/media/virtio/Makefile
> > > > >  create mode 100644 drivers/media/virtio/virtio_media.h
> > > > >  create mode 100644 drivers/media/virtio/virtio_media_driver.c
> > > > >  create mode 100644 include/uapi/linux/virtio_media.h
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 3785b8c1d..c3b5c5eb6 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -28573,6 +28573,7 @@ F:      Documentation/devicetree/bindings=
/virtio/
> > > > >  F:     Documentation/driver-api/virtio/
> > > > >  F:     drivers/block/virtio_blk.c
> > > > >  F:     drivers/crypto/virtio/
> > > > > +F:     drivers/media/virtio/
> > > > >  F:     drivers/vdpa/
> > > > >  F:     drivers/virtio/
> > > > >  F:     include/linux/vdpa.h
> > > > > @@ -28685,6 +28686,13 @@ S:     Maintained
> > > > >  F:     drivers/iommu/virtio-iommu.c
> > > > >  F:     include/uapi/linux/virtio_iommu.h
> > > > >
> > > > > +VIRTIO MEDIA DRIVER
> > > > > +M:     Brian Daniels <briandaniels@google.com>
> > > > > +L:     linux-media@vger.kernel.org
> > > > > +S:     Maintained
> > > > > +F:     drivers/media/virtio/
> > > > > +F:     include/uapi/linux/virtio_media.h
> > > > > +
> > > > >  VIRTIO MEM DRIVER
> > > > >  M:     David Hildenbrand <david@kernel.org>
> > > > >  L:     virtualization@lists.linux.dev
> > > > > diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
> > > > > index 6abc9302c..ce7d088e7 100644
> > > > > --- a/drivers/media/Kconfig
> > > > > +++ b/drivers/media/Kconfig
> > > > > @@ -136,6 +136,19 @@ config MEDIA_PLATFORM_SUPPORT
> > > > >
> > > > >           Say Y when you want to be able to see such devices.
> > > > >
> > > > > +config MEDIA_VIRTIO
> > > > > +       tristate "Virtio-media Driver"
> > > > > +       depends on VIRTIO && VIDEO_DEV && 64BIT && (X86 || CPU_LI=
TTLE_ENDIAN)
> > > > > +       select VIDEOBUF2_CORE
> > > > > +       select VIDEOBUF2_MEMOPS
> > > > > +       help
> > > > > +         Enables the virtio-media driver.
> > > > > +
> > > > > +         This driver is used to virtualize media devices such as=
 cameras or
> > > > > +         decoders from a host into a guest using the V4L2 protoc=
ol.
> > > > > +
> > > > > +         If unsure, say N.
> > > > > +
> > > > >  config MEDIA_TEST_SUPPORT
> > > > >         bool
> > > > >         prompt "Test drivers" if MEDIA_SUPPORT_FILTER
> > > > > diff --git a/drivers/media/Makefile b/drivers/media/Makefile
> > > > > index 20fac24e4..357e786cc 100644
> > > > > --- a/drivers/media/Makefile
> > > > > +++ b/drivers/media/Makefile
> > > > > @@ -23,6 +23,8 @@ obj-$(CONFIG_DVB_CORE) +=3D dvb-core/
> > > > >  # There are both core and drivers at RC subtree - merge before d=
rivers
> > > > >  obj-y +=3D rc/
> > > > >
> > > > > +obj-$(CONFIG_MEDIA_VIRTIO) +=3D virtio/
> > > > > +
> > > > >  obj-$(CONFIG_CEC_CORE) +=3D cec/
> > > > >
> > > > >  #
> > > > > diff --git a/drivers/media/virtio/Makefile b/drivers/media/virtio=
/Makefile
> > > > > new file mode 100644
> > > > > index 000000000..09d9834da
> > > > > --- /dev/null
> > > > > +++ b/drivers/media/virtio/Makefile
> > > > > @@ -0,0 +1,7 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +#
> > > > > +# Makefile for the virtio-media device driver.
> > > > > +
> > > > > +virtio-media-objs :=3D virtio_media_driver.o
> > > > > +
> > > > > +obj-$(CONFIG_MEDIA_VIRTIO) +=3D virtio-media.o
> > > > > diff --git a/drivers/media/virtio/virtio_media.h b/drivers/media/=
virtio/virtio_media.h
> > > > > new file mode 100644
> > > > > index 000000000..7acb2b842
> > > > > --- /dev/null
> > > > > +++ b/drivers/media/virtio/virtio_media.h
> > > > > @@ -0,0 +1,95 @@
> > > > > +/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+ */
> > > > > +
> > > > > +/*
> > > > > + * Virtio-media structures & functions declarations.
> > > > > + *
> > > > > + * Copyright (c) 2024-2026 Google LLC.
> > > > > + */
> > > > > +
> > > > > +#ifndef __VIRTIO_MEDIA_H
> > > > > +#define __VIRTIO_MEDIA_H
> > > > > +
> > > > > +#include <linux/virtio_config.h>
> > > > > +#include <media/v4l2-device.h>
> > > > > +
> > > > > +#include "uapi/linux/virtio_media.h"
> > > > > +
> > > > > +#define DESC_CHAIN_MAX_LEN SG_MAX_SINGLE_ALLOC
> > > > > +
> > > > > +#define VIRTIO_MEDIA_DEFAULT_DRIVER_NAME "virtio-media"
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media - Virtio-media device.
> > > > > + * @v4l2_dev: v4l2_device for the media device.
> > > > > + * @video_dev: video_device for the media device.
> > > > > + * @virtio_dev: virtio device for the media device.
> > > > > + * @commandq: virtio command queue.
> > > > > + * @eventq: virtio event queue.
> > > > > + * @eventq_work: work to run when events are received on @eventq=
.
> > > > > + * @mmap_region: region into which MMAP buffers are mapped by th=
e host.
> > > > > + * @event_buffer: buffer for event descriptors.
> > > > > + * @sessions: list of active sessions on the device.
> > > > > + * @sessions_lock: protects @sessions and &struct virtio_media_s=
ession.list.
> > > > > + * @events_lock: prevents concurrent processing of events.
> > > > > + * @cmd: union of the device commands ``open`` and ``munmap``. T=
he other
> > > > > + *       commands are handled by &struct virtio_media_session
> > > > > + * @resp: union of responses to device commands ``open`` and ``m=
unmap``. The
> > > > > + *        other responses are handled by &struct virtio_media_se=
ssion
> > > > > + * @vlock: serializes access to the command queue.
> > > > > + * @wq: waitqueue for host responses on the command queue.
> > > > > + */
> > > > > +struct virtio_media {
> > > > > +       struct v4l2_device v4l2_dev;
> > > > > +       struct video_device video_dev;
> > > > > +
> > > > > +       struct virtio_device *virtio_dev;
> > > > > +       struct virtqueue *commandq;
> > > > > +       struct virtqueue *eventq;
> > > > > +       struct work_struct eventq_work;
> > > > > +
> > > > > +       struct virtio_shm_region mmap_region;
> > > > > +
> > > > > +       void *event_buffer;
> > > > > +
> > > > > +       struct list_head sessions;
> > > > > +       struct mutex sessions_lock; /* protects sessions list */
> > > > > +
> > > > > +       struct mutex events_lock; /* prevents concurrent event pr=
ocessing */
> > > > > +
> > > > > +       __dma_from_device_group_begin();
> > > > > +       union {
> > > > > +               struct virtio_media_cmd_open open;
> > > > > +               struct virtio_media_cmd_munmap munmap;
> > > > > +       } cmd;
> > > > > +
> > > > > +       union {
> > > > > +               struct virtio_media_resp_open open;
> > > > > +               struct virtio_media_resp_munmap munmap;
> > > > > +       } resp;
> > > > > +       __dma_from_device_group_end();
> > > > > +
> > > > > +       struct mutex vlock; /* serializes command queue access */
> > > > > +       wait_queue_head_t wq;
> > > > > +};
> > > > > +
> > > > > +static inline struct virtio_media *
> > > > > +to_virtio_media(struct video_device *video_dev)
> > > > > +{
> > > > > +       return container_of(video_dev, struct virtio_media, video=
_dev);
> > > > > +}
> > > > > +
> > > > > +/* virtio_media_driver.c */
> > > > > +
> > > > > +int virtio_media_send_command(struct virtio_media *vv, struct sc=
atterlist **sgs,
> > > > > +                             const size_t out_sgs, const size_t =
in_sgs,
> > > > > +                             size_t minimum_resp_len, size_t *re=
sp_len);
> > > > > +void virtio_media_process_events(struct virtio_media *vv);
> > > > > +
> > > > > +/* virtio_media_ioctls.c */
> > > > > +
> > > > > +long virtio_media_device_ioctl(struct file *file, unsigned int c=
md,
> > > > > +                              unsigned long arg);
> > > > > +extern const struct v4l2_ioctl_ops virtio_media_ioctl_ops;
> > > > > +
> > > > > +#endif // __VIRTIO_MEDIA_H
> > > > > +
> > > > > diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers=
/media/virtio/virtio_media_driver.c
> > > > > new file mode 100644
> > > > > index 000000000..25f2ceaa6
> > > > > --- /dev/null
> > > > > +++ b/drivers/media/virtio/virtio_media_driver.c
> > > > > @@ -0,0 +1,146 @@
> > > > > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0+
> > > > > +
> > > > > +/*
> > > > > + * Virtio-media driver.
> > > > > + *
> > > > > + * Copyright (c) 2024-2026 Google LLC.
> > > > > + */
> > > > > +
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/dev_printk.h>
> > > > > +#include <linux/mutex.h>
> > > > > +#include <linux/types.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/virtio.h>
> > > > > +#include <linux/virtio_config.h>
> > > > > +#include <linux/virtio_ids.h>
> > > > > +
> > > > > +#include <media/v4l2-dev.h>
> > > > > +#include <media/v4l2-device.h>
> > > > > +
> > > > > +#include "uapi/linux/virtio_media.h"
> > > > > +#include "virtio_media.h"
> > > > > +
> > > > > +static void commandq_callback(struct virtqueue *vq)
> > > > > +{
> > > > > +}
> > > > > +
> > > > > +static void eventq_callback(struct virtqueue *vq)
> > > > > +{
> > > > > +}
> > > > > +
> > > > > +static const struct v4l2_file_operations virtio_media_fops =3D {
> > > > > +       .owner =3D THIS_MODULE,
> > > > > +       .open =3D v4l2_fh_open,
> > > > > +       .release =3D v4l2_fh_release,
> > > > > +};
> > > > > +
> > > > > +static int virtio_media_probe(struct virtio_device *virtio_dev)
> > > > > +{
> > > > > +       struct device *dev =3D &virtio_dev->dev;
> > > > > +       struct virtqueue *vqs[2];
> > > > > +       static struct virtqueue_info vq_info[2] =3D {
> > > > > +               {
> > > > > +                       .name =3D "command",
> > > > > +                       .callback =3D commandq_callback,
> > > > > +               },
> > > > > +               {
> > > > > +                       .name =3D "event",
> > > > > +                       .callback =3D eventq_callback,
> > > > > +               },
> > > > > +       };
> > > > > +       struct virtio_media *vv;
> > > > > +       struct video_device *vd;
> > > > > +       int ret;
> > > > > +
> > > > > +       vv =3D devm_kzalloc(dev, sizeof(*vv), GFP_KERNEL);
> > > > > +       if (!vv)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       INIT_LIST_HEAD(&vv->sessions);
> > > > > +       mutex_init(&vv->sessions_lock);
> > > > > +       mutex_init(&vv->events_lock);
> > > > > +       mutex_init(&vv->vlock);
> > > > > +
> > > > > +       vv->virtio_dev =3D virtio_dev;
> > > > > +       virtio_dev->priv =3D vv;
> > > > > +
> > > > > +       init_waitqueue_head(&vv->wq);
> > > > > +
> > > > > +       ret =3D v4l2_device_register(dev, &vv->v4l2_dev);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       ret =3D virtio_find_vqs(virtio_dev, 2, vqs, vq_info, NULL=
);
> > > > > +       if (ret)
> > > > > +               goto err_find_vqs;
> > > > > +
> > > > > +       vv->commandq =3D vqs[0];
> > > > > +       vv->eventq =3D vqs[1];
> > > > > +
> > > > > +       vd =3D &vv->video_dev;
> > > > > +       vd->v4l2_dev =3D &vv->v4l2_dev;
> > > > > +       vd->vfl_type =3D VFL_TYPE_VIDEO;
> > > > > +       vd->fops =3D &virtio_media_fops;
> > > > > +       vd->release =3D video_device_release_empty;
> > > > > +       strscpy(vd->name, "virtio-media", sizeof(vd->name));
> > > > > +
> > > > > +       video_set_drvdata(vd, vv);
> > > > > +
> > > > > +       vd->device_caps =3D virtio_cread32(virtio_dev, 0);
> > > > > +       if (vd->device_caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDE=
O_M2M_MPLANE))
> > > > > +               vd->vfl_dir =3D VFL_DIR_M2M;
> > > > > +       else if (vd->device_caps &
> > > > > +                (V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OUTPUT_M=
PLANE))
> > > > > +               vd->vfl_dir =3D VFL_DIR_TX;
> > > > > +       else
> > > > > +               vd->vfl_dir =3D VFL_DIR_RX;
> > > > > +
> > > > > +       ret =3D video_register_device(vd, virtio_cread32(virtio_d=
ev, 4), 0);
> > > > > +       if (ret)
> > > > > +               goto err_register_device;
> > > > > +
> > > > > +       virtio_device_ready(virtio_dev);
> > > > > +
> > > > > +       return 0;
> > > > > +
> > > > > +err_register_device:
> > > > > +       virtio_dev->config->del_vqs(virtio_dev);
> > > > > +err_find_vqs:
> > > > > +       v4l2_device_unregister(&vv->v4l2_dev);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +static void virtio_media_remove(struct virtio_device *virtio_dev=
)
> > > > > +{
> > > > > +       struct virtio_media *vv =3D virtio_dev->priv;
> > > > > +
> > > > > +       virtio_reset_device(virtio_dev);
> > > > > +       v4l2_device_unregister(&vv->v4l2_dev);
> > > > > +       virtio_dev->config->del_vqs(virtio_dev);
> > > > > +       video_unregister_device(&vv->video_dev);
> > > > > +}
> > > > > +
> > > > > +static struct virtio_device_id id_table[] =3D {
> > > > > +       { VIRTIO_ID_MEDIA, VIRTIO_DEV_ANY_ID },
> > > > > +       { 0 },
> > > > > +};
> > > > > +
> > > > > +static unsigned int features[] =3D {};
> > > > > +
> > > > > +static struct virtio_driver virtio_media_driver =3D {
> > > > > +       .feature_table =3D features,
> > > > > +       .feature_table_size =3D ARRAY_SIZE(features),
> > > > > +       .driver.name =3D VIRTIO_MEDIA_DEFAULT_DRIVER_NAME,
> > > > > +       .driver.owner =3D THIS_MODULE,
> > > > > +       .id_table =3D id_table,
> > > > > +       .probe =3D virtio_media_probe,
> > > > > +       .remove =3D virtio_media_remove,
> > > > > +};
> > > > > +
> > > > > +module_virtio_driver(virtio_media_driver);
> > > > > +
> > > > > +MODULE_DEVICE_TABLE(virtio, id_table);
> > > > > +MODULE_DESCRIPTION("virtio media driver");
> > > > > +MODULE_AUTHOR("Alexandre Courbot <gnurou@gmail.com>");
> > > > > +MODULE_LICENSE("Dual BSD/GPL");
> > > > > diff --git a/include/uapi/linux/virtio_media.h b/include/uapi/lin=
ux/virtio_media.h
> > > > > new file mode 100644
> > > > > index 000000000..280fbbe94
> > > > > --- /dev/null
> > > > > +++ b/include/uapi/linux/virtio_media.h
> > > > > @@ -0,0 +1,287 @@
> > > > > +/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) =
OR BSD-3-Clause) */
> > > > > +
> > > > > +/*
> > > > > + * Definitions of virtio-media protocol structures.
> > > > > + *
> > > > > + * Copyright (c) 2024-2026 Google LLC.
> > > > > + */
> > > > > +
> > > > > +#ifndef __VIRTIO_MEDIA_PROTOCOL_H
> > > > > +#define __VIRTIO_MEDIA_PROTOCOL_H
> > > > > +
> > > > > +#include <linux/videodev2.h>
> > > > > +
> > > > > +/*
> > > > > + * Virtio protocol definition.
> > > > > + */
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_cmd_header - Header for all virtio-media =
commands.
> > > > > + * @cmd: one of VIRTIO_MEDIA_CMD_*.
> > > > > + * @__reserved: must be set to zero by the driver.
> > > > > + *
> > > > > + * This header starts all commands from the driver to the device=
 on the
> > > > > + * commandq.
> > > > > + */
> > > > > +struct virtio_media_cmd_header {
> > > > > +       u32 cmd;
> > > > > +       u32 __reserved;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_resp_header - Header for all virtio-media=
 responses.
> > > > > + * @status: 0 if the command was successful, or one of the stand=
ard Linux error
> > > > > + *          codes as a positive integer.
> > > > > + * @__reserved: must be set to zero by the device.
> > > > > + *
> > > > > + * This header starts all responses from the device to the drive=
r on the
> > > > > + * commandq.
> > > > > + */
> > > > > +struct virtio_media_resp_header {
> > > > > +       u32 status;
> > > > > +       u32 __reserved;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * VIRTIO_MEDIA_CMD_OPEN - Command for creating a new session.
> > > > > + *
> > > > > + * This is the equivalent of calling ``open`` on a V4L2 device n=
ode. Upon
> > > > > + * success, a session id is returned which can be used to perfor=
m other
> > > > > + * commands on the session, notably ioctls.
> > > > > + */
> > > > > +#define VIRTIO_MEDIA_CMD_OPEN 1
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_cmd_open - Driver command for VIRTIO_MEDI=
A_CMD_OPEN.
> > > > > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_OPEN.
> > > > > + */
> > > > > +struct virtio_media_cmd_open {
> > > > > +       struct virtio_media_cmd_header hdr;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_resp_open - Device response for VIRTIO_ME=
DIA_CMD_OPEN.
> > > > > + * @hdr: header containing the status of the command.
> > > > > + * @session_id: if &struct virtio_media_resp_header.status =3D=
=3D 0, contains the
> > > > > + *              id of the newly created session.
> > > > > + * @__reserved: must be set to zero by the device.
> > > > > + */
> > > > > +struct virtio_media_resp_open {
> > > > > +       struct virtio_media_resp_header hdr;
> > > > > +       u32 session_id;
> > > > > +       u32 __reserved;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * VIRTIO_MEDIA_CMD_CLOSE - Command for closing an active sessio=
n.
> > > > > + *
> > > > > + * This is the equivalent of calling ``close`` on a previously o=
pened V4L2
> > > > > + * session. All resources associated with this session will be f=
reed and the
> > > > > + * session ID shall not be used again after queueing this comman=
d.
> > > > > + *
> > > > > + * This command does not require a response from the device.
> > > > > + */
> > > > > +#define VIRTIO_MEDIA_CMD_CLOSE 2
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_cmd_close - Driver command for VIRTIO_MED=
IA_CMD_CLOSE.
> > > > > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_CLOSE.
> > > > > + * @session_id: id of the session to close.
> > > > > + * @__reserved: must be set to zero by the driver.
> > > > > + */
> > > > > +struct virtio_media_cmd_close {
> > > > > +       struct virtio_media_cmd_header hdr;
> > > > > +       u32 session_id;
> > > > > +       u32 __reserved;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * VIRTIO_MEDIA_CMD_IOCTL - Driver command for executing an ioct=
l.
> > > > > + *
> > > > > + * This command asks the device to run one of the ``VIDIOC_*`` i=
octls on the
> > > > > + * active session.
> > > > > + *
> > > > > + * The code of the ioctl is extracted from the VIDIOC_* definiti=
ons in
> > > > > + * ``videodev2.h``, and consists of the second argument of the `=
`_IO*`` macro.
> > > > > + *
> > > > > + * Each ioctl has a payload, which is defined by the third argum=
ent of the
> > > > > + * ``_IO*`` macro defining it. It can be writable by the driver =
(``_IOW``), the
> > > > > + * device (``_IOR``), or both (``_IOWR``).
> > > > > + *
> > > > > + * If an ioctl is writable by the driver, it must be followed by=
 a
> > > > > + * driver-writable descriptor containing the payload.
> > > > > + *
> > > > > + * If an ioctl is writable by the device, it must be followed by=
 a
> > > > > + * device-writable descriptor of the size of the payload that th=
e device will
> > > > > + * write into.
> > > > > + *
> > > > > + */
> > > > > +#define VIRTIO_MEDIA_CMD_IOCTL 3
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_cmd_ioctl - Driver command for VIRTIO_MED=
IA_CMD_IOCTL.
> > > > > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_IOCTL.
> > > > > + * @session_id: id of the session to run the ioctl on.
> > > > > + * @code: code of the ioctl to run.
> > > > > + */
> > > > > +struct virtio_media_cmd_ioctl {
> > > > > +       struct virtio_media_cmd_header hdr;
> > > > > +       u32 session_id;
> > > > > +       u32 code;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_resp_ioctl - Device response for VIRTIO_M=
EDIA_CMD_IOCTL.
> > > > > + * @hdr: header containing the status of the ioctl.
> > > > > + */
> > > > > +struct virtio_media_resp_ioctl {
> > > > > +       struct virtio_media_resp_header hdr;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_sg_entry - Description of part of a scatt=
ered guest
> > > > > + *                                memory.
> > > > > + * @start: start guest address of the memory segment.
> > > > > + * @len: length of this memory segment.
> > > > > + * @__reserved: must be set to zero by the driver.
> > > > > + */
> > > > > +struct virtio_media_sg_entry {
> > > > > +       u64 start;
> > > > > +       u32 len;
> > > > > +       u32 __reserved;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * VIRTIO_MEDIA_MMAP_FLAG_RW - Bit position of the VIRTIO_MEDIA_=
MMAP_FLAG_RW
> > > > > + *                             flag.
> > > > > + */
> > > > > +#define VIRTIO_MEDIA_MMAP_FLAG_RW 0
> > > > > +
> > > > > +/**
> > > > > + * VIRTIO_MEDIA_CMD_MMAP - Command for mapping a MMAP buffer int=
o the driver's
> > > > > + *                         address space.
> > > > > + */
> > > > > +#define VIRTIO_MEDIA_CMD_MMAP 4
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_cmd_mmap - Driver command for VIRTIO_MEDI=
A_CMD_MMAP.
> > > > > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MMAP.
> > > > > + * @session_id: ID of the session we are mapping for.
> > > > > + * @flags: combination of VIRTIO_MEDIA_MMAP_FLAG_*.
> > > > > + * @offset: mem_offset field of the plane to map, as returned by
> > > > > + *          VIDIOC_QUERYBUF.
> > > > > + */
> > > > > +struct virtio_media_cmd_mmap {
> > > > > +       struct virtio_media_cmd_header hdr;
> > > > > +       u32 session_id;
> > > > > +       u32 flags;
> > > > > +       u32 offset;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_resp_mmap - Device response for VIRTIO_ME=
DIA_CMD_MMAP.
> > > > > + * @hdr: header containing the status of the command.
> > > > > + * @driver_addr: offset into SHM region 0 of the start of the ma=
pping.
> > > > > + * @len: length of the mapping.
> > > > > + */
> > > > > +struct virtio_media_resp_mmap {
> > > > > +       struct virtio_media_resp_header hdr;
> > > > > +       u64 driver_addr;
> > > > > +       u64 len;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * VIRTIO_MEDIA_CMD_MUNMAP - Unmap a MMAP buffer previously mapp=
ed using
> > > > > + *                           VIRTIO_MEDIA_CMD_MMAP.
> > > > > + */
> > > > > +#define VIRTIO_MEDIA_CMD_MUNMAP 5
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_cmd_munmap - Driver command for VIRTIO_ME=
DIA_CMD_MUNMAP.
> > > > > + * @hdr: header with cmd member set to VIRTIO_MEDIA_CMD_MUNMAP.
> > > > > + * @driver_addr: offset into SHM region 0 at which the buffer ha=
s been
> > > > > + *               previously mapped.
> > > > > + */
> > > > > +struct virtio_media_cmd_munmap {
> > > > > +       struct virtio_media_cmd_header hdr;
> > > > > +       u64 driver_addr;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_resp_munmap - Device response for
> > > > > + *                                   VIRTIO_MEDIA_CMD_MUNMAP.
> > > > > + * @hdr: header containing the status of the command.
> > > > > + */
> > > > > +struct virtio_media_resp_munmap {
> > > > > +       struct virtio_media_resp_header hdr;
> > > > > +};
> > > > > +
> > > > > +/* The values for these events are set by the virtio-media speci=
fication. */
> > > > > +#define VIRTIO_MEDIA_EVT_ERROR 0
> > > > > +#define VIRTIO_MEDIA_EVT_DQBUF 1
> > > > > +#define VIRTIO_MEDIA_EVT_EVENT 2
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_event_header - Header for events on the e=
ventq.
> > > > > + * @event: one of VIRTIO_MEDIA_EVT_*
> > > > > + * @session_id: ID of the session the event applies to.
> > > > > + */
> > > > > +struct virtio_media_event_header {
> > > > > +       u32 event;
> > > > > +       u32 session_id;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_event_error - Unrecoverable device-side e=
rror.
> > > > > + * @hdr: header for the event.
> > > > > + * @errno: error code describing the kind of error that occurred=
.
> > > > > + * @__reserved: must be set to zero by the device.
> > > > > + *
> > > > > + * Upon receiving this event, the session mentioned in the heade=
r is considered
> > > > > + * corrupted and closed.
> > > > > + */
> > > > > +struct virtio_media_event_error {
> > > > > +       struct virtio_media_event_header hdr;
> > > > > +       u32 errno;
> > > > > +       u32 __reserved;
> > > > > +};
> > > > > +
> > > > > +/* This is set to VIDEO_MAX_PLANES defined in include/uapi/linux=
/videodev2.h.
> > > > > + * It is renamed here to match the constant that is defined in t=
he virtio-media
> > > > > + * specification.
> > > > > + */
> > > > > +#define VIRTIO_MEDIA_MAX_PLANES VIDEO_MAX_PLANES
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_event_dqbuf - Dequeued buffer event.
> > > > > + * @hdr: header for the event.
> > > > > + * @buffer: &struct v4l2_buffer describing the buffer that has b=
een dequeued.
> > > > > + * @planes: plane information for the dequeued buffer.
> > > > > + *
> > > > > + * This event is used to signal that a buffer is not being used =
anymore by the
> > > > > + * device and is returned to the driver.
> > > > > + */
> > > > > +struct virtio_media_event_dqbuf {
> > > > > +       struct virtio_media_event_header hdr;
> > > > > +       struct v4l2_buffer buffer;
> > > > > +       struct v4l2_plane planes[VIRTIO_MEDIA_MAX_PLANES];
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct virtio_media_event_event - V4L2 event.
> > > > > + * @hdr: header for the event.
> > > > > + * @event: description of the event that occurred.
> > > > > + *
> > > > > + * This event signals that a V4L2 event has been emitted for a s=
ession.
> > > > > + */
> > > > > +struct virtio_media_event_event {
> > > > > +       struct virtio_media_event_header hdr;
> > > > > +       struct v4l2_event event;
> > > > > +};
> > > > > +
> > > > > +/* Maximum size of an event. We will queue descriptors of this s=
ize on the
> > > > > + * eventq.
> > > > > + */
> > > > > +#define VIRTIO_MEDIA_EVENT_MAX_SIZE sizeof(struct virtio_media_e=
vent_dqbuf)
> > > > > +
> > > > > +#endif // __VIRTIO_MEDIA_PROTOCOL_H
> > > > > --
> > > > > 2.55.0.737.g08866a6d13-goog
> > > > >
> > >
> >
>
