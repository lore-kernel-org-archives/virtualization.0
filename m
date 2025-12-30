Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318A2E3AF1
	for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089780; cv=none; b=r2CXjs/YTUiWC0SXgLnJKQkOaEEOATO4WIuFQrlx3diVXPFh/QYiBA9okj1vQlNVAAEAg0qDCVdNKLjVYx/MiH+dGnpm/p9iKbzRfpsYRjqo2KVRHljEYqTSe9Jz45PWAIbRe/VTuLNQF9kNrqrXmLP929D42/ByQa9VzKXwKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089780; c=relaxed/simple;
	bh=d79M2iBKtK7/e3UWQBP6Z7XMZcGHJdPNMKAqQ6Eyk7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ficlcgWx3F3aMU1rVeHMZazieMQ8LZuR63ru2uBh0nDZSk0JVFe7h20j36AEhYtW4s/LV248y56cwZzxxHPcinAzMhkVA7yyt818FMF9m/PY/GGnmn9dm9btsglrzay4Q+FdHkX3Taui0WJD7XcRp9jXwqoHRBP0S7ij0YLSmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hx27djo6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hx27djo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awHY3MD6YI7UgDTD6QKfkNuaN+VrZkEZlRiSgXqWnPs=;
	b=Hx27djo6x77GeQQ1lgTSKc/rpiU1WdokGmJc/sZ5Z9orN3COn1wNf3Tzt0v86p+rfoMn0N
	CJDZRinML9rxytkRt0M/BsAcdQFYr5z95bCdTEFMaieVJ5oTRPJOGYcvDzUKKM+vqA40M8
	uAHiqfhGbM+tEVcYbRorSWHsEV56cf4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-uyO9hVAxMC6_bjyFvO_a3w-1; Tue, 30 Dec 2025 05:16:16 -0500
X-MC-Unique: uyO9hVAxMC6_bjyFvO_a3w-1
X-Mimecast-MFC-AGG-ID: uyO9hVAxMC6_bjyFvO_a3w_1767089775
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477771366cbso73693275e9.0
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 02:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089775; x=1767694575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awHY3MD6YI7UgDTD6QKfkNuaN+VrZkEZlRiSgXqWnPs=;
        b=B/3x4SPIPJ6Jvbmz10uG8/zPvtA9Kd7PYrhFTZINSN6EPwIA1wmWWb0Qpp+AE88OVO
         RDBv9PPdD+PZhAUBT5ftZ49LpYd6Yr+jRFCMK8FbcTLgl49crPZHNx2H2a4i5s2BDZxa
         euEseKdu2G+EHeThHM0JVJyUzumUkdb7uFCBPDYqGU5azZHN8AJ7yzc8fyEGlcJ2KiT5
         jyi1X3PIHeBGES2pujoU1YD3//dIDzDMdfey8qprmgDIpjy7u/wBmgxdcKpQdpvBixfy
         V4sCn+5sexc1dx9tm34OSkyjpjTeFXSoZ+Hk62SA9nTPQtBH7oOCZJI2GiV0arC/69g6
         +Zrw==
X-Forwarded-Encrypted: i=1; AJvYcCUcUMWV+8uzFL6QC3Zi8POn6ihEXhJFl7hF1CzO04uZJo2e3naSrnvV08MVSMf5Npv2eJvSZZXVDM+yFBchow==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF9jL534DdRhVCxLMOfbn358JgaIqk3LVZgvLbmDVI8YmGlwX+
	PHzGWVFUzsj8hOuttkrTz9R1k6UNevHfjA7puB3zfpPtqvPUg3Y8fGhycPEbQu1A1AQeI6tQObO
	q6EFMZeqkyuMOFw5+oRNWmiVx6UTMj9jOU5hPVNffNy/tp0gY0gCZt73IXju7dSCiwlC7
X-Gm-Gg: AY/fxX4XZxtcRD2g2BFYzJJQUc2teO+nfDaXmbDnXr6vS3CT4FUKrna3UE9W0wO9Qp6
	k8BbUyd8+x9MRp7fw6iUxxIas4sO7RSDhZ7PnbUpSEQ/jTRJziyiMqgG7iYyJTzqkCvgsi9C3j9
	nxQGoXWtY2BWJi7guNruUWYFS0I4Wcq1/0t9CQI3+2r3Wx0BSqu+EhSTs6vRMJXzoAy8qHt9Elg
	H4mIx3ZEcXwroVVlc0sgD6gL/oCGUqqUGzkwsaYMq4A9wbB3E7nF2tLIgSiFoIhxtjOS9CZ3H9E
	LO+9v6KqWJLlihoIjZGs47o9Jlw1s/iL2oiuyxpqXsyun+uBDJ9b3h++e9lVS//4fKLZimgjUey
	k99LtXcMhyHqAtMGRKAoFADX8mjzw1NNUOA==
X-Received: by 2002:a05:600c:500d:b0:47d:576d:8140 with SMTP id 5b1f17b1804b1-47d5b261006mr54433905e9.24.1767089774865;
        Tue, 30 Dec 2025 02:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhdLHPqUgLnPyVKN6hwhRQFuXWAPZjO+w56XwRJ3KNAI+UkHXfY0sXelHGWgys0dAYrWVbAg==
X-Received: by 2002:a05:600c:500d:b0:47d:576d:8140 with SMTP id 5b1f17b1804b1-47d5b261006mr54433635e9.24.1767089774436;
        Tue, 30 Dec 2025 02:16:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272eaf8sm630015255e9.5.2025.12.30.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:14 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:11 -0500
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
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 08/13] vsock/virtio: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <34e5e1af186fc92ab4ea6cf6c9f5550a40c9567d.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LWEWfEdOhRBNG4ONHxoJcBLtlsCHvXHHCZ1RvoiUQa8_1767089775
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The event_list array contains 8 small (4-byte) events that share
cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
this can trigger warnings about overlapping DMA mappings within
the same cacheline.

The previous patch isolated event_list in its own cache lines
so the warnings are spurious.

Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
write into these fields, suppressing the warnings.

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 76099f7dc040..f1589db5d190 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -393,7 +393,7 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
 
 	sg_init_one(&sg, event, sizeof(*event));
 
-	return virtqueue_add_inbuf(vq, &sg, 1, event, GFP_KERNEL);
+	return virtqueue_add_inbuf_cache_clean(vq, &sg, 1, event, GFP_KERNEL);
 }
 
 /* event_lock must be held */
-- 
MST

