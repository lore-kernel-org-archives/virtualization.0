Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB212135AA
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535530; cv=none; b=G0E+Dm6idXYh7w2VQnfpOP5l+Lz1jrZNOOewxC9Cmxhsg3599ac9qBHpodZozAogPTEWJlwc0dYqcccg7XPRSFvpZHNwrazv3aC88lJsdu+qE0D3mHfZXikXeh0ic9GX1eNbhHYBm9kfKoB0yHVU85aRb1hVI7N3j5f7jlwlNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535530; c=relaxed/simple;
	bh=JCftPQYVyvK+z4ejhkMDA1JxlGnB45HtW0/686G+fKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah9x4qpisfkbZFkydO+RkibJhE9QPItiTUUkbfFNJK9tNDfIcuoqDdE/CGwRw7dGGBXC8ybXvLBtsWlejs4pGsLvIdFC650aUd0DDZ2XG0wm8MSYBOnl+FZzozeCf5gHojj8Iyh1rS7KTUEzIRZPDFqcpPMuQXJIEX5CI+yzdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qx6+KCev; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qx6+KCev"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAB2D80E87
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 02:05:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sg4u3tZ7DjY4 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Feb 2025 02:05:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0DAB580DE8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DAB580DE8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qx6+KCev
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0DAB580DE8
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 02:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740535525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57XmEgDKKtefwUvQro1qxevSUUpBlr1i0FY1HHy6KeA=;
	b=Qx6+KCev5WvUuGAsvoNGPm3AXroILOq6/6xi3fGB4CkZrKqYbZJoDfGulR0zIxieKlXy9a
	+VeCyaN2O0hWvv5PJn3SfsZPbEQMnXI10z8nzLxVp4j8KebBgDyaXjsWEh1r0mjqyJ4UkK
	Rs1UfVJVH+fj9TrvV12Ca+f7Wzy8wrY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-3TdyBDt2PTmDvfTfvq9PEA-1; Tue, 25 Feb 2025 21:05:23 -0500
X-MC-Unique: 3TdyBDt2PTmDvfTfvq9PEA-1
X-Mimecast-MFC-AGG-ID: 3TdyBDt2PTmDvfTfvq9PEA_1740535522
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab341e14e27so622505766b.3
        for <virtualization@lists.linux-foundation.org>; Tue, 25 Feb 2025 18:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740535522; x=1741140322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57XmEgDKKtefwUvQro1qxevSUUpBlr1i0FY1HHy6KeA=;
        b=CT2t96C71ugK3GwSY7XB+7MQjEi5/NhaT8Gx3lcdmQkZ1VvLsGBrHVVaH+P80++095
         2aQz8oqby0SVBRviYz99uka4k5Yf5oLA+s559UHecRG7xE8MQxAmmm+u2xCbJUHmEB0R
         IA7D3EFfEmuzFi/40ionXXLVCUUBF+YEW4hNaGg2UeDJlCJlBrWJlNoZQoE9xhgijGOr
         4QSzCG6iq7+JTCk+GibmuN5mmVnTjSc88MRaQyG75RZlzA92zes/sRewXtuG19oAg/LF
         c+1QqBstzCk3TQhUcNj5ZmI9QMvKefpGSAQ20hyvVRd487SKbgKScplcbF0X13Y5cROK
         1OqA==
X-Forwarded-Encrypted: i=1; AJvYcCVJZTQIfKDPoX9CtUNvAdOBmVlBgOF+B1ut/z0PhvlSIz4gEXC48Rf5vFfP3+zr9ch4SUwqWsleRBTuyASNLQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxqbkOz9n/BCc5ouqQ5NMS6DhePSDgCuhBUMooIKzo3Lw8H/a7Y
	Lq8NKrNanme/rA2poGTa7wp60ljvPZ6BgL0dofXEAJoZ/xEig9dInZKJdTRJHGTZBeyPeLRZRyX
	5uW4OgdrT+ccKyrrzsghfFIKgHxK7ZlQAytM3rLZUDCjspWEMd6yXTDbk6ThWl+HgDx3/lHYf0z
	p2fNxW6lmt4qPRuaMynTzpZGK7KQEln5L1txQH3j5damyqPSMXB1kAUg==
