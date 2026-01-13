Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5E38F92D
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317003; cv=none; b=tNDbp8RpvGJYAIKuonkuPJRrjJ+mcwboKy6w0GFfRZwjbNk3fjxI71ZymmlwyC4/Gf/hNBaXgXsMWHLTHr9oAX+WthBxxlMFK0hHFpZqdbj2QEN0BfKQcVh3uwnkMayqdkCIpo139tDhp2Xju+OkLykMs+DMbBIPR/g83Dht5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317003; c=relaxed/simple;
	bh=IjDfml/1cvOw28maSGmYa6FTlTr0QObwVkLthL0Z9E0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRWaCuzaGlXvofxpAuojaKAPUxJCsfzNJELm5A2Qz1s2J5sDoeQPNXZVdY4Q2ppiaO9lWsmjDs6UGzWkmuUznQRqWVxLxhtJMhKGfIsLnpQBPRv7NbDcmm0zSqrqQMdR6wB1/V2YtjrEYzjWtorgjBgzGe09M8Cz6kIVkUcOXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPsk5HZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPsk5HZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768317000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAAeBZ/ggGqoYtjNvmyj/ESVJlgSIndVqwIXnT1NG9o=;
	b=QPsk5HZirVaONL8Zw5zUyFHtz9vAA9FTXA9/g8HMXANdX35F17WkPw3S+/65nWBpapu9q7
	YLpxhbfD+sGqyOWvSqkB32ZsIUJQ7rKDYcbcDuRBEnt+2mp0WV7WuXNHwkMDnsEBREG99E
	yjSPIQxQF4qD4tbaZQ/O3FEwq0PNFbs=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-nSX5PU5GPbm9TQ2-iNRy8w-1; Tue, 13 Jan 2026 10:09:59 -0500
X-MC-Unique: nSX5PU5GPbm9TQ2-iNRy8w-1
X-Mimecast-MFC-AGG-ID: nSX5PU5GPbm9TQ2-iNRy8w_1768316999
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-644548b1dcfso11694168d50.3
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 07:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768316998; x=1768921798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZAAeBZ/ggGqoYtjNvmyj/ESVJlgSIndVqwIXnT1NG9o=;
        b=R8v10PSX5yrnN71yK6hNBcO9sxIetwe+2PWDCFMS2o84rf9+oCl8Lyleh8sJxTvIAU
         ll3B4Lp4o/OR6rM6IZFMIvP0otzY6WxP9eDUAmKWgDOclqUqwyLWVMh4N6Ego5yp2jit
         p7HAFtSqM4Hi7xniOkYEiK+9VKeqr6wfM6rW9yWWuv6M0Bh59INRudh09TDIeJm2WfUD
         KMCIVodcghG/l9sRruDM3W5aiK4SR5tDmFylPxjKR9zilQUqMRLfmvSRB2hlernvY71s
         oeVZ9xXYafi40hUwbQQ8w6+RjTCqUNrGW/tt7tMuBkm8KNwuAArSDdO4HovksYMzbhpF
         rNIg==
X-Forwarded-Encrypted: i=1; AJvYcCWKuo98Qcf6bUvgTUpwuzX5tDQ/8+uwkFrZdSREh6+TYYjod0BYH0vtiP/h+XKSPouTwA0WDuc+7sRrofcWIA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyo0itUyFKUkh78/rpFrd/seqF1vF+r90ACV86DsHlAuFewqsmJ
	HG4lmQRiK6ilV7FaTEXrAsgzMp5DQzOkRc0AVxHyQRfa3q34KdKswFTHKeCy58cyWWtkq9Gj3IB
	f5pxhlpDQdv78abebiqCNifLA3/A4vROsvdgxAEgLbYk+4ADyx6h8Hr/4A8yuoYrqPbQ1FWqb4x
	2nzky2Jm1VabdQs0nDKI1ww4UGRwJr+mane9eEnehbYdl/RyTBSE7djA==
X-Gm-Gg: AY/fxX7zJ6Bp3fJfgRvNnnrTRFLrIMgO49X3KUNigxhJKHC58oarOdKg4Pa++KU3nS1
	Egv2QBEHQ9m11SB15NqNbzE7dKJcGbEHdsOW8pnFSX8PjMAFq1CRWukmctIUosOdZoq+Wy1QUCM
	onp0ejUpXh4pEr9inBtX1V/ml/553O+SjdV2l+8q/1rTNWTiRztecU2gwYaMMQbm6jHQ==
X-Received: by 2002:a05:690e:188a:b0:645:5a5c:9e6e with SMTP id 956f58d0204a3-64716c38598mr21012227d50.58.1768316998372;
        Tue, 13 Jan 2026 07:09:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUQu5b372OR/WzFamLww+5ihUUPM+AKZFRRBPnbReC7DXBcecUS6o/jcoZDs3wKchzx5T+ELijxoadbsoCJVg=
X-Received: by 2002:a05:690e:188a:b0:645:5a5c:9e6e with SMTP id
 956f58d0204a3-64716c38598mr21012204d50.58.1768316997915; Tue, 13 Jan 2026
 07:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-13-eperezma@redhat.com>
 <CACGkMEvt4bK3ihn1QBn-ax7GprH91c-6-muv7jJ1-bR4fkG6=g@mail.gmail.com>
In-Reply-To: <CACGkMEvt4bK3ihn1QBn-ax7GprH91c-6-muv7jJ1-bR4fkG6=g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Jan 2026 16:09:20 +0100
X-Gm-Features: AZwV_QjAYAyd5o7f4z_hRuIUphdspTVKi06NR1fbx6XGNfT2h4vevoQgfU0BSRM
Message-ID: <CAJaqyWfE3j9B-66Bha2xAvudgWprpkLP9rjxHUkGPJhznujybw@mail.gmail.com>
Subject: Re: [PATCH v11 12/12] vduse: bump version number
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G0S68pNB2OblUaBcaSXAoFei79LeEXkR_-pfu157jlg_1768316999
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 7:25=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jan 9, 2026 at 11:25=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Finalize the series by advertising VDUSE API v1 support to userspace.
> >
> > Now that all required infrastructure for v1 (ASIDs, VQ groups,
> > update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> > features.
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 8227b5e9f3f6..5ad0ba1392f3 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -2201,7 +2201,7 @@ static long vduse_ioctl(struct file *file, unsign=
ed int cmd,
> >                         break;
> >
> >                 ret =3D -EINVAL;
> > -               if (api_version > VDUSE_API_VERSION)
> > +               if (api_version > VDUSE_API_VERSION_1)
> >                         break;
> >
> >                 ret =3D 0;
> > @@ -2268,7 +2268,7 @@ static int vduse_open(struct inode *inode, struct=
 file *file)
> >         if (!control)
> >                 return -ENOMEM;
> >
> > -       control->api_version =3D VDUSE_API_VERSION;
> > +       control->api_version =3D VDUSE_API_VERSION_1;
>
> This can break the "legacy" userspace that doesn't call VDUSE_SET_API_VER=
SION?
>
> Thanks
>

It can result in a userland visible change, yes. Protecting it for the
next version, thanks for pointing it out!

I don't think you can "break" any valid userspace VDUSE actually, the
only change the userland VDUSE can see is if calls
VDUSE_IOTLB_GET_FD2, set the vq group in VDUSE_VQ_SETUP, set the asid
in VDUSE_IOTLB_GET_INFO, or similar. In that case, the userland device
gets -ENOIOCTLCMD or -EINVAL and suddenly something "valid" happens if
the kernel applies this patch. But it is an userland visible change
anyway, so I'll protect it for the next version.

Thanks!

