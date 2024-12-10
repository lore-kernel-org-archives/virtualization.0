Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC471DC98C
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853132; cv=none; b=f8QvOjheaQ4pKpPD7qeVbjnMCGI6yS76V75rIkhyd5Cwu+yZ9r5KT4KkDwRRcuRLDaKMwPMEyi9erkHZlaMl2eJMDZsN75W9zJuxCGSpYuPj+DIw7KNpT4BSMcl0OfPURH5y+GjML8wx9pwlDJR/NETmyvNNLsaidtZRv47KJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853132; c=relaxed/simple;
	bh=q9A16Y6kO4s41vmJMGS854yDLlp9NiUZZ2qJ/TT+EKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sOJx7xlEYSgxd5LrjO2xA5VN7dXIZJbpibv+CwDpMQAI+C+pdtI8NVuL+mi/sLUEpdZdqY6jPdulxqi0nEFmXsdLhfkFk/m0f9JfDxGbhW3TZOSK8NTyWLyLVraGms062/xgtZEe7N2nS3i+BNdN4B3gzlZOtAybdw3/zIcSTa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJaqSrYy; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJaqSrYy"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45BC240E84
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KwLPj_HBfW5d for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 17:52:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 31A1740E3F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31A1740E3F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eJaqSrYy
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 31A1740E3F
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5z++hiDZoK6MQKlJqwcak2mnPX1FBIvWTnRgAgxRHwY=;
	b=eJaqSrYyp2Foq+sTIRsPU1J9YpZbFgWot1Y9m2sy30tRVK0FxffldwK+yeWl/1eSmEKkx7
	xzpNI00HgPd6EP173ccatIubHLhLoeTii+HY4YGZl9xwoQndZmYCj4KPpZu9okCY/bximg
	XA128FPPgR7l+WMkBeTBjK/KERVZmYc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-DJVePCB0OSC3b1D1Lbgrkg-1; Tue, 10 Dec 2024 12:52:05 -0500
X-MC-Unique: DJVePCB0OSC3b1D1Lbgrkg-1
X-Mimecast-MFC-AGG-ID: DJVePCB0OSC3b1D1Lbgrkg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f02ea82dso27834785e9.3
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 09:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853124; x=1734457924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z++hiDZoK6MQKlJqwcak2mnPX1FBIvWTnRgAgxRHwY=;
        b=GGHrvTcARV3HAmxizo9iaAIVA4gIjbv8jz+jPTkjkb9alfo9aGKRkOoH+mX/jlj9Xx
         7PPnFihpgvyVBM2ZZuk2sHv1hEWOqT2iOeSHg27A3ZYB/Y2R1tLbEkpyPndf/RovPD8I
         XzdJE1/G4VwMVY9dgyUAklyvVdQIFMKucwLawREeKsmJxq1/Yy1IaEsRGx5mRTrh4mZ+
         K1UXolNJ5L4UZngEIWGR06GHIf00wEtaUpmSO8wFR5/uIx0cWJNFK6PjxyF/mpevxFdn
         wk3LlxWhlIhrhnXMCr38jItZHkZilJ91Fb6iolaeXWvQYGz6Sx6Y6X40J0srFa4oRf54
         xEcw==
X-Forwarded-Encrypted: i=1; AJvYcCW5fQbhUBBGNfc3ERI5PLLovCfcMDWqJqGYl/uxSbKtYdnL+CSULQw+SOP8lsevtI2jsLpfYStHoyVPwZe7GA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw+VRYgnFEKqe94RC3ej4Jj18x4hGB251ZKMg2HgFVIIKJdd7lF
	EZnscdU+vgWUVt0y+dIETs/apMIZnbFRVbLGamL+uPMn8IILff1/AfEC2EbccUr2qBTGy+ncusN
	+1zaESBTrBACTwsHTFTILm0xmYLqGlUB9CsJxZK/DG9xJOATt9XetXpHlgCISMiw8fCoug3fVFi
	01tuM=
