Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A01C199229
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148045; cv=none; b=ZKgmfE9jAl6v1gH/sqw9tD3MHPdTY+kRoj5ZpUNDmFva435FJvIP+NmTLNqnKEx5xEUnFY6xeKhdBUV3+KxdhIS1Vf/AS+HNqhoMDQsHfS/4l0d61sr5xKW79ZCPPZ9KkasrupnBY1j4jszpSOlbPdM4jW3qIh7IJv+atQyBBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148045; c=relaxed/simple;
	bh=pFA1yUiGPlsgyeSVcgazShhN8fRF06GsnpgIB1d90gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLGa03vImUBANthNyMozPqmERuATXyKN0HPU7lI/IWTQE5Y/KCthseTbLpSB9hd5aO/Vo2LGKtT9HlSYczkso6L+29G7gnsq2RNu+dbudhexQu0C3Hh+8OqxVHeTqV7FhBmW6mx9X2299W32+8SPPn/LIOUK3I9yNHlouY/C6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QprvXix6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QprvXix6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB284606F2
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 06:54:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNUgdvPIAWLu for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Oct 2024 06:54:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E2162606E5
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2162606E5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QprvXix6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E2162606E5
	for <virtualization@lists.linux-foundation.org>; Thu, 17 Oct 2024 06:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729148041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJQzvz6uHtGrtsGDp9Qm2Acz8a7WWHI/1Ep6JEpCX4c=;
	b=QprvXix6rqkRgiiqJtBIxdSJrycUr1FtYzzueEMma83acWIbMRVR8Ivyj94tORPP1rYRVh
	qiNiJiPtqa2Jh98FwNsGc32859+5xuEFGkpRzVC5SawMvgMGmVsnGxPXO9dVa4fU36n+GZ
	qWyDoeB5TS3k6isVSYJ71SO9HjPjiWY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-n1E8xn-uPmaQEOGo0aAnbQ-1; Thu, 17 Oct 2024 02:53:58 -0400
X-MC-Unique: n1E8xn-uPmaQEOGo0aAnbQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7ea8baba4d5so870989a12.2
        for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 23:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148037; x=1729752837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJQzvz6uHtGrtsGDp9Qm2Acz8a7WWHI/1Ep6JEpCX4c=;
        b=KeR9KGz74ZhKErOY0c58Ay+bT45kRMFC7LKEw2IIboabtp/fI5+72ELykAqEK8E1so
         Rc7P9oUR4m1HDQynZbIkFuvIO9hjJYt/SCaJHIFSfOmjuQAa7ro344HkS5JbsTzL3c8b
         3F4YwL5UEmG82b0Yf7fPVPHJgKOoNuGkoFwaJd0vUt6w9a+wUrnlBd1qT7NOhXlpzWFy
         zweafB8gN3dkA8lsz0TR6yz2hQSKePWWxeWmifcibCJwu1GWWLLGuHlNN/JzJRhFiHz0
         OQpWcNUIFdKslkxrFSFw7zayeJAMMmQ+g/KH2uVrV3FgLbnXtMblRJjy2DtHMx+oodhQ
         gghg==
X-Forwarded-Encrypted: i=1; AJvYcCUn19+PHvtRQiW0G4qgqS8oraripe9LFMq0OJbT6FOxP2uqRXn7nwqwtBCew+MRiRdiEtjw+RoMKwaNNJDZgg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yyq6mBYpmBESr20nOI6ubfr0GR3Sj6huWDQMYWsVHItSi+5zXZY
	TAczrt3j5hJUCNVBwmuWonF0Kq262sz75Z1LzVJkhkAvbkxlw5AdVLmvimdql0v4orZnbLS6nAv
	RhC9VX2Vt1nz+ezz+NsXJc+SjSv7OhJSYT73m2J7mW7viB9FN/mGktJqhPKB1PPqDO6LYOZpGX8
	TGlDsqn4CCUpiEN+kquVCKu8lOobdC5SRETpfSpgap4w4S5l5ubeCnHQ==
X-Received: by 2002:a05:6a20:2d14:b0:1d2:d001:5677 with SMTP id adf61e73a8af0-1d905ebfe59mr9558119637.17.1729148037329;
        Wed, 16 Oct 2024 23:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG8C/BVcvKkGicqaeLbaxiAJT7pyamfNAsXZNUiPjCu+QbFKGLR3kgbDl4/vHQ02bbwqp70XJypNXY2tnt4PQ=
X-Received: by 2002:a05:6a20:2d14:b0:1d2:d001:5677 with SMTP id
 adf61e73a8af0-1d905ebfe59mr9558108637.17.1729148036926; Wed, 16 Oct 2024
 23:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-8-lulu@redhat.com>
 <a6b0d25b-4b8c-4633-8900-978adf14795d@oracle.com> <20241015061702-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241015061702-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 14:53:44 +0800
Message-ID: <CACGkMEuPzd-gtBhCGE8dRWdAbyta=9yFPYjiCU0H0z3tLRJPRw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] vhost: Add new UAPI to support change to task mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 6:19=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 14, 2024 at 03:56:33PM -0500, Mike Christie wrote:
> > On 10/3/24 8:58 PM, Cindy Lu wrote:
> > > Add a new UAPI to support setting the vhost device to
> > > use task mode. The user space application needs to use
> > > VHOST_SET_INHERIT_FROM_OWNER to set the mode.
> > > This setting must be set before VHOST_SET_OWNER is set.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/vhost.c      | 18 +++++++++++++++++-
> > >  include/uapi/linux/vhost.h |  2 ++
> > >  2 files changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 08c9e77916ca..0e5c81026acd 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -2341,8 +2341,24 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsi=
gned int ioctl, void __user *argp)
> > >  {
> > >     struct eventfd_ctx *ctx;
> > >     u64 p;
> > > -   long r;
> > > +   long r =3D 0;
> > >     int i, fd;
> > > +   bool inherit_owner;
> > > +
> > > +   if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> >
> > Maybe instead of a modparam and this ioctl we just want a new ioctl:
> >
> > /*
> >  * This will setup the owner based on the calling thread instead of
> >  * using kthread.
> >  */
> > #define VHOST_INHERIT_OWNER _IO(VHOST_VIRTIO, 0x83)
>
> I feel this is not good because it is insecure -
> process should not normally have a say in whether
> namespaces work correctly.

Note there's still a lot of kthread users, so the "problem" is not
specific to vhost.

> So we want the system admin to be able to block the
> old mode.

Then we will break the userspace silently which seems not good.

>
> > It would initially be used by vhost-scsi when worker_per_virtqueue=3Dtr=
ue
> > since that is a new use case and there will be no regressions.
> >
> > For the other cases we default to VHOST_SET_OWNER. Other QEMU cases or
> > tool XYZ can use the new ioctl when they are ready.
>
> I do not like it that we switched default now we apparently will be
> switching it back. Will break some userspace whatever we do.
>
> --
> MST
>

Thanks

