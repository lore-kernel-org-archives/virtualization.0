Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E32F5308
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102965; cv=none; b=H26ubybKWrCwKiZHunDFXraqf0rT6M9drJh+b5ayd18UR8V/9zciUT8VjP4GB9wVJ+WSrDfc0OIcmkdbXTEXPKJHq4P7fZm5hP6Upgy84pSeKz9svqDDyx1QfiiEne6l/SwmMUzIC1+pUrFElqqAfEC8X0DQ++/Anrqnm/mOTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102965; c=relaxed/simple;
	bh=H2YVRx21awCGxO5yG3V6ekKCwDhUBJ/VCw98EpAmHeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlRSOWfn7Opj0c1Bt+Sq6wdT8lTqDuCHLj0/5DQPJMV48LJjqIzZ4ErpaDLOB1fUCff5PRI3+Bp/gGcBA3MNnlphgBA1BMc8YTGF2oxqgy3qkgPSzr84cOiMRWyirWge2VnrmXrGMzQaSvvGATgFWaI8eppRCPDpeUlwT3zcdDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWu6MQZ1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWu6MQZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770102963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hOZorHoPjkoVpWCCOvI6k+RcLdfxGlvax8aFQ5mrpk=;
	b=MWu6MQZ1C5TyhSIss7VrW7Q/EpJeTG/vJoBbEfjXmB8WxIh83Of2a3cl5ZodTPMJcmchki
	ET7OLYKom5X9QpbjNcr+OMIOcI/OgQO8PrnQkbeKMJ6IgdtjUnMDWpgAMsXjRwjCKWNRxa
	ah8ifd0FXmAPpSpc40o/Uo+/rNs+mAE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-7cg2dOlzNz6sQH1EsUbjBA-1; Tue, 03 Feb 2026 02:16:01 -0500
X-MC-Unique: 7cg2dOlzNz6sQH1EsUbjBA-1
X-Mimecast-MFC-AGG-ID: 7cg2dOlzNz6sQH1EsUbjBA_1770102961
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-794c46b4679so25427087b3.0
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 23:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770102961; x=1770707761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4hOZorHoPjkoVpWCCOvI6k+RcLdfxGlvax8aFQ5mrpk=;
        b=t5sDWLeFzkhCZl08nKB5XEXv+YAjkMIAoM4iJIvrmknpnnIKQMh33tbXBBHiFod86u
         8K55+iwqR/11RoRNUYPyUeotJrQijT6EF8NAE0Dsq4TiJxPP7ONPJz94PctkgvL9tPOs
         F6X6XFzODtf/qPteUdd3G2684aKnV41ZNMoaGf6J4Uz4QRIJs0UWQTWJaY0tVwP7U21q
         /gw5+2BsLD9OofKrpC1m6rIE9TSE0hFchfQUR55YQYatHaL5nUSEjRJf0FzonQcIYpWE
         LUz1jWsKixjXKHk7aCrt5Oyxe3n7Cm/0IYjRMxV0og/CVMiwrQEf4zBURgOVJvvshitP
         e65A==
X-Forwarded-Encrypted: i=1; AJvYcCXnoIE4W5+t3tz3oO89u5CyWdfxRS7uP814jjE2JhVeGNN0ru8bChxtMAfvM7GtSCtUyNBjwHqkfI7RPUC8UA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcWKtcOEJhWHg8Kgmgx/LPmn8HxuPgH4Qj0vkdkTVjYALQ4kp/
	JvdRz1tQZ1LcJTz1S7K5aDfUoiKpwNSWy4T+Od0JO7++QcJwTheGdcy4xQ4GoBWCecofTsnOt3X
	xl1KSzWwWVpNEYyRhFEkzboQQVe5iFtQmYxWtJKGYx3N1saljENB2cemSclDFp11nKwiNLTa7YX
	vhUTL2BKOnKmucYr3Ue+vfsxM3OCXg/Ntbem+G3wzO34E=
