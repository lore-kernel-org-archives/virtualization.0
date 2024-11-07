Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DD1DFE30
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974951; cv=none; b=JzD+SOpAoUNYDL3YXtlifWO2rvMLkmuvPziK2ElOTghBX+tkARPRmjo/HaSoE8WMFukwOQgN/45KzJOweZA/iRK5gp546otf79ExGyWVW5GpVm71+K3whT5+WZeVQTtgqVJyRcgO/i28Y4iLTEKPUaTqBe6KDA01pdfba+Y5Cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974951; c=relaxed/simple;
	bh=V9NpU14QYVeWan0vHTGnaXzW9/fUraIqiInUNJ6WR64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZL+P4u+hYelizoSl+vu13UOIx+25UjxOxUS2YE79wtiAFezF6aGsT41FDFT9hBj35PivknySzBo5qaFey5jHlCSlOhdfs8fuq5d7uZ3S0lxre5p097wWkjmgppCf+CS21NfOIxuuGEQI+4oB8/MiTig8v6NOGxGBgwL+l6tKCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHEjGKZ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHEjGKZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730974948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/rk41amqTRxMFOn/UjLc5ZQtOWZ+WqrRln+PhszSu8=;
	b=ZHEjGKZ26vH5Qj5ykNMFbAxQHM5qU09gWBMsc/LJXLahQR5IRR4w4VW9N6xsW/DLLEUL3r
	reeJ4dSueYXyiWs9vP+ddH+X9/nWtTPuoff76d5lNpzr5n0OvoOXJpVzWPXTzVjQf5NdEL
	I3JhrUfq7ibiyMCcYs49oq1woOrqhr4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-zXNS7fl9NAuFoVlBWx8Sgg-1; Thu, 07 Nov 2024 05:22:27 -0500
X-MC-Unique: zXNS7fl9NAuFoVlBWx8Sgg-1
X-Mimecast-MFC-AGG-ID: zXNS7fl9NAuFoVlBWx8Sgg
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b146057b67so84188685a.2
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 02:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730974947; x=1731579747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/rk41amqTRxMFOn/UjLc5ZQtOWZ+WqrRln+PhszSu8=;
        b=wTsJ7kHb0b4SGhJ/0vNzCWC8dSAC/W5Oetx0aO+aJifPkfFmYxhm3xLBzPXQ5OaaSe
         bgNe2kuD9ljI2KpImO2PqLilFmQzdecJRcTgTicL/e2o46OOsRPXvh5HUAJomX49JxKR
         RGGG/R9hmT62tOTu/KlEw7hJ7dAiqjyRd5QGtPsoFO6fhM4qGZVylOl/7JguY7jFZnsb
         X/R6yVWh1oqKgN8AtL7FNO6pcavKC5ndldSIkoDVR3ywN2zMHLUqucnFh5ZNUP+qVTpF
         kpZt0EE1+xGVeUXyh/dQIYaCZ554WUIjdV0WfLLTZEUih5J3nOeGB1IgGMCdBXR7HIAe
         IC/g==
X-Forwarded-Encrypted: i=1; AJvYcCWh6oF1o2r+mGC1lEVtiV6A2BpSM9nOdmsn2c0ugR1fZzYxr0+CtB+PIrKQkpgVT8Bng6oVgBQXHc6YA3fXZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhZt/rGh54nta/RoC02JMeIAtN2efMhLLuTjr+6k9AopnPEueh
	OGvPDlg3JxpnkHfXD9rgKPsQsHC+B8+9G/wCHa7X3SHYz7Xng0ZvjVUmrDnoyyhEjQYc4/ob+K6
	67qOKtB+S1Lqk83ErHIxno1ODx5qInHDuNj4lCY/YTgsmwo/n5uJ+3MeM/l0zNOEy
X-Received: by 2002:a05:620a:2a12:b0:7b1:4caf:3750 with SMTP id af79cd13be357-7b2fb9beb07mr3543632085a.53.1730974947201;
        Thu, 07 Nov 2024 02:22:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwf5lDb7bXsoa9a9hWJCOiDp2nDecqoUe9Y1TkckHnyCQWTiTj30iao7oA6EM5S1LIifvLqA==
X-Received: by 2002:a05:620a:2a12:b0:7b1:4caf:3750 with SMTP id af79cd13be357-7b2fb9beb07mr3543629485a.53.1730974946829;
        Thu, 07 Nov 2024 02:22:26 -0800 (PST)
Received: from sgarzare-redhat ([5.77.70.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac43811sm49735285a.35.2024.11.07.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:22:26 -0800 (PST)
Date: Thu, 7 Nov 2024 11:22:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jia He <justin.he@arm.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 4/4] virtio/vsock: Put vsock_connected_sockets_vsk()
 to use
Message-ID: <ucfa7kvzvfvcstufnkhg3rxb4vrke7nuovqwtlw5awxrhiktqo@lc543oliswzk>
References: <20241106-vsock-mem-leaks-v1-0-8f4ffc3099e6@rbox.co>
 <20241106-vsock-mem-leaks-v1-4-8f4ffc3099e6@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241106-vsock-mem-leaks-v1-4-8f4ffc3099e6@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lePloPFaFfX5-YrCSWlu6QsRHndyuoAx4wPDe7HBwVM_1730974947
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 06, 2024 at 06:51:21PM +0100, Michal Luczaj wrote:
>Macro vsock_connected_sockets_vsk() has been unused since its introduction.
>Instead of removing it, utilise it in vsock_insert_connected() where it's
>been open-coded.
>
>No functional change intended.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

This is not a fix, so please remove the Fixes tag, we don't need to 
backport this patch in stable branches.

Also in this case this is not related at all with virtio transport, so 
please remove `virtio` from the commit title.

In addition maybe you can remove this patch from this series, and send 
it to net-next.

Thanks,
Stefano

>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index dfd29160fe11c4675f872c1ee123d65b2da0dae6..c3a37c3d4bf3c8117fbc8bd020da8dc1c9212732 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -275,8 +275,7 @@ static void vsock_insert_unbound(struct vsock_sock *vsk)
>
> void vsock_insert_connected(struct vsock_sock *vsk)
> {
>-	struct list_head *list = vsock_connected_sockets(
>-		&vsk->remote_addr, &vsk->local_addr);
>+	struct list_head *list = vsock_connected_sockets_vsk(vsk);
>
> 	spin_lock_bh(&vsock_table_lock);
> 	__vsock_insert_connected(list, vsk);
>
>-- 
>2.46.2
>

