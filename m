Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D918C02E
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758874570; cv=none; b=b+QvLPyfIERo3zz01Qb1iksRETZkG9UyhJjMnFT960AFe5VK5zs5vdZZKKJUBi8nBqgkCEnO02IPh40BXuzKlgh3l1qNrg8cee3OZHjHckuzHLAYSrA9dRrPh5nYNa/+zmEDV48OQaJxJMm3G+i3WQLdRL8cW9Nsq2FrqCK94ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758874570; c=relaxed/simple;
	bh=PAWqAMgCX8zKBiBa2Vocv2kUpAhOIGrJa2cAM8McDj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrqrqKzEGUqo5rtck2/7qTxgVilLu8Gru9xDLubnpbqwArpfA1BaTfkHnF+xiBcGESsokOYVrCBEY+71NWtfgGmmHu4r8SrBwM95Y5MVZ8zb3isCusN3DTMSvo8hOA/ALLqwh2YEAaqrD29oc2O4rMMZEO6ZJnJK97hNLKzKCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edoE8hh2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edoE8hh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758874566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iApw1NqrgZL1fh1MtbJLVbGmqzgFuHm0wJ8kzPM515E=;
	b=edoE8hh2r5OYAUdOxlSJSWi0lM6BsbC1zgmsDwCC9xyBeaSIp6yAAFdHP4CvGAYpL/6CB8
	wMHkKTwuOv5wrVrtG9TYMqmZrGdxtFie8cvIzVmNo24jkHJON4B3ePSJydhYkRJiEikbpc
	D/dEfFqnJhCp92xvb5nmeGOGaB0ycvg=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-K_ietin0PN66GqNgVVFQmw-1; Fri, 26 Sep 2025 04:15:59 -0400
X-MC-Unique: K_ietin0PN66GqNgVVFQmw-1
X-Mimecast-MFC-AGG-ID: K_ietin0PN66GqNgVVFQmw_1758874559
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-60f47bb49f1so2016706d50.2
        for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 01:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758874558; x=1759479358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iApw1NqrgZL1fh1MtbJLVbGmqzgFuHm0wJ8kzPM515E=;
        b=LOCC+UvzALWBLegVlzUS282oB9c3hQjQZvk5Frb7dh0imdCDyijBorL8Mj3CEcFed5
         60OJD6UdgWJ+XBpO4+RuDLETYZ4bCcQkpF9X1Db4OiyqL7Jrm9ykgkm7f3cNEkXmrtth
         iKxC+3cBsLUzMimAsfv+F1DXJMji7McQ5alKdmu3HWzcu2ZiUYCcuGjd68UmrluPdhom
         C11GD/X9ye4qzC0Y+4LpBGZ4Axbcs877QbpnrPoP5PI+YW8DcDYntBzGHAVikFMP2tMa
         IK2JtxVo6rMokGPfIzxFs9UCioHf6QTmQoNZ6HfxnI+0bUhQAjHHhA8SZ+jOZ7B/X0HX
         DrVw==
X-Forwarded-Encrypted: i=1; AJvYcCWVrvMJNAaqLJbX+cUTEVTBbiGMlbwLSGkoPHDAAa/ut0sE3VJ4Sau5z7cBB1/vNwvWzVPsmOM5bGkhNWlFRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmXfhIoHSjhboZepMnTmY7SBi4Z4VeUUtvgJPVVOh9JyYsWFUQ
	xN7iBqNMAbqBhio0p1EetfH5txnYOq5xwJUCdZpCqOaP0jMbPe5iJVaJGi8xJsm0vd0k4WDhIKw
	1TZ6QHtNgwBoNZJkvi5h2sghCwn9tDe6pZ/cSGZyFk8PPdnPA8r6Y7L4OgnI/eBigMWvXgcaE7s
	YE0rJXkcC9m50SGIX/wvyFHqOejbRPS1I0dsEmAnacbQc+JyKldGk=
X-Gm-Gg: ASbGnctB630Ad0XZkY75ooGF1OFQ6drfjY0A+GVuCkGdf58FFCqA7liJ5TGqOy8uoF+
	yS1F6SE4ym7iTI4cGXypdVOJaucBieSE2PXbSorOUnrv9NsR/xlN8ELmA2U5YMcP12LDzU0MReo
	G9AsgBnFt+/dCDXIwxFc3EiIxDP3oHH2upSlZGmR4479lSAzE3MFLcTGe0KpQ+isXlJoPNZ2Ikf
	XAnSKbS
X-Received: by 2002:a53:d00a:0:b0:5f4:55cb:80d4 with SMTP id 956f58d0204a3-6361a750311mr5561846d50.17.1758874557960;
        Fri, 26 Sep 2025 01:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4SbSK9j79FVPhMlNlBU7vMW5idfjSWimDCArExOIwfFywiP0sYJvUsgWC46gr4tHACGVIsgCwCmpGOh74cJA=
