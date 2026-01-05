Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D93327C05
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601415; cv=none; b=HT2TfASq4jXhSe5FcePnrzbwIIKqX3JtOPOPZHY0iRE96TtfgVNgHp16TLK1xaBUgxl4uymraHQ7EJBo7rnuAgT2JhR57ARuis8p5nwPM2KBGhr4jr9i76/y3NbrHJ/zeeNd62hk0bus/VgEHMXQdzORwU9tnXsvRJnIn6aGbq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601415; c=relaxed/simple;
	bh=yZFREYe+kB50ig8I4QfoDGYH7fn5mVvqsTw8oxG1/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EzL+FEeIzsE44lBzeXD0m7AyPsry72dnxhR2lVhqiuZPIQ9UXID97fxwUd4S9XX+rRVeQowI8GXgeSHbiVbPMUryPLhZUMnn6rjN3kBaktPkCpJBPc7EMM3IrfXBGsR6fZiLaODG1hlt3MmaVaJF0c4goivXCNzDAUJau7ssX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGXcGOjm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGXcGOjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFAlf3bglsAJtkYzmv+ft5xqaztKYGlID1/+YOBMr0o=;
	b=ZGXcGOjmLeGWkx/FvHO8OG4Ix2VK+O/U+h6lTSg+bUIDJIqrYivt3bKmKOd78wkGT14jKq
	cJ+MU6jtIuvVOCQJ60me7U3zrveQ8w38odAw7T8//11WcJLnkd+M8QMUN1u2LMug7PmCAL
	2SHcXDsZ+3ve3JPQJLxFe+CgDnoUww4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-pnp_grtnPGmuVvWkxLJEzA-1; Mon, 05 Jan 2026 03:23:30 -0500
X-MC-Unique: pnp_grtnPGmuVvWkxLJEzA-1
X-Mimecast-MFC-AGG-ID: pnp_grtnPGmuVvWkxLJEzA_1767601410
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47918084ac1so120298765e9.2
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601409; x=1768206209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFAlf3bglsAJtkYzmv+ft5xqaztKYGlID1/+YOBMr0o=;
        b=TVhQcKedOnTW6/RCTv96AzLH+FHwKjS37Uc5fMWf5/hxAsLAT4qIW2ki66dF767R9k
         z92wCFkVEFNg0KPWiQKWwNrH9fTFlrnbHlZ+YSNT7s3ITA+796igTrcSt+sHSgLt0lzT
         R7leX+Z5zxRFreip+YtbYiI407tEezQVximLbFUJpo95g6IGiMPAQDpvGkz66XpViVOU
         JcOKCYPJTwDSicdmYPrRK5WO5GlBCbONzIlayrp4Ab1xl62dGkssO3WDwsY6Ff7VO94k
         +eB78+NTXRgudvyPKOyKqkprVYxQVXgPh+DUrp+iGjOiUCtsTc85cY4aXhwvPg7GkKLY
         mtHg==
X-Forwarded-Encrypted: i=1; AJvYcCViw9NyacfKhjP6CvJSUmlXkHnSb92VPy9zGBN+dqNrQZ/EGnDTkoCFALcz2ucwdpJ7WNUBoVXQcPWpcTr01g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYZ5glCTXlJIvjfhpBwe5lsSSH4xZNRWwXZ6YzjCJOuBOHBiuM
	ArfUrkYE4vECF0q4oEsv/C5z/teK0vp1QK1cbqyxv6tcVarU89+16Js08LX7HgLCxOBVBD/9M0U
	3Bd1PjQfxyiYaPEKmDiHjbGAZwE9Pl/odaXHi3eMgTzp+WRf87cGhOEqpIPWXcgEle2du
X-Gm-Gg: AY/fxX65TgMQ7iBYR8m3SHDj6Mgz4WCTvjYIadRMezB4Et7EhqU5E98F5AvRXZIwkXX
	0uQqFYWSplPrfS0enhRPdfSIiT0uOqEovsAcEnVJBGW3P7GsQpGNgQcYUAmKfe1VcDP4stcDJVq
	GKcK5hmW9zADdqHikJECjrYQlwUcdzwy2Mepok9gT9zpi9CligmRM9Jawp7kIEGTPnGhJqcPIMK
	GcAMie/5Mh3fsKiXX+63DL/YpoIyxWsKDqHW7qQq19CleeweSkEHNZ/N4ZVQ1iprngDe1NJxkp9
	2JiNSHO+agvMBp916cZ55VhX/OrRSF4JeuTsHk/e4orkH9DdyOueaggRebYFP0z6nFTb1FENTuz
	x1UBfPNhcEhYANpwEa/ftq+e+S5EiT+13Ng==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47d1958a43fmr573308245e9.19.1767601409513;
        Mon, 05 Jan 2026 00:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwNUq77RyeyS0obHX/fGtVMqKrfm8Lk7lx8bL3zrRbRdvbJ0vPOnUhK5sFwtMU1HFVUtXhCA==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47d1958a43fmr573308005e9.19.1767601409047;
        Mon, 05 Jan 2026 00:23:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d145162sm142697615e9.4.2026.01.05.00.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:28 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:25 -0500
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
Subject: [PATCH v2 09/15] virtio_input: fix DMA alignment for evts
Message-ID: <cd328233198a76618809bb5cd9a6ddcaa603a8a1.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: l5Xbts-GcaLdzA-xvp2SGtCPszZjNwWfZutKBzlZdS0_1767601410
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The evts array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent lock and ready fields are written
by the CPU during normal operation. If these share cachelines with evts,
CPU writes can corrupt DMA data.

Add __dma_from_device_group_begin()/end() annotations to ensure evts is
isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index d0728285b6ce..9f13de1f1d77 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
@@ -16,7 +17,9 @@ struct virtio_input {
 	char                       serial[64];
 	char                       phys[64];
 	struct virtqueue           *evt, *sts;
+	__dma_from_device_group_begin();
 	struct virtio_input_event  evts[64];
+	__dma_from_device_group_end();
 	spinlock_t                 lock;
 	bool                       ready;
 };
-- 
MST

