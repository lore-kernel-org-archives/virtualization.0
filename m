Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C2EC433E0
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 09:17:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A36164DF2
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 09:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A36164DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2266605DD;
	Mon, 22 Feb 2021 09:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gD7Qlgjapzez; Mon, 22 Feb 2021 09:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D95A600B8;
	Mon, 22 Feb 2021 09:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 452D2C000A;
	Mon, 22 Feb 2021 09:17:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC8AAC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA17F838D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8qLsic3X8rsD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:17:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12F91838CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 09:17:17 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id k13so812334otn.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 01:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JXZV647H5BYCHpnVbK18NPhPYUqUbASDZFa6HiBidv4=;
 b=R2L1Bb1ZfQDb04etZCJmOS4fJmEnABVD3Y0ha5wCtoocWbdGx/AQRp3QTQNYwUlox4
 dQW2mpnBgmEmdukvZwgwiHWjJiGuHDWbXIWeFp3nCV8xvqdN0Rf0mWH681VlOWyKubNP
 5j9TSlqots+7i26mm8usT3sdofoYdemf+Pc2zRSKVbTzBWb5PmAIQZkUJSMlsc8v6ACh
 j1SO3d1IvcVybpxW4Ny4Z5dUFjkKVpslJxuR3YuBBE4FA8uWEnoErnJV8faAE98lzEOj
 plAnqZ1/qEnI5Ey3qYMNs5dYy5de2hxkRyS7ON7CSxVAruYJjHQ/+nc+AaEtdzkAUk+W
 XLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JXZV647H5BYCHpnVbK18NPhPYUqUbASDZFa6HiBidv4=;
 b=Q3wS2OzNAksyjv4aaybdAI7RMc2InlWXgR8qmkSAKpZrdqq824msfAba41ffpREJyU
 q7N8ptNauiJJ9ezkaiejCIbtJ7ZRMHOHSPG2enGMwW4zCO20qoOg3TJ6CMcRAoPu1lTI
 Lal3BBhAkInOVDBVQvTErxDNYH0LGh68+tK9aPGYwRZtDUO8KTXP4s7FpS7jhu0izN7B
 MHcMdH8Khw0ZCsiKn2nWM58lSNvyeA4hyxMF9WrQZDj0zPU7GWD/0zHI09ZAziFTvYAb
 GaM9Uj7TgxP0MGZ52F0GA4hF9kbFL8DDJaQc/MCn57wW7Fw+KXTJ2i5Gg1vvpQ5TUXUj
 51ug==
X-Gm-Message-State: AOAM531hHz+tn7Va7fviJuIoX5GxFf4ZLWTusuqxGmw3/wechqY/3dtJ
 de2InPqQcgMZicYct5TZF02uVO2xHQYVVd0BVOE=
X-Google-Smtp-Source: ABdhPJxrtmdGpEVqPzCczcvP70u3HmP6L1HuyW1LdtdGUfs+yrj9mHq13Z0S4kCrY2rb6o+0FkR43QoGnVfkvJXAZFs=
X-Received: by 2002:a9d:2da2:: with SMTP id g31mr15772769otb.222.1613985437017; 
 Mon, 22 Feb 2021 01:17:17 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-rMYoK9k=z0q7Dv9pJTDUxGJL5UiKhy1RERqCiTSL-qsFNHw@mail.gmail.com>
 <f5028d5b-bbdf-b548-9d0e-939ee549c695@redhat.com>
 <CAJ-rMYp05zE4a9+BnoPt3Ta=3p1w9aCN=SBcWozVHD4asJMLFw@mail.gmail.com>
 <33402945-5871-3045-1196-da67a6a47a39@redhat.com>
In-Reply-To: <33402945-5871-3045-1196-da67a6a47a39@redhat.com>
From: Gautam Dawar <gdawar.xilinx@gmail.com>
Date: Mon, 22 Feb 2021 14:47:06 +0530
Message-ID: <CAJ-rMYqMBjGpEEO1Vmg9tzMS3G0noa3Jjf-EoLFVQEaT-NVsDQ@mail.gmail.com>
Subject: Re: Kernel panic with vhost-vdpa
To: Jason Wang <jasowang@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============4256077232648915007=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============4256077232648915007==
Content-Type: multipart/alternative; boundary="000000000000a5695305bbe944f5"

