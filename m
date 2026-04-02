Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB93A4538
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117893; cv=none; b=Jo60vHsn9sTvkf17jz3xJybaLo2yrMYvD/yEt18D27pm4MrGKN8HfogjnOzAuZax5lLFzlBojtOMu/OhrqYKg6BlEX0iBmYVPHl8RR/e7CneI9KyF/lpjFbnTKqlkQaieWR48BlQPvjTaSVZ8LiN6LJXzqfUZqi56z9HiMlxc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117893; c=relaxed/simple;
	bh=7RbGQyRVtd3iDjWPPVgXBB7W0hDbsWzu7x3oEX7DOMs=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=dD4wjM/4bWVBELTx5Fku7hnRUVrDo2muOlNry5KIBFNuGHya0gZJAijavc0RT/E1/C5ldl6j6iF80oSRdVZB7of8z91Js0KvzTtt7/ToE+YyOLO/pWOz4NvUjXT++AWTSgXIwoDreDO1jPsQwBwLV3SijxKKyvfWpFZJWFK+reg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pn98l8Ws; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pn98l8Ws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0i0CiAjjC2o5qhUUVNqS3NUjJfokP7K8K/WQ+tgiCw=;
	b=Pn98l8WsgDJrBBlBEHfMvGQHi3vCY22S3ibszjMxk3GVsYRc3BiKnuoYE+LVBIG9Cfo3qs
	ChH6Io9DPtYgLtKJ08uyUru48bk3It4+mUEsEiiBgBw8y02WEanLPCdkIUPdhrR1gYCpQ1
	hjeFDR0UTmA/hcJzqgyRAmSBx4VGozA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-BW7hwmpwNnW7mSeYy9TynQ-1; Thu, 02 Apr 2026 04:18:07 -0400
X-MC-Unique: BW7hwmpwNnW7mSeYy9TynQ-1
X-Mimecast-MFC-AGG-ID: BW7hwmpwNnW7mSeYy9TynQ_1775117886
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4887d32788bso4267495e9.0
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 01:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117886; x=1775722686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0i0CiAjjC2o5qhUUVNqS3NUjJfokP7K8K/WQ+tgiCw=;
        b=RTM+phsMsY2cdI6IAdIFqolGTRp+wLuec+sqWNwDdzS8GQXO4BJad2iBbgUyoYlANH
         vaSaocbXB99hpbaJEyIRl0HH0MdIEm+iV2C6ILQ89vYEn5MGk1CUSUElN2sXkXzFenEW
         xwYpjEWbVpErRnAi7DeNEJMlErlV58BrZgUiv0p3bJ1O8xTyYi/Lol0zRXZETHTlj7gJ
         bMzQfl+fr8b2hMHsrettK4a03+WZSB0f6dTQ0vqO10AbVFEvXAQBscba8EOmxG6ANp7H
         wpbFl6aX+kdtBhGDFJtVqRrJtMCejzHIcSHk3xuy1SzxIK+s5Qgk2yudBJ2kKLXhemix
         bSpA==
X-Forwarded-Encrypted: i=1; AJvYcCVF3FIG+10q1+Bo5z8qJUXgfL0zUxUfzk/QyNYlWGIQWd0nQVbiL6io22CX/3xU2Ke6O3UJQ3JF/9uTMdE0hw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyR1DEEu7EoyV+4Q/LxFrvwhKrNelfmg5Q1U7pABWYwfo1s/kp
	9oSJol8Ij5Nx3/WhBHCMiOLPLk7aW3A8QFT1pDWq3t3p8BS3zUeeFT3xoohgUBkU153iFiaWOIn
	jokBTzdqpkeb0WqPM0rrFGUGW3dWx6qjuhdI2Z2xrlfWFK7sLvX1sqfDa2o6oXPLDzndU
X-Gm-Gg: ATEYQzwaG9q2WWQV0DZB2x4Crpw73G88yEwemZt20eZ0AK74XTFvsi8yBhQaCgrTRsL
	hyE53zKVARUcwCzqHgku2eaAo1hNBdHYQ/k831LaodYStimL7mB1VrHkP8xKx7mZO56yzK/ZvJ7
	DN9F8w4xHeEhjJBYB9qSwcV2I/QKmg8wT/DoKG18uS6O0VshlouPbR0CDHxdIxUx955Yf6QH/Xy
	jVZyT62jYJNurLGs0pC+y3Kn6/WM7hUSrLfMS2LzvyehD9WpIa64GqorJ1z6wpb9y3OZ3qshvKK
	Mqu/wpKFof0AKBjnftQgTpIKiLjO10S6x35piojtPYHFQPSPUN6jj76hgtwzvSSFawziX4PaRfk
	nirJg98tDHtMWH7QNpAkhrIL7hkvfNLFVspLJ0Y36NJqK1PhdpdI40EQGYLbB
X-Received: by 2002:a05:600c:b99:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-4888b70fbdemr38341105e9.9.1775117886258;
        Thu, 02 Apr 2026 01:18:06 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:485:3f1c:d8a4 with SMTP id 5b1f17b1804b1-4888b70fbdemr38340675e9.9.1775117885762;
        Thu, 02 Apr 2026 01:18:05 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm214476005e9.0.2026.04.02.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:18:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 02 Apr 2026 10:18:01 +0200
Subject: [PATCH net 1/2] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
In-Reply-To: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
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
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pl40-iajA4vP9GYKLcnSMnADl4RVbXfFz6Xs27Zaq8Q_1775117886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e853dfea0a24d3787f7d6eb351dd6c6..4b65bfe5d875111f115e0fc4c6727adb66f34830 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -547,9 +547,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
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

