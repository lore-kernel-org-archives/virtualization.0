Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58C31D6DD4
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433394; cv=none; b=PoJLtaxzogny8zlxJL29pJRFzuNqE5REbipZublJQ3E1bIxVggQujNqoQpm97WnVgIwraY+ge+tZc7k15Gi5oN9Xlqfcy/R+LRHOUuSEGlRNAkcZCp6uCnBNS5lZmK+gl0HbOk/GVAL9BklF4lMvNw8MhooLdbHPrQCsob2GMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433394; c=relaxed/simple;
	bh=rGCaM38jYnJVXBwmgw8Sh7VmVvIrDfJq+EHfQSyCLRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=d7aqmo0/wi2bIiN8qn/8oGlW405MJZz3o4XbPeAUa4jaxv9bIYTiaJ2gZnOtFePIyz9T8mMr4wmTj+22P1/s6miO9sk69T5CB6cwdJ0RNLAYK94aSM3GJUKptFqzCCp5D3ChK3UCeJjICIG4BXt27nET0hbHNvQW4Joe08MZYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlsEwGfx; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlsEwGfx"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3477E60E13
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:43:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sBDIRpCUf11k for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Feb 2025 21:43:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 60C9560E1A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60C9560E1A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UlsEwGfx
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 60C9560E1A
	for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 21:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740433390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRvlyIwfIErpAyFrGoq863D4eRcM+k3YszciGmJ1mwo=;
	b=UlsEwGfx0P6BfJrnof8mG5mFQQRWFELak9NgzsuG+wkCuMrNEvNhmB8wesjZMQ0E37SKv4
	jSyRn+xyVAja/RaAXfjO8I2azB0iZZZ6d8/eaxeLWGHMnp8ZJrCCemzAmzed1+zB5q5D0F
	/M0+P7kH0ykyCy0mHED/eFidEo3L8lM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-VbdVHI7zNKGphr8zqoLVMA-1; Mon, 24 Feb 2025 16:43:08 -0500
X-MC-Unique: VbdVHI7zNKGphr8zqoLVMA-1
X-Mimecast-MFC-AGG-ID: VbdVHI7zNKGphr8zqoLVMA_1740433388
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abbf03205e6so418483966b.1
        for <virtualization@lists.linux-foundation.org>; Mon, 24 Feb 2025 13:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740433387; x=1741038187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRvlyIwfIErpAyFrGoq863D4eRcM+k3YszciGmJ1mwo=;
        b=ql7yTFcdUyEJu8sbUDbxRjcfxlXXmg5LXSMMgaR/6eMWRFk0ep7qvU664L3vKu5j0c
         qh9m/zAN0QT3TVm7sAJZLF5df8z2RA5KNM80RB4uReM3i1BGk7QUHzaoSQ2sP3URwJNH
         VWx3gZAqEt/JDY/J773qaqNeUNDdSsKTx8SeqsrhQ/v1lwJqhs5Fl8G3WUfjDZNFNnuk
         bDFm5rgTPKkKUJ2AFwHuBGzMYdFWQB7v/CesVVdgKFYTgiGm0t2PzretVyerRddoW5FY
         RtCct58dx1oRrnmYaTayTKFmGAqgBf9PS+73+i+jIf+Ud/U8vTJ95CaK/NVQySXxn62J
         Rwkw==
X-Forwarded-Encrypted: i=1; AJvYcCXKdzOLz5jcEvCwjoI1xXiSWEzxv+sBvp6q6Bbk/eMuvDsdkxPUIZYI3ObzglqxJprsFuAzXr9S5BcAgeqmVA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxMH76wl4t+WNMjRhpZB+h6bGWYOKNwOvoaGmU08CXAqNApgykm
	QKAboMHEF9AT3kL7r+1byFkR4+DNjAyqGYl9WtMZvEpvq7u2MCdSI+sZLKC58qihKmj4Q/Qilfe
	9MW56cSBR2HbLuoZoDNiVRVq7c3d5jYa6vcg/8Kw0U0u9NFuHvI+djd87tkYNClNguODsxbHFr8
	a80x0=
X-Gm-Gg: ASbGncu11MK3jMsOZuV5723ArN0T8xP4D8OKrSG1SVYwBzMHx4s6vZ2ROgap3sIVuvn
	sSf0+JTcEMS+TSBPGhjE6U4kQudLRRIv9WpNwuUE1/KrfgEd0UjyqWs9Ak+hvXCVjctZaiXUo7B
	t+Gb6aXJIJbh3Uol/suxP72pohWqgqw57BapZ+yi5uzBWk3V00huT2cx71ttpXUKVk570EHBEjw
	pPgTjr9UxJo966DU0qcZxe81jcbsO7/xtPm4ZKLzBvRQq06cpT/UKIcDQykfbRW2PGMHPFWIo4Z
	X5hYbExvBw==
X-Received: by 2002:a05:6402:2684:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e44a256c8dmr1414783a12.25.1740433387669;
        Mon, 24 Feb 2025 13:43:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFggkY3qckFwg+3BfU9CiVPo7fKtfcLRWbW/4aTirrRH/YEvcpVLH1Iwi+Ay7RISwY3EepFrw==
X-Received: by 2002:a05:6402:2684:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e44a256c8dmr1414733a12.25.1740433387287;
        Mon, 24 Feb 2025 13:43:07 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1a01648sm29278766b.0.2025.02.24.13.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:43:06 -0800 (PST)
Date: Mon, 24 Feb 2025 16:43:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 0/6] vhost: Add support of kthread API
Message-ID: <20250224164233-mutt-send-email-mst@kernel.org>
References: <20250223154042.556001-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250223154042.556001-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yOAgQj2osHy-uSbS9pHPHdZpfY8PohiPx7AGrZ9m_6A_1740433388
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2025 at 11:36:15PM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API.  


This looks good to me.

Pls address Jason's comments and add a Kconfig knob, and I will apply/

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
>  5. reset the value of inherit_owner in vhost_dev_reset_owner  
>  
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: introduce worker ops to support multiple thread models
>   vhost: Add new UAPI to support change to task mode
>   vhost: Add check for inherit_owner status
> 
>  drivers/vhost/vhost.c      | 227 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |  13 +++
>  include/uapi/linux/vhost.h |  18 +++
>  3 files changed, 234 insertions(+), 24 deletions(-)
> 
> -- 
> 2.45.0