X-Received: by 2002:a53:d00a:0:b0:5f4:55cb:80d4 with SMTP id
 956f58d0204a3-6361a750311mr5561808d50.17.1758874557500; Fri, 26 Sep 2025
 01:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925091335.1964283-1-eperezma@redhat.com> <20250925091335.1964283-4-eperezma@redhat.com>
 <CACGkMEtXOOLuf01qx_MbptjvyZe0jLTgnPU5JDQ0SOUXx54KYg@mail.gmail.com>
In-Reply-To: <CACGkMEtXOOLuf01qx_MbptjvyZe0jLTgnPU5JDQ0SOUXx54KYg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Sep 2025 10:15:20 +0200
X-Gm-Features: AS18NWCopejN_FK7ENozNsFySeBw-nz8CXI6PUBCArm2jbv5RYVBc6ZzT_gwC0E
Message-ID: <CAJaqyWfx8L6rt+sEeVjdPQ3y0=c_8gSi5_d1TLUopq5PmqAY9w@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] vduse: add vq group support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 70peAhYgaVkHyqnTGeI4dOBw2j4pWlbvR6VOtZ8Fb2s_1758874559
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 9:42=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Sep 25, 2025 at 5:14=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > This allows sepparate the different virtqueues in groups that shares th=
e
> > same address space.  Asking the VDUSE device for the groups of the vq a=
t
> > the beginning as they're needed for the DMA API.
> >
> > Allocating 3 vq groups as net is the device that need the most groups:
> > * Dataplane (guest passthrough)
> > * CVQ
> > * Shadowed vrings.
> >
> > Future versions of the series can include dynamic allocation of the
> > groups array so VDUSE can declare more groups.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v4:
> > * Revert the "invalid vq group" concept and assume 0 if not set (Jason)=
.
> > * Make config->ngroups =3D=3D 0 invalid (Jason).
> >
> > v3:
> > * Make the default group an invalid group as long as VDUSE device does
> >   not set it to some valid u32 value.  Modify the vdpa core to take tha=
t
> >   into account (Jason).
> > * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
> >
> > v2:
> > * Now the vq group is in vduse_vq_config struct instead of issuing one
> >   VDUSE message per vq.
> >
> > v1:
> > * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lowe=
r
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove the descs vq group capability as it will not be used and we ca=
n
> >   add it on top.
> > * Do not ask for vq groups in number of vq groups < 2.
> > * Move the valid vq groups range check to vduse_validate_config.
> >
> > RFC v2:
> > * Cache group information in kernel, as we need to provide the vq map
> >   tokens properly.
> > * Add descs vq group to optimize SVQ forwarding and support indirect
> >   descriptors out of the box.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 46 ++++++++++++++++++++++++++----
> >  drivers/vhost/vdpa.c               | 11 +++++--
> >  include/uapi/linux/vduse.h         | 12 ++++++--
> >  3 files changed, 58 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 2b6a8958ffe0..3415217cb3a9 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -40,6 +40,7 @@
> >  #define DRV_LICENSE  "GPL v2"
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > +#define VDUSE_DEV_MAX_GROUPS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -59,6 +60,7 @@ struct vduse_virtqueue {
> >         struct vdpa_vq_state state;
> >         bool ready;
> >         bool kicked;
> > +       u32 vq_group;
> >         spinlock_t kick_lock;
> >         spinlock_t irq_lock;
> >         struct eventfd_ctx *kickfd;
> > @@ -115,6 +117,7 @@ struct vduse_dev {
> >         u8 status;
> >         u32 vq_num;
> >         u32 vq_align;
> > +       u32 ngroups;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> > @@ -456,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
> >                 vq->driver_addr =3D 0;
> >                 vq->device_addr =3D 0;
> >                 vq->num =3D 0;
> > +               vq->vq_group =3D 0;
> >                 memset(&vq->state, 0, sizeof(vq->state));
> >
> >                 spin_lock(&vq->kick_lock);
> > @@ -593,6 +597,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> >         return 0;
> >  }
> >
> > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +       if (dev->api_version < VDUSE_API_VERSION_1)
> > +               return 0;
> > +
> > +       return dev->vqs[idx]->vq_group;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -790,6 +804,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > +       .get_vq_group           =3D vduse_get_vq_group,
> >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > @@ -1253,12 +1268,24 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                 if (config.index >=3D dev->vq_num)
> >                         break;
> >
> > -               if (!is_mem_zero((const char *)config.reserved,
> > -                                sizeof(config.reserved)))
> > +               if (dev->api_version < VDUSE_API_VERSION_1 && config.gr=
oup)
> > +                       break;
> > +
> > +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > +                       if (config.group > dev->ngroups)
> > +                               break;
>
> This should be ">=3D".
>

Right, good catch!

