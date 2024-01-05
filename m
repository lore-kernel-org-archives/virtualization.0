Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A224B5F
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsTUhiny"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B96A782884
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 09:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B96A782884
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsTUhiny
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5dUltvG60-Kk
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 09:59:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6499782883
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 09:59:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6499782883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704448787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45uAMmO7xDbSFGvzDA+/LGFjUxCqudPotVlBnaUDubw=;
	b=NsTUhiny0zWsLN1N69KMQpLgZ9vMQYVSn+qpBw3JWNBJYGesxKSZGv09/vaBFokFC+Ahx/
	cRYaSMXDOji5ArccAiykBR9BksFPkIqjKV/9a7AYi0UF+zdRIIA1i/C0wBd0BKokyfQcqN
	x34b5GpPhdjaYlnGuPKDGOT7yAZw5Js=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-gqDwY51rP520rXSi_T4RoQ-1; Fri, 05 Jan 2024 04:59:40 -0500
X-MC-Unique: gqDwY51rP520rXSi_T4RoQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dbdca3685aeso531313276.0
        for <virtualization@lists.linux-foundation.org>; Fri, 05 Jan 2024 01:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448780; x=1705053580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45uAMmO7xDbSFGvzDA+/LGFjUxCqudPotVlBnaUDubw=;
        b=X0HeemKq+ArLMDhrCEqV/U34DhvwzE6H9Bcr7locn/RK240GDvZhfkYj3c5G2hOWAs
         O+Mg10V1WWN/P3Q2iVvM4ok+YIWGBYTysnCWjbvkYug+vqCaZZqMOGveItx/07WQnPWz
         XM06WnVigY4T1zXqx4/hqY4401kTEmtKU1YW8V3sCKQy85OVn4nieMw+TphZywTEvGL4
         TQkY8GCQVCG4wU56I6kaQGMUoXhWruTKz1hZz+n9LnwcPP/+HbXCZv6gxcEzScEuxRGL
         EQD4nD20fWMo0offJskZ/W+V+XDOfgg3jtIffGHdn31HPUTvBfY46YhZRY6etY2c7Ipp
         hYgw==
X-Gm-Message-State: AOJu0Yy6oQxAx85Vow4bXIH5dGwhuKIhc/MGaU33/8WHFFGWpgeC0m8c
	ARU+ZZ3J0WyiKkWcFyMmgUuNoYvAhNFfKsWgd/VytAtgtuQzIKddF+3sI/j4omV9Ki+HaUUkOcR
	+QFxtKh71nGd3MYFnM6JqbNOMtOW5lpLxX3sTMoMs+hBGdoY842K/6RjXdiQh9bEgvA==
X-Received: by 2002:a5b:383:0:b0:dbd:abc3:8f86 with SMTP id k3-20020a5b0383000000b00dbdabc38f86mr1210830ybp.32.1704448780180;
        Fri, 05 Jan 2024 01:59:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh4FZh36MQfTA/ZNynVxWMGivw8xsHz78oLX07j3kR/sf0wo08FIofpLtlQKq8zDWRDJ+l3DXenZ+ck0owq40=
X-Received: by 2002:a5b:383:0:b0:dbd:abc3:8f86 with SMTP id
 k3-20020a5b0383000000b00dbdabc38f86mr1210823ybp.32.1704448779914; Fri, 05 Jan
 2024 01:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com>
 <20240104153753.2931026-3-maxime.coquelin@redhat.com> <CACGkMEtmTY0ux8pw8VQ8SAdgGty=rM1VRkh6c-qBVSaqhYuURw@mail.gmail.com>
 <888255d7-e45b-44db-8561-5e9f386603c3@redhat.com>
In-Reply-To: <888255d7-e45b-44db-8561-5e9f386603c3@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Jan 2024 10:59:03 +0100
Message-ID: <CAJaqyWfrO3c9GD2k+aX=fA8OQLg2aQPHHb4WyTbE09KkmoOesA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] vduse: Temporarily fail if control queue features requested
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 9:12=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 1/5/24 03:45, Jason Wang wrote:
> > On Thu, Jan 4, 2024 at 11:38=E2=80=AFPM Maxime Coquelin
> > <maxime.coquelin@redhat.com> wrote:
> >>
> >> Virtio-net driver control queue implementation is not safe
> >> when used with VDUSE. If the VDUSE application does not
> >> reply to control queue messages, it currently ends up
> >> hanging the kernel thread sending this command.
> >>
> >> Some work is on-going to make the control queue
> >> implementation robust with VDUSE. Until it is completed,
> >> let's fail features check if any control-queue related
> >> feature is requested.
> >>
> >> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> >> ---
> >>   drivers/vdpa/vdpa_user/vduse_dev.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_us=
er/vduse_dev.c
> >> index 0486ff672408..94f54ea2eb06 100644
> >> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >> @@ -28,6 +28,7 @@
> >>   #include <uapi/linux/virtio_config.h>
> >>   #include <uapi/linux/virtio_ids.h>
> >>   #include <uapi/linux/virtio_blk.h>
> >> +#include <uapi/linux/virtio_ring.h>
> >>   #include <linux/mod_devicetable.h>
> >>
> >>   #include "iova_domain.h"
> >> @@ -46,6 +47,15 @@
> >>
> >>   #define IRQ_UNBOUND -1
> >>
> >> +#define VDUSE_NET_INVALID_FEATURES_MASK         \
> >> +       (BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |        \
> >> +        BIT_ULL(VIRTIO_NET_F_CTRL_RX)   |      \
> >> +        BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |      \
> >> +        BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) | \
> >> +        BIT_ULL(VIRTIO_NET_F_MQ) |             \
> >> +        BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |  \
> >> +        BIT_ULL(VIRTIO_NET_F_RSS))
> >
> > We need to make this as well:
> >
> > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
>
> I missed it, and see others have been added in the Virtio spec
> repository (BTW, I see this specific one is missing in the dependency
> list [0], I will submit a patch).
>
> I wonder if it is not just simpler to just check for
> VIRTIO_NET_F_CTRL_VQ is requested. As we fail instead of masking out,
> the VDUSE driver won't be the one violating the spec so it should be
> good?
>
> It will avoid having to update the mask if new features depending on it
> are added (or forgetting to update it).
>
> WDYT?
>

I think it is safer to work with a whitelist, instead of a blacklist.
As any new feature might require code changes in QEMU. Is that
possible?

> Thanks,
> Maxime
>
> [0]:
> https://github.com/oasis-tcs/virtio-spec/blob/5fc35a7efb903fc352da81a6d2b=
e5c01810b68d3/device-types/net/description.tex#L129
> > Other than this,
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > Thanks
> >
> >> +
> >>   struct vduse_virtqueue {
> >>          u16 index;
> >>          u16 num_max;
> >> @@ -1680,6 +1690,9 @@ static bool features_is_valid(struct vduse_dev_c=
onfig *config)
> >>          if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
> >>                          (config->features & (1ULL << VIRTIO_BLK_F_CON=
FIG_WCE)))
> >>                  return false;
> >> +       else if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> >> +                       (config->features & VDUSE_NET_INVALID_FEATURES=
_MASK))
> >> +               return false;
> >>
> >>          return true;
> >>   }
> >> --
> >> 2.43.0
> >>
> >
>
>

