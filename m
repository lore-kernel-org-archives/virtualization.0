Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2471D9A43
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886126; cv=none; b=bLCyAk7SNtov3+N1/EUwf+GnV4sbgmIKsHFuTkr33ICL8qXCKpbhyQvBHyQQ07qyAeCCW1VNVHSwaUSR3cKStcgIuFEzDGgkbrfLcoNtgdWb3GRRKWCqOZWuXN+LnpQ7htXwsBuAbB8SwI4imsJpttxuCsgvzFwOdbS4jwQIv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886126; c=relaxed/simple;
	bh=Bvl36VOmpCQxv3IEs3k+665K4+jeHl2Dl/E6Fh3bEOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hZz3qHFv43ejW6G+v/MbOJAa1FiE34T2SPqwL7Kyf1T55Di1/0e8ra3t76kFJFgjNL16NZckOzJJYknuu36J32nAZbBUK4kaW5a3nCMIXhbAFPLc88cG3dGa7ogOAH2IS8ZJozNEZBtqMAParmtzsqKl8VedFXr7n1LJ5nHybMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5NVAZQf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5NVAZQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730886123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/m2B5XkqveJBUmDhsVEUtZ9/8cFuA0F3GzIlGJUsU0=;
	b=Z5NVAZQf9MvYo3SorCtXAvjHqXYyKzFM2781j0uiR+RqPtOd2Cs2F+ja70AyCw4pngvkKa
	QblaerYC+HjtjRGZqyQioxZeu/4axAZ/aea8GWpeFzJkFpoQRdec/p2vhu3xFIYwY7QLJo
	z8rwjdcQUpqtj9R2Ln3pmLnxRVi++oU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-JJqf-qvxNhS_KogpU1gQWw-1; Wed, 06 Nov 2024 04:42:01 -0500
X-MC-Unique: JJqf-qvxNhS_KogpU1gQWw-1
X-Mimecast-MFC-AGG-ID: JJqf-qvxNhS_KogpU1gQWw
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-84ff1850a9dso1614944241.3
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 01:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886120; x=1731490920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/m2B5XkqveJBUmDhsVEUtZ9/8cFuA0F3GzIlGJUsU0=;
        b=nqyk9csYpc8eAF46FgmjGyDvkAkuBwiOwXtehH2Djy+7P2XKeEyflpzs0SRLvLBOza
         yIT6rlGtqEoZQgJpJO5FfpxPRVvfFrBYTVL8msNoh4Dxm4wCPu22/zaoiBYMm7vxEbQH
         WHmvTRYff5offGQjy3+xJiGSBmd7UFskGzw3wLMHsq4xWmXA6p5WCTymFxZuRM9f5/AS
         VPjGnt79ANO7WcRmvTwIJIkTuC3dFXEpyhAkXj6OnfG4h0Qnm9PrLHkCJqLjKiDkvUlE
         dzuzDuw2dWo0yRZP335vXL1HJAzdmwJZWNaCMXZ2VbqGxccxcNiCuHgiXdIDBbqK8wvl
         W4fw==
X-Forwarded-Encrypted: i=1; AJvYcCVKzpI8Jv/MFqN1+hIyQL80hJFJ4v735GtMdjbFfq7syv0icBSxkGyLdyW//ahrN13kxzCs6Ie9U9tkQ/qAvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvGa3z370SmDPZFEuDSbWhGlmV00QdFhVfgvLhXRX74adeN6U5
	OzISRYltarJ3rKK2YNi39pmFxMB5P8ZvwHsSU2i2XLacoqkSWFUTdUiVS5EqepPBbWSnS5GcMPL
	PoJM5SGMZm0yAyokilfyNK5upmqOAshYJh0ScaYrJuRasSwTHlgXai/q7v9z+yIXg
X-Received: by 2002:a05:6102:548d:b0:4a3:d46a:3590 with SMTP id ada2fe7eead31-4a95425990amr23380003137.1.1730886120283;
        Wed, 06 Nov 2024 01:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmS9OYo4otT12nfkWmtHNvDCJx/YgNSZ/gBSMflzmUZlx87lhupACD1+p41aeETaeGNvH1KA==
X-Received: by 2002:a05:6102:548d:b0:4a3:d46a:3590 with SMTP id ada2fe7eead31-4a95425990amr23379910137.1.1730886118398;
        Wed, 06 Nov 2024 01:41:58 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39e992esm612199085a.25.2024.11.06.01.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:41:57 -0800 (PST)
Date: Wed, 6 Nov 2024 10:41:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	mst@redhat.com, jasowang@redhat.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, gregkh@linuxfoundation.org, 
	imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <lnagtti6isffhiioeevmy5gzdmpiuy7zlztsipryw6brsg37ee@rhvuzi6kraff>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N1J0yu5woaGS-WkA7W7h5Ci8MPbMBEFVV5uvqcqNrKk_1730886120
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 06, 2024 at 04:36:04AM -0500, Hyunwoo Kim wrote:
>When hvs is released, there is a possibility that vsk->trans may not
>be initialized to NULL, which could lead to a dangling pointer.
>This issue is resolved by initializing vsk->trans to NULL.
>
>Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
>Cc: stable@vger.kernel.org
>Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>---
>v1 -> v2: Add fixes and cc tags
>---
> net/vmw_vsock/hyperv_transport.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index e2157e387217..56c232cf5b0f 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
> 		vmbus_hvsock_device_unregister(chan);
>
> 	kfree(hvs);
>+	vsk->trans = NULL;
> }
>
> static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
>-- 
>2.34.1
>

