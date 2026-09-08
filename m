Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB291380FDE
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 05:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845993; cv=none; b=a+7ZWVCWcYoJGfE/Vw8sqmwr7ubsdVzWsrsAJU6LO2+fnbYT1bnYG3GQXpHAp2EhxTD9+/yqOLSBb8sSIuS+XlhiLNPbC1l2ZnW65YFKXsaUBI8vP1/deTXjVAx1aGwqObe/ivcF2A0XRnY7/dOr/nISkCD/I/kPuIA3UsROJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845993; c=relaxed/simple;
	bh=+wdB7PxXXtKvNQ35EUFAY1t6ihDReA2lJ+JGlRl8HqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PP2e2imLQAsuSoyj0VSPO1l7TdAjMghxJ9FS/JjRPCj1NGhJhiuL1OXmCOdeDDiw7p19eTrlGzTYpcn/dJbJWtyEE5tyFLmnpLEdiBTHvb5lbRjjXtFZs8MaKFVHJwK+Rcst2Ny60zaDaLxVU7kUFdpPNdC4a8ycRaqs5LOoU88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIzhPfAZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIzhPfAZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso40270695e9.3
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845986; x=1789450786; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPvq113vaLkp19diB9PBTYq+aXRuG2muF34cABuckMo=;
        b=fIzhPfAZXtFPf+bDXQxLOcuIbylQ3SsLN9uTm5ATp0PS7Rx0wOQXC05JCuJbAeunKv
         jemyUAfuiTNoK1lppRzoQaa0NlNd6ltwPzGSg5CxSZ08JPYO4u0R5gl/bgjIRxxF5iNT
         k1drvIaua660ZQIZiTBK82Yo3utD+T5SsyDXD3urPXp3gbKiFbK2BPCaH769hZlW6Z/4
         Y1fVisrKGpV22V0jJoywj+Om+cD3BF0phlJeZIITxVtRyYlw4Z6i2QsfzkLbqrv+Lvn7
         C8eULBArkg0YXfSmomvc38Un38K1ztkeCOvDoBWvhs4bibLYQpvki083GFXxpmYcSRp2
         JksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845986; x=1789450786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iPvq113vaLkp19diB9PBTYq+aXRuG2muF34cABuckMo=;
        b=b01HASUlCPKTVqnI1Ff8bgMfrd6T3k5TFkDEK9KUP0mLoJZM/j4ItH699LcYhjjP0R
         OAalGbOMAntCsZZ1gAeai56whNFo7Wixj5zl420abVIjHeDY2IVc+SDJRMBRInKxtQhf
         TsQQutA/7TCGUHOM4/xqjgcKzhuf2OFnH+mzgXbsaNWQ6v+nyS66ieeI/5R4d+N4nJ68
         gUKA1Z/jjxWOckhvnfKIBgUjumktl4o5Ih0FNyRWW2x9QfujiZl9IUNO5j2brx77yEYG
         C3qImGLPYvb0KHLzrt6bdFzsG6mBo9a2hOZTM3jlJemGrX0SxG6kjxgFU5aLPxBA9Bry
         MCbA==
X-Forwarded-Encrypted: i=1; AKwUvBwYSFMsxNXdqiQTBdJFsGuky9jaU3zj7NsrtNNC4hb4P52/4bZMhff7IRF295uS4P9Ub3stZvcfNQWA+OI6Yg==@lists.linux.dev
X-Gm-Message-State: AFuF++lI9Iy6m2g3zYN9+huQZzoFJAm8nkYv+JyH5hvjvi3GXOQfBNVx
	iSxkziC2ZJz5tCd3hQ078RDWjrTTCmKpfJG0C1F+O8viFHzkgsLT9gX6
X-Gm-Gg: AYBFou04PMCsBA46rO8Ytf1wJAsGBjU2J9alWPuU16HMzD+j6aSzXMy+ajCZ8iNVlOH
	mH0ZnTGcjPn3dPSPTcQyH4P9z5UwQ1XozKyuHEQkFImLEFOfiA+Ezk0zN+8MzTGt41oxgqTcX2U
	IwjByCfB5oPxxpMvciuh5f5EJmTUrB74+fHuL78q3n+jhuKd9+6NdTuMuwywGGAbi0p3TwGpoLq
	5nDWPLWmU0olyi5GowGSYlbk+YcSLTL5110YFcA0G8l4JrCAcz13T7dMnDaDM3/O43Ezu3Byuvy
	J2rJ9OJJVmfElr8R9bBNSDNp+lUWSrGy0zWMsIJWYI3ccqO3H/chI4SMsaJwAeouG6ei/lxFlUj
	NeIC7Z8IoShi4LOtl2C9ubJ0d0OECAMgR3/28eNvBbVHq0PqY1YS2rhXxGKKbMO/H/jfFOZt9/I
	ZV92g6pizqlzyvQecFFD/0LptwsfgaHTsxKeO+AB8tTPc1LIkLCzY94cDVp2TPujLIUQegcSf2Z
	fBPzBbJ2KyNYFrz9sku2xyNxa3Gdy2y9Ev1SxO0ACOxz7PLKyW8mRORymL50Cp9AXyfyqw6UA0P
	28jVQEPcX0NLAX6X28zfminLpWVJCMM5xEhAPYEhxXo=
X-Received: by 2002:a05:600c:620b:b0:49c:fa20:cc07 with SMTP id 5b1f17b1804b1-49cff19cbf4mr203278645e9.30.1788845986284;
        Mon, 07 Sep 2026 22:39:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:45 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 5/6] platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:16 +0200
Message-Id: <20260908053817.26065-6-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TmFIFO invokes virtqueue callbacks from its FIFO work item under
spin_lock_irqsave(). The core's synchronize_rcu() fallback already
covers those sections.

Implement synchronize_cbs() using the existing per-direction locks
instead of waiting for an RCU grace period. fifo->spin_lock[0] covers
the transmit callbacks, including the callback from the timeout
handler. fifo->spin_lock[1] covers the receive callbacks. Take and
release each lock in turn to synchronize with callbacks running
under that lock.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 3c6408581373..664bec20a7ae 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1135,6 +1135,20 @@ static void mlxbf_tmfifo_virtio_reset(struct virtio_device *vdev)
 	tm_vdev->status = 0;
 }
 
+/* Synchronize with callbacks running in the FIFO work item. */
+static void mlxbf_tmfifo_virtio_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
+	struct mlxbf_tmfifo *fifo = tm_vdev->vrings[0].fifo;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fifo->spin_lock); i++) {
+		spin_lock_irqsave(&fifo->spin_lock[i], flags);
+		spin_unlock_irqrestore(&fifo->spin_lock[i], flags);
+	}
+}
+
 /* Read the value of a configuration field. */
 static void mlxbf_tmfifo_virtio_get(struct virtio_device *vdev,
 				    unsigned int offset,
@@ -1179,6 +1193,7 @@ static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
 	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
 	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
 	.reset = mlxbf_tmfifo_virtio_reset,
+	.synchronize_cbs = mlxbf_tmfifo_virtio_synchronize_cbs,
 	.set_status = mlxbf_tmfifo_virtio_set_status,
 	.get_status = mlxbf_tmfifo_virtio_get_status,
 	.get = mlxbf_tmfifo_virtio_get,
-- 
2.39.5 (Apple Git-154)
