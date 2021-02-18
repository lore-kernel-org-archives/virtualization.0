Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F226C433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 15:15:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA9264E33
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 15:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA9264E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 309716065C
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 15:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7_cl0ExUmk1T for <virtualization@archiver.kernel.org>;
	Thu, 18 Feb 2021 15:15:44 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 2FEC36064D; Thu, 18 Feb 2021 15:15:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55A8C605CE;
	Thu, 18 Feb 2021 15:15:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36D2CC000E;
	Thu, 18 Feb 2021 15:15:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72AFEC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 15:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5F6CB87385
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 15:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oAvUTOzMcoH0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 15:15:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 39A5E87351
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 15:15:36 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id b16so2163278otq.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 07:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fqOoSnLntu1r0yNQXqRnssjyAY+6GUDjKbc/+jw3UJo=;
 b=Rjp98aaACh6wxzh2L+iJIOamwRWc5pVwinKPHfU4Dj9qzJMWnq1XONczyHJBwWBfxC
 ErOYDCtR1HxCJGH3k6KzvgQ7hAl7Wve27UbA1M4UFw8cESB7qfGzLxKrmfxi02KH6rEN
 CDQtUr8kLRa/uLJd/0fiP364Bd4tOWzv6oJECdMLrcVAFCuxl+AhCjzk4SONuYZheaTt
 g3Hybj7xJg/Nfv/jIoNPquqraOey7P9OZwQr8Hw+953EA2aTb8kxPjqDWJlSAvOsdNcA
 /5CKujKynQK+FnUWju6WKuPyYAdqr1sZ9noCLXhK49as1NkHjlY/bjLZH7GsW9+2fErC
 cX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fqOoSnLntu1r0yNQXqRnssjyAY+6GUDjKbc/+jw3UJo=;
 b=Nm7vNZdvoemP8OufeuP3r9S7aykd3fuBeqPX8yXLsg9QpuLupT1GZ7Fvzgxl3u6S3v
 HAuAk6japa0+rHnNFaScvdPMScbn5+1uevlJpR9vE6AMcqyFIKenrpTIg2cIUarY+nfN
 NAAm7bxTazesFw3C16mCM/jmCO6W8GN7GgNld0xzcyQzsZjX9ENtQH+9FMuONT4XrkCj
 ufuCZxg2WUKkgr2UfEKEgex1WhKImYIk6pYSYdZqeT/qh5QoqNtxBcuHC8DsA4Eid56j
 Ii8Ja53Ej9SfLRHFoVVvuClGyZN7ITJi+llIufxH5XcvJphwWT03SOyZ6u7v/zhjCfbF
 bfww==
X-Gm-Message-State: AOAM532Rh7+NY2ukl6ff0s2K6uKH0VpIOwgonW5lF/qbP+FrewKOSdUh
 BjnH55IPb+c3/xIZMFP7gfXw2kU19gTh/Rf4wpY=
X-Google-Smtp-Source: ABdhPJz3ftncnzSbKkUbPdDOeKQLORXEvqFfIZTAMMFqBLAA/EMO1Ag7PEhe0+EE29lrkbZ0trXUKj7VWh5HTq2AypI=
X-Received: by 2002:a9d:6393:: with SMTP id w19mr3296088otk.99.1613661335500; 
 Thu, 18 Feb 2021 07:15:35 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-rMYoK9k=z0q7Dv9pJTDUxGJL5UiKhy1RERqCiTSL-qsFNHw@mail.gmail.com>
 <f5028d5b-bbdf-b548-9d0e-939ee549c695@redhat.com>
In-Reply-To: <f5028d5b-bbdf-b548-9d0e-939ee549c695@redhat.com>
From: Gautam Dawar <gdawar.xilinx@gmail.com>
Date: Thu, 18 Feb 2021 20:45:24 +0530
Message-ID: <CAJ-rMYp05zE4a9+BnoPt3Ta=3p1w9aCN=SBcWozVHD4asJMLFw@mail.gmail.com>
Subject: Re: Kernel panic with vhost-vdpa
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000b0d8ea05bb9dce08"
Cc: martinh@xilinx.com, hanand@xilinx.com, mst@redhat.com, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--000000000000b0d8ea05bb9dce08
Content-Type: multipart/alternative; boundary="000000000000b0d8e405bb9dce06"

--000000000000b0d8e405bb9dce06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

Thanks for your response.

On Thu, 18 Feb 2021 at 14:18, Jason Wang <jasowang@redhat.com> wrote:

