Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C701E2823
	for <virtualization@lists.linux-foundation.org>; Mon, 31 Mar 2025 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743422421; cv=none; b=tzzjhDZYNhW6iVvOQqTiAVl3VVrlIKlNXae0yWE6RN9Mvlg1EB+1I5DLdOZH/qmUOEfqm5/sxcbk8HD2p8GRhO9vwzzS/KaCGqU3BvQA4Ht/xPxe96E61Zw+abv1AOCGMh0vcsI5MXIyJh5+DTJ36G4GVyDmC8RDZXDOm4D28+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743422421; c=relaxed/simple;
	bh=76SU+zIo7WlCNaXWUl6aelYPfKu7lO0vioy9H+xSEnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmkeCUUonXAmoH+eJeuX33roXvLMNWGzNl5iXBSkr4oRwMMp9ODzRLn9X2OCznftThT1A2UkgJYRYYEwt7Rxo3uahlXx8EbWDDrPKYkqGj+a72lTYQ6tT3q9aFIHV3dRwuCcqiOrF00YjtT6y1ntSqSVsljEEVHSYZHeISwqgOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgxcX5KJ; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgxcX5KJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A1C6400D7
	for <virtualization@lists.linux-foundation.org>; Mon, 31 Mar 2025 12:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQlVRWyTJApb for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Mar 2025 12:00:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5C93240065
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C93240065
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PgxcX5KJ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C93240065
	for <virtualization@lists.linux-foundation.org>; Mon, 31 Mar 2025 12:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743422417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SALfqHpaVZ7H1/T2YDaQ+8Ub/OE8/ksE1OnbpJljKQE=;
	b=PgxcX5KJYBVcF13kaDHwhDeuMUC3TVEVFxGBNf2qlOga0148XC8lUDKGNCCQm4a21iR0zY
	vOGtE5vPAWbXySwmoGt4+1Frm71MjtscTlwuKmrDWsafkQkd45c16xUF8HzUR3PAxdhb+u
	UUYexB4m1D6PU2vyh1m/QgMkXg6fWFw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301--UVGfCvtPaqXjthZmOgm7w-1; Mon, 31 Mar 2025 08:00:16 -0400
X-MC-Unique: -UVGfCvtPaqXjthZmOgm7w-1
X-Mimecast-MFC-AGG-ID: -UVGfCvtPaqXjthZmOgm7w_1743422415
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac6a0443bafso402642566b.2
        for <virtualization@lists.linux-foundation.org>; Mon, 31 Mar 2025 05:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743422415; x=1744027215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SALfqHpaVZ7H1/T2YDaQ+8Ub/OE8/ksE1OnbpJljKQE=;
        b=V7cv1zXh/CRUplIzEgtIBb7PJkGa/cHzjQKJ2+VVRiqBzy9ZK0A5nkRp4avzcKqnEx
         BvCNcC+bNqfqOW4nXCV5Gtb7WiIlnvdFcOp6+kmCqzhi5GZv9zyI5n7UuOSKUErR4MBT
         4J4ENUDtj54vRv+fUle93nk0ZoD08jEhqm6NjTmZvszi9tYIa1LgfpKNgHWGoWJARcNG
         VOE7fGmHDgAMWNkSTl25Gg2mZnn4zjEaWohjzj0KborKWVS0GNrBdFH6fREeamwB261B
         fhVIUDh5aOUkVZgPsXwpB0+TK41pmfrcwcreFqmWPF3d+2YkluboA4fExKx7l9wr/yr4
         CN6g==
X-Forwarded-Encrypted: i=1; AJvYcCVB74jhXfsGc5o9RYWpA4ZgoYDNWSL2Sy2xAYUOL7/ae954baMwATBSxbPVYLeeXdXjQelJPPysPkEFyxnqUQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxgW5646z5oLgtaJUcahEVse9OpniRPJ3v31gryPZfYBvsverC0
	JZrTljR+HUOiHtwzdpx2Xr7Am9XCwUGAe8Ng0CNlLK1TiOtiAbxWkOtz9w5Uobqyq5LWprutqOP
	+ZQizO3ZwEG3B+gSXVnjPJlrq8N8FOCxhrWqvGAP4E8oUzjiw6pMbkW90FTx+RBxr0XXJ0CFQZ+
	ihuJrk1VzdPBAnzfDyQAu2DVauDNQanU5T78+wC4yUcMnglgPEobYqQw==
X-Gm-Gg: ASbGnctxQUscNfQGgWadgaNugv7wgeBmndvwKDjGcZDOf+MyXjXlZAqkpJjv1mErtQW
	RbDWWugEtZ41rt7YS2y6XfhhkEBrdrHRJTVZZvmAF2LIIqCPJ9N+LKLIFSUbc7eRYPlFNiiBRrg
	==
X-Received: by 2002:a17:907:a08a:b0:ac3:cff:80f1 with SMTP id a640c23a62f3a-ac738c880d3mr758638466b.54.1743422414490;
        Mon, 31 Mar 2025 05:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDnA3ED+fmlUHGPDP9zSXTFcjlj2+EA7N/YnNwtisbC+ekVhCoZq1nyT+pnlJz/9pdqBVMe0AoZpt/YKM5Oao=
X-Received: by 2002:a17:907:a08a:b0:ac3:cff:80f1 with SMTP id
 a640c23a62f3a-ac738c880d3mr758635266b.54.1743422414079; Mon, 31 Mar 2025
 05:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250328100359.1306072-1-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 31 Mar 2025 19:59:37 +0800
X-Gm-Features: AQ5f1JroAFl0j8Y8E1rVmceWhY1UAp8ypP7a0k97xGC3a_KBzP4oWFz8KEo9czA
Message-ID: <CAPpAL=x00fw7qV3GdOCQPZcry-VyQFFUq1NXu7uOH7zVmESNqA@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0d3wXUfH1FLGDORzZ-SmsDtLdjFEqYTIlJOnVlbgeXk_1743422415
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this series of v8 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Mar 28, 2025 at 6:04=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (8):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Introduce vhost_worker_ops in vhost_worker
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: uapi to control task mode (owner vs kthread)
>   vhost: Add check for inherit_owner status
>   vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
>
>  drivers/vhost/Kconfig      |  15 +++
>  drivers/vhost/vhost.c      | 219 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  21 ++++
>  include/uapi/linux/vhost.h |  16 +++
>  4 files changed, 252 insertions(+), 19 deletions(-)
>
> --
> 2.45.0
>
>

