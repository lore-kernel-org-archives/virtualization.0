Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606077;
	b=a2+BJ3qifSKovCw+HE4/7ANaB7O0JqNkIks18pmoyG5ILyxOAfYftL2rpioRqog8y3Om
	 jWQ71Myb2M/qD0Mmti+zM8YSE25OwDSjPTDSAb6GsynDjEVO1/Jf6IOtnJoFKeFbquVxj
	 /KV1jiUgB9TACeMhcNeFS9EgOkf0MaxISPivCr9HJsLuEJlMgPwuCst/kGPWBWGCj19ma
	 K8S+n2L70btNHV+pnfzMWdLBzVN/LeRXT04PU6k9i8UAh4m89yAT+EPKO0qchHpsgGFkn
	 PLwxyODTMj9+KfwxC8oD4pOzY9UniNDvs/H+XXB6IN7SdAiGerfHIkEHJKSNfBEBFQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=6CgTfiZOL+WTnVSNydqbdz+GPzYfHdE/NBvMC5F7pDU=;
	b=wfo4INiEum9o4qNItbsP69nFQasXgXobjRVK95K4YumaAbf1xMCF5YZe3qGtP2PaW87+
	 MyraDwRgTG1Ut/rOQyX0kqWaEklowsZT9QT+zb4EVnc/Lfxx5eicVKJvigYWRoRx2ICzC
	 diebfEQZ71H5QENWh4LSZZkjw9Z9kh722S7R1+iobDcqicVNwRgu2l5P8KlZ3AEE2u78Q
	 WTFBwXO8oAChypELmPY9tZxJV7MBfmaGvCHWKF6XvzbuX6V7PQZk+4HN1osgGeX0hRxWr
	 C5ARd2Q+x3m2SjmdoL+c2JPMOcfByT08GfqFW+1GG8zWtG2hhZv1XHzHA+qDm67vJew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DZ0CkCBg;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC79606A321
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 11:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC79606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DZ0CkCBg
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso53719295e9.3
        for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795606075; x=1796210875; darn=lists.linux.dev;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CgTfiZOL+WTnVSNydqbdz+GPzYfHdE/NBvMC5F7pDU=;
        b=DZ0CkCBgtsRFwatg0SwQQhGzMQi1y0FELHr2gDv6K3vIETNVhLUo38ieX5a6Vg9wXH
         fAhEsS0eyTD/M7ChCY+L5j4I+RPOHttvAemqHfpSfDXxIb2JVkofpnckwwRojfc9ujsF
         k5mtwFNvKouTCCOjA4uzDqaD+13yNPmomXdl911qE7XO7yc0I+609jU45b60+hj3qp45
         0Te5nv1L9YRJ5xHV1xdsRsymqmc7qW3UFijwoQrnKdzB0xMkJhAbLU7+YcKQpblItVhT
         rgVxPnJfjwWHmiZkOKrYyfMegUkjyYc86VmqvYcxr1BCHYU63klJR4Zsw6tv/f3n6JTj
         fP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606075; x=1796210875;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6CgTfiZOL+WTnVSNydqbdz+GPzYfHdE/NBvMC5F7pDU=;
        b=g2RCNUckxe9I6tFxJXjslFHIZo+FPudQRFaWHgtWjVJSLfE24GDlxYKjCf6IYpSJ8k
         O43xHJeaKHO2dJI4jycWjheU9i8rxtAwZoUFsxz6PdtTgk2A0+069hd3BuNFpEel6lvN
         v45Y5TwM54eb7AcOvIp0CaZkzUXsf36vQOMGChwobKPZdsX8lRx9z/LJ36Fxk0omDi49
         4K/p6W/FgnShnUP+skzWK6TYeQAAD1vcvJq/jGQdxSf1wp3NjefEovGHXn4PyfNL21dO
         P+hHrZbZOwcgbE2UnhDKGBAaNuYHPsZ/PxNR3dv5VELsfJwIVrsF70N4JknH9WIQGgy6
         PJaA==
X-Gm-Message-State: APuU4Z8kqa6M4PzUbH83gLMZ5Nn2LJX+/DQ4YBZl8WXwkob/fHqPWgY3
	EuDXv9ef0POE65TbJzdll+gnG2+H8mgF6XO8G+lRDZ+fDmkB9wG9lb4V
X-Gm-Gg: AZFdTZc00y3EVPY0wXeLFjkVRBnwWUS7GWHkP4gNwq1alqHlWLUTvhtsxnHMTYl08V4
	HMpuG5RHtNaDWWHo6rZLa23cw6b3uKwQNzvnLoXETSkwHHLMYI2X8ekWG1zqxdIgcSqLfnN+0qz
	oeRLE/knrNe7Sh6EFYDB1bFjzPWEg228GVs9iLHmN4/2v7hQeJWkqVEphXJmavX3rG30Gcg5LJw
	obJSD/1PN/0x24I4euDhHmcD3ATm/hIccz0ifEE3j045sqXDWeSGfUZeo05VBJdpLC7VuAZl+E/
	1BiXFvRDNlAkv3UHGhnNfjBcYXgzqQGsP7eJL+KcH74BSlG0esHF1V++eXLGf/VotMA45K+q2xJ
	rST5y7DaFNF+cC0um1P5B/Q+FXWPEjxo48fNxUTNEmAYLBp2LQgOTXyOdSgeCD7PobaMOcMz9lB
	zkykPocWj+74vp2v/9mW5CIPZgbXGybNZ5MkR31LeO68NwsttOWJ2yVfQcMal8Mj4X8ZKrowUN3
	qa20XBG5OU5U8SZwX7Y7fF8KK0QDk4w+ARE5K2SMvPquv22fzvuU9xlOIz7mF3x8Ytl1SlrLXnU
	wyeQNjq5EdmRlQz5UD4l7PUkE117rKCIrvha0BVrT9mtIeZoFBA6wjrbKKJVAbQO
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id 5b1f17b1804b1-4bb88809950mr360052035e9.17.1795606074854;
        Wed, 25 Nov 2026 03:27:54 -0800 (PST)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm729734405e9.13.2026.11.25.03.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:27:54 -0800 (PST)
Date: Wed, 25 Nov 2026 13:27:53 +0200
From: Michail Tatas <michail.tatas@gmail.com>
To: amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	fan.jiaming@hotmail.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] virtio_console: Put device on failure
Message-ID: <awbGObIpMjR21JSC@michalis-linux>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If dma_alloc_coherent() fails, the buffer is freed but not the
reference which is acquired before calling dma_alloc_coherent().
Fix by calling put_device in the error path.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/char/virtio_console.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 62eecfa61646..de83a8a61a8f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -451,18 +451,22 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 		/* Increase device refcnt to avoid freeing it */
 		get_device(buf->dev);
 		buf->buf = dma_alloc_coherent(buf->dev, buf_size, &buf->dma, gfp);
+		if (!buf->buf)
+			goto free_buf_and_put_dev;
 	} else {
 		buf->dev = NULL;
 		buf->buf = kmalloc(buf_size, gfp);
+		if (!buf->buf)
+			goto free_buf;
 	}
 
-	if (!buf->buf)
-		goto free_buf;
 	buf->len = 0;
 	buf->offset = 0;
 	buf->size = buf_size;
 	return buf;
 
+free_buf_and_put_dev:
+	put_device(buf->dev);
 free_buf:
 	kfree(buf);
 fail:
-- 
2.43.0

