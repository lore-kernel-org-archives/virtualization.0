Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713F14A8B
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709251; cv=none; b=RksDebtz3iF/Y2nAhmB2YOb0Pn8R3UcatwqZevrCu4ENVw3e5Gwmth6IiEBnG4m8kfsOuba429QyGeruRz5PApe5lWA6sdJMj7B1Bd82heKaginKA8de9+I42FtLu6iEGB7Sx4jLmRZ1EtETrs0GQDKoXatVmQ0GzIWzKDhurao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709251; c=relaxed/simple;
	bh=UjKVWN7uen5QtJlj47WJo7MSZiaiu10pJfZXyVbBjLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OVlMO6xpVDC2LTofsgWmzQnAld29aex1V98bYEdQObkYXcBMRprMogCtw6Zi0qSZAJ6hs9IPyN+0aR9HqtLXJjHWC2OrfegZyKNv8//2fBm/EJAXr2lukVcfti6Kh4qVvEahJc6/DV99GaojJ85GjB8Qh/W37rk+1e/rRSrD7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJPjyxJE; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJPjyxJE"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C532D400E9
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRxsuenznD0K for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jun 2025 06:20:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0C20D404D7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C20D404D7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PJPjyxJE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C20D404D7
	for <virtualization@lists.linux-foundation.org>; Thu, 12 Jun 2025 06:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749709247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piaS+IvVA5BU5uoyHWio7NQXE3J6rbJilCTVKgCGvkw=;
	b=PJPjyxJEZH6N+jp60tdq7eDjUsXCHix79YpXahvuIbSCGFY7cJMThElBwkvEjmAzrhKJXG
	ldAHxb80YOJGk1eZc+t4dG4qlbcr9EeoyMD8pNpH8u/SkaK6sf96ul7KRlSGVmMsQ1TU9X
	QqcUdzbozHO1tCx4DJGOGwd/5fu6JAA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-ggy4ovH7MNSPYMIOTYhGaA-1; Thu, 12 Jun 2025 02:20:46 -0400
X-MC-Unique: ggy4ovH7MNSPYMIOTYhGaA-1
X-Mimecast-MFC-AGG-ID: ggy4ovH7MNSPYMIOTYhGaA_1749709245
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so246263f8f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 11 Jun 2025 23:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749709245; x=1750314045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piaS+IvVA5BU5uoyHWio7NQXE3J6rbJilCTVKgCGvkw=;
        b=bYYs2UPTrJpobsrAyEmNxYirLkVXFNVItvxnPeJLt3YlG8yB/5vVxxz3nURv+SpYDV
         LawimwWQBvDE+C7xqqnKB+8I2w5oZ9YkthYuwdY18+KRUhdWRWJwNxjNPVgC2SNuORHU
         ezoGiLOyj6PWhUARGc6fbsjeJ4iUChIIJgRCWewTgw2okvt2ZMz/daBEv+itXRsr3tZy
         UAjPvVnCUwWTl5xAVb1NAat3GmLJD+xqYFMB0RhUkNat3nXPz/aJEfY+uQmcnu7o3e5I
         3jwuqQCLAqPfgzNTdh6eWp6y1nI/cU4J0eNB1YZGApvlRD/IWkpfrSPhQ0sDTjCNhldl
         h98Q==
X-Forwarded-Encrypted: i=1; AJvYcCXh2yJQmvFpjSoQl8Kq6/nmFmcL3jYso4cqW4q/uiT2njkiTlZMyazW47+0FeI/Ws13byBPlczP7VH6xB4mcg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwpW9yuJhVnMx5RBALbdoQuDqplQLlv0veUNWD7CYi5LPAP1sHP
	gOCP+L/wqlHnoN7biQGH4km/+hj8fvk3uTVgXGRx5pUbIwDbohge1fWoDSH/l52KkVTLzBVOhAg
	GJtOFe1VAkbxqEjp1pGPT4Xywf6tB6eCNjqI6iAgKqsice4fQEQyzXPTSjzIe+Tj2AC1Yquq5Qf
	eEtR9k9/A=
X-Gm-Gg: ASbGnctZjX3GVKh2CXep7VkaUD7KqHoGQTAj1dCQpeZWY5xvruwuQ8zgBUShHrZJXvL
	cUvlnajMmLXH1tOni+uiCVTtCvoZ4bVZG3TJAu8151UVdHh8JZ0zGLtykLNIYW+/5y+LXacg/eF
	yA98dC1sRwc5tvxQLcEhs0OLcYNnbo99KC2DhgJcHvXY5+Q2SU/DmryA0jDhLF9tEKnADwJ4KDC
	5VTcoMZlTavbW/AUECq8V7sa9FXNLYccd8CFCLpHsqYaNiHii/8OxCN+7uIXgvagY+WtWMSd6nz
	jYsq90yX84wJ4i+V
X-Received: by 2002:a05:6000:2210:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3a561309d4bmr1368854f8f.15.1749709244931;
        Wed, 11 Jun 2025 23:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2RtRKGSbUvUXqFG5RCVEOgWfBzpJ3ZXPuVL/rUgYKBarLIkU9OJETs4KF/dDE8YU6wvHsPw==
X-Received: by 2002:a05:6000:2210:b0:3a4:f6ba:51da with SMTP id ffacd0b85a97d-3a561309d4bmr1368835f8f.15.1749709244571;
        Wed, 11 Jun 2025 23:20:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a56198a3b4sm980497f8f.21.2025.06.11.23.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 23:20:44 -0700 (PDT)
Date: Thu, 12 Jun 2025 02:20:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v11 0/3] vhost: Add support of kthread API
Message-ID: <20250612022012-mutt-send-email-mst@kernel.org>
References: <20250609073430.442159-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250609073430.442159-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qdDbf86WFn6Jyjtu8kdccuQ-e8izG6035TgGPvyiQxk_1749709245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 09, 2025 at 03:33:06PM +0800, Cindy Lu wrote:
> In this series, a new UAPI is implemented to allow   
> userspace applications to configure their thread mode.


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
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (3):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Reintroduce kthread mode support in vhost
>   vhost: Add configuration controls for vhost worker's mode


All of this should be squashed in a single patch.

> 
>  drivers/vhost/Kconfig      |  17 +++
>  drivers/vhost/vhost.c      | 234 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  25 ++++
>  4 files changed, 280 insertions(+), 18 deletions(-)
> 
> -- 
> 2.45.0

