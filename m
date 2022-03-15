Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE3CC433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 08:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DFEC841A9;
	Tue, 15 Mar 2022 08:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W6pL5zad49iy; Tue, 15 Mar 2022 08:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 83EB18415B;
	Tue, 15 Mar 2022 08:59:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5851FC001A;
	Tue, 15 Mar 2022 08:59:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A541C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 67DFF40880
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fidBDemHs8r
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:59:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAB2D402E2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 08:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647334778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7c2yA6rflI6/ZoBuTo2+0uiD0W6JY9rvnw4zKuVNUXY=;
 b=IMii1d/n12UsL4fZxwj1zNkM79rSl5Nc315BFPVTPnfS74YBUO646udAvq5IbRipjjtoJF
 hKwxz4OtjykuzKU/D0X/x844Z0pX13jCrRZmWL4KLuVYdRZJ3SMMiCsHk1TFv6PfK83Gm4
 I2PsdaaAqmCpfMvEPbnsTvSr4DZix+0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-Lb5zaJ9fPuyoC9TO5dYvBw-1; Tue, 15 Mar 2022 04:59:36 -0400
X-MC-Unique: Lb5zaJ9fPuyoC9TO5dYvBw-1
Received: by mail-lf1-f70.google.com with SMTP id
 i17-20020a056512007100b0044879482376so3125305lfo.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 01:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7c2yA6rflI6/ZoBuTo2+0uiD0W6JY9rvnw4zKuVNUXY=;
 b=x0Q57xFBV3G6jZ9zl5RNllZKPQJPOyS0wxDp9bS2JqnatBOKcxihPutdbvwp2ZsyQY
 K8hDTboPnKWGNMNpybDkO9d5AZdewXso5nKna2S5YXyKvAr0IZ1cDx/+z+kMa4koIwQS
 luBjKEFqLXxkyFSdbZFwBzUgLsdfw5QXuAljiXxMyMBrFLH2BW83OPyWrpn8QgeOG3TI
 A21gaLzHzzYsGTarmWRPqU83kjxdA93KVG+sVrRxrspeBeWRe/FSKe7DAjxuShCl6yCS
 VybTP5XICdmBFFRlgrB7zpPsbpIzH//w7ySop1H3KDd8RYcy33iWJJaKQkzvqGXdIp5B
 PHUQ==
X-Gm-Message-State: AOAM531u/O682SBSXMA8VW48Sq/90bARmMZTBj31SAaItn5WZIacpzHe
 V9sMc+QMyxUk44UErdCs3sXI02x1jU6sLrDXqzH7ayGoEIL3W60cHaaiYB4C5j3/wLrXTGxBM2R
 0uehAA9+CmMPP8VOYOrJEqSVBA90xfCfqBYRXzgDaSfnowXHRMHtrhV7vFg==
X-Received: by 2002:a19:7514:0:b0:448:7d8e:aca with SMTP id
 y20-20020a197514000000b004487d8e0acamr9656608lfe.471.1647334775168; 
 Tue, 15 Mar 2022 01:59:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOPG5mZQ+aR6cThJEYDQFYYyykihoAOeRqJrNm+T9GSpAnv2U2iF3seNPUA78OyWz1K9ZxhyPSxKU1nEmWnMA=
X-Received: by 2002:a19:7514:0:b0:448:7d8e:aca with SMTP id
 y20-20020a197514000000b004487d8e0acamr9656590lfe.471.1647334774583; Tue, 15
 Mar 2022 01:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220311152832.17703-1-suwan.kim027@gmail.com>
 <ea838f63-5f63-6f3b-f49e-1107b43f7d1c@redhat.com>
 <Yi82BL9KecQsVfgX@localhost.localdomain>
In-Reply-To: <Yi82BL9KecQsVfgX@localhost.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Mar 2022 16:59:23 +0800
Message-ID: <CACGkMEujXYNE-88=m9ohjbeAj2F7CqEUes8gOUmasTNtwn2bUA@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: support polling I/O
To: Suwan Kim <suwan.kim027@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-block@vger.kernel.org, pbonzini <pbonzini@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, mst <mst@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============3471108349231938626=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============3471108349231938626==
Content-Type: multipart/alternative; boundary="00000000000010cde805da3e0408"

