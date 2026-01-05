Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02B329E64
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601422; cv=none; b=QvgpEN9sqe+pGqYDoH99R2+/3KFkIq2zkM0j4vMrLa+NguBRmVOIsRKYsTknLWq1FlIaCAWg7Uh5eTmY5EVibVFILNA0VJW9THesMHobiZuoN6UUkR+ZbxJ0F6J/GOI8gkZaxeIR2MBqHN73dffvkL/Yb7D0AY9dd90RxzAirAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601422; c=relaxed/simple;
	bh=HzYnyY7SZLB21Zw4R22hNRsG3Q5nx5zt5Jv7qf1jNBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eaKf428Qjsh0O8nr845rIKsn0pyyFWzjFqFN1jnbyTAhGBhRrQ0I+JJ3hySDcTW7k4h1c3xiwrOVeohHeO8t/UPelx4bp4IlY03z0RmJqUkJxh97blG8PiOPxyvJ6/c+9Y13yJcOnKFwCrrYfNweMwqa+JHN9rVlFA4BzCcp7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AG5sQUCG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG5sQUCG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/8txVkwqMRJjWWbc/atl6vQI7/U+u3Ckdz87v1ZTBF4=;
	b=AG5sQUCG7U5QWAr+Q46BSKAKSwAgf3KFF2ZYHdoWdSv3pwkK9HGoNnO23TLNBOBkHs+9rJ
	OQDsPzlL/G9CjYRWQnGflJ0CyuD1yz6mR9wUCiY4OxUXwaR551T0+hnW9m26yCR9PCP3hE
	79FQS+nw7tAx2MZ8+AMDdRX/qNkgYTo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-C9JxNodYPEeIyCerh3EXtg-1; Mon, 05 Jan 2026 03:23:38 -0500
X-MC-Unique: C9JxNodYPEeIyCerh3EXtg-1
X-Mimecast-MFC-AGG-ID: C9JxNodYPEeIyCerh3EXtg_1767601418
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so117043645e9.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601417; x=1768206217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8txVkwqMRJjWWbc/atl6vQI7/U+u3Ckdz87v1ZTBF4=;
        b=fde1y57QtaQhIgWqyBXp1tvXHZdKZdJce2ncxciosUO8sKgUgiAvBc5Fj73+FkHC6N
         l3VUysGn/aZpTvBd1QgoEKt8NjM3mToDw/fg5ppq2n7L12jxAy78jiFSGcizCEF7k9cS
         Cn/e9gVx3/Ad4g/7+z3bTdOl2uj12bOosUZ0elR842L90WHuj8GdhOfqUk/0hcwycAc4
         erxjgYIKFB5d1rOGzsdWEh3FK0dg4L1AV/OIfbTkSi8m/XkKEBE8AEwkEzO6KY4dQW7s
         8KyQUK85yv4f8lQvqlwUwF+AXPw0IWKa6SOW39SFI35edIwRYfWQJGbnwviPTl1jC5Re
         giBA==
X-Forwarded-Encrypted: i=1; AJvYcCW6oUjSD2uBiZGP9JztuUpIGZFEIyj+ICvJo8mIUeEO5ygAS72NHtLr0iExS/9is+pW/qAvbEyATe3XtOL1aQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkc4AREx63o/sWjw72l1dS5dO+7bF3OIuVpSKL1gLtzRqjYHFs
	VTPn/51nbIn88uqlENZT5vpPez7UDaXE9hWXCRI5hhQnjDVs7jblECfcwqT9h0njXVvxoWJZVBd
	g167Vj3VdTSxvZZRe2jUkux6cJ2e8XcyCV+ePRvQe/eWwBK9NuW43URDX34IRlSrOo0lf
X-Gm-Gg: AY/fxX7UtpiU01OHq3mj2nb6cNGhez4VxiGeciUk4y67bqs1H4spuRYuHXA0T34N6BD
	m7FOsH6ntwW2xLNt1Hsqjzx2oD15wa8FBsZfFoDLckAW9bsBDehZLM1wQz5qBbwCdqro63HdZ7a
	ujQ2cD3K9k434SD6Ybxe4ms6+vR2EN6iJXnlXmvDAU1cJpZ7pxFGuei50IN6D//MAWKWfObe1Uy
	HVzC/A3VUbUgw1tr4Hq00ptC/4n98fwcZT+wkekBNjnKZa6nTP8iAzG7AxAp+j0BNh750ozLwDW
	kOl6SM/FZNAbInowJNWWkFM4oGOrWjsDS/jig/QhfNHq689POps8VavuIXH70Zv72y7HEE5FnPO
	nBBg9g4BOuQHKluWF7rrIJhD0mWUJ3YDjkw==
X-Received: by 2002:a05:600c:858e:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47d1c629902mr472043375e9.4.1767601417345;
        Mon, 05 Jan 2026 00:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVSX2iBXTT4S7tXy0ZYHsUHRdZMVGE7PsYbGyf8OKqSDfiJqG7TGaTn+6DDGk03BIi3LI2pg==
X-Received: by 2002:a05:600c:858e:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47d1c629902mr472043065e9.4.1767601416846;
        Mon, 05 Jan 2026 00:23:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6be6b202sm54210025e9.6.2026.01.05.00.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:36 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:33 -0500
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
Subject: [PATCH v2 11/15] virtio-rng: fix DMA alignment for data buffer
Message-ID: <157a63b6324d1f1307ddd4faa3b62a8b90a79423.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: dmBpH_RKOsatGeMuK9-yFAyiKWjQXEVw45vjdaoeM8U_1767601418
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The data buffer in struct virtrng_info is used for DMA_FROM_DEVICE via
virtqueue_add_inbuf() and shares cachelines with the adjacent
CPU-written fields (data_avail, data_idx).

The device writing to the DMA buffer and the CPU writing to adjacent
fields could corrupt each other's data on non-cache-coherent platforms.

Add __dma_from_device_group_begin()/end() annotations to place these
in distinct cache lines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index dd998f4fe4f2..eb80a031c7be 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_rng.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -28,11 +29,13 @@ struct virtrng_info {
 	unsigned int data_avail;
 	unsigned int data_idx;
 	/* minimal size returned by rng_buffer_size() */
+	__dma_from_device_group_begin();
 #if SMP_CACHE_BYTES < 32
 	u8 data[32];
 #else
 	u8 data[SMP_CACHE_BYTES];
 #endif
+	__dma_from_device_group_end();
 };
 
 static void random_recv_done(struct virtqueue *vq)
-- 
MST

