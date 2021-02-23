Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D100FC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:02:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A3A64E22
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A3A64E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8BD8605C2;
	Tue, 23 Feb 2021 10:02:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D1oE8yg8487N; Tue, 23 Feb 2021 10:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66CA26059C;
	Tue, 23 Feb 2021 10:02:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29636C000D;
	Tue, 23 Feb 2021 10:02:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CA9EC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5A14B84FB0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YsO578tWiTIU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:02:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6F39184F76
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:02:53 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id 18so17079790oiz.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/VPQlw/Q0S8vBnagCuK8FZwxI5Xz9TCUhxvl2odhRXY=;
 b=M6wq3JHD5aHPNJ+/TKAg3dMpKvT7GVcps3q1gBuRIlnstP0zjnQ/OhpXltOzEBjoxW
 beruzYtTnGrc3X7Gy9MI/+wdcGQferqFE/3dKCIrPkS8EitNsl2MlHA9Gae9rMNKlcxy
 RM+teObFye201hZuno15svM4Bx+RJc4DudHzZ+n2II4LXhU2vs+KoetyG8g5tLdtkCGP
 prwErJAUetoPO3bLFeRGHR4scIYDDepVcpXNEzvx0dfTaeOLqjRuyD/g3RYcCGSvuG4y
 DWyF3pfIJHleLVcIGyTvwssCsVBqZL0O14gaKfploiOfExHfQDbjzXcgpvdtkpLHDagy
 ffvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/VPQlw/Q0S8vBnagCuK8FZwxI5Xz9TCUhxvl2odhRXY=;
 b=VqL1tQ6ty9FwTE1PiNzX/DNcKRuiCcuXdb2SFUhQNd/2cTMBKG9n0QVcYW8QAlRthR
 xw5MNsyFfrw+x3KfNczsOWlKHnRcOFZV1x6aJqiDeiGO7XXHK+hOPPuuABOQMVVj+TX7
 3bt4PPAn7Rw27IPV2wBf77U5aVToXmsxtPYDglVVEB/Pqrf4cUaOW5QOe1pMWJUfVxzE
 dGw9n3sjhDomMJYPBWTvINIFKBL6wqgq+yWKHLRzmgJ8Auh3AUINvjMiog+vCP0p/SAD
 fxUARI2ln3i8O+DsfJLA1TIlmeTYSgewLhND8lEDfwznKNzUr7qx8GCs21fcw1DRHCgk
 mnWQ==
X-Gm-Message-State: AOAM533fnMQVZ9D+P6lyTFtvkQiNRMBQYm0j82qIWqklD2RhjN9W1zY1
 1Y0Ctn70PBDGsU7790X8Vz++X3gNQleJFSFccaM=
X-Google-Smtp-Source: ABdhPJy3H5GsBkTnTUI/NhM3VxqnX+n9i/pqZC6HyTjl9ROiYwgPp8+kUmIwIYhT385h9k5xAS4Y9yBpL+dcbXhsd2U=
X-Received: by 2002:a05:6808:491:: with SMTP id
 z17mr18049688oid.22.1614074572802; 
 Tue, 23 Feb 2021 02:02:52 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-rMYrf8ZBAHaxd51q2c5GVLEfpwgE26RpmGrr=pg7syeSfNw@mail.gmail.com>
 <d1ee6ed2-ccc7-c4aa-02c9-ad1b28818ed2@redhat.com>
In-Reply-To: <d1ee6ed2-ccc7-c4aa-02c9-ad1b28818ed2@redhat.com>
From: Gautam Dawar <gdawar.xilinx@gmail.com>
Date: Tue, 23 Feb 2021 15:32:41 +0530
Message-ID: <CAJ-rMYpnUGBHnWwVnC_KAAWxbjnD+oRdsjYBmeUB19Hn_R=pdA@mail.gmail.com>
Subject: Re: [PATCH] vhost vdpa: fix the irq check for invoking
 irq_bypass_unregister_producer
To: Jason Wang <jasowang@redhat.com>
Cc: martinh@xilinx.com, hanand@xilinx.com,
 virtualization@lists.linux-foundation.org, gdawar@xilinx.com, mst@redhat.com
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
Content-Type: multipart/mixed; boundary="===============2231818288306914410=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2231818288306914410==
Content-Type: multipart/alternative; boundary="0000000000008d8e9005bbfe050e"

--0000000000008d8e9005bbfe050e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Feb 2021 at 10:13, Jason Wang <jasowang@redhat.com> wrote:

