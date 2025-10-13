Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D12308F3C
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364947; cv=none; b=pIO0jfuAW34rH/MIq2vh3JYVUfKTFV5ij8g/j8NG5Pd7QFwLHNgFj4tx78OPRkIy1rSyEncNIzDjzqFHEuRqTlV++mLHaMWak77dE+05Ij3u9uthJDFe1lAPEE3WbSTJPgt5lYBlA3i7KJW1DFZwKXz8xMgMGUHpRybPFV2VYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364947; c=relaxed/simple;
	bh=X6/q1bHsLK+ZhgGEzfdnTYkllaQ39VA9H94eFOB9hyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q78YrZg11N4ZeC3EnS8TgqDXAjadEh+yIYnpCCEDylnkG9lH/A7TS/QwcdRVnJGq94PHnbkt9UURmXrkUU5I0qpNHBtgqy3QpswAZ19UWMY/RfI/W5+PdEIDh5A15AwvUu2y2vEO/H5sWkz0JE/LfcuUzEno3UcMA0WyIDu7naU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxvJ9B5+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxvJ9B5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760364945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9uIgQtAlSBtKcFSO9NiV0X395eAsPo0/3pZRzpykst8=;
	b=OxvJ9B5+Ov0+JYuUbY/CpHKdEMN8k9UsUM/YcDt+ySUsd//bH/N+I23vdQmxQPitI2GkdM
	6rLS0m44nKF2PFpiHdY9wM8mXdrCEqqpTgZCrq+m0igJmHAkn94ZIOATPfRn8Z+HdV9pBU
	QBvUt5nU8mDSsb6+enDMKP2R6ktuFeY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-LRQHmV82OtqxDS7LqXtVKQ-1; Mon, 13 Oct 2025 10:15:44 -0400
X-MC-Unique: LRQHmV82OtqxDS7LqXtVKQ-1
X-Mimecast-MFC-AGG-ID: LRQHmV82OtqxDS7LqXtVKQ_1760364943
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso39068045e9.2
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 07:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364943; x=1760969743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uIgQtAlSBtKcFSO9NiV0X395eAsPo0/3pZRzpykst8=;
        b=HVVqT4cd2lFdYi5AGgcxPtKFjHCzRS8BvoVavbR4L5y8MLMIfCUtrxuJkvwGpPQtoz
         QsR6QMMfki8tug9vWZ4v7LNDjF/gaqrqHM6xRUkk7KyFe3JRfWR2NGafdcb/UzjMV1MV
         HMWA35O4PytpjD41HfReKUjidI5XzQiOZTpeGFx98xZHERjL+XWilXfuTdxo878B6DpQ
         1MSd7GYiUhryNDCfdCsrg/M6NCGVYKuNIE2/ZlhZjumUuXrtTuGny2M8WPXxByJM+cyu
         NyoO97M++jpq4WT6u7weO9TDd/6wsWDXIajbzjmdbEJIVPgMJeWm8ojRHINLr79vpjoW
         f3tA==
X-Forwarded-Encrypted: i=1; AJvYcCVC90+reOp4z/I/lYpKtkNppF+F73/4AIdQ4cK0pDz8cov4+nb+0JF1sv0I1B42hkL8wVtxZq/40HFK+bJ9Ig==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWZGcg6gnz1JMPxN5b7ND9nZhG7uj+9USrgY11rwmngasxwnCc
	tO/aDaaFaLvXhDlUOs6EaryfgNwWNBDASs+MQFnjhmeON0RIlIk3XKHkVTaJ8HP8ixm2tGceNC9
	IFsUh7iOzaOSmYgRLGS8jTzLSythYS1JJOIITD/v3oNXyGqDG8aaRPBv2U/o+ntpXa9Ng
X-Gm-Gg: ASbGncsz95TXgOCOp6HBpu2L6a555GEcX9uTNxrHwzil5OXrdyKrLonwLqhp+vZAd/X
	Q1SKtdoLVHUt7H5A3ddSH/TOrnzcNIR/9EfDaIaN9bS14H5qRAq6X+6zNbyVRwumWBthl5JfDlN
	t9YXZ9nen8Qrow0PwpHchyZwQ3F4jNfhkATO/oFFpqIxGR+Trfd+3OxaYSGZiEq0qYmtc8FmMUq
	y3eaVwDLwR4/xJMheX1hkrwUUdshvk3ngkk5fTyi8vaaCnOnYlj41rv5vFtDLAXQCaLB7PK68gH
	G5RuXfeU9dyi58bhM17rDetW5VgtCwJb/w==
