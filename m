Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA73C9888
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050694; cv=none; b=m+GJHtPiWQvCR2jYWvw5jysLHOHxtJEPJjVwd9t8kwu0HpA/obWZbBGJ/zwomryc/+7dzNVW50CXmA0K3vKLY31GBBqprGaQzoPJjvnnBPK+KerVeHIgldrXkD5rR4/SOPKCFXzMgM7y2VhdqV6AyCcDgIMv1Z4JTwvircY68e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050694; c=relaxed/simple;
	bh=RXSyMRxzFhcNa0zgTZo3T9gcSlAYCWvVaDfWUfXYl9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZzv/qlHQ2gt/P7XYU6lDBvyMBP4DyAW/tDoO0TRVJYJIQEBcviu/y3jDI3dq8FVwC28Fr5AjjURO+/EyuO0TXBGD0Dozhes7SgG0NHMXlF24L85tRA870C4W3DCofOg8dwpH92hENmSrwMfvU9XhTcT8CyR0J5TbUWeuxYjsE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vnmg8Fhg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vnmg8Fhg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780050691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WG8LPwjNZex3yXLcptOPjDBhSyhtaMydTIQXX8L5lU=;
	b=Vnmg8FhgGWqufYm3hr4Xg85U0OF/OFN45vwDFTN8AOVY5Lw01/7MnMbJBsVkJyNhz1M67n
	Noc+xKH9Kna3ZHvGKCddjVwWnGaxAU2/jZyjgChU8r98oBB2YgN/ijeb83cc3Dma7u52oU
	ab4FvSW6XVV3PyB4RDpaA/4wCBMD5CA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-J_TLpiLZMTuNDjX_7WSZJw-1; Fri, 29 May 2026 06:31:30 -0400
X-MC-Unique: J_TLpiLZMTuNDjX_7WSZJw-1
X-Mimecast-MFC-AGG-ID: J_TLpiLZMTuNDjX_7WSZJw_1780050689
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7d296b0a093so127167877b3.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 03:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050689; x=1780655489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WG8LPwjNZex3yXLcptOPjDBhSyhtaMydTIQXX8L5lU=;
        b=VpjUO5Q5unWd98/itWJXByBmnKcZSyK+l0+arOK4a0jpf3tW8JzV4QPNALDQfwwAKO
         I435QEqF0ZR04kAJoX5+kwf+c/+dAKaHkAE/iianqj2yrklE2Y14xYfiyLYmyNK/skJ/
         NCTgNDH1t1IPGYYdIHNsKFEcd8p0JjIY3/CuybCVemGQM5xCnAmR5+dOuaY1WnBALFOE
         6s3TXy4aHyw4op3itTJm0YpBUTEQi4GJFCPXB9PDkY3VIiCK1bYjg3JT+/RkIGm9IeeG
         XysqVwO4zQPm7E/jWnRqTVX71LnQEPjwIG60pUdtHM3i+dS7qHQ3iXE7QpI14+FbvEIG
         HsxA==
X-Forwarded-Encrypted: i=1; AFNElJ+BXzYfjcE5Upg9o2eOOfnWFpmbhxIVEW6Q5xRGHPN+MlM/Ix7TjW/vyMnSnKHbVMGuFXeSHlqpFOgqIH7WXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTmAlQipgF98EhJrLQniyuyom9TcQPIKLvkk0m2bIx+tswJp8X
	OefZu5dVNCBZHiqe1925ZPsg0+aQ4yR8omrL5tzpHCKEoL0Kdw7tZMcDWvCfcXJCt2p8k6u8wmL
	pGceTxc424sWHEHrh2AHJcEFB2u1U/nmyi5qnqxidoKPum7AIlURxPpjbHunhV7rZach9Iu+MEa
	TpZgMLV9G8QEFA9S6sfYFKKUoKZUEMAGaBmHBn5mOYkjk=
