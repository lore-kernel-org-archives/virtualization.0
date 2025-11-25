Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE602DF151
	for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114631; cv=none; b=IPDaeOsgaOQFknyrE/eLsSD7FD5yPoSkuZ9sqj9mm3PVMF0Le8XiSY6MIGCkL8jozecgm826iWeOlGtNsAzFDouifCW0z2XsisIkxdbyT7xgrl+U5Zi1QK8PYf6T8iy1K7HV6Fy5GDo1nOdVC0lL37Lqw9xBiqbhSZfc9qtP81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114631; c=relaxed/simple;
	bh=VR/QlSFYXfB2XAkyEqk2La815NaXCesg1lVuqP0+cyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ahD5PCaWLyWqur7PNjjoX93Npx5AztlOzD7X5P74hye6KVRuOYXgkUC4cROUitcKszc+XoKXlK5pdIhzwjj318BNKuIFu0dan3JE6Jmza3lrX8/ByEMtlPKUD8+DxbZuVIpwpiEHjJ04VimbWBeu5j0FWrUj2Y8x4Ps0hIBK5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMQV/RVW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMQV/RVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764114627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIwS7E0jdpZel3anL6UezeiFSzMWSTuk00aa6Qzm+5s=;
	b=jMQV/RVWTdbHi/b6gkUA7hBBNlvuHQDMOiHjbmnWfFrl0ZBRmrl6FK4KSe23UT2jSzE6w9
	5wsjvmEIQqJUrg99I2ib7rDrqZsXyVy/BWk2cKcKs97ou6ydD02Dw0W0pMFnzLuDIumvxq
	CK4emBnp9GlDGSk5sDB+yi2jDe8hcbg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-j7DGFUMlOhWZ2terLwz3NQ-1; Tue, 25 Nov 2025 18:50:25 -0500
X-MC-Unique: j7DGFUMlOhWZ2terLwz3NQ-1
X-Mimecast-MFC-AGG-ID: j7DGFUMlOhWZ2terLwz3NQ_1764114624
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477212937eeso37522405e9.2
        for <virtualization@lists.linux.dev>; Tue, 25 Nov 2025 15:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114624; x=1764719424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIwS7E0jdpZel3anL6UezeiFSzMWSTuk00aa6Qzm+5s=;
        b=JQ8Y0ZL29T/IijHe2g+OA5m3fc03pZ+Nx/nR6xyPrlaWvCBhrsPl8lN/9wOoiB0Ts+
         bcIyV9uNYw+E97Qa4JGxCFq5ovirDS0YqtV/Q+OjUxnzWhfRI/jceNHjlqqVuSH+mhk6
         upN6BRmHYFwmb2B6A38NvPDXhCVgX2e/HhBWVv93uiKvH889sl73ZjHSc1MhAimMlUlI
         Px4axNtCs/IO8XKbgVwn2pfiT2RPIWQC0FaO5NalthLoU2/+QUkLwfaLntZC9IFawWfG
         lKMwNNL4WywKkZ+aKhxwCp8iaiz+CIYss5YNLZyxlqBAAWf30CNuTRGy/Jxw2eVEmmSD
         whEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSqqRUgPZMzfT/m/gBcaPyn+nv3Su1lFR/+kUuw0UBtoMvkxCmqgZJbDSK1oZWPikQJ5e2/363kHscqhB63w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTfhoEIVEgk8bEce6ZvO7SH960IUes+sGY49fCYprf146hKGFi
	LIZgE3XzhdoKWAj7iDBlVbuM3R0v/NGm+vEUgPr86fbYF2n5HzG5qabtCYSJs/nLikITzo/3SP3
	7nn6vMAbHAtDFO+gDj5JdLO/TkTfJ+NWkRX8Bzmk34yyPyKXdee84JmnW5AUobdjoSbT+