X-Received: by 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id 5b1f17b1804b1-46fa9a9ebb8mr139543425e9.9.1760364942892;
        Mon, 13 Oct 2025 07:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR9AfQG1bPxhSVGiAWctJCWR2+PTWw1bYga2tLxdTe6Ieug+DROBY5xi12o8AGOXPV/OiFfQ==
X-Received: by 2002:a05:600c:502c:b0:46e:3d41:5fe6 with SMTP id 5b1f17b1804b1-46fa9a9ebb8mr139543115e9.9.1760364942471;
        Mon, 13 Oct 2025 07:15:42 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3520sm136542145e9.2.2025.10.13.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:15:41 -0700 (PDT)
Date: Mon, 13 Oct 2025 16:15:40 +0200
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
Message-ID: <aO0JjDGk2zLlzB1E@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2243144.yiUUSuA9gR@fedora.fritz.box>
 <aOkqUWxiRDlm0Jzi@fedora>
 <2318164.vFx2qVVIhK@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2318164.vFx2qVVIhK@fedora.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xZI44WcekQOTc83dVIdyTEM7h2rPUqLYzC033Rl9p8Q_1760364943
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 10, 2025 at 11:20:22PM +0200, Francesco Valla wrote:
> On Friday, 10 October 2025 at 17:46:25 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > Hello Mikhail, Harald,
> > > 
> > > hoping there will be a v6 of this patch soon, a few comments:
> > > 
> > 
> > I am working on the v6 by addressing the comments in this thread.
> > 
> > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > 
> > > [...]
> > > 
> > > > +
> > > > +/* virtio_can private data structure */
> > > > +struct virtio_can_priv {
> > > > +	struct can_priv can;	/* must be the first member */
> > > > +	/* NAPI for RX messages */
> > > > +	struct napi_struct napi;
> > > > +	/* NAPI for TX messages */
> > > > +	struct napi_struct napi_tx;
> > > > +	/* The network device we're associated with */
> > > > +	struct net_device *dev;
> > > > +	/* The virtio device we're associated with */
> > > > +	struct virtio_device *vdev;
> > > > +	/* The virtqueues */
> > > > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > > > +	/* I/O callback function pointers for the virtqueues */
> > > > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > > > +	/* Lock for TX operations */
> > > > +	spinlock_t tx_lock;
> > > > +	/* Control queue lock. Defensive programming, may be not needed */
> > > > +	struct mutex ctrl_lock;
> > > > +	/* Wait for control queue processing without polling */
> > > > +	struct completion ctrl_done;
> > > > +	/* List of virtio CAN TX message */
> > > > +	struct list_head tx_list;
> > > > +	/* Array of receive queue messages */
> > > > +	struct virtio_can_rx rpkt[128];
> > > 
> > > This array should probably be allocated dynamically at probe - maybe
> > > using a module parameter instead of a hardcoded value as length? 
> > > 
> > 
> > If I allocate this array in probe(), I would not know sdu[] in advance
> > if I defined it as a flexible array. That made me wonder: can sdu[] be
> > defined as flexible array for rx? 
> > 
> > Thanks.
> > 
> 
> One thing that can be done is to define struct virtio_can_rx as:
> 
> struct virtio_can_rx {
> #define VIRTIO_CAN_RX                   0x0101
> 	__le16 msg_type;
> 	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> 	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> 	__u8 padding;
> 	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> 	__le32 flags;
> 	__le32 can_id;
> 	__u8 sdu[] __counted_by(length);
> };
> 
> and then allocate the rpkt[] array using the maximum length for SDU:
> 
> priv->rpkt = kcalloc(num_rx_buffers,
> 		sizeof(struct virtio_can_rx) + VIRTIO_CAN_MAX_DLEN,
> 		GFP_KERNEL);
> 
> In this way, the size of each member of rpkt[] is known and is thus
> suitable for virtio_can_populate_vqs().
> 
> 

From the spec, VIRTIO_CAN_MAX_DLEN shall be 2048 bytes that corresponds
with CAN-XL frame.

Matias

