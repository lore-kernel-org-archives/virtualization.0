Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E273D88F6
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265787; cv=none; b=hrUx5Stb3YUkhc+WV8T5p5IbUNwmjTU5RaJ/dBy4zy2hLN/uVNU0hELVL4YF52z0Iy01xxMw8jk/8K9fG6jVBmVmdnBlHTKuK1XFmbt1dhhQ6lLiPW8AlK3SfQGjAU9VGclvkdrL26uBPfBGaMeL0dl8PvKSI4O9XL3WGEf40lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265787; c=relaxed/simple;
	bh=8KxSLwY587LR57aGsCLpqgDw1kJidOt4vFYe6TGecyU=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=V/WOaivyNV4gCNejitwOowdmbsgY0sNfeGMQzdM2GK/vqKvc3qrI0qS0LXezlUWci1k4C2AQ4Ez8PtYs3Z4x1TuAts9ReDMNgIJhXuhFZUK+GLrxWqPGTmbOS9wlaYAgncSP+Nr35eqU2S6KyMDN9XIOB6QXlrmy2cCEzF4mqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3i75YCJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3i75YCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
	b=B3i75YCJCypjiEog0x0BthTUZZv2+T93KXOogawOe20DG5nZ4GavjoEJjWtFlVWNDr9Pim
	+35e9tz4saHZkc8b/fIzeRlaONKRLEO7DW2DZKtzp2Mda9edhNwB1uX8F816mdarD4ylOw
	JpID/ECRkjeuJJqaAjfTWRxvAutaduY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-kFmyA0tcN92uXK7zvyHStQ-1; Wed, 15 Apr 2026 11:09:43 -0400
X-MC-Unique: kFmyA0tcN92uXK7zvyHStQ-1
X-Mimecast-MFC-AGG-ID: kFmyA0tcN92uXK7zvyHStQ_1776265782
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d721a4858so2659940f8f.1
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 08:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265782; x=1776870582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=BP/+H1AFZBFWDALt7c56VBL2aosRIwuh1XhHsADlVOmwrdHdiEnvYGCjXBbmRxaAtt
         l7GRSRD30OMdtOd/x423dRyNpNghY3O322SnlQSO8etBSX9ygUREx66cI7i3zWF3lLRC
         ZOcMK3iJOtJ1OZ8NU7XJP1ev9l7WthM5kA3rvs5fDTKnAYR+/YZrMwGi014owyghZZ3k
         mb3oTTA/HuPC8v8uJFWsb6Jr+cqsOC/Uo/fsdNW1nWhZI7MBDa6dkfHVJBpVirecXVYH
         Y89pWYVqJbIw70MF1L6d662GJQsTY/Bj3u7ecMXKl/JcjYCG+epIuBlQ4S9l4R3/Pt0I
         SUKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+083xTE2GNsEcK3QzafyaBLWEqYx6ieteZ0SDKLIW4M5kFm5UyMC585alxb0AY5UXulvbxdRGQR36QFIGLug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAC9iz1/GOWmAO8/Iw76K3AodKLlg05JCl9BgVd1iQwbmogL/O
	hnA6TFvJaqmSpORCcje5R0LQHwoSA+RE/YNYQ3P8H+nx0LR1VYNjuc576Pq1JqoA8i2u+NN5bye
	YEwiclqtICqprcj5WxtMrJHm13t9sYmFr4nXhjBJQPwBlFKdwSvpnwIs8VhtDDSHeBy3A
X-Gm-Gg: AeBDietmPhObm7XmaOihm6+zflrdBAqtJnJu8qy4RhRe3LF8Rr0LBhkx1bFSmm1YBPi
	GlGDRZzl49VEFvtEMIsSP9U+VerqUC/enPOTH/53xChQc2CJ18v2XvhSCmXpg1qBPLVmy51yLDI
	tBToUQ7MeNl3G7z4r3pg1dTBZQWEte3eqgkg/u4hJ7afV8Tjaq70Jt+zuVpKOke/Tg0ZeH85ZMn
	mggaRHSKuBD/foSm99m7voDzqGq2ElcqBAsc9ST6loNKozjlSgsmhQVzMruZUhx/7erIE+Tl14S
	NbTi4+VmELU85fhzzqjmUnY/Bn9gYes4RYrKpysuO1BixJ2P7rgbdwgsA6Pewn+UwiQGGNhO1h6
	d4y1YjmCwIEBqJ07JCvK3/zyks/iI16XiLCxNRscg8FAItYeVAYC9Sd+nSYvP
X-Received: by 2002:a5d:64c4:0:b0:43d:30ea:9383 with SMTP id ffacd0b85a97d-43d64259b42mr30842195f8f.8.1776265781769;
        Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
X-Received: by 2002:a5d:64c4:0:b0:43d:30ea:9383 with SMTP id ffacd0b85a97d-43d64259b42mr30842115f8f.8.1776265781194;
        Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:40 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 15 Apr 2026 17:09:28 +0200
Subject: [PATCH net v4 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260415-fix_peek-v4-1-8207e872759e@redhat.com>
References: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
In-Reply-To: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ohGusnz3QjRgg5SG2GyzFy9Q1Q3kO9nrX1gqtKAuMms_1776265782
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in
a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a152a9e208d0..b5015ab2ee1e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -545,9 +545,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 	skb_queue_walk(&vvs->rx_queue, skb) {
 		size_t bytes;
 
-		bytes = len - total;
-		if (bytes > skb->len)
-			bytes = skb->len;
+		bytes = min_t(size_t, len - total,
+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
 
 		spin_unlock_bh(&vvs->rx_lock);
 

-- 
2.53.0

