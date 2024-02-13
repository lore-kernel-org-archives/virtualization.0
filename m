Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FED179AE
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810607; cv=none; b=eC0NIKg3njPkJ8rVIrLtxowcWPY4L8TFaXalY83zQCvCIQg9UFOr5EOvUlMUz87qmiFXA0JqtP2xLD9JqSr+8GIOeJHfWkK6nckH9GH8tJcAxbBPMvYRUWUuRwSFVV/TH8laN4BmkbdWhDMSqHhnSELtKML7XB+yVyw4XJ/ghuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810607; c=relaxed/simple;
	bh=IGlJct8UocHdJXhuIkJ7ySUjtintsyyQjIJPu0zBh04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srMVnxxi/jTXRVzdje/EEblRo7NIXknoUlzBnr0Rux2XCaYkWKZVEuyCV9yWBDgLmqRly4kASFtINLyc/3dJxL6AA8VdeYh+HoRt9BC48M24++gULAy/CMBwKre4zkh+idNTwgt/0ge416D3us/i8BeHf9T1PBwHYKey9rHYW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFVSGaeL; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFVSGaeL"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCAFF406D1
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 07:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VXHpSrkt5l91
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 07:50:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A61BA405F5
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A61BA405F5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RFVSGaeL
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A61BA405F5
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707810602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WD8HyMi+KDRNtPWM+Apb/3cJueC+uBY6p5Bp0UVVdjU=;
	b=RFVSGaeLzK9mKEHnhNWs52aLbULgFKpHTLxfIL4fis9x0K1v1Qty1PgbktLSzybCswQC1H
	vwxb/Ml9noq5Zzg+Y2xYO5hT4aS3dtTTpX/S0Ar7oZjQ5IwFW3a2ysxjS0KNTeuIKMQcDH
	4+0Hp7XVJ6jx5dOtvN6Z5qWO2Tu1cck=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-27y6sv48OaGOxod8se-4ZQ-1; Tue, 13 Feb 2024 02:49:59 -0500
X-MC-Unique: 27y6sv48OaGOxod8se-4ZQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dc647f65573so7254621276.2
        for <virtualization@lists.linux-foundation.org>; Mon, 12 Feb 2024 23:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707810598; x=1708415398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD8HyMi+KDRNtPWM+Apb/3cJueC+uBY6p5Bp0UVVdjU=;
        b=ONREC4YAcjTZzMBvfi0jujwCvlsREtWV22I4mKo7WkPwCH0IWiF3IH0nFOj8c634YA
         0g5icQoikBqGUz4DTx2XfRpIQAkrGfQla4vfUBgMRHQbWg5kEc8kjUQH7eUB8kBwMO7U
         TpKHwIv/qju6A/72mhIwh8hHDLOfnZgiBBR8MpgDNl8yc23JSvNzyqP74PSifivo5/Fu
         O/K3YhMShKunSQYyn7d/CRm5V9sUAT23P+1fcWrCIyV3yqfhmhAdTbVSILJD34uCv6bn
         WPSIYui+Gtd/x3Fx5njpvtMI6hMOvRN5jz6iJZc8SPbV6x9cxhg0iMjLzik6xGe9nlDI
         jbow==
X-Gm-Message-State: AOJu0YyyB7pqKJgMQvPMEifB/1D6fOV3vA2lV5qVYa9wdSiVlqlZSm1K
	g6ZEQefasJOdAYF9i4s8vkFPt2nttV7MeEeN3bhoQZ5B7hU6DeNYNjfrunVwlFs6W1hYnpPi/Rs
	t67rO+PQE1jwFWcJgZfdhkXMSLfh9O/CWvmwSkOgcmlULNpuEZdm7d4SE3rlJKj6s3FnLHaPHQw
	Vf+7rJvPrhgnWhRGDGZ6B8YlyqooTnGYjmErgQzqhJoVazKgCdlhbKFUz+JGOhSxJZ
X-Received: by 2002:a25:820d:0:b0:dbd:5bfa:9681 with SMTP id q13-20020a25820d000000b00dbd5bfa9681mr7462174ybk.37.1707810598327;
        Mon, 12 Feb 2024 23:49:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYSPexmJxuxFZYyjtjDwgf/rqjhXzefnrHu+jPWU4Rz8j5IBWPCVxEBALDrlrkPWF6ACDM/ejf9firzPkcRGw=
X-Received: by 2002:a25:820d:0:b0:dbd:5bfa:9681 with SMTP id
 q13-20020a25820d000000b00dbd5bfa9681mr7462164ybk.37.1707810598045; Mon, 12
 Feb 2024 23:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com> <20240212031722-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240212031722-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 08:49:21 +0100
Message-ID: <CAJaqyWcyoDCp6OVQQbU=Pd73tGki0dBQmb82=i5MmsLcZTZfyw@mail.gmail.com>
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

On Mon, Feb 12, 2024 at 9:20=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> > Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> > vdpa devices.
> >
> > Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>
> I don't think failing suspend or resume makes sense though -
> e.g. practically failing suspend will just prevent sleeping I think -
> why should guest not having driver loaded prevent
> system suspend?
>

In the QEMU case the vhost device has not started, so QEMU should
allow the system suspension.

I haven't tested the QEMU behavior on suspend (not poweroff) with the
guest driver loaded, but I think QEMU should indeed block the
suspension, as there is no way to recover the device after that
without the guest cooperation?

> there's also state such as features set which does need to be
> preserved.
>

That's true if the device does not support resuming. Well, in the
particular case of features, maybe we need to keep it, as userspace
could call VHOST_GET_FEATURES. But maybe we can clean some things,
right.

> I think the thing to do is to skip invoking suspend/resume callback, and =
in
> fact checking suspend/resume altogether.
>

I don't follow this. What should be done in this cases by QEMU?
1) The device does not support suspend
2) The device support suspend but not resume

In my opinion 1) should be forbidden, as we don't support to resume
the device properly, and 2) can be allowed by fetching all the state.

Thanks!

> > ---
> >  drivers/vhost/vdpa.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index bc4a51e4638b..ce1882acfc3b 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v=
)
> >       if (!ops->suspend)
> >               return -EOPNOTSUPP;
> >
> > +     if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> > +             return -EINVAL;
> > +
> >       ret =3D ops->suspend(vdpa);
> >       if (!ret)
> >               v->suspended =3D true;
> > @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
> >       if (!ops->resume)
> >               return -EOPNOTSUPP;
> >
> > +     if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> > +             return -EINVAL;
> > +
> >       ret =3D ops->resume(vdpa);
> >       if (!ret)
> >               v->suspended =3D false;
> > --
> > 2.39.3
>
>

