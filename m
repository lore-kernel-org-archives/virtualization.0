Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF226773B
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550454; cv=none; b=VHhRdUrUQkrx/n0DDioXPg7m86JXfcdjWqwGyvJpzjzUL960m9DzKXcV9OxgOBKufWEaQphXND4QrhGgLnpZqKugPWJuNlGuBUXOVA0vpeDyT4Db8nC/1JcJNu9VrSBOthue66fXILrImtwEtP3sjZjiBX/Du3vlLgOjajGMhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550454; c=relaxed/simple;
	bh=occPEZDucJVb8lBD1jQ1GAuOO0994gL1zBT5kTdiRNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6u322mNY6Kxko7bE1Ej7RYiarkPocU3rWDnXomWwrrAWy2iERCXIzZ0ej5QysiVutlU6UUGv3Kzl+ySStuw48fyWXcz1l8Pt/r7mqL6kt4FNiaHCC1RybU6VBnoZPCqfJlUntrbjbbZOebsRRhKIurqvlL3E8AsChM4p61fE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2pxzqDY; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2pxzqDY"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 304158214E
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 06:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FduuVx1aTpQr for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Feb 2025 06:14:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 543018214C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 543018214C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i2pxzqDY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 543018214C
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 06:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740550450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrYuHXAnjLqXKtPJWbNFQh22GoqGfQZfdjz3jbFGr6E=;
	b=i2pxzqDYrR9kIXEEXzGoCs1bAJMviQqkFu/tpIwO1ywvN5R75VWMPu9gCUnZnM9dRwKr6j
	zabjaPx9ewtBIjZnnQUI5/y5JQDPmj6ry85LZrrkWAmaojcfEqkMLT2F/oBKlOrPuvmagA
	bzCLwQihuxMfDj2wcImQyncH9qdphQo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-SpMukhJxPm6_7V-ncU0apg-1; Wed, 26 Feb 2025 01:14:07 -0500
X-MC-Unique: SpMukhJxPm6_7V-ncU0apg-1
X-Mimecast-MFC-AGG-ID: SpMukhJxPm6_7V-ncU0apg_1740550446
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab77e03f2c0so667782466b.3
        for <virtualization@lists.linux-foundation.org>; Tue, 25 Feb 2025 22:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550446; x=1741155246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrYuHXAnjLqXKtPJWbNFQh22GoqGfQZfdjz3jbFGr6E=;
        b=aBTiEt4WHWi3G8am31G3ZJ3idCvu9eI1NV7lC3T+3OynB8go5eYs2rNBXMRxZ564v0
         TilDXbQeCuOpTeefGB56C+AGH9GqVqe/kf4kdaHYPfd8X9lEIvmulFoCK5wOrSOCX4Vy
         sF1kzMsnL8kJGPY4wW53L+hhAjmrMM9817lj74W4lXPJ9Ig55ipEJyvicpyaywRm+s8A
         s2m7qeetbv7BWl945DvPBe19Ty0xINS3ovtKKdQEhroN3Qx71SMTHmOBGj/Cum8+24qw
         t2wgvmkvV1hpqAP2kQ8SjMJSHQiDPhrJajLaMj9z85U3KYbLRaJHOa5OdRRaKouseMTv
         Ut/A==
X-Forwarded-Encrypted: i=1; AJvYcCU9myRPGKohOXUmmy8sSa+5ctw8vWiff/nnzWiUpqk8SdAnU6gpmi0bW3iqfrP46naVPvDBZG0iK4vIWQ5g0w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz8ufpMJiijngHoWWnEOM0JWojnDAlDSMTLNF20VAEy6RTInv6Z
	Zec6s8td3/Qjk2Rpq3HNFaAu7VDbyTCb0HljgmqGmIndl8SOhMstxqeM0JA0JDx1gXbkneJym1B
	Z6TMXc2nUtWMhtNZjTkdLPvp/8+eq+fnwC5+Ph3pcZzMFRU4MKrwiwvTU5aBXxv48jLf+p7wavt
	b+bGGJwcqn/YtyUOs/IlV9okXmPS2QsWZi/CjoCfzq0KYc4morRzuFgg==
