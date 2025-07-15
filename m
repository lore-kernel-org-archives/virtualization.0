Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12624DCF9
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594779; cv=none; b=GWRjBmhxcvlEXAN7vOPfAJu/AVfmKuRef3pZfbceAAKSs1kM4VYDKmk/y175qwZB+G38qynj7EZ8ah4TqOwCeVn0PEDXDRRRjNIobpSG/T79l3/POjfBPiRyYuIrdjORecm0SR2LKrMHvl5kGGGrqIWAyp+WwWB/xx6en+vJ7sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594779; c=relaxed/simple;
	bh=uDfrJF/drcy35q3gMp74bx+UGibPNfQDLes/+Jl9AVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTItyTbm0RDgIGT89l1m9o9RNaezWT4AfEYAOSZn7iJ15PQroq4JoPEyzpBjGZsCyQJ2laU0qWR2W3YLquf6IhvuN0B4bFnqdkBzN9T0JtuM+ARVkGGYCHml3OcD7CFp+ovY0KYPXvUb/VLxSj13PfszxS4F7gDxzNcZobH+HEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLQl/tvM; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLQl/tvM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD7CE40FC6
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 15:52:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWgmusViJRDO for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jul 2025 15:52:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B6CF840FC1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6CF840FC1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MLQl/tvM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6CF840FC1
	for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGVgaXIwZocM9TTdAix5oncCbiNFuNiHnVvJ4UMFQXE=;
	b=MLQl/tvMlxZWfL6Z6F1MsFxOyX3n40nZf3w7F7faPfSgHEJe0Y0Ay/zT/I2Kz14boV050h
	oM9/C29AzxNuODAuhN7ncwK5AoAsw4JfycWzRbFViHgihoaURkqf0Lr8VALw/nbcF58CG0
	2Itk5x8pTz1NE/buO3SNsKqFn1r5wNM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-YheLAszhOsGzrY1KRkEaBg-1; Tue, 15 Jul 2025 11:52:52 -0400
X-MC-Unique: YheLAszhOsGzrY1KRkEaBg-1
X-Mimecast-MFC-AGG-ID: YheLAszhOsGzrY1KRkEaBg_1752594771
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae1c79fb8a9so648614166b.0
        for <virtualization@lists.linux-foundation.org>; Tue, 15 Jul 2025 08:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594771; x=1753199571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGVgaXIwZocM9TTdAix5oncCbiNFuNiHnVvJ4UMFQXE=;
        b=Y1hke3jYd5jePLKqWMZvTJF2WcoGjCKZ4em8RVhSXFOswMbnQM/2jFDsRvLbeyPiT4
         77dhLfRlYC9pR6f6D6dWoCqgt8LCRBzgMLUuim/AFMDlLc3rilJI0KicLTtXv1bTRSo3
         7Ae+isPH1QBYbn46XDd53bC+qg2LtgNedi9Ijhdr6zBr/LEssC8c8GS2gpzsn4k86NWn
         zF6bccNZMN3dI9+gbfUCIHwE6FIkECjyKNcwcbu8y05DjfMBhsJs2jNTUULv9iNGVL7W
         8ElCprUeMKZyr2U51H7tq2cial5cHnnbgSYWG6jQ017XVRLnqrOZPc0cWrhKctp9lMwA
         ttCw==
X-Forwarded-Encrypted: i=1; AJvYcCVqEWK6JRX9nVqKk1MKwkqak6VOLbTqdc03QyQS7Acy0M4vrMNyUXpYRtyG37M6x7zGYz6rIVSkcErAQE3H2w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyGuQLPLHUz3JYX0EAYa6w+5w8DnAp7w3UW3UWPcMnXvzuNtS1g
	9bZcrFSfRCvYwQSACYfvdaUNUlNr/CRER6ErfS6D/hD4odj8NaL33v8WY5oVsl4dT5HxSjPp9GW
	fEv0YjjeZjJAaWTgoaLxVOkDNwwVWmh99cneI1Q10vRQUeNDFZ85zZDXguzifgqKVL7syBrY/co
	zHuPcxhFuwT/FBibszdDYPB0PBIv5AcZaHEOnITr0xizhQtBXaHX228RC73Q==
X-Gm-Gg: ASbGncsJHrVeXCJqN9RgbF41kneBbRFQ7pkpg96BgQX+qSlMLTKZWLmoDy6IkTpkKpM
	4oAe7vfXjzhUf5zA60JgKffXPHpjX6QnIvZpjm9YSTZFubKHKPa8XPCFfN37WWQ2CvW8TynmGDy
	D19DHzP54fTTcl08Jt4R9eaw==
X-Received: by 2002:a17:906:c115:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-ae6fbe3d07emr2002471066b.27.1752594771130;
        Tue, 15 Jul 2025 08:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUS6HiH3OZ7t7wywPZ+i8XtYq8L6TxhaGYbPlDaYTLcxgd1/uZaFKuIjLPtsvr7tm1eM8MCwXkgLfvRdsAGGY=
X-Received: by 2002:a17:906:c115:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-ae6fbe3d07emr2002466666b.27.1752594770666; Tue, 15 Jul 2025
 08:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250714071333.59794-1-lulu@redhat.com>
In-Reply-To: <20250714071333.59794-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:52:12 +0800
X-Gm-Features: Ac12FXwfXi0jx38BKdlRwU2IFKU-jNFpCJwwxM4OKirTaJ-ZKXvGTV-e0aBSlEs
Message-ID: <CAPpAL=w8GQypO4gFv6vgO0YDNPLLQ-4JuEKyp9oHP8WiATWOmQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/1]vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A1OThkMvmKuyOtQmz6q_eDkXOs13jVuQFtj81RHlBxo_1752594771
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 3:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> Changelog v13:
>  1.enable the kconfig by default
>  2.Rebase on the latest kernel
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (1):
>   vhost: Reintroduces support of kthread API and adds mode selection
>
>  drivers/vhost/Kconfig      |  18 +++
>  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  29 +++++
>  4 files changed, 295 insertions(+), 18 deletions(-)
>
> --
> 2.45.0
>
>

