Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547D199E8C
	for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505718; cv=none; b=RnkvRT4vDygm704X77jC9thULlX5vcVTTBf0NgTT5cK4zf4LS+vRXLEcunrBsPsybk2ixyvfXD4LwUhQIrxLnJN8js6g4zARm3ZQGMgWLjbyDm6A3xJSubs1G04UMjF/9kTAyxijCnB0ZgTbf9mV5Y2IdSbBVVJnfqalQSABJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505718; c=relaxed/simple;
	bh=8VoMAvq3zO3JVqiphTJGZqYC0YcLa4T9AVNVLehqUQQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A/37PYDLYP+U4dWxKn9tKCOaUTEc+XeEyVgw2fIS4Smlkcui+N8umJkw96p7taKivrQXptohSkgQRPtBfYxNJKrkbB8M8uumuB1P8lIrPR8BPdX4Vj7FLeVJYJyTFmjzOpRGJqyakXoIyQVJshmmYOFoONu88hrqwkDJBiODSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com; spf=fail smtp.mailfrom=bluespec.com; dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b=CQNvknXs; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bluespec.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bluespec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bluespec-com.20230601.gappssmtp.com header.i=@bluespec-com.20230601.gappssmtp.com header.b="CQNvknXs"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78f103d9f64so13622585a.0
        for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20230601.gappssmtp.com; s=20230601; t=1714505714; x=1715110514; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rkIPuP+CuWN9tKCMSVVGNkNWpD1n57mvYpOJRL642BE=;
        b=CQNvknXsLacrYly/VWd6hdJaHD5mcOpPQ3eVtHyQsK5ezuaqt6bswJ2TUGb50at3Cj
         42tM3MqN7QWEIqJP7XQzZZ1SitswD5VspAtViQONQVlD4Z6BLzWAmvoT5NbvJyQ4uW+3
         obgeIRb+awwlnYl+9mkLv1RoTmBtibgy5AsAxdZ+Cpi0+S3Cczh2R+hwv+07IMs5oGEJ
         ApEoqeHJBoyPCaQdzdwUImRhu6/A14Yygw58ja9lhXfJfN92G2uc2WJEZbZ1CCUuyPys
         2OqtLcjTc0HIt/ZHwyDSXVcAekILcw8mRpi2S4cUYAf/RNd0UWnuaEgGYawt3lNJKOqt
         TGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714505714; x=1715110514;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkIPuP+CuWN9tKCMSVVGNkNWpD1n57mvYpOJRL642BE=;
        b=pW8ZWlquIZSvlfxN2Tlp4BwrbsN5gvR0aiBlCbHbmxYjhLOdqZ4P6V6QDKFJDJTyFP
         4XHo9UhW03Kgud9GRCW2TIMywX1sX1a7yi5c8zHqbTjRup19z4O6pMi82WKqGmQKddA2
         4YR7od6sZiPaBRwnDrnze49k2JyEikAVHxCn9zSCR5X3YpqVCvyXGLSsGFWy3aSN/xhg
         mB/CgcaXmtx8JF/8rqOY9ZKxL1IXa+F7sv2FccmBLfdH99GjI/0Z0yI2QO2i+ZzWW5YX
         PwgcHHj1GtNH6G/FAaFG70REo/sSZ7IVze0wdmbkyEvlKV1baLhSoy+mu01Tou8LMeZ8
         XCzg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Gd25vyc2F3hZmVYG9D73aIixZYSQ8/mfQ+Ejt3Ia1J1oZiQIjhCwzTz/k1w9vtY2kCoZJ5W1FfFGPpTRolnt9WIoVo3xnGp2Nm6D4wQ=
X-Gm-Message-State: AOJu0YwIecmoIAgwrxKMLmRz3NN6qNEgptYZwcS/+gxlO85Kkc6eopJZ
	zaNLQto4d5/yBNpeeP9/y3vsKXcARJbwb6kWNbfSuBlDQU06slSr8kikbigq
X-Google-Smtp-Source: AGHT+IGBKXU/7tRSFz93Y1xzcjPZPQaoRweolkwmfOyZ1X1BJG2s1+KA1acju3jrin1dLUxC2l0LEA==
X-Received: by 2002:ad4:4ee4:0:b0:69b:6b28:f941 with SMTP id dv4-20020ad44ee4000000b0069b6b28f941mr7236867qvb.20.1714505714112;
        Tue, 30 Apr 2024 12:35:14 -0700 (PDT)
Received: from localhost.localdomain ([102.129.235.205])
        by smtp.gmail.com with ESMTPSA id mg20-20020a056214561400b006a0cf4808dfsm2100850qvb.45.2024.04.30.12.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 12:35:13 -0700 (PDT)
Date: Tue, 30 Apr 2024 15:35:09 -0400
From: Darius Rad <darius@bluespec.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_net: Warn if insufficient queue length for
 transmitting
Message-ID: <ZjFH7Xb5gyTtOpWd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The transmit queue is stopped when the number of free queue entries is less
than 2+MAX_SKB_FRAGS, in start_xmit().  If the queue length (QUEUE_NUM_MAX)
is less than then this, transmission will immediately trigger a netdev
watchdog timeout.  Report this condition earlier and more directly.

Signed-off-by: Darius Rad <darius@bluespec.com>
---
 drivers/net/virtio_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 115c3c5414f2..72ee8473b61c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4917,6 +4917,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 			set_bit(guest_offloads[i], &vi->guest_offloads);
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	if (virtqueue_get_vring_size(vi->sq->vq) < 2 + MAX_SKB_FRAGS)
+		netdev_warn_once(dev, "not enough queue entries, expect xmit timeout\n");
+
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
-- 
2.39.2

