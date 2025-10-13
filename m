Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D82D0C95
	for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378846; cv=none; b=bWqHKRzDHoTrj9CSkRwnmSeEK8LpEmAPv6RB0Olaa8J4dn8jOwoxSowT7K9VW9KDQTzlMP9Kn+mnj8wloZqUYLgvMKIyr+K7vTMPBBnzG0tuTXVfiKdL6dVE2hoDl8NEJxo0CVFyOnENj9FalI93d3NuuQnFPAaKSmGYTvrznZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378846; c=relaxed/simple;
	bh=ec468sUdlPior92fEOwciycgEdPP3rJJ7JplWSCISIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EhTnvv/CkPOd/5+CVlLgKsBDFdEVWfYR5XFQu8ghZYg2KMLZYV99a/loVM+y3N5LQNJjFC1ODDKMg7i+qUkN2Sl53QBFWpIou5IwVWkuzr8W467Am9IIBKJnXiAGoyabaewqflEwAz6IEvnKWofie4Jlxw1I98ZkTo3yqBGcGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ha6ShKg0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha6ShKg0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760378843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heV73gvBg4o6OaIEpLpiDR+pemy/KAioE642ZBmJkl8=;
	b=ha6ShKg0F7qc+1gEweNcJxnuPo/rlxhwTDzzrgc+uiOmmWuX+c0lWSh8bMa/qKOi7vj5RU
	q28/q5F5H9emeJy20vngLVW14s20FgfhLmjO3IwtljQZjfMVBk0GIBMgfRuK12vHN6PivV
	uJSRVZkeGeGrMjxugl8crnGvjeXFWtY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-F8bSVIBkNLyIcB0kgLlAJg-1; Mon, 13 Oct 2025 14:07:22 -0400
X-MC-Unique: F8bSVIBkNLyIcB0kgLlAJg-1
X-Mimecast-MFC-AGG-ID: F8bSVIBkNLyIcB0kgLlAJg_1760378841
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e46486972so26618415e9.0
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 11:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760378841; x=1760983641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heV73gvBg4o6OaIEpLpiDR+pemy/KAioE642ZBmJkl8=;
        b=NhCZMFVcxz7/0M3QyOdBl0Dki5E5STIn3wJrpwbm5Au9ipNNILHq4gH6+pmrBl97sC
         PMLrrpdaMEvbkS+3Yb9j87HBBU5fYjFxFSemMUKnJvgI9cf/LmS+a1NOIWQmW4cRttpV
         rUtVz+v2WZJWEVPRGXa4HAA3LS3bIp3HdLVoHqd1Pxp2SNoScod4zXltW5dze7xbXHWR
         zfcKi+Ou46fFXlAxz25Ulie6QhK7L2QqQh/pswd91dDT3SZ5Zyelde8ABwRraSZv8ty9
         t+502YMo5G1gULnSiznGCfvIvCi54WVdEmoQxTZe0NKiG7NgpgoiuEiL5vf72qp7pp8D
         Eq5g==
X-Forwarded-Encrypted: i=1; AJvYcCUtz8WiX2EMCNlzEzZMBaqpt6wDP1QFQBI6r43wK9fKH8H9cfkw4n1IUYTECiwu33mm+TMPt4T4c+OZyegmIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxzt07zqHgL4XiUXzCHTwDPkfLoTavWEpu3IohG/XXTf8XnnZXM
	wY1NOTDwHTFikKztMjmYj/VL2a3vE/qxaVwY8R5QP79qthTb/xpaqrFuXrFQSCvTdrMIkrglGVe
	rRZX9tv9LsYGBJtr95Yu+clo1eRRjgVEZtGQEtMlq0D/fp2Ot6yZT+ZAIIWkXqLoT+N9P
X-Gm-Gg: ASbGncsdPeZQ/yGEazMha/bOB54nEAAZOTWCm33lgSZSA4g6hk88OFkZ9EkwwAc5eNV
	2T0j2jeqFFZYHWiSSu0Kp8HfSjjPO+2ounhQL6GXQh/5SRWG6jo032nbRLwLSsL3xCvtkmI1C83
	RjSFQTdl3T22ZWKNi1qE3fYG9By19Usi/Ci7xm5csslCebzTYdzig7xQU2LGp0xUV/uuIT5o8TJ
	hG0GIXNj99KpaHhaITBjaa6hSMR/qTlDudfk2XejIuyhDCxXwAp+Os/aWZTxqkM9kV/s+DKzTsn
	z9JKBfsgcuWgoZgXw7KwMVqhp3k9iNcKAg==
X-Received: by 2002:a05:600c:8b38:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-46fa9af3682mr162925105e9.18.1760378840699;
        Mon, 13 Oct 2025 11:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6NSG53jZlFPMrLIRjIMLz3I3zfd3vW98lZywLTQ95z1DX1KrroQS8L4AgN5nQ3GdFs4i6qg==
X-Received: by 2002:a05:600c:8b38:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-46fa9af3682mr162924925e9.18.1760378840252;
        Mon, 13 Oct 2025 11:07:20 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49be017sm194828505e9.13.2025.10.13.11.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:07:19 -0700 (PDT)
