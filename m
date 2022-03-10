Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B74C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 05:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27CFB812D1;
	Thu, 10 Mar 2022 05:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOv06j3vNyYq; Thu, 10 Mar 2022 05:43:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B51C812E4;
	Thu, 10 Mar 2022 05:43:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56CB7C0012;
	Thu, 10 Mar 2022 05:43:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88F3EC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 05:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6465440A02
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 05:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qJeqmWl1nKAS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 05:43:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33223408E7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 05:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646891021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x9QzHdB9qfKPGetPE93QARDGDfHnG7eDoqAtFhra7N4=;
 b=i0sFyGoVN8TXjEiW5HvgT6iaDvDmS/+yhXXg1DinyXa6CJtRJVST917E+xocA4fwQU2SNF
 DSptHlIjFSlhr/YYIDdsT8Cx+Kbju3ji4jPZRbmZBYyneRlDW74UaPVHAR8TTSXXAcrC2i
 FUeedeH0NCd0/7Nb/TFSLAMQwWuFRNM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-F0vqU2ctN_qJD_5qnajxBA-1; Thu, 10 Mar 2022 00:43:39 -0500
X-MC-Unique: F0vqU2ctN_qJD_5qnajxBA-1
Received: by mail-lj1-f197.google.com with SMTP id
 h18-20020a2e3a12000000b00247e2a0e909so1854379lja.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 21:43:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x9QzHdB9qfKPGetPE93QARDGDfHnG7eDoqAtFhra7N4=;
 b=NZ1M3ITTsZScL8TU4j0vy6qQ7j1VPszAx/+2pQGEtNcKqnUMyx6w+EOvzAS4i+5UcM
 6W5kn0ttMr+HAi+LyvD/4Qg/eCeujgjtrobiD7wnFYI4X6spK0ZI5mIVEW/OuMa7lkB1
 hMKFFpk8umSpw9wWlJwOleOGICK7zgW8fHAoZipRIm99pQopJGWMhRu9of7x5ymRD9z5
 Ww4vpCDnrMbrMZf42K/7SFl9DW3GmDQDz6WhuYAoDy03znROwAVvY48gMtNJ3PGkgoZR
 mCW0WjAS2JHicIRDA499h9OEOfE4wVBczopcPywOcwXCIT34IwEAsz1bTfvA+jC/oDM+
 ZH8A==
X-Gm-Message-State: AOAM530jIDL6F66x8JS2bJa5Pv8GjHbKcnwIz452brMQSsxG2l/fPNTi
 1LjXUtV01hu6NVJUUQ+IEc2uU8pCA9Pha4D9OGOqwcY8Xwhq8FZgh/qUZ69wH6sZZg/xdFPS9kp
 oB1kI+DEeNuldt1WGsZaZZiCAydpyisJBfKOOklF9FO6JMKT5a6Yi3moqbg==
X-Received: by 2002:a2e:b004:0:b0:247:e29f:fbd4 with SMTP id
 y4-20020a2eb004000000b00247e29ffbd4mr1871251ljk.315.1646891018049; 
 Wed, 09 Mar 2022 21:43:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMuxlvEtizpvkCTH/UqCgVaHK6Rdc1MGd77I/6uA52Nzc19cjYfV5kYF6rCxEDcAhtGVrv8PXSZYaJns3yewI=
X-Received: by 2002:a2e:b004:0:b0:247:e29f:fbd4 with SMTP id
 y4-20020a2eb004000000b00247e29ffbd4mr1871240ljk.315.1646891017789; Wed, 09
 Mar 2022 21:43:37 -0800 (PST)
MIME-Version: 1.0
References: <20220117092921.1573-1-longpeng2@huawei.com>
 <20220117092921.1573-3-longpeng2@huawei.com>
 <1a26d7b3-1020-50c5-f0a3-ebc645cdcddf@redhat.com>
 <4e1870fed35f487b8cc2a5d112e7c41b@huawei.com>
In-Reply-To: <4e1870fed35f487b8cc2a5d112e7c41b@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Mar 2022 13:43:26 +0800
Message-ID: <CACGkMEugOVe8m23npXAHYDVENpCYrat5nWXPefJkr4Krhcnxow@mail.gmail.com>
Subject: Re: [RFC 2/3] vdpa: support exposing the count of vqs to userspace
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Huangzhichao <huangzhichao@huawei.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Yechuan <yechuan@huawei.com>
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
Content-Type: multipart/mixed; boundary="===============9148859235955512859=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============9148859235955512859==
Content-Type: multipart/alternative; boundary="000000000000198a9f05d9d6b23a"

--000000000000198a9f05d9d6b23a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2022 at 11:16 AM Longpeng (Mike, Cloud Infrastructure
Service Product Dept.) <longpeng2@huawei.com> wrote:

