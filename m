Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A98366
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745986575; cv=none; b=HPR7PY8QuShrvd9iPTVFlpcZInKnzi5hO++m8VqWsRhL4lzeDMuZWyYAIB9cm+O/Nn3KogThB51LTGyMdAtOUaMO3S4Log+C/4RsmOR7XJKJ2sN8VDZ3ZMx9uWvtDWKwJ8Z7J2GdY3U3nx94dydyaeldcipd/XlM7MOsQ6CiuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745986575; c=relaxed/simple;
	bh=zgDHxZHHrf4WGJgqJqT62WLPzI28iR81A8ZXmn05rSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UefshwTxsAkw4BZPu6VzblU5Oww12kTlh7eCOo29FTl7TMfy0+P5eS+LAAp4DtxPzrlDgD4aBP1GBG6aGvnkKU9TmR4x2MNdHorGPDjHU0lpHy3Q2M/c+TwZ4S+/1AU34Cl9czioeYIJH/8nj5uubF3MoN7M0By21Vt1xck4Qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYV61XuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYV61XuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745986572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygUsX5Aj+sOuYKbO8rsoFiUIMipny1zZHHgpVhDkmo4=;
	b=iYV61XuDRX3Esm2l18MR29PJVBTHugr9Eu6Jv/WNah1/0Nu9X19zvKKngGdcBtY8OBPMOs
	npv/EtOgLAmAL9aRbQy6t/FWC+q4t4iwotqBMlSXOtt2xYip3PUk6GbaQU+pBUrUUXyQJG
	GSFPuTRTYeywIhpHa5DXXhozE+tt/ZI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-rlVYvX8wOJGORJ5bwQZfeA-1; Wed, 30 Apr 2025 00:16:10 -0400
X-MC-Unique: rlVYvX8wOJGORJ5bwQZfeA-1
X-Mimecast-MFC-AGG-ID: rlVYvX8wOJGORJ5bwQZfeA_1745986569
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ee54d5a00so2269343f8f.1
        for <virtualization@lists.linux.dev>; Tue, 29 Apr 2025 21:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745986569; x=1746591369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygUsX5Aj+sOuYKbO8rsoFiUIMipny1zZHHgpVhDkmo4=;
        b=CweHGyqqmkC4ajQI6SG0afyc0f63ZzXJrO5v6pJRnUPFS/Hc+n2tN/kAvbB7xYF6Ib
         EQcqLtET6l4FMEJWBhJr01tHbF0gtI8qwjTihSSxTiHWRcIp19ueOhcxCrFMMgouBk5I
         Bo1k6thGk9Czi3lyh39ZMdID8JiMDuO4hQbzoGQSM42aiZ9rABVgnvDQuGXalCeNETOR
         y1MWuCtcb1FiCNiQyOa8s1lIBjtgpDXSH2/d0DBpmHnLuVHW14p2Xpccf810y9bYN+z6
         UjiHYWTKbqPLlofKnZm0FSWSXv4EeVQdrA3ZkwpwawO9yHNWCMmU+0dGNkg6KdPA/ury
         1/6g==
X-Forwarded-Encrypted: i=1; AJvYcCUvh2t80YM6UT+GEYkwNXxzx4WX+iyvLz8SC3V/bF64JBIYKLRcNOEFiDMfgQiJAIgmnWiXWAe2ksD/FyGNCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/rXhS3Dixojhh7eRxvNOwQggn1rEtoF5uHGhh6yxVYkQNBpe5
	TNd+5UxF0P6MqFyVTWwAbvgjRTVeMYiHUUEtADK2JQyIUzWYLDmvU3S9IGSCRdHCedG6vaIQfwM
	9RBTFB0N7Vf56sEjJPKRTk+mhIPhYimObpSJgn5uysLTanW4RVFqUa/NAh/Dptd2v
