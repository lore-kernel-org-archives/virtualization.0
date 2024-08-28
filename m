Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BE15D5CF
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838425; cv=none; b=FCHD4Xk0NkGg0XCxRfE1zEt5NXMEvV3JSrVdTLuVKRk5CGC50O6uy5psna7eCxmqTSRnPpuy5osCVtsyxG5DDRaftzbiuW2A/XZQ+U6h9TjrQNm9M9RF3wHKa/3lKNzPxu6k2XlEHfH5DosgAPtyiJ5E5i/SwHuvtAbJWb1LsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838425; c=relaxed/simple;
	bh=r72QLoFGiRbClZBW9n0myeCz15GaLdkhV+3zu7ayllk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEFGhoE+fnBGKuVeNko9pLSPxTmtc0SXAAOPV7VusXQbQcbfFtjW/aTkUu+FVBd6mgA9Sh1ehbx50vXsoqobpRkcaD7vXeA/7XNM54iGJUJ/tisscIPFGvvnj9rLgpR1E3ou9T0W1WXWBdkCNC4D9EIM4Ty7m4+8Zi/8zj1WZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6KFRKom; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6KFRKom"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D74ED402D5
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:47:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fSK6vor65Q_8 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Aug 2024 09:47:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B0C1A402B9
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0C1A402B9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6KFRKom
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0C1A402B9
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724838421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ccU6JWpMNBWSt+eDM3V9HlZBQ7GrgQMzqDlSIIFms9s=;
	b=i6KFRKomZh2DgqS513y6IzL49gIZfS8nC3aysHhcuEyQBpICElvTh2EKa0BIU3yCgJEcS8
	G3TOCyXX4jXLOG31QdTcIiQwlbXMy/hI8UeMHFUgH1kTUWoMX59p+xdlqfPJ9GXUcwM/Hl
	KBOhbpTdu8lgp1sHvjOcGZdfs/6PjNI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-A2evlxAZOBy4x769cFY66Q-1; Wed, 28 Aug 2024 05:46:59 -0400
X-MC-Unique: A2evlxAZOBy4x769cFY66Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bee6a8843eso5545200a12.3
        for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 02:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724838418; x=1725443218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccU6JWpMNBWSt+eDM3V9HlZBQ7GrgQMzqDlSIIFms9s=;
        b=VI23mPjNyrp4AAypZLA50NEPyTRKTV4T1J3LaqiFbxgSvPl5hd1MuaxJ/zGbJKFUd9
         b3eNh/7xieL5+dJaALvQNqwi5EExFTiZ/wA2H7ceXq/GNwL733wU34/Vn5VyHKqPqJb1
         ILYS7vfkY3orq2V5AuHrjoLqHkJZc+4XrC+f5Cd+upLbKZ8CMW2pChnRM4AWf9SgzVMM
         5TtlyN7DRN18uC79uF+sTrkcbYEXexiRpTnVBU7EgEBLCc2qQnW5fsV3pDIg+avovBIf
         3C2s9sa1jphAlHDnShcQMPqXvo9fFpwTUNKAwkTtxXGxv4/PfTgse+vAuNpjvQUtFcJp
         GtZA==
X-Forwarded-Encrypted: i=1; AJvYcCUypK1y+qnDMEU7FvyS5nJQGEQZrnDnx1Yh7OW0dBWn9qN8va/mu3yihx1TsY6vFpCyymGpXKkX2WeMUbWyqA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwEDUQUQexediIjtdDMUrC6rmKI5rAEb4ufKcqhmtKSnIZhR7XC
	S9JqBxxPmb+6aKaGo+btowKZvS5sv6PIFCBlKZAP8m9EOf3ILIM3yKwyhvaKATYaRsjGmUEWzmV
	5Dd4LXyAZJczEMGHxKpFjs6vNcXNvIe+hjTQX2odSqZxy86hDFvhX5DW5FQCNoN0rRi2YsTgCW5
	7MsxXBL4cBgWcqbZmESpncddpomez2SFlma9YNZmBMVRPALUylchojEg==
X-Received: by 2002:a05:6402:3709:b0:5be:e01c:6b5e with SMTP id 4fb4d7f45d1cf-5c214c62bf7mr1053095a12.35.1724838418359;
        Wed, 28 Aug 2024 02:46:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnq9AE9KRm5+YQj4Di1/zCftkF/BXYpzArwOeoZ4gVb/5zNP3hTWdDBV5iE8iU3DddUjK/zdPyIa2rrsOkdmY=
X-Received: by 2002:a05:6402:3709:b0:5be:e01c:6b5e with SMTP id
 4fb4d7f45d1cf-5c214c62bf7mr1053075a12.35.1724838417911; Wed, 28 Aug 2024
 02:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <CACGkMEu8y74bffhfPcPGdq1jBVXxaPivXGRh3qe9TdjOQfrp0g@mail.gmail.com>
In-Reply-To: <CACGkMEu8y74bffhfPcPGdq1jBVXxaPivXGRh3qe9TdjOQfrp0g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Aug 2024 17:46:21 +0800
Message-ID: <CACLfguVSqfrjTjYGkP6Fis=pONcf5x7u-8qUb=-Z+o-fLWENcg@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Aug 2024 at 10:32, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add a new UAPI to support setting the vhost device to
> > use kthread mode. The user space application needs to use
> > VHOST_SET_USE_KTHREAD to set the mode. This setting must
> > be set before VHOST_SET_OWNER is set.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 11 ++++++++++-
> >  include/uapi/linux/vhost.h |  2 ++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 0a7b2999100f..d6b71bddc272 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2340,14 +2340,23 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >  {
> >         struct eventfd_ctx *ctx;
> >         u64 p;
> > -       long r;
> > +       long r =3D 0;
> >         int i, fd;
> > +       bool kthread;
> >
> >         /* If you are not the owner, you can become one */
> >         if (ioctl =3D=3D VHOST_SET_OWNER) {
> >                 r =3D vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +       if (ioctl =3D=3D VHOST_SET_USE_KTHREAD) {
> > +               if (copy_from_user(&kthread, argp, sizeof(kthread))) {
> > +                       r =3D -EFAULT;
> > +                       goto done;
> > +               }
> > +               use_kthread =3D kthread;
> > +               goto done;
> > +       }
> >
> >         /* You must be the owner to do anything else */
> >         r =3D vhost_dev_check_owner(d);
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index b95dd84eef2d..386fe735da63 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,6 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE      _IOWR(VHOST_VIRTIO, 0x82,      =
 \
> >                                               struct vhost_vring_state)
> > +
>
> Unnecessary changes.
>
> > +#define VHOST_SET_USE_KTHREAD _IOW(VHOST_VIRTIO, 0x83, bool)
>
> So I think we need to do something the opposite. New flag for new
> behaviour instead of new flag for the old one ...
>
> By using this we can unbreak the old applications.
>
> Btw, I think this needs to come before/along with the introduction of
> the module parameter that enforce old behavior.
>
I think the old behavior your mentioned here is use Kthread?
So If I understand correctly, the NEW uapi is something like
VHOST_SET_ENFORCE_TASK

The module parameter can also be changed to.
bool enforce_kthread =3D true;
module_param(enforce_true, bool, 0444);

thanks
Cindy
> Thanks
>
>
> >  #endif
>
> > --
> > 2.45.0
> >
>