> Hi Jason,
>
> > -----Original Message-----
> > From: Jason Wang [mailto:jasowang@redhat.com]
> > Sent: Tuesday, January 18, 2022 11:08 AM
> > To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> > <longpeng2@huawei.com>; mst@redhat.com; sgarzare@redhat.com;
> > stefanha@redhat.com
> > Cc: virtualization@lists.linux-foundation.org; kvm@vger.kernel.org;
> > linux-kernel@vger.kernel.org; netdev@vger.kernel.org; Gonglei (Arei)
> > <arei.gonglei@huawei.com>; Yechuan <yechuan@huawei.com>; Huangzhichao
> > <huangzhichao@huawei.com>
> > Subject: Re: [RFC 2/3] vdpa: support exposing the count of vqs to
> userspace
> >
> >
> > =E5=9C=A8 2022/1/17 =E4=B8=8B=E5=8D=885:29, Longpeng(Mike) =E5=86=99=E9=
=81=93:
> > > From: Longpeng <longpeng2@huawei.com>
> > >
> > > - GET_VQS_COUNT: the count of virtqueues that exposed
> > >
> > > Signed-off-by: Longpeng <longpeng2@huawei.com>
> > > ---
> > >   drivers/vhost/vdpa.c       | 13 +++++++++++++
> > >   include/uapi/linux/vhost.h |  3 +++
> > >   2 files changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index 1eea14a4ea56..c1074278fc6b 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -369,6 +369,16 @@ static long vhost_vdpa_get_config_size(struct
> vhost_vdpa
> > *v, u32 __user *argp)
> > >     return 0;
> > >   }
> > >
> > > +static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 __use=
r
> *argp)
> > > +{
> > > +   struct vdpa_device *vdpa =3D v->vdpa;
> >
> >
> > While at it, I think it's better to change vdpa->nvqs to use u32?
> >
>
> struct vhost_vdpa {
>     ...
>         int nvqs;
>     ...
> };
>
> struct vdpa_device {
>     ...
>         int nvqs;
>     ...
> };
>
> I think we should change both to u32?
>

Yes.

Thanks


>
>
> > Thanks
> >
> >
> > > +
> > > +   if (copy_to_user(argp, &vdpa->nvqs, sizeof(vdpa->nvqs)))
> > > +           return -EFAULT;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >   static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned
> int cmd,
> > >                                void __user *argp)
> > >   {
> > > @@ -509,6 +519,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file
> *filep,
> > >     case VHOST_VDPA_GET_CONFIG_SIZE:
> > >             r =3D vhost_vdpa_get_config_size(v, argp);
> > >             break;
> > > +   case VHOST_VDPA_GET_VQS_COUNT:
> > > +           r =3D vhost_vdpa_get_vqs_count(v, argp);
> > > +           break;
> > >     default:
> > >             r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
> > >             if (r =3D=3D -ENOIOCTLCMD)
> > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > index bc74e95a273a..5d99e7c242a2 100644
> > > --- a/include/uapi/linux/vhost.h
> > > +++ b/include/uapi/linux/vhost.h
> > > @@ -154,4 +154,7 @@
> > >   /* Get the config size */
> > >   #define VHOST_VDPA_GET_CONFIG_SIZE        _IOR(VHOST_VIRTIO, 0x79,
> __u32)
> > >
> > > +/* Get the count of all virtqueues */
> > > +#define VHOST_VDPA_GET_VQS_COUNT   _IOR(VHOST_VIRTIO, 0x80, __u32)
> > > +
> > >   #endif
>
>