--00000000000010cde805da3e0408
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 14, 2022 at 8:33 PM Suwan Kim <suwan.kim027@gmail.com> wrote:

> On Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/3/11 =E4=B8=8B=E5=8D=8811:28, Suwan Kim =E5=86=99=E9=81=
=93:
> > > diff --git a/include/uapi/linux/virtio_blk.h
> b/include/uapi/linux/virtio_blk.h
> > > index d888f013d9ff..3fcaf937afe1 100644
> > > --- a/include/uapi/linux/virtio_blk.h
> > > +++ b/include/uapi/linux/virtio_blk.h
> > > @@ -119,8 +119,9 @@ struct virtio_blk_config {
> > >      * deallocation of one or more of the sectors.
> > >      */
> > >     __u8 write_zeroes_may_unmap;
> > > +   __u8 unused1;
> > > -   __u8 unused1[3];
> > > +   __virtio16 num_poll_queues;
> > >   } __attribute__((packed));
> >
> >
> > This looks like a implementation specific (virtio-blk-pci) optimization=
,
> how
> > about other implementation like vhost-user-blk?
>
> I didn=E2=80=99t consider vhost-user-blk yet. But does vhost-user-blk als=
o
> use vritio_blk_config as kernel-qemu interface?
>

Yes, but see below.


>
> Does vhost-user-blk need additional modification to support polling
> in kernel side?
>


No, but the issue is, things like polling looks not a good candidate for
the attributes belonging to the device but the driver. So I have more
questions:

1) what does it really mean for hardware virtio block devices?
2) Does driver polling help for the qemu implementation without polling?
3) Using blk_config means we can only get the benefit from the new device

Thanks



> Regards,
> Suwan Kim
>
>

--00000000000010cde805da3e0408
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 14, 2022 at 8:33 PM Suwan=
 Kim &lt;<a href=3D"mailto:suwan.kim027@gmail.com">suwan.kim027@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Mon, Mar 14, 2022 at 02:14:53PM +0800, Jason Wang wrote:<br>
&gt; <br>
&gt; =E5=9C=A8 2022/3/11 =E4=B8=8B=E5=8D=8811:28, Suwan Kim =E5=86=99=E9=81=
=93:<br>
&gt; &gt; diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux=
/virtio_blk.h<br>
&gt; &gt; index d888f013d9ff..3fcaf937afe1 100644<br>
&gt; &gt; --- a/include/uapi/linux/virtio_blk.h<br>
&gt; &gt; +++ b/include/uapi/linux/virtio_blk.h<br>
&gt; &gt; @@ -119,8 +119,9 @@ struct virtio_blk_config {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 * deallocation of one or more of the sectors.=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0__u8 write_zeroes_may_unmap;<br>
&gt; &gt; +=C2=A0 =C2=A0__u8 unused1;<br>
&gt; &gt; -=C2=A0 =C2=A0__u8 unused1[3];<br>
&gt; &gt; +=C2=A0 =C2=A0__virtio16 num_poll_queues;<br>
&gt; &gt;=C2=A0 =C2=A0} __attribute__((packed));<br>
&gt; <br>
&gt; <br>
&gt; This looks like a implementation specific (virtio-blk-pci) optimizatio=
n, how<br>
&gt; about other implementation like vhost-user-blk?<br>
<br>
I didn=E2=80=99t consider vhost-user-blk yet. But does vhost-user-blk also<=
br>
use vritio_blk_config as kernel-qemu interface?<br></blockquote><div><br></=
div><div>Yes, but see below.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
Does vhost-user-blk need additional modification to support polling<br>
in kernel side?<br></blockquote><div><br></div><div><br></div><div>No, but =
the issue is, things=C2=A0like polling looks not a good candidate for the a=
ttributes belonging to the device but the driver. So I have more questions:=
</div><div><br></div><div>1) what does it really mean for hardware virtio b=
lock devices?</div><div>2) Does driver polling help for the qemu implementa=
tion without polling?</div><div>3) Using blk_config means we can only get t=
he benefit from the new device</div><div><br></div><div>Thanks</div><div>=
=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
Regards,<br>
Suwan Kim<br>
<br>
</blockquote></div></div>

--00000000000010cde805da3e0408--


--===============3471108349231938626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3471108349231938626==--

