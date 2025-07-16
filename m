Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085D21D5B8
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Jul 2025 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675183; cv=none; b=HEMQFYZI3rI2SurHOqnuUYAi4zsi7g345QfhVvYWehWb/ci7iUKTRwESb2RHGnW1Kl1K58mmrd+/AdKvOac+/CNbv3w0sD4SSZBzvwPmvNHiYdaK3AWvd3j8pcqxRDalFX1dDro70nziCPoDH3N7kRZf0mtH7sakXY0O3iA2lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675183; c=relaxed/simple;
	bh=1UuX6szgOmOAGr0EFSUNwfsGrhCajPIIWCzDM/8ZdDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hUHaHhQUjUgi+SF+4mM/c3+kSqWyMVdLyKvHI2j2VQRQeTsJyWzPANbZf7hcKlTzJr5swCRWurNbWO0svFK35IseKdCmxhsn588JL4iF/WVO/It41ZAQ9fGLKNKOmGu02MZhDiMQYfOQmf5Z/bDT/A8qPGE/BCJ+OpOLEeDOhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOuGef5W; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOuGef5W"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C38AB60D50
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Jul 2025 14:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E3l67dtlh9fZ for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jul 2025 14:13:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1B63A60DD6
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B63A60DD6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZOuGef5W
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B63A60DD6
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Jul 2025 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752675179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3kQObBm2VhsuQ4Br5dn7g/NxqBvEUCwsbnrpjwtiTk=;
	b=ZOuGef5WJYkKzUCuIxqEROoJE+bGteCntTd0yewDTTo9ThvvWefUzASX0arzvbCebTwabB
	h2JClUNRNas2ks1fVT75GXVG2b6L6XhUHf8LD5C2GRq3/9Nr00EEQ6VmenhHZxHbphGPO9
	9H1hk3lO8n5KjH/yrdkQtnqUaYmYdUM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-Qobm_w8rOVucIjMxPl9awg-1; Wed, 16 Jul 2025 10:12:57 -0400
X-MC-Unique: Qobm_w8rOVucIjMxPl9awg-1
X-Mimecast-MFC-AGG-ID: Qobm_w8rOVucIjMxPl9awg_1752675176
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f3796779so3186356f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 16 Jul 2025 07:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675176; x=1753279976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3kQObBm2VhsuQ4Br5dn7g/NxqBvEUCwsbnrpjwtiTk=;
        b=CB5ayjQ+6uVg3VWvdzpsjX4vJGsJ5K18htD5uxagGhfjp7HCrONn4CsORKyviljnsM
         0en5fYasGORxvvrtkGuy5UIt2Mx+iqjrFpsaDfY0yad+X85texc8YZKGPwpNgNZIDUl8
         PGJIo+O/XVg4wEJSMuEzsd+Ot/WFGI0nxFV+hmZPhpyDAV3xcNRfUOHRpI5EjOUEiRz6
         mX3sAROQtTGv6AMfXvXKTeNEWM8yg/t9IJ9lFqsjc+XGIlSPh+4HuUYOsou/VghtpOJn
         LqYNSSS3Yyhh34mj7/StwWhLzl11+h7O5aeoSwc8/hZZvAfr4tkfhY5BrvlHDmPqTPXS
         4rDw==
X-Forwarded-Encrypted: i=1; AJvYcCWhWiO6jOq6bpphQY6YsKc24cyMrjH14eM7eRmFNd9L8W+7l79rtp86FCGxXyQrZZ7I721NAi0JvaGD7+tKWA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx2+lB7QV3qxSQjkcWuylvMTpTXjH8Dm+Kq2Z9wZALA3NRJj14k
	OCK9MFz+ywhO01fDDqYx2iqp5lenZ1xYI+svDr1JIHx+Im1u125Rxrq50bNdtCmox5AY9QSvdKD
	3v/1zCOplmq17SqNybl+cGU9oI53ALmel0GLkaIZ5eXahS1204iu0Bf2jrm1TjQiSFhH5uSekXW
	SpUsWMzJE=
X-Gm-Gg: ASbGncuxMXzL6D8SgZEkMZufsu8GnRwVNNlNAhlBFuXNHDvtOjpQvNBy5uU8I/KMi+h
	nkUOV/MaAEsxb2jYBT3tPWoW1cBkAuT23fiXbkNWA2lhQTg6J0wG/q3CjrLv4zrsUnE02GJSmBc
	n1Aknsxx2Ee/rs6DUA3o/iUtUIrGMz57lyaEvfBIDAikPWivgmGBNwQ2t7g3Q4Dqilx9C2Qfq2Y
	6dw2G5Oxma9jQQMipXP0fsq9SbuyMrp1uZO/wuYXHmM9Ndp/bx6mkoc9NfPZpmJilifgKx/9aN0
	Hc3oF9eAiJ1URuFDAEUKZfIYbfDy1hrG
X-Received: by 2002:a05:6000:64b:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3b60dd4f79dmr2927573f8f.16.1752675175564;
        Wed, 16 Jul 2025 07:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcTQHmFkdo4qKszITkM/hDotRfA4R+XuTHN+mNxyUn7y3tAOgVhUvnmBHW+D+Oz3dz00ArzA==
X-Received: by 2002:a05:6000:64b:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3b60dd4f79dmr2927547f8f.16.1752675175042;
        Wed, 16 Jul 2025 07:12:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600a39281sm10296194f8f.73.2025.07.16.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:12:54 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:12:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v13 0/1]vhost: Add support of kthread API
Message-ID: <20250716101152-mutt-send-email-mst@kernel.org>
References: <20250714071333.59794-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250714071333.59794-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6M75xsx764dYgdudY6wS12snFhRk-4PRqaYzMB-u9Fs_1752675176
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 14, 2025 at 03:12:31PM +0800, Cindy Lu wrote:
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
>  1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
> 
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the default value is true.
>  2. Add a structure for task function; the worker will select a different mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
> 
> Changelog v4:
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function pointer in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
> 
> Changelog v5:
>  1. Change wakeup and stop function pointers in struct vhost_worker to void.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
> 
> Changelog v6:
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner.
>  
> Changelog v7: 
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops and add kthread support.
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
>  2. Squashed patches 6‑7. 
>  3. Squashed patches 2‑4. 
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


I applied this, thanks! But I've rewritten the commit log.
Pls take a look - commit log must include the motivation,
and be written in the imperative mood.

Thanks again!


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