X-Gm-Gg: ASbGncsOML9pFMtnHn3WACSjAN71ZMiVdTg60gGS6aJxogKcg+3AcUIDFnz9CAjLyhY
	BJNOdqRT96HKQgMeKNSv3woiNqORw2fJ2bkRPimNekX9mMhbkOLx7podRaWlctzl+egbHMYV+gA
	==
X-Received: by 2002:a17:907:6d05:b0:aba:598b:dbde with SMTP id a640c23a62f3a-abc0d97e504mr2119383266b.8.1740550446153;
        Tue, 25 Feb 2025 22:14:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEPM7VfuOk/Au93iZs65YIRLhsjQkDmCkNqmGnjdzf1TQUXJWU9PFxQBBs189DJw6J4yaO/kqbah0ezftoIDw=
X-Received: by 2002:a17:907:6d05:b0:aba:598b:dbde with SMTP id
 a640c23a62f3a-abc0d97e504mr2119381266b.8.1740550445828; Tue, 25 Feb 2025
 22:14:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-6-lulu@redhat.com>
 <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
In-Reply-To: <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 14:13:27 +0800
X-Gm-Features: AQ5f1JoNoWEefztuGY9ylFIkLRXZ0YQ4UToF_h0n3mIP4S6r1pE-NAlUqjniIn0
Message-ID: <CACLfguU8-F=i3N6cyouBxwneM1Fr0oNs9ac3+c5xoHr_zcZW6A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wemGbMIotgSY2J6EjsI0GzqV79EFz9Tn8iblogKVys0_1740550446
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:31=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> >Add a new UAPI to enable setting the vhost device to task mode.
> >The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> >to configure the mode if necessary.
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> > include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > 2 files changed, 40 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index d8c0ea118bb1..45d8f5c5bca9 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, =
struct vhost_iotlb *umem)
> >       int i;
> >
> >       vhost_dev_cleanup(dev);
> >-
> >+      dev->inherit_owner =3D true;
> >       dev->umem =3D umem;
> >       /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
> >        * VQs aren't running.
> >@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *argp)
> > {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> >-      long r;
> >+      long r =3D 0;
> >       int i, fd;
> >+      u8 inherit_owner;
> >
> >       /* If you are not the owner, you can become one */
> >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >+      if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >+              /*inherit_owner can only be modified before owner is set*=
/
> >+              if (vhost_dev_has_owner(d)) {
> >+                      r =3D -EBUSY;
> >+                      goto done;
> >+              }
> >+              if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> >+                      r =3D -EFAULT;
> >+                      goto done;
> >+              }
> >+              /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */
> >+              if (inherit_owner > 1) {
> >+                      r =3D -EINVAL;
> >+                      goto done;
> >+              }
> >+
> >+              d->inherit_owner =3D (bool)inherit_owner;
> >
> >+              goto done;
> >+      }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >index b95dd84eef2d..8f558b433536 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,22 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> >+
> >+/**
> >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost dev=
ice
> >+ *
> >+ * @param inherit_owner: An 8-bit value that determines the vhost threa=
d mode
> >+ *
> >+ * When inherit_owner is set to 1:
> >+ *   - The VHOST worker threads inherit its values/checks from
> >+ *     the thread that owns the VHOST device, The vhost threads will
> >+ *     be counted in the nproc rlimits.
> >+ *
> >+ * When inherit_owner is set to 0:
> >+ *   - The VHOST worker threads will use the traditional kernel thread =
(kthread)
> >+ *     implementation, which may be preferred by older userspace applic=
ations that
> >+ *     do not utilize the newer vhost_task concept.
> >+ */
> >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>
> I don't think we really care of the size of the parameter, so can we
> just use `bool` or `unsigned int` or `int` for this IOCTL?
>
> As we did for other IOCTLs where we had to enable/disable something (e.g
> VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).
>
hi Stefano
I initially used it as a boolean, but during the code review, the
maintainers considered it was unsuitable for the bool use as the
interface in ioctl (I think in version 3 ?). So I changed it to u8,
then will check if this is 1/0 in ioctl and the u8 should be
sufficient for us to use
Thanks
cindy
> Thanks,
> Stefano
>

