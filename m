Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737F20F093
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743996017; cv=none; b=WaTk3iA/PEnv6eiW+zgSjqMcFVgBl88wsC0h7HgbEsIdrT6myAfOFx3ICSyg+i6lg+0Y5s+KsCKRT/WOVA2l2OHEcAKbv25TMK5Ms4R/yNaR6LonYw2ajugV9YWsZHyzhv7e7pDX4MhcdfHKD0IhgMUn0ArJ13+RL83bdNoesa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743996017; c=relaxed/simple;
	bh=u0c6Avm1gLozqeIt/1O0xn96n0POL5Eca/kJDjcZzkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDM5ruWZmcEZutDtr6rJMJBfAO76f7bZ54ZXHy4RndvK4drg/TGKuWcqdlH1gaaiRdK8wxtPYm1jLwMqDg44HiQbWokH/ELzOroWrvQsSCBnR25zUGKtmvMSqepTsFvqKAY3rKqfkyzn8tribu8AoWceiYo4tfzJTTw9Kvtevl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FlejdInf; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlejdInf"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B98CF409EA
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 03:20:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixMNtPa64X5e for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Apr 2025 03:20:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E95A94052A
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E95A94052A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlejdInf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E95A94052A
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 03:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743996013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKZcnqeoJM6ayZoyXnhIBesFK061IAtxlU5uJ2H12OE=;
	b=FlejdInfkb8z3CW8nRkpOXcnxACsEHgWAy25yiKj8zV9jbbbZSj01GhOIsqpfUmviofnDI
	v+SPWfqydaaWteAgur6rxjdVPMPb5ay50dReopKtnn0Xpdht4Earjhr4xsoO3AA8QqgS8s
	PZSg1PyFqKB8LQ2/IZK8ak13CF6y43w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-JfQMn3oqMYqEpR03uEAn2A-1; Sun, 06 Apr 2025 23:20:12 -0400
X-MC-Unique: JfQMn3oqMYqEpR03uEAn2A-1
X-Mimecast-MFC-AGG-ID: JfQMn3oqMYqEpR03uEAn2A_1743996011
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac28f255a36so310750266b.3
        for <virtualization@lists.linux-foundation.org>; Sun, 06 Apr 2025 20:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743996011; x=1744600811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKZcnqeoJM6ayZoyXnhIBesFK061IAtxlU5uJ2H12OE=;
        b=by2VxvfKzmnGTHPM7CF8XBcDxR9QrJbGVRB8y6Kj2H4SFlXgp5PggOUsFbQw7eNplf
         3v2siYCe6qyM2mK0NAxNQbTm708DzSQ7hLhKwM3nbG7FUDn19E9ioHqkDHw4NrGhFcls
         sdL0OKBE2Avz7oYldNBKwaS/7nuLi/+I4bKYs4HCNbG2n0TB7SOx5nOTpliGkC4hNzJY
         GBktXiAnt90+YTbT1RedBuxIJk2XWqGxlQ3W+/mRHpjjsnccpHWEbSyzYXZsowSWERky
         61q/sZiTKxWIkvxv+qGhJ4AgYpYuIhiAdhoKdvMVpi2w+HDvkPXsTwizJrVD+uXIBQK1
         RDTw==
X-Forwarded-Encrypted: i=1; AJvYcCUC461zwBZMJwXBib50o2sTpmtURqtXyGssVtkkG3BebWiAitAfwW0ofjyITCJ7e61pc7gwwG1P1BVQPJURlg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwyFYwUUZJgwCHJtlWYtglkKGZURPF7vtPG8POkcyCnfWB0VFqd
	VzvdKLUljX+TyesK9vmy/GNB1ENJ20ssAJCSmL1zbM4ji085EvyscE9cVfIh7f8x/+oKpOBwRYv
	HKTpc62bwe7/0/lIZOOs9kiqzuNYYGrm2dIueOm6eIqoeJ+EFccllaBnZpFufV22YIdy15qEaXZ
	xqgL2V9MX6tccRxcexT6+ZjuioA528n9BPGTENPxyVN0uG7ZNLzeJWEA==
