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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F8BC433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:01:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FB464E20
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FB464E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C25F83131;
	Tue, 23 Feb 2021 10:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zyCQ351O5jwI; Tue, 23 Feb 2021 10:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 852E6830D7;
	Tue, 23 Feb 2021 10:01:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62B0BC000B;
	Tue, 23 Feb 2021 10:01:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A789C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39768605AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZHAG63Ez7IZU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:00:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD0896059C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:00:57 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id o3so7345725oic.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=g7i+mmJYKCxnN/IuEyguQaGDLSpuGsj6h6hhVKvv3FY=;
 b=YkJHbuC53MeJPt6z60G7TVnNIdELlWhY3n6uzFOxQTlDgdEQQOQfFlLmGxjUiAnrdc
 zficPVJYtQva4zfxarhLqncA7eD4UgdMbGRCxjZ571EJsu2NcdhEPMMB7gQ7LcfI0RHn
 /MvU2ZN5SccSvYWHkHrMnkEh+GUwOGTnpINAsDdBmxw01PiKcUlZZXAZP5xSj42Ha9vA
 IACL95gKyfmjp7L3M2MRYYsaSG6AUcck4RnRDzPHjULRWl26xByZYyEIe4Qb+vNICkqT
 GmYbYWrt9kUvF+LXmhWOEx7q1dfpApGrEiQERbdH3Sm6jXgv/PGhw9IpD06EQ1Toyc61
 T04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=g7i+mmJYKCxnN/IuEyguQaGDLSpuGsj6h6hhVKvv3FY=;
 b=tE7XmGytTA0Bdl/5ZPHV4ZDkShf37bWr2QVvN9pLfIgBQanb6dBzituDEcXmGV2xn2
 Gmlf1jPwo+L+jPKWoUSuP/szSs7Qv8K5CBwhGViyHgpoLQ/ZrmM1pmRZoJDb8oyHWGok
 B7BhUc7iFuvXeJToiJQdBSJlk47+TYwjqdRdUrAN2OCI55ura41TiBGD1fX/Ex7RLHDX
 JDkx4YAmrFNrtAsx4uMruawyrChegdfZXyKIBMW62midBMvgZO7IjVHW7UGcGdGUMUWi
 rY46VvP/lqr7F7ra6FNSBeab9SCRUo6fL83Q+F6v678Ul7NMK1znmzoLwMXVeZry4XXw
 S4ug==
X-Gm-Message-State: AOAM533zT3E7xHqPV1bq2iiGLumL+HAkLYpfoCZUnSoM17pS8xu+p7uN
 Mwa8YTmHuzTYG2x76sYaYDof0xTsppTTY//Cw3/DJZEafUXdbQ==
X-Google-Smtp-Source: ABdhPJwUdTcaDy/tVNKqW4EmnJcbyO0xSyJYs/F/Jqevv++xuSU+u6CQ2VSPSPBZ2CNMH9f/87/WOewBD/H2Fn68HaU=
X-Received: by 2002:aca:aa96:: with SMTP id t144mr8722494oie.131.1614074456670; 
 Tue, 23 Feb 2021 02:00:56 -0800 (PST)
MIME-Version: 1.0
From: Gautam Dawar <gdawar.xilinx@gmail.com>
Date: Tue, 23 Feb 2021 15:30:45 +0530
Message-ID: <CAJ-rMYpFFD0vwERMbj_tMLmeFqECr0Q+s4ct_sO0AAt3rgWG0Q@mail.gmail.com>
Subject: [PATCH v2] vhost vdpa: fix the missing
 irq_bypass_unregister_producer() invocation
To: virtualization@lists.linux-foundation.org, 
 Jason Wang <jasowang@redhat.com>, mst@redhat.com, gdawar@xilinx.com,
 martinh@xilinx.com, hanand@xilinx.com
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
Content-Type: multipart/mixed; boundary="===============2996052909606263931=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============2996052909606263931==
Content-Type: multipart/alternative; boundary="000000000000a1862905bbfdfe8a"

--000000000000a1862905bbfdfe8a
Content-Type: text/plain; charset="UTF-8"