X-Gm-Gg: Acq92OEmE1zDru/s8WVEW+GWQqlFG5zU8Hau3nxVFJTyZ/l29uk9JmDK8SIm1HwnnO1
	KagdhSDHCKIjUAe2dqAdFoUXwGBRr7s16mt4DAMGyI/4VyJWaS9lwuVdtfjf+42Nn32yuiX717x
	yoGBhayGNgyQFfGSYVDPfaAjj3zS1MTxF9pLS7tHHKPZcBr19QTWoSrYhozfD9NcTGHVwdqf4wT
	+3VqpwC7jUvtFgvDA==
X-Received: by 2002:a05:690c:c22b:b0:7b9:edca:bac6 with SMTP id 00721157ae682-7de47e27cd9mr17401057b3.15.1780050689201;
        Fri, 29 May 2026 03:31:29 -0700 (PDT)
X-Received: by 2002:a05:690c:c22b:b0:7b9:edca:bac6 with SMTP id
 00721157ae682-7de47e27cd9mr17400777b3.15.1780050688567; Fri, 29 May 2026
 03:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-3-eperezma@redhat.com>
 <CACGkMEvafXSWZBsDtt5-zit5_po6U35ciP_-yhbv-MtKo4uG7Q@mail.gmail.com>
 <CAJaqyWf3kgjQ5AQs3yYipNTDvGnF-arcXvJkAJP3G6+eoSB5aQ@mail.gmail.com>
 <CACGkMEvmA4BnMQoQfzhROmWx1XfQYgHYuZd8JgUy-2zb-ZeLWg@mail.gmail.com> <CAJaqyWdQ-a1YbCER30noeGacWeaC=RQuUdPbFA4ke-r0p9boRw@mail.gmail.com>
