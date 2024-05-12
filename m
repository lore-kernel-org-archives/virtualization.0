Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB3134A9
	for <virtualization@lists.linux.dev>; Sun, 12 May 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715529729; cv=none; b=qbMtseHhPZQFRicIVT+zZKhRP2qVc+O9eVYH50rmG29XRhQ2HM0l9vzznE23YjZzf5VhSnNwpV96kWuAgAW+Uy9hEOgJ9yw0XC8AbXtw1IzFx285bNWLXEYB43gXAFm1mAHvEeALCp0yLwHPYM+b5jUKuOQJTO4IV1OtPui760g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715529729; c=relaxed/simple;
	bh=RxSDTegW7CO/59WWa4N5BIOvsZNO4JGLYbZ0l9O8rwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UwFYHQz/5E5HzR6TGLdi9NJvhejEX+bigWggp1GqnQzlFc4BbSPHLbek62ufR+0pVcXrSrgefV+dDPDZsw8YmQ2ytiha0JDi+4MW/Rh05WyRYQw+Dytu6T1/bLa31rFl6IZinKtGeKe+ad3yCDpS9AvNdZfNP68l+amdc2xhgfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHbcPriN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHbcPriN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715529726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AxLpy9sLIlZS5JyNf+AGoRDlBshQGmESMZNZDTclcZQ=;
	b=iHbcPriNanALp+OLxsD4SNNopdTs4ja5WfF1PZGv78NmeUC9g3g88yelbNJZ+6lGbINCeb
	bDf8RlTNjrmuz2pOZG/uC5b0ypDRtJO/+/SL7AmXq+lUO+iA5QNheQ8HWRu6/tC1OTSqLQ
	lBBSxpHpVA3me2ksvSRSToE8xdk6Nic=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-9g5eV50KOfmgEBmxJd8Psw-1; Sun, 12 May 2024 12:02:04 -0400
X-MC-Unique: 9g5eV50KOfmgEBmxJd8Psw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59a0d2280cso282540266b.1
        for <virtualization@lists.linux.dev>; Sun, 12 May 2024 09:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715529723; x=1716134523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxLpy9sLIlZS5JyNf+AGoRDlBshQGmESMZNZDTclcZQ=;
        b=hicGQ/OzTo+l2xCZ84rGOvyrxvC1j9K11oBAAdkDnpJfXOuxfDTXs+kUgQtsGMjbNB
         MuP63sUXDivQBgKbL3T/LwbUGi/5LiFPuzbig4981R3SSvTy5I8KAbYQP1A6CQbdiz4t
         cEijptvdvGh8YQ4kDMabEA5LWDPYNALWgtI48sVy0ni96EniYyyizOWSLLsefy+FnEq/
         G38duJZ8kV2Yrthhg2/jhfXt2zJKKJQLKv3QYaHDEqi7gulVP1CX2Gb7mzbXXN+9HMSf
         mk8woO1ScAEUK2VO5w4+LTj3dbRA74xZwetzWt6LaYcTeiEfrHHj49wYBe1uadCoKa5/
         ezZA==
X-Forwarded-Encrypted: i=1; AJvYcCVjMYCfCCHUo1PSwVKUF38KEGw7kcxI2ww1y2PbS6nvOjpL6IAF+gGvscktf+wxeZknuQqpCd7gOnoICbovVqszut+Kf6J18EkSFwnSi68=
X-Gm-Message-State: AOJu0YwPuY5IX9y/DSqTTiIh/twmp7exbCZaxPguzwDaXg0ZE2Gu+oFs
	42rOQZOvoc96bwqnKs6Re9YYoIs4VvxkcXa7Mn27o9ZINQWbi0SybKWDUEa/P6ngTeuwzheqtuO
	2E4qdinq21X8fqpJ8gf7PCBFr+csjJhufoNEkY3w3Ej52AjOdJkcviRJ6Gnq5YriI
X-Received: by 2002:a17:906:c405:b0:a59:c319:f1e0 with SMTP id a640c23a62f3a-a5a2d681e12mr464656266b.75.1715529723223;
        Sun, 12 May 2024 09:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRCDOgxb5kjSSoH51C64l7LHObzt/SMo/s+DeV5DWeoHqnDcKMdPA3OGfhMkwQa5PjbfnFNQ==
X-Received: by 2002:a17:906:c405:b0:a59:c319:f1e0 with SMTP id a640c23a62f3a-a5a2d681e12mr464653366b.75.1715529722576;
        Sun, 12 May 2024 09:02:02 -0700 (PDT)
Received: from redhat.com ([31.187.78.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1b602b39sm455227466b.50.2024.05.12.09.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 09:02:01 -0700 (PDT)
Date: Sun, 12 May 2024 12:01:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <20240512115645-mutt-send-email-mst@kernel.org>
References: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2024 at 03:50:45PM +0300, Dan Carpenter wrote:
> The virtnet_send_command_reply() function returns true on success or
> false on failure.  The "ok" variable is true/false depending on whether
> it succeeds or not.  It's up to the caller to translate the true/false
> into -EINVAL on failure or zero for success.
> 
> The bug is that __virtnet_get_hw_stats() returns false for both
> errors and success.  It's not a bug, but it is confusing that the caller
> virtnet_get_hw_stats() uses an "ok" variable to store negative error
> codes.

The bug is ... It's not a bug ....

I think what you are trying to say is that the error isn't
really handled anyway, except for printing a warning,
so it's not a big deal.

Right?

I don't know why can't get_ethtool_stats fail - we should
probably fix that.


> Fix the bug and clean things up so that it's clear that
> __virtnet_get_hw_stats() returns zero on success or negative error codes
> on failure.
> 
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/virtio_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 218a446c4c27..4fc0fcdad259 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4016,7 +4016,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>  					&sgs_out, &sgs_in);
>  
>  	if (!ok)
> -		return ok;
> +		return -EINVAL;
>  
>  	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
>  		hdr = p;
> @@ -4053,7 +4053,7 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
>  	struct virtio_net_ctrl_queue_stats *req;
>  	bool enable_cvq;
>  	void *reply;
> -	int ok;
> +	int err;
>  
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
>  		return 0;
> @@ -4100,12 +4100,12 @@ static int virtnet_get_hw_stats(struct virtnet_info *vi,
>  	if (enable_cvq)
>  		virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
>  
> -	ok = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
> +	err = __virtnet_get_hw_stats(vi, ctx, req, sizeof(*req) * j, reply, res_size);
>  
>  	kfree(req);
>  	kfree(reply);
>  
> -	return ok;
> +	return err;
>  }
>  
>  static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)