When qemu with vhost-vdpa netdevice is run for the first time, it works
well.
But after the VM is powered off, the next qemu run causes kernel panic due
to a
NULL pointer dereference in irq_bypass_register_producer().

When the VM is powered off, vhost_vdpa_clean_irq() misses on calling
irq_bypass_unregister_producer() for irq 0 because of the existing check.

This leaves stale producer nodes, which are reset in
vhost_vring_call_reset()
when vhost_dev_init() is invoked during the second qemu run.

As the node member of struct irq_bypass_producer is also initialized
to zero, traversal on the producers list causes crash due to NULL pointer
dereference.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211711
Signed-off-by: Gautam Dawar <gdawar@xilinx.com>

-----
changelog:
v1->v2:
 - Addressed Jason's comment to remove the irq check and use
   vhost_vdpa_unsetup_vq_irq() to avoid local variable vq
-----


diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 62a9bb0efc55..e00573b87aba 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -844,14 +844,10 @@ static int vhost_vdpa_open(struct inode *inode,
struct file *filep)

 static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
 {
-       struct vhost_virtqueue *vq;
        int i;

-       for (i = 0; i < v->nvqs; i++) {
-               vq = &v->vqs[i];
-               if (vq->call_ctx.producer.irq)
-
irq_bypass_unregister_producer(&vq->call_ctx.producer);
-       }
+       for (i = 0; i < v->nvqs; i++)
+               vhost_vdpa_unsetup_vq_irq(v, i);
 }

 static int vhost_vdpa_release(struct inode *inode, struct file *filep)

--000000000000a1862905bbfdfe8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">When qemu with vhost-vdpa netdevice is run for the first t=
ime, it works well.<br>But after the VM is powered off, the next qemu run c=
auses kernel panic due to a<br>NULL pointer dereference in irq_bypass_regis=
ter_producer().<br><br>When the VM is powered off, vhost_vdpa_clean_irq() m=
isses on calling<br>irq_bypass_unregister_producer() for irq 0 because of t=
he existing check.<br><div><br></div><div>This leaves stale producer nodes,=
 which are reset in vhost_vring_call_reset()<br>when vhost_dev_init() is in=
voked during the second qemu run.<br><br>As the node member of struct irq_b=
ypass_producer is also initialized<br>to zero, traversal on the producers l=
ist causes crash due to NULL pointer<br>dereference.<br><br>Bugzilla: <a hr=
ef=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D211711">https://bugzill=
a.kernel.org/show_bug.cgi?id=3D211711</a><br>Signed-off-by: Gautam Dawar &l=
t;<a href=3D"mailto:gdawar@xilinx.com">gdawar@xilinx.com</a>&gt;<br><br>---=
--<br>changelog:<br>v1-&gt;v2:<br>=C2=A0- Addressed Jason&#39;s comment to =
remove the irq check and use<br>=C2=A0 =C2=A0vhost_vdpa_unsetup_vq_irq() to=
 avoid local variable vq<br>-----<br><br><br>diff --git a/drivers/vhost/vdp=
a.c b/drivers/vhost/vdpa.c<br>index 62a9bb0efc55..e00573b87aba 100644<br>--=
- a/drivers/vhost/vdpa.c<br>+++ b/drivers/vhost/vdpa.c<br>@@ -844,14 +844,1=
0 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)<br=
><br>=C2=A0static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)<br>=C2=A0=
{<br>- =C2=A0 =C2=A0 =C2=A0 struct vhost_virtqueue *vq;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int i;<br><br>- =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; v-&=
gt;nvqs; i++) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =
=3D &amp;v-&gt;vqs[i];<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (vq-&gt;call_ctx.producer.irq)<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_bypass_unregister_produce=
r(&amp;vq-&gt;call_ctx.producer);<br>- =C2=A0 =C2=A0 =C2=A0 }<br>+ =C2=A0 =
=C2=A0 =C2=A0 for (i =3D 0; i &lt; v-&gt;nvqs; i++)<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_vdpa_unsetup_vq_irq(v, i);<br>=C2=A0}=
</div><div><br></div><div>=C2=A0static int vhost_vdpa_release(struct inode =
*inode, struct file *filep)<br></div></div>

--000000000000a1862905bbfdfe8a--

--===============2996052909606263931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2996052909606263931==--