In-Reply-To: <CAJaqyWdQ-a1YbCER30noeGacWeaC=RQuUdPbFA4ke-r0p9boRw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 29 May 2026 12:30:51 +0200
X-Gm-Features: AVHnY4LiZEi_qTBsGjvfYqSYlgE9PDpBZyqrzeCWIAI1KtGSetv_y02Q_M8j3gk
Message-ID: <CAJaqyWdo_o+ZiQLaAjS=quVw=r5RHzeyxXV+huVcid3ofAtiWw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vduse: add VDUSE_GET_FEATURES ioctl
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p4YOiR2o6eG1V23ph05DerU0msvmW7oS-D8eIOBCMbg_1780050689
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 7:46=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Mar 13, 2026 at 6:56=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Mar 12, 2026 at 3:12=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 4:56=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > Add an ioctl to allow VDUSE instances to query the available feat=
ures
> > > > > supported by the kernel module.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > A simple u64 bitmap is used for feature flags. While a flexible a=
rray
> > > > > could support indefinite expansion, 64 bits is sufficient for the
> > > > > foreseeable future and simplifies the implementation.
> > > > >
> > > > > Also, dev_dbg is used for logging rather than dev_err as these ca=
n be
> > > > > triggered from userspace.
> > > > > ---
> > > > > v3:
> > > > > * Remove check for API_VERSION < 2
> > > > > * Add comment about struct vduse_dev_config:vduse_features is onl=
y valid
> > > > >   if VDUSE_GET_FEATURES success.
> > > > >
> > > > > v2:
> > > > > * return -EINVAL if ioctl called with version < 2, so userland vi=
sible
> > > > >   reply is kept (Jason).
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
> > > > >  include/uapi/linux/vduse.h         | 7 ++++++-
> > > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index d1da7c15d98b..17e0358d3a68 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -52,6 +52,9 @@
> > > > >
> > > > >  #define IRQ_UNBOUND -1
> > > > >
> > > > > +/* Supported VDUSE features */
> > > > > +static const uint64_t vduse_features;
> > > > > +
> > > > >  /*
> > > > >   * VDUSE instance have not asked the vduse API version, so assum=
e 0.
> > > > >   *
> > > > > @@ -2207,6 +2210,10 @@ static long vduse_ioctl(struct file *file,=
 unsigned int cmd,
> > > > >                 ret =3D vduse_destroy_dev(name);
> > > > >                 break;
> > > > >         }
> > > > > +       case VDUSE_GET_FEATURES:
> > > > > +               ret =3D put_user(vduse_features, (u64 __user *)ar=
gp);
> > > > > +               break;
> > > > > +
> > > > >         default:
> > > > >                 ret =3D -EINVAL;
> > > > >                 break;
> > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vdus=
e.h
> > > > > index 361eea511c21..e9b5f32a452d 100644
> > > > > --- a/include/uapi/linux/vduse.h
> > > > > +++ b/include/uapi/linux/vduse.h
> > > > > @@ -33,6 +33,7 @@
> > > > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > > > >   * @ngroups: number of vq groups that VDUSE device declares
> > > > >   * @nas: number of address spaces that VDUSE device declares
> > > > > + * @vduse_features: VDUSE features
> > > > >   * @reserved: for future use, needs to be initialized to zero
> > > > >   * @config_size: the size of the configuration space
> > > > >   * @config: the buffer of the configuration space
> > > > > @@ -49,7 +50,8 @@ struct vduse_dev_config {
> > > > >         __u32 vq_align;
> > > > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > > >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > > > -       __u32 reserved[11];
> > > > > +       __u64 vduse_features; /* if VDUSE_GET_FEATURES is not EIN=
VAL */
> > > > > +       __u32 reserved[9];
> > > >
> > > > If we go with VDUSE_GET_FEATURES, I'd perfer to go with
> > > > VDUSE_SET_FEATURES intead of this.
> > > >
> > >
> > > I didn't realize the lack of symmetry, but that approach grows and
> > > complicates the possible states of struct vduse_control and the
> > > vduse_ioctl code for little benefit in my opinion. Making it atomic i=
n
> > > VDUSE_CREATE_DEV ioctl helps centralize all the potential errors.
> > > Also, from previous experience with vhost_vdpa, the ioctls slow down
> > > the device creation, which could affect things like VDUSE adoption fo=
r
> > > containers etc.
> >
> > Maybe, but if we really care about the time spent on device creation,
> > uAPI needs redesigning. Or at least more feature in the future
> > wouldn't slow down further.
> >
> > >
> > > On the other hand, it would make it easier to tell if the device
> > > couldn't be created because of invalid features set. This is highly
> > > unlikely, as the VDUSE device should retrieve the features by calling
> > > VDUSE_GET_FEATURES earlier.
> > >
> > > I don't think it is worth it, but if you think we should go that way
> > > I'm ok with the change.
> >
> > It depends on the intialziation flow. After getting features, I'd
> > expect it's something like this
> >
> > A:
> >
> > 1) GET_API_VERSION
> > 2) SET_API_VERSION
> > 3) GET_FEATURES
> > 4) SET_FEATURES
> > 5) CREATE_DEV
> >
> > Or B in this patch:
> >
> > 1) GET_API_VERSION
> > 2) SET_API_VERSION
> > 3) GET_FEATURES
> > 4) CREATE_DEV
> >
> > I think it's better to stick the symmetry as API_VERSION (technically,
> > API could be set via config as well?)
> >
>
> Yes, I'd have chosen to set the API_VERSION via config too.
>
> > BTW, I found VDUSE_SET_API_VERSION could be set multiple times (even
> > after the device is create), do we need to fix this?
> >
>
> It shouldn't be a problem, each device has its own copy of
> api_version. It seems clear to me that the API setting only affects
> devices created after the change, but I can add a guard after the
> first device is created.
>

I keep thinking that we are increasing the complexity for little
benefit TBH. This is the diff on top of the current series. MST, do
you prefer a new VDUSE_SET_FEATURES ioctl to follow the api version
API and keep the symmetry with GET_VDUSE_FEATURES or use the config
struct like the group and asid configuration?

