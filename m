Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7C8125B2
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811744; cv=none; b=VGNrCSuuoJ/5+xtHX0ae4YWmhWV4gaeoRP4r8ougjBnOa7kZh6nPKIeEK3DPKQ2jYznRHYZrjZeNREYq15FiRYxB+xCmi8LrM/C0ywLMkY6Ezorc42Jjzcjxs538bE/vKqXanNW6kPO1XrbCLilQEwvQ8MFKy20X/UEP2XY+1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811744; c=relaxed/simple;
	bh=Him3uu+VhmW+P97SEtrpmNC4Q3nMKaWaoPwFM5roTjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJfK0t687/8TAfDfjyvHiRZ2cg3HwjX7NukFIpmsPa4uWnrfmrE8PRw9QzSSb2RVjFHB4ViGkY1IkUPmDsailtiTgqBFdwz9ZKwy4Rbkd7hwhe7d7gSxqaSbBvtwZytBHwc61680b2GxnneOQi1nmKVPPjX3qJLwo82GQqKM1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXuU29JD; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXuU29JD"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B32C40936
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 08:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Yq7JnWovphw
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 08:09:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 70DB94058A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70DB94058A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IXuU29JD
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 70DB94058A
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 08:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707811739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2znvQ6ssT4uVnr2WUtHz2BuLWLoRgEnRzMe+E1iIug=;
	b=IXuU29JDQrOvApPAzco+S2tL6Vmu9DXy0YpYkhPz9B1YerhZniHR8VI40b8SqdcKmOhDwE
	IbjNwDc0OXlb+wVa55H+QmG7c0rxNNbCQx57X8WnHsjDHxK2CQrXoq+ySmh1URaZqk7xji
	IkplhJtPkx03ll63oQGAA6J99U2rhio=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-CTLk3R93MDCgM1XVbZ1udQ-1; Tue, 13 Feb 2024 03:08:58 -0500
X-MC-Unique: CTLk3R93MDCgM1XVbZ1udQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so1618559276.1
        for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 00:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707811737; x=1708416537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2znvQ6ssT4uVnr2WUtHz2BuLWLoRgEnRzMe+E1iIug=;
        b=w3ze2cA5sAqAdMCki5ONHzWjVa9ahA00dNqnUlRSADy7oxY96dEpnPQ/YCojZ8iHYE
         aW+sVX/8VftaFCdhObLt6oHYcSZfJbtaYDo9ZUOER5DyEMDYPSBY9/dXAKNF3jJ6BFKq
         B0lHo1pT2mHO4eeLtNyb9IkH+lDVU9OjjQ69TQZCesXQzgejeOQ60XZM0Mn8HUm4R1xq
         KkQzKukGSwZHgfdqUHE1vKhQXkxHFgT5fe7WczAF7+kDH6Hj3K9pATyHlRINMsEgeHGS
         6YE2zBS91bWtqJwC6QDhDjG+quAciG2GKImHRcakd7J/UIJkzdIENK01pmZQEli8wHVS
         bMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKwVLZs90NRaL4EV6t8gHvxOj6WV5UbinBc9Tp/Aav6R/P6GE3kQf7OUU54xgnK0VX4dO1NSeYyW1Jkjap/dQe8nHjmMcoLcj1Y/k/KlSStWjUyf3un8QpWQ==
X-Gm-Message-State: AOJu0YwFuhpckNYTqlfqK2p+TH+yWxwsUGAgG6pMM6cJ5x2kSBQ84S2S
	NUxbUZNmztrfOurYFGyZJ9d68XzWw++hwcCEu0G6Dpfeur7GHUa0zUBK+UdA3ZXPfkaIwR+UEb2
	lIetvdIU8jSW6C0UISqgLH5T70L9WnIcxAyklxlrUjA1MUNV7m6kIv3SL5TnrNFZd0v5ywosQa9
	uujsF2I8mr5tXakyJRlx9lP1MQ4AWxFcTF6RYkpce1Ngq/aWFGsoru6Q==
X-Received: by 2002:a25:c5cc:0:b0:dcc:2da:e44e with SMTP id v195-20020a25c5cc000000b00dcc02dae44emr2067606ybe.61.1707811737591;
        Tue, 13 Feb 2024 00:08:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB85iA0wuX+bkrV7RmCTb44Tsqf91DLHEXY9MpcVOEMNtO1sH+p0OEz/bSxFF4evsBn6zlqrdsfYYEIKF7iFA=
X-Received: by 2002:a25:c5cc:0:b0:dcc:2da:e44e with SMTP id
 v195-20020a25c5cc000000b00dcc02dae44emr2067598ybe.61.1707811737307; Tue, 13
 Feb 2024 00:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
 <20240212031722-mutt-send-email-mst@kernel.org> <CAJaqyWcyoDCp6OVQQbU=Pd73tGki0dBQmb82=i5MmsLcZTZfyw@mail.gmail.com>
In-Reply-To: <CAJaqyWcyoDCp6OVQQbU=Pd73tGki0dBQmb82=i5MmsLcZTZfyw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 09:08:21 +0100
Message-ID: <CAJaqyWcmYMXvLmJ2JYbrcF818doz1og625CHst7fWED6oMBCHQ@mail.gmail.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 8:49=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Feb 12, 2024 at 9:20=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> > > Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> > > vdpa devices.
> > >
> > > Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >
> > I don't think failing suspend or resume makes sense though -
> > e.g. practically failing suspend will just prevent sleeping I think -
> > why should guest not having driver loaded prevent
> > system suspend?
> >
>
> In the QEMU case the vhost device has not started, so QEMU should
> allow the system suspension.
>
> I haven't tested the QEMU behavior on suspend (not poweroff) with the
> guest driver loaded, but I think QEMU should indeed block the
> suspension, as there is no way to recover the device after that
> without the guest cooperation?
>
> > there's also state such as features set which does need to be
> > preserved.
> >
>
> That's true if the device does not support resuming. Well, in the
> particular case of features, maybe we need to keep it, as userspace
> could call VHOST_GET_FEATURES. But maybe we can clean some things,
> right.
>
> > I think the thing to do is to skip invoking suspend/resume callback, an=
d in
> > fact checking suspend/resume altogether.
> >
>
> I don't follow this. What should be done in this cases by QEMU?
> 1) The device does not support suspend
> 2) The device support suspend but not resume
>
> In my opinion 1) should be forbidden, as we don't support to resume
> the device properly, and 2) can be allowed by fetching all the state.
>

Ok I missed the whole other thread, everything is clear now.

Thanks!

> Thanks!
>
> > > ---
> > >  drivers/vhost/vdpa.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index bc4a51e4638b..ce1882acfc3b 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa =
*v)
> > >       if (!ops->suspend)
> > >               return -EOPNOTSUPP;
> > >
> > > +     if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +             return -EINVAL;
> > > +
> > >       ret =3D ops->suspend(vdpa);
> > >       if (!ret)
> > >               v->suspended =3D true;
> > > @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *=
v)
> > >       if (!ops->resume)
> > >               return -EOPNOTSUPP;
> > >
> > > +     if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +             return -EINVAL;
> > > +
> > >       ret =3D ops->resume(vdpa);
> > >       if (!ret)
> > >               v->suspended =3D false;
> > > --
> > > 2.39.3
> >
> >

