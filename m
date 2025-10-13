Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971D241103
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349179; cv=none; b=pi9TYgoJRWs92dytza20LG+zGXVl8emZvjhSaCD6tzMnsxCVn1FyZzuboAZmVJtPr+XWQGrKU47UPLbknWgCUi9Q721SlbarVfVGSCerv+WNIp10XdJV6Ex9Mvf778D/4YJk5scGXPTsurH4FoQQtOJ9DiA0Chva2KXTjdOgaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349179; c=relaxed/simple;
	bh=Cv2pxU9WsCUo3pBsuAkVnFh3X1Cxe7DJidXgAYF03Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ggd0igCHlUtu730WFnPMZh1cZw8uBn6HOizAyDSRvBu2HjHNZ7+P9kFpH/aBRAZtD3JjvKs7+mOUG07I3Rk4UlcKm3ELipYDo+pcIFb0LMto9KqfTYKylERpC0l+0AbzZy79+W+N7yOlMVD/uqmnps2DT6QEQQ9WKrB0xF9OazQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFjwGDCb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFjwGDCb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760349176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6mqEeRrvidObhzNRzchLNQqA+ReDntMNjcs0lPjGX4=;
	b=WFjwGDCb0qTrQj7Yt9MvpDyxRI36YsHKxpXrDLI4A1oVYnOCzWmIRFkBl05pSjZdt/fbcY
	Wm1VYo1NRYPbTIKfhKotf42QyuZG4lOEKo+hAa0Ym1SvSrd9GsoRdbHvIW7yrxJ923zuXF
	LfPf6l83J/JLP2g/tF3RrjYJN9HTvZY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-yUf40WqaPqKid2-0nGm_Tw-1; Mon, 13 Oct 2025 05:52:53 -0400
X-MC-Unique: yUf40WqaPqKid2-0nGm_Tw-1
X-Mimecast-MFC-AGG-ID: yUf40WqaPqKid2-0nGm_Tw_1760349172
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso3218928f8f.0
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 02:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349172; x=1760953972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6mqEeRrvidObhzNRzchLNQqA+ReDntMNjcs0lPjGX4=;
        b=rBt0TjNU1ux5HQE2sOeQKUmTrwIcJSEiv0h62AZud19W4zR/YpnhhyzDCbKPvvIhF9
         qZCyTRQYISZBHtb0s+iUJN9fLoAxxvtSbSXSm5wtF4UrLtucLv/KYEq5oo2iYzJUbSMj
         0WGgeSoBTC8hm//jaa5C0C1foVye0V1uIjJtsAtaub6NVXX7XSAJ2HqEwHTNpHIWdAl2
         jgmGZYDtf9cGKeA96XbM5YR8J2GSY+NPUbQ9dbLU2bSCSZed01D6OJhvO0juoH6lRS5S
         bRHKfHM+F9Sqd8WRPDz52K8l/KGKUlYWCCspUNhjj8IAKAhJf8F/k6ckSlQYPsiYhlR+
         hBtg==
X-Forwarded-Encrypted: i=1; AJvYcCVfykyMIQLQknarW8HM/tbpDGcVGNcNUdg2YNNmD+0CGzwy+sI3JwGV2ln46JL2Q9A0WJloPrtq/UucuBukEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQK82G2mOsKroQY/zhR1+cO7cgXxYC+U7LYn4TYVyqdvHvP24d
	BK1deM6+q4ITh+YZ7mMxysIwUQlS/asVl9uRRQQRHZlDso1GcehlddfsblfV7le4I2Ibu3C8FwS
	nw1e3gJBuOFChA/aYTyT200kzE8vgqPb5QcQouHkASnTcFN4sprIEEeBkXeDo3Dmi6v9u
X-Gm-Gg: ASbGncuZ2CyuG44BsrfOI/LriLBAGUM7UNo+iYy+ZQTNxTbpwYgqNBF+UBm3MQZsX3y
	TjdpBbkMUJNaumPorwR3/VwuHxWrYgrBJeV+4nL5MQ98rw1Pwyfu340oe/iZCrVSbYZxExsSwsG
	hbcf+N20iguDXnlhomF1xPChMKivD9AbHTCGPCReGYTZZnveHj6fLAST1O31ZlYMG0jnfLiH1C4
	QC1iV9LYOooOf0ON6yPmtFfptFVhpaAiwgRF7JmJDRwe+6HaL9INW1hoJ6WH7TuBJIC+bs3GPdQ
	k9DXwR1l0i88PSsH9raFBhvlgS2MRJAvLg==
X-Received: by 2002:a05:6000:41c9:b0:426:d54e:7f78 with SMTP id ffacd0b85a97d-426d54e802amr4973498f8f.18.1760349171973;
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFToPVmudWTFsq6bFqEIEPs/FQujXTZ0U+mV3FlG97R8DNDTM+O9fu/M5ZF2UtsJ7uQAo9BZQ==
X-Received: by 2002:a05:6000:41c9:b0:426:d54e:7f78 with SMTP id ffacd0b85a97d-426d54e802amr4973477f8f.18.1760349171548;
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf790sm16929272f8f.28.2025.10.13.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:52:51 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:52:49 +0200
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
Message-ID: <aOzL8f4C27z361P2@fedora>
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
X-Mimecast-MFC-PROC-ID: nkGchx7U9N3AJ3Z-xClJ5sfEqmKKx83MjyPGZSZJXWA_1760349172
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

Thanks for your answer. What is the value of VIRTIO_CAN_MAX_DLEN? I
can't find it nor in the code or in the spec. I guess is 64 bytes? Also,
IIUC, using __counted_by() would not end up saving space but adding an
extra check for the compiler. Am I right? In that case, can't I just use
a fixed array of VIRTIO_CAN_MAX_DLEN bytes?

Thanks, Matias.

