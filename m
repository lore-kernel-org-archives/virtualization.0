Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CC21147B
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140898; cv=none; b=cN+pZoQJ0MoxO/Qkbxc/pc9Br6ZEGYOoux7E7r/b6mF+FFkPu4Z5dcDtNynbitI7GhXA9txu/zSY8uAuJ31jZ5TWaWry1hLMGAhK0nS2ir2gAu73riZ3guJPg7SlA+MLu2ynC1UwhsOGuQCrAYjG3KUaZukUwO/PEURQ4uUJRX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140898; c=relaxed/simple;
	bh=xzcyd/4tACV1vdkZnBnWWvBGExY6+i1HYokMa9uBOqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ3ZHvn5rHtY56YiMaIB6A9S/h5Mo59dyacqZDoyq2HqLLptnM2unGbCNx74H0XN8SeQhqdYGgSElsHo4tadP4c+yPyrwx3kdnUlt49o2DfVZSzEaSW0PzA8a3No4pcn6wXK5YqfuI26QjnzkHlrrQ+CkRG1Apo7dsQJU2E0VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ah6kXaXS; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah6kXaXS"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D34C850F4
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5hvbpkMV3mb for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 05:48:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B8978850F3
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8978850F3
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ah6kXaXS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8978850F3
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743140893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTKh94tdwNg9q3c5LOM370VR1+uTKQc5L4EVszLLHWU=;
	b=ah6kXaXSH0u702HRtryB/0Pujl8gECyWrptYj1R5KMSJmoe6FD5jgFYzy+mZ+nNik85vy1
	gFxDm77WdHHArPRRUpUEtn/BQc4koy/zDAsuwbMU4O8PEiVPTeBchgJgM0RcrQpbLV1TgT
	d6zY4WUlBywLshlQSK5t0XTY4caiNKA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-lifsAhxpNNWeOgg-gcejcg-1; Fri, 28 Mar 2025 01:48:10 -0400
X-MC-Unique: lifsAhxpNNWeOgg-gcejcg-1
X-Mimecast-MFC-AGG-ID: lifsAhxpNNWeOgg-gcejcg_1743140889
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3dca41591so156156066b.1
        for <virtualization@lists.linux-foundation.org>; Thu, 27 Mar 2025 22:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743140889; x=1743745689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTKh94tdwNg9q3c5LOM370VR1+uTKQc5L4EVszLLHWU=;
        b=cEcx4UAL9LIbwAvmXsajDZwoLPyvu/72vZYgbrWZ3CDYbGh9rLAotqP2hh92cGjjpo
         DM/jSUQdbnvYyh/RY5pqL17fflNgAT9GREuCYyQI4QBY1J9PCDRcBFk5GCpxS2WL2r/1
         Wy5cCXO7e94SnEcoZkpAK7sa1sE8X5uaI3UQcIfeZHha1zu2gExiJIqtKc4XxZUi+9lP
         qTnIYN47Yet5FU4zk/MBObWxDVZW3I9IBKq52es/B6Kg9mIPZd2vvOLGMwUc3Myv/E3U
         qr9o43Us1I+cY+cviyERngR+O3HgxMKfe1kP2cAIKn8nX+vqPXce+y6pBoTgk0oOGyw5
         ftPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZN5gDw7gJrOmjstx2KRMfPUQ6w9L7ZvvyI5GlO1yG+A5AfG0HSPBNuxKE8+Q83HyJ6VrBmFEP/J9CSqgcw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwfGhb5y8EWEvq7NaRVBwcU9WSQmCblOzc3hGJXQzuiQa1mkcgA
	4bxknNnkf7+Qhwm9oJBT+U6Oyxynn9cnXwrvaZAEiohp/A8sEob9JuqYHiVa3SB5TpKUzXjFRUt
	GR0tSdzPlBY6DcJfKukN+FimVklQaLddbTgr/w3umNGBruE+c2BoWG8RPcs0AerZWBSijAQtXPn
	6U4ItqE3HvMFK7J8B709cjinSRJEN51b5YwQWK6h1+yC7okFRChHPchw==