---
 drivers/vdpa/vdpa_user/vduse_dev.c | 27 +++++++++++++++++++++++----
 include/uapi/linux/vduse.h         |  7 ++++---
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c
b/drivers/vdpa/vdpa_user/vduse_dev.c
index 4f642b95a7cb..a5427dcebf29 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -162,6 +162,7 @@ struct vduse_dev_msg {

 struct vduse_control {
        u64 api_version;
+       u64 vduse_features;
 };

 static DEFINE_MUTEX(vduse_lock);
@@ -2079,7 +2080,8 @@ static struct attribute *vduse_dev_attrs[] =3D {
 ATTRIBUTE_GROUPS(vduse_dev);

 static int vduse_create_dev(struct vduse_dev_config *config,
-                           void *config_buf, u64 api_version)
+                           void *config_buf, u64 api_version,
+                           u64 vduse_features)
 {
        int ret;
        struct vduse_dev *dev;
@@ -2101,9 +2103,9 @@ static int vduse_create_dev(struct
vduse_dev_config *config,
        dev->device_features =3D config->features;
        dev->device_id =3D config->device_id;
        dev->vendor_id =3D config->vendor_id;
-       dev->vduse_features =3D config->vduse_features;
+       dev->vduse_features =3D vduse_features;
        dev_dbg(vduse_ctrl_dev, "Creating device %s with features 0x%llx",
-               config->name, config->vduse_features);
+               config->name, vduse_features);

        dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : config-=
>nas;
        dev->as =3D kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
@@ -2199,6 +2201,21 @@ static long vduse_ioctl(struct file *file,
unsigned int cmd,
                control->api_version =3D api_version;
                break;
        }
+       case VDUSE_SET_FEATURES: {
+               u64 features;
+
+               ret =3D -EFAULT;
+               if (get_user(features, (u64 __user *)argp))
+                       break;
+
+               ret =3D -EINVAL;
+               if (features & ~vduse_features)
+                       break;
+
+               ret =3D 0;
+               control->vduse_features =3D features;
+               break;
+       }
        case VDUSE_CREATE_DEV: {
                struct vduse_dev_config config;
                unsigned long size =3D offsetof(struct vduse_dev_config, co=
nfig);
@@ -2220,7 +2237,8 @@ static long vduse_ioctl(struct file *file,
unsigned int cmd,
                        break;
                }
                config.name[VDUSE_NAME_MAX - 1] =3D '\0';
-               ret =3D vduse_create_dev(&config, buf, control->api_version=
);
+               ret =3D vduse_create_dev(&config, buf, control->api_version=
,
+                                      control->vduse_features);
                if (ret)
                        kvfree(buf);
                break;
@@ -2266,6 +2284,7 @@ static int vduse_open(struct inode *inode,
struct file *file)
                return -ENOMEM;

        control->api_version =3D VDUSE_API_VERSION_NOT_ASKED;
+       control->vduse_features =3D 0;
        file->private_data =3D control;

        return 0;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 7324faea5df4..6e45f60aa015 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -26,6 +26,9 @@
 /* Set the version of VDUSE API that userspace supported. */
 #define VDUSE_SET_API_VERSION  _IOW(VDUSE_BASE, 0x01, __u64)

+/* Set the VDUSE features that userspace supported. */
+#define VDUSE_SET_FEATURES     _IOW(VDUSE_BASE, 0x05, __u64)
+
 /**
  * struct vduse_dev_config - basic configuration of a VDUSE device
  * @name: VDUSE device name, needs to be NUL terminated
@@ -36,7 +39,6 @@
  * @vq_align: the allocation alignment of virtqueue's metadata
  * @ngroups: number of vq groups that VDUSE device declares
  * @nas: number of address spaces that VDUSE device declares
- * @vduse_features: VDUSE features
  * @reserved: for future use, needs to be initialized to zero
  * @config_size: the size of the configuration space
  * @config: the buffer of the configuration space
@@ -53,8 +55,7 @@ struct vduse_dev_config {
        __u32 vq_align;
        __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
        __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
-       __u64 vduse_features; /* if VDUSE_GET_FEATURES is not EINVAL */
-       __u32 reserved[9];
+       __u32 reserved[11];
        __u32 config_size;
        __u8 config[];
 };

