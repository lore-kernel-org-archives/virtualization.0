Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F65C678D5
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 09:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0380D4010F;
	Tue,  7 Mar 2023 09:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0380D4010F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S+QR1ImO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3QSV-edGJTgV; Tue,  7 Mar 2023 09:31:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69CA24013C;
	Tue,  7 Mar 2023 09:31:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69CA24013C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FFEAC0071;
	Tue,  7 Mar 2023 09:31:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09932C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5A2B4013C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5A2B4013C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wgrKQURZ20gQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:31:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 792064010F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 792064010F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678181469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROZo+Hm2nwaruvzp5tLmXfiaUhDZcP6CcaTEU4f9q20=;
 b=S+QR1ImOrGwQjLROwzTPinvPUwbWczYv+5HAS0pm3qLpbJ0Mtfzm9ESXsp8yv0yaJ17mwZ
 erR/qnq4Y/4+6N3ahnWqAd9eAsVV/r2qZolfAoW9TMxCGqlQ4qe0WeXqmftRnes8DJ/Fq6
 M2/mv0/meIN8aOtFdG1Z31ePSO02QWg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-HIEQn-7YOA2oArelcHgv9Q-1; Tue, 07 Mar 2023 04:31:08 -0500
X-MC-Unique: HIEQn-7YOA2oArelcHgv9Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 o15-20020a05600002cf00b002c54a27803cso2056307wry.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 01:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678181465;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ROZo+Hm2nwaruvzp5tLmXfiaUhDZcP6CcaTEU4f9q20=;
 b=MO4ksH/hYfhAFCXwMWXDFKoSWQyHPIt2IaMKOv+ehoIqd9NQM9DqdMz5BCYGpGI1pj
 P8lDhdQe89DflJXM5/ggB9qXwL6mElt1I7WgJhgyD+O+MNKbocswa4wmO+hLm543tgjy
 wG3HTtauJSd+cfS5ua1KiQY6hibvlGn2Bj/U5xwMAxO7pT5xmjgAochjdzk5eEY2khN4
 CxT/OA1TvYG/G6CBAI4BLTJ968HcZHKBi83YtTXdijt4BxRMRJPxdPTK3lKTeBFf1cCB
 fcyiN1P1LN1t4twPkxaKTa91cNayCv5nWKszLacy5Njsaf7PBmqxebkeR1jcEZiKCg20
 NQ3Q==
X-Gm-Message-State: AO0yUKV+X9Tw/Smw0Z7EYXABwSNBSnnU74dyYG5I/mU0TU/XXGp3x9wn
 ipIHxGQ5XrvbtXtI1SDukEbIPY/SJjqLnUMSrkCujpbHmAbMAtM+YLdHhIBukMRNor0Mzuzfd4M
 gaYrm0lnBfL2JN0sfJ7oIO7hWRlbfb3fYdWWsk6e/Qw==
X-Received: by 2002:a05:600c:474f:b0:3df:deb5:6ff5 with SMTP id
 w15-20020a05600c474f00b003dfdeb56ff5mr12407888wmo.24.1678181465559; 
 Tue, 07 Mar 2023 01:31:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8nRlHuSVvS3Y2XSx89Qt+KslRCgHQzi54Bw407xKpxIWyRaTqJXGns7ik+zzvdl7UyrHzyXg==
X-Received: by 2002:a05:600c:474f:b0:3df:deb5:6ff5 with SMTP id
 w15-20020a05600c474f00b003dfdeb56ff5mr12407858wmo.24.1678181465188; 
 Tue, 07 Mar 2023 01:31:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 e15-20020a5d594f000000b002c56046a3b5sm12073447wri.53.2023.03.07.01.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Mar 2023 01:31:04 -0800 (PST)
Date: Tue, 7 Mar 2023 10:31:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH v2 4/8] vringh: support VA with iotlb
Message-ID: <20230307093101.3nfxhadkyevszmyj@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-5-sgarzare@redhat.com>
 <CAJaqyWdeEzKnYuX-c348vVg0PpUH4y-e1dSLhRvYem=MEDKE=Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdeEzKnYuX-c348vVg0PpUH4y-e1dSLhRvYem=MEDKE=Q@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Mar 03, 2023 at 03:38:57PM +0100, Eugenio Perez Martin wrote:
