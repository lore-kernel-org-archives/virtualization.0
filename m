Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8A29B8DB
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414410; cv=none; b=a2GyFMBygc5hgOUUNpi0DOGagTBA42XPfJEeNMelxbg+TdKw5tfWLj0Pqa+As2GJtCZCP/+BysurL+ORWc8oswwSZUM/3LYa6Q2LASmAxY84VOYCh3x5PPYQeZhQ0vwzp3ZGyciIqc3IZHifoVzn0h+taPCPhYK9fhoZYZ+kLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414410; c=relaxed/simple;
	bh=Z6rDoDbBzZehN05laYqSOz5TF+zWduNfgDpGobbtTm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqtrMLtd6npYgiFn+Q0Ep9HlYVwA3AZ1sx2Vhue716W3OcQDTL4CMrTwqJpnMwog+8j2tC//poEjyljQOAlxG5vE1Bi0RMmWFXEfaQTaGDEBSqiEHQBkcCUeohQkJ3yjlGKcg2Tjg7K+LxmlUE0Sd/MUq6te6Ifs2xINkZFvh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOQ7qcUg; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOQ7qcUg"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E701411E5
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0qxXmrJWEuV for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Nov 2025 07:33:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E619D4111B
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E619D4111B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iOQ7qcUg
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E619D4111B
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 07:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762414405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYAde5e7XRo2nCFdsgkjpp8tUcZhDMLUB3jHCGqkjtg=;
	b=iOQ7qcUgR97zNz+PCohNQW93bGReZDuyBye0SwfKzLHvAREC34u4E9HUyucltYFd6aUm9Q
	G3MhmT47izEwxQ7AcpjSf3vsspT+u0DXJntfsOLDd8B1GLiv/F1PK31UTxPYvN5flatzP9
	1A7/LZ1ZbsLp3QxOh4l/6QajrzumzEk=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-Y6cGs3uCMXuFHJXqg4amhQ-1; Thu, 06 Nov 2025 02:33:24 -0500
X-MC-Unique: Y6cGs3uCMXuFHJXqg4amhQ-1
X-Mimecast-MFC-AGG-ID: Y6cGs3uCMXuFHJXqg4amhQ_1762414404
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5dd83dae672so199170137.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Nov 2025 23:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762414404; x=1763019204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYAde5e7XRo2nCFdsgkjpp8tUcZhDMLUB3jHCGqkjtg=;
        b=sMebYQD4XOL1CWkHtl0yAWokiRouUNA7FkzvBR/48+hR+Uw2p8zzkKtfxXxU4D3tUO
         OS9kau8bhQ97dOTWpIc6/ffd6pNKtiCldXTt7j7R3oyqdN/g7hu335Lu4QFz55txnw52
         Khtv1nNhEBd8p1OlpuOIFUHTTlfXJsKaU1eu00gmU1gl4821ZY5Sul5TBvos3Tbz4Gpe
         i5sgml/AvmENd9nmqVkTUsdokANvKB4Ukeu2O2mycIdObuF1BBxkLg+LuaihWqzw8qm+
         nkwTe3/bA/lSaJMyIr6BoCbnPoL5zQnaPAA/drjtP6mZpxP1HwD5qxi99wYDpMePQFRB
         fGLw==
X-Forwarded-Encrypted: i=1; AJvYcCUsJ11zoPs/tvI3v11EuChD+eoP9YjVXSWPOMFZzNn/XDD57aDjzq7bj3L8CSA2dGSDe3M0lvbfD1mDQ6ngMQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxrLA7Noj3LDJser+zlWkNt9Q1Acfj8jlsSxHtTar3X/M05rxFb
	8vkTQPP/ybJGCY/pkDf0POGyc0cpBEKCBoM6mdtyVXSC8XBkEd/4OI2K2t4sHVpJLkQmhQNxPF8
	GGNgXYMGcvbw+wgx9FFkRj8IIH3vj22GdArdIKDt/OZuaBsgEkKfsRuO8P05gkn+fbJbZAl7+pc
	stqwy6XFG7zhjKiAkkdIWy0LBB7Zf5PVfsvt/fjzX8WF3lIHLGQFuRvT93ig==
X-Gm-Gg: ASbGncvoAusEehwDJ3zl4rRGxacC8A7AY4HjxUPuHlvRfS+wmmXJUL22Rl9hh7VMXkA
	8WHaFDns9xeGvT6KdNoOKi/ICtTUmnGz1N33dRUTLbwlwKMb+Bc7dRblq0gHugdxjXXtSJfQn3P
	wH/7qzscfH33EB2EC1eJ6pt0SdCdJVGyT3tKNJNTLL0SgHugHAjj7D+cDT
X-Received: by 2002:a05:6102:3053:b0:5db:d07c:218d with SMTP id ada2fe7eead31-5dd9fdb4d0fmr879048137.15.1762414403865;
        Wed, 05 Nov 2025 23:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfgJ5v70iJc90m1C5a8kGqaC50su+K78cw6ZlEPzjU2+a4nohKdaZgEJEwG3WrJX689N8V+NwxJorp4vWreDI=
X-Received: by 2002:a05:6102:3053:b0:5db:d07c:218d with SMTP id
 ada2fe7eead31-5dd9fdb4d0fmr879040137.15.1762414403476; Wed, 05 Nov 2025
 23:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <miwqc3uxmvvs5efvcqv7s4boajxjgko2ecqkyeqk62e4pwjexa@qi24ta7rftx6>
In-Reply-To: <miwqc3uxmvvs5efvcqv7s4boajxjgko2ecqkyeqk62e4pwjexa@qi24ta7rftx6>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 6 Nov 2025 15:32:42 +0800
X-Gm-Features: AWmQ_bnoiY8Gk32PJh58YA8qenD4YokFKdcWQ14qjx3RkyIPx105xiGyaIgP11w
Message-ID: <CACLfguWr37_OON9f7T3=tu87Fp1ZDm2gKxREikAUCnD8+McVvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state check
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BD8riPYbGP4BQMt24Qow7P8EnsmoTEq--WTNeYsS25Y_1762414404
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

whie

On Wed, Nov 5, 2025 at 6:03=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> Thanks for your patches!
>
> On Wed, Nov 05, 2025 at 04:01:41PM +0800, Cindy Lu wrote:
> > Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> > feature bit is properly set only when the device is not yet in
> > the DRIVER_OK (running) state.
> >
> > This makes the MAC address visible in the output of:
> >
> >  vdpa dev config show -jp
> >
> > when the device is created without an initial MAC address.
> >
> So when the random MAC address is assigned it is not currently shown?
> I don't fully understand the motivation.
>
Yes, when the device was created without a MAC address, the
VIRTIO_NET_F_MAC bit wasn=E2=80=99t set during dev_add, so it wasn=E2=80=99=
t
displayed. At this time the mac address is 0. I think we can remove
the VIRTIO_NET_F_MAC bit check when showing it.
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 82034efb74fc..e38aa3a335fc 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_d=
ev *v_mdev, struct vdpa_device *
> >       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >       mdev =3D mvdev->mdev;
> >       config =3D &ndev->config;
>
> > +     if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +             ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC);
> > +     } else {
> > +             mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\=
n");
> > +             return err;
> The err is EOPNOTSUPP. Is this the right error?
will fix this
>
> > +     }
> >
> Why is this block not under the reslock?
>
will fix this
> Thanks,
> Dragos
>

