Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CF192B89
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743140625; cv=none; b=CKzIFUh31fU+1KhH+gzZ3WRBXf+W/oroBBW8EwY7DdyGflfEX+Vg//XOxYYf2k5ktGaS3I8XPeE9ESq4krpnU90ozOsd2TQh7o/FpTb2EtBtaPWSDOkFDn7wWjznCUcUBF6K5QeYEVsnWVU/a1IoQD4HSpdXIQlA0vIor19ioFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743140625; c=relaxed/simple;
	bh=R1Cd1RWDi2fBuC1OYcPiJgOwZpJZ3ikPbq83P1CyQQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHQUCzLDE/8RQGzEMY2X7hOj24nMHo8/kwUW37uKAGUZj8jfCdGRTfQGRQbTzSq1qvXP7imcJI2wu3LtBFwr2EOveFB3mXpFI9xkNP1tbNFLWJeeQbWI7nhQSobHrP/NKVEKDbPNLaSSGONzNoQJ4sDOLT1msjYbdITVjin09PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkYyCOJu; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkYyCOJu"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B04B6072B
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZnLZF5-A1te3 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 05:43:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6AE76606B3
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AE76606B3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YkYyCOJu
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6AE76606B3
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 05:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743140620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wksMuYw/9GpKsbd4SKNGSlHUTKX13CwUN+KU7W5lxQ=;
	b=YkYyCOJuua6pYYFr09xvoddx9NeXC/CqNy4blUnniMK8vC5XUIl6VeMhE64fvYpMOIPqac
	gBIrGp51gER0m41iYO/Ao8fBafxssqUxMvcyBv+udwUjZBnvMIFJ9iO7+sH0+5uG33cL0R
	eOdS7kV+Ng8lZtDqUt5EiRZxTU9Wyhs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-Vpe2XCLLOSSuqkdnexQDFQ-1; Fri, 28 Mar 2025 01:43:39 -0400
X-MC-Unique: Vpe2XCLLOSSuqkdnexQDFQ-1
X-Mimecast-MFC-AGG-ID: Vpe2XCLLOSSuqkdnexQDFQ_1743140618
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab397fff5a3so179268166b.1
        for <virtualization@lists.linux-foundation.org>; Thu, 27 Mar 2025 22:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743140618; x=1743745418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wksMuYw/9GpKsbd4SKNGSlHUTKX13CwUN+KU7W5lxQ=;
        b=dmFAdqBXOhYwGclFZ9Imowh7hEXlyTPns+yPq7KIv/CT6n7vL7Eu4w1zhyluzk8LVw
         /NxxjvJUaQKRp6+3q8l4AzIwXqP4T6Nd5S5aKW0ddwDiWFxWV8WhmkQEyKCT2c7+LKVD
         2rRAuoR7EL/BS6xi4PYRi65J09UgHruWpWpPRHHvIZsyXxIWKKUM3FC4S3PD/rXNpCDo
         2Clnn1We6mR6xigzryxGoSWw5/Sj5qJmvHvDABHIn9DbR2wgC74JnpZKUbALVW5zxgdz
         z2BAs2L2QBeu4ibHgtDc1GLlvHthkHB0CJyICj92He1yVjY8nM187LrtGY7S+7gMI8mD
         6CBA==
X-Forwarded-Encrypted: i=1; AJvYcCXd9Fi2vJSp3skMHjdTmdOfpseH9xj/sqJnJI03wGRLhfEUdaOg7FMJlrqYrXNLTVYRp9TykWT5tA80umxrhg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzuNZyImSqfxsiqULsGU8rCyu6EtjBMc5ksb5CxBI6YAkaSCh8D
	oKGF7qq2tG2cViuz/wFY5aLJIIFErcp6ek+YmvgKgS+9fYfHr+UMVJU7+O3P7TQ0U33uN75/HQm
	0ganWFwFxFY49gfijOB4rRBjfSAXftsplDC4na0Vg7FTkhLyh32VYXFZDvwNlvtWfoaqvM6lLfm
	yh37966Kq8+UJJJxsb9RSqKoYSkcFMLMaF+G5sTvRFp1OsOSufzzIJHg==
X-Gm-Gg: ASbGncsiI9BlI08xZsnvTU8RHqeXlSso7luh6MWXBJjqUXm/hEaMDjB+81/GmUmlhEV
	G+8KJAbDSzuGBEYrJZ1rfbcR68A/eUZDqkQBSdW2Ic8rhfu+3w89reikoLFQ7uFsoMKEydbEZZQ
	==
X-Received: by 2002:a17:907:d09:b0:abf:48df:bf07 with SMTP id a640c23a62f3a-ac71ec953a4mr133953166b.15.1743140618029;
        Thu, 27 Mar 2025 22:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbNxIeMm1LXUGFUqFwfktfKRuuPWGPkRIHX8SMtj4Le0B0TdFaZ3P0I7nYy+Mxe+zRAUGYAlqF6VzzU8SAANg=
X-Received: by 2002:a17:907:d09:b0:abf:48df:bf07 with SMTP id
 a640c23a62f3a-ac71ec953a4mr133951066b.15.1743140617642; Thu, 27 Mar 2025
 22:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250321153611-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250321153611-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 28 Mar 2025 13:43:01 +0800
X-Gm-Features: AQ5f1JrnFEMx6y_4Kqib8q0i7cd7Ag5bB8-g7oD9EIrR0itmEqRSBH6v1-QxRBY
Message-ID: <CACLfguWG+rxAu-pBSKRd1etNQ0GBA33LHtG5vdKasub-1fueEQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NqEy-sU0HcKyiDysm92ELr8zlvftgQm0NtV1Y_ub2Xo_1743140618
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 3:37=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Mar 02, 2025 at 10:32:02PM +0800, Cindy Lu wrote:
> > In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> > the vhost now uses vhost_task and operates as a child of the
> > owner thread. This aligns with containerization principles.
> > However, this change has caused confusion for some legacy
> > userspace applications. Therefore, we are reintroducing
> > support for the kthread API.
> >
> > In this series, a new UAPI is implemented to allow
> > userspace applications to configure their thread mode.
>
> This seems to be on top of an old tree.
> Can you rebase pls?
>
sure, I will rebase this
Thanks
Cindy
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
> >  5. reset the value of inherit_owner in vhost_dev_reset_owner s.
> >
> > Changelog v7:
> >  1. add a KConfig knob to disable legacy app support
> >  2. Split the changes into two patches to separately introduce the ops =
and add kthread support.
> >  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
> >  4. Rebased on the latest kernel
> >  5. Address other comments
> >
> > Tested with QEMU with kthread mode/task mode/kthread+task mode
> >
> > Cindy Lu (8):
> >   vhost: Add a new parameter in vhost_dev to allow user select kthread
> >   vhost: Reintroduce vhost_worker to support kthread
> >   vhost: Add the cgroup related function
> >   vhost: Introduce vhost_worker_ops in vhost_worker
> >   vhost: Reintroduce kthread mode support in vhost
> >   vhost: uapi to control task mode (owner vs kthread)
> >   vhost: Add check for inherit_owner status
> >   vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
> >
> >  drivers/vhost/Kconfig      |  15 +++
> >  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
> >  drivers/vhost/vhost.h      |  21 ++++
> >  include/uapi/linux/vhost.h |  15 +++
> >  4 files changed, 259 insertions(+), 19 deletions(-)
> >
> > --
> > 2.45.0
>