X-Gm-Gg: ASbGncsVjEmo17QnuRHBtwYRFDq5ajVpDytcSZulnL+lEN+uHl7LjAGMorQFgtdvKQc
	eAL8CqHUW2ytp9vsJRsHIfZhGKdODx9Fshl5AUCarT42QdYqBXKE1A5ySZTxLWuM66QlcWUWJyA
	==
X-Received: by 2002:a17:907:608d:b0:ac1:fb27:d3a2 with SMTP id a640c23a62f3a-ac6fae43107mr572830166b.5.1743140888721;
        Thu, 27 Mar 2025 22:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAxFnUp1kopqJ87Yu6gx3aXwUHDTW6oUEiLodlLZhwNh8981qQjsS2iXuR+w9T4KcHv8JjuXB4mL4fMR7n4KQ=
X-Received: by 2002:a17:907:608d:b0:ac1:fb27:d3a2 with SMTP id
 a640c23a62f3a-ac6fae43107mr572828066b.5.1743140888321; Thu, 27 Mar 2025
 22:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com> <svi5ui3ea55mor5cav7jirrttd6lkv4xkjnjj57tnjdyiwmr5c@p2hhfwuokyv5>
In-Reply-To: <svi5ui3ea55mor5cav7jirrttd6lkv4xkjnjj57tnjdyiwmr5c@p2hhfwuokyv5>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 28 Mar 2025 13:47:30 +0800
X-Gm-Features: AQ5f1Jq14v0a610in7Y1BoeO9ekSPxC1BG3Mk0b8VDIHn8AMhS-ZlF3OlrBypI8
Message-ID: <CACLfguVActMtC-_2fSS7GMWSgmSjaHFcXr-7H72Co301ZbXC6w@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZhWI33n3L25sFSnwI09yiClguwGRRtv8Lk-R29RkdJk_1743140889
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:12=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> >On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >>
> >> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> >> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> >> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> >> is disabled, and any attempt to use it will result in failure.
> >>
> >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >> ---
> >>  drivers/vhost/Kconfig | 15 +++++++++++++++
> >>  drivers/vhost/vhost.c | 11 +++++++++++
> >>  2 files changed, 26 insertions(+)
> >>
> >> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> >> index b455d9ab6f3d..e5b9dcbf31b6 100644
> >> --- a/drivers/vhost/Kconfig
> >> +++ b/drivers/vhost/Kconfig
> >> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >>           If unsure, say "N".
> >>
> >>  endif
> >> +
> >> +config VHOST_ENABLE_FORK_OWNER_IOCTL
> >> +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> >> +       default n
> >> +       help
> >> +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which a=
llows
> >> +         userspace applications to modify the thread mode for vhost d=
evices.
> >> +
> >> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set t=
o `n`,
> >> +          meaning the ioctl is disabled and any operation using this =
ioctl
> >> +          will fail.
> >> +          When the configuration is enabled (y), the ioctl becomes
> >> +          available, allowing users to set the mode if needed.
> >> +
> >> +         If unsure, say "N".
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index fb0c7fb43f78..09e5e44dc516 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *argp)
> >>                 r =3D vhost_dev_set_owner(d);
> >>                 goto done;
> >>         }
> >> +
> >> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >>         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >>                 u8 inherit_owner;
> >>                 /*inherit_owner can only be modified before owner is s=
et*/
> >> @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >>                 r =3D 0;
> >>                 goto done;
> >>         }
> >> +
>
> nit: this empyt line is not needed
>
sure , will fix this
Thanks
Cindy
> >> +#else
> >> +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >> +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', r=
eturn error */
> >> +               r =3D -ENOTTY;
> >> +               goto done;
> >> +       }
> >> +#endif
> >> +
> >>         /* You must be the owner to do anything else */
> >>         r =3D vhost_dev_check_owner(d);
> >>         if (r)
> >> --
> >> 2.45.0
> >
> >Do we need to change the default value of the inhert_owner? For example:
> >
> >#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >inherit_owner =3D false;
> >#else
> >inherit_onwer =3D true;
> >#endif
> >
> >?
>
> I'm not sure about this honestly, the user space has no way to figure
> out the default value and still has to do the IOCTL.
> So IMHO better to have a default value that is independent of the kernel
> configuration and consistent with the current behavior.
>
> Thanks,
> Stefano
>
> >
> >Other patches look good to me.
> >
> >Thanks
> >
> >>
> >
>

