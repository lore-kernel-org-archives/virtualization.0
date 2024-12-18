Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAF17DFE3
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511039; cv=none; b=DkQEil6vDfVNnm8Kni1OWW4NaqAmmuFEPAcCD6PM/xumziMy2gFECWxZgTmg260Ejwe71EL82tpBQAHhuqdZJBNY3wyhNBL5ugFFTu3YaIYOy6GXV8F+Msm+c+Qw0qqtEX9pmbKvgWZHke6ys8o182PG4VXWCubkhjkyfYUBjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511039; c=relaxed/simple;
	bh=KdNSPTYzI0yXRPOSxU2NZR4f+TDNEOZLE396GR9IUio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUbOnmcG5phJ3l9YkeyHv5IFuD18pJ//xrOh0kmT6wn3nrndnm/LWuum0QLb+Q5KmQewckpETejYqTjNbNBNoLLU+2Rd76WBhXTL7QBxDOTGkOj9z/11I/LmadFF1yR0nqGa1PwTxhm960sgpGXX2ypURW1mgs8ZayzAPuODJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gFHXCwZC; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFHXCwZC"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B994613F8
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vu9kG_2M6Sp6 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Dec 2024 08:37:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9E23D606F4
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E23D606F4
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gFHXCwZC
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E23D606F4
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734511034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GS4RlJkSlafscPifZWZnqyNOXWHjYSJdsZMAPTjf4Xg=;
	b=gFHXCwZC6d+os9litCKmuGxIq1OysxKJpIhZw+Q2h6OnEYDzYiqbZi93KY/8HCnjwT85Tf
	Ahd56vdnKBfebDowEWVdkpzs9qgtTqjSO0tfmKudFfz7APoPE6gltrLWjn12gN+xEc29s0
	KrBG8+x03BUh5JUAVSwyL550z2Xgnqo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-vszeBIFsOmKfdYFDInsJ6g-1; Wed, 18 Dec 2024 03:37:10 -0500
X-MC-Unique: vszeBIFsOmKfdYFDInsJ6g-1
X-Mimecast-MFC-AGG-ID: vszeBIFsOmKfdYFDInsJ6g
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa67f03ca86so451905166b.2
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Dec 2024 00:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511029; x=1735115829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GS4RlJkSlafscPifZWZnqyNOXWHjYSJdsZMAPTjf4Xg=;
        b=QSNCccgDJMp5AYRyLZdmD1IME7qibKHOjJuTOfPOPLRlRRTgUy74Vw0rF0HXsoc3TZ
         IU4pgWippCQZXGY4ZBpychGehAXTVeanFCP2z5LOZaemvRZ9OM5Nx/sFDM0g6B8aLSq8
         6Br40T4DtnrR5BXn3onw6Khpt1JnTe8fmCOIJv1QkaKuQCXMl+cC/k+cXsRmyy2ebXIv
         BeqzEN9sjQSrYlPUoKEYdm4BGRdfl47UcHQUFq5V+T/SaDHX2JaqfGagZuese3cwEa2O
         cImaxugjBKtXzhL0To4ptEeGn9z0EM6L7GQGsSnI82EYX4FxeaW8AWVBBypljc90xPkx
         OEbg==
X-Forwarded-Encrypted: i=1; AJvYcCXIYz6zdB0odD/omlpGLloKHyEOV884lEfK0UF156d/h+romyZi5LEKeNj5lu/ry/gVQ87uWgaUvRZRndP5Ow==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxLl0rcXUvQlXbqemV9wTGjLz/VONUXunbQViWQwMbIEcVEvdSG
	OfHvTnXQTK/BNbGp+85Nn/d7FZMEQbf/Ls7BklZz05pm2d9Mt66lFNQK8/dsKfnk5YaOBGQgfGs
	zjCGdFPkbDPVa117ix+0vF/cjeEjPnG60kvIRNB8HJDE4DWBPPWnisHl9sukpHwPS6UjzXdttH4
	Ova7XiiSpbRmRU+0724FCyF1CkrZ/kzv6TVsFec2Y1ysFQlhLCRigKqg==
X-Gm-Gg: ASbGncv1c3U7kNr2A2VNgraVTCh/Ig6agfU/ybFPZw+EeKcl2+WrLOb6yCHPLg+WnAV
	72dt02kocddLRiYtFSbkxo2a7J+zCsL/+UT3ycT8=
X-Received: by 2002:a05:6402:34cb:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5d7ee3b57ddmr5014753a12.17.1734511029518;
        Wed, 18 Dec 2024 00:37:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsTO9d3Y4gBzRKxIZ2rqQKa8yVFxcJFzH6jsY0ql4eXDtA+BSmNxlStP+pIpwj1SFopfPZm0RqzKTnvpwlDD0=
X-Received: by 2002:a05:6402:34cb:b0:5d0:c697:1f02 with SMTP id
 4fb4d7f45d1cf-5d7ee3b57ddmr5014697a12.17.1734511029163; Wed, 18 Dec 2024
 00:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-2-lulu@redhat.com>
 <urth32zhvjesd7pjgy4rzbkbddtvxbmevfjid5vebfak2bd2ae@izvzeo5mk2s6>
In-Reply-To: <urth32zhvjesd7pjgy4rzbkbddtvxbmevfjid5vebfak2bd2ae@izvzeo5mk2s6>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 18 Dec 2024 16:36:30 +0800
Message-ID: <CACLfguVbD_eti13-yVezT-z5Hy=U5FVNwmDO4ogVY657EYv4DA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] vhost: Add a new parameter in vhost_dev to allow
 user select kthread
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7T7vOSi4M-kHR_hZeVYEihjbietqjCqVc6AnLDP6eKk_1734511029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:52=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:41:40AM +0800, Cindy Lu wrote:
> >The vhost now uses vhost_task and workers as a child of the owner thread=
.
> >While this aligns with containerization principles,it confuses some lega=
cy
>
> nit: missing space in "principles,it"
>
Thanks Stefano, will fix this
> >userspace app, Therefore, we are reintroducing kthread API support.
>
> nit: "app, therefore" or "app. Therefore"
>
sure, will fix this
> >
> >Introduce a new parameter to enable users to choose between
> >kthread and task mode.
> >
> >Signed-off-by: Cindy Lu <lulu@redhat.com>
> >---
> > drivers/vhost/vhost.c | 1 +
> > drivers/vhost/vhost.h | 1 +
> > 2 files changed, 2 insertions(+)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 9ac25d08f473..eaddbd39c29b 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -552,6 +552,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> >       dev->byte_weight =3D byte_weight;
> >       dev->use_worker =3D use_worker;
> >       dev->msg_handler =3D msg_handler;
> >+      dev->inherit_owner =3D true;
> >       init_waitqueue_head(&dev->wait);
> >       INIT_LIST_HEAD(&dev->read_list);
> >       INIT_LIST_HEAD(&dev->pending_list);
> >diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> >index bb75a292d50c..c650c4506c70 100644
> >--- a/drivers/vhost/vhost.h
> >+++ b/drivers/vhost/vhost.h
> >@@ -176,6 +176,7 @@ struct vhost_dev {
> >       int byte_weight;
> >       struct xarray worker_xa;
> >       bool use_worker;
> >+      bool inherit_owner;
> >       int (*msg_handler)(struct vhost_dev *dev, u32 asid,
> >                          struct vhost_iotlb_msg *msg);
> > };
> >--
> >2.45.0
> >
>

