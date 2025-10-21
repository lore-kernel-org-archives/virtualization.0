Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5F2F8BFC
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039617; cv=none; b=ue3MaGw2wNkBTDT1+7L3vXPWy9ndLU5UTtEoChUVffy9NN6UYrfDB8UgSSI2H4NiSKOedYFGuD8u1+JktXyFZKxsNsYApTcwrczT84XVQFSgUF5h0VzLyjKbAG41t8eu12kmw/mHtq+veG6KYq4Jgthxf0umwj5652d3OqIZuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039617; c=relaxed/simple;
	bh=joioCTHNcicHEl18wOj/vKbeHGh0dtHXxJrEocOCvK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lHHcCwFFBilu3DE5iiI1Gh0BKMqyXypBuuUtLDuelZkW9ojf2priOLCRpEn2jo0RlagbsBWK/iOYsI350C0sF5TDtJSBC762RuL+JTm/da0NiIYE8UrkxuJ9uAxbJdtjsOq9GN3EHpRBhcZ/h+xt5CtMfVUJ2+sbprrXnBW2rUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5gUnZQH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5gUnZQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58p/SRCqJ0LAx3dnpJuwG+DdvwsYHwAoukVUv/kmb8g=;
	b=Z5gUnZQHBU5i3vXLYBM+mDu+aTN37kEJLNwldV3U2Bcr4NSZ42MftnL0NDrwTo7jbSyWmK
	5IajxRWhXb48gKL8AMgTZfNOrTnmClQXmFICkERwFJMOHaQg5o2d9t2ALOrZrEpD+kBStF
	evNQWMDEYzYCF5Yro+z8wnjKHM/19Gs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-paDtCq7JMWCJ3Zqdkqp3tw-1; Tue, 21 Oct 2025 05:40:12 -0400
X-MC-Unique: paDtCq7JMWCJ3Zqdkqp3tw-1
X-Mimecast-MFC-AGG-ID: paDtCq7JMWCJ3Zqdkqp3tw_1761039611
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso59897205e9.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 02:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039611; x=1761644411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58p/SRCqJ0LAx3dnpJuwG+DdvwsYHwAoukVUv/kmb8g=;
        b=X0yFYRnZxtQdyKM/yi4YdVjI6/ju3qdraJGkYpK6z+C48l3A9H/sfD0IwoOwzMiKHR
         rDjVkGU2GN162jdU+u6BlGbW/j+sfNo0c9u23dLXdgU42RmgBcMOTZ1YeP0gixGfFEp8
         gM1MGESoda2+2CKlZUaM+f1JbJomsczAnaYHdLLaX2IUqVy/q1S3eYvFUiPkVBYIbILy
         oIwjkikG15USxvihsZvWKelVNYP0WO2nzyqiGl7X+XVp/SO+eM363FbSGRGWoJDoaR6G
         4tIlHd5QiJrgXWhWXAutj4fYL/JcUm2DhqDloKXio+UiP4bdoHVganJ7/u21KhACLN1+
         rYRg==
X-Forwarded-Encrypted: i=1; AJvYcCWUsSalVjTdS3P2u/ddLidJVe5CQFph+BeD3fANH23IzVnF5YcDA8wdfQXu0rLQGZjCIBeSR9vZQjEXEOvTOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0V3NJ22ByCTf8VqdPw2RS9QpcyoiV8RzLAv73qMWoFxwI5xs4
	LdKHI4lrTTfl1GXS+uRR2QMlujrNA+KoIhJdwYWmFRfveU1lSlVjxgBvVcTCvBNy8j6h+u+rrfj
	jIEsJxS4rfKbD415bj/w41rEqXmnPgf36bqzbwI9kIg4u9cRKseE3nih2poUxdAL4q/uk
X-Gm-Gg: ASbGnctPZsrdP5YbCKruliC1PN2qOhlQ37rnU+EAio8fnR6s1tCdF5gws2Gm2yd8+Zh
	ptVNloymhNz+25xiJcK3vExO7chVTIQW2TkpWlcPll+CvpeVz7WYz5Ev31CLOBDHlbsGKck2Ozj
	yJZcMg6KZYH9NX3G/PZLkN1ePF5At3v6qW0xCfm6LBjGq967DsJeGavjZZfNfhB4UKgdkmAh62E
	X0SVoQAzQIS/bBwMBJUxz6WKtRPFK0W2IObGiBn+Z9We0wH5Eg5aacomrU3L8Y/Rd+va+eOs4uR
	1o4q3zMykUfHVZjX0MnNoixWuwZZEIXk4d2Fb/SkM0397E27CQpYAhyQBwLyLDGm7qd0
X-Received: by 2002:a05:600c:524f:b0:46e:326e:4501 with SMTP id 5b1f17b1804b1-471178a785bmr115492645e9.10.1761039611068;
        Tue, 21 Oct 2025 02:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnKSW02QAXJ0oFhtSLv5TjL06FH3eXdLlv337/+4vkyG1qVajLc6qLhwPGLEda7bmT57ysBw==