--000000000000a5695305bbe944f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jason. I've posted the formal patch for this change.

Regards,
Gautam

On Mon, 22 Feb 2021 at 14:15, Jason Wang <jasowang@redhat.com> wrote:

>
> On 2021/2/18 11:15 =E4=B8=8B=E5=8D=88, Gautam Dawar wrote:
>
> Hi Jason,
>
> Thanks for your response.
>
> On Thu, 18 Feb 2021 at 14:18, Jason Wang <jasowang@redhat.com> wrote:
>
>> Hi Gautam:
>> On 2021/2/15 9:01 =E4=B8=8B=E5=8D=88, Gautam Dawar wrote:
>>
>> Hi Jason/Michael,
>>
>>
>>
>> I observed a kernel panic while testing vhost-vdpa with Xilinx adapters.
>> Here are the details for your review:
>>
>>
>>
>> Problem statement:
>>
>> When qemu with vhost-vdpa netdevice is run for the first time, it works
>> well. But after the VM is powered off, next qemu run causes kernel panic
>> due to a NULL pointer dereference in irq_bypass_register_producer().
>>
>>
>>
>> Root cause analysis:
>>
>> When the VM is powered off, vhost_dev_stop() is invoked which in turn
>> calls vhost_vdpa_reset_device() causing the irq_bypass producers to be
>> unregistered.
>>
>>
>>
>> On the next run, when qemu opens the vhost device, the vhost_vdpa_open()
>> file operation calls vhost_dev_init(). Here, call_ctx->producer memory i=
s
>> cleared in vhost_vring_call_reset().
>>
>>
>>
>> Further, when the virtqueues are initialized by vhost_virtqueue_init(),
>> vhost_vdpa_setup_vq_irq() again registers the irq_bypass producer for ea=
ch
>> virtqueue. As the node member of struct irq_bypass_producer is also
>> initialized to zero, traversal on the producers list causes crash due to
>> NULL pointer dereference.
>>
>>
>> Thanks a lot for reporting this issue.
>>
>>
>>
>>
>> Fix details:
>>
>>
>>
>> I think that this issue can be fixed by invoking
>> vhost_vdpa_setup_vq_irq() only when vhost_vdpa_set_status() includes
>> VIRTIO_CONFIG_S_DRIVER_OK in the new status value. This way, there won=
=E2=80=99t be
>> any stale nodes in the irqbypass  module=E2=80=99s producers list which =
are reset
>> in vhost_vring_call_reset().
>>
>>
>>
>> Patch:
>>
>>
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c index
>> 62a9bb0efc55..fdad94e2fbf9 100644
>>
>> --- a/drivers/vhost/vdpa.c
>>
>> +++ b/drivers/vhost/vdpa.c
>>
>> @@ -409,7 +409,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa
>> *v, unsigned int cmd,
>>
>>                         cb.private =3D NULL;
>>
>>                 }
>>
>>                 ops->set_vq_cb(vdpa, idx, &cb);
>>
>> -               vhost_vdpa_setup_vq_irq(v, idx);
>>
>>                 break;
>>
>>
>>
>>         case VHOST_SET_VRING_NUM:
>>
>>
>>
>> We can also track this issue in Bugzilla ticket 21171 (
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D211711)  and the complete
>> patch is attached with this email.
>>
>>
>> So vhost supports to remove or switch eventfd through
>> vhost_vdpa_vring_ioctl(). So if userspace want to switch to another
>> eventfd, we should re-do the register and unregister.
>>
> GD>>  This makes sense. I missed the use case where userspace may want to
> switch to a different eventfd.
>
>
> This can happen when interrupt needs to be disabled for some reason (e.g
> MSI-X is masked).
>
>
>
> I think we need to deal this issue in another way. Can we check whether o=
r
>> not the producer is initialized before?
>>
>> Thanks
>>
> GD>> Initialization path is fine but the actual problem lies in the
> clean-up part.
> I think the following check is the cause of this issue:
>
> static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
>                 if (vq->call_ctx.producer.irq)
>
> irq_bypass_unregister_producer(&vq->call_ctx.producer);
>
> The above if condition will prevent the de-initialization of the producer
> nodes corresponding to irq 0 but  irq_bypass_unregister_producer() should
> be called for all valid irq values including zero.
>
> Accordingly, following patch is required to fix this issue:
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 62a9bb0efc55..d1c3a33c6239 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -849,7 +849,7 @@ static void vhost_vdpa_clean_irq(struct vhost_vdpa *v=
)
>
>         for (i =3D 0; i < v->nvqs; i++) {
>                 vq =3D &v->vqs[i];
> -               if (vq->call_ctx.producer.irq)
> +               if (vq->call_ctx.producer.irq >=3D 0)
>
> irq_bypass_unregister_producer(&vq->call_ctx.producer);
>         }
>  }
>
>
> It should work, please post a formal patch for this.
>
> I will give more thought in the meanwhile since I spot some other defects
> on codes for irqbyass usage in vdpa.
>
> Thanks
>
>
>
> The revised patch (bug211711_fix.patch) is also attached with this email.
>
>>
>>
>> Regards,
>>
>> Gautam Dawar
>>
>>

