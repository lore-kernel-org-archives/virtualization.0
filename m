Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612D1DED5B
	for <virtualization@lists.linux-foundation.org>; Fri, 11 Jul 2025 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216571; cv=none; b=qpJ6zKV9SA9iAfajeElN6Tuvs9RUueL1mheEkgQWbzEU0FkmGqIQLPd5TSBZ9AKn8tubBnBi16y6+cgM12ChzZ23GoYbYxl8CJHjLcjoGuOlJ0T2wmIc9I9Lq0W6Fwyy8tC8FL1LpJvXBGw5syBwIyrCF67NlHVoAG+jX7y1Ut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216571; c=relaxed/simple;
	bh=8WjKZo/Tzc+89ScV1HU0cXSdTevhkck7mFPn4y7/ZAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAvhEEHxHHlQSUW/G+W0GFhA1dJLaH7Xmzkhe0hmSbVx1bKolbASiUdY0c4BjOPv0hGen4isV+NrVoCb/Bb8yEJGxIzIMluNfW1mOAiOhjf8NxWHpCNXnbQCCnjzvnhZtjVOplTHw/cx3c3CHzYuOph4750U6IhdsZwCVYbYRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVwHIZcs; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVwHIZcs"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 340CC61423
	for <virtualization@lists.linux-foundation.org>; Fri, 11 Jul 2025 06:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZOUaJhqBuXz for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jul 2025 06:49:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 79A8B610A8
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79A8B610A8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVwHIZcs
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79A8B610A8
	for <virtualization@lists.linux-foundation.org>; Fri, 11 Jul 2025 06:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752216568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxbG4JFSAtZVQEjQXI+wWXnxQA/cXn+OA4Z+OMpKyu4=;
	b=eVwHIZcs41r3nSKwXtY2urVZWC32sMykNziXDwhZMqgd62IfG57Gb7yDAfaVUdu015kJG2
	uizJr+mQMhlJ24nlXXDQduN2RspglplpGWmLV9CkRmPy37xnQl3DXwz+ka9rlm/SYaLUdY
	/wd3xHGwIkkGLSvbPg/jYmBpmuhLym8=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-i74RjoRJPcajskJT8pO1JQ-1; Fri, 11 Jul 2025 02:49:27 -0400
X-MC-Unique: i74RjoRJPcajskJT8pO1JQ-1
X-Mimecast-MFC-AGG-ID: i74RjoRJPcajskJT8pO1JQ_1752216566
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5315999c994so615691e0c.2
        for <virtualization@lists.linux-foundation.org>; Thu, 10 Jul 2025 23:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752216566; x=1752821366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxbG4JFSAtZVQEjQXI+wWXnxQA/cXn+OA4Z+OMpKyu4=;
        b=w4Nn4Ftw+E9g5et8Ij72HoUhF4mM0MO8gVJKnH7APOQz6M+gHXw8LZ6AkbZSD+HyLY
         DsuuxhjwGc+OfjWAT56ap4EI8cHJDwV9aQ7tJyI3iYsEiTmag/ryo3vwo3JoAtwN67PR
         Wi0qCkOav0iYFrHRs3N7X+Ydh8pNOSQH2+YnAPCsWunv1/7YVq/KxbRrg/mCuEK0c05I
         CHxuxiuRXsZ+s4PTiux7sSFJpEZeCXzMrqWeVIO5bRbRgV+EfsuLEsoaZxwQQd5wDGiV
         Yb5MX60Y3jr6LPdWqnQ0DRrctN06+5lF+NUaVPzLCvy1sio1NcSWsJS2DH0WUxgsiShP
         zEKA==
X-Forwarded-Encrypted: i=1; AJvYcCVjwRQCpWHXIzhg4Wn429rufMyx257tAWG8TbDP5QRi9Rb32B8x4zUl4RiwG0S7xJCFExD4R/egmUXzrJvQ9w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxJpnnIhC+JVJEo1GcoevWbFl3quB/Rvz5MAUl9r7hJsCA+Vd/P
	Z/inMDgW6MENwJw5HUPym44P9qEwapjIPVFTFnmVz2I3Y4sYaZycZt0JuG5Zwx+PEJxnhfxPCT8
	8Ic4O3jdLWwC6qv0REO8h5IXGtQDS/ULobEBqhrVVrxH2CTLpkaJ+PN7cSJCdrV00BJ+o6tKkZE
	Xqerm5frOP4YFoq0pG9hBqPfCDPN9RGFDO3Yy4nA/fDEDfhyiOxLGojE0ouQ==
