Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EB8C433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 04:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E5C6415E5;
	Tue, 15 Mar 2022 04:19:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1wxM3OucvE_q; Tue, 15 Mar 2022 04:19:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E2A3A415E6;
	Tue, 15 Mar 2022 04:19:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9025C0012;
	Tue, 15 Mar 2022 04:19:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B402C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A94F60F71
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LocC785XUlSl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:19:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9248260F4A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647317953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uHW4XNZX39uu7lrHeLL7bZcnwun240HRUru+yIyvyT8=;
 b=bdE/WPQP4/PT0iT5x9iEdbGoOHNBy1DKPUscUCwoExTkWb9DvzIExWm67BqdjgUGXxBoJV
 WCrA1P7KX8Li07JcYj49e+nhs8PL9tpsqQ0rA5KNI5r4x/g//ob4GrEv9aRYQLUWozpdLQ
 V1ExpF3jpdgeuztiNHzsGK/FxPk/nIs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-MGjp1Wd6MA-NIQjWW4JSJQ-1; Tue, 15 Mar 2022 00:19:12 -0400
X-MC-Unique: MGjp1Wd6MA-NIQjWW4JSJQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 o16-20020ac24c50000000b004484c4815e3so5334619lfk.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 21:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uHW4XNZX39uu7lrHeLL7bZcnwun240HRUru+yIyvyT8=;
 b=M8ULJPBUGwDLaxOAHbuqq3tzU0Ag485Kl+6jIH/X8IM8KwqDfE/xwK3EYKf0mN9VHA
 bn5wsvkxFLO2NovwM55+FtPXV4sswaJsEoe0rIasMdfNfEFYPbw2BcO/KYiRH0d4l9x4
 c69yq/ZAtxqsHzQHDuSrWZG135w67j4xURthYM8mvXf/a5dmyg7Veimo8N5ta4EbBYZt
 aofyqRgI0YorrtEVqJHyWkPkQKbvuSmsOLBODtWEPbEK8o9RBEx3ZufN1Kr42ToRdyoF
 k+Lj59Ko7IAchWO9DpZawVukua2Bxqws6u6eTV7z6m1igZR8ExdvfzAS3LCZqP48DsoB
 pDjg==
X-Gm-Message-State: AOAM53230Cin3gz/vm0RzdiXnDuidhh0pzrdobBSknJEcDx2SFmN2pPc
 lQnGP2IQbIOlrVN5m+9y4thHefF/soLV+iZbkWcaHNaJCerU9hIpZyfGqmrcSsFsG904fYbGPYg
 YiRQd2HlGl2tybTRc/2Drl+h37SogvBrKJpCupcdzyBNfxbVO0T9skseWTA==
X-Received: by 2002:a2e:954c:0:b0:249:23d4:850b with SMTP id
 t12-20020a2e954c000000b0024923d4850bmr9655385ljh.73.1647317950190; 
 Mon, 14 Mar 2022 21:19:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBMYRvtP3ILUCDvMWlKR3I41XbOoiX4G8axMoNdrGOdm3q9cmCdsY+tUBBlS6qoubfDeDmwFeVtGAO++1sMeA=
X-Received: by 2002:a2e:954c:0:b0:249:23d4:850b with SMTP id
 t12-20020a2e954c000000b0024923d4850bmr9655377ljh.73.1647317950025; Mon, 14
 Mar 2022 21:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220315032553.455-1-longpeng2@huawei.com>
 <20220315032553.455-4-longpeng2@huawei.com>
In-Reply-To: <20220315032553.455-4-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Mar 2022 12:18:59 +0800
Message-ID: <CACGkMEvcWYBqH5HffGxY0P3A8Eg9cFzKK_yxAxoMGJ_FP4cfHQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vdpa: support exposing the count of vqs to
 userspace
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
Content-Type: multipart/mixed; boundary="===============2261053037985205552=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2261053037985205552==
Content-Type: multipart/alternative; boundary="0000000000003e685f05da3a19bf"

--0000000000003e685f05da3a19bf
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 15, 2022 at 11:26 AM Longpeng(Mike) <longpeng2@huawei.com>
wrote:

> From: Longpeng <longpeng2@huawei.com>
>
> - GET_VQS_COUNT: the count of virtqueues that exposed
>

