Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C57315D22
	for <virtualization@lists.linux.dev>; Mon, 26 Jan 2026 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422006; cv=none; b=Gx4qSOB/1AJwXYI76Ug3WPAIYS7YjVjEiauLJlDy1ON2dClVgKp0U+DDMelOUzNWuZ6LG9FcywSJbtWlt+tS8P30lzoF+Yd85nf1O9Ve9HpdOLbWG46cjOfX5MtKErKkz9qNIO195pvJM76V63QiQjuGRMdh8kgtSZMa04723vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422006; c=relaxed/simple;
	bh=RwbCROst0SrKoPI0Mz/RhGJ6cgMIVH0PkBXsjkD/Qrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DpcP9DOUK0ROqgOy/siOLsoeO6XUOYMd8akWN9NIliQVBeJhBSWoWwufokm0Lgl6Yk5zEXkG9GnyGvjkEe09B5HaCM9144hS153Tdk+hTDm2OJC4h16c9RTaxLjgh1YSfCCMtzOVV5Vo7GQQ5RTEcQYU+YxjCOzNrNXtQ2LXDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bR0W1fD3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR0W1fD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769422004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zGZ7zVWK6KG4OaKzcOGu+si3YSRlswA4cevBUVUMjg8=;
	b=bR0W1fD35gOc2yX6KVjidOCVSwEUBOEbAWd8/rKipA6j4rhUB3coZNpnSrO/j11pN5TK4p
	rExwQSKsCxPAu3zjNZ4JoKS3c2xXDjpaWpAanP110T3u28vFVZzveJRg/5IKKG+STnr37w
	je/mHD38fQS9blPx18AMFh5ZBXks/2k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-pxSqHZpXO7-v6d5dNFWmMg-1; Mon, 26 Jan 2026 05:06:42 -0500
X-MC-Unique: pxSqHZpXO7-v6d5dNFWmMg-1
X-Mimecast-MFC-AGG-ID: pxSqHZpXO7-v6d5dNFWmMg_1769422001
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47ee432070aso39049365e9.1
        for <virtualization@lists.linux.dev>; Mon, 26 Jan 2026 02:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422001; x=1770026801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGZ7zVWK6KG4OaKzcOGu+si3YSRlswA4cevBUVUMjg8=;
        b=m2IN4oGvXkXW9mZpMCWXakqyei0z20r/xIXno3XJSUNWqCc8tiK74psRGwK3nsqJhw
         l4i0pM6K5efNuB4mUD9+4srdRNO9zFQCo5xuhbzGlBvLM1Oh6oT/DN/uuOdBDdVzMHH/
         uN8ETz1nSKeFjBoq5xArXeNxJXTbDETJPLFyCSiNCFkA8x4tMg1nYMagCvHZhA6kUdIu
         WYLNqFOx9mRw71ciAeYAFB4nFqZDm88HR0DUwmr4dq7VoV2xHrq2oBlpIKZtjn+bMVw3
         zTIZiw56vRxADtsvqqiHIRXN0Jm3pWNpyv44emhsVy8UnZzf5zAkDhPa5z8EFRLqF7DO
         A5JA==
X-Forwarded-Encrypted: i=1; AJvYcCVY3ADboUySMVPPUM8AZVXvaxMOxPmA94P0a+w0pRd6KYz/xjqgJ7JG6X17ezyiLVf+t0BG1MwAq4Kt+4jyjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymsxzJ92lt2wQ14yLOIbUxMPQVHppxc/qMJJYwUgA8l7OBe35N
	snbotLBOiH13Ix2tjpVxTi+qimBRs93IBSWz2PDHe+PdMbft1fMmufnCmFnbEC5G7XlrXVx97NU
	q6Wnm171twiScPQe2cViERt7tGzaFILaicabBGQTpvb5VZAb959vVqchpJH87akdNOK9P
