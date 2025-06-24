Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384424D599
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Jun 2025 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734408; cv=none; b=MlpP0PxlEQrHYAsRJe0nnT5E/qzK2WvaD5+/mE2ebMlHd+9WXVFz4UCYqDs7PG2eswFY0bZFMWewGHfP6KFzUX/JGCmjdCByqaXbcB8e1/gjX0A1YlzU3SP0m8+8ef1hjaQ4cbjPslU3esPYkGIHQ6vNxYKzpS89s4INok5zEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734408; c=relaxed/simple;
	bh=Hf4pTDvMYaPZ6cEcFPUxwJ3dIHRZ97tgnAGbROXDCAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+4ipHiE6WeJQ/yjo3Xab2SQ5ziKwrskjJ0ZWqhER318OCT1y63PeNPLJvRLa2zsCq84aP8pcU9Ir31fZ0WXAXTRwYX9e0nR9ay+axQ8eenKQmCkR8Fupe8fb1ps6pXAhZzvhoJ2MuFXFDVInU97TyA6I09nvbXOd6UgoqWSyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFKjU/Yj; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFKjU/Yj"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B67DD40801
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Jun 2025 03:06:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rI2NqGZRPS-r for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jun 2025 03:06:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F29E2407FD
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F29E2407FD
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFKjU/Yj
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F29E2407FD
	for <virtualization@lists.linux-foundation.org>; Tue, 24 Jun 2025 03:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750734404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx6sgmMMgVG7mUKi7Kr+wT8T087UyGpYIyapJqyqMJY=;
	b=FFKjU/Yj/LO6FCWlUX/XxYRNubiMVfDuBqrKe8aNikiSwyvZmVr+M0ZwA+MA8hNmJsGqHy
	kJP5subTVzVXlfsRFpoMCgEq5dyFTLjEoCJcowMmm3KXJ9+EW33cfiu79Pz7Tx1JhcnMMz
	T1hmcOZaofm8H2dsX0WfbQXZM6KDYc4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-bCJyq5y9N8i1hoTfgnot4A-1; Mon, 23 Jun 2025 23:06:43 -0400
X-MC-Unique: bCJyq5y9N8i1hoTfgnot4A-1
X-Mimecast-MFC-AGG-ID: bCJyq5y9N8i1hoTfgnot4A_1750734402
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade81d27cddso431436766b.0
        for <virtualization@lists.linux-foundation.org>; Mon, 23 Jun 2025 20:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734402; x=1751339202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx6sgmMMgVG7mUKi7Kr+wT8T087UyGpYIyapJqyqMJY=;
        b=W7KvPuXRjbOMxWTpt9aIKHLWfaM8gow+bJ1wvrNqX9GtzN/NPLs4MyZt+Db5jpLhnM
         qZDEIUmo/Fm5Od39E6R2Kiri3BszdfFkYeFEgSbfbC3S7ISILh1lFkm18EW64uPi98RA
         X8gvMJjU5CUc4LdnJyTGGVmLOUtXzZrBP+DuSRmmS+IB8myRd3fgtcOAswbbQLtJh/Eh
         Cs0fgEUCekTGJJ2FlfrTRkdF8M841spcYmM+0WNXQJ+gP0j8t+WaAv0nzl+z0t6JD2tH
         Agafr9Cz6tdXdjjasZWWJhlgIN+zxyELXNI1lXCE0Ng3ogW56KkMMj++43fzlYC0d8EY
         T2WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVABHgIXELcxKbpQVaipsZYdqKI47LGJpugbLdFab4dwbQ2ch45TvE3sN/iwlM1HjyuewiKaYUOOErVh5POfw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwdXMW2dgLQJ0EJnrs3TwIMKbwnFsWkw852DfGg16YUVqa7COQ5
	VajRLCGHAj167VfXM7vmfOgc4IPukWG5c3ADl4w4A1Ggs6kGDpgUcIhQFgvDm/lLqdyPdCfBdTT
	le1nqcH1x5du+PLxqN20adHONDRpBe3WeHc6CeDpwESlYnFs3DkF46cG217unOcJ49pgZnrZObZ
	g2LpSAcExPU5CD7EQgFPseMKE6Se87LNqC0v/HNvsGL1YauHaax6X7LbWOaQ==
X-Gm-Gg: ASbGnctMcufh71ey7uJiTvHSRPZvZOt8F9qeF+VTW8uwyGwDTfuPwA/GpRzJPk4RSNQ
	9hJUmtpe1sLQ8JmK3eFVt1pnHLm7kiqteCkAYOO3n6PW3bvfN6Tc/K4mGPXm9e0yG0CWsOsakfq
	0qH1az
X-Received: by 2002:a17:907:7e82:b0:ade:44a6:4a46 with SMTP id a640c23a62f3a-ae0579646camr1357685766b.24.1750734401894;
        Mon, 23 Jun 2025 20:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCafKAXMcIHxmBhRwK7iS3XqemOJaV64Z8YrHbwgZKXjFKieDbmnmUfsC1RX0ZnO0TrS5tn9NXnxrmG/36Ll0=
X-Received: by 2002:a17:907:7e82:b0:ade:44a6:4a46 with SMTP id
 a640c23a62f3a-ae0579646camr1357684166b.24.1750734401547; Mon, 23 Jun 2025
 20:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616062922.682558-1-lulu@redhat.com>
In-Reply-To: <20250616062922.682558-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 24 Jun 2025 11:06:04 +0800
X-Gm-Features: Ac12FXxonylFwEpUfkwEJ5y5yjB5bxPnbHAzx0yEInUcezXskog1NQQnLXV30mQ
Message-ID: <CAPpAL=y8WxyFiXifBDARFZf+wcEO1r3MYPg09MKz8aMAXBFtSw@mail.gmail.com>
Subject: Re: [PATCH v12 0/1] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Aha8tp-gCyqgKEWXDA-rtg83CXDYpa6wJy2kuTSzaak_1750734402
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this series of patches with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jun 16, 2025 at 2:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> Changelog v10:
>  1.Add support for the module_param.
>  2.Squash patches 3 and 4.
>  3.Make minor fixes in the commit log.
>  4.Fix the mismatched tabs in Kconfig.
>  5.Rebase on the latest kernel.
>
> Changelog v11:
>  1.make the module_param under Kconfig
>  2.Make minor fixes in the commit log.
>  3.change the name inherit_owner to fork_owner
>  4.add NEW ioctl VHOST_GET_FORK_FROM_OWNER
>  5.Rebase on the latest kernel
>
> Changelog v12:
> 1.Squash all patches to 1.
> 2.Add define for task mode and kthread mode
> 3.Address some other comments
> 4.Rebase on the latest kernel
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
>
> Cindy Lu (1):
>   vhost: Reintroduces support of kthread API and adds mode selection
>
>  drivers/vhost/Kconfig      |  17 +++
>  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  29 +++++
>  4 files changed, 294 insertions(+), 18 deletions(-)
>
> --
> 2.45.0
>
>