--000000000000198a9f05d9d6b23a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 10, 2022 at 11:16 AM Long=
peng (Mike, Cloud Infrastructure Service Product Dept.) &lt;<a href=3D"mail=
to:longpeng2@huawei.com">longpeng2@huawei.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi Jason,<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Jason Wang [mailto:<a href=3D"mailto:jasowang@redhat.com" target=
=3D"_blank">jasowang@redhat.com</a>]<br>
&gt; Sent: Tuesday, January 18, 2022 11:08 AM<br>
&gt; To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)<br>
&gt; &lt;<a href=3D"mailto:longpeng2@huawei.com" target=3D"_blank">longpeng=
2@huawei.com</a>&gt;; <a href=3D"mailto:mst@redhat.com" target=3D"_blank">m=
st@redhat.com</a>; <a href=3D"mailto:sgarzare@redhat.com" target=3D"_blank"=
>sgarzare@redhat.com</a>;<br>
&gt; <a href=3D"mailto:stefanha@redhat.com" target=3D"_blank">stefanha@redh=
at.com</a><br>
&gt; Cc: <a href=3D"mailto:virtualization@lists.linux-foundation.org" targe=
t=3D"_blank">virtualization@lists.linux-foundation.org</a>; <a href=3D"mail=
to:kvm@vger.kernel.org" target=3D"_blank">kvm@vger.kernel.org</a>;<br>
&gt; <a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_blank">linu=
x-kernel@vger.kernel.org</a>; <a href=3D"mailto:netdev@vger.kernel.org" tar=
get=3D"_blank">netdev@vger.kernel.org</a>; Gonglei (Arei)<br>
&gt; &lt;<a href=3D"mailto:arei.gonglei@huawei.com" target=3D"_blank">arei.=
gonglei@huawei.com</a>&gt;; Yechuan &lt;<a href=3D"mailto:yechuan@huawei.co=
m" target=3D"_blank">yechuan@huawei.com</a>&gt;; Huangzhichao<br>
&gt; &lt;<a href=3D"mailto:huangzhichao@huawei.com" target=3D"_blank">huang=
zhichao@huawei.com</a>&gt;<br>
&gt; Subject: Re: [RFC 2/3] vdpa: support exposing the count of vqs to user=
space<br>
&gt; <br>
&gt; <br>
&gt; =E5=9C=A8 2022/1/17 =E4=B8=8B=E5=8D=885:29, Longpeng(Mike) =E5=86=99=
=E9=81=93:<br>
&gt; &gt; From: Longpeng &lt;<a href=3D"mailto:longpeng2@huawei.com" target=
=3D"_blank">longpeng2@huawei.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; - GET_VQS_COUNT: the count of virtqueues that exposed<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Longpeng &lt;<a href=3D"mailto:longpeng2@huawei.co=
m" target=3D"_blank">longpeng2@huawei.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0drivers/vhost/vdpa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 +=
++++++++++++<br>
&gt; &gt;=C2=A0 =C2=A0include/uapi/linux/vhost.h |=C2=A0 3 +++<br>
&gt; &gt;=C2=A0 =C2=A02 files changed, 16 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c<br>
&gt; &gt; index 1eea14a4ea56..c1074278fc6b 100644<br>
&gt; &gt; --- a/drivers/vhost/vdpa.c<br>
&gt; &gt; +++ b/drivers/vhost/vdpa.c<br>
&gt; &gt; @@ -369,6 +369,16 @@ static long vhost_vdpa_get_config_size(struc=
t vhost_vdpa<br>
&gt; *v, u32 __user *argp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt;=C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; +static long vhost_vdpa_get_vqs_count(struct vhost_vdpa *v, u32 _=
_user *argp)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0struct vdpa_device *vdpa =3D v-&gt;vdpa;<br>
&gt; <br>
&gt; <br>
&gt; While at it, I think it&#39;s better to change vdpa-&gt;nvqs to use u3=
2?<br>
&gt; <br>
<br>
struct vhost_vdpa {<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int nvqs;<br>
=C2=A0 =C2=A0 ...<br>
};<br>
<br>
struct vdpa_device {<br>
=C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int nvqs;<br>
=C2=A0 =C2=A0 ...<br>
};<br>
<br>
I think we should change both to u32?<br></blockquote><div><br></div><div>Y=
es.</div><div><br></div><div>Thanks</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
<br>
&gt; Thanks<br>
&gt; <br>
&gt; <br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0if (copy_to_user(argp, &amp;vdpa-&gt;nvqs, sizeof(v=
dpa-&gt;nvqs)))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0return 0;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __user *argp)<br>
&gt; &gt;=C2=A0 =C2=A0{<br>
&gt; &gt; @@ -509,6 +519,9 @@ static long vhost_vdpa_unlocked_ioctl(struct =
file *filep,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0case VHOST_VDPA_GET_CONFIG_SIZE:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D vhost_vdpa_g=
et_config_size(v, argp);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; +=C2=A0 =C2=A0case VHOST_VDPA_GET_VQS_COUNT:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D vhost_vdpa_get_vq=
s_count(v, argp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0default:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D vhost_dev_io=
ctl(&amp;v-&gt;vdev, cmd, argp);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r =3D=3D -ENOI=
OCTLCMD)<br>
&gt; &gt; diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhos=
t.h<br>
&gt; &gt; index bc74e95a273a..5d99e7c242a2 100644<br>
&gt; &gt; --- a/include/uapi/linux/vhost.h<br>
&gt; &gt; +++ b/include/uapi/linux/vhost.h<br>
&gt; &gt; @@ -154,4 +154,7 @@<br>
&gt; &gt;=C2=A0 =C2=A0/* Get the config size */<br>
&gt; &gt;=C2=A0 =C2=A0#define VHOST_VDPA_GET_CONFIG_SIZE=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 _IOR(VHOST_VIRTIO, 0x79, __u32)<br>
&gt; &gt;<br>
&gt; &gt; +/* Get the count of all virtqueues */<br>
&gt; &gt; +#define VHOST_VDPA_GET_VQS_COUNT=C2=A0 =C2=A0_IOR(VHOST_VIRTIO, =
0x80, __u32)<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0#endif<br>
<br>
</blockquote></div></div>

--000000000000198a9f05d9d6b23a--


--===============9148859235955512859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9148859235955512859==--

