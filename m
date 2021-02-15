Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AC0C433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 14:04:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F53664DBA
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 14:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F53664DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 149476F509
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 14:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ASfBKfAIwZJS for <virtualization@archiver.kernel.org>;
	Mon, 15 Feb 2021 14:04:37 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 3228E6F513; Mon, 15 Feb 2021 14:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52C896F4EA;
	Mon, 15 Feb 2021 14:04:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29158C0174;
	Mon, 15 Feb 2021 14:04:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D458C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5CAC786734
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wa47Ss+0UqSZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:04:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com
 [209.85.166.170])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 87C438666F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 14:04:31 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id d20so5551853ilo.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 06:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=CMk0288Ic0k2hVmewJgULrLbbB0KUo6UCLtLpXe4J9s=;
 b=J7LWZ6NWhWMZd40G6En3wc9FqEpIUZIeOWjoDUvu5YgHoY2FoZ3krYOHuvmiL7ocKZ
 47hgdAOaCcsU0yvhvzUL5hWSQ+6W1b3YNzvJN53Ez7rGYhA4kUDDeL/x3G3h72uOp1Gl
 MNlAMo7uZgCtTO9zkkfyjUUdvFxbH61y9saoc/ruImv/O0o+dSAltYy1BYGCzNmSjZmS
 x2frz+rmjGzzJ+fH3MEm3WMRNqsD8Kfwr8VZRAo4P8xro1LE1uU3KViKqLzwIzT0Ichx
 4g+MfCIrVdUso0uujx1WF6pGUwfPV3MfY70kGhYfCRETrBlvK95GxsYsETVVl6Zk1ysV
 02hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=CMk0288Ic0k2hVmewJgULrLbbB0KUo6UCLtLpXe4J9s=;
 b=tCcM65ZEqhBT478Vg9ciyfD0lyjzmEDPbymFgCXMRm0XPjL6no+SE8cC/fCZ3CYZs0
 C4sbfz3iOKW7bkgGGn8SEj0yZXGG6X5ammj0huQ8DJuR+XXGIRKiygoAbHsi7zlFvCaj
 e5pDkwOFHkSo6ob/fTeIQpXW5HSUoVxLi3n45Aaxxri617iCM4nhx0nmKacM4CuB+dS/
 lSKdXihhG9GQUAfv/KMPeXjOtgs8jMaELe/QbidX6Z/YujTH1rgamzHYwMPb831vZlHy
 lI8/80TYzHB4Uli8p4gMCFbMMfsR+2rugik4VczCmC0ViNeXDVQEt3/Q+J2Fvoaw4bI4
 wtyg==
X-Gm-Message-State: AOAM530Uant6tlO3lXrz2H++1q9iBxT+2xrBXKad9QeaN7X9gAgWsHK/
 tV+LtRjRwF+/bjByjJriDfVL0dlJldPjch65SI3eHFdRhGH2Rg==
X-Google-Smtp-Source: ABdhPJxoinyjrBPdZLGocyj3cHWt6ZZA2q2WUSJ+iCD07UaiX2qfBLJEkM4SOtDkRHyx6xR1oMJY4wsWp1jghmsCGYE=
X-Received: by 2002:a05:6e02:1a0f:: with SMTP id
 s15mr13377294ild.244.1613397870619; 
 Mon, 15 Feb 2021 06:04:30 -0800 (PST)
MIME-Version: 1.0
From: Gautam Dawar <gdawar.xilinx@gmail.com>
Date: Mon, 15 Feb 2021 19:34:19 +0530
Message-ID: <CAJ-rMYqm57NVNEbjZ3AzUC8uLOheF7zwXGXuDuQRMX7WEkrhQg@mail.gmail.com>
Subject: [PATCH] vhost vdpa: setup vq irq only when set status includes
 VIRTIO_CONFIG_S_DRIVER_OK
