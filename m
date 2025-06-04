Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464A262FDC
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016906; cv=none; b=s9Q912hCNCwMDbcccwIqyj9ARi2Wqx5DWzVrBKhtjBC+/fooM9OZ/Q3h0upYe9lbmC+HLg81mJ3Zws8nu4ykbKxUcfun9IyILeOY4fkKzKiHoyDa3qLhQEnhUqXHlJE7o2oceqOam0pnXnthVY/qYNacpR7oXATaMkEzred4S0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016906; c=relaxed/simple;
	bh=4TyRBG1G4EzdBNunppuanZ43NQgPH8fGRCpZBDbYUus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXsTTQCegdSQkG0me08xa4yiv9gG/BsuU1bQdTepH8zKKj5y5HzdJmcUVtR/rrz95KCSVgmE9Gr7Kof+wy+GD9nsk/I5NbP+nCPcrm0ZHX9zArj02yOtsRQRWMVKftdJHsIR4ULxav12nuZ53n/9vdqTtxNKnU1VSJuuaE3/w0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WXc3N7wW; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXc3N7wW"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C286540C58
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 06:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RM3PtcHy17CL for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jun 2025 06:01:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DBBC240C2D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBBC240C2D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WXc3N7wW
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DBBC240C2D
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 06:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749016900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zuRWRJUNtoA1IwLH7xLOPSpkGMVdWFOSz6YPLpJ70Q8=;
	b=WXc3N7wW1PLLSKXOExxYmGo2Fw7+4jUShSzvhw02P0Fp3vOwbgFs40qXLw4sZqlN22tFCd
	UtO4sus+z2dFl9+q0iQo7NpX/5fNAFjeX+GAcDTQqCk+LuMunX8pG6iZLan79DvY5y6cZk
	3MvTF0YZkcH5U+Iy9gIB0xkP0FaxeLY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-PNsHv8NsMAyiJXQwjCS9ig-1; Wed, 04 Jun 2025 02:01:37 -0400
X-MC-Unique: PNsHv8NsMAyiJXQwjCS9ig-1
X-Mimecast-MFC-AGG-ID: PNsHv8NsMAyiJXQwjCS9ig_1749016896
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-adb3e2061c5so59492866b.0
        for <virtualization@lists.linux-foundation.org>; Tue, 03 Jun 2025 23:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749016896; x=1749621696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuRWRJUNtoA1IwLH7xLOPSpkGMVdWFOSz6YPLpJ70Q8=;
        b=UWyJgisULoGmNzjcDLFFIPuqlBQDVHMEvj2iT0TyQGhuOQd7KlTKfXPlSYgzvOt10P
         5SGN4oNuiSDhgi9OkRlRQZRLcyBW2T8h/5NYX/tN89ofSeRxu74oY4gsCYwM1CSWan+4
         Yqau5DjG/tO9EJY29eIBvb6CMs9RLQ+PMHb5iWjIXwSHnzhN+T7V857lODc1WWYDCVgm
         apmNIBe3TsbbsYe0lz3w5iIZ2OVM659FJFd9oHDxPwGbv99u8jpMRChXhZSKUgQyeYWZ
         A7jtH4QMXY2XAJziGzFhHhUCI/JlC7Tkw9x+tvordbfTaN59DLNS/qQ1yYFfdEyJrWYF
         Ej2A==
X-Forwarded-Encrypted: i=1; AJvYcCUrMmUgbCMHTMwP0N75z+FXOgbUcRTwEyXE4snmH24R40CP+iEfd6hN6auQSlQH78RTATBNE4nuGUjxGWxFUQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwKwdZ1FgWUHF/gTpv+8nZ8Zl3HEJKzWDjW3kCBlccNFAG3Ahs0
	sfSYUl3YHYoN1im6pqIty2/MYnJzPKHcdFTTuRPvkbzQQA0nbLS/3x2hi7ppeNeFE+hVw5TD8Ms
	+sAKapdz9RQMtzCRX+ShBXrVgD3m3rN50M2LzCxS5XfxIGXNdIu34QWSWPomkUyJm+Fi4eMI/LZ
	qDZsKj8pMISoevER+G1omG5/Exd2wLJEc2oBDrsuCg9hAIwZwd8+cKW+h5qw==