> Hi Gautam:
> On 2021/2/15 9:01 =E4=B8=8B=E5=8D=88, Gautam Dawar wrote:
>
> Hi Jason/Michael,
>
>
>
> I observed a kernel panic while testing vhost-vdpa with Xilinx adapters.
> Here are the details for your review:
>
>
>
> Problem statement:
>
> When qemu with vhost-vdpa netdevice is run for the first time, it works
> well. But after the VM is powered off, next qemu run causes kernel panic
> due to a NULL pointer dereference in irq_bypass_register_producer().
>
>
>
> Root cause analysis:
>
> When the VM is powered off, vhost_dev_stop() is invoked which in turn
> calls vhost_vdpa_reset_device() causing the irq_bypass producers to be
> unregistered.
>
>
>
> On the next run, when qemu opens the vhost device, the vhost_vdpa_open()
> file operation calls vhost_dev_init(). Here, call_ctx->producer memory is
> cleared in vhost_vring_call_reset().
>
>
>
> Further, when the virtqueues are initialized by vhost_virtqueue_init(),
> vhost_vdpa_setup_vq_irq() again registers the irq_bypass producer for eac=
h
> virtqueue. As the node member of struct irq_bypass_producer is also
> initialized to zero, traversal on the producers list causes crash due to
> NULL pointer dereference.
>
>
> Thanks a lot for reporting this issue.
>
>
>
>
> Fix details:
>
>
>
> I think that this issue can be fixed by invoking vhost_vdpa_setup_vq_irq(=
)
> only when vhost_vdpa_set_status() includes VIRTIO_CONFIG_S_DRIVER_OK in t=
he
> new status value. This way, there won=E2=80=99t be any stale nodes in the
> irqbypass  module=E2=80=99s producers list which are reset in
> vhost_vring_call_reset().
>
>
>
> Patch:
>
>
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c index
> 62a9bb0efc55..fdad94e2fbf9 100644
>
> --- a/drivers/vhost/vdpa.c
>
> +++ b/drivers/vhost/vdpa.c
>
> @@ -409,7 +409,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa
> *v, unsigned int cmd,
>
>                         cb.private =3D NULL;
>
>                 }
>
>                 ops->set_vq_cb(vdpa, idx, &cb);
>
> -               vhost_vdpa_setup_vq_irq(v, idx);
>
>                 break;
>
>
>
>         case VHOST_SET_VRING_NUM:
>
>
>
> We can also track this issue in Bugzilla ticket 21171 (
> https://bugzilla.kernel.org/show_bug.cgi?id=3D211711)  and the complete
> patch is attached with this email.
>
>
> So vhost supports to remove or switch eventfd through
> vhost_vdpa_vring_ioctl(). So if userspace want to switch to another
> eventfd, we should re-do the register and unregister.
>
GD>>  This makes sense. I missed the use case where userspace may want to
switch to a different eventfd.

I think we need to deal this issue in another way. Can we check whether or
> not the producer is initialized before?
>
> Thanks
>
GD>> Initialization path is fine but the actual problem lies in the
clean-up part.
I think the following check is the cause of this issue:

static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
                if (vq->call_ctx.producer.irq)

irq_bypass_unregister_producer(&vq->call_ctx.producer);

The above if condition will prevent the de-initialization of the producer
nodes corresponding to irq 0 but  irq_bypass_unregister_producer() should
be called for all valid irq values including zero.

Accordingly, following patch is required to fix this issue:

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 62a9bb0efc55..d1c3a33c6239 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -849,7 +849,7 @@ static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)

        for (i =3D 0; i < v->nvqs; i++) {
                vq =3D &v->vqs[i];
-               if (vq->call_ctx.producer.irq)
+               if (vq->call_ctx.producer.irq >=3D 0)

irq_bypass_unregister_producer(&vq->call_ctx.producer);
        }
 }

The revised patch (bug211711_fix.patch) is also attached with this email.

>
>
> Regards,
>
> Gautam Dawar
>
>

