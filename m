Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1C3A1691
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374160; cv=none; b=YfqQRPjL8u5HSY3eaGbezN0uWrQ9YbCGUaSBjjZKmfysUAB5Kd+LKrSyH5zboXzhW8dkhe37NR0PZlmuATKhw71djPWNEp3AFoV/qzJoBQlSgOeFTSrNcCWD7Gu1z9lv3BHOvO0sAQDuucr3PZ2o8ULN8zpJ0X1I3xVody15agY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374160; c=relaxed/simple;
	bh=TJyvrr4HaLk8h/xrwfw3is3omZUyp+y5i6BcRF5lQPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SfraANulM86s6VxAEmk5hW9mjrrQ92wPautcjOjUnuLngxVla3MQK8fgNHWLbJL0rihnQsnkZN09i8q94mvVebR0V/vMTaWLmhFvDEUnTXBFlhklxA2N4CSkxjkowJ7EqY9Gp0vjUtSu4TIq/GdUuIIGGfvGSx4zMwVQ2apf8Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWRz/86F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWRz/86F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774374158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8hqPRba6xj486YSVHnHmVBfkPNRQNNSk9RXrPw+XUY=;
	b=RWRz/86FJzCuuuk8kc5cNhlbBehk+YudoeLnpResQDXGw7TvIIcz2TtuIBNKXuj0QWikBv
	/5TMqoO7X796wfTZ4iMRRslc2uCpUKyBRh+RYJpTD/WFsSmyHrcSjpg2svTQFTgAAySacq
	ZE4paDo51l5p77+5jkyhblXJ8YaJ2cU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-wdgyUu2aNoCEyGQFmhCT5w-1; Tue, 24 Mar 2026 13:42:37 -0400
X-MC-Unique: wdgyUu2aNoCEyGQFmhCT5w-1
X-Mimecast-MFC-AGG-ID: wdgyUu2aNoCEyGQFmhCT5w_1774374156
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fc42c83aso17393835e9.0
        for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 10:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774374155; x=1774978955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8hqPRba6xj486YSVHnHmVBfkPNRQNNSk9RXrPw+XUY=;
        b=gC0l31cTxMP+twmyu7Tdz1PA9nwOKVmVWft2i+Y3tjgbtLIoKSja/Bw1HiSmGAf5o2
         qc8q82lHyB+gghxnRuZVtG0b8kId6umvOANRWFY/fFxFzxbQdnq2OTV5i5T2KuScZJji
         6kNfThbEJzbg6dcdw9FFwXlR4WAl4t8/SAjP9O1+qZRDa10kHDL2jftLnb93Po6uthH4
         Iy8PLqesMHwf+bq9g/qB6Kix3TboIqUb+cmu1caGtmQjZgxKSpjoU0JGQIK897UeQUJP
         NNQuxVE4K475VgwyJq7SYktHF3odDUiXjY4pH86/UuqmPItVp+4BTbHUCQVkKmaowvil
         y19A==
X-Forwarded-Encrypted: i=1; AJvYcCUvlhc2cKLI8Smsp5KJ8rMd1z7Xlf53EfAaAnnMPtFJAKYkinnp3ZMNoY/izJo94KBuUXQz+MBi3AXonGsu/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgVoKQ9UO0FBBQ8/QIMGPcmrmm6qYEQp3GKjS6VI0cRbr68RCO
	ffssrI6hEVuwxMzagIz3Kf8DvHzSHCqwLxVdpwRSczJuwbVJWJFDe5ny/LB1IfRNgYu8IVYYtxo
	3prj29InJtSEhwcoPjZaGAGimixPZtyEeW9p4ItHTXQJ1Pgnv0nKIpx0HVBxyirtZar8l
X-Gm-Gg: ATEYQzz0WBOHnvroXH7roRY1xz5nactVRtmPaDh9o5z597kuXddTzISCzuhVkpJBemo
	wak2QptMkWfu2Br9JUcRcAoLqZBjx3up6gbCq/K6iFdwpPTuEnnVem/DWPTS1GklbGEMw8HIn8o
	kotjAxbpnpWq2PinS+2fTnXwrwzlEGG3230BjDz0OskO6o9J9rsS7N4M/daTPaJMmbsu8YbUS2I
	4TK9yiL7GCjyV7mb6z5HCOfhWW/NGP2yZou7+0ywti1u5qmmXa9NnGsZo0abhAduoJSVu0BnrLb
	wRK9Uz7SeWYImBnyf1lSu2rpu7S9G1156+9WkpDgqQP2JL/HsGyOrfy6QCm+VNQuZdig1fgvaTN
	p2/yZU3Eau+xlzlU=
