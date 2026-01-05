Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C632A3FF
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601434; cv=none; b=QbesS0nROv2bt1UwxEpaKRhRo4eue1hWwEXjyg6lrKhuT7DPGAzzk5YfGVlhBjFuzinnNPnOTk+FaR037KmA1v97nDpv4l1VtYE11EC7XCInW15Bjs70OQKVeUPtyC8G6ZHtpaqk0jZMlupo7OOHhffpTJUuuAhg0YeHENxLTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601434; c=relaxed/simple;
	bh=aG8SdrVHEUE18T+idL+tMCWXHe6vRndhmeQnti1MW2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q5F25nTI312hbfa/skDDCYkTHZDGc8gizezevGBygv21HD8y/u+PEFOLOhdSUXSy9ZAtESk1wP1xxFsWWVkbE+6hFDtU/TvDudBzEu45iR7mZK0CBLMDdjAA3TK5W7/LHpMGdpTdKiYLRRUcn+2pRVoPoQyYUDtTQ+6Bfr2cz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJLOHygn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJLOHygn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1WdygBrbpusefWmIaX+oAwz9bur1qkKHYd3aQzYNeN8=;
	b=IJLOHygn0jycrG+u+R2SxrrlpafXVcHrKb1JC2w8pPPPiq6z9M882Fus/umMrY5tKWf8A1
	c2c/0v7xocDq4o1d18R8L1W5IfUg5RCtcAsMWVq+xvCOQt5sSKnsHDvb9CJHHDCd0fqQtQ
	BPrSf5x8Yxr5NCkUB6i1nKgtt63QsTw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-K2Kmt-2xOumAbNAnruksNw-1; Mon, 05 Jan 2026 03:23:43 -0500
X-MC-Unique: K2Kmt-2xOumAbNAnruksNw-1
X-Mimecast-MFC-AGG-ID: K2Kmt-2xOumAbNAnruksNw_1767601422
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477c49f273fso171311065e9.3
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601422; x=1768206222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WdygBrbpusefWmIaX+oAwz9bur1qkKHYd3aQzYNeN8=;
        b=EmVz+v9Zd7wpCe30Mty7BmA6NwRyCJ2PWGGy/89a6ZNr1OiBv10Ac085KCaiMJ3Te5
         USKMXFqg+mThevXkuXyGQxitjUnCtPvWZzK6XpJPlPr+3/rZPfeNbGBXZKNbyblnlhz3
         t9l9OmnYmL/CqvGuulFukUp1o4fliQbEMmEmFd0YTTva7VIhWeKqhh0wsJSGwbEP1NUW
         wkU1Rlw8toy6inbceohjX86L/hX+3ImeitmkOQbTUew+BzFJebSxECPAyz/yxKQn3nOD
         zhUDkCMe0+e58L6z8WjvW8sDZZKHUxCDzRsCtoklWtu/Ok8vZTklQyU5BCKNkoMv2iRc
         JzVg==
X-Forwarded-Encrypted: i=1; AJvYcCXYekwpVFPMN/W+Gom5iSwzYRVzPMucl5wsZd3oEpe7LzVbqtfc+eYzw9YAO48W7ulmWRbx3iYQ9rT5nRTTHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzunFdFYsmPg2DzVAdVJgnJSDCkfsCct+QStqAcTstpp+stSAc5
	Qwk6+nhJi6CjPT4YwlYcor9L+qsleYCq5LO6opxJiTIkoYLTxlXEMje3r7jy2P/PUIut/MgKHtn
	NlvHevuGQIS8jLAkqr/8mtAZHnpqF660Kiscr9LmlHZ+q5lm/JM6/0ZW8NiSJrlKFEB5u
X-Gm-Gg: AY/fxX6WO2zSYG4E5nxGD4C/rx1SPMyJUicO68v64QYEalHln2d6udcOJzDHLMEUh4B
	D4l4HHxma3/ggWAFfT+kNLKok9zUGcydvcSSRRYSK5gkUaUGgea0tXwkfh4uooTui0l9Bb1D/zv
	I2sLY7A1Im0hclu0hFZsDGIqF99yhsOHk6+hBWS4SSyY/XUZulov8xpIS4NcgGvw2wEI7ln92QX
	A6eE7jWAsT8Jxb5kCuUKYVYbLsGMIvT3ljp/JYQn/hWyxim6/fw6RuV7Y6Oy/loeR4YwQQO0MWr
	nqk0T3YRClEIkOkfXQPn4E1cFY97PH+wueIiXVf9XIRmMAssSJp8niKb5st6ht8fJiseXa/k36j
	fDyw3Ce+K3v4ve6EpYtKCbytsu8wXW94ztw==
X-Received: by 2002:a05:600c:1e1c:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-47d4047f3e5mr400615045e9.36.1767601421769;
        Mon, 05 Jan 2026 00:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0AgOv9S8mcPvJ16vNEXPXT2v+oy4k5XMxl4opf9hSfJCRKVIgJxqAgfJFXStW11yISqh4Rw==
X-Received: by 2002:a05:600c:1e1c:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-47d4047f3e5mr400614705e9.36.1767601421303;
        Mon, 05 Jan 2026 00:23:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d33eefesm137323605e9.12.2026.01.05.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:40 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 12/15] virtio_input: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <4c885b4046323f68cf5cadc7fbfb00216b11dd20.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 69DWv9DkjYK4egHSmtSPkkvak5EwRHsOl-z1uGKSvo0_1767601422
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The evts array contains 64 small (8-byte) input events that share
cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
this can trigger warnings about overlapping DMA mappings within
the same cacheline.

Previous patch isolated the array in its own cachelines,
so the warnings are now spurious.

Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
write into these cache lines, suppressing these warnings.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 9f13de1f1d77..74df16677da8 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -30,7 +30,7 @@ static void virtinput_queue_evtbuf(struct virtio_input *vi,
 	struct scatterlist sg[1];
 
 	sg_init_one(sg, evtbuf, sizeof(*evtbuf));
-	virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
+	virtqueue_add_inbuf_cache_clean(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
 }
 
 static void virtinput_recv_events(struct virtqueue *vq)
-- 
MST