To: virtualization@lists.linux-foundation.org, jasowang@redhat.com, 
 mst@redhat.com, gdawar@xilinx.com, hanand@xilinx.com, martinh@xilinx.com
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
Content-Type: multipart/mixed; boundary="===============0348951310827747000=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============0348951310827747000==
Content-Type: multipart/alternative; boundary="000000000000f5afa305bb6076ba"

--000000000000f5afa305bb6076ba
Content-Type: text/plain; charset="UTF-8"

When qemu with vhost-vdpa netdevice is run for the first time, it works
well.
But after the VM is powered off, the next qemu run causes kernel panic due
to a
NULL pointer dereference in irq_bypass_register_producer().

When the VM is powered off, vhost_dev_stop() is invoked which in turn calls
vhost_vdpa_reset_device() causing the irq_bypass producers to be
unregistered.

On the next run, when qemu opens the vhost device, the vhost_vdpa_open()
file
operation calls vhost_dev_init(). Here, call_ctx->producer memory is cleared
in vhost_vring_call_reset().

Further, when the virtqueues are initialized by vhost_virtqueue_init(),
vhost_vdpa_setup_vq_irq() again registers the irq_bypass producer for each
virtqueue. As the node member of struct irq_bypass_producer is also
initialized
to zero, traversal on the producers list causes crash due to NULL pointer
dereference.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211711
Signed-off-by: Gautam Dawar <gdawar@xilinx.com>

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 62a9bb0efc55..fdad94e2fbf9 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -409,7 +409,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa
*v, unsigned int cmd,
                        cb.private = NULL;
                }
                ops->set_vq_cb(vdpa, idx, &cb);
-               vhost_vdpa_setup_vq_irq(v, idx);
                break;

        case VHOST_SET_VRING_NUM:

--000000000000f5afa305bb6076ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">When qemu with vhost-vdpa netdevice is run for the first t=
ime, it works well.<br>But after the VM is powered off, the next qemu run c=
auses kernel panic due to a<br>NULL pointer dereference in irq_bypass_regis=
ter_producer().<br><br>When the VM is powered off, vhost_dev_stop() is invo=
ked which in turn calls<br>vhost_vdpa_reset_device() causing the irq_bypass=
 producers to be unregistered.<br><br>On the next run, when qemu opens the =
vhost device, the vhost_vdpa_open() file<br>operation calls vhost_dev_init(=
). Here, call_ctx-&gt;producer memory is cleared<br>in vhost_vring_call_res=
et().<br><br>Further, when the virtqueues are initialized by vhost_virtqueu=
e_init(),<br>vhost_vdpa_setup_vq_irq() again registers the irq_bypass produ=
cer for each<br>virtqueue. As the node member of struct irq_bypass_producer=
 is also initialized<br>to zero, traversal on the producers list causes cra=
sh due to NULL pointer<br>dereference.<br><br>Bugzilla: <a href=3D"https://=
bugzilla.kernel.org/show_bug.cgi?id=3D211711">https://bugzilla.kernel.org/s=
how_bug.cgi?id=3D211711</a><div>Signed-off-by: Gautam Dawar &lt;<a href=3D"=
mailto:gdawar@xilinx.com">gdawar@xilinx.com</a>&gt;<br><div><br></div><div>=
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c<br>index 62a9bb0ef=
c55..fdad94e2fbf9 100644<br>--- a/drivers/vhost/vdpa.c<br>+++ b/drivers/vho=
st/vdpa.c<br>@@ -409,7 +409,6 @@ static long vhost_vdpa_vring_ioctl(struct =
vhost_vdpa *v, unsigned int cmd,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb.private =3D NULL;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ops-&gt;set_vq_cb(vdpa, idx, &amp;cb=
);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_vdpa_setup_v=
q_irq(v, idx);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b=
reak;<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 case VHOST_SET_VRING_NUM:<br></div=
></div></div>

--000000000000f5afa305bb6076ba--

--===============0348951310827747000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0348951310827747000==--
