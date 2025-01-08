Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065C17E8E2
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304716; cv=none; b=j8a0t0B2WimHJwwxmIc9dJiEk67jLdavxDe1xRvi+lFKwf4vQUL4YJ2GkJ2OeUSjuzjaM387Ye/cmccqtBvUMsSCIMBG4CgH6KRfvI/739aHHjmcHTCDgG77ycA2RhLjjeViabD4sUwXV31tS64NKVfCU22GEX1XtWmJ3Bw5Fvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304716; c=relaxed/simple;
	bh=8dLaTNZkOANyi7LZAXsihdUd6Va5DlR/j7so/eFJ/RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/JNR9v7XI9/HU2ew846kfWjnGEwL9RPU/GSzHIKUpOVHGgeFw855LayblQVyrqUkmC+XSQECofvKtG8aKCixPdE8JHY40v/kj74EC783CEbugoPWagyndJ05OqBI+PyUT/G3gZnHYqo/LOLzTicvt2IFZrq0t90r+8+uqEySzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVEw9Cnm; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVEw9Cnm"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E8FC605A3
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 02:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X9Ma_9bo4EtU for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 02:51:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A2313606E1
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2313606E1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVEw9Cnm
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2313606E1
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 02:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736304711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaOb1WalMmtTDfnQFpI5uhYTy1TqdKKF46UnkmKk8QA=;
	b=eVEw9CnmuaHrj27pb81E7/jTfs7/FIdqO8urAw5Hd+VFYYQ6VSMDFyLXy32t/QjHYxx0Tq
	LVrZm12j+4kdlqbf2ZrTsF4Vs1maGCaVvqScsNUJJC9P6WJ1Z5nTA1RpUM/WZ2mpB8+qXZ
	QyOurL6/zI+7/TIimZAX9WiWKPjkQhI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-8x5LwG8tM1awwhqtSYpBbQ-1; Tue, 07 Jan 2025 21:51:50 -0500
X-MC-Unique: 8x5LwG8tM1awwhqtSYpBbQ-1
X-Mimecast-MFC-AGG-ID: 8x5LwG8tM1awwhqtSYpBbQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aab954d1116so852897166b.3
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Jan 2025 18:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736304709; x=1736909509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaOb1WalMmtTDfnQFpI5uhYTy1TqdKKF46UnkmKk8QA=;
        b=qmqb7mHoTmZo52n03KAV0EI1re57VWekrQDKFgzZxLe6DQtopouhVjQFugtqstxvpn
         zHaiZFFxvnQ/IrguEKRCuX31nD94z/8O6GWQxsTXwYlLNKqbODiw7tYBGVgGuzNX2aR7
         wCXB0z1n+3hmtfP4Dzl+ryMfoMOFCpVSBbDdt7Kee77H9WazI47vTOLWinSHrN3Z866I
         dT23nQHpDIkYCFtNnz6rpZBZNnO4P8LhPWYDcyseBuVttsv1vVa5CgDPggVYDJhyCVN+
         qqry2UqYRaoymiBMMqA46lyyjuRITAJTp8BTwvvmpTmZHhsNC601E8EQyn0fPNJUkQcX
         p+QA==
X-Forwarded-Encrypted: i=1; AJvYcCWiPk2cfni6i6yucbxCTCsoB3HlHQinC/DdkMuN3cQLK8fWEaDKiPbC876F/KshNTkdeR063iYjM811kbKnHw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw4LbaEEAivMOBgbLUH03pTQfHCReSTDkURdBOwUEWZrZq+BOsq
	oZJDVQNLx1aXp2XtUX34whxgDrhEKGxFO4BukfwBKivWogeCPZ7twiIdZOgsrA8vcCtKpVZEMYD
	asdM3h/bas7tDucOT9l0hF6oGcfbELtnN4ZL2JxdMghdBxCxmL5QbzeFmDS0KSXzmDsBJYiZp/T
	8utUMWrx4Eg9KtQtsJ8/cMWpeVrG6/fwtN74gf7GEyXJDOkeavDx9Hww==
X-Gm-Gg: ASbGncuKytq6Lo4icD0aF9JEDBAPN04WP6bub5ITUUEVboLC/1gCUdUfGHQX8p6sVdh
	4cNxdadzNJYqT8ReYfkpsn/lH7auQcU56BA3jIyE=