X-Gm-Gg: ASbGnctgpQDAmPSHww95npzAXNWdhVHIaEV3tcPz7xyTW1gGMDViP0fuA7PG5yIHiwl
	Ua+KK6YUdQN76acxm89Idt/d9LLa/JrWmyrvbgKvdFFmJOmoDagmOjVatgqBDJCahjoBHUHX/ng
	==
X-Received: by 2002:a17:907:2cc5:b0:ac7:391a:e2d5 with SMTP id a640c23a62f3a-ac7d6e9fedfmr940790966b.60.1743996010764;
        Sun, 06 Apr 2025 20:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyaASIls+cOpryke10gRp95gULeuPF1FuQluD5pPvHsnbXkXlhIa7Ty4Cap0zu4wlhYBi4L2p7sScEvmBHme0=
X-Received: by 2002:a17:907:2cc5:b0:ac7:391a:e2d5 with SMTP id
 a640c23a62f3a-ac7d6e9fedfmr940789366b.60.1743996010431; Sun, 06 Apr 2025
 20:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-7-lulu@redhat.com>
 <pgcopzs6q6kqwlmndtbt2bdpbj3xvosjjxb7vikte3gnt643xh@5qhv5myd2cpc>
In-Reply-To: <pgcopzs6q6kqwlmndtbt2bdpbj3xvosjjxb7vikte3gnt643xh@5qhv5myd2cpc>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 7 Apr 2025 11:19:33 +0800
X-Gm-Features: ATxdqUEqOkuVmABA1s36h59JIHqt9NVOz5EMMRXCcAsp0MZnvUrNJ_xlQuJAb58
Message-ID: <CACLfguV9F7wR=NE1GbjMuvFL2drZ8FLSR-UPPfavWvsuoWJPBw@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] vhost: uapi to control task mode (owner vs kthread)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 46rywf_gQKVWWlgGFn_xaL-g1-boEaxON-qWRvqYaLQ_1743996011
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:57=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Fri, Mar 28, 2025 at 06:02:50PM +0800, Cindy Lu wrote:
> >Add a new UAPI to configure the vhost device to use the kthread mode
>
> nit: missing . at the end
>
> >The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
> >to choose between owner and kthread mode if necessary
>
> Ditto
>
> >This setting must be applied before VHOST_SET_OWNER, as the worker
> >will be created in the VHOST_SET_OWNER function
>
> Ditto.
>
Sure, will fix this

> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> > include/uapi/linux/vhost.h | 16 ++++++++++++++++
> > 2 files changed, 36 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index be97028a8baf..ff930c2e5b78 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, =
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
> >@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> >-
>
> As I mentioned, I'll add the Kconfig in this patch to avoid bisection
> issues.
>
> The rest LGTM.
>
sure, will fix this
Thanks
cindy
> Thanks,
> Stefano
>
> >+      if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >+              u8 inherit_owner;
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
> >+              if (inherit_owner > 1) {
> >+                      r =3D -EINVAL;
> >+                      goto done;
> >+              }
> >+              d->inherit_owner =3D (bool)inherit_owner;
> >+              r =3D 0;
> >+              goto done;
> >+      }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> >diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >index b95dd84eef2d..1ae0917bfeca 100644
> >--- a/include/uapi/linux/vhost.h
> >+++ b/include/uapi/linux/vhost.h
> >@@ -235,4 +235,20 @@
> >  */
> > #define VHOST_VDPA_GET_VRING_SIZE     _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> >+
> >+/**
> >+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost dev=
ice,
> >+ * This ioctl must called before VHOST_SET_OWNER.
> >+ *
> >+ * @param inherit_owner: An 8-bit value that determines the vhost threa=
d mode
> >+ *
> >+ * When inherit_owner is set to 1(default value):
> >+ *   - Vhost will create tasks similar to processes forked from the own=
er,
> >+ *     inheriting all of the owner's attributes.
> >+ *
> >+ * When inherit_owner is set to 0:
> >+ *   - Vhost will create tasks as kernel thread.
> >+ */
> >+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> >+
> > #endif
> >--
> >2.45.0
> >
>