X-Gm-Gg: ASbGnctyod5LWvJqQu7aSSZ3Uicf/MS/SD1RmLVv7MPgwB7poFO8vj+QtGcWFkU1uTT
	JFh0x3O4zUa3GlHnjRPjOtSeIYzwX02PXhvI+89Jlp9RH14Ziqlxh3oe3ILCbbyuARumGhp5jzA
	==
X-Received: by 2002:a17:906:6a18:b0:ab6:d6c3:f1e2 with SMTP id a640c23a62f3a-abed101a68emr584728566b.38.1740535522486;
        Tue, 25 Feb 2025 18:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDnpl2j+0DavpNWZdYT5Z/FgRyn64TInVqaEucZU+lYsdoJPEs6pdWR0j3CR6bsT3Arc59/ceBLEEvkVFCxxI=
X-Received: by 2002:a17:906:6a18:b0:ab6:d6c3:f1e2 with SMTP id
 a640c23a62f3a-abed101a68emr584726366b.38.1740535522087; Tue, 25 Feb 2025
 18:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250224164233-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250224164233-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 10:04:44 +0800
X-Gm-Features: AQ5f1JqiQ7lr3YyNb7nTi5Z3YzGts4m-JzTljklxhrdzE-njba0nKckam0rKUMM
Message-ID: <CACLfguVo+04seP-hmbVjzKBVk4XfXcPvtRsuHOiiMUn7fzJB8g@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J4FjNesKoe4pMx835tMSA6Y12OqWciAOhfLaI0ZgSAo_1740535522
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:43=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Feb 23, 2025 at 11:36:15PM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > the vhost now uses vhost_task and operates as a child of the
> > owner thread. This aligns with containerization principles.
> > However, this change has caused confusion for some legacy
> > userspace applications. Therefore, we are reintroducing
> > support for the kthread API.
>
>
> This looks good to me.
>
> Pls address Jason's comments and add a Kconfig knob, and I will apply/
>
Thank you MST, I will add this
thanks
Cindy
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
> >
> > Changelog v2:
> >  1. Change the module_param's name to enforce_inherit_owner, and the de=
fault value is true.
> >  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
> >
> > Changelog v3:
> >  1. Change the module_param's name to inherit_owner_default, and the de=
fault value is true.
> >  2. Add a structure for task function; the worker will select a differe=
nt mode based on the value inherit_owner.
> >  3. device will have their own inherit_owner in struct vhost_dev
> >  4. Address other comments
> >
> > Changelog v4:
> >  1. remove the module_param, only keep the UAPI
> >  2. remove the structure for task function; change to use the function =
pointer in vhost_worker
> >  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
> >  4. Address other comments
> >
> > Changelog v5:
> >  1. Change wakeup and stop function pointers in struct vhost_worker to =
void.
> >  2. merging patches 4, 5, 6 in a single patch
> >  3. Fix spelling issues and address other comments.
> >
> > Changelog v6:
> >  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
> >  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FR=
OM_OWNER
> >  3. reuse the function __vhost_worker_flush
> >  4. use a ops sturct to support worker relates function
> >  5. reset the value of inherit_owner in vhost_dev_reset_owner
> >
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (6):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Reintroduce vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: introduce worker ops to support multiple thread models
> >   vhost: Add new UAPI to support change to task mode
> >   vhost: Add check for inherit_owner status
> >
> >  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h      |  13 +++
> >  include/uapi/linux/vhost.h |  18 +++
> >  3 files changed, 234 insertions(+), 24 deletions(-)
> >
> > --
> > 2.45.0
>

