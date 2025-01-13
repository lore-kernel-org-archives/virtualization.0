Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903154648
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736735818; cv=none; b=R+xPVjtcwSoOpBDEz20fet0pGZDnpUmiSUj3iUJKU7HDxykJQYqCdvxDKimq26WMnY7p387JeSV8oYQ0AcAa/M5HJICGDyuxGA76rf6wDPLk4IYAmM7Udml8fOrpKqSgLXZVDTj0nifqtJZVF438PNVWzis4uMYXfUoK/G1cj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736735818; c=relaxed/simple;
	bh=33atN2c5q5MV+wEeaURs0G2Pk1+6beFwxSOU9ZHJ4zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsiLE4UnhojO3Um9owcHGb6uOJtHyPk0DQrol0t5l0i7dqoVyb7JSJIE2sOpxujIrjDp+h3GQAm6YBEsv69fG8O2CGd6cLdsag5tO1EVJWQQQBaHW0F5/q6F1yySqHttOfmX6Au4TU8jpgII4YGJP/FtiUjRnMqkA3vURwaPyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avwzXWE8; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avwzXWE8"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B1B0812BB
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nio-zM0o27o8 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jan 2025 02:36:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7F6A7812B9
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F6A7812B9
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=avwzXWE8
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F6A7812B9
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 02:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736735813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjbGZVtKCla7smHmd/NdDBnCwHIsn6ZbQJ8PT6NLfpE=;
	b=avwzXWE808V1GDdWOFBizTtqII0M6iBe3lfkWM9GcXKXDu1dBoh1smszeC5FUkwhOOk5Ar
	u/x/dHqoL06otZJf6NgUTXMObMQ3R8TVyeOSaeiGHRNF6EH1qKI1Ob0l0PQzQXWsKpGjgj
	ay4+5mAxRkgFhDb2NtRxUeyRl17ugpM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-A6xSv8cXMqevq-Kgj22NmA-1; Sun, 12 Jan 2025 21:36:51 -0500
X-MC-Unique: A6xSv8cXMqevq-Kgj22NmA-1
X-Mimecast-MFC-AGG-ID: A6xSv8cXMqevq-Kgj22NmA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa622312962so364587966b.2
        for <virtualization@lists.linux-foundation.org>; Sun, 12 Jan 2025 18:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736735810; x=1737340610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjbGZVtKCla7smHmd/NdDBnCwHIsn6ZbQJ8PT6NLfpE=;
        b=EHVNhaRJpAuAEOZ20aN0KblFy6nKHTtJ+SRNErTIA/Gm3+BM52O+c7zCOcEBgIMk7e
         V3c+Edzq1SBw+czq+l0TqR3h7pgLR2F/RuXOjCechR0VJhG5gdY+AuZbrOuewfBbq5xJ
         +7sKAKsAS7jn3k/svBE+zQxUs2JPL8fafvBd6aHCLKMn3cbOoe3iAGhdpA8x+14YlqvX
         BfiT0SuTchXKbDVML+Cr6hDg0a8mC6jrTrrkCeO9XchanuMW2V1S0Ynwr93jQ7V/a+z/
         1C8IWoOowR7XkINXTd8/1rzJDFtJOWvpLTcWH0zGJW3zGTcIveCZgQdef0AEY4UdPZsU
         TNcg==
X-Forwarded-Encrypted: i=1; AJvYcCUkSYIXqcmC0VTwS6XKDXPvuyiLva9pw8lkKiBy+CZqBHUCQDikTdKMp4OY1N32QJnGyXFkxAREnorDMJzpxQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw6/2tn0jEq+SuZMBNBeWcV6Zyq22FpVtflBun2xRfi2Nesnqmx
	R7wVRl5qftwWRXPYKNQ5KZdh5tgmQdpYjaFOXpA8bRqagjpVzPJTJphaOd8uwNlxL2ojqJGVAxU
	wtQMq07z5gGR521h02jEa+++TUopgg+/fTr09AJHsH+BzqJpEeAhpH7SEWxb19y462gEWgH/K/h
	jfbgDzc/VBJbHyoW5Dk4eQJDiAoNw2ld+V8D7y0iDa27zMydjsT78Uqg==
X-Gm-Gg: ASbGncskO781NBKuGw1JGuhYCCGH5khN3OaG/qCyRL1Rx6ds1sIgfTrIrammYKoryDp
	eiLH3gIVYI7ETgN/M9deYj5NOcBPxYZd4KWfYIKU=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id a640c23a62f3a-ab2ab5f6f1cmr1637968166b.32.1736735810505;
        Sun, 12 Jan 2025 18:36:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaKJ+N3gTUuKbOesPp5xfJ0dnGbxjrRb2BcOPB+C8M6hWol16j29uHgmFXOoNXM/nAg72lLh9aCgqO/JMIO6Q=
X-Received: by 2002:a17:907:7288:b0:aa6:73ae:b3b3 with SMTP id
 a640c23a62f3a-ab2ab5f6f1cmr1637966866b.32.1736735810150; Sun, 12 Jan 2025
 18:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250108071107-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 13 Jan 2025 10:36:12 +0800
X-Gm-Features: AbW1kvZzKRu6zgb1uk7BzXKIMdzPKzlbctv6VkNibULKkSY0RJRzGOOzIN9zHaQ
Message-ID: <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TjLZLU63NQRZYVr-PR0R9dcIQFTpV6kqHP2KTFOc0q8_1736735811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 8:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
> > Add a new UAPI to enable setting the vhost device to task mode.
> > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > to configure the mode if necessary.
> > This setting must be applied before VHOST_SET_OWNER, as the worker
> > will be created in the VHOST_SET_OWNER function
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Good.  I would like to see an option to allow/block this ioctl,
> to prevent exceeding nproc limits. A Kconfig option is probably
> sufficient.  "allow legacy threading mode" and default to yes?
>
sure I will add this in the new version, the legacy thread mode here
is  kthread mode
I will change these commit comments and make it more clear
Thanks
Cindy

>
> > ---
> >  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> >  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> >  2 files changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 3e9cb99da1b5..12c3bf3d1ed4 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >  {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> > -     long r;
> > +     long r =3D 0;
> >       int i, fd;
> > +     u8 inherit_owner;
> >
> >       /* If you are not the owner, you can become one */
> >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> > +     if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> > +             /*inherit_owner can only be modified before owner is set*=
/
> > +             if (vhost_dev_has_owner(d)) {
> > +                     r =3D -EBUSY;
> > +                     goto done;
> > +             }
> > +             if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > +                     r =3D -EFAULT;
> > +                     goto done;
> > +             }
> > +             /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */
> > +             if (inherit_owner > 1) {
> > +                     r =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +
> > +             d->inherit_owner =3D (bool)inherit_owner;
> >
> > +             goto done;
> > +     }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index b95dd84eef2d..d7564d62b76d 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,22 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the v=
host device
> > + *
> > + * @param inherit_owner: An 8-bit value that determines the vhost thre=
ad mode
> > + *
> > + * When inherit_owner is set to 1:
> > + *   - The VHOST worker threads inherit its values/checks from
> > + *     the thread that owns the VHOST device, The vhost threads will
> > + *     be counted in the nproc rlimits.
> > + *
> > + * When inherit_owner is set to 0:
> > + *   - The VHOST worker threads will use the traditional kernel thread=
 (kthread)
> > + *     implementation, which may be preferred by older userspace appli=
cations that
> > + *     do not utilize the newer vhost_task concept.
> > + */
> > +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +
> >  #endif
> > --
> > 2.45.0
>

