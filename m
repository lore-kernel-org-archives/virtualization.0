Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086013AA27
	for <virtualization@lists.linux.dev>; Wed,  2 Apr 2025 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743572619; cv=none; b=hPkWXv1FonzKePRAY/V4OqGTM7uJhaJUJ+2e2JtUqwtS9hknpQNwX5kIw/ephoPTmZx56fFRzl8Bs8DGaD9H2mZXwFj4Bec+PaFMWfutGOGZS5rswCeOdJyGJO8Xe6xX1wsWR36syug0FDPfSFR4HqkYDAQuFTnHkkmis+qCFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743572619; c=relaxed/simple;
	bh=4YodOXIyddgrUGXCDpWh7pKVlP0DqqsIUu4EW1rqHZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Njtdr4wO6l2X5cIMrR1kBjL544GlH2VfxUQQBjiuui88RaJmnrlPAVAsc0sn0SL6AtAOAdX64dYUPfKBHcljXC28cinuPT70ER05z01ELncn2LHB5fqkbKvWmZCaMygnjwaWh6DAnCHxeELLutcBFrpqAkbKFTJEfsgRdD+y/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1F9eQQY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1F9eQQY"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301493f45aeso10377839a91.1
        for <virtualization@lists.linux.dev>; Tue, 01 Apr 2025 22:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743572617; x=1744177417; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7oMFt6rTiybYoRdpooKvYV5UYutJybr7cfusGu3htIA=;
        b=B1F9eQQYcMUQJOI3EGkfHJuNQpVDuETLwmMQtzdzz+fskuobUeuftD2S6jlJlSWwuX
         /KdIEVeZ0Fn+OHVrxIyBDdQknKNw3ETZ05BrOFgh9ETFC4jfzX29ymv6VT3mSBlajnCl
         pnCmlwvRCCG/EnAX+f7o9rAbUfkxGTBl7VpWyzZzM4YBkgqkBA849Q2riScgao8l5vuG
         2TeWbFtSmUw0CFAdyvqSGbKf7WMjHq7jdouZ2NwIHwM/whr9MmPFaYMPNnkbRtep99Ye
         9aQY32TVNrS5KksCu/+zqUpiDI+bQRdpaWHzQoUxGskeZ+ahUf+lV4hOTb80kZFCEBZL
         u2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743572617; x=1744177417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oMFt6rTiybYoRdpooKvYV5UYutJybr7cfusGu3htIA=;
        b=vcVgLsozFlUxN6lVANql22mAhkeLBN2nJulTP58LnkhDPjJfgK9vbnqCoE3LPundqR
         Ieid3Y4Yeh79UgPiAEQkn/uvkw7kVKiDmjM14s+1jVVmh/IV4mLVt0TjrREpI6iL3mow
         vbo2c1N0lc5pVcQ/k3ZGsUMTBjejwyaw/xDyNi+j7HL0qCDvgTqFF5en57ib2jPpxY/E
         4YdC7ojf0XYbWY1b/iE91rEzJtm2e9xIhulUKfWv6TtgX86I69FxKoKjk9COwAA4MTas
         cjiFH+8rvgtWkhSpRaiLS5aRhpXeV4K7NEcPzERhP4MN3uiJgpbt0/XAu+wD9lJeZJkw
         qi6A==
X-Gm-Message-State: AOJu0Yz47JLDOkUt/kKNamcEKICbxlIUApZAdSaezSZcvjybp4ZpeR2C
	PsCJYy7bR0K/N4HJlvXcTcSlnfw0QOVFVoq0ZTzD2DPpBqtVdvTsBOrwvinn
X-Gm-Gg: ASbGncvZSLbowUUi7a0qbhKMHr+8z/7oYX8wEgHHS1haUFd8c2X7IXNVxcpLwc20AQo
	cIqWk63JrJrz2F490bdYfWnoO4lxeyp/bUFy8/mEWLbqMmzSNdnLdyjhDrmv55hIpTLULha2zih
	uFR5duh8lx8yPi+hZpmcE/6zvFPMQiJAmCzOnagUz5zTszMK7YyTajne9jAXRsW0IZnMlFX9ved
	IecwiQSTbh+aafKCBPLoM703nKfyiWLaN1YIZIcNO+2K+Adxebrz+3re5gYTm59s8nH487oqjKT
	HgllBCYu95JPT3GKe6XIokwBBHCghjQVWh2HPO6SAvv5OP9VJi1XDXxagi0K
X-Google-Smtp-Source: AGHT+IEic+6AY+ZdBrLSKJCMvjDVGOhMYUP1QxYWYvLdMiiVD00LmEfJ4lEnY8i5M2nghj2SBWMTbA==
X-Received: by 2002:a17:90b:5210:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-30531f93127mr25734500a91.10.1743572616792;
        Tue, 01 Apr 2025 22:43:36 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4e:bd30:194b:b252:cf33:1fe5])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3056f83c93asm720529a91.14.2025.04.01.22.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 22:43:36 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH] virtio-net: disable delayed refill when setting up xdp
Date: Wed,  2 Apr 2025 12:42:10 +0700
Message-ID: <20250402054210.67623-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up XDP for a running interface, we call napi_disable() on
the receive queue's napi. In delayed refill_work, it also calls
napi_disable() on the receive queue's napi. This can leads to deadlock
when napi_disable() is called on an already disabled napi. This commit
fixes this by disabling future and cancelling all inflight delayed
refill works before calling napi_disabled() in virtnet_xdp_set.

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e4617216a4b..33406d59efe2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	if (!prog && !old_prog)
 		return 0;
 
+	/*
+	 * Make sure refill_work does not run concurrently to
+	 * avoid napi_disable race which leads to deadlock.
+	 */
+	if (netif_running(dev)) {
+		disable_delayed_refill(vi);
+		cancel_delayed_work_sync(&vi->refill);
+	}
+
 	if (prog)
 		bpf_prog_add(prog, vi->max_queue_pairs - 1);
 
@@ -6004,6 +6013,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
 	}
+	if (netif_running(dev))
+		enable_delayed_refill(vi);
 
 	return 0;
 
@@ -6019,6 +6030,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			virtnet_napi_enable(&vi->rq[i]);
 			virtnet_napi_tx_enable(&vi->sq[i]);
 		}
+		enable_delayed_refill(vi);
 	}
 	if (prog)
 		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
-- 
2.43.0