--000000000000b0d8e405bb9dce06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jason,</div><div><br></div><div><div>Thanks for yo=
ur response.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, 18 Feb 2021 at 14:18, Jason Wang &lt;<a href=3D"m=
ailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    <p>Hi Gautam:<br>
    </p>
    <div>On 2021/2/15 9:01 =E4=B8=8B=E5=8D=88, Gautam Dawar
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">Hi
          Jason/Michael,</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">I
          observed a kernel panic while testing vhost-vdpa with
          Xilinx adapters. Here are the details for your review:</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">Problem
          statement: </p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">When
          qemu with vhost-vdpa netdevice is run for the first
          time, it works well. But after the VM is powered off, next
          qemu run causes
          kernel panic due to a NULL pointer dereference in
          irq_bypass_register_producer().</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">Root
          cause analysis:</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">When
          the VM is powered off, vhost_dev_stop() is invoked
          which in turn calls vhost_vdpa_reset_device() causing the
          irq_bypass producers
          to be unregistered.</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">On the
          next run, when qemu opens the vhost device, the
          vhost_vdpa_open() file operation calls vhost_dev_init(). Here,
          call_ctx-&gt;producer
          memory is cleared in vhost_vring_call_reset().</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">Further,
          when the virtqueues are initialized by
          vhost_virtqueue_init(), vhost_vdpa_setup_vq_irq() again
          registers the
          irq_bypass producer for each virtqueue. As the node member of
          struct irq_bypass_producer
          is also initialized to zero, traversal on the producers list
          causes crash due
          to NULL pointer dereference.</p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Thanks a lot for reporting this issue.<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">Fix
          details:</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">I
          think that this issue can be fixed by invoking
          vhost_vdpa_setup_vq_irq() only when vhost_vdpa_set_status()
          includes
          VIRTIO_CONFIG_S_DRIVER_OK in the new status value. This way,
          there won=E2=80=99t be any
          stale nodes in the irqbypass=C2=A0 module=E2=80=99s
          producers list which are reset in vhost_vring_call_reset().</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">Patch:</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">diff
          --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
          index 62a9bb0efc55..fdad94e2fbf9 100644</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">---
          a/drivers/vhost/vdpa.c</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">+++
          b/drivers/vhost/vdpa.c</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">@@
          -409,7 +409,6 @@ static long
          vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,</p=
>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
          cb.private =3D NULL;</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
          }</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
          ops-&gt;set_vq_cb(vdpa,
          idx, &amp;cb);</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
          vhost_vdpa_setup_vq_irq(v, idx);</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
          break;</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
          case
          VHOST_SET_VRING_NUM: </p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">We can
          also track this issue in Bugzilla ticket 21171 (<a href=3D"https:=
//bugzilla.kernel.org/show_bug.cgi?id=3D211711" style=3D"color:rgb(5,99,193=
)" target=3D"_blank">https://bugzilla.kernel.org/show_bug.cgi?id=3D211711</=
a>)=C2=A0
          and the complete patch is attached with this
          email.</p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>So vhost supports to remove or switch eventfd through
      vhost_vdpa_vring_ioctl(). So if userspace want to switch to
      another eventfd, we should re-do the register and unregister.</p></di=
v></blockquote><div>GD&gt;&gt;=C2=A0 This makes sense. I missed the use cas=
e where userspace may want to switch to a different eventfd.<br></div><div>=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>
    <p>I think we need to deal this issue in another way. Can we check
      whether or not the producer is initialized before?</p>
    <p>Thanks</p></div></blockquote><div>GD&gt;&gt; Initialization path is =
fine but the actual problem lies in the clean-up part.</div><div>I think th=
e following check is the cause of this issue:</div><div><br></div><div>stat=
ic void vhost_vdpa_clean_irq(struct vhost_vdpa *v)</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <font color=3D"#ff0000">if (vq-&g=
t;call_ctx.producer.irq)</font><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_bypass_unregister_produce=
r(&amp;vq-&gt;call_ctx.producer);<br></div><div>=C2=A0</div><div>The above =
if condition will prevent the de-initialization of the producer nodes corre=
sponding to irq 0 but=C2=A0

irq_bypass_unregister_producer() should be called for all valid irq values =
including zero.</div><div><br></div><div>Accordingly, following patch is re=
quired to fix this issue:</div><div><br></div><div>diff --git a/drivers/vho=
st/vdpa.c b/drivers/vhost/vdpa.c<br>index 62a9bb0efc55..d1c3a33c6239 100644=
<br>--- a/drivers/vhost/vdpa.c<br>+++ b/drivers/vhost/vdpa.c<br>@@ -849,7 +=
849,7 @@ static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)<br><br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; v-&gt;nvqs; i++) {<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D &amp;v-&gt;vqs[i];<=
br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vq-&gt;call_ctx.p=
roducer.irq)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vq-&=
gt;call_ctx.producer.irq &gt;=3D 0)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_bypass_unregister_prod=
ucer(&amp;vq-&gt;call_ctx.producer);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
=C2=A0}<br></div><div><br></div><div>The revised patch (bug211711_fix.patch=
) is also attached with this email.</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">=C2=A0</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">Regards,</p>
        <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-family:Cali=
bri,sans-serif">Gautam
          Dawar</p>
      </div>
    </blockquote>
  </div>

</blockquote></div></div>

