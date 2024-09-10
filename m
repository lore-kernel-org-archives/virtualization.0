Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62F1CD2A
	for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 06:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949770; cv=none; b=N2wdwG5d5qmOEZcXEhgKLogXXlTQ3VaSAMUazbYReM6aaqrnMlrXp831590aGikNXXuxqILdPZ/HtqGUVUn4GH+ng0ukm9P4XXFqlxyAsrR7foKKNIRqb9WG9VFa7jwL2ng+lNPIpitBbU6aOEjpWV4AQxlR4rk+/EH4AD3uGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949770; c=relaxed/simple;
	bh=xYE2j6hsQhcBJCANyatZ9d21NJz+/bdQZjeik81Edl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b+LtZmJXnHLSshPDyZY7lbf99TUDp5It8in+9f+A2N+sO/CmUEL2IKNM2jKMttyUpq4wTYsqLfD9zezbGnJEkKh3YBWx1I/hjTioNfKumE6ygSwcpkFETNi5V/0pZk3NMqrqxHGWY75TfjuzUQ0Rht5Pge97FoK4I4xb6d5PU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWG0ruyS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWG0ruyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725949767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=slRCTHzCCcQBwX+pPISbs1hQFnemuMhepgFBpAq56NA=;
	b=dWG0ruyS5/UgOsszMkaDVqD7lth6I7V40sN27lkLMlZFR7Wfo46WlwXoLstJ+zGXww2Wnm
	f7PurEFNbRE+zIuS0IdTVNI7YHSAFmrPuoIyPkU6VwYB3LH60nO5nbG4jBAJx+TP7cX9gm
	VsZQUzWEvKAJeVl2oUEBJIWrnxV+9hg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-D6XSXdvjMnCs_hwMhr7U0A-1; Tue, 10 Sep 2024 02:29:26 -0400
X-MC-Unique: D6XSXdvjMnCs_hwMhr7U0A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so9037345e9.3
        for <virtualization@lists.linux.dev>; Mon, 09 Sep 2024 23:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725949765; x=1726554565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slRCTHzCCcQBwX+pPISbs1hQFnemuMhepgFBpAq56NA=;
        b=OdTgwmFbrbOYwnL7ssy4nxyKK+7JGmiN60l3ZDzSMf4GYt3AVvCom5ammmSUlBFbfk
         FBVk1x8BQ+HEP2XGGg1aPj/xN5CxbrF4Ln5EFAT8SrtYw3Uc55QLU16ESIXczFR1tjWH
         ql1uJwp5gp+ev7CrJVCqTj8wXZm3PN/MSBDQE9RteJtgfoF+ugnMWSOGraMZ+RzHbuWG
         SEi8dIEYhiEDCN4FwQJy3tY/i3g+syPxY/wpcdv5zXhjYbL2GId3B0+7ZPlG0Y0zITGy
         /f9RsUARsQSwUNN/+YHHIPWHZAuDm+AMfDUDlmoOe4VIGsCu33gwM5Cs1otwNgM14qGJ
         Hm0w==
X-Forwarded-Encrypted: i=1; AJvYcCVt7oZN6GR5eHzo/Uvxo0Kj6Rgaq8E2brtYAjdmKB+m1q5EY3EFHJUXjwQE+f+xwVt7xc+nJt24nV2IhVtx/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywr2T9PummVwfDHyWpiOf7472cvLRnxqQwjyoxaU3RXwT99f/Rx
	BpDg6LdLyweCu6OsRSNEYDILkwZ78rVJj/iLcMPEKHp3iVAWUHXqeQdgbDcd1BQ7lXnyXRiwEBr
	BFt5gnBk687RognEsTk9wUnzEYF6UZwCSZkD3gauqcr26yqC3c64XGcQKGzaydn+B
X-Received: by 2002:a05:600c:1c10:b0:42c:bdb0:c61e with SMTP id 5b1f17b1804b1-42cbdb0c782mr14797465e9.13.1725949765346;
        Mon, 09 Sep 2024 23:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6kk2YzMvA4RngNvuADaIpUJvCPpWuMQGvfkxNqLt6NjTpt10YtpZLMbS8AlyZJ/UVPyyijQ==
X-Received: by 2002:a05:600c:1c10:b0:42c:bdb0:c61e with SMTP id 5b1f17b1804b1-42cbdb0c782mr14797045e9.13.1725949764207;
        Mon, 09 Sep 2024 23:29:24 -0700 (PDT)
Received: from redhat.com ([31.187.78.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb323f4sm99266095e9.12.2024.09.09.23.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:29:23 -0700 (PDT)
Date: Tue, 10 Sep 2024 02:29:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: dtatulea@nvidia.com, jasowang@redhat.com, shannon.nelson@amd.com,
	sashal@kernel.org, alvaro.karsz@solid-run.com,
	christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com,
	bilbao@vt.edu, xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
	eperezma@redhat.com, cratiu@nvidia.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Carlos Bilbao <cbilbao@digitalocean.com>
Subject: Re: [PATCH v3 0/2] Properly initialize speed/duplex and remove vDPA
 config updates
Message-ID: <20240910022843-mutt-send-email-mst@kernel.org>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2024 at 10:11:13AM -0500, Carlos Bilbao wrote:
> From: Carlos Bilbao <cbilbao@digitalocean.com>
> 
> Initialize speed and duplex for virtio_net_config to UNKNOWN (mlx5_vdpa
> vDPA devices currently do not support VIRTIO_NET_F_SPEED_DUPLEX). Remove
> ioctl VHOST_VDPA_SET_CONFIG and its related logic as it is not supported;
> see: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
> 
> Carlos:
>   vdpa/mlx5: Set speed and duplex of vDPA devices to UNKNOWN
>   vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance

This will need a rebase. Will apply once you post one.
Thanks!

> ---
> 
> Changes since v1:
>  Link: https://lkml.org/lkml/2024/8/29/1368
>  - Fix prefix of the first commit and add Reviewed-By tag.
>  - Redo second commit completely: instead of attempting to add support to
>    set configuration fields, remove ioctl and support entirely from vDPA
>    implementations -- because it's not allowed by spec.
> 
> Changes since v2:
>  Link: https://lkml.org/lkml/2024/9/3/1407
>  - Fix first commit by changing 4 spaces for a tab.
>  - In second commit, ENI is legacy and should keep set_config(). Change it
>    to set_config_legacy() to avoid future confusion and erroneous
>    implementations.
> 
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c    |  2 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c    | 10 ----------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 19 ++++++++++++-------
>  drivers/vdpa/pds/vdpa_dev.c        | 16 ----------------
>  drivers/vdpa/solidrun/snet_main.c  | 18 ------------------
>  drivers/vdpa/vdpa.c                | 16 ----------------
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 16 ----------------
>  drivers/vdpa/vdpa_sim/vdpa_sim.h   |  1 -
>  drivers/vdpa/vdpa_user/vduse_dev.c |  7 -------
>  drivers/vdpa/virtio_pci/vp_vdpa.c  | 14 --------------
>  drivers/vhost/vdpa.c               | 26 --------------------------
>  drivers/virtio/virtio_vdpa.c       |  9 ---------
>  include/linux/vdpa.h               |  7 ++++---
>  include/uapi/linux/vhost.h         |  8 ++++----
>  14 files changed, 21 insertions(+), 148 deletions(-)