X-Gm-Gg: ASbGncuc9Uf9vQFCNFiCP+FghDaeg+SGYR0bQOqq07VBpp1w11Enia0vlg/gyQTpXVP
	/jeTHKvRYysVhvK50QKgcqmT2cqUbkjv2S0f/K84FZDC2FN/fWLmW3zfm3czk4i+lQHhstg==
X-Received: by 2002:a17:907:3e27:b0:ad8:932e:77c9 with SMTP id a640c23a62f3a-addf6e5309dmr151678266b.3.1749016895885;
        Tue, 03 Jun 2025 23:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq7zshd+Mlb0ExzQc1p+OYd8O3naYB2lELgamGzeWirUG3oP6mxKyenZR4eIlwQzxmUZ2DblEvLugnFUc5+nI=
X-Received: by 2002:a17:907:3e27:b0:ad8:932e:77c9 with SMTP id
 a640c23a62f3a-addf6e5309dmr151674666b.3.1749016895432; Tue, 03 Jun 2025
 23:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250531095800.160043-1-lulu@redhat.com>
In-Reply-To: <20250531095800.160043-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 4 Jun 2025 14:00:57 +0800
X-Gm-Features: AX0GCFudKt31CUN4yXL1ybV6SffNxLvQTIurYx8hfUPGvIKESpW4_6rDnGimkiw
Message-ID: <CAPpAL=w24Wwq8Qa9uQr8OQqdg8vMiK0FSOUGdCHAvB0O2B_T7Q@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 0/3] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vJ3OncYvOSnXm9rV-Sqa7J77Ysk-qRZOQDQtSF1evdE_1749016896
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, May 31, 2025 at 5:58=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> the vhost now uses vhost_task and operates as a child of the
> owner thread. This aligns with containerization principles.
> However, this change has caused confusion for some legacy
> userspace applications. Therefore, we are reintroducing
> support for the kthread API.
>
> In this series, a new UAPI is implemented to allow
> userspace applications to configure their thread mode.
>
> Changelog v2:
>  1. Change the module_param's name to enforce_inherit_owner, and the defa=
ult value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the defa=
ult value is true.
>  2. Add a structure for task function; the worker will select a different=
 mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
>
> Changelog v4:
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function po=
inter in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
>
> Changelog v5:
>  1. Change wakeup and stop function pointers in struct vhost_worker to vo=
id.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
>
> Changelog v6:
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM=
_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner.
>
> Changelog v7:
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops an=
d add kthread support.
>  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
>  4. Rebased on the latest kernel
>  5. Address other comments
>
> Changelog v8:
>  1. Rebased on the latest kernel
>  2. Address some other comments
>
> Changelog v9:
>  1. Rebased on the latest kernel.
>  2. Squashed patches 6=E2=80=917.
>  3. Squashed patches 2=E2=80=914.
>  4. Minor fixes in commit log
>
>
> Changelog v10:
>  1.Add support for the module_param.
>  2.Squash patches 3 and 4.
>  3.Make minor fixes in the commit log.
>  4.Fix the mismatched tabs in Kconfig.
>  5.Rebase on the latest kernel.
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (3):
>   vhost: Add a new modparam to allow userspace select kthread
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: Add new UAPI to select kthread mode and KConfig to enable this
>     IOCTL
>
>  drivers/vhost/Kconfig      |  13 +++
>  drivers/vhost/vhost.c      | 223 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  16 +++
>  4 files changed, 255 insertions(+), 19 deletions(-)
>
> --
> 2.45.0
>
>