> > +                       if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > +                               break;
> > +               }
> > +
> > +               if (config.reserved1 ||
> > +                   !is_mem_zero((const char *)config.reserved2,
> > +                                sizeof(config.reserved2)))
> >                         break;
> >
> >                 index =3D array_index_nospec(config.index, dev->vq_num)=
;
> >                 dev->vqs[index]->num_max =3D config.max_size;
> > +               dev->vqs[index]->vq_group =3D config.group;
> >                 ret =3D 0;
> >                 break;
> >         }
> > @@ -1738,12 +1765,20 @@ static bool features_is_valid(struct vduse_dev_=
config *config)
> >         return true;
> >  }
> >
> > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > +                                 u64 api_version)
> >  {
> >         if (!is_mem_zero((const char *)config->reserved,
> >                          sizeof(config->reserved)))
> >                 return false;
> >
> > +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +               return false;
> > +
> > +       if (api_version >=3D VDUSE_API_VERSION_1 &&
> > +           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS=
))
> > +               return false;
> > +
> >         if (config->vq_align > PAGE_SIZE)
> >                 return false;
> >
> > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +       dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups;
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> >                 goto err_str;
> > @@ -1937,7 +1973,7 @@ static long vduse_ioctl(struct file *file, unsign=
ed int cmd,
> >                         break;
> >
> >                 ret =3D -EINVAL;
> > -               if (vduse_validate_config(&config) =3D=3D false)
> > +               if (!vduse_validate_config(&config, control->api_versio=
n))
> >                         break;
> >
> >                 buf =3D vmemdup_user(argp + size, config.config_size);
> > @@ -2018,7 +2054,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
dev, const char *name)
> >
> >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> >                                  &vduse_vdpa_config_ops, &vduse_map_ops=
,
> > -                                1, 1, name, true);
> > +                                dev->ngroups, 1, name, true);
> >         if (IS_ERR(vdev))
> >                 return PTR_ERR(vdev);
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 05a481e4c385..6305382eacbb 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/vdpa.h>
> >  #include <linux/nospec.h>
> >  #include <linux/vhost.h>
> > +#include <linux/types.h>
> >
> >  #include "vhost.h"
> >
> > @@ -657,16 +658,20 @@ static long vhost_vdpa_vring_ioctl(struct vhost_v=
dpa *v, unsigned int cmd,
> >                         return -EFAULT;
> >                 ops->set_vq_ready(vdpa, idx, s.num);
> >                 return 0;
> > -       case VHOST_VDPA_GET_VRING_GROUP:
> > +       case VHOST_VDPA_GET_VRING_GROUP: {
> > +               u64 group;
> > +
> >                 if (!ops->get_vq_group)
> >                         return -EOPNOTSUPP;
> >                 s.index =3D idx;
> > -               s.num =3D ops->get_vq_group(vdpa, idx);
> > -               if (s.num >=3D vdpa->ngroups)
> > +               group =3D ops->get_vq_group(vdpa, idx);
> > +               if (group >=3D vdpa->ngroups || group > U32_MAX || grou=
p < 0)
> >                         return -EIO;
> >                 else if (copy_to_user(argp, &s, sizeof(s)))
> >                         return -EFAULT;
> > +               s.num =3D group;
>
> I guess this won't work.
>

Right, and it has a lot of dead code from the s64 conversion. Fixing it.

Should I send the whole series again or a patch on top?

> >                 return 0;
> > +       }
> >         case VHOST_VDPA_GET_VRING_DESC_GROUP:
> >                 if (!vhost_vdpa_has_desc_group(v))
> >                         return -EOPNOTSUPP;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index ccb92a1efce0..a3d51cf6df3a 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -31,6 +31,7 @@
> >   * @features: virtio features
> >   * @vq_num: the number of virtqueues
> >   * @vq_align: the allocation alignment of virtqueue's metadata
> > + * @ngroups: number of vq groups that VDUSE device declares
> >   * @reserved: for future use, needs to be initialized to zero
> >   * @config_size: the size of the configuration space
> >   * @config: the buffer of the configuration space
> > @@ -45,7 +46,8 @@ struct vduse_dev_config {
> >         __u64 features;
> >         __u32 vq_num;
> >         __u32 vq_align;
> > -       __u32 reserved[13];
> > +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > +       __u32 reserved[12];
> >         __u32 config_size;
> >         __u8 config[];
> >  };
> > @@ -122,14 +124,18 @@ struct vduse_config_data {
> >   * struct vduse_vq_config - basic configuration of a virtqueue
> >   * @index: virtqueue index
> >   * @max_size: the max size of virtqueue
> > - * @reserved: for future use, needs to be initialized to zero
> > + * @reserved1: for future use, needs to be initialized to zero
> > + * @group: virtqueue group
> > + * @reserved2: for future use, needs to be initialized to zero
> >   *
> >   * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
> >   */
> >  struct vduse_vq_config {
> >         __u32 index;
> >         __u16 max_size;
> > -       __u16 reserved[13];
> > +       __u16 reserved1;
> > +       __u32 group;
> > +       __u16 reserved2[10];
> >  };
> >
> >  /*
> > --
> > 2.51.0
> >
>
> Thanks
>