>On Thu, Mar 2, 2023 at 12:35 PM Stefano Garzarella <sgarzare@redhat.com> w=
rote:
>>
>> vDPA supports the possibility to use user VA in the iotlb messages.
>> So, let's add support for user VA in vringh to use it in the vDPA
>> simulators.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Notes:
>>     v2:
>>     - replace kmap_atomic() with kmap_local_page() [see previous patch]
>>     - fix cast warnings when build with W=3D1 C=3D1
>>
>>  include/linux/vringh.h            |   5 +-
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c |   2 +-
>>  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   4 +-
>>  drivers/vhost/vringh.c            | 247 ++++++++++++++++++++++++------
>>  4 files changed, 205 insertions(+), 53 deletions(-)
>>
>> diff --git a/include/linux/vringh.h b/include/linux/vringh.h
>> index 1991a02c6431..d39b9f2dcba0 100644
>> --- a/include/linux/vringh.h
>> +++ b/include/linux/vringh.h
>> @@ -32,6 +32,9 @@ struct vringh {
>>         /* Can we get away with weak barriers? */
>>         bool weak_barriers;
>>
>> +       /* Use user's VA */
>> +       bool use_va;
>> +
>>         /* Last available index we saw (ie. where we're up to). */
>>         u16 last_avail_idx;
>>
>> @@ -279,7 +282,7 @@ void vringh_set_iotlb(struct vringh *vrh, struct vho=
st_iotlb *iotlb,
>>                       spinlock_t *iotlb_lock);
>>
>>  int vringh_init_iotlb(struct vringh *vrh, u64 features,
>> -                     unsigned int num, bool weak_barriers,
>> +                     unsigned int num, bool weak_barriers, bool use_va,
>>                       struct vring_desc *desc,
>>                       struct vring_avail *avail,
>>                       struct vring_used *used);
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/m=
lx5_vnet.c
>> index 3a0e721aef05..babc8dd171a6 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2537,7 +2537,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *m=
vdev)
>>
>>         if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
>>                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_fea=
tures,
>> -                                       MLX5_CVQ_MAX_ENT, false,
>> +                                       MLX5_CVQ_MAX_ENT, false, false,
>>                                         (struct vring_desc *)(uintptr_t)=
cvq->desc_addr,
>>                                         (struct vring_avail *)(uintptr_t=
)cvq->driver_addr,
>>                                         (struct vring_used *)(uintptr_t)=
cvq->device_addr);
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vd=
pa_sim.c
>> index 6a0a65814626..481eb156658b 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>> @@ -60,7 +60,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasi=
m, unsigned int idx)
>>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
>>         uint16_t last_avail_idx =3D vq->vring.last_avail_idx;
>>
>> -       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true,
>> +       vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true, =
false,
>>                           (struct vring_desc *)(uintptr_t)vq->desc_addr,
>>                           (struct vring_avail *)
>>                           (uintptr_t)vq->driver_addr,
>> @@ -81,7 +81,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>>         vq->cb =3D NULL;
>>         vq->private =3D NULL;
>>         vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_featur=
es,
>> -                         VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
>> +                         VDPASIM_QUEUE_MAX, false, false, NULL, NULL, N=
ULL);
>>
>>         vq->vring.notify =3D NULL;
>>  }
>> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
>> index 0ba3ef809e48..61c79cea44ca 100644
>> --- a/drivers/vhost/vringh.c
>> +++ b/drivers/vhost/vringh.c
>> @@ -1094,15 +1094,99 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
>>
>>  #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
>>
>> -static int iotlb_translate(const struct vringh *vrh,
>> -                          u64 addr, u64 len, u64 *translated,
>> -                          struct bio_vec iov[],
>> -                          int iov_size, u32 perm)
>> +static int iotlb_translate_va(const struct vringh *vrh,
>> +                             u64 addr, u64 len, u64 *translated,
>> +                             struct iovec iov[],
>> +                             int iov_size, u32 perm)
>>  {
>>         struct vhost_iotlb_map *map;
>>         struct vhost_iotlb *iotlb =3D vrh->iotlb;
>> +       u64 s =3D 0, last =3D addr + len - 1;
>>         int ret =3D 0;
>> +
>> +       spin_lock(vrh->iotlb_lock);
>> +
>> +       while (len > s) {
>> +               u64 size;
>> +
>> +               if (unlikely(ret >=3D iov_size)) {
>> +                       ret =3D -ENOBUFS;
>> +                       break;
>> +               }
>> +
>> +               map =3D vhost_iotlb_itree_first(iotlb, addr, last);
>> +               if (!map || map->start > addr) {
>> +                       ret =3D -EINVAL;
>> +                       break;
>> +               } else if (!(map->perm & perm)) {
>> +                       ret =3D -EPERM;
>> +                       break;
>> +               }
>> +
>> +               size =3D map->size - addr + map->start;
>> +               iov[ret].iov_len =3D min(len - s, size);
>> +               iov[ret].iov_base =3D (void __user *)(unsigned long)
>> +                                   (map->addr + addr - map->start);
>> +               s +=3D size;
>> +               addr +=3D size;
>> +               ++ret;
>> +       }
>> +
>> +       spin_unlock(vrh->iotlb_lock);
>> +
>> +       if (translated)
>> +               *translated =3D min(len, s);
>> +
>> +       return ret;
>> +}
>
>It seems to me iotlb_translate_va and iotlb_translate_pa are very
>similar, their only difference is that the argument is that iov is
>iovec instead of bio_vec. And how to fill it, obviously.
>
>It would be great to merge both functions, only differing with a
>conditional on vrh->use_va, or generics, or similar. Or, if following
>the style of the rest of vringh code, to provide a callback to fill
>iovec (although I like conditional more).
>
>However I cannot think of an easy way to perform that without long
>macros or type erasure.

I agree and I tried, but then I got messed up and let it go.

But maybe with the callback it shouldn't be too messy, I can try it and
see what comes out :-)

>
>> +
>> +static inline int copy_from_va(const struct vringh *vrh, void *dst, voi=
d *src,
>> +                              u64 len, u64 *translated)
>> +{
>> +       struct iovec iov[16];
>> +       struct iov_iter iter;
>> +       int ret;
>> +
>> +       ret =3D iotlb_translate_va(vrh, (u64)(uintptr_t)src, len, transl=
ated, iov,
>> +                                ARRAY_SIZE(iov), VHOST_MAP_RO);
>> +       if (ret =3D=3D -ENOBUFS)
>> +               ret =3D ARRAY_SIZE(iov);
>> +       else if (ret < 0)
>> +               return ret;
>> +
>> +       iov_iter_init(&iter, ITER_SOURCE, iov, ret, *translated);
>> +
>> +       return copy_from_iter(dst, *translated, &iter);
>
>Maybe a good baby step for DRY is to return the iov_iter in
>copy_from/to_va/pa here?

Good point! I'll try it.

>
>But I'm ok with this version too.
>
>Acked-by: Eugenio P=E9rez Martin <eperezma@redhat.com>

Thanks for the review!
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
