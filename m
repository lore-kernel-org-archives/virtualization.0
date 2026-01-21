Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D53C00A0
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997247; cv=none; b=RaNz0aApuaBvShuApndM+q1XtKk4/qKSMTX25yjgR1N3fuadODX9LbX6hBwA5eB4KZkHAwmLsyRRJG0LJFidT3RDdQ4mR9wVTgZXj5Wn+z4DjssLjyKf8H1keCFkfDBo02qQAr0QD4M4tFz+EyNjnYaIcZl1+wa0/YyEE3sNPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997247; c=relaxed/simple;
	bh=sRJH0LcPiGEMiEKO6ssQ7+EoDIhVQvOD4UKf23OY3vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=giPhwGNsody5dgXUwVHKjSfbyL8XpMQ2AnAs2LE4BBDI4kmR54DndUrrUM49c8LMZi/sjcGO9j5ATEgDjkXEDeAtTMZ0UP6/z/Px/zNohuWdvnJslaWC+XdTzHLm2w9ss1a3aiEDCGG4PaXPz4MNz+AzOLItGxE6z2Iv4oxaP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoZ9WNtn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoZ9WNtn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768997243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dRcVrBqhQujwyY3t8+ooFMd21puB/4S+X1pfO3AW+ug=;
	b=UoZ9WNtnzrZj/fh35Z+uNAFJO3PYsu5hB3DfMitohaFUmAsz7bfgRaROfPwQsoci3rZNsB
	UIwJxkoAR7z3QB/Rpm7X1BLIfBF2kuSUilheNzz62KoakLbL04gFGy2m2dugBVophJ4rXB
	wWjVBjycB8JdYcpQrnprBIrcLMcOXEY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-mGaatNIeNO-ht2R76YhAHA-1; Wed, 21 Jan 2026 07:07:22 -0500
X-MC-Unique: mGaatNIeNO-ht2R76YhAHA-1
X-Mimecast-MFC-AGG-ID: mGaatNIeNO-ht2R76YhAHA_1768997241
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48025e12b5bso38796675e9.2
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 04:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768997241; x=1769602041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRcVrBqhQujwyY3t8+ooFMd21puB/4S+X1pfO3AW+ug=;
        b=uZ+pGBMOG+LPB4TuMhaMi1/wH7M43GLCT9RiX+I+jinaylkEziTvjlx25LMoGvLJ/h
         fonpOB8maLzYSogN5/pvPaucZhcaZQ0V/NzQHrUVz+T4KujXFAMv/6wo79ySYkJ8ZWxQ
         WeDXxQPIRrLshSy1ipEa59fzV1UnQIeuBvOTKrIQ4DIolzrfggEt34XzEtQDhxchWdNa
         xWWH/yq9vqzGOAVhx5Z/+xPkkrIpjggIKbODZtZUU6VNAR/uA1AJOFowe+pwvR+T6Vuk
         YdMBUtrIPj6WEOup7anAS5+1Ii4GtMozPO5EyOURnjCj1P1Yz9guBbiQoZVVUeoTiSKf
         2c0g==
X-Forwarded-Encrypted: i=1; AJvYcCVVRgR0yLKac/Dbwy0JIO4KJPthkKCZMA7e/dsi0FJO8KizVRUavk92bJrizYh7NOlRfKxP0B6nul4LMpUS1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1JuiGkHeY4GAr/sULg4/aZoZ1ndcNSRY+AdIYRjajDlsjAF6t
	9IJ3oP3bj2/4E3iJALAB3MNAIkskCmYkxZqGNtXIz3eqfwVzjLJyzsYgeMsjgDI16qGUmHc61js
	E3keDAsEaY+5X3+ObZ7OW1ACej9NyAgs+a13KQotHEFkNkJejduzEXf8jE5hkj45+Mu+v