X-Received: by 2002:a05:600c:4705:b0:485:3dfc:57d with SMTP id 5b1f17b1804b1-4871608481emr9678885e9.30.1774374155069;
        Tue, 24 Mar 2026 10:42:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4705:b0:485:3dfc:57d with SMTP id 5b1f17b1804b1-4871608481emr9678495e9.30.1774374154616;
        Tue, 24 Mar 2026 10:42:34 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48716549160sm3084885e9.3.2026.03.24.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:42:34 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:42:31 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-can@vger.kernel.org, virtualization@lists.linux.dev,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	Stefano Garzarella <sgarzare@redhat.com>, francesco@valla.it
Subject: Re: [PATCH v13] can: virtio: Add virtio CAN driver
Message-ID: <acLNB9PYmJ9L0Wvc@fedora>
References: <ab2FlQTWUxl0KmlT@fedora>
 <20260323-hilarious-active-eagle-a0ee74-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260323-hilarious-active-eagle-a0ee74-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3QBEBKYAdFs70UWfoikGGR02Mb06qepm1k3qfZ6C7Rs_1774374156
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 23, 2026 at 11:36:18AM +0100, Marc Kleine-Budde wrote:
> Hello,
> 

Hello and thanks, I am struggling to come up with a solution for this
comment.

> The nipa/ai-review bot found these problems:
> 
> | https://netdev-ai.bots.linux.dev/ai-review.html?id=b046d75a-2de1-4063-bb96-8f64abc65e7d
> 
> commit 0f3cb3b3bc94eaff9b9709b528e498fe6150f9c1
> Author: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> 
> can: virtio: Add virtio CAN driver
> 
> This commit adds a virtio CAN driver implementing a complete CAN bus
> interface over Virtio transport, supporting both CAN Classic and CAN-FD
> frames.
> 
> > diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> > new file mode 100644
> > index 000000000000..57641c3ed6d0
> > --- /dev/null
> > +++ b/drivers/net/can/virtio_can.c
> 
> [ ... ]
> 
> > +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> > +{
> > +	struct virtio_can_priv *priv = vdev->priv;
> > +	struct net_device *ndev = priv->dev;
> > +	size_t size;
> > +	int err;
> > +
> > +	napi_enable(&priv->napi);
> > +	napi_enable(&priv->napi_tx);
> > +
> > +	err = virtio_can_find_vqs(priv);
> > +	if (err != 0)
> > +		return err;
> 
> What happens to the enabled NAPI instances when this error path is taken?
> virtio_can_restore() enables both NAPI instances at the start, but if
> virtio_can_find_vqs() fails here, the function returns without calling
> napi_disable().
> 
I was expecting that, if virtio_can_restore() fails, then a successive
virtio_can_remove() will not hang in napi_disable() since the napis were
already enabled.  

> The corresponding virtio_can_freeze() function disables both NAPIs before
> returning, so the restore function leaves the NAPI subsystem in an
> inconsistent state on failure.
> 
> If the PM framework retries restore after this failure, the second
> napi_enable() call on an already-enabled NAPI will hit the BUG_ON in
> napi_enable_locked():
>

Does the PM framework really retries if virtio_can_restore() fails? If not, that BUG_ON
is never reached.

> net/core/dev.c:napi_enable_locked() {
> 	BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
> 	...
> }
> 
> In contrast, virtio_can_probe() enables NAPI only after all setup
> succeeds, avoiding this issue.
> 
> > +
> > +	size = priv->rpkt_len * priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free;
> > +	priv->rpkt = devm_krealloc(&vdev->dev, priv->rpkt, size, GFP_KERNEL | __GFP_ZERO);
> > +	if (!priv->rpkt) {
> > +		virtio_can_del_vq(vdev);
> > +		return -ENOMEM;
> > +	}
> 
> The same NAPI state issue occurs on this error path.
> 
> > +	virtio_can_populate_rx_vq(vdev);
> > +
> > +	if (netif_running(ndev)) {
> > +		err = virtio_can_start(ndev);
> > +		if (err) {
> > +			virtio_can_del_vq(vdev);
> > +			return err;
> > +		}
> 
> And again on this error path.
> 
> Should all three error paths call napi_disable(&priv->napi_tx) and
> napi_disable(&priv->napi) before returning the error code?
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |


