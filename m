Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E066F1E5B63
	for <virtualization@lists.linux.dev>; Sat, 11 Jul 2026 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783239; cv=none; b=NnOVuQkBRDRn1LrmWKy4aog/CXMw+/QwmCrxTZxU0Qi+HNZjouYkplewEb1X4iVgjZq02tkWIIAeMYiqgr0CRLZIEvoEsmRBVXKLy7cLoLzdcp78A0hMbiABo5aqtlcjN3KID6QNBso3Foys7R4jf4191i6HoXslr94gl3bwoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783239; c=relaxed/simple;
	bh=8PCyBlIWQjZCCPrTVN7xE+pF7wIpZzqRFJWJCP5kxbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aPrZe9bE9PCg70mt4Sha0E85B06LdZmeJ+tXbfj8xRbHAHgLj8QqHbXi6Q/fI84McP1z2OIU49+zTdWQtueWrCIxf/u1AJQgZ2iUhsmYVRJzklICdGbj8oxiHx8/aq0wvkhhSXukfKNf+4ESvMoPHJ67vBmlS3+gFUP3oZBAzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkvIiiVi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkvIiiVi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783783235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmUM+RWb25XiR9LGFNREMs6O7PLt7AQAUsEOfZqyWvs=;
	b=TkvIiiVi0LEaR4EEAqNjl7wB56UpBlTaru8GqsporoAF4SM+AHi2UPD/qK78Kzb7yX4Fmf
	Dz3hST6AaYlMeoJa7lzUMHgBiHTU+JcWJD+075lWJ4Qqoq81YHMb1WscbP+Pl37bufZe11
	E7mCBkd9iqtTr6ynJwZJ6vIo/XgvHbw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-FnRBdqCzO7GsWvHE82yfdQ-1; Sat, 11 Jul 2026 11:20:34 -0400
X-MC-Unique: FnRBdqCzO7GsWvHE82yfdQ-1
X-Mimecast-MFC-AGG-ID: FnRBdqCzO7GsWvHE82yfdQ_1783783233
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493c526df6bso14062105e9.3
        for <virtualization@lists.linux.dev>; Sat, 11 Jul 2026 08:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783233; x=1784388033;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmUM+RWb25XiR9LGFNREMs6O7PLt7AQAUsEOfZqyWvs=;
        b=YqbZHOwq0wpteYKynD6tBZPj+vTk1DZW6RcReDWeZaSCsrADRjueYGEtO5PcTMgUMp
         16fL0sPzYvPW3taqKLyIKtFYpC9XhL2lZKXjkGWOYntNr3guIz+8j8acinQF7pbCIlLk
         hZUcl6xy5AjtCI+63kf6Vwe+ALUxzMUbDrcQ10USX3I9X57WfmHyyGRyOWMdSsmQmd9b
         h5+QXgz8+03gbrBi+OyZp8DzQwIcYUKSiYBCDjR1hDssdBDEV454KncsT49tzYUbhCSx
         oym914oufzkmm27hDznmgVQEzMfX4KZDSo+RQOlbdzw/ykP8KEaKe0ZxtrAwhe+dWlW/
         R56A==
X-Forwarded-Encrypted: i=1; AHgh+RqiERF47WuuIjSkiXzINPvrjaAkVJzXYGxaSLiDuap4tCf8E541+twKZXJBeWudIdEojhWiaQW05WtxiGiVHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHKqLvB8uuv1raWRx22EBsJ7d6waFH3zNcjM4OxRg6vGFSvMTg
	gLVEr29kX8OasNdrs8Kq97fKEQwx7I2oP0JZKoXizdGum61AbOAPVwieAFSkhKWBlWffgLQd5IQ
	xZ8cEuUefI12fevVnwBQ38hncp1v+J4eqN+WZY1E7EdSmUzsepI5uFn2bN9rHpHfwFesi80GmLo
	SNYA5bHA==
X-Gm-Gg: AfdE7clLoziOmXBVqKrsucyTn6Zax7R460kvkquyH/OrqBU6n7wVb3zkkRR0t9dEHF1
	1Adr6mhBOBn8vvKfvM0gK/x+I+WNbRJdwF9jFiVTuPQ498scrVX0qUiwivZzyuVDNPAh3Pw2pmy
	9ew3NfyoPYn58jGJP4IXhlYyp7MVqvmSOLoV99D5BZorzYyDBgGwxBwt1AiOSehv2KT7R1Y2ZDV
	So6krGEfZdtDSLft3KOGil+d/Nb0XngYONcWsQOPTKTsjcTZkgO/htEiACcNcemPAoSXJDTC7A1
	131Qm/GFLrdqAYxmLKEzEegZgK0rLdsvZz/t5bOtSSZt8J5gpDL0K2TCPNd6HKmOxIaVuSCZKT4
	b2ng=
X-Received: by 2002:a05:600c:3e19:b0:493:f28e:462a with SMTP id 5b1f17b1804b1-493f87e6ba2mr28363885e9.12.1783783233282;
        Sat, 11 Jul 2026 08:20:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3e19:b0:493:f28e:462a with SMTP id 5b1f17b1804b1-493f87e6ba2mr28363605e9.12.1783783232734;
        Sat, 11 Jul 2026 08:20:32 -0700 (PDT)
Received: from redhat.com ([185.81.125.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ff6casm266286555e9.5.2026.07.11.08.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:20:31 -0700 (PDT)
Date: Sat, 11 Jul 2026 11:20:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] virtio_net: validate device stats reply records before
 use
Message-ID: <20260711111503-mutt-send-email-mst@kernel.org>
References: <20260711150754.2918392-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260711150754.2918392-1-michael.bommarito@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FEGgsKKMDxD4w3eYUkC3mHq0E0znHh-6kDnfbzAwFp0_1783783233
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 11, 2026 at 11:07:54AM -0400, Michael Bommarito wrote:
> __virtnet_get_hw_stats() walks the device statistics reply buffer with
> "for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size))",
> using each record's device-supplied hdr->size as the stride without
> checking that a full struct virtio_net_stats_reply_hdr remains, that
> hdr->size is nonzero and matches the expected size for hdr->type, or that
> the record fits within res_size. A backend that returns hdr->size == 0
> spins the loop forever; a short or oversized size drives out-of-bounds
> reads in virtnet_fill_stats().
> 
> Impact: a malicious or compromised virtio-net backend hangs the CPU
> running the guest's device-statistics query in an infinite loop
> (hdr->size == 0), or drives an out-of-bounds read of the reply buffer.
> This matters most for a confidential guest, where the host is outside the
> trust boundary.

Why does it "matter most", or at all, there?
Host can always deny guest service. In fact, this is how cloud vendors
charge their clients, by denying service to whoever did not pay them.


> Validate each record before use: require a full header in the remaining
> bytes, a nonzero hdr->size that is at least the header size and matches the
> size expected for hdr->type, and that the record fits within res_size; stop
> the walk otherwise. Add virtnet_stats_reply_size() for the per-type size.

I'm all for making things easier to debug even when the device is buggy.
But I'm not inclined to add tons of hard to maintain code to
that end, and I would be worried broken hosts will come to
rely on drivers working around them.


> 
> Fixes: 941168f8b40e ("virtio_net: support device stats")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/net/virtio_net.c | 42 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c6c8c..9cbe40d218cc4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3532,6 +3532,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
>  	return err;
>  }
>  
> +
>  /*
>   * Send command via the control virtqueue and check status.  Commands
>   * supported by the hypervisor, as indicated by feature bits, should
> @@ -3546,6 +3547,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
>  	bool ok;
>  	int ret;
>  
> +
>  	/* Caller should know better */
>  	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
>


we don't need this.
  
> @@ -4927,6 +4929,32 @@ static void virtnet_fill_stats(struct virtnet_info *vi, u32 qid,
>  	}
>  }
>  
> +static int virtnet_stats_reply_size(u8 type)
> +{
> +	switch (type) {
> +	case VIRTIO_NET_STATS_TYPE_REPLY_CVQ:
> +		return sizeof(struct virtio_net_stats_cvq);
> +	case VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC:
> +		return sizeof(struct virtio_net_stats_rx_basic);
> +	case VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM:
> +		return sizeof(struct virtio_net_stats_rx_csum);
> +	case VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO:
> +		return sizeof(struct virtio_net_stats_rx_gso);
> +	case VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED:
> +		return sizeof(struct virtio_net_stats_rx_speed);
> +	case VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC:
> +		return sizeof(struct virtio_net_stats_tx_basic);
> +	case VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM:
> +		return sizeof(struct virtio_net_stats_tx_csum);
> +	case VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO:
> +		return sizeof(struct virtio_net_stats_tx_gso);
> +	case VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED:
> +		return sizeof(struct virtio_net_stats_tx_speed);
> +	default:
> +		return sizeof(struct virtio_net_stats_reply_hdr);
> +	}
> +}
> +
>  static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>  				  struct virtnet_stats_ctx *ctx,
>  				  struct virtio_net_ctrl_queue_stats *req,
> @@ -4936,7 +4964,7 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>  	struct scatterlist sgs_in, sgs_out;
>  	void *p;
>  	u32 qid;
> -	int ok;
> +	int hdr_size, ok, remaining;
>  
>  	sg_init_one(&sgs_out, req, req_size);
>  	sg_init_one(&sgs_in, reply, res_size);
> @@ -4948,8 +4976,17 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>  	if (!ok)
>  		return ok;
>  
> -	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> +	for (p = reply; p - reply < res_size; p += hdr_size) {
> +		remaining = res_size - (p - reply);
> +		if (remaining < sizeof(*hdr))
> +			return -EINVAL;
> +
>  		hdr = p;
> +		hdr_size = le16_to_cpu(hdr->size);
> +		if (hdr_size < virtnet_stats_reply_size(hdr->type) ||
> +		    hdr_size > remaining)
> +			return -EINVAL;
> +
>  		qid = le16_to_cpu(hdr->vq_index);
>  		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
>  	}

That's a lot of fragile code for unclear benefit.


> @@ -7305,3 +7342,4 @@ module_exit(virtio_net_driver_exit);
>  MODULE_DEVICE_TABLE(virtio, id_table);
>  MODULE_DESCRIPTION("Virtio network driver");
>  MODULE_LICENSE("GPL");
> +
> -- 
> 2.53.0