X-Gm-Gg: ASbGncuVo9z4Fs2umhqXvYTqIVRr6XkMA7C81NibZ5MjjsbMgsKCNTg27BQAhvNNZJY
	+O/Q4CKx3t2wwc3NthcHMbukpz2zbhNKKQZL0+kON55hwahDyOHMTEvWn5IbgCC5d23L7/Q+sP4
	k0h1IS7sfj5FbfTtDCBkgwaA==
X-Received: by 2002:a05:6102:dca:b0:4e9:c773:dca1 with SMTP id ada2fe7eead31-4f6411e36c2mr1621590137.11.1752216566330;
        Thu, 10 Jul 2025 23:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8pdr64dQhCGFiGndp3QqJ4OXoQVOVXjcmO3HV7h3AAPJDmNsRuoLhWIcxZByOZsvaufxvkGWZod21F8kL+T8=
X-Received: by 2002:a05:6102:dca:b0:4e9:c773:dca1 with SMTP id
 ada2fe7eead31-4f6411e36c2mr1621586137.11.1752216565960; Thu, 10 Jul 2025
 23:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616062922.682558-1-lulu@redhat.com> <20250616062922.682558-2-lulu@redhat.com>
 <6107dcb2-51a3-42f8-b856-f443c0e2a60d@6wind.com> <CACGkMEsJdfeNuHdKu0OH=sT4RYhN3d_VOnDcu4_-FquRXo24Xw@mail.gmail.com>
In-Reply-To: <CACGkMEsJdfeNuHdKu0OH=sT4RYhN3d_VOnDcu4_-FquRXo24Xw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 11 Jul 2025 14:48:12 +0800
X-Gm-Features: Ac12FXxIsX9kCA8tu7rmOHAy5cYEuocqulMU9XdacIEoFSZMPVCORVJXY4Z54Eo
Message-ID: <CACLfguWqF62MMY3Y45GCRnh=5J75q6ebAqhFgOmhsAAsoyYXew@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] vhost: Reintroduces support of kthread API and
 adds mode selection
To: Jason Wang <jasowang@redhat.com>
Cc: nicolas.dichtel@6wind.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qp65SrTHtpsO-T-tbfWDftOCZOIAXz7Z2MuCcTiLh78_1752216566
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:02=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jun 18, 2025 at 8:06=E2=80=AFPM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
> >
> > Le 16/06/2025 =C3=A0 08:28, Cindy Lu a =C3=A9crit :
> > > This patch reintroduces kthread mode for vhost workers and provides
> > > configuration to select between kthread and task worker.
> > >
> > > - Add 'fork_owner' parameter to vhost_dev to let users select kthread
> > >   or task mode. Default mode is task mode(VHOST_FORK_OWNER_TASK).
> > >
> > > - Reintroduce kthread mode support:
> > >   * Bring back the original vhost_worker() implementation,
> > >     and renamed to vhost_run_work_kthread_list().
> > >   * Add cgroup support for the kthread
> > >   * Introduce struct vhost_worker_ops:
> > >     - Encapsulates create / stop / wake=E2=80=91up callbacks.
> > >     - vhost_worker_create() selects the proper ops according to
> > >       inherit_owner.
> > >
> > > - Userspace configuration interface:
> > >   * New IOCTLs:
> > >       - VHOST_SET_FORK_FROM_OWNER lets userspace select task mode
> > >         (VHOST_FORK_OWNER_TASK) or kthread mode (VHOST_FORK_OWNER_KTH=
READ)
> > >       - VHOST_GET_FORK_FROM_OWNER reads the current worker mode
> > >   * Expose module parameter 'fork_from_owner_default' to allow system
> > >     administrators to configure the default mode for vhost workers
> > >   * Kconfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL controls wh=
ether
> > >     these IOCTLs and the parameter are available (for distros that ma=
y
> > >     want to disable them)
> > >
> > > - The VHOST_NEW_WORKER functionality requires fork_owner to be set
> > >   to true, with validation added to ensure proper configuration
> > >
> > > This partially reverts or improves upon:
> > >   commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > >   commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xar=
ray")
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/Kconfig      |  17 +++
> > >  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++-=
--
> > >  drivers/vhost/vhost.h      |  22 ++++
> > >  include/uapi/linux/vhost.h |  29 +++++
> > >  4 files changed, 294 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index 020d4fbb947c..1b3602b1f8e2 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -95,4 +95,21 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > >
> > >         If unsure, say "N".
> > >
> > > +config VHOST_ENABLE_FORK_OWNER_CONTROL
> > > +     bool "Enable VHOST_ENABLE_FORK_OWNER_CONTROL"
> > > +     default n
> > Why disabling this option by default?
>
> I think we should enable this by default.
>
> Thanks
>
Thanks jason,  I will send  a new version
Thanks
cindy
> >
> > Regards,
> > Nicolas
> >
>

