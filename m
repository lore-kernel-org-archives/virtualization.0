Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5F61F130D
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395244; cv=none; b=uRg5V8jTG5COY/skssdOOQMwjyQIY+YhRGl5Ev1lBlgDWJ2h/YOtup0MmWgGAIpqSOgQLIK+ZpuZpiqJ7bqR/dbQ7HnPeLn/38UJjdTKZ/acN7G+gIkVfQaDMN/a2YHRC4jqYKjtZmKmJ9r+1qQhaDZDAnPkr8XgJYi0m73GNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395244; c=relaxed/simple;
	bh=eshHAQfNSHOzASdNe9Ca6yUEiJvbhuYcQfpae53AkRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LBaLNjSkoxy9zsIH+LmA09bwD0vGrTuF6ZUY175upWDmNk1BtrDoO9811C5/vhcf5WajdABXbADX2hXk8fzdBNyEO9NV32kn49CC3ni//yaYs2+2NS2SOBDCAc5e/jmWJyQ1bBzg8SU8Sd/TBmVgoecPyPv9aqIQvOhc3hCpuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NzbxdELE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzbxdELE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733395240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WpCGJ4eeYXK6hXhyy8nkE9QIN4zLNYIGTlUdRPmUVpo=;
	b=NzbxdELEolBXpW+x0eTUpQL8y4JifnZIXG9HMnRrTvmI6Puq4QpNsIkQa1Cads+hmJcKOr
	12KuXyVbqNA4kBmjAsXYGMr3dUKmjSeCZEZ3edfdeoLH7twNMbyTx+hhiqr2zB+JUGnn0P
	kvKtTdMY51gIqpnfNlpVPhpgXhB9/bs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-7ouI1xpOMI6BTwpSBSjxrA-1; Thu, 05 Dec 2024 05:40:39 -0500
X-MC-Unique: 7ouI1xpOMI6BTwpSBSjxrA-1
X-Mimecast-MFC-AGG-ID: 7ouI1xpOMI6BTwpSBSjxrA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso6770575e9.0
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 02:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395238; x=1734000038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpCGJ4eeYXK6hXhyy8nkE9QIN4zLNYIGTlUdRPmUVpo=;
        b=vd5+H8cFy9KsLpXuggLOFUH8Zf/+QhesyQ8ldubu6sBCfNJ0a0TlFQGwa9bSBaCgLv
         I+wvSuK7jVcezgSrwvF/vvOqnYITG4Nttu2NxszCK0yixD1MZQF1kUPct8chon+Zuq3y
         MbDvTDYopG6EZvcvDcMhqB/z6Ebi2IZyN/lwjWLnThBYM7SESGNHlJFvF2xnqJCk4G3X
         eofSgPOVwD9e2Y4lhBI3NiTcokL+xdU5u8dvavC9ANiHT+7s26IohLVneEicFMh/g4KC
         Ks/2ad8nUZhTGIfz3V8CdgnVyXsVe3xQWT+lZ0FnGelPefB/O9WF5sH/1GZZgI4J/c6K
         +CoA==
X-Gm-Message-State: AOJu0Yy7yaSt+ayK9vpIz2VqZuXChhLLW8Xm4Bgaja4oPIe4h0Nnjk0r
	E5P/X4x7jz/jFhex5459UeA9wkJLCuW+z/0JkHA29nk5UySvPe+0PRfBaxsxtm1ycE9CBP5cJfz
	4iJ7q4SsW/ntKyes64w2QheJjBdy2t94KKy/kPcaKu8a0KIZo+ap6TdsuYTp5sZG0
X-Gm-Gg: ASbGncsCnD15pxXXhyB1XS7qepKjl4ODQsyFjew2t0KqGCsTREy7LIU546TWYsCFs8+
	v4sHxq/Q9DA5BcWlRka1RlMPWdCt88aGoBj/3da0E7YXOFQgfMey5qyqUiCIr4hREAPgmQsfCfA
	+p70JN2PWOq262f08TcO0TS5cF4F02bYArPUUF1AhuKAM8TGMET1fUrz4U3+qKYKiA2O1muP05S
	0dxHHc5U/F00N+mJEdssB5rA1PsofBvt+y+GVc=
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr98426185e9.30.1733395238183;
        Thu, 05 Dec 2024 02:40:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsUHluXJQKUT4U9GZXEYGz55h1e+WikGnJtrY5qJkX8kQnZ3tgKpsrMkwfLF3sVmYTJvd9jg==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr98425925e9.30.1733395237817;
        Thu, 05 Dec 2024 02:40:37 -0800 (PST)
Received: from redhat.com ([2.55.188.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5272f99sm55804775e9.11.2024.12.05.02.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:40:37 -0800 (PST)
Date: Thu, 5 Dec 2024 05:40:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/7] virtio_net: introduce
 virtnet_sq_free_unused_buf_done()
Message-ID: <20241205054009-mutt-send-email-mst@kernel.org>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
 <20241204050724.307544-4-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241204050724.307544-4-koichiro.den@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6K0qNyov7ZsqC4W1jLOxIZPPzcaav9QT3ZLaLVm7T8U_1733395238
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2024 at 02:07:20PM +0900, Koichiro Den wrote:
> This will be used in the following commits, to ensure DQL reset occurs
> iff. all unused buffers are actually recycled.
> 
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

to avoid adding an unused function, squash with a patch that uses it.


> ---
>  drivers/net/virtio_net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1b7a85e75e14..b3cbbd8052e4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
>  static struct virtio_net_common_hdr xsk_hdr;
>  
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
>  static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
>  			       struct net_device *dev,
>  			       unsigned int *xdp_xmit,
> @@ -6233,6 +6234,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  	}
>  }
>  
> +static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
> +{
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	int i = vq2txq(vq);
> +
> +	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
> +}
> +
>  static void free_unused_bufs(struct virtnet_info *vi)
>  {
>  	void *buf;
> -- 
> 2.43.0

