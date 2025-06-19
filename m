Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51511712
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Jun 2025 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750294951; cv=none; b=DPt1SYFlL6jQc2/xtfW/ZRfZpvEFF3sg4aipeUakaBuxsj6fgQMdi7rQJocMtmM2ZI/xuuyKAkXu9dVsfoDdU/6XLnszZGm/Y73kRsDPgf3daMY2jyoFmyxeayfbxBRc05t1v5z0E48QZoQCBcaLDsPRFj3nfnbOacUNb6ZGHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750294951; c=relaxed/simple;
	bh=Gh2HTqjo6HqHISVOKNkZllB0IT8SZEBJKMzIIC1BIaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfTceDyztcFjuITrdZhBqHDPUEfxABZ9iBk0VjMgwxeXEwATs+n5rrRr+MDRSo8peUnJofeXE2I0tzQr3QdryHrCox6nBhW7aQGZJk4riBqwsG/kqMCPsib1DkXTNHfso39XPfy78ZYH2jeJloILdfkFSkvhdJvH2N4FSoIBOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OT79OqfA; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OT79OqfA"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 849DA60B8F
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Jun 2025 01:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DiMtxCjJ8OmO for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jun 2025 01:02:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CFC7060B4C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFC7060B4C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OT79OqfA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CFC7060B4C
	for <virtualization@lists.linux-foundation.org>; Thu, 19 Jun 2025 01:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750294946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l65TrwKTqa28Ab3gvX6Whw90rT+WUXHj8udnKRnKtFc=;
	b=OT79OqfApvnu1E9zTD0koX7+45EIWvIEDJKB9MCWQbJFD8NND6G9wWcEdRgW0/U/Kg2Xlp
	O7kjDreggsKMj3JCuwhj7Hx5jH6EB6/VJX4H5VpGsEWOR+ZHAuQQ5zMkAWnKuCWNHPCkhj
	z/rN9V7y8aPBCGcBQDKkKc4SGtiNrGY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-doL-_hj2NgO77_5rS8nAwQ-1; Wed, 18 Jun 2025 21:02:24 -0400
X-MC-Unique: doL-_hj2NgO77_5rS8nAwQ-1
X-Mimecast-MFC-AGG-ID: doL-_hj2NgO77_5rS8nAwQ_1750294944
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311f4f2e6baso177180a91.0
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Jun 2025 18:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750294943; x=1750899743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l65TrwKTqa28Ab3gvX6Whw90rT+WUXHj8udnKRnKtFc=;
        b=CavbXJLzxvb4M9fMU0ERKivg1kj0QR9q/HC4F+NxZSDzvenGy6Djbw7K90T7NvEh5Z
         QAlg+y4usRQdrPUCRW5D0b5ocYCZ0Abw8ryBIsxRHx1Zy7YzV5S09Qm3Kxhr+NMqa+S6
         6sqlAs4GASF1uUBop/EHJ1rq7/bM7gMMoX91DFWg7V50UzN8ZCsB2oGhH8g5dwS0HQwM
         zkNHTMYi8fwHh9IcHnbO11OXY48vqKCAzWgDgnRI2mPpF4dmEOgs/zjTVxu35AOm+xEO
         pmrkng/3EOG0yUdeARNsnocHUrFSj7u9Io933yS3J7xYFO+uAlGWAzeEMx6Qcm73ZTrX
         TNfw==
X-Forwarded-Encrypted: i=1; AJvYcCVSUNBcP3qFzQRoD6tToeFy2yfE3k5zQQTMtrQDKWSHw8nSxSy0s3GmTjsl3ZGmgYGX8cANSjJGtcX7Hc0yew==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywv7IvYEloWQLiSk4fmGEgg930JC7vGj3uj/nY9PhFrk+0vF47V
	Ow8jZ2nB7OPn9ji2regUPXKrqIjbEptLBs3UhpYC1rtD80n+1C+kwOhCO3HqMjLPA6PeDsaeUMw
	JAQUvnKS7gR0Qsyu8wCWoHAqoMTsGRO6rw1pYYmnlnwhEqn7LQfhUaQFeuHrHauSaRV5TlR/6UK
	HsASEds2zwfysNHx5v+sHyIyBgiUj+B6z4vpoX+p00MCuM95ow7NKYf0jTLw==
