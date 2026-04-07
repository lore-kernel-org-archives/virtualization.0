Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B222222AC
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569736; cv=none; b=Qqsi1UqIGhFeY4Li7lfYoENeuhBBvqwKuuuF5zsiOFXAwpY9YTww+omfTh0M96vvBBNGrT6f3wmXeqJNNmFeuASCLhxsHM7Xqwjua7c8BpRn0ebEsB1IjX77Mrb58xCr3d9k59skMoaloxcy2bjXzWYeVog+6uV3HGcVlieOskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569736; c=relaxed/simple;
	bh=ku//Og96honEKfqlO6IFIyTkbq5vfNMlseA4tBULPUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dxjJkEGbmjFUc9BKryvSpOEI8ZhLj3A3wW4NPab0hJdCZc0bsFtCl12I3DpGDoAI7Jv+tuBshmH787JgLMsda5jt7ahO9H6hVVD573SFEk+wDWfmLEaO+6hYTAMEXE7VKF88hG4XNNbWGEsBisf/mBFEBLfno8kuawwThflT1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKZyJe9D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKZyJe9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775569734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SemPS/ErL+EkevTHIsXEII6ZD+AkVr3URBNYDRGp7Q=;
	b=VKZyJe9DiylRorzBRcnY5xBvkBB5TLowIo1ydYwZlamyGa+TSRgPNAodqh9Ep1/UchnZlj
	juu/caEZqrpWlG/qQfwGloKmvpxMzgsgn8oFM1yFMOJDoFUGkAgYQl/qVAri9LbeCOqekX
	ASHQm4je5F3NM43UnLTucX3gRre7rtI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-1YdNVjqFOPi3K8WhlcQ2zg-1; Tue, 07 Apr 2026 09:48:53 -0400
X-MC-Unique: 1YdNVjqFOPi3K8WhlcQ2zg-1
X-Mimecast-MFC-AGG-ID: 1YdNVjqFOPi3K8WhlcQ2zg_1775569732
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c213b485so3492385e9.2
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 06:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775569732; x=1776174532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SemPS/ErL+EkevTHIsXEII6ZD+AkVr3URBNYDRGp7Q=;
        b=PIrFdrpLU9fsP9bx7M28pxqrJ3xUXqC03IyIxkLinGj4ZDkKFFLAXxywWVoVWJwlRQ
         EEUstOK4kAvkz0R1h3b90s9vaP+GlvrUjbmdrqUEp/HmUYx7UDtx9pzbM54UrJLW7BWq
         Rt5GqjhbCPe6vSSeVcR8U4Vwh3kxBjlqSd7ltxoUZblDH4VEgMx6tWHOXCWe7NFQMPLm
         0lG7w7+jCf5tnEW25wTNdCrF8M+DSVSRHpeSsLU4f5Ro0W55J1E8MgTddmbBigkFr//L
         ZxRwRYhwk5ZHixWaldCMvRrmy2VPiF3voQy4d+A5ntNPWRPql8t95CvppHj8wNmWzZsD
         G/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUDVfJVnCZVQR2jZtdeaYZv/a+m+qpx7C0fIF+/yRUvSiocL1W7iTv1MjGhNabPF7jnMWTw1BMZcneR/9GHPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/q2pVtExNMV+khpmnTv+67x8MzXqaC9o5RpBTJzUu75IRLaRl
	nbEF/VYwxD4Pgw986B0Dvgww6L0h2FJymxgHsB8aJtswpn5vokgQR5dBlLI4lOT++bkIgmA4XDC
	xR8y3f8kyUrVNPiXowENI0hgwEdp16H72T2r87G+UvrAq+j6Gd3Doeb6RXvK+KHta8Xjb
X-Gm-Gg: AeBDieuKHm/TqTGTOE71llM0YtAF+13sS2XbHfGPgxaa4AyktqcND30itagpk62gIvh
	YmWUsqBLGNnNdhCM0fAbk62xxnr3kLddkEdFq9YlaZlyau2pNElbrrRMT5FMkpGaQIN5bWhiHYC
	s+oO2KNEhb8OGy0dVlDtDDt3qZpkKTvm4pm/GL1scI20KCJ0O+03S6aVaRP/+fCosse2YtR5WX2
	oa46KB1AG5i3XhH7FRcHzOVgAByY7WSZo5C9MqkbXHlhksaLsww1QJ/8awuZLn9uBH3SIMQ/IUC
	ilnvUk61seuYSNMuIYFCiym+qGdhTKEsqQjNPaFF30qhxpfcZD4RskXALK7TuAuwCkw4I+mh4p2
	95KIHVvjjviWnKvU=
X-Received: by 2002:a05:600c:638e:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488997dec25mr231622825e9.27.1775569731561;
        Tue, 07 Apr 2026 06:48:51 -0700 (PDT)
