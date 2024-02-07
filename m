Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31013FF2
	for <virtualization@lists.linux.dev>; Wed,  7 Feb 2024 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276452; cv=none; b=g9zFg/fJFzmCDQWH1ky+6q2mYv9OXge6wN1DQJGJMXipbS7I6a37FRgOnd5lHQHzs9u9kK0O8LAES+cDqELliRnxuFRreTH8AfowTsAxQoaZgi6KVZ1QEVVPwDmqvOxQgPpPaTA/AlETc5Ldapn328MmHorR8XdOpjvq58Fh7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276452; c=relaxed/simple;
	bh=qsE//gaQh/ELevMsklLn/ApppxOTlK4xCHYMHM46s2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4RPSAOXv2ENO3glVdwSswzGO52/SYm7qShq+t0XUvIRhrCqVibgZd/6JXb4QOvkNLX/dyTmIJ9uuc00Vr/+spFsTG+BI2Xe0/ybr7CTQsWA0YVKnZyRWj3df4KSoEYavtbjpMh3mOGRQk5xJsdPRX7eZkEzM94H6MgHMwQh2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cB47q0Lw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cB47q0Lw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707276448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECyPdLbuQ8n+CIX5LY9BuiN4WFH5pGMhm7CI6F18Oro=;
	b=cB47q0LwVLp0f+1wvJ6ZyQGxoTr7qMwDQsOH6MFAk54gI5YSBUpxjFyfStZodn4WtM4T8N
	fhaC4CWzRqaLpUPo/US3azQuy8nYoZ/ERChsznwpHpy3IbVwtmndZcMhAiQwiaM+wEl6CO
	JueMgUKzxmpT57HnciBkAX+DAAifkik=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-YOy39ULoMaibACR7cXOJ9Q-1; Tue, 06 Feb 2024 22:27:27 -0500
X-MC-Unique: YOy39ULoMaibACR7cXOJ9Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6e054e01dfaso196145b3a.2
        for <virtualization@lists.linux.dev>; Tue, 06 Feb 2024 19:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707276446; x=1707881246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECyPdLbuQ8n+CIX5LY9BuiN4WFH5pGMhm7CI6F18Oro=;
        b=pRA/x1XMBPfXWeH65k9H9/bSWOjofX847NjhDPoc1PGMU6UH5wbyggjvzOXQgn+t+u
         VRnd6bp55nWhzzvFzeBMD4L/RnWsAzArfXyxIEC6qYFk76DnUlhVURDLh9Xy/4AgFOQ/
         ggBfDDkLqvtSv8XRfkFDjIXto8FatkQjC+6i6KA8T+io+Fa21JVEx8Y6oz1cGDBKeqwC
         OyCqOc7/GRLokYz+iGa0yLzySM+y401QK3bRr61j7ODRTZOQYRwmNd10sYRs23BmhIFQ
         AcoLDIuXNg+/hvFsepb19kfSRJVxEy1bsVvLV/mI7CT+IT4DzSflDIsY1IxG/V7djFyg
         teJg==
X-Gm-Message-State: AOJu0YzQ19sBsSVxckXPwneaepzKcknyhfk5nBeZA4GlPmV9iLqid5Xv
	zXyn50vJemtmN1Zf6EmnJCuaBZ/hrlx2LZipBnnathFviP8K4hs7L7/e/tllihJiw4GHKUkcDuY
	tdMcLkAsoIvvp1Flxf7fmCZ64CAjoTr1zaCh8bkzRh9jskTFjaL6GWln5/BMCtCZTUYzEM1unB/
	/jUn1Bc7z5UhaBM1stezOPdJuA383n2JP34q+skgM=
X-Received: by 2002:aa7:84c6:0:b0:6dd:84ce:4602 with SMTP id x6-20020aa784c6000000b006dd84ce4602mr1445737pfn.6.1707276446478;
        Tue, 06 Feb 2024 19:27:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOduHPoLP4mCVG39rBl1Z8IToYghCDdc8bbnZRY4nXuhv/6H/c+FYVQ3yUyKyTYydLTVyAuvDaqusFQbjMZgQ=
X-Received: by 2002:aa7:84c6:0:b0:6dd:84ce:4602 with SMTP id
 x6-20020aa784c6000000b006dd84ce4602mr1445717pfn.6.1707276446144; Tue, 06 Feb
 2024 19:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240206145154.118044-1-sgarzare@redhat.com>
In-Reply-To: <20240206145154.118044-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Feb 2024 11:27:14 +0800
Message-ID: <CACGkMEs-FAz7Xv7j6k3grq97q9qO18Em2bLDS4qBaCDZS7+gbQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: fail enabling virtqueue in certain conditions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhu Lingshan <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 10:52=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
> the driver to enable virtqueue before setting DRIVER_OK. If the driver
> tries anyway, better to fail right away as soon as we get the ioctl.
> Let's also update the documentation to make it clearer.
>
> We had a problem in QEMU for not meeting this requirement, see
> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.co=
m/

Maybe it's better to only enable cvq when the backend supports
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK. Eugenio, any comment on this?

>
> Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK=
 backend feature")
> Cc: eperezma@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/uapi/linux/vhost_types.h | 3 ++-
>  drivers/vhost/vdpa.c             | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index d7656908f730..5df49b6021a7 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -182,7 +182,8 @@ struct vhost_vdpa_iova_range {
>  /* Device can be resumed */
>  #define VHOST_BACKEND_F_RESUME  0x5
>  /* Device supports the driver enabling virtqueues both before and after
> - * DRIVER_OK
> + * DRIVER_OK. If this feature is not negotiated, the virtqueues must be
> + * enabled before setting DRIVER_OK.
>   */
>  #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
>  /* Device may expose the virtqueue's descriptor area, driver area and
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..1fba305ba8c1 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -651,6 +651,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa=
 *v, unsigned int cmd,
>         case VHOST_VDPA_SET_VRING_ENABLE:
>                 if (copy_from_user(&s, argp, sizeof(s)))
>                         return -EFAULT;
> +               if (!vhost_backend_has_feature(vq,
> +                       VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) &&
> +                   (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +                       return -EINVAL;

As discussed, without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we don't
know if parents can do vq_ready after driver_ok.

So maybe we need to keep this behaviour to unbreak some "legacy" userspace?

For example ifcvf did:

static void ifcvf_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev,
                                    u16 qid, bool ready)
{
  struct ifcvf_hw *vf =3D vdpa_to_vf(vdpa_dev);

        ifcvf_set_vq_ready(vf, qid, ready);
}

And it did:

void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready)
{
        struct virtio_pci_common_cfg __iomem *cfg =3D hw->common_cfg;

        vp_iowrite16(qid, &cfg->queue_select);
        vp_iowrite16(ready, &cfg->queue_enable);
}

Though it didn't advertise VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK?

Adding LingShan for more thought.

Thanks

>                 ops->set_vq_ready(vdpa, idx, s.num);
>                 return 0;
>         case VHOST_VDPA_GET_VRING_GROUP:
> --
> 2.43.0
>