--000000000000a5695305bbe944f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Jason. I&#39;ve posted the formal patch for this ch=
ange.<div><br></div><div>Regards,</div><div>Gautam</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 22 Feb 2021=
 at 14:15, Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=3D"=
_blank">jasowang@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 2021/2/18 11:15 =E4=B8=8B=E5=8D=88, Gautam Dawar
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>Hi Jason,</div>
        <div><br>
        </div>
        <div>
          <div>Thanks for your response.</div>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Thu, 18 Feb 2021 at
            14:18, Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" ta=
rget=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p>Hi Gautam:<br>
              </p>
              <div>On 2021/2/15 9:01 =E4=B8=8B=E5=8D=88, Gautam Dawar wrote=
:<br>
              </div>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">Hi
                    Jason/Michael,</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">I
                    observed a kernel panic while testing vhost-vdpa
                    with Xilinx adapters. Here are the details for your
                    review:</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">Problem
                    statement: </p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">When
                    qemu with vhost-vdpa netdevice is run for the first
                    time, it works well. But after the VM is powered
                    off, next qemu run causes kernel panic due to a NULL
                    pointer dereference in
                    irq_bypass_register_producer().</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">Root
                    cause analysis:</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">When
                    the VM is powered off, vhost_dev_stop() is invoked
                    which in turn calls vhost_vdpa_reset_device()
                    causing the irq_bypass producers to be unregistered.</p=
>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">On
                    the next run, when qemu opens the vhost device, the
                    vhost_vdpa_open() file operation calls
                    vhost_dev_init(). Here, call_ctx-&gt;producer memory
                    is cleared in vhost_vring_call_reset().</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">Further,
                    when the virtqueues are initialized by
                    vhost_virtqueue_init(), vhost_vdpa_setup_vq_irq()
                    again registers the irq_bypass producer for each
                    virtqueue. As the node member of struct
                    irq_bypass_producer is also initialized to zero,
                    traversal on the producers list causes crash due to
                    NULL pointer dereference.</p>
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
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">Fix
                    details:</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">I
                    think that this issue can be fixed by invoking
                    vhost_vdpa_setup_vq_irq() only when
                    vhost_vdpa_set_status() includes
                    VIRTIO_CONFIG_S_DRIVER_OK in the new status value.
                    This way, there won=E2=80=99t be any stale nodes in the
                    irqbypass=C2=A0 module=E2=80=99s producers list which a=
