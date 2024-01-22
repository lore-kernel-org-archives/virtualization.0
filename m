Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A453A1BE
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920484; cv=none; b=ZTeg6A7N6Eh/c6CKOYOLCqygRbcfcAkncltiwTBngAsGv500mqUwsvYat9b2+bm+N/s1MJYZn9icYC2t07PTxzMuMKGSG/S8GxgNT5NddAwjLuq69eRVz92gC3PW9AHRNa7chdrISyBkQdJ7ga7ll4AxaMsFI8nndqFf4qa6fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920484; c=relaxed/simple;
	bh=UMEPrzsFfMwcLb6gpEQxDtl8Y3dVJdxWPuxxS76bS/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdeDdfUq5TUnMYl3WAVqZlZstuX/lbnqbF3KZRyssHk5nNH1XhuWJKJoIbGcK2CtF/tnLsn3ZEffxHHJIusDAwLgcrDbHcaam9PSwT7JXrxTGa+fMcUxfPQ1wmJ1Sg/KTR6Z9XSV5NUGaDqTHzcn+vorKkp/ODbUcLyJAPkCYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3XRLw8Y; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3XRLw8Y"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59F5660DFE
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:48:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59F5660DFE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K3XRLw8Y
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pvXSu1gKukO2
	for <virtualization@lists.linux-foundation.org>;
	Mon, 22 Jan 2024 10:48:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 883536076C
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 10:48:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 883536076C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705920481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAQacrX86fqUD9K4Yvf7W+7v6QcN6oGZap2bo4/kXUo=;
	b=K3XRLw8YZNLLDxpHjZ0hPoTtI6u1PcTM1TjXlrmaarRrMWkF0ndVvgSEdy4iWrLSHdAAB7
	QJvL5f1PNk72xQ1yh0JOWfT3SVM+Xbkm1kdGgaii6cb4muO2cRnmxZqTWZml4ct3JKQYgV
	D7LB00FjwwnA9aiSQw1RwY4H7ZLAkQI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-EXr4Ar5gOyG4Wat4zUvoOg-1; Mon, 22 Jan 2024 05:47:59 -0500
X-MC-Unique: EXr4Ar5gOyG4Wat4zUvoOg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5fface2c4afso17116877b3.0
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Jan 2024 02:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920479; x=1706525279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAQacrX86fqUD9K4Yvf7W+7v6QcN6oGZap2bo4/kXUo=;
        b=YMOfhsZ2ac8f8syG7SzjOnDI/GGY9bBar3gaeOVekNXJCH7tOfqZe9VbFL0fc/8+6A
         t4AyxmEX5Ymc4Awqw9kMlpFl2pNNWcrruf7HhR7N/VDdyS7GyAXp0AIUki+9tZuOXcQ4
         lGDlldvnhdpNx2e77UZJwvZOIoY72i/BtTw+3qDlJecaj2uZB/4jFoQIl+vuEC0t9FAg
         bj+BOxtbdjxVG3WSEudWu/hGJMeTnTRR3kMlvAg+GQrZj3O/RhS0qHboNQvf81QufE9Z
         eTEmlt53Cp+rFGqvn6/azUL8T6i7CIg1AprKXG4ujd7d4rMv9QJ/JRtWGxlJ26UvOuOp
         3S6g==
X-Gm-Message-State: AOJu0YyU5cTA+1IMRlhBxh43TwECW8vNLDmH88Vld03FjBSaJQWRmeLB
	P/ZB7IUNuz7FQEdF8GR7aF2dPyANvUbi7ZIQDF4ntWdKEH+6i1nby2TzTwi5iFYnewpl/EisR9B
	2QNFVsWckt/I5iZ43eHKO9oPDI1CmMWLbH8YdrWNfT2uD/MChgDI2WztrK6iD1MyeotEy0LCjju
	45sRgNeoo+qZQZLneAiQKY5GHxCSljcs2Z61cPrKxumQxhKMtj8wRlTA==
X-Received: by 2002:a0d:dbd5:0:b0:5ff:956d:8b7f with SMTP id d204-20020a0ddbd5000000b005ff956d8b7fmr3052788ywe.10.1705920479009;
        Mon, 22 Jan 2024 02:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL9kWBkFrWysbj41gcH1s65ao+SK2QQzY/6YTjr57S5jDjOuIcHyA9BD2Aa+0IG0Ml8khImO/AtDyOFc4vg/0=
X-Received: by 2002:a0d:dbd5:0:b0:5ff:956d:8b7f with SMTP id
 d204-20020a0ddbd5000000b005ff956d8b7fmr3052778ywe.10.1705920478772; Mon, 22
 Jan 2024 02:47:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1705519403-255169-1-git-send-email-steven.sistare@oracle.com> <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
In-Reply-To: <mhnsrwlvqjeftu5aa77iaowdk2wrq366yofjchbn5fwchgcbna@kcjtoj46fawi>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 22 Jan 2024 11:47:22 +0100
Message-ID: <CAJaqyWcLj7Y0rm3_jdfP8KgS4gkE9ns286XJywBGE0iijMireQ@mail.gmail.com>
Subject: Re: [PATCH V1] vdpa_sim: reset must not run
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:22=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Wed, Jan 17, 2024 at 11:23:23AM -0800, Steve Sistare wrote:
> >vdpasim_do_reset sets running to true, which is wrong, as it allows
> >vdpasim_kick_vq to post work requests before the device has been
> >configured.  To fix, do not set running until VIRTIO_CONFIG_S_FEATURES_O=
K
> >is set.
> >
> >Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
> >Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >---
> > drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vd=
pa_sim.c
> >index be2925d0d283..6304cb0b4770 100644
> >--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> >@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim=
, u32 flags)
> >               }
> >       }
> >
> >-      vdpasim->running =3D true;
> >+      vdpasim->running =3D false;
> >       spin_unlock(&vdpasim->iommu_lock);
> >
> >       vdpasim->features =3D 0;
> >@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *v=
dpa, u8 status)
> >
> >       mutex_lock(&vdpasim->mutex);
> >       vdpasim->status =3D status;
> >+      vdpasim->running =3D (status & VIRTIO_CONFIG_S_FEATURES_OK) !=3D =
0;
> >       mutex_unlock(&vdpasim->mutex);
>
> Should we do something similar also in vdpasim_resume() ?
>
> I mean something like this:
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index be2925d0d283..55e4633d5442 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -520,7 +520,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
>          int i;
>
>          mutex_lock(&vdpasim->mutex);
> -       vdpasim->running =3D true;
> +       vdpasim->running =3D (vdpasim->status & VIRTIO_CONFIG_S_FEATURES_=
OK) !=3D 0;
>
>          if (vdpasim->pending_kick) {
>                  /* Process pending descriptors */
>
> Thanks,
> Stefano
>

The suspend and resume operation should not be called before
DRIVER_OK, so maybe we should add that protection at
drivers/vhost/vdpa.c actually?

Thanks!