X-Gm-Gg: ASbGncspvPgWxD61foOpA4DL6nB+yWGpQh7RG0d7IWR1jIR84a8xKJ6YcKYnEx4v+gS
	gie/rIShB19+ZduX3Wuwc+WZgYOL5VKjgyD4jG++nutsimXgsAv1psJw0hi2iy+rORSsSER53Ow
	FK
X-Received: by 2002:a17:90b:4b07:b0:311:e358:c4af with SMTP id 98e67ed59e1d1-313f1d4e22fmr33298303a91.16.1750294943509;
        Wed, 18 Jun 2025 18:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvD1oNGfqVd8IaeRKyp0By/ZB9vOLf69wY8Wdjl95C+Bq7i6eW/n+2Kf6VIikkjjMZqqg/6jugigwoZuc6aLU=
X-Received: by 2002:a17:90b:4b07:b0:311:e358:c4af with SMTP id
 98e67ed59e1d1-313f1d4e22fmr33298246a91.16.1750294942980; Wed, 18 Jun 2025
 18:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616062922.682558-1-lulu@redhat.com> <20250616062922.682558-2-lulu@redhat.com>
 <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com>
In-Reply-To: <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Jun 2025 09:02:11 +0800
X-Gm-Features: AX0GCFsYtNF6CJUPUnvICkqbfymXVtXGjil77zAKX7_d_Qq1yhWIuFMie025ixE
Message-ID: <CACGkMEsJdfeNuHdKu0OH=sT4RYhN3d_VOnDcu4_-FquRXo24Xw@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: nicolas.dichtel@6wind.com
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rEI2wABEK-TDnYeDExDytI-sGP1aEzocOJ9M-fXl5bA_1750294944
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 8:06=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 16/06/2025 =C3=A0 08:28, Cindy Lu a =C3=A9crit :
> > This patch reintroduces kthread mode for vhost workers and provides
> > configuration to select between kthread and task worker.
> >
> > - Add 'fork_owner' parameter to vhost_dev to let users select kthread
> >   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
> >
> > - Reintroduce kthread mode support:
> >   * Bring back the original vhost_worker() implementation,
> >     and renamed to vhost_run_work_kthread_list().
> >   * Add cgroup support for the kthread
> >   * Introduce struct vhost_worker_ops:
> >     - Encapsulates create / stop / wake=E2=80=91up callbacks.
> >     - vhost_worker_create() selects the proper ops according to
> >       inherit_owner.
> >
> > - Userspace configuration interface:
> >   * New IOCTLs:
> >       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
> >         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTHRE=
AD)
> >       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
> >   * Expose module parameter 'fork_from_owner_default' to allow system
> >     administrators to configure the default mode for vhost workers
> >   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls whet=
her
> >     these IOCTLs and the parameter are available (for distros that may
> >     want to disable them)
> >
> > - The VHOST_NEW_WORKER functionality requires fork_owner to be set
> >   to true, with validation added to ensure proper configuration
> >
> > This partially reverts or improves upon:
> >   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> >   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarra=
y")
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig      |  17 +++
> >  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
> >  drivers/vhost/vhost.h      |  22 ++++
> >  include/uapi/linux/vhost.h |  29 +++++
> >  4 files changed, 294 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 020d4fbb947c..1b3602b1f8e2 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -95,4 +95,21 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >
> >         If unsure, say "N".
> >
> > +config VHOST_ENABLE_FORK_OWNER_CONTROL
> > +     bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
> > +     default n
> Why disabling this option by default?

I think we should enable this by default.

Thanks

>
> Regards,
> Nicolas
>