>
> On 2021/2/22 =E4=B8=8B=E5=8D=885:13, Gautam Dawar wrote:
> > When qemu with vhost-vdpa netdevice is run for the first time, it
> > works well.
> > But after the VM is powered off, the next qemu run causes kernel panic
> > due to
> > a NULL pointer dereference in irq_bypass_register_producer().
> >
> > When the VM is powered off, vhost_vdpa_clean_irq() misses on calling
> > irq_bypass_unregister_producer() for irq 0 because of the existing chec=
k.
> >
> > This leaves stale producer nodes, which are reset in
> > vhost_vring_call_reset()
> > when vhost_dev_init() is invoked during the second qemu run.
> >
> > As the node member of struct irq_bypass_producer is also initialized
> > to zero, traversal on the producers list causes crash due to NULL point=
er
> > dereference.
> >
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D211711
> > Signed-off-by: Gautam Dawar <gdawar@xilinx.com <mailto:gdawar@xilinx.co=
m
> >>
> >
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 62a9bb0efc55..d1c3a33c6239 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -849,7 +849,7 @@ static void vhost_vdpa_clean_irq(struct vhost_vdpa
> *v)
> >
> >         for (i =3D 0; i < v->nvqs; i++) {
> >                 vq =3D &v->vqs[i];
> > -               if (vq->call_ctx.producer.irq)
> > +               if (vq->call_ctx.producer.irq >=3D 0)
> > irq_bypass_unregister_producer(&vq->call_ctx.producer);
>
>
> Since it's impossible to have an irq < 0 ( see
> vhost_vdap_setup_vq_irq()), I think we can simply remove the check above.
>
> Then we can call vhost_vdpa_unsetup_vq_irq() here to avoid temporary
> variable like vq.
>
>
Done and submitted patch v2.


> Thanks
>
>
> >         }
> >  }
>
> Regards,
Gautam

--0000000000008d8e9005bbfe050e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 23 Feb 2021 at 10:13, Jason W=
ang &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2021/2/22 =E4=B8=8B=E5=8D=885:13, Gautam Dawar wrote:<br>
&gt; When qemu with vhost-vdpa netdevice is run for the first time, it <br>
&gt; works well.<br>
&gt; But after the VM is powered off, the next qemu run causes kernel panic=
 <br>
&gt; due to<br>
&gt; a NULL pointer dereference in irq_bypass_register_producer().<br>
&gt;<br>
&gt; When the VM is powered off, vhost_vdpa_clean_irq() misses on calling<b=
r>
&gt; irq_bypass_unregister_producer() for irq 0 because of the existing che=
ck.<br>
&gt;<br>
&gt; This leaves stale producer nodes, which are reset in <br>
&gt; vhost_vring_call_reset()<br>
&gt; when vhost_dev_init() is invoked during the second qemu run.<br>
&gt;<br>
&gt; As the node member of struct irq_bypass_producer is also initialized<b=
r>
&gt; to zero, traversal on the producers list causes crash due to NULL poin=
ter<br>
&gt; dereference.<br>
&gt;<br>
&gt; Bugzilla: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D211=
711" rel=3D"noreferrer" target=3D"_blank">https://bugzilla.kernel.org/show_=
bug.cgi?id=3D211711</a><br>
&gt; Signed-off-by: Gautam Dawar &lt;<a href=3D"mailto:gdawar@xilinx.com" t=
arget=3D"_blank">gdawar@xilinx.com</a> &lt;mailto:<a href=3D"mailto:gdawar@=
xilinx.com" target=3D"_blank">gdawar@xilinx.com</a>&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c<br>
&gt; index 62a9bb0efc55..d1c3a33c6239 100644<br>
&gt; --- a/drivers/vhost/vdpa.c<br>
&gt; +++ b/drivers/vhost/vdpa.c<br>
&gt; @@ -849,7 +849,7 @@ static void vhost_vdpa_clean_irq(struct vhost_vdpa=
 *v)<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; v-&gt;nvqs; i++) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D &amp;v-=
&gt;vqs[i];<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vq-&gt;call_ctx=
.producer.irq)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vq-&gt;call_ctx=
.producer.irq &gt;=3D 0)<br>
&gt; irq_bypass_unregister_producer(&amp;vq-&gt;call_ctx.producer);<br>
<br>
<br>
Since it&#39;s impossible to have an irq &lt; 0 ( see <br>
vhost_vdap_setup_vq_irq()), I think we can simply remove the check above.<b=
r>
<br>
Then we can call vhost_vdpa_unsetup_vq_irq() here to avoid temporary <br>
variable like vq.<br>
<br></blockquote><div><br></div><div>Done and submitted patch v2.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks<br>
<br>
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0}<br>
<br></blockquote><div>Regards,</div><div>Gautam=C2=A0</div></div></div>

--0000000000008d8e9005bbfe050e--

--===============2231818288306914410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2231818288306914410==--