Date: Mon, 13 Oct 2025 20:07:18 +0200
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
Message-ID: <aO0/1oCiuOgxZMrg@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <2318164.vFx2qVVIhK@fedora.fritz.box>
 <aOzL8f4C27z361P2@fedora>
 <5719046.rdbgypaU67@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5719046.rdbgypaU67@fedora.fritz.box>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RRGIN01u4nP-xhLBm9ImmFf4X2vtEbmNT-A5zYdha_w_1760378841
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 13, 2025 at 06:29:44PM +0200, Francesco Valla wrote:
> Hello Matias,
> 
> On Monday, 13 October 2025 at 11:52:49 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > On Fri, Oct 10, 2025 at 11:20:22PM +0200, Francesco Valla wrote:
> > > On Friday, 10 October 2025 at 17:46:25 Matias Ezequiel Vara Larsen <mvaralar@redhat.com> wrote:
> > > > On Thu, Sep 11, 2025 at 10:59:40PM +0200, Francesco Valla wrote:
> > > > > Hello Mikhail, Harald,
> > > > > 
> > > > > hoping there will be a v6 of this patch soon, a few comments:
> > > > > 
> > > > 
> > > > I am working on the v6 by addressing the comments in this thread.
> > > > 
> > > > > On Monday, 8 January 2024 at 14:10:35 Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com> wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > +
> > > > > > +/* virtio_can private data structure */
> > > > > > +struct virtio_can_priv {
> > > > > > +	struct can_priv can;	/* must be the first member */
> > > > > > +	/* NAPI for RX messages */
> > > > > > +	struct napi_struct napi;
> > > > > > +	/* NAPI for TX messages */
> > > > > > +	struct napi_struct napi_tx;
> > > > > > +	/* The network device we're associated with */
> > > > > > +	struct net_device *dev;
> > > > > > +	/* The virtio device we're associated with */
> > > > > > +	struct virtio_device *vdev;
> > > > > > +	/* The virtqueues */
> > > > > > +	struct virtqueue *vqs[VIRTIO_CAN_QUEUE_COUNT];
> > > > > > +	/* I/O callback function pointers for the virtqueues */
> > > > > > +	vq_callback_t *io_callbacks[VIRTIO_CAN_QUEUE_COUNT];
> > > > > > +	/* Lock for TX operations */
> > > > > > +	spinlock_t tx_lock;
> > > > > > +	/* Control queue lock. Defensive programming, may be not needed */
> > > > > > +	struct mutex ctrl_lock;
> > > > > > +	/* Wait for control queue processing without polling */
> > > > > > +	struct completion ctrl_done;
> > > > > > +	/* List of virtio CAN TX message */
> > > > > > +	struct list_head tx_list;
> > > > > > +	/* Array of receive queue messages */
> > > > > > +	struct virtio_can_rx rpkt[128];
> > > > > 
> > > > > This array should probably be allocated dynamically at probe - maybe
> > > > > using a module parameter instead of a hardcoded value as length? 
> > > > > 
> > > > 
> > > > If I allocate this array in probe(), I would not know sdu[] in advance
> > > > if I defined it as a flexible array. That made me wonder: can sdu[] be
> > > > defined as flexible array for rx? 
> > > > 
> > > > Thanks.
> > > > 
> > > 
> > > One thing that can be done is to define struct virtio_can_rx as:
> > > 
> > > struct virtio_can_rx {
> > > #define VIRTIO_CAN_RX                   0x0101
> > > 	__le16 msg_type;
> > > 	__le16 length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
> > > 	__u8 reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
> > > 	__u8 padding;
> > > 	__le16 reserved_xl_priority; /* May be needed for CAN XL priority */
> > > 	__le32 flags;
> > > 	__le32 can_id;
> > > 	__u8 sdu[] __counted_by(length);
> > > };
> > > 
> > > and then allocate the rpkt[] array using the maximum length for SDU:
> > > 
> > > priv->rpkt = kcalloc(num_rx_buffers,
> > > 		sizeof(struct virtio_can_rx) + VIRTIO_CAN_MAX_DLEN,
> > > 		GFP_KERNEL);
> > > 
> > > In this way, the size of each member of rpkt[] is known and is thus
> > > suitable for virtio_can_populate_vqs().
> > > 
> > > 
> > 
> > Thanks for your answer. What is the value of VIRTIO_CAN_MAX_DLEN? I
> > can't find it nor in the code or in the spec. I guess is 64 bytes? Also,
> > IIUC, using __counted_by() would not end up saving space but adding an
> > extra check for the compiler. Am I right? In that case, can't I just use
> > a fixed array of VIRTIO_CAN_MAX_DLEN bytes?
> 
> My bad, I forgot to say that VIRTIO_CAN_MAX_DLEN has to be defined, but:
> given some more thoughts, maybe this can be a dynamic value based on
> the features received from the virtio framework, to avoid wasting memory?
> 
> E.g.:
> 
> if (virtio_has_feature(VIRTIO_CAN_F_CAN_FD))
> 	sdu_len = CANFD_MAX_DLEN;
> else
> 	sdu_len = CAN_MAX_DLEN;
> 
> priv->rpkt = kcalloc(num_rx_buffers, sizeof(struct virtio_can_rx) + sdu_len,
> 		GFP_KERNEL);
> 
> 
> My understanding of __counted_by() is the same: additional checks but nothing
> more.
> 
> 
> CAN-XL appears to be not supported by the virtio specs v1.4 [1], but if/when
> it will be, the addition of an additional case would be simple.
> 
> [1] https://github.com/oasis-tcs/virtio-spec/blob/virtio-1.4/device-types/can/description.tex#L33
> 

Sounds good, I'll add that.

Matias