X-Received: by 2002:a05:600c:524f:b0:46e:326e:4501 with SMTP id 5b1f17b1804b1-471178a785bmr115492395e9.10.1761039610598;
        Tue, 21 Oct 2025 02:40:10 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949dd479sm15669425e9.0.2025.10.21.02.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:40:08 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:40:07 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	development@redaril.me
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <aPdU93e2RQy5MHQr@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <1997333.7Z3S40VBb9@fedora.fritz.box>
 <aPZNiD1SN16K7hmT@fedora>
 <27327622.1r3eYUQgxm@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <27327622.1r3eYUQgxm@fedora.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w_RgKA2iSKQBUNgvxmL61HiQa6ln586MwLKPAJ3Kziw_1761039611
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 11:24:15PM +0200, Francesco Valla wrote:
> On Monday, 20 October 2025 at 16:56:08 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Tue, Oct 14, 2025 at 06:01:07PM +0200, Francesco Valla wrote:
> > > On Tuesday, 14 October 2025 at 12:15:12 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > > Hello Mikhail, Harald,
> > > > > 
> > > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > > 
> > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > 
> > > > > [...]
> > > > > > +
> > > > > > +/* Compare with m_can.c/m_can_echo_tx_event() */
> > > > > > +static int virtio_can_read_tx_queue(struct virtqueue *vq)
> > > > > > +{
> > > > > > +	struct virtio_can_priv *can_priv = vq->vdev->priv;
> > > > > > +	struct net_device *dev = can_priv->dev;
> > > > > > +	struct virtio_can_tx *can_tx_msg;
> > > > > > +	struct net_device_stats *stats;
> > > > > > +	unsigned long flags;
> > > > > > +	unsigned int len;
> > > > > > +	u8 result;
> > > > > > +
> > > > > > +	stats = &dev->stats;
> > > > > > +
> > > > > > +	/* Protect list and virtio queue operations */
> > > > > > +	spin_lock_irqsave(&can_priv->tx_lock, flags);
> > > > > > +
> > > > > > +	can_tx_msg = virtqueue_get_buf(vq, &len);
> > > > > > +	if (!can_tx_msg) {
> > > > > > +		spin_unlock_irqrestore(&can_priv->tx_lock, flags);
> > > > > > +		return 0; /* No more data */
> > > > > > +	}
> > > > > > +
> > > > > > +	if (unlikely(len < sizeof(struct virtio_can_tx_in))) {
> > > > > > +		netdev_err(dev, "TX ACK: Device sent no result code\n");
> > > > > > +		result = VIRTIO_CAN_RESULT_NOT_OK; /* Keep things going */
> > > > > > +	} else {
> > > > > > +		result = can_tx_msg->tx_in.result;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (can_priv->can.state < CAN_STATE_BUS_OFF) {
> > > > > > +		/* Here also frames with result != VIRTIO_CAN_RESULT_OK are
> > > > > > +		 * echoed. Intentional to bring a waiting process in an upper
> > > > > > +		 * layer to an end.
> > > > > > +		 * TODO: Any better means to indicate a problem here?
> > > > > > +		 */
> > > > > > +		if (result != VIRTIO_CAN_RESULT_OK)
> > > > > > +			netdev_warn(dev, "TX ACK: Result = %u\n", result);
> > > > > 
> > > > > Maybe an error frame reporting CAN_ERR_CRTL_UNSPEC would be better?
> > > > > 
> > > > I am not sure. In xilinx_can.c, CAN_ERR_CRTL_UNSPEC is indicated during
> > > > a problem in the rx path and this is the tx path. I think the comment
> > > > refers to improving the way the driver informs this error to the user
> > > > but I may be wrong.
> > > > 
> > > 
> > > Since we have no detail of what went wrong here, I suggested
> > > CAN_ERR_CRTL_UNSPEC as it is "unspecified error", to be coupled with a
> > > controller error with id CAN_ERR_CRTL; however, a different error might be
> > > more appropriate.
> > > 
> > > For sure, at least in my experience, having a warn printed to kmsg is *not*
> > > enough, as the application sending the message(s) would not be able to detect
> > > the error.
> > > 
> > > 
> > > > > For sure, counting the known errors as valid tx_packets and tx_bytes
> > > > > is misleading.
> > > > > 
> > > > 
> > > > I'll remove the counters below.
> > > > 
> > > 
> > > We don't really know what's wrong here - the packet might have been sent and
> > > and then not ACK'ed, as well as any other error condition (as it happens in the
> > > reference implementation from the original authors [1]). Echoing the packet
> > > only "to bring a waiting process in an upper layer to an end" and incrementing
> > > counters feels wrong, but maybe someone more expert than me can advise better
> > > here.
> > > 
> > > 
> > 
> > I agree. IIUC, in case there has been a problem during transmission, I
> > should 1) indicate this by injecting a CAN_ERR_CRTL_UNSPEC package with
> > netif_rx() and 2) use can_free_echo_skb() and increment the tx_error
> > stats. Is this correct?
> > 
> > Matias
> > 
> > 
> 
> That's my understanding too! stats->tx_dropped should be the right value to
> increment (see for example [1]).
> 
> [1] https://elixir.bootlin.com/linux/v6.17.3/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L1035
> 

I think the counter to increment would be stats->tx_errors in this case ...

Matias