X-Gm-Gg: AZuq6aJ0ywGQjODsIP4oIEG6sbx3U8FNQN6qmLDNO2OtOB6xy1RrKh7x7Lp4O/5t6Xx
	W8PcszK2pqGlsj4BnJRrwfYMCh0ifbagnIwpGvxtN0jIGwW1vnbulXegICIaQ3ZuxRZSZD4Irs4
	sXAMiLDXShn3TQSktswMTl4/dNUCw/LFAE5LDLV5Q8dg/TpLLOBZ76xHXGzbcJIa/q7g==
X-Received: by 2002:a05:690c:dd6:b0:794:ef16:6f3 with SMTP id 00721157ae682-794ef160d85mr10898237b3.53.1770102961163;
        Mon, 02 Feb 2026 23:16:01 -0800 (PST)
X-Received: by 2002:a05:690c:dd6:b0:794:ef16:6f3 with SMTP id
 00721157ae682-794ef160d85mr10898117b3.53.1770102960694; Mon, 02 Feb 2026
 23:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202224835.559538-1-arnd@kernel.org> <20260202224835.559538-2-arnd@kernel.org>
In-Reply-To: <20260202224835.559538-2-arnd@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Feb 2026 08:15:24 +0100
X-Gm-Features: AZwV_QhioeKVo0UHD4zPqgXZ6BMlW3T-Adumri5XR7X2NLM8-07MwpFVfjfCzmg
Message-ID: <CAJaqyWfaX8wiAR_gcATxcB+AfvyyitTVRL9eEkpS1nATqOaWKA@mail.gmail.com>
Subject: Re: [PATCH 2/2] [v2] vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Arnd Bergmann <arnd@arndb.de>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hUiLxE4UVxJpNnIDBIkIPrCsmt8PZxWqZeA7GOv0acA_1770102961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 11:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> These two ioctls are incompatible on 32-bit x86 userspace, because
> the data structures are shorter than they are on 64-bit.
>
> Add a proper .compat_ioctl handler for x86 that reads the structures
> with the smaller padding before calling the internal handlers.
>
> Fixes: ad146355bfad ("vduse: Support querying information of IOVA regions=
")
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")

I can work on merging the new code of vduse_dev_compat_ioctl and
vduse_dev_ioctl on top. If this fix makes it correct,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The code is directly copied from the native ioctl handler, but I
> did not test this with actual x86-32 userspace, so please review
> carefully.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 123 ++++++++++++++++++++++++++++-
>  1 file changed, 122 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 405d59610f76..3ada167ac260 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1618,6 +1618,127 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>         return ret;
>  }
>
> +/*
> + * i386 has different alignment constraints than x86_64,
> + * so there are only 3 bytes of padding instead of 7.
> + */
> +struct compat_vduse_iotlb_entry {
> +       compat_u64 offset;
> +       compat_u64 start;
> +       compat_u64 last;
> +       __u8 perm;
> +       __u8 padding[__alignof__(compat_u64) - 1];
> +};
> +#define COMPAT_VDUSE_IOTLB_GET_FD      _IOWR(VDUSE_BASE, 0x10, struct co=
mpat_vduse_iotlb_entry)
> +
> +struct compat_vduse_vq_info {
> +       __u32 index;
> +       __u32 num;
> +       compat_u64 desc_addr;
> +       compat_u64 driver_addr;
> +       compat_u64 device_addr;
> +       union {
> +               struct vduse_vq_state_split split;
> +               struct vduse_vq_state_packed packed;
> +       };
> +       __u8 ready;
> +       __u8 padding[__alignof__(compat_u64) - 1];
> +} __uapi_arch_align;
> +#define COMPAT_VDUSE_VQ_GET_INFO       _IOWR(VDUSE_BASE, 0x15, struct co=
mpat_vduse_vq_info)
> +
> +static long vduse_dev_compat_ioctl(struct file *file, unsigned int cmd,
> +                                  unsigned long arg)
> +{
> +       struct vduse_dev *dev =3D file->private_data;
> +       void __user *argp =3D (void __user *)arg;
> +       int ret;
> +
> +       if (!IS_ENABLED(CONFIG_X86_64))
> +               return vduse_dev_ioctl(file, cmd,
> +                                      (unsigned long)compat_ptr(arg));
> +
> +       if (unlikely(dev->broken))
> +               return -EPERM;
> +
> +       switch (cmd) {
> +       case COMPAT_VDUSE_IOTLB_GET_FD: {
> +               struct vduse_iotlb_entry_v2 entry =3D {0};
> +               struct file *f =3D NULL;
> +
> +               ret =3D -EFAULT;
> +               if (copy_from_user(&entry, argp, _IOC_SIZE(cmd)))
> +                       break;
> +
> +               ret =3D vduse_dev_iotlb_entry(dev, &entry, &f, NULL);
> +               if (ret)
> +                       break;
> +
> +               ret =3D -EINVAL;
> +               if (!f)
> +                       break;
> +
> +               ret =3D copy_to_user(argp, &entry, _IOC_SIZE(cmd));
> +               if (ret) {
> +                       ret =3D -EFAULT;
> +                       fput(f);
> +                       break;
> +               }
> +               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.perm=
));
> +               fput(f);
> +               break;
> +       }
> +       case COMPAT_VDUSE_VQ_GET_INFO: {
> +               struct vduse_vq_info vq_info =3D {};
> +               struct vduse_virtqueue *vq;
> +               u32 index;
> +
> +               ret =3D -EFAULT;
> +               if (copy_from_user(&vq_info, argp,
> +                                  sizeof(struct compat_vduse_vq_info)))
> +                       break;
> +
> +               ret =3D -EINVAL;
> +               if (vq_info.index >=3D dev->vq_num)
> +                       break;
> +
> +               index =3D array_index_nospec(vq_info.index, dev->vq_num);
> +               vq =3D dev->vqs[index];
> +               vq_info.desc_addr =3D vq->desc_addr;
> +               vq_info.driver_addr =3D vq->driver_addr;
> +               vq_info.device_addr =3D vq->device_addr;
> +               vq_info.num =3D vq->num;
> +
> +               if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED))=
 {
> +                       vq_info.packed.last_avail_counter =3D
> +                               vq->state.packed.last_avail_counter;
> +                       vq_info.packed.last_avail_idx =3D
> +                               vq->state.packed.last_avail_idx;
> +                       vq_info.packed.last_used_counter =3D
> +                               vq->state.packed.last_used_counter;
> +                       vq_info.packed.last_used_idx =3D
> +                               vq->state.packed.last_used_idx;
> +               } else
> +                       vq_info.split.avail_index =3D
> +                               vq->state.split.avail_index;
> +
> +               vq_info.ready =3D vq->ready;
> +
> +               ret =3D -EFAULT;
> +               if (copy_to_user(argp, &vq_info,
> +                   sizeof(struct compat_vduse_vq_info)))
> +                       break;
> +
> +               ret =3D 0;
> +               break;
> +       }
> +       default:
> +               ret =3D -ENOIOCTLCMD;
> +               break;
> +       }
> +
> +       return vduse_dev_ioctl(file, cmd, (unsigned long)compat_ptr(arg))=
;
> +}
> +
>  static int vduse_dev_release(struct inode *inode, struct file *file)
>  {
>         struct vduse_dev *dev =3D file->private_data;
> @@ -1678,7 +1799,7 @@ static const struct file_operations vduse_dev_fops =
=3D {
>         .write_iter     =3D vduse_dev_write_iter,
>         .poll           =3D vduse_dev_poll,
>         .unlocked_ioctl =3D vduse_dev_ioctl,
> -       .compat_ioctl   =3D compat_ptr_ioctl,
> +       .compat_ioctl   =3D PTR_IF(IS_ENABLED(CONFIG_COMPAT), vduse_dev_c=
ompat_ioctl),
>         .llseek         =3D noop_llseek,
>  };
>
> --
> 2.39.5
>

