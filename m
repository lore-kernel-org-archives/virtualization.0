Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79921F940A
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339000; cv=none; b=Co/9JGpNwlTEmhl2lbVQP1m4wA0OZS6DnUS8xaw3Nf4N0uWzzsDZlUEuQR9ygFtdQDzamoti4UMr+SfSvK1lMskQMZ/TF+6OYIxKtzHF/w2k+/z8U9+g/WlI9cQHihJxZi6ALVa2jSjBScWhNAp2jMR3c5h39GT1jRYjscreGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339000; c=relaxed/simple;
	bh=CYEL1xsMWMcBwANmoFnaeB+RsMLozxlw7Y9ZKV5IL4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nxNMuZKi7Q4od0jY/NSHkDiPf1m94TL416Wra0eZQ6PYkwz3SPy9JOVlZHGFLh2cVoR/SpEimGJ4OLR8aBO9nrmZNlk52HeE9PH9FIqZFY68P0tdVGu679eCsABWBVBz6P6KMcGz22hblUBka8hsr3OjeSsfVxwF4/Ow1LopbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdP9n+/f; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdP9n+/f"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56397401F1
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygPEpJQoadjj for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 12:23:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 51C68401D8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51C68401D8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JdP9n+/f
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 51C68401D8
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736338997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jtNPZrhPuEXDAUmk7MMSLxT+pmGkUlhGX8IMqmFXcVs=;
	b=JdP9n+/f26cNTN/O2msmEFR97+TcyDAeJZCkhXueCJ+NJZ89O8GYtrGLc+GCsrP3rQDN1t
	iD3x7Ak9I/8fN6Qz7ZNRLr9mvX8gPQ2J1LlgOwkEyhW2ttey9rhY7Dr7MFuqF3NqqrI4Yn
	iclafhAll5B76GWZKhhCFmNSLjqw3Cc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-tWK8jy-kML6Vc6NvEZV6Ag-1; Wed, 08 Jan 2025 07:23:15 -0500
X-MC-Unique: tWK8jy-kML6Vc6NvEZV6Ag-1
X-Mimecast-MFC-AGG-ID: tWK8jy-kML6Vc6NvEZV6Ag
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aaf921b8a85so591352066b.0
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 04:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736338994; x=1736943794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtNPZrhPuEXDAUmk7MMSLxT+pmGkUlhGX8IMqmFXcVs=;
        b=Z1DGnqVQaMExP/3Fwm1SGESCKyo2CBW6Cjz7vYK6S6Jf/jF+M53xt7BdeSepRm3EUG
         Ly/uHdqxQDkvXvvtLRsPY79ntR30aDXKRQ9gX3cG/MxQjf4HwNaZKtZRquKlWXpnpjsq
         N24Lx04R+PsJgRzgq2U8bY7bQ4MP5f/8kJodmxKBQqEhceYyxOTfjgX4VeRz4rRbYqrn
         a4ekln9AU4/oebjGStRovvk+gbUPGtdgGikmn7X8HmqNwEMOLxPgKqsrYnJDmaCkTisg
         U9ubJBKCpmg78Dmd+8qb7qtgIo5i7E+jPzhANpco9C3kQW+mPmMAciHb/p8O6Y8QL2bA
         /5zw==
X-Forwarded-Encrypted: i=1; AJvYcCVlPffwiHGLXIiV6b9mkIBCcb6C2DoVTOtDE90NwJ/CYDzRoY/UjS9ZoMM9jbsNGZQy+/06vV9m30qCBd9s+g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyNgPOBTWzdb247pGJ8cH9PCaDq5ftyZ8xkjSbK8S1zdPUx9NM6
	9eDRP27at8V71ycCBImcv5nfu0wXSB9rUuT6r+d3KLS7Mcf8yJUen1rMDyyW2uf4Ffr8j5jVrtA
	joLfgvX6tOXqFvng6lGrnpV2/nLEkWNQf66lFh7/JoL2ThK4CTGzNFH6utSN/EyTtkpZOJ/zox7
	xnw6k=
X-Gm-Gg: ASbGncvinMdQQ1MdrV4d/TLzInGLHZAUBHdqCNiddUdfih67lrPiXgWWxDVQwAOeoCo
	MY1lM4AKD+GUIyFQciC7ZmbQA+N9IStm1C9+DgWWrDDgwEJnrGq/OqsmZ38rd5bLyRG78F7hI6j
	sXMYysEQYG54uzBXcjZyplDVMdrKoL0ak+iYMdgnvh6B1J4gt+aq3hAnzS60SrIfc+/nfdLJa8v
	5ksq+fBxuj0bCHrqAILW6A3DLvFBgZCg//i1ZmX/5ks/B8w3AI=
X-Received: by 2002:a17:907:1c96:b0:aa6:6a52:970 with SMTP id a640c23a62f3a-ab2ab6a7603mr214442866b.1.1736338993621;
        Wed, 08 Jan 2025 04:23:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgJ2ItxqbcNpBvhzA7PF267wqdTMYaBrex8PA7k15rP1ubt/sLuYmBO/GJPJLWwYew7P6vYw==
X-Received: by 2002:a17:907:1c96:b0:aa6:6a52:970 with SMTP id a640c23a62f3a-ab2ab6a7603mr214439666b.1.1736338993060;
        Wed, 08 Jan 2025 04:23:13 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f616sm2481777466b.41.2025.01.08.04.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:23:12 -0800 (PST)
Date: Wed, 8 Jan 2025 07:23:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 0/6] vhost: Add support of kthread API
Message-ID: <20250108072229-mutt-send-email-mst@kernel.org>
References: <20241230124445.1850997-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241230124445.1850997-1-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zpD5ocZdYuBoD84Ezef7_coEUUrGTZeR59NJisptNAQ_1736338994
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 30, 2024 at 08:43:47PM +0800, Cindy Lu wrote:
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),   
> the vhost now uses vhost_task and operates as a child of the   
> owner thread. This aligns with containerization principles.   
> However, this change has caused confusion for some legacy   
> userspace applications. Therefore, we are reintroducing   
> support for the kthread API.  


I briefly applied this, but there seem to be a bit too
many nits. So I will wait for v6 with everything addressed.

Thanks!

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
> Tested with QEMU with kthread mode/task mode/kthread+task mode
> 
> Cindy Lu (6):
>   vhost: Add a new parameter in vhost_dev to allow user select kthread
>   vhost: Add the vhost_worker to support kthread
>   vhost: Add the cgroup related function
>   vhost: Add worker related functions to support kthread
>   vhost: Add new UAPI to support change to task mode
>   vhost_scsi: Add check for inherit_owner status
> 
>  drivers/vhost/scsi.c       |   8 ++
>  drivers/vhost/vhost.c      | 178 +++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h      |   4 +
>  include/uapi/linux/vhost.h |  19 ++++
>  4 files changed, 192 insertions(+), 17 deletions(-)
> 
> -- 
> 2.45.0

