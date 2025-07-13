Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA26FC3
	for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752411988; cv=none; b=tJNSi5R1xnXCBAIdSr9CtK9TuXsJpcS2RbZwEJWjXkjGGQq1VSuf8gHGoM3fTRo14I1z1q3uNXPE2ggs6xDsCXhUhmKNQLpjOq1SAfxqr5D83NWD+7QjYOys3WT36rAQF0DE+0s6JDQJXVSpT3yo+IgfmEPu1GYycLu2fWi4oog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752411988; c=relaxed/simple;
	bh=Z274H62C1qWQ4ePX6hvPQlxJcpneSxKuZ/SeTd9UfVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oa/P9W1aao5FnYWcmFtV4v2x0Cq5VG0wdQp530Lx7p2WhYBIpH0iyNU09ZLPI2KGmsbvhqh0EicyW9yd5VzkNv6YCbsWHfWfhXDit2CZ6yEQDlC0xMlZ/i5o5uygxUKJbotC4ksv2r2WzlXgfI21vhtmxccuijP0arXLgzFocoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/P9NVMP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/P9NVMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752411985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZ7DFGM4h3wwXXGccC52KVAC5yN9Y5zw8awmuxOwTcc=;
	b=U/P9NVMPLre+sgEjnm6OTkjXHZ5YcHefNZrF9tNy86tSjPcr7oFQ81DCPUh0r31O0r+Cvx
	xK16K8hjdVR6qVPqsNVITgCsfnsF/f7J7b25bTsQrKpvyI/cOGd9IoIRtX66iOKOwlLFY4
	nAS8OFCsEdpMQ/kuQDHLKoM8yo4jexE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-KU1e7-pNNbS_Mr5cTsF8OQ-1; Sun, 13 Jul 2025 09:06:24 -0400
X-MC-Unique: KU1e7-pNNbS_Mr5cTsF8OQ-1
X-Mimecast-MFC-AGG-ID: KU1e7-pNNbS_Mr5cTsF8OQ_1752411983
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a52bfda108so1727900f8f.3
        for <virtualization@lists.linux.dev>; Sun, 13 Jul 2025 06:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752411983; x=1753016783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZ7DFGM4h3wwXXGccC52KVAC5yN9Y5zw8awmuxOwTcc=;
        b=nxhhal/u9YhPYdrTLQqrwVJ9+98BMPJYezQzQNxJuUYLKcxOQKTvmfQfvIByzkI/Hj
         Tvoe3XTXCEOGkH1Kxj7q2AiZ/q+G+EGiVBPGBV/b3fC7HT+oIy+AzLVRjFveWeVfqJ5K
         QHXrNbNxGgqY3978BDWSD/7o5z5SosJVLNwPGNI27AYsIuIgoqIO5zD7myMRMimLRc1J
         ebHunSEsI6tZvdpV5pcX9SnnmT1oLhxvPSP9e9XLq8kfncWBj4AajcXkQ/gOOKTNZauA
         LdYJy/iAtxRu5+3+U+sW+LsW4Gxm0QP6TTF/8dmxc8ILCLVEIew40jagH9HlruYlJBh2
         vyGg==
X-Forwarded-Encrypted: i=1; AJvYcCXP89DHU7q8m0XzWVxTJBYOAkVJFMkgsmMTx75WvgNhdD6UQ4y3+o/JHgmpR6PttCw0B8gPmHMTJPKt7ch89Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRSwNfkXpftZz1tHyaFwMNCeDL2eTRdalyOAP86tfPHJzx3sf9
	JImh/RaPylkaYNIuiF+4pf+riROrPUfsjEl+vf/HT2SYzC+e8szAol0mFKB3wSWdwUTCLsDRrSo
	LAyz4HIo9n7QZSz9uodVv8D2YpmNGo+tRhN2EclGauMYjF1PEfSI9vXblqr3AgXztDeQE
X-Gm-Gg: ASbGncvo3X5yRUmLKxlRaVgZ5f3WHBMDkUesSlQSAkA37EbjZ/7s6UWCot6jDA+TYdh
	D3llvBR6D6sedVsLU+wDbD7QUaHbUbOL3gkeKK/dYWjynKZ9VhGXiSdvVHv5wdvFxoWdmlmJwF9
	Y9Xo+ddCM8sVSvEwuoJeOyCR1AqGiVBlNF14WkdHdheJHKyGHcVa/waXUS2R5L5cEUPxeaKcASk
	A8rMvLj0t3ej/p9/MWeIUn5FQOCOVCNHE95duuizrhfGKFoSIXn1CKaTsojir7jeMWaCs6c1hlU
	rfDoeLJVv7qC9Tq4VinXIa9jSGB4oJMj