X-Received: by 2002:a17:907:70c:b0:aae:fd36:f511 with SMTP id a640c23a62f3a-ab2abc6ea66mr77955566b.47.1736304709349;
        Tue, 07 Jan 2025 18:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6yK+DbzIUr4iGjw5rQGTq1fi56HNFDf3sTbtwCjx1OywVB5oV8TYRFR62h6FgiT92zaX8RgvipZ3/oQ5Q3Ic=
X-Received: by 2002:a17:907:70c:b0:aae:fd36:f511 with SMTP id
 a640c23a62f3a-ab2abc6ea66mr77954366b.47.1736304709030; Tue, 07 Jan 2025
 18:51:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-6-lulu@redhat.com>
 <CACGkMEvPbe3wvC0UvAu-vgGYu1xMWRzCt0qwUofcHJThRdFxiQ@mail.gmail.com>
In-Reply-To: <CACGkMEvPbe3wvC0UvAu-vgGYu1xMWRzCt0qwUofcHJThRdFxiQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Jan 2025 10:51:11 +0800
X-Gm-Features: AbW1kvbiMIhC0HRAuDWZOT4vBtLPxtDfnnW0zCtIIqaxj_a90D6twTPuluo2bIM
Message-ID: <CACLfguV_PZSuhXsga=A-OeBGx0m0ThjyVy1eihM_2WEmoY3jhQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] vhost: Add new UAPI to support change to task mode
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uYj3o4XfK9V4mCw7n07Q18LV_mdfbOG2_H3nsVgr2bA_1736304709
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 2, 2025 at 11:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a new UAPI to enable setting the vhost device to task mode.
> > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > to configure the mode if necessary.
> > This setting must be applied before VHOST_SET_OWNER, as the worker
> > will be created in the VHOST_SET_OWNER function
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> >  include/uapi/linux/vhost.h | 19 +++++++++++++++++++
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index ff17c42e2d1a..47c1329360ac 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2250,15 +2250,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >  {
> >         struct eventfd_ctx *ctx;
> >         u64 p;
> > -       long r;
> > +       long r =3D 0;
> >         int i, fd;
> > +       u8 inherit_owner;
> >
> >         /* If you are not the owner, you can become one */
> >         if (ioctl =3D=3D VHOST_SET_OWNER) {
> >                 r =3D vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +       if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> > +               /*inherit_owner can only be modified before owner is se=
t*/
> > +               if (vhost_dev_has_owner(d)) {
> > +                       r =3D -EBUSY;
> > +                       goto done;
> > +               }
> > +               if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > +                       r =3D -EFAULT;
> > +                       goto done;
> > +               }
>
> Not a native speaker but I wonder if "VHOST_FORK_FROM_OWNER" is better or=
 not.
>
Sure will do
> > +               /* Validate the inherit_owner value, ensuring it is eit=
her 0 or 1 */
> > +               if (inherit_owner > 1) {
> > +                       r =3D -EINVAL;
> > +                       goto done;
> > +               }
> > +
> > +               d->inherit_owner =3D (bool)inherit_owner;
>
> So this allows userspace to reset the owner and toggle the value. This
> seems to be fine, but I wonder if we need to some cleanup in
> vhost_dev_reset_owner() or not. Let's explain this somewhere (probably
> in the commit log).
>
sure will add these information
Thanks
Cindy
> >
> > +               goto done;
> > +       }
> >         /* You must be the owner to do anything else */
> >         r =3D vhost_dev_check_owner(d);
> >         if (r)
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index b95dd84eef2d..f5fcf0b25736 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,23 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,      =
 \
> >                                               struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the v=
host device
> > + *
> > + * @param inherit_owner: An 8-bit value that determines the vhost thre=
ad mode
> > + *
> > + * When inherit_owner is set to 1 (default behavior):
> > + *   - The VHOST worker threads inherit their values/checks from
> > + *     the thread that owns the VHOST device. The vhost threads will
> > + *     be counted in the nproc rlimits.
> > + *
> > + * When inherit_owner is set to 0:
> > + *   - The VHOST worker threads will use the traditional kernel thread=
 (kthread)
> > + *     implementation, which may be preferred by older userspace appli=
cations that
> > + *     do not utilize the newer vhost_task concept.
> > + */
> > +
> > +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +
> >  #endif
> > --
> > 2.45.0
>
> Thanks
>