X-Received: by 2002:a05:600c:638e:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488997dec25mr231622475e9.27.1775569731074;
        Tue, 07 Apr 2026 06:48:51 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm543792925e9.12.2026.04.07.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:48:50 -0700 (PDT)
Date: Tue, 7 Apr 2026 15:48:48 +0200
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
Message-ID: <adULQMZggR9M/Fgx@fedora>
References: <ab2FlQTWUxl0KmlT@fedora>
 <20260323-hilarious-active-eagle-a0ee74-mkl@pengutronix.de>
 <acLNB9PYmJ9L0Wvc@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <acLNB9PYmJ9L0Wvc@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j3qwHQJGtuoPQvaxBa6u_kWMXTbyYOKmzOy1yIwaiv0_1775569732
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Mar 24, 2026 at 06:42:31PM +0100, Matias Ezequiel Vara Larsen wrote:
> On Mon, Mar 23, 2026 at 11:36:18AM +0100, Marc Kleine-Budde wrote:
> > Hello,
> > 
> 
> Hello and thanks, I am struggling to come up with a solution for this
> comment.
> 
> > The nipa/ai-review bot found these problems:
> > 
> > | https://netdev-ai.bots.linux.dev/ai-review.html?id=b046d75a-2de1-4063-bb96-8f64abc65e7d
> > 
> > commit 0f3cb3b3bc94eaff9b9709b528e498fe6150f9c1
> > Author: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > 
> > can: virtio: Add virtio CAN driver
> > 
> > This commit adds a virtio CAN driver implementing a complete CAN bus
> > interface over Virtio transport, supporting both CAN Classic and CAN-FD
> > frames.
> > 
> > > diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
> > > new file mode 100644
> > > index 000000000000..57641c3ed6d0
> > > --- /dev/null
> > > +++ b/drivers/net/can/virtio_can.c
> > 
> > [ ... ]
> > 
> > > +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> > > +{
> > > +	struct virtio_can_priv *priv = vdev->priv;
> > > +	struct net_device *ndev = priv->dev;
> > > +	size_t size;
> > > +	int err;
> > > +
> > > +	napi_enable(&priv->napi);
> > > +	napi_enable(&priv->napi_tx);
> > > +
> > > +	err = virtio_can_find_vqs(priv);
> > > +	if (err != 0)
> > > +		return err;
> > 
> > What happens to the enabled NAPI instances when this error path is taken?
> > virtio_can_restore() enables both NAPI instances at the start, but if
> > virtio_can_find_vqs() fails here, the function returns without calling
> > napi_disable().
> > 
> I was expecting that, if virtio_can_restore() fails, then a successive
> virtio_can_remove() will not hang in napi_disable() since the napis were
> already enabled.  
> 

Ping @Marc Kleine-Budde, do you have any comment about the comments
above?

Thanks, Matias

> > The corresponding virtio_can_freeze() function disables both NAPIs before
> > returning, so the restore function leaves the NAPI subsystem in an
> > inconsistent state on failure.
> > 
> > If the PM framework retries restore after this failure, the second
> > napi_enable() call on an already-enabled NAPI will hit the BUG_ON in
> > napi_enable_locked():
> >
> 
> Does the PM framework really retries if virtio_can_restore() fails? If not, that BUG_ON
> is never reached.
> 
> > net/core/dev.c:napi_enable_locked() {
> > 	BUG_ON(!test_bit(NAPI_STATE_SCHED, &n->state));
> > 	...
> > }
> > 
> > In contrast, virtio_can_probe() enables NAPI only after all setup
> > succeeds, avoiding this issue.
> > 
> > > +
> > > +	size = priv->rpkt_len * priv->vqs[VIRTIO_CAN_QUEUE_RX]->num_free;
> > > +	priv->rpkt = devm_krealloc(&vdev->dev, priv->rpkt, size, GFP_KERNEL | __GFP_ZERO);
> > > +	if (!priv->rpkt) {
> > > +		virtio_can_del_vq(vdev);
> > > +		return -ENOMEM;
> > > +	}
> > 
> > The same NAPI state issue occurs on this error path.
> > 
> > > +	virtio_can_populate_rx_vq(vdev);
> > > +
> > > +	if (netif_running(ndev)) {
> > > +		err = virtio_can_start(ndev);
> > > +		if (err) {
> > > +			virtio_can_del_vq(vdev);
> > > +			return err;
> > > +		}
> > 
> > And again on this error path.
> > 
> > Should all three error paths call napi_disable(&priv->napi_tx) and
> > napi_disable(&priv->napi) before returning the error code?
> > 
> > -- 
> > Pengutronix e.K.                 | Marc Kleine-Budde          |
> > Embedded Linux                   | https://www.pengutronix.de |
> > Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> > Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
> 
> 

