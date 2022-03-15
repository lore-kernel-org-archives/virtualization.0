Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96B7C433FE
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 04:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EE0D60F6E;
	Tue, 15 Mar 2022 04:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XG67u4M80NbB; Tue, 15 Mar 2022 04:18:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A412960F4A;
	Tue, 15 Mar 2022 04:18:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D7B0C0012;
	Tue, 15 Mar 2022 04:18:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F56FC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78FF9415E5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iEGe4GtVlc88
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:18:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D856B415E3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647317930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PsO6HkaMJ2Kprjan7eNzJfsWF2SbOQ7QcIo/3Q9VIsQ=;
 b=Z3oZnipFDtcFzOtJ63H36P+Y7kgT5GvOY7YiiapdsaTgMVuvg4YXnUF/MK4nDJShXZfdAb
 VE0Ooz/zGl/fFuJNK1UloLiXwbkW3obXr0+mHYY/WE4fRCq3bMc6hexWIzp3cNuJKZcC0p
 KJlPB9Vy18CHZalCxd70gjca0NGZ3Vs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-QGh7XCAyNlWYzaeFTa3cwg-1; Tue, 15 Mar 2022 00:18:48 -0400
X-MC-Unique: QGh7XCAyNlWYzaeFTa3cwg-1
Received: by mail-lj1-f198.google.com with SMTP id
 a23-20020a05651c031700b00247fd91c2b5so7218500ljp.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 21:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PsO6HkaMJ2Kprjan7eNzJfsWF2SbOQ7QcIo/3Q9VIsQ=;
 b=M4e7N9ysK/SgbFt2ixOJbbT4wUNJVVOSwqixQsjZS5dc3hgsxga+UxRxhtu6AbzCXf
 pWiy6/shjCSYw1t+wBwFizKCltE8/FpJXfV3rQpBWZvSdrQeaSo9ygBkjuv2nkJXdlNv
 /bH4SClhwd8r3M07QHwIa3qNmB7UzN4Z35pyJRGIxUW7UWLxRzfqc606ZHzlVahqb/QH
 FcEjeQyZgqlAhSB1RmDSGEPuyI9xRgYG3y/W7GJgJzla3BbVPaweMzq1datakf4PkPFU
 5mnRBJl01vwjN37to9Z4hcUfToK3f04OTwciTxNv+eTDbKzF8zTgIN9b/BkjJLJj6+oD
 Pbcw==
X-Gm-Message-State: AOAM532s9ihtXU54z1ee3p2jrIIsqvOMUxxXmB/yUfqvUXMpys3p79Ai
 9TvlDjKBGdXk+IAaCHqqVg2w2mUyYsgXUCe4rmlrjvn2NhOwUC0yjS0JRcP3HAur01uEWSAkNpf
 Gsc77ll5Pi7LFBrjE5dv/pLuPJS1PMOCbJe5YeRXfrDAN0xQcCRXgJT7/uw==
X-Received: by 2002:a05:651c:b23:b0:247:ee17:e9ed with SMTP id
 b35-20020a05651c0b2300b00247ee17e9edmr15995434ljr.243.1647317926461; 
 Mon, 14 Mar 2022 21:18:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVU9FZ9WEcQiGiMMptrEgNqc6f8mAO6/rM6av7IzlNZaQDc+PoWvlOXijIb8cHAI1Ifa/TAtJfo+L22R+Uh0U=
X-Received: by 2002:a05:651c:b23:b0:247:ee17:e9ed with SMTP id
 b35-20020a05651c0b2300b00247ee17e9edmr15995417ljr.243.1647317926215; Mon, 14
 Mar 2022 21:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220315032553.455-1-longpeng2@huawei.com>
 <20220315032553.455-3-longpeng2@huawei.com>
In-Reply-To: <20220315032553.455-3-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Mar 2022 12:18:35 +0800
Message-ID: <CACGkMEsc16hWfKDg5yeq7qwy3HR3LzWfDk5PBZpHKG7KB6nohg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vdpa: change the type of nvqs to u32
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Yechuan <yechuan@huawei.com>, Huangzhichao <huangzhichao@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Type: multipart/mixed; boundary="===============4973865188760310471=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4973865188760310471==
Content-Type: multipart/alternative; boundary="000000000000d319da05da3a17f1"

--000000000000d319da05da3a17f1
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 15, 2022 at 11:26 AM Longpeng(Mike) <longpeng2@huawei.com>
wrote:

> From: Longpeng <longpeng2@huawei.com>
>
> Change vdpa_device.nvqs and vhost_vdpa.nvqs to use u32
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>  drivers/vdpa/vdpa.c  |  6 +++---
>  drivers/vhost/vdpa.c | 10 ++++++----
>  include/linux/vdpa.h |  6 +++---
>  3 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1ea5254..2b75c00 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -232,7 +232,7 @@ static int vdpa_name_match(struct device *dev, const
> void *data)
>         return (strcmp(dev_name(&vdev->dev), data) == 0);
>  }
>
> -static int __vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> +static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>  {
>         struct device *dev;
>
> @@ -257,7 +257,7 @@ static int __vdpa_register_device(struct vdpa_device
> *vdev, int nvqs)
>   *
>   * Return: Returns an error when fail to add device to vDPA bus
>   */
> -int _vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> +int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>  {
>         if (!vdev->mdev)
>                 return -EINVAL;
> @@ -274,7 +274,7 @@ int _vdpa_register_device(struct vdpa_device *vdev,
> int nvqs)
>   *
>   * Return: Returns an error when fail to add to vDPA bus
>   */
> -int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
> +int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
>  {
>         int err;
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 605c7ae..0c82eb5 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -42,7 +42,7 @@ struct vhost_vdpa {
>         struct device dev;
>         struct cdev cdev;
>         atomic_t opened;
> -       int nvqs;
> +       u32 nvqs;
>         int virtio_id;
>         int minor;
>         struct eventfd_ctx *config_ctx;
> @@ -158,7 +158,8 @@ static long vhost_vdpa_set_status(struct vhost_vdpa
> *v, u8 __user *statusp)
>         struct vdpa_device *vdpa = v->vdpa;
>         const struct vdpa_config_ops *ops = vdpa->config;
>         u8 status, status_old;
> -       int ret, nvqs = v->nvqs;
> +       u32 nvqs = v->nvqs;
> +       int ret;
>         u16 i;
>
>         if (copy_from_user(&status, statusp, sizeof(status)))
> @@ -965,7 +966,8 @@ static int vhost_vdpa_open(struct inode *inode, struct
> file *filep)
>         struct vhost_vdpa *v;
>         struct vhost_dev *dev;
>         struct vhost_virtqueue **vqs;
> -       int nvqs, i, r, opened;
> +       int r, opened;
> +       u32 i, nvqs;
>
>         v = container_of(inode->i_cdev, struct vhost_vdpa, cdev);
>
> @@ -1018,7 +1020,7 @@ static int vhost_vdpa_open(struct inode *inode,
> struct file *filep)
>
>  static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
>  {
> -       int i;
> +       u32 i;
>
>         for (i = 0; i < v->nvqs; i++)
>                 vhost_vdpa_unsetup_vq_irq(v, i);
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index a526919..8943a20 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -83,7 +83,7 @@ struct vdpa_device {
>         unsigned int index;
>         bool features_valid;
>         bool use_va;
> -       int nvqs;
> +       u32 nvqs;
>         struct vdpa_mgmt_dev *mdev;
>  };
>
> @@ -338,10 +338,10 @@ struct vdpa_device *__vdpa_alloc_device(struct
> device *parent,
>                                        dev_struct, member)), name,
> use_va), \
>                                        dev_struct, member)
>
> -int vdpa_register_device(struct vdpa_device *vdev, int nvqs);
> +int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs);
>  void vdpa_unregister_device(struct vdpa_device *vdev);
>
> -int _vdpa_register_device(struct vdpa_device *vdev, int nvqs);
> +int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs);
>  void _vdpa_unregister_device(struct vdpa_device *vdev);
>
>  /**
> --
> 1.8.3.1
>
>

--000000000000d319da05da3a17f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 15, 2022 at 11:26 AM Long=
peng(Mike) &lt;<a href=3D"mailto:longpeng2@huawei.com">longpeng2@huawei.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
From: Longpeng &lt;<a href=3D"mailto:longpeng2@huawei.com" target=3D"_blank=
">longpeng2@huawei.com</a>&gt;<br>
<br>
Change vdpa_device.nvqs and vhost_vdpa.nvqs to use u32<br>
<br>
Signed-off-by: Longpeng &lt;<a href=3D"mailto:longpeng2@huawei.com" target=
=3D"_blank">longpeng2@huawei.com</a>&gt;<br></blockquote><div><br></div><di=
v>Acked-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@=
redhat.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
---<br>
=C2=A0drivers/vdpa/vdpa.c=C2=A0 |=C2=A0 6 +++---<br>
=C2=A0drivers/vhost/vdpa.c | 10 ++++++----<br>
=C2=A0include/linux/vdpa.h |=C2=A0 6 +++---<br>
=C2=A03 files changed, 12 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c<br>
index 1ea5254..2b75c00 100644<br>
--- a/drivers/vdpa/vdpa.c<br>
+++ b/drivers/vdpa/vdpa.c<br>
@@ -232,7 +232,7 @@ static int vdpa_name_match(struct device *dev, const vo=
id *data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (strcmp(dev_name(&amp;vdev-&gt;dev), dat=
a) =3D=3D 0);<br>
=C2=A0}<br>
<br>
-static int __vdpa_register_device(struct vdpa_device *vdev, int nvqs)<br>
+static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device *dev;<br>
<br>
@@ -257,7 +257,7 @@ static int __vdpa_register_device(struct vdpa_device *v=
dev, int nvqs)<br>
=C2=A0 *<br>
=C2=A0 * Return: Returns an error when fail to add device to vDPA bus<br>
=C2=A0 */<br>
-int _vdpa_register_device(struct vdpa_device *vdev, int nvqs)<br>
+int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vdev-&gt;mdev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
@@ -274,7 +274,7 @@ int _vdpa_register_device(struct vdpa_device *vdev, int=
 nvqs)<br>