--000000000000b0d8e405bb9dce06--
--000000000000b0d8ea05bb9dce08
Content-Type: application/octet-stream; name="bug211711_fix.patch"
Content-Disposition: attachment; filename="bug211711_fix.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_klb07x3s0>
X-Attachment-Id: f_klb07x3s0

Y29tbWl0IGQwZWEzYTU0M2IxM2RlZmJjZjMyMWRhNWUxMzZmYjg5NjY1MmI2OTcKQXV0aG9yOiBH
YXV0YW0gRGF3YXIgPGdkYXdhckB4aWxpbnguY29tPgpEYXRlOiAgIFRodSBGZWIgMTggMjA6Mzg6
NDYgMjAyMSArMDUzMAoKICAgIHZob3N0IHZkcGE6IGZpeCB0aGUgaXJxIGNoZWNrIGZvciBpbnZv
a2luZyBpcnFfYnlwYXNzX3VucmVnaXN0ZXJfcHJvZHVjZXIKICAgIAogICAgV2hlbiBxZW11IHdp
dGggdmhvc3QtdmRwYSBuZXRkZXZpY2UgaXMgcnVuIGZvciB0aGUgZmlyc3QgdGltZSwgaXQgd29y
a3Mgd2VsbC4KICAgIEJ1dCBhZnRlciB0aGUgVk0gaXMgcG93ZXJlZCBvZmYsIG5leHQgcWVtdSBy
dW4gY2F1c2VzIGtlcm5lbCBwYW5pYyBkdWUgdG8gYQogICAgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNlIGluIGlycV9ieXBhc3NfcmVnaXN0ZXJfcHJvZHVjZXIoKS4KICAgIAogICAgV2hlbiB0aGUg
Vk0gaXMgcG93ZXJlZCBvZmYsIHZob3N0X3ZkcGFfY2xlYW5faXJxKCkgbWlzc2VzIG9uIGNhbGxp
bmcKICAgIGlycV9ieXBhc3NfdW5yZWdpc3Rlcl9wcm9kdWNlcigpIGZvciBpcnEgMCBiZWNhdXNl
IG9mIGV4aXN0aW5nIGNoZWNrLgogICAgCiAgICBUaGlzIGxlYXZlcyBzdGFsZSBwcm9kdWNlciBu
b2Rlcywgd2hpY2ggYXJlIHJlc2V0IGluIHZob3N0X3ZyaW5nX2NhbGxfcmVzZXQoKQogICAgd2hl
biB2aG9zdF9kZXZfaW5pdCgpIGlzIGludm9rZWQgZHVyaW5nIHNlY29uZCBxZW11IHJ1bi4KICAg
IAogICAgQXMgdGhlIG5vZGUgbWVtYmVyIG9mIHN0cnVjdCBpcnFfYnlwYXNzX3Byb2R1Y2VyIGlz
IGFsc28gaW5pdGlhbGl6ZWQKICAgIHRvIHplcm8sIHRyYXZlcnNhbCBvbiB0aGUgcHJvZHVjZXJz
IGxpc3QgY2F1c2VzIGNyYXNoIGR1ZSB0byBOVUxMIHBvaW50ZXIKICAgIGRlcmVmZXJlbmNlLgog
ICAgCiAgICBCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNn
aT9pZD0yMTE3MTEKICAgIFNpZ25lZC1vZmYtYnk6IEdhdXRhbSBEYXdhciA8Z2Rhd2FyQHhpbGlu
eC5jb20+CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0
L3ZkcGEuYwppbmRleCA2MmE5YmIwZWZjNTUuLmQxYzNhMzNjNjIzOSAxMDA2NDQKLS0tIGEvZHJp
dmVycy92aG9zdC92ZHBhLmMKKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKQEAgLTg0OSw3ICs4
NDksNyBAQCBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX2NsZWFuX2lycShzdHJ1Y3Qgdmhvc3RfdmRw
YSAqdikKIAogCWZvciAoaSA9IDA7IGkgPCB2LT5udnFzOyBpKyspIHsKIAkJdnEgPSAmdi0+dnFz
W2ldOwotCQlpZiAodnEtPmNhbGxfY3R4LnByb2R1Y2VyLmlycSkKKwkJaWYgKHZxLT5jYWxsX2N0
eC5wcm9kdWNlci5pcnEgPj0gMCkKIAkJCWlycV9ieXBhc3NfdW5yZWdpc3Rlcl9wcm9kdWNlcigm
dnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsKIAl9CiB9Cg==
--000000000000b0d8ea05bb9dce08
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--000000000000b0d8ea05bb9dce08--
