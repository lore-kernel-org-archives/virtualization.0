Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4C77F08
	for <virtualization@lists.linux.dev>; Wed,  7 Aug 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038700; cv=none; b=WM1jj7M48jyF4GmgEteqGUnkUHz3iqRxm4woo/+4CkC5qMyT85yZwPAe9++U2np51uEnqfj6vM6kaUMRzVP6xnnoi2KBTfX+kllJtpXGF8hrQ8VSLWAo0giCGUHooQzwmFk1qe3+par0MGE6mIlvbWtRSjX4KXJxO5k/Qkc7Uug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038700; c=relaxed/simple;
	bh=BGi0niil7ZhDHyq+NZ6JdNNg1TfEYTESPyfrYYgGC6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=s+SOvbmyOHpX++mJQq1UGGX+6CHh5vcI54NYXPbeAfoU4H1/WFg66RJD6LjkHcu2Zu6tERwWlxP2lGCILtEg+bLYwiVcalZFYfZOI7nc8eDVWexF3hJvb9d0c+WU7Fg9Q5e9pL14n23EOni1E94hJudsKeV/+yv9E5E0Ie8sOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z52g//A4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z52g//A4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723038698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeN30O0br2KcNUsWMzAJND3zzsH9WsTjuBPNWdcC/qM=;
	b=Z52g//A45+/H4mvOPCThUEmRZFwzDnq7XE9s2k+MsipATPyATumeG2ih3Oz3ZM1qcr5Hmt
	7mof0LGBs/o0fNSJcy5PITry+MROhA82La+XSPN/ZhOAohXDHsN+WvIyVU5wPHLQhkgZrD
	lQGq86e7v+0dc1p+YPo9HYewQToZtmY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-Zjktv9f5P5COD5dYCKLY2Q-1; Wed, 07 Aug 2024 09:51:36 -0400
X-MC-Unique: Zjktv9f5P5COD5dYCKLY2Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42820c29a76so13303975e9.2
        for <virtualization@lists.linux.dev>; Wed, 07 Aug 2024 06:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038695; x=1723643495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeN30O0br2KcNUsWMzAJND3zzsH9WsTjuBPNWdcC/qM=;
        b=IVA/OdILJBjK8fHMYsD9mkgljLr4LHJWPLP9ATByowBkP9i+jZdBbobrLKZG5/VXH+
         3f9XjVKtjywX+cEmHrWoU4MT84rwJKlQb1LQ3rh6e0dMczCcjInm1iNrlQbjyxQkXwRL
         V4ukXtoGobFSx+5zJrNhyNoy69NHTMWQohHbR/Np4KXBfL/JCTIQdLfaZN2C5DKz4reM
         hZUliO0NwaTJ03B9txF2ds7jYv/tOBF9GlsdD/BOAHQNLeQVprDPGPOceaH9bRiVStQe
         iszkuwt9CuAAkqvD2RMBwZzWPzuLTaALA7cPH8lDaA9Pee9OIKcssaz/ilYogPvrr4yE
         zZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSVaXozsG563ynzG6akhD97q5jVLmHVp1ttIn3A//WNH66VNQSk/q99xatjItbBRfOmJmBASsVgqPQLePcXzlUq7x8g72IHgQeSrGxOtg=
X-Gm-Message-State: AOJu0YyDm0FrXidI91OHbMTMsrsGYfxbIk8tDiDREY/pSXgsrbVhXDB/
	SZRCV9mXuCZwtQDbqMw1is8dA0hHoS5B2A7TUyA4XqjZDvlaSrgUiejzXfVmdA1uwiE2uv4woZP
	OSVL4UeV/r/dk5OvzpbEc4tHql/8x/AKh26KaexBGY+d+LtizLbsGZ0uHjDCwVeCK
X-Received: by 2002:a05:600c:4f12:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-428e6b7c13amr127656945e9.24.1723038694934;
        Wed, 07 Aug 2024 06:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhVFXgTXOjAYJDRv4mghT8BBwotFekv1SrhkpxYI+/Pu124Fj0jnbNi/dHqZyErUwSt44fSg==
X-Received: by 2002:a05:600c:4f12:b0:425:7974:2266 with SMTP id 5b1f17b1804b1-428e6b7c13amr127656675e9.24.1723038694161;
        Wed, 07 Aug 2024 06:51:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:efe1:812e:e83a:2c34:ce60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059713adsm30818505e9.11.2024.08.07.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:51:33 -0700 (PDT)
Date: Wed, 7 Aug 2024 09:51:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	inux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V6 0/4] virtio-net: synchronize op/admin state
Message-ID: <20240807095118-mutt-send-email-mst@kernel.org>
References: <20240806022224.71779-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240806022224.71779-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 10:22:20AM +0800, Jason Wang wrote:
> Hi All:
> 
> This series tries to synchronize the operstate with the admin state
> which allows the lower virtio-net to propagate the link status to the
> upper devices like macvlan.
> 
> This is done by toggling carrier during ndo_open/stop while doing
> other necessary serialization about the carrier settings during probe.
> 
> While at it, also fix a race between probe and ndo_set_features as we
> didn't initalize the guest offload setting under rtnl lock.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Changes since V5:
> 
> - Fix sevreal typos
> - Include a new patch to synchronize probe with ndo_set_features
> 
> Changes since V4:
> 
> - do not update settings during ndo_open()
> - do not try to canel config noticiation during probe() as core make
>   sure the config notificaiton won't be triggered before probe is
>   done.
> - Tweak sevreal comments.
> 
> Changes since V3:
> 
> - when driver tries to enable config interrupt, check pending
>   interrupt and execute the nofitication change callback if necessary
> - do not unconditonally trigger the config space read
> - do not set LINK_UP flag in ndo_open/close but depends on the
>   notification change
> - disable config change notification until ndo_open()
> - read the link status under the rtnl_lock() to prevent a race with
>   ndo_open()
> 
> Changes since V2:
> 
> - introduce config_driver_disabled and helpers
> - schedule config change work unconditionally
> 
> Thanks
> 
> Jason Wang (4):
>   virtio: rename virtio_config_enabled to virtio_config_core_enabled
>   virtio: allow driver to disable the configure change notification
>   virtio-net: synchronize operstate with admin state on up/down
>   virtio-net: synchronize probe with ndo_set_features
> 
>  drivers/net/virtio_net.c | 78 +++++++++++++++++++++++++---------------
>  drivers/virtio/virtio.c  | 59 +++++++++++++++++++++++-------
>  include/linux/virtio.h   | 11 ++++--
>  3 files changed, 105 insertions(+), 43 deletions(-)
> 
> -- 
> 2.31.1