=C2=A0 *<br>
=C2=A0 * Return: Returns an error when fail to add to vDPA bus<br>
=C2=A0 */<br>
-int vdpa_register_device(struct vdpa_device *vdev, int nvqs)<br>
+int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int err;<br>
<br>
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c<br>
index 605c7ae..0c82eb5 100644<br>
--- a/drivers/vhost/vdpa.c<br>
+++ b/drivers/vhost/vdpa.c<br>
@@ -42,7 +42,7 @@ struct vhost_vdpa {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cdev cdev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 atomic_t opened;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int nvqs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 nvqs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int virtio_id;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int minor;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct eventfd_ctx *config_ctx;<br>
@@ -158,7 +158,8 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v,=
 u8 __user *statusp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vdpa_device *vdpa =3D v-&gt;vdpa;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct vdpa_config_ops *ops =3D vdpa-&gt;=
config;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 status, status_old;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret, nvqs =3D v-&gt;nvqs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 nvqs =3D v-&gt;nvqs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u16 i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (copy_from_user(&amp;status, statusp, sizeof=
(status)))<br>
@@ -965,7 +966,8 @@ static int vhost_vdpa_open(struct inode *inode, struct =
file *filep)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_vdpa *v;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_dev *dev;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_virtqueue **vqs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int nvqs, i, r, opened;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int r, opened;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 i, nvqs;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D container_of(inode-&gt;i_cdev, struct vho=
st_vdpa, cdev);<br>
<br>
@@ -1018,7 +1020,7 @@ static int vhost_vdpa_open(struct inode *inode, struc=
t file *filep)<br>
<br>
=C2=A0static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 i;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; v-&gt;nvqs; i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_vdpa_unsetup_=
vq_irq(v, i);<br>
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h<br>
index a526919..8943a20 100644<br>
--- a/include/linux/vdpa.h<br>
+++ b/include/linux/vdpa.h<br>
@@ -83,7 +83,7 @@ struct vdpa_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int index;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool features_valid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool use_va;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int nvqs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 nvqs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vdpa_mgmt_dev *mdev;<br>
=C2=A0};<br>
<br>
@@ -338,10 +338,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device=
 *parent,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_struc=
t, member)), name, use_va), \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_struc=
t, member)<br>
<br>
-int vdpa_register_device(struct vdpa_device *vdev, int nvqs);<br>
+int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs);<br>
=C2=A0void vdpa_unregister_device(struct vdpa_device *vdev);<br>
<br>
-int _vdpa_register_device(struct vdpa_device *vdev, int nvqs);<br>
+int _vdpa_register_device(struct vdpa_device *vdev, u32 nvqs);<br>
=C2=A0void _vdpa_unregister_device(struct vdpa_device *vdev);<br>
<br>
=C2=A0/**<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div></div>

--000000000000d319da05da3a17f1--


--===============4973865188760310471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4973865188760310471==--