X-Received: by 2002:a05:6000:4310:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b5f351eb04mr7209978f8f.12.1752411982751;
        Sun, 13 Jul 2025 06:06:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE2ys4qL9+YtIzIALr0+tTYJaMx4eY/a4wPb9tFRfyrsCkVtVpx+ZFnEMifQUzh4YJURVoTg==
X-Received: by 2002:a05:6000:4310:b0:3b3:a6c2:1a10 with SMTP id ffacd0b85a97d-3b5f351eb04mr7209936f8f.12.1752411982244;
        Sun, 13 Jul 2025 06:06:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f7ddd667sm58219305e9.34.2025.07.13.06.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 06:06:21 -0700 (PDT)
Date: Sun, 13 Jul 2025 09:06:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org,
	yin31149@gmail.com, eperezma@redhat.com, jasowang@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH RFC] virtio-net: Fix VLAN filter table initialization
 timing
Message-ID: <20250713090209-mutt-send-email-mst@kernel.org>
References: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250713-vlan-v1-1-a3cf0bcfa644@rsg.ci.i.u-tokyo.ac.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wA6KDDJtxnkg07v7VisjzR3b4GL3M3MeVsgNvTAc7Co_1752411983
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 13, 2025 at 08:52:43PM +0900, Akihiko Odaki wrote:
> The VLAN filter table was not being properly initialized when the driver
> sets the DRIVER_OK status bit, causing incorrect VLAN filtering behavior
> that could allow unintended VLAN packets to pass through. Correct the
> table initialization timing to fix the issue.
> 
> Problem
> -------
> 
> The expected initial state of the table depends on feature negotiation:
> 
> With VIRTIO_NET_F_CTRL_VLAN:
>   The table must be empty in accordance with the specification.
> Without VIRTIO_NET_F_CTRL_VLAN:
>   The table should be filled to permit all VLAN traffic.
> 
> Prior to commit  ("virtio-net: do not reset vlan filtering at
> set_features"), virtio_net_set_features() always initialized the VLAN
> table. That commit changed the behavior to skip initialization when
> VIRTIO_NET_F_CTRL_VLAN was negotiated, assuming the table would be
> properly cleared during reset and remain stable.
> 
> However, this assumption breaks when a driver renegotiates features:
> 1. Initial negotiation without VIRTIO_NET_F_CTRL_VLAN (table filled)
> 2. Renegotiation with VIRTIO_NET_F_CTRL_VLAN (table will not be cleared)
> 
> The problem was exacerbated by commit 0caed25cd171 ("virtio: Call
> set_features during reset"), which triggered virtio_net_set_features()
> during reset, exposing the bug whenever VIRTIO_NET_F_CTRL_VLAN was
> negotiated after a reset.
> 
> Solution
> --------
> 
> Fix by moving VLAN table initialization to virtio_net_set_status(),
> which sets the DRIVER_OK status bit. This ensures proper table
> initialization regardless of feature negotiation sequence.
> 
> Fixes: 06b636a1e2ad ("virtio-net: do not reset vlan filtering at set_features")
> Reported-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

A bit worried about legacy drivers that might use device before
DRIVER_OK, is that a problem?


> ---
> Not tested.
> 
> Konstantin, please see if this patch fixes your workload.
> ---
>  hw/net/virtio-net.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 221252e00a50a46033d7ec8d18936e7c8196a6ca..6d2a67471e570e1e9b4b4fb5338d87c30e23ae36 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -389,6 +389,12 @@ static int virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
>      int i;
>      uint8_t queue_status;
>  
> +    if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +        !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +        bool vlan = virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VLAN);
> +        memset(n->vlans, vlan ? 0 : 0xff, MAX_VLAN >> 3);
> +    }
> +
>      virtio_net_vnet_endian_status(n, status);
>      virtio_net_vhost_status(n, status);
>  
> @@ -998,10 +1004,6 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>          vhost_net_save_acked_features(nc->peer);
>      }
>  
> -    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
> -        memset(n->vlans, 0xff, MAX_VLAN >> 3);
> -    }
> -
>      if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
>          qapi_event_send_failover_negotiated(n->netclient_name);
>          qatomic_set(&n->failover_primary_hidden, false);
> @@ -3990,7 +3992,6 @@ static void virtio_net_reset(VirtIODevice *vdev)
>      memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
>      memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
>      qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
> -    memset(n->vlans, 0, MAX_VLAN >> 3);
>  
>      /* Flush any async TX */
>      for (i = 0;  i < n->max_queue_pairs; i++) {
> 
> ---
> base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
> change-id: 20250713-vlan-8c107a65ad91
> 
> Best regards,
> -- 
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