X-Gm-Gg: AZuq6aIaIiX6+55SbKfRN9o0vDvZc/mYlTRP9dVDYNsTVEtafgrFc/xPkgVs8UKSe7d
	WIasotDThoMFdx4xeioylF0KXwacG3ZyYRtpEfPx10POaUZQ0Wd6npsTkkDPBssJyRt4Z91hw5+
	V8Pxn1mHaHDqikutxFlZOgtSlDMulkZ+DbjrhuOLduvNIxR+jLpGGUNVB9osAEp10sADz3i9A1t
	84kKfzInkL9WZ3+fwETDGFR7KKkfCWA6glu521UVutgBnSjgBNicFpZEu+6uI3kaDDB4D9bSa5L
	sHWf2xlqLevwEBPN6CfE6qIQUokZt3pTydOwKA9bRSHmskjdxBEGEaXuPC2gZYCd8P2Fn/QFUpe
	mCbV72K6hY+vTFqw=
X-Received: by 2002:a05:600c:3e0e:b0:480:3ad0:6509 with SMTP id 5b1f17b1804b1-4803e7a2da0mr80803035e9.12.1768997240988;
        Wed, 21 Jan 2026 04:07:20 -0800 (PST)
X-Received: by 2002:a05:600c:3e0e:b0:480:3ad0:6509 with SMTP id 5b1f17b1804b1-4803e7a2da0mr80802465e9.12.1768997240572;
        Wed, 21 Jan 2026 04:07:20 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480424a37dasm22002135e9.2.2026.01.21.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 04:07:20 -0800 (PST)
Date: Wed, 21 Jan 2026 13:07:17 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Asias He <asias@redhat.com>, Melbin K Mathew <mlbnkm1@gmail.com>
Subject: Re: [PATCH net v6 1/4] vsock/virtio: fix potential underflow in
 virtio_transport_get_credit()
Message-ID: <aXDBKc0HyN8f-8l7@leonardi-redhat>
References: <20260121093628.9941-1-sgarzare@redhat.com>
 <20260121093628.9941-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260121093628.9941-2-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cmMkRJ_umFahLRDyY4XJ-QWTbOPG8MMI6tVgClexQrQ_1768997241
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 21, 2026 at 10:36:25AM +0100, Stefano Garzarella wrote:
>From: Melbin K Mathew <mlbnkm1@gmail.com>
>
>The credit calculation in virtio_transport_get_credit() uses unsigned
>arithmetic:
>
>  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>
>If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
>are in flight, the subtraction can underflow and produce a large
>positive value, potentially allowing more data to be queued than the
>peer can handle.
>
>Reuse virtio_transport_has_space() which already handles this case and
>add a comment to make it clear why we are doing that.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>[Stefano: use virtio_transport_has_space() instead of duplicating the code]
>[Stefano: tweak the commit message]
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 26b979ad71f0..6175124d63d3 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -28,6 +28,7 @@
>
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout);
>+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
>
> static const struct virtio_transport *
> virtio_transport_get_ops(struct vsock_sock *vsk)
>@@ -499,9 +500,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> 		return 0;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>-	if (ret > credit)
>-		ret = credit;
>+	ret = min_t(u32, credit, virtio_transport_has_space(vvs));
> 	vvs->tx_cnt += ret;
> 	vvs->bytes_unsent += ret;
> 	spin_unlock_bh(&vvs->tx_lock);
>@@ -877,11 +876,14 @@ u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
>
>-static s64 virtio_transport_has_space(struct vsock_sock *vsk)
>+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
> {
>-	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>+	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
>+	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
>+	 * does not underflow.
>+	 */
> 	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>@@ -895,7 +897,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
> 	s64 bytes;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	bytes = virtio_transport_has_space(vsk);
>+	bytes = virtio_transport_has_space(vvs);
> 	spin_unlock_bh(&vvs->tx_lock);
>
> 	return bytes;
>@@ -1492,7 +1494,7 @@ static bool virtio_transport_space_update(struct sock *sk,
> 	spin_lock_bh(&vvs->tx_lock);
> 	vvs->peer_buf_alloc = le32_to_cpu(hdr->buf_alloc);
> 	vvs->peer_fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
>-	space_available = virtio_transport_has_space(vsk);
>+	space_available = virtio_transport_has_space(vvs);
> 	spin_unlock_bh(&vvs->tx_lock);
> 	return space_available;
> }
>-- 2.52.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