Acked-by: Jason Wang <jasowang@redhat.com>


>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
>  drivers/vhost/vdpa.c       | 13 +++++++++++++
>  include/uapi/linux/vhost.h |  3 +++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 0c82eb5..69b3f05 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -370,6 +370,16 @@ static long vhost_vdpa_get_config_size(struct
> vhost_vdpa *v, u32 __user *argp)
>         return 0;
>  }
>
> +static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 __user
> *argp)
> +{
> +       struct vdpa_device *vdpa = v->vdpa;
> +
> +       if (copy_to_user(argp, &vdpa->nvqs, sizeof(vdpa->nvqs)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>                                    void __user *argp)
>  {
> @@ -510,6 +520,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file
> *filep,
>         case VHOST_VDPA_GET_CONFIG_SIZE:
>                 r = vhost_vdpa_get_config_size(v, argp);
>                 break;
> +       case VHOST_VDPA_GET_VQS_COUNT:
> +               r = vhost_vdpa_get_vqs_count(v, argp);
> +               break;
>         default:
>                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>                 if (r == -ENOIOCTLCMD)
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index bc74e95..5d99e7c 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -154,4 +154,7 @@
>  /* Get the config size */
>  #define VHOST_VDPA_GET_CONFIG_SIZE     _IOR(VHOST_VIRTIO, 0x79, __u32)
>
> +/* Get the count of all virtqueues */
> +#define VHOST_VDPA_GET_VQS_COUNT       _IOR(VHOST_VIRTIO, 0x80, __u32)
> +
>  #endif
> --
> 1.8.3.1
>
>

--0000000000003e685f05da3a19bf
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
- GET_VQS_COUNT: the count of virtqueues that exposed<br></blockquote><div>=
<br></div><div>Acked-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.c=
om">jasowang@redhat.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
Signed-off-by: Longpeng &lt;<a href=3D"mailto:longpeng2@huawei.com" target=
=3D"_blank">longpeng2@huawei.com</a>&gt;<br>
---<br>
=C2=A0drivers/vhost/vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 +++++++++++++<br>
=C2=A0include/uapi/linux/vhost.h |=C2=A0 3 +++<br>
=C2=A02 files changed, 16 insertions(+)<br>
<br>
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c<br>
index 0c82eb5..69b3f05 100644<br>
--- a/drivers/vhost/vdpa.c<br>
+++ b/drivers/vhost/vdpa.c<br>
@@ -370,6 +370,16 @@ static long vhost_vdpa_get_config_size(struct vhost_vd=
pa *v, u32 __user *argp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 __user *arg=
p)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct vdpa_device *vdpa =3D v-&gt;vdpa;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_to_user(argp, &amp;vdpa-&gt;nvqs, size=
of(vdpa-&gt;nvqs)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
=C2=A0static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int=
 cmd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void __user *argp)<br>
=C2=A0{<br>
@@ -510,6 +520,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *file=
p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case VHOST_VDPA_GET_CONFIG_SIZE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D vhost_vdpa_ge=
t_config_size(v, argp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case VHOST_VDPA_GET_VQS_COUNT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D vhost_vdpa_ge=
t_vqs_count(v, argp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D vhost_dev_ioc=
tl(&amp;v-&gt;vdev, cmd, argp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r =3D=3D -ENOIO=
CTLCMD)<br>
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h<br>
index bc74e95..5d99e7c 100644<br>
--- a/include/uapi/linux/vhost.h<br>
+++ b/include/uapi/linux/vhost.h<br>
@@ -154,4 +154,7 @@<br>
=C2=A0/* Get the config size */<br>
=C2=A0#define VHOST_VDPA_GET_CONFIG_SIZE=C2=A0 =C2=A0 =C2=A0_IOR(VHOST_VIRT=
IO, 0x79, __u32)<br>
<br>
+/* Get the count of all virtqueues */<br>
+#define VHOST_VDPA_GET_VQS_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0_IOR(VHOST_VIRT=
IO, 0x80, __u32)<br>
+<br>
=C2=A0#endif<br>
-- <br>
1.8.3.1<br>
<br>
</blockquote></div></div>

--0000000000003e685f05da3a19bf--


--===============2261053037985205552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2261053037985205552==--

