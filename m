Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034025A2CD
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Apr 2025 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744187910; cv=none; b=h2FhjQzxcICUIe8F2YrQ8RuCAmXxwXnNC3DYQDaK3KhzGcSRXzqCobl2wp+12LzuiFr7NTcOs1/Xtz1KQ3ZmPuBD9+4DSsJ+t2Sn6QxHbLhKeVA4nXSovOSnNsI1BQYZSGzbMklqQ4liIUBqWfrC6VmQqAAAQ7bLtdkwlslmipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744187910; c=relaxed/simple;
	bh=61PW9y7PDNWOcIblSehzngap5jGtPaiZoqUtTkIf7Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMMpxCyXUuxe13HckAwqvspeVugz39J98svRjKnWEFrkfzAD07h3piMebjQedvGSEWmh8yvj8kCMa3w1u/cXz2xV5aqZca623CpVnGJHeQJCkWyu9he+weMymC9rd952TiVxBhDSBmkAOAG4P4CAaaFUWN4wea34hXDz5TFZKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSfCJDAX; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSfCJDAX"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 498D06086B
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Apr 2025 08:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mvaUqT6wGwnX for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Apr 2025 08:38:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 80BE061077
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80BE061077
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NSfCJDAX
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 80BE061077
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Apr 2025 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744187905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Db2JSRrytLkXPNCk2u9oY2iCWyl++39LNyoKOlHjxS4=;
	b=NSfCJDAXC34jrFptPGDjx0rTF0OMzG5QLUJf6xgealGWuI4d3jd+px3MoaSAS8ZOFABoOH
	bMxw/efRCmI7NrHxZRolHq3bkfFCZVrLEDdeiypBa/GRag7BHbMBDR4I58pm3YqJWIds39
	4F2alWgFNnA6e2qyMKSgANV6QvYWRGk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-aRfgxG7TOq29Z57c3C2t2A-1; Wed, 09 Apr 2025 04:38:24 -0400
X-MC-Unique: aRfgxG7TOq29Z57c3C2t2A-1
X-Mimecast-MFC-AGG-ID: aRfgxG7TOq29Z57c3C2t2A_1744187903
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac79e4764e5so566985566b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Apr 2025 01:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744187903; x=1744792703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Db2JSRrytLkXPNCk2u9oY2iCWyl++39LNyoKOlHjxS4=;
        b=crkjanDXzgqhMuyPO0QsXl+LLT4v0sDucGBktgD9RbrcHSm03+ScrukMLASzBc1Lf1
         wuCu+KLF3Hv9fyut6dvuScQ4AQ1Cq2H+/iw6tjvbZuZTc/MnrKnqP8zQN9O64n8dSzPK
         HLP/SuljxkmPOJ9+zu6ufxMKYO9QQZ9WIG35PchjmVCpcwbdFqzxMY81wbCJcpEl+oGc
         ENQwk7YbYvy12Cn9HuJ2qWDcv7MzPDAMKQmwJeVT6fzqQKByow/jHWh0I6kXt+wE2faF
         2E8ptlFUkn7O+2r9XPTCOWjyzzDT7DzXzeytPNPsRY8p8sDaR5Kl5WTlbRbK6d2Kx580
         UAYw==
X-Forwarded-Encrypted: i=1; AJvYcCVqE5SmYOW4GDcHOno/fer5PGZJH3QaADaLQo8JJSI1ZcRA54ZoKdNSBBEXRi3h2D636bA5Py66JbnX4TK5jA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzsx29yvKZ8qX+0DLYL1UNWQGJkqkSPKDHOU5i5wv/7B4/QtOEh
	thiNPYFGRacZd4Gej0IgpCSlf1YTSaruODrkclDRVd9zdxepi7+gQup7m6ZdRfEpCQUmJSnmlxH
	wSAPOCRw3SYfQyPkKAqrQBSRS+C+YZExxv/Wl0xs4iKiH9Z8rHn8zj2bw/56e9QC+9kMRyy+QuH
	yDmXvj8aMjNWnClM6hVJTR/6Ff32XC/OcMkVUliR4rv0H7gZVbkfdJHg==
X-Gm-Gg: ASbGnctAHlhiiNKiZlnQhDrhKfyziQftgkMVlyVcgVnCFUd+ZabXJIoNYnZXVU0RyY2
	eyXi56cY132uVEHSpXOx0pjGJ3KeX9CUV2H80NJ3LXF/lCgcnvEiFP/aa6kXNcFkq4mdFWQ==
X-Received: by 2002:a17:907:d22:b0:ac7:e5c7:d235 with SMTP id a640c23a62f3a-aca9d5f2efbmr173776966b.17.1744187902790;
        Wed, 09 Apr 2025 01:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfsT/n2l3DnTQQWDgOLT9XB9DPUTgcUViU2G8XrGBhEdFOH5XIrY6JzqMwM3FJqCj1qI/dn6iOuo9AsFhQy0g=
X-Received: by 2002:a17:907:d22:b0:ac7:e5c7:d235 with SMTP id
 a640c23a62f3a-aca9d5f2efbmr173774366b.17.1744187902343; Wed, 09 Apr 2025
 01:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com> <20250328100359.1306072-9-lulu@redhat.com>
 <20250408075426-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250408075426-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 9 Apr 2025 16:37:44 +0800
X-Gm-Features: ATxdqUHSwziP5tEY_Ach5syGN9Prz3P9ZHSrioqnJKFuE86H3ZVl_NFlZH6Hdgk
Message-ID: <CACLfguXTYy2BfmB3wLnVdANu6jvxjP4G8a3h2XHO-iw5RE1CnA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 88nQHgEC17LMVHAyTQ6-dJGx6PoY7tP5VmF_sSApRlM_1744187903
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 7:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, Mar 28, 2025 at 06:02:52PM +0800, Cindy Lu wrote:
> > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > is disabled, and any attempt to use it will result in failure.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig | 15 +++++++++++++++
> >  drivers/vhost/vhost.c |  3 +++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >         If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +     bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +     default n
> > +     help
> > +       This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allo=
ws
> > +       userspace applications to modify the thread mode for vhost devi=
ces.
>
> ok
>
> > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to=
 `n`,
> > +          meaning the ioctl is disabled and any operation using this i=
octl
> > +          will fail.
> > +          When the configuration is enabled (y), the ioctl becomes
> > +          available, allowing users to set the mode if needed.
>
> no need to be so verbose - the disabled beavious belongs in commit log
> not here.
>
> Also either ioctl or IOCTL but not both.
>
sure, will change this
Thanks
cindy
> > +
> > +       If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fb0c7fb43f78..568e43cb54a9 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> > +
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >               u8 inherit_owner;
> >               /*inherit_owner can only be modified before owner is set*=
/
> > @@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >               r =3D 0;
> >               goto done;
> >       }
> > +#endif
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> > --
> > 2.45.0
>

