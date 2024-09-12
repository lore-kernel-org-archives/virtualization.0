Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670143D0C5
	for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153359; cv=none; b=prOqz882xVT4ps/9eeBEVUIBX8Dl8aVJ5Pdi7K5rfP9TiVh9hmcGYK7Wts/jyrSLlUHubtkESz0XTqoqzFbb0dRcZdoQp+ZL1NSqBDEk5Gbg8Q8lJbeOJ3dZTznTVRX9rOmC+H5o9Ij7RQ/22ZoBCM6aipQLZWRQMhOzKPSX49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153359; c=relaxed/simple;
	bh=pCwUfPfW+tZr/wgmn6kXYp5e5XgcklV0FfGI1wa+ig4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hWRKy8vZZd9t5nez2HHDwD9lsof7sOV5nsMWM+u23c8QfTIsAG+dvFhHzo/Yx7wV5/TmVwqmK9vDloB90f/N1taZ794r7e2FVN00CuY+VPCHGp1QiX7hVLp5IC4RUglKO4+IG33s0FycfMsp8zcHFPjAgRU1Bw2KoisKv19d2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7FbTjfV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7FbTjfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726153356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=POUJMdgzbyeLPMy6EHJDd+KgN1IsD2zQwLwCfPdtios=;
	b=U7FbTjfV0BuQj7FZD2/XKVl9eR+saUhHV7qQzSPGhplf9FEDPPjc4bJDiukvSwzb9WG10m
	8jfJRubaWWQDZvz2UomqDzQs1fOhCW0gBBaeugOHoHqLerB1xXGi+Uw78uR4Df6ql5kNsX
	BxnCrmPeIJ2B896cHu9xJlCEJiozcjY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-7KSyonF5OeyA6fdZW8Iu_A-1; Thu, 12 Sep 2024 11:02:34 -0400
X-MC-Unique: 7KSyonF5OeyA6fdZW8Iu_A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c54e188dso1158745f8f.1
        for <virtualization@lists.linux.dev>; Thu, 12 Sep 2024 08:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153351; x=1726758151;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POUJMdgzbyeLPMy6EHJDd+KgN1IsD2zQwLwCfPdtios=;
        b=Jn5xFtsCubW/8Z1Twk9sIs9IQ5dBc5U3ziF45QCtNtB2auzvd4m4TGIeApiPFwa25s
         K3G4o1xT8iPIfRfac4OFo0TKnmhoGu4YdX98e1RSkPN+iBXlr7qm/yIFglYqvHiJAP7c
         xCbc2e+M2lpiLYKBE+DgaoD24y1IwSP7wMvgJbpGeN9GDnH/edpM95vI0Ncxg66+epMb
         qh+VYkD7PdXTfGgN42VkMwSH/1R9fpUkF+jxl4wFkKE1otbWPHPnPnVvCGkFbyzeBUY2
         cpEnnv9DzsfZWo3dS1cfSS8xwTbyI97umStdxPEw5OnaFl0qIjgv9Qt/3vLQfG+g97c1
         xKbg==
X-Forwarded-Encrypted: i=1; AJvYcCWPdBckYDzsR1SpT5QPNXZJRA5bZaXVRRri9NFXeCNDUh2abxQIUN1nrr1SELf2qy4dJHrF9FTmCmWj05Nseg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1ffbGfO9HpJW+ksDWwOAYIoqRegDgZ9fEVcJHiDQdL9kVy1AS
	VMyYtF21o08sotBz2P2zhwkKL8zKGh97HXQfVGNVrDUf93Bi0zQbYNArHAImQHuEjx+/TEmI4ks
	IgoppYlUgR1eLcacFCTQK3dzjapVCwwUNZbdGpVcZf8fP2xooKz1XC9bY+Iy9C7c/ogz5TEdp
X-Received: by 2002:a5d:6a87:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-378a8a7ab0bmr6692325f8f.19.1726153351513;
        Thu, 12 Sep 2024 08:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQQPkAEY8RQQc+BFfq+NtbIjOBDj/FEKUqoUUMKlrrFseEWM6ZWT2N6n6+DXYJlT4UgCKLng==
X-Received: by 2002:a5d:6a87:0:b0:367:8e57:8 with SMTP id ffacd0b85a97d-378a8a7ab0bmr6692239f8f.19.1726153350627;
        Thu, 12 Sep 2024 08:02:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:45a6:a4e6:75a4:a286:2745])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cbbbf8a4csm108364955e9.47.2024.09.12.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:02:30 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:02:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Marco Elver <elver@google.com>,
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2] virtio_ring: tag event_triggered as racy for KCSAN
Message-ID: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Setting event_triggered from the interrupt handler
is fundamentally racy. There are races of 2 types:
1. vq processing can read false value while interrupt
   triggered and set it to true.
   result will be a bit of extra work when disabling cbs, no big deal.

1. vq processing can set false value then interrupt
   immediately sets true value
   since interrupt then triggers a callback which will
   process buffers, this is also not an issue.

However, looks like KCSAN can not figure all this out, and warns about
the race between the write and the read.  Tag the access data_racy for
now.  We should probably look at ways to make this more
straight-forwardly correct.

Cc: Marco Elver <elver@google.com>
Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..98374ed7c577 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2588,7 +2588,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 
 	/* Just a hint for performance: so it's ok that this can be racy! */
 	if (vq->event)
-		vq->event_triggered = true;
+		data_race(vq->event_triggered = true);
 
 	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
 	if (vq->vq.callback)
-- 
MST

