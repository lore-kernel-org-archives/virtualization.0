Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2829B216
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765439155; cv=none; b=iAzyy6n1jF+QdQjf8EfrEw6eGPkmQuNM0EttIjVXFgG2lA5eQKJLCQkfrPHgxQ8IH74zc7XYokj1vdgc1+F+oU4916/oHVXwD2LNZBV+XtZPQsH5WkxUPyx/T5/4B8IgdWUqGYPIdqLOL+RlSK8xTTqijInPXO3aKst014epxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765439155; c=relaxed/simple;
	bh=9mvg3H/c8i6Vw6drMjILUPrnDLVQ4fS3OBd1K9POmt0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sMpq9+3z1Vyk2OxXE+0L1JP9bwZCcaSX0Hbjc8bUQ03+dC9gB/Cy22UjZ/lHCw25nDFxZFgdbLmxOmziru1YkPrlfjJLAVySzY9tax16IsqARpzEePwBx/ifpzxSvQyxMcrOXS9QXD67TvPBLHVfFWJ4dI8/2ExzwsVb59HjCgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/wTYR/r; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/wTYR/r"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso6241585e9.3
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 23:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765439152; x=1766043952; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5PFu97mrs/j5hiZkT9fpEkRD8VCD4PVmKLSzKLxEz0=;
        b=I/wTYR/rr5KfEkI8mLVgQwWvVCMplghkb4zcLh9W7JsZhPjM9PodTIBu5pj970UO6F
         RP+Gvi+1GaNU/PzGX21+TXQlGmXMQ+WgDQeJVhNlgGcvgM+izULtovYg5hWw08c2oOuC
         iIgUVMUAhutFcZCjIqLHbxL9MKmRtDW5MmAJN7fWew1Dg9X8xNNZkmul9viHAJWUngfS
         s8J1AiQfaRp8Kq9ciY2MZ30Wr4CcaUdtk/ETGzTPE1ZpXtxZKSHyDvM1NO02PcZHjoWr
         h7nX4Fwo7qm35GHhTBeDotp6MlvQm1Te1xjRbeugDYZPGZ8ZUSbe7joZfMa14RNo9wSS
         jvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765439152; x=1766043952;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5PFu97mrs/j5hiZkT9fpEkRD8VCD4PVmKLSzKLxEz0=;
        b=bga3Wuz8h41ILII6MfcDLrXOYKTHCM8MvUKZ/IKutFg2SU6ja5O1oRZC6g8CzXwf8R
         gkrf/GnCcAw6D0aY7s1YldBmIkDG2CCsJ6vUNzgAp2bdF/ESRGFK/Dd498dhASwshag1
         SHAqpN055aBC9k/BBo2K1TIk9FtRsla+U7U0+j3N5Uwi79AGLp1e/8xpImGMlKQgiaWy
         QHnSe+20gymSypH+1R7ek87blPfxw1x7/bx0Zd3gzudkNspzd0koJi2xstdUk5C/dIml
         51h4dIVRwvIJYMZBPSKlpMXRKhu1jQGLuyDwGSqbeYySgBVroM7juKvIJftdKgMthuJk
         EabA==
X-Forwarded-Encrypted: i=1; AJvYcCWn2ai5u05OUJ+3OgVjWgijaVGvHms9dHlqynP2Sdw/3VOnmv/urVOps/LY32jiXYGdDqf1QOSc7M7lnohqgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+YbAJsc4KZq8piSvFztWbV/Xjfq4uDOHzwTZAWtSMosqmPqIS
	vOYe3vdkVr0eqAExFkvOY0D8vZx/1RZaTmS0llypbc31l4Cks7tswJF+OwNNTKcJU9g=
X-Gm-Gg: AY/fxX4Dz5V2WhKMDXfyVAQ+6EaE89HtFYL8gJuo5oCv9YFLW7FDEMYQPloQiSI5zAO
	JqLFQNWePQR47EDF3yrBQVYWj1/bpai3kiiwF9/Nxh6oZ/W9KFOhmflzuaOIgsGcrxOmLsPkG5w
	a73IJ93m1I0v9I3Gmu+O23GCULvcweQTWSzJIIXb+iYP3i792ZUDV9r07Yb7l+mt5+H5bPxOL6+
	d1+iws0EQ/F3A0y+QcKGpHMfANCE7GVAoXQk1Q5xKFjR3OWfXpDRMwsynboyvszdX5kTOLaXQVx
	Ln5THaB6xGkBetQaVEovJJdpahI6iHfZbgHcL+xfDb7uPnkCHGPzjNJoeDi1/AeAHHEh1xeM5Rc
	89f8KQfEswx9tKWCOIV1Qb+uyBqQVlq6N1ZycZcFpDa7mVxmKNvG6i3Y2cnUzLz+rExi5tPL+z8
	vd4/MWHuN/QQCHCYVg
X-Google-Smtp-Source: AGHT+IF7TmgbE+Uw5kfOPicBWaMZFFELImJD78GoXEDw+MdgM7iNhig2tJYwraCIhaxT+6NDNvyhbA==
X-Received: by 2002:a05:600c:630e:b0:477:ae31:1311 with SMTP id 5b1f17b1804b1-47a8375a1f6mr46323505e9.13.1765439151697;
        Wed, 10 Dec 2025 23:45:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89f8c145sm19182315e9.14.2025.12.10.23.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:45:51 -0800 (PST)
Date: Thu, 11 Dec 2025 10:45:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] vsock/virtio: Fix error code in
 virtio_transport_recv_listen()
Message-ID: <aTp2q-K4xNwiDQSW@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return a negative error code if the transport doesn't match.  Don't
return success.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 net/vmw_vsock/virtio_transport_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..77fbc6c541bf 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1550,7 +1550,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		release_sock(child);
 		virtio_transport_reset_no_sock(t, skb);
 		sock_put(child);
-		return ret;
+		return ret ?: -EINVAL;
 	}
 
 	if (virtio_transport_space_update(child, skb))
-- 
2.51.0