X-Gm-Gg: AZuq6aLFuTU/hWlXRA0bTUUN1ZMDrJN/JkxsJD0Vw9VFyFCAnSSwUP1P4FY/tCvqiDT
	jhZDqUbKTcXpAMK4fJ8b73tDe5RskhoyETVydOCEf/vOcHK1CD2mXespruakPFQD8+b5X7Edl3h
	wJDjecgnoDV1f+JoaFCx+V/L1Z6FJl3Td72PXcefrWSfIoB7Uif0SVijzo8g+n3XxsB3hbfqqA/
	3IlJZuCdIbvt2ydxYuuGqiLFsTI294fKN90TLie9WFQsDt/k9JedTRHvpvy03qoZcb5pUeOJFPX
	/Z5IpV2VOH3+lF8tUhyAaGdXtS58BtsA6wFll3hGaeCkFMJjfNLd7QnZlNyI5t3EGcTCWoSJMXo
	+nTY=
X-Received: by 2002:a05:600c:8b0e:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4805ce4def9mr74286525e9.16.1769422001248;
        Mon, 26 Jan 2026 02:06:41 -0800 (PST)
X-Received: by 2002:a05:600c:8b0e:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-4805ce4def9mr74286025e9.16.1769422000817;
        Mon, 26 Jan 2026 02:06:40 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85206fsm266170605e9.6.2026.01.26.02.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:06:40 -0800 (PST)
Date: Mon, 26 Jan 2026 11:06:38 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v8] can: virtio: Add virtio CAN driver
Message-ID: <aXc8rhN8SvmOFbJ0@fedora>
References: <aW/D8kiFu666wiuD@fedora>
 <aXYkWO0ShTsrjP1R@bywater>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aXYkWO0ShTsrjP1R@bywater>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VI2EH6srZLYhIrvBIO76VxRoYM5Drcdpq-CTHZPSG8Y_1769422001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 25, 2026 at 03:10:32PM +0100, Francesco Valla wrote:
> Hi Matias,
> 
> If an additional version is foreseen, consider dropping some more
> note-like comments, as in future they might become dangling.
> 

Yes! I am planing to remove some comments and send v9. I was not
completely sure which ones. Also, I was thinking to set myself as a
maintainer in case Harald is busy.

> E.g.:
> 
> On Tue, Jan 20, 2026 at 07:05:38PM +0100, Matias Ezequiel Vara Larsen wrote:
> 
> [...]
> 
> > +
> > +/* Poll TX used queue for sent CAN messages
> > + * See https://wiki.linuxfoundation.org/networking/napi function
> > + * int (*poll)(struct napi_struct *napi, int budget);
> > + */
> > +static int virtio_can_tx_poll(struct napi_struct *napi, int quota)
> > +{
> 
> [...]
> 
> > +/* See m_can_poll() / m_can_handle_state_errors() m_can_handle_state_change() */
> > +static int virtio_can_handle_busoff(struct net_device *dev)
> > +{
> 
> [...]
> 
> > +/* Poll RX used queue for received CAN messages
> > + * See https://wiki.linuxfoundation.org/networking/napi function
> > + * int (*poll)(struct napi_struct *napi, int budget);
> > + * Important: "The networking subsystem promises that poll() will not be
> > + * invoked simultaneously (for the same napi_struct) on multiple processors"
> > + */
> > +static int virtio_can_rx_poll(struct napi_struct *napi, int quota)
> > +{
> > +
> 
> [...]
> 
> > +/* Compare with m_can.c/m_can_suspend(), virtio_net.c/virtnet_freeze() and
> > + * virtio_card.c/virtsnd_freeze()
> > + */
> > +static int __maybe_unused virtio_can_freeze(struct virtio_device *vdev)
> > +{
> 
> [...]
> > +
> > +/* Compare with m_can.c/m_can_resume(), virtio_net.c/virtnet_restore() and
> > + * virtio_card.c/virtsnd_restore()
> > + */
> > +static int __maybe_unused virtio_can_restore(struct virtio_device *vdev)
> > +{
> 
> 
> With this (maybe negligible) note considered: 
> 
> Reviewed-by: Francesco Valla <francesco@valla.it>
> Tested-by: Francesco Valla <francesco@valla.it>
> 

Thanks Francesco!

Matias

