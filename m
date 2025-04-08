Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEF26869D
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 11:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113378; cv=none; b=Uj8Ayfo3k4J3LFH+QqmLyFwwuY0bT5ys4scjBed1EW8AoSqm190KZFqoWuvh8f2wlErQg0jfCXJOHRGxsOBHwydLCXqm3QGkybtaIVVyp2E7/idj6sVL281Lg8c442bhes/IgsPK6Scarq4VJesL0aPxiG50vBqKOuVkJKasgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113378; c=relaxed/simple;
	bh=wYW1XvzQSniRNKIaNun7g4wBLkN0tc7NLsGQ8V1kHkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SOzIhkDIGYEm2P7MPBKXEd1c7Sf3WWxPiwWq6DAWp9cngTXw7/Ib5JisVEyasW8N/zYvPO0PLIx5/jUxYutv9LYCLONFgqF/Q73VXQoqghtv+QBsK6mzRKD6BiG5f1tXkYZ1MkVlk+dSHCocEfeHTrgbj7vEShJaegkL6+ckodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cI0jjt7G; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cI0jjt7G"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B062760903
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 11:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lYhciwcZMnes for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Apr 2025 11:56:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 06EF860862
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06EF860862
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cI0jjt7G
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 06EF860862
	for <virtualization@lists.linux-foundation.org>; Tue,  8 Apr 2025 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744113374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8NmMOJUiBDf2Mnm/32fYSinOOAarf9NGUqN9KbURsM=;
	b=cI0jjt7GnZo3QPB/VTHMSBmY35fOOh8PvlPuAFRlXJebQEP66LlHN4l1X8mUoYGxU2d2kf
	DPPfOOO9D1ME9JO7eeBE4+7ZgoxZfrd9OevZIzD1/7k3qguqv298Jo9fJsGFl2LP1XXwlI
	Lr3krpbAZ4g/Itsf889e9Y5MXnDLAq8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-lScXayfxOtK3tJC3gpQtQw-1; Tue, 08 Apr 2025 07:56:13 -0400
X-MC-Unique: lScXayfxOtK3tJC3gpQtQw-1
X-Mimecast-MFC-AGG-ID: lScXayfxOtK3tJC3gpQtQw_1744113372
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso3555047f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 08 Apr 2025 04:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113372; x=1744718172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8NmMOJUiBDf2Mnm/32fYSinOOAarf9NGUqN9KbURsM=;
        b=HI4YwR3beWRNkxM1BMEk4yWdBfA7RrEk6TD/bPert/Vz366D23qt0QYvr1oklHYyI6
         7Kp8hm0POnsOc1aNINL4GfIUbiYueTJJvcyVzGUIXJHvYe/wufxbwpD7Vp3mn+YP1Pi5
         kAE2KbQ9Y+jqS13IfJoqEwfAStdEDzmrj37ijTAJmk67nBlPZAYJtILltaYK+l66tm+o
         3v4rIRYHpwRoVqlaVKcy4DrvWwMr7P/GNbeo8k3yL1OZeQ6sofYRCD7nSdF6T1qWb60L
         bSZYhEhBqbXs7cai7OyXs7nfnjT9raThJOTBj8hrLA5a/IJZcd9GIS4mlAXdmSPPr9UP
         1Mdw==
X-Forwarded-Encrypted: i=1; AJvYcCVGDHX5kcE6EVfL98ak0yJt1Ts60KNTo9i14TxF55xl/tBpbNqBCjJkKLQSKg98ARwsXBAf8Iw1e+9j5XPbhA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzTAmQi34UPO6XO51hskt2vnhcoPTXCnIWId5nH6W8p+zkKdCvB
	NubP/3ujGzLZJ1kjSck85DpRn7tsiYDEmhT//qhagrDk4whmmpLG46+J8rTceRG1Ma1tAng/OYQ
	vTRcBqC0ZgnZ2o5cBJuquef+gYGSvOdkaep2rrzdPmdmiInHwt1uQojLb8bXj1qap9x6JimftyT
	YSOng=
X-Gm-Gg: ASbGncsMMX6vlLGYV5YUpuRdvD4zZRNXVYo5gffPXpNiPTcBAw4Y4MVRLWPmaOPvl86
	FbyZxH1GiJbH7eUzZfri9FZzCNq0gQ2WZp7J9q231ogxV1Eei+u4PDbe93WmbKpwOvl5KjJY2hx
	2HXP/YnD7/wSB888qKOqlOwDnuN1Ur4lvBIySNRYiUJlu6Tsh4EiVfbp5G21aZV9vpd+dOCv/Ej
	vZrbiMJ0FeBhAQb0pc6EzkfQIenwY+ydz5Fk9BqUOy5rxm3xKgrtOfoz/PIaMPeD+x8SuXiZsBV
	v2BDWS7fjA==
X-Received: by 2002:a05:6000:2484:b0:391:31c8:ba59 with SMTP id ffacd0b85a97d-39d6fc0c110mr8562978f8f.4.1744113371951;
        Tue, 08 Apr 2025 04:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcMsSZ5Gam/fQOpaIuoaRMdI4T7XugacA1lPSXA8mE0sG1MgVGLtGvlHpdN41g6650CZaIhQ==
X-Received: by 2002:a05:6000:2484:b0:391:31c8:ba59 with SMTP id ffacd0b85a97d-39d6fc0c110mr8562957f8f.4.1744113371519;
        Tue, 08 Apr 2025 04:56:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301a9da1sm14440447f8f.22.2025.04.08.04.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 04:56:10 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:56:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v8 8/8] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250408075426-mutt-send-email-mst@kernel.org>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-9-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-9-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L5rUj8q2c-8skHLjEuvoysd2Fy4pXwHR0ZTe4z_38ns_1744113372
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:52PM +0800, Cindy Lu wrote:
> Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> is disabled, and any attempt to use it will result in failure.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/Kconfig | 15 +++++++++++++++
>  drivers/vhost/vhost.c |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> index b455d9ab6f3d..e5b9dcbf31b6 100644
> --- a/drivers/vhost/Kconfig
> +++ b/drivers/vhost/Kconfig
> @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
>  	  If unsure, say "N".
>  
>  endif
> +
> +config VHOST_ENABLE_FORK_OWNER_IOCTL
> +	bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> +	default n
> +	help
> +	  This option enables the IOCTL VHOST_FORK_FROM_OWNER, which allows
> +	  userspace applications to modify the thread mode for vhost devices.

ok

> +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to `n`,
> +          meaning the ioctl is disabled and any operation using this ioctl
> +          will fail.
> +          When the configuration is enabled (y), the ioctl becomes
> +          available, allowing users to set the mode if needed.

no need to be so verbose - the disabled beavious belongs in commit log
not here.

Also either ioctl or IOCTL but not both.

> +
> +	  If unsure, say "N".
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index fb0c7fb43f78..568e43cb54a9 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		r = vhost_dev_set_owner(d);
>  		goto done;
>  	}
> +
> +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
>  	if (ioctl == VHOST_FORK_FROM_OWNER) {
>  		u8 inherit_owner;
>  		/*inherit_owner can only be modified before owner is set*/
> @@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		r = 0;
>  		goto done;
>  	}
> +#endif
>  	/* You must be the owner to do anything else */
>  	r = vhost_dev_check_owner(d);
>  	if (r)
> -- 
> 2.45.0

