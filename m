Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E1ADDC3
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819314; cv=none; b=AlooK2eFJ/erQ7GXwbHfkNi0Fh2ilgQG3yW32mGzu2dNfQit8bdabIEUj5AUXW/L4onKxrBn/29THubUndwZ/4vG8b+AMthBgibl1eCvSiENIriBYOpe9PoergyP8e/1QY4Iko7CuByNVRAS85qNSPXr8VZRiFvIxm2uA5hnZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819314; c=relaxed/simple;
	bh=7NPx0m69QGK/K52N5RPTJZOB/2IxrbETFrl7bRUu6hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NAovz5DmF79WXnK7DlU9Nndcj51aMQrRR194Nlu1d0/MDrnI4DZ9jn1QD4Vs0eoyaGCFNm+c89ptrr5hr+1h1gqzUivxFeBzedkQ0obd3v22DgJxx23xkzWg+nOeaQy/ziScSq9+gIDoR8MgLmDEqdmkua9OnTKS6h7WsSuvSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAupx9za; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAupx9za"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713819311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NIMZzutzj5URGu2VjD1bhrmGI/gglErZUqfLIOoWVfY=;
	b=bAupx9zaWgEw6DsE66Koqxv1otcPB02m5KBhzuKpHk5q177/3npXweCjCliFg2QaAwgbl1
	SpW5q1n8a3XlDxLInTC4nwujgYow0PdG8vyUCBlZlEkjZyiX88NQ1kAxLScQmwp0DsVttH
	xRIKyRGf+ui3nNlNVAJpx9OYdMIbAa8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-u8JegTPDN_aH2O77ZnYvqw-1; Mon, 22 Apr 2024 16:55:10 -0400
X-MC-Unique: u8JegTPDN_aH2O77ZnYvqw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-418f8271081so17864935e9.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 13:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819309; x=1714424109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIMZzutzj5URGu2VjD1bhrmGI/gglErZUqfLIOoWVfY=;
        b=tFSDEGAQAM4hnrV9HGo7q6ge5Nna46nRzYI6OuUsr2C8kCv3aBtEX1E/ceoqwnKfqD
         cD8ba+36hjtR88lu6y/hu0Cu/dNxXWBfoj/7sTaV264aqO3ZLWeD7Do1moaMkMz53FRr
         XU8CQUTA4P+qP8HHt7qfNOHpy2vmKLu4RhAnpT7WLc0ZMjp+ISIJ0UspE0dAnOvcJlbj
         rZVVbwbmaG4e51StZdIpP8OedH1aYV0x+U34+pDevAZZvK9qXWodJv4rQWPcQKpfnvpm
         Mja3jKLkAgla9qxqcqF9qB2zTb07AVyHqncRr0n5mqRLYxqltppGnZoXTBjn1De469Xq
         +dbw==
X-Forwarded-Encrypted: i=1; AJvYcCVNrWkPgx44c1FNZtU7ALaBV6C2JPeiQyAcCxoYNlRNNe5Z1VBGtpOYpCV7CjiY3NHPH31Su0+0EnR7oFFFq7/3rTxl42u3iymMqx7t6Wo=
X-Gm-Message-State: AOJu0YwjISTBSMCc9RG1HI81Po7FZsR0A1AnQgCYz/R85OBKZugx19dj
	z7KhkleVqpTe111iDFe4I20LMYhmIv8TGU4jf/5XoFKSHwB3G0X4fOUesFrWcewJqfHaVFSzkAF
	f40Zmc4uu6eajiTJQ0F8GMa8iMAMCmwN2yMdj8PajOuF1dUKLpTpqfa9unsg0hbap
X-Received: by 2002:a05:600c:1c1c:b0:419:ea21:2d83 with SMTP id j28-20020a05600c1c1c00b00419ea212d83mr7428167wms.0.1713819308936;
        Mon, 22 Apr 2024 13:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpNSfsyjNS+1cIbZ2IqGyPSbY18hXu6dedSNGqEbkI9BXf4Gw8EwTjzkQX4Y3Oxp7OeMckzg==
X-Received: by 2002:a05:600c:1c1c:b0:419:ea21:2d83 with SMTP id j28-20020a05600c1c1c00b00419ea212d83mr7428147wms.0.1713819308421;
        Mon, 22 Apr 2024 13:55:08 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b0041a652a501fsm3976008wmr.13.2024.04.22.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:55:07 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:55:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net-next v7 0/4] ethtool: provide the dim profile
 fine-tuning channel
Message-ID: <20240422165456-mutt-send-email-mst@kernel.org>
References: <20240415133807.116394-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240415133807.116394-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 09:38:03PM +0800, Heng Qi wrote:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a way which the NIC can
> be custom configured is necessary.
> 
> Currently, interaction with the driver is still based on the commonly
> used "ethtool -C".
> 
> Since the profile now exists in netdevice, adding a function similar
> to net_dim_get_rx_moderation_dev() with netdevice as argument is
> nice, but this would be better along with cleaning up the rest of
> the drivers, which we can get to very soon after this set.
> 
> Please review, thank you very much!


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Changelog
> =====
> v6->v7:
>   - A new wrapper struct pointer is used in struct net_device.
>   - Add IS_ENABLED(CONFIG_DIMLIB) to avoid compiler warnings.
>   - Profile fields changed from u16 to u32.
> 
> v5->v6:
>   - Place the profile in netdevice to bypass the driver.
>     The interaction code of ethtool <-> kernel has not changed at all,
>     only the interaction part of kernel <-> driver has changed.
> 
> v4->v5:
>   - Update some snippets from Kuba, Thanks.
> 
> v3->v4:
>   - Some tiny updates and patch 1 only add a new comment.
> 
> v2->v3:
>   - Break up the attributes to avoid the use of raw c structs.
>   - Use per-device profile instead of global profile in the driver.
> 
> v1->v2:
>   - Use ethtool tool instead of net-sysfs
> 
> Heng Qi (4):
>   linux/dim: move useful macros to .h file
>   ethtool: provide customized dim profile management
>   virtio-net: refactor dim initialization/destruction
>   virtio-net: support dim profile fine-tuning
> 
> Heng Qi (4):
>   linux/dim: move useful macros to .h file
>   ethtool: provide customized dim profile management
>   virtio-net: refactor dim initialization/destruction
>   virtio-net: support dim profile fine-tuning
> 
>  Documentation/netlink/specs/ethtool.yaml     |  33 +++
>  Documentation/networking/ethtool-netlink.rst |   8 +
>  drivers/net/virtio_net.c                     |  46 +++--
>  include/linux/dim.h                          |  13 ++
>  include/linux/ethtool.h                      |  11 +-
>  include/linux/netdevice.h                    |  24 +++
>  include/uapi/linux/ethtool_netlink.h         |  24 +++
>  lib/dim/net_dim.c                            |  10 +-
>  net/core/dev.c                               |  83 ++++++++
>  net/ethtool/coalesce.c                       | 201 ++++++++++++++++++-
>  10 files changed, 430 insertions(+), 23 deletions(-)
> 
> -- 
> 2.32.0.3.g01195cf9f