X-Gm-Gg: ASbGnctvUB6FzEfIHlO8zTIW7DjJb1vSrhsCjN0XLY7+NYj/lxCbRfYEciREH+0wD1c
	ju2ytlyCeEJCT6wKcfuUOOAD/KQAGPu+/ib9XlrSocw6MMEjWoIskeARxlAvbGgDCABqNQsFqyh
	xLR3CNZbw6/+/5K+AqZtGZ4KaL3OF78Z7W0xJaRxUlaiNG49Cb3r+5mQkxW/348bzMhvZl1XSv1
	7MXuGtlWfQChYLCJMQN3SrrsjhOIHkKSJ2fNNmoV1cYbFaLMBJY03bV7ZEfVvZWuj4syd5Am5/1
	BNd8WUfefiEqmK46c/cGxbayX06SLUXk25/TuQerFq/v9C+JE+ayeCVs46Yqw2y6iH7C3ZNwfiU
	sTUftJAY86PqHXUQ71wM6zPQ931tjCw==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr261113155e9.24.1764114624357;
        Tue, 25 Nov 2025 15:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnq4RJlt9m2aS6c4TGKhjJ1S2uVgEkT/HKNHftYudQTJJrbCWeUDlCnlsQl791oaHujLBMkw==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr261112975e9.24.1764114623865;
        Tue, 25 Nov 2025 15:50:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052def4bsm26279025e9.13.2025.11.25.15.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:50:23 -0800 (PST)
Date: Tue, 25 Nov 2025 18:50:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vhost/net: check peek_head_len after signal to
 guest to avoid delays
Message-ID: <20251125184936-mutt-send-email-mst@kernel.org>
References: <20251125180034.1167847-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251125180034.1167847-1-jon@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R38f1WaNga7RZlLs8Vi24XqeXNZ0A5SO24U8PdUV63I_1764114624
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2025 at 11:00:33AM -0700, Jon Kohler wrote:
> In non-busypoll handle_rx paths, if peek_head_len returns 0, the RX
> loop breaks, the RX wait queue is re-enabled, and vhost_net_signal_used
> is called to flush done_idx and notify the guest if needed.
> 
> However, signaling the guest can take non-trivial time. During this
> window, additional RX payloads may arrive on rx_ring without further
> kicks. These new payloads will sit unprocessed until another kick
> arrives, increasing latency. In high-rate UDP RX workloads, this was
> observed to occur over 20k times per second.
> 
> To minimize this window and improve opportunities to process packets
> promptly, immediately call peek_head_len after signaling. If new packets
> are found, treat it as a busy poll interrupt and requeue handle_rx,
> improving fairness to TX handlers and other pending CPU work. This also
> helps suppress unnecessary thread wakeups, reducing waker CPU demand.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Given this is supposed to be a performance improvement,
pls include info on the effect this has on performance. Thanks!

> ---
>  drivers/vhost/net.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..04cb5f1dc6e4 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1015,6 +1015,27 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>  	struct vhost_virtqueue *tvq = &tnvq->vq;
>  	int len = peek_head_len(rnvq, sk);
>  
> +	if (!len && rnvq->done_idx) {
> +		/* When idle, flush signal first, which can take some
> +		 * time for ring management and guest notification.
> +		 * Afterwards, check one last time for work, as the ring
> +		 * may have received new work during the notification
> +		 * window.
> +		 */
> +		vhost_net_signal_used(rnvq, *count);
> +		*count = 0;
> +		if (peek_head_len(rnvq, sk)) {
> +			/* More work came in during the notification
> +			 * window. To be fair to the TX handler and other
> +			 * potentially pending work items, pretend like
> +			 * this was a busy poll interruption so that
> +			 * the RX handler will be rescheduled and try
> +			 * again.
> +			 */
> +			*busyloop_intr = true;
> +		}
> +	}
> +
>  	if (!len && rvq->busyloop_timeout) {
>  		/* Flush batched heads first */
>  		vhost_net_signal_used(rnvq, *count);
> -- 
> 2.43.0

