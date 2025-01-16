Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53301193074
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006809; cv=none; b=SyTvqhT5ae9nXV05gS46Kddfy2XzpARsgerITAO3+olEErnXeNycQ1efTvO7/UD+wi2LvYust8uMKgGiGr5Q44WvpdeG1BkIIcMuXZzGs0hnSG9HcQ/ECN32fRPCbUneP14nSm91it2xSS6jhYtiI3vN5BtPeSXBJBxvvM+2PA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006809; c=relaxed/simple;
	bh=QoUuXeDBulZSbVMdrI5zM6Eg9lCr5hgBtBOzJbP8zEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A5IXrHowlMB3FnRNeGu7ljLDODCRowecWf9D8zcfCnPsrLN3wA2F0zR8NaZ9e4GQCyGLn8WGli//EH+m1GYVCWmIYKniJn5kD60aak5vqLZMYAmxlvGPGcHZGcu1VQ2dVscZK1PeDBklcAoOb3UgPW8Be/0NdxNszHSL7Z1WI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gBJW+6hW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gBJW+6hW"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2165cb60719so7982055ad.0
        for <virtualization@lists.linux.dev>; Wed, 15 Jan 2025 21:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006807; x=1737611607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sIKGTHIeBOioZLiUeQpKiV7N2jyLH+xFiew0830fKc=;
        b=gBJW+6hWOX9p27io1OfGgfH7WXc+kJwzA64N38WeOx7hLJ8WNO+PgEtJR2h9eB8Nhd
         +13uHwq7XT1TeOwtp2NL8yxnxSpkfrbkj+uFdFe4TuX8dgKHiUZkUrbrfqVAgv43E/VF
         Cf7mWi+YKsyp10aVi8z9JxwJXsN0j2ZDvp/4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006807; x=1737611607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sIKGTHIeBOioZLiUeQpKiV7N2jyLH+xFiew0830fKc=;
        b=DJAL/ifsa5VDxxyeeAXSTpdyT3Ada0jUeib7+9oNF6AyI7nHpm1BQz0iBIc0EKKnFO
         1CTLy4TGVksvCAmhQrMhh7pVKA72cmRhA08iWTRzf+4Lv6NCZGFWE2EhPoIcNk9zlpbO
         MaBLMbXfigCSLUxYYzA5VrbiAY0Nm7dmJ+bawcF3JN/kG5z3SUf5vxJMoBk4+3uvao2s
         8LFcUNAe06puuiqGdAfnF9ym4lc2QY3LRlXnUaWTNFhEz5lg+wFbMWLRXjtym+PBOw3j
         KbqBlTAHl+mAqwCTBIHJRYyyhvUjJvhbJ1DiIpW7smQxApx6fj+hXaZMAYUsShHmn+Hy
         z4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV7WSb+bsQ2hJPsz51xP6d5RX9lFbFrwTP09rbUCSgrddnJVsmnMSmJuvW6HhQkGSl6pf840X0oUwnqV5CnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+nvafL27DBcJyOXHwU/AbZSIu4MLL5yhPrgv1RcogE/F9lrRq
	jQzuKkEDhgvzRF1lqQOIjxC0pI7wKqGlq0gGBgmspaAmEHbSftSjao4JITAhqXY=
X-Gm-Gg: ASbGncvx9XujCjpkJTErVm6ivHGy3Kn0trBA4pQXaC7x8SN9v8N++A7mlscdfPEl/WJ
	HKCX0NGDgDrnqelHlt2h20RNKfMlVR6jZHdSnan1kaWFFPM0iwYmg01kmlcUJeYTQXrR1rKNqjA
	sTEQhTnprAWe0Cg6TCsAng+VFmNB4fqSMBBvSnE33+GkI0FrZJZ4UsxXcznwKb/hhUacGYS4Q4L
	+BHGVuJpcKrahV+hqhoRrtDAb5723j7lzIUMYG5Sxd1ypIbR/4+XDxARieD82Nt
X-Google-Smtp-Source: AGHT+IEJCssTOUws+b72W8uZUvjCTPp85OZ9h1VVGxQI7rHP+zFi1sj5ShlGmZbXcEUCTdHWY7Z3FA==
X-Received: by 2002:a17:902:9a09:b0:21a:8dec:e596 with SMTP id d9443c01a7336-21a8dece7e5mr344365815ad.35.1737006807678;
        Wed, 15 Jan 2025 21:53:27 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:27 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 2/4] virtio_net: Prepare for NAPI to queue mapping
Date: Thu, 16 Jan 2025 05:52:57 +0000
Message-Id: <20250116055302.14308-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116055302.14308-1-jdamato@fastly.com>
References: <20250116055302.14308-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Slight refactor to prepare the code for NAPI to queue mapping. No
functional changes.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 v2:
   - Previously patch 1 in the v1.
   - Added Reviewed-by and Tested-by tags to commit message. No
     functional changes.

 drivers/net/virtio_net.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7646ddd9bef7..cff18c66b54a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2789,7 +2789,8 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_do_enable(struct virtqueue *vq,
+				   struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -2802,6 +2803,11 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 	local_bh_enable();
 }
 
+static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+{
+	virtnet_napi_do_enable(vq, napi);
+}
+
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 				   struct virtqueue *vq,
 				   struct napi_struct *napi)
@@ -2817,7 +2823,7 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 		return;
 	}
 
-	return virtnet_napi_enable(vq, napi);
+	virtnet_napi_do_enable(vq, napi);
 }
 
 static void virtnet_napi_tx_disable(struct napi_struct *napi)
-- 
2.25.1

