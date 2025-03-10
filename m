Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C91DF72F
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 21:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640941; cv=none; b=lrzuh0mH/otOL7A9Ucosn75yrlyS0j7vtW4i1YY5nDseab2MHD3PFGe6oBggWpev6zZQdn1slPWBYXrUBDBF4VbrBML79BqZcao1UL4tP7KfHhQ3yO0kC16ZqepJaS7iHMAtgFxCdAP5tRtuh8anMujPc06sBa7VMkU4azzCZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640941; c=relaxed/simple;
	bh=L2wq15UItCiN04BIyCvZmtzf97dq/7ag+fNk4WjCasg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGYFMeaJ/cePDZRGb+2NtYOBm+3LhAWWoqgDL7gknUd+kDPTuYVY4tZRj1nlb8z6HIIG4+nFejSxIU7I+rcAeNWAEEdLOSu2MkB5MP6D5hq2e8tUB6ktQKFwh1TLqGjmuW4w5wi3llM03FJzgsU5rE+W10Er9ShIt0A7RHxtZbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOlds9A5; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOlds9A5"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0021581268
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 21:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TpWx0DVu6fO3 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Mar 2025 21:08:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E751B811E8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E751B811E8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HOlds9A5
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E751B811E8
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 21:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741640937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SvMGLxhh+ZiXjvBM74tRFWSSYebdSD0/MkQ6jTYRHSk=;
	b=HOlds9A5bASAcMBNZCJqbGRv42xG6Kqg8b4kre40+Sswdnax/eZO1nLSzgi0rmcTdLeDr6
	PzNFJGdfbT3ouwGV5+tD29lx9EL1G9gfolDp1LDfbQu6F4MYgye7vLTyuQp8QxbZaCXNAo
	ONIz7g8TwKS7s/do7Y+5T+6F8K/U0XQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-RReKF-bcO5GmqTHbOHNfGw-1; Mon, 10 Mar 2025 17:08:56 -0400
X-MC-Unique: RReKF-bcO5GmqTHbOHNfGw-1
X-Mimecast-MFC-AGG-ID: RReKF-bcO5GmqTHbOHNfGw_1741640935
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d44e9f0e69so2961655ab.3
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 14:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640935; x=1742245735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvMGLxhh+ZiXjvBM74tRFWSSYebdSD0/MkQ6jTYRHSk=;
        b=RZMkg9lYCjMVp3uAiPlP8gRHLriKdlGlzOuJ4DO5LbVhBL2yqnM9eIAH7w4rhX7+sm
         vimxqLUMAIhJOE4NBL3ffl/B7n7mhOyQXoVksKTS5yYE893YB1UE3NJNXkpzGO4War+G
         4yuCQ6+ce4QJrskGbpm+M/KMMWJOkxYOcS3OODsOKZ1xT2LVUH4wRsVjGSaxB0fDC+yQ
         GCTEe65au0R58ToHcGBaxRptbBvfx5tF6Bky3XMFKxyaMF5JippDSXoFcMqg/u6EbmIA
         5kWUfLjEiFawib/3Gr2vW9Kg95KhedwxQvuOukjC+0SkS48jCWMPaWv4KwL9iJlopCQ2
         5oBg==
X-Forwarded-Encrypted: i=1; AJvYcCUNshm+FiPJyOXzktOtWa71VkhCAp/GvWjVl2kuzgsxNtNH253pcGCq3PZGORcENAjzFP6tYQIsIxqODZfg1g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx0ZYsIm5UVL3qGntnNGfTzqax3WkLW0CawitsD7I+Zl2yG9zYa
	av4KvRGkb+xCrSbHyqVEbcwPik3Pysu8adY/GdzVzjd0mkbKNeYSzpM7Ayv5zDTmimbUOq7zhGd
	6H++mUW54QF9ZvUJNvFtyXzeAeZMh/GLINzHsYLYEZzB1xsskjJ1Y+kDEcAf5kfMVrCGeyayDyj
	9o6FQ=
X-Gm-Gg: ASbGnctJqFxWv+rJ3dK/DM7cWFFSO+k8jMhMDaY3Li8GADRahalvKZG7uvi+nuuclst
	a4ABrPdmtHn8qc+VdlZebsc/vreWuIQEcOvns9UFnVgUDGyCzOS5VqR/F+WIAWnTCIFEMIvOOy1
	6l5leqwtQlhF/V2C2l5HAyYOf1aSf7CKNw7Ml3/htyG3x5iwlO+zoAZ5MPRqqh1Zdt2cMNl/MNf
	6G1imDKcIgxnBnXzQm0m3vt0QrOJiAmtID7rQFjERT8WAYQvk/sWM6+9ujV0/ThLfVFFsPJwTIT
	Hqc50HE7tG9xPxEDKfI=
X-Received: by 2002:a05:6e02:1a24:b0:3d4:3d13:e5fc with SMTP id e9e14a558f8ab-3d46899f135mr3923655ab.5.1741640935361;
        Mon, 10 Mar 2025 14:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmNDJ2pRGpp9uY0mu1cCccVjJS8JHYTtTcVWJbMxUlnrc80/38LgZSUF0a1GBpMv/1LQn6Cw==
X-Received: by 2002:a05:6e02:1a24:b0:3d4:3d13:e5fc with SMTP id e9e14a558f8ab-3d46899f135mr3923535ab.5.1741640935057;
        Mon, 10 Mar 2025 14:08:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f21552b5d5sm2031142173.77.2025.03.10.14.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:08:53 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:08:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <jgg@nvidia.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <israelr@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 vfio] vfio/virtio: Enable support for virtio-block
 live migration
Message-ID: <20250310150850.5d61a387.alex.williamson@redhat.com>
In-Reply-To: <20250302162723.82578-1-yishaih@nvidia.com>
References: <20250302162723.82578-1-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NnLkGfcodFVmqysxlc_JKeUFIZC-XqFv2D9mJEbI_rY_1741640935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Mar 2025 18:27:23 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> With a functional and tested backend for virtio-block live migration,
> add the virtio-block device ID to the pci_device_id table.
> 
> Currently, the driver supports legacy IO functionality only for
> virtio-net, and it is accounted for in specific parts of the code.
> 
> To enforce this limitation, an explicit check for virtio-net, has been
> added in virtiovf_support_legacy_io(). Once a backend implements legacy
> IO functionality for virtio-block, the necessary support will be added
> to the driver, and this additional check should be removed.
> 
> The module description was updated accordingly.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
> Changes from V0:
> https://lore.kernel.org/kvm/20250227155444.57354e74.alex.williamson@redhat.com/T/
> 
> - Replace "NET,BLOCK" with "NET and BLOCK" for readability, as was
>   suggested by Alex.
> - Make the tristate summary more generic as was suggeted by Kevin and
>   Alex.
> - Add Kevin Tian Reviewed-by clause.
> 
>  drivers/vfio/pci/virtio/Kconfig     | 6 +++---
>  drivers/vfio/pci/virtio/legacy_io.c | 4 +++-
>  drivers/vfio/pci/virtio/main.c      | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)

Applied to vfio next branch for v6.15.  Thanks,

Alex