X-Gm-Gg: ASbGncvtcEvH5vwAb3+jGk31FjDtDn0ZAn1JimKNw0ZQxZZ7JNCnbch+L4j6vHMigAy
	LTesrvKW5+J54ouwc3ygNeEKg5pClDL+SnK8iU2WQHPWq8EquYqLlxKDFIR9/5o7KSkNhP3kbxa
	bSVOkkWt46BVZu4YhtKvibIJy7oXEQYPBqCTFknz7z7GR+vrrV42KkQmq1xDyHCsRC3/DhLXgRX
	fhaa1K+kTIQHoS/Gatvx5CscCpuX/RyeTB0d681XR3hu7kzQfppOPvS8XplGWQaBvL32aa1pwlX
	tC015w==
X-Received: by 2002:a05:6000:3107:b0:39e:cbd2:986e with SMTP id ffacd0b85a97d-3a08f7549d1mr1353157f8f.5.1745986569037;
        Tue, 29 Apr 2025 21:16:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+lHolfiev/9wzrSLD/goStrUPIkJvBTYC7L3ZO/UV3vmik+9LstEAjZayv9Op1hJoC/Zxjg==
X-Received: by 2002:a05:6000:3107:b0:39e:cbd2:986e with SMTP id ffacd0b85a97d-3a08f7549d1mr1353146f8f.5.1745986568705;
        Tue, 29 Apr 2025 21:16:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b391c42bsm3531975e9.39.2025.04.29.21.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:16:07 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:16:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, minhquangbui99@gmail.com, romieu@fr.zoreil.com,
	kuniyu@amazon.com, virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: don't re-enable refill work too early
 when NAPI is disabled
Message-ID: <20250430001555-mutt-send-email-mst@kernel.org>
References: <20250429143104.2576553-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250429143104.2576553-1-kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r9rC5Ge1n645l4psmC0WCsAHlqSFDJi-3Vs_tlH3qzs_1745986569
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 29, 2025 at 07:31:04AM -0700, Jakub Kicinski wrote:
> Commit 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> fixed a deadlock between reconfig paths and refill work trying to disable
> the same NAPI instance. The refill work can't run in parallel with reconfig
> because trying to double-disable a NAPI instance causes a stall under the
> instance lock, which the reconfig path needs to re-enable the NAPI and
> therefore unblock the stalled thread.
> 
> There are two cases where we re-enable refill too early. One is in the
> virtnet_set_queues() handler. We call it when installing XDP:
> 
>    virtnet_rx_pause_all(vi);
>    ...
>    virtnet_napi_tx_disable(..);
>    ...
>    virtnet_set_queues(..);
>    ...
>    virtnet_rx_resume_all(..);
> 
> We want the work to be disabled until we call virtnet_rx_resume_all(),
> but virtnet_set_queues() kicks it before NAPIs were re-enabled.
> 
> The other case is a more trivial case of mis-ordering in
> __virtnet_rx_resume() found by code inspection.
> 
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: minhquangbui99@gmail.com
> CC: romieu@fr.zoreil.com
> CC: kuniyu@amazon.com
> CC: virtualization@lists.linux.dev
> ---
>  drivers/net/virtio_net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848fab51dfa1..4c904e176495 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3383,12 +3383,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  				bool refill)
>  {
>  	bool running = netif_running(vi->dev);
> +	bool schedule_refill = false;
>  
>  	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_delayed_work(&vi->refill, 0);
> -
> +		schedule_refill = true;
>  	if (running)
>  		virtnet_napi_enable(rq);
> +
> +	if (schedule_refill)
> +		schedule_delayed_work(&vi->refill, 0);
>  }
>  
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3728,7 +3731,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  succ:
>  	vi->curr_queue_pairs = queue_pairs;
>  	/* virtnet_open() will refill when device is going to up. */
> -	if (dev->flags & IFF_UP)
> +	if (dev->flags & IFF_UP && vi->refill_enabled)
>  		schedule_delayed_work(&vi->refill, 0);
>  
>  	return 0;
> -- 
> 2.49.0

