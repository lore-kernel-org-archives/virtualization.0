Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C52199E9B
	for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507621; cv=none; b=BgPi9cYF2TxbdlznFJfFFcbSgeo4c+D/xTMtlCQ0zc8G1XWtF3VwcDcblj1ZXQb42uV1bI7n2qokmUgydAaNUj3YkOxbgFmv3eiEZ0J3vwuXSOm5Mzehc4ZnKR293lLPpzusHPj86D1w7IUrokid0sK02vLkQnMlLQcy9wB9RZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507621; c=relaxed/simple;
	bh=ug3YfKik7AumLDou9Srebnw6+kedHrFJPLCWgOx1frE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Nu3yyXsRhF9gLFpK0ifxuWNAY2+U7A8i+HhK/Fn+QI2rj5auRn1D/GZZufTSpM56dtgNOFFSOWW2F3WAEf03s4AUaltG4R2cmzTdmctD0a4DYSlOFig95CipWRZVvJI3vAIS3a9oSqso7v7feXR3Hdlb6TXNYwnEZlMeWvAxOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAq66FZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAq66FZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714507618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxTrrQAHX5LIHD8+8RfIAMS1TPkS1k3rljcnnnsPEVE=;
	b=jAq66FZ4tlALHbPQhE/ZoM181Z5KaVwK5JqgoZvkc3hXGqI4AHAyPfmyWrljrNgyE/Xm5M
	DH+Zv8/7YFinrf1L8i8nTQH9B1/Pa88b7oXud1+56AOGkf5dnmgj0GJE9GnYbq9A0sPE/0
	gJfYmC3yw7JsWET72Yh01Ne4dOOk4Vc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-eukzesrWM6OCF9XlbhGi9A-1; Tue, 30 Apr 2024 16:06:56 -0400
X-MC-Unique: eukzesrWM6OCF9XlbhGi9A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-572a203c05dso4025a12.0
        for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 13:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714507616; x=1715112416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxTrrQAHX5LIHD8+8RfIAMS1TPkS1k3rljcnnnsPEVE=;
        b=NUJGxQFruXrGkNXb4m/YbPg3BK+s+dDO4D2QXFrlpOttZpS2KdVAef5ysXBpRHGLsz
         e37A55fkJkXOYwArA9AxpcI1BcqsZutEr1jVSwWbXWECrK3fEbEagOZKbFtW7ZsMNjRH
         vvMXO+Qw9SLOQPoofNi2kU/Ms+Ww61sh+FfoYX4IqfPVXarXlrvva55FmqAHvA/INqtF
         GAqdbagQsvj1X8yaczzRq6ngIbcyME9b9tE/OpRTv/8uQ4SmUPFEho8bzelRDfA25865
         tjjA/0kwzo5HcJRMEu6PsFZhVwNc42vkAOrtWEWw8aq8oIseff+rTuBXNoHCSqb7mBYY
         5fWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKk7Vz1QEm0q5PyebJPCSTOLMo4/+Gm2b9dvg11MfAuqz6AIKwSOv9P6KrK5nFs8AfZmvbBGlZY7sUmEfq6N/P4MTaRCz+2TjLABKY5NQ=
X-Gm-Message-State: AOJu0Yy7CXDCTlAUuIkvt2gplfEyhZv/WU2jyfCeH7f8UauaeCbVWO89
	WhxQbdrzrEtznJNVgYSeZ5kXFyHijH6kkaE0hXu8HDt7yNjUDPI8XLyxO/Ozr4fzrE8aFMIxdIE
	IXVu3yzv6z+XNQ5euhJbO1sAA9wFRoCb7D+9Ls8bn1jxJJ28IvihqvVUA8DtC2ibA
X-Received: by 2002:a17:906:2a44:b0:a58:ee10:ad05 with SMTP id k4-20020a1709062a4400b00a58ee10ad05mr484898eje.69.1714507615501;
        Tue, 30 Apr 2024 13:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7ocL9+DqttG8t6q0QKC2cVrRfgcVUPqW7FLSaNzemeZLoe4wornulVDynqTC9/Zrj4O1LwA==
X-Received: by 2002:a17:906:2a44:b0:a58:ee10:ad05 with SMTP id k4-20020a1709062a4400b00a58ee10ad05mr484881eje.69.1714507614890;
        Tue, 30 Apr 2024 13:06:54 -0700 (PDT)
Received: from redhat.com ([2.55.56.94])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b00a4e24d259edsm15356306ejj.167.2024.04.30.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:06:54 -0700 (PDT)
Date: Tue, 30 Apr 2024 16:06:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Darius Rad <darius@bluespec.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Warn if insufficient queue length for
 transmitting
Message-ID: <20240430121730-mutt-send-email-mst@kernel.org>
References: <ZjFH7Xb5gyTtOpWd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZjFH7Xb5gyTtOpWd@localhost.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 03:35:09PM -0400, Darius Rad wrote:
> The transmit queue is stopped when the number of free queue entries is less
> than 2+MAX_SKB_FRAGS, in start_xmit().  If the queue length (QUEUE_NUM_MAX)
> is less than then this, transmission will immediately trigger a netdev
> watchdog timeout.  Report this condition earlier and more directly.
> 
> Signed-off-by: Darius Rad <darius@bluespec.com>
> ---
>  drivers/net/virtio_net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 115c3c5414f2..72ee8473b61c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4917,6 +4917,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			set_bit(guest_offloads[i], &vi->guest_offloads);
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	if (virtqueue_get_vring_size(vi->sq->vq) < 2 + MAX_SKB_FRAGS)
> +		netdev_warn_once(dev, "not enough queue entries, expect xmit timeout\n");
> +

How about actually fixing it though? E.g. by linearizing...

It also bothers me that there's practically
/proc/sys/net/core/max_skb_frags
and if that's low then things could actually work.

Finally, while originally it was just 17 typically, now it's
configurable. So it's possible that you change the config to make big
tcp work better and device stops working while it worked fine
previously.


>  	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>  		 dev->name, max_queue_pairs);
>  
> -- 
> 2.39.2