X-Gm-Gg: ASbGncuQDrys0O4qAnsiWN9Nwiy+h0v2XuQAKr38P63Z4ZNS7rnhKziO/5Sk1YHSCIA
	4Y/KGv6fC5DUZijr1fXFnI5g2S/eqZ/ER593r0+sfuJ54wafswE9vetFLaRs0kfClf2CxAKvYt6
	vh0Pecgn0WxURoun6TiIK5favqCR+rM3XoqwB/eShqcW2AwKa7gWZCuTBpgv6BtSdbmkhOGVF8t
	D2oHR1PNNCNWZvEb8CktT87kRhcJrNLV1Tfdz1wxirgBXAD3yHKMME1hGzvpJoVnr/4aEavOLKH
	mOEG/NE3V4CzLPeIxN0e5krOHdP8mw==
X-Received: by 2002:a05:600c:358a:b0:434:fd77:5436 with SMTP id 5b1f17b1804b1-434fff500a4mr54092185e9.15.1733853123922;
        Tue, 10 Dec 2024 09:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWlVeLxQceZVqJYPqW9abSwCI92YZV60MOUnZJwqpD1i3FXk0/EecHfd0I1AsDffr0xedD9A==
X-Received: by 2002:a05:600c:358a:b0:434:fd77:5436 with SMTP id 5b1f17b1804b1-434fff500a4mr54091875e9.15.1733853123291;
        Tue, 10 Dec 2024 09:52:03 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436199f6896sm12564785e9.14.2024.12.10.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:52:02 -0800 (PST)
Date: Tue, 10 Dec 2024 18:51:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/8] vhost: Add support of kthread API
Message-ID: <wxfwmdn73heh5k7dnbaqt5iq23qwz4ltlapetvsqlryhz7mhpt@4e3pw5qm7yom>
References: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241210164456.925060-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dIth4JC32h9uMRqZ4DZnC1-EcCxSjh6GSXlIGH9Uqd8_1733853124
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 11, 2024 at 12:41:39AM +0800, Cindy Lu wrote:
>In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),

missing something here?

>
>The vhost now uses vhost_task and operates as a child of the owner thread.
>This aligns with containerization principles, But it has confused some legacy
>userspace applications. Therefore, we are reintroducing support
>for the kthread API.
>
>In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
>The vhost now use vhost_task and workers working as a child of the owner thread,
>which aligns with containerization principles. However, this change has caused
>confusion for some legacy userspace applications.
>Therefore, we are reintroducing support for the kthread API.

This paragraph seems duplicated.

If you have to resend a v5, recheck the cover for a moment because it's 
not easy to follow.

>
>In this patch,

s/patch/series

> a new User API is implemented to allow userspace applications to
>configure their request mode.
>
>Changelog v2:
> 1. Change the module_param's name to enforce_inherit_owner, and the default value is true.
> 2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>
>Changelog v3:
> 1. Change the module_param's name to inherit_owner_default, and the default value is true.
> 2. Add a structure for task function; the worker will select a different mode based on the value inherit_owner.
> 3. device will have their own inherit_owner in struct vhost_dev
> 4. Address other comments
>
>Changelog v4:
> 1. remove the module_param, only keep the UAPI
> 2. remove the structure for task function; change to use the function pointer in vhost_worker
> 3. fix the issue in vhost_worker_create and vhost_dev_ioctl
> 4. Address other comments
>
>Tested with QEMU with kthread mode/task mode/kthread+task mode

A link to QEMU patches will be nice.

>
>Cindy Lu (8):
>  vhost: Add a new parameter in vhost_dev to allow user select kthread
>  vhost: Add the vhost_worker to support kthread
>  vhost: Add the cgroup related function
>  vhost: Add kthread support in function vhost_worker_create
>  vhost: Add kthread support in function vhost_worker_queue()
>  vhost: Add kthread support in function vhost_worker_destroy()

What about merging patches 4, 5, 6 in a single patch?

Thanks,
Stefano

>  vhost: Add new UAPI to support change to task mode
>  vhost_scsi: Add check for inherit_owner status
>
> drivers/vhost/scsi.c       |   8 ++
> drivers/vhost/vhost.c      | 185 +++++++++++++++++++++++++++++++++----
> drivers/vhost/vhost.h      |   4 +
> include/uapi/linux/vhost.h |  18 ++++
> 4 files changed, 198 insertions(+), 17 deletions(-)
>
>-- 
>2.45.0
>