re reset
                    in vhost_vring_call_reset().</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">Patch:</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">diff
                    --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
                    index 62a9bb0efc55..fdad94e2fbf9 100644</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">---
                    a/drivers/vhost/vdpa.c</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">+++
                    b/drivers/vhost/vdpa.c</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">@@
                    -409,7 +409,6 @@ static long
                    vhost_vdpa_vring_ioctl(struct vhost_vdpa *v,
                    unsigned int cmd,</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
                    cb.private =3D NULL;</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                    }</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                    ops-&gt;set_vq_cb(vdpa, idx, &amp;cb);</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                    vhost_vdpa_setup_vq_irq(v, idx);</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                    break;</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
                    case VHOST_SET_VRING_NUM: </p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">We
                    can also track this issue in Bugzilla ticket 21171 (<a =
href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D211711" style=3D"colo=
r:rgb(5,99,193)" target=3D"_blank">https://bugzilla.kernel.org/show_bug.cgi=
?id=3D211711</a>)=C2=A0
                    and the complete patch is attached with this email.</p>
                </div>
              </blockquote>
              <p><br>
              </p>
              <p>So vhost supports to remove or switch eventfd through
                vhost_vdpa_vring_ioctl(). So if userspace want to switch
                to another eventfd, we should re-do the register and
                unregister.</p>
            </div>
          </blockquote>
          <div>GD&gt;&gt;=C2=A0 This makes sense. I missed the use case whe=
re
            userspace may want to switch to a different eventfd.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>This can happen when interrupt needs to be disabled for some
      reason (e.g MSI-X is masked).<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div><br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p>I think we need to deal this issue in another way. Can
                we check whether or not the producer is initialized
                before?</p>
              <p>Thanks</p>
            </div>
          </blockquote>
          <div>GD&gt;&gt; Initialization path is fine but the actual
            problem lies in the clean-up part.</div>
          <div>I think the following check is the cause of this issue:</div=
>
          <div><br>
          </div>
          <div>static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)</div>
          <div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <fon=
t color=3D"#ff0000">if
              (vq-&gt;call_ctx.producer.irq)</font><br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
            irq_bypass_unregister_producer(&amp;vq-&gt;call_ctx.producer);<=
br>
          </div>
          <div>=C2=A0</div>
          <div>The above if condition will prevent the de-initialization
            of the producer nodes corresponding to irq 0 but=C2=A0
            irq_bypass_unregister_producer() should be called for all
            valid irq values including zero.</div>
          <div><br>
          </div>
          <div>Accordingly, following patch is required to fix this
            issue:</div>
          <div><br>
          </div>
          <div>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c<br>
            index 62a9bb0efc55..d1c3a33c6239 100644<br>
            --- a/drivers/vhost/vdpa.c<br>
            +++ b/drivers/vhost/vdpa.c<br>
            @@ -849,7 +849,7 @@ static void vhost_vdpa_clean_irq(struct
            vhost_vdpa *v)<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; v-&gt;nvqs; i+=
+) {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D =
&amp;v-&gt;vqs[i];<br>
            - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vq-&gt;c=
all_ctx.producer.irq)<br>
            + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vq-&gt;c=
all_ctx.producer.irq &gt;=3D 0)<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
            irq_bypass_unregister_producer(&amp;vq-&gt;call_ctx.producer);<=
br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
            =C2=A0}<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>It should work, please post a formal patch for this.</p>
    <p>I will give more thought in the meanwhile since I spot some other
      defects on codes for irqbyass usage in vdpa.</p>
    <p>Thanks<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_quote">
          <div><br>
          </div>
          <div>The revised patch (bug211711_fix.patch) is also attached
            with this email.</div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">=C2=A0</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">Regards,</p>
                  <p style=3D"margin:0in 0in 0.0001pt;font-size:11pt;font-f=
amily:Calibri,sans-serif">Gautam
                    Dawar</p>
                </div>
              </blockquote>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </div>

</blockquote></div>

--000000000000a5695305bbe944f5--

--===============4256077232648915007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4256077232648915007==--
