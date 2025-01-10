Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F020766D
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540782; cv=none; b=s+4JxUclAcIEYxLc21jhn6HID/MRZzsfL03EIPoZgfLodSbIjzJX65BnsT0OTuQCdFGL3fJrXOy3ErHXKFLkyvlkJbidAZkxcBGSOD4Q35esZ62T1n/PKAa6I9j5E6DbFzw7/TwMilFcfECWsRzMKI0aDURiNfoEurYYvAwFHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540782; c=relaxed/simple;
	bh=L//1ItUL/phY7fZdnQAHFMdHc+JAiSoz2Yj9uNn6Lyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqCl8bpCd67GFfG474ZfpT5hTjDKSJh7+fUJJYJt4RRiAlWhucTEX1/o57EaWEA5S51pghJwUh7M2yfj0vpuGHPE54Lj6QL5OLFMD0WNkz07RKIl30yDolP3l/oObyOnfDPdJNXuuymz6kMsKAV9xtBeHWgUrlVYvdBvpTqAa3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=u1J0KuHL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="u1J0KuHL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21619108a6bso42373465ad.3
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736540780; x=1737145580; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYBtxkIddVIdjfELPff+6zSxWcfnw5xo+urXkFqVelo=;
        b=u1J0KuHLznfI2iC5FUFnAYbrubWAM++KwKXTXzIPaMD6l8EqAjUYPkyNFe7NWd65DL
         ulK2svXvxECdzGmkSTsiBSLS1G6TxWYNyrs/AZ3yFQZ1cpucnRQ9vWyaMUp/w+L1LyCn
         jlFldtPuzW/6nY73CPgO42VGkW9gP6Vm19ZSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540780; x=1737145580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYBtxkIddVIdjfELPff+6zSxWcfnw5xo+urXkFqVelo=;
        b=YSCGueG/OuTThlTddf8YBGm8q+twE1+C0/8SEbq5r6ksl78ReuXQwQSplvLvht68y+
         sXbIvB+wKZ2c+Igb5M+5YnjJ/Pzvb6/ewpGqDH1kNOKWemxjJ5txAm0hXPBX2xXApIOw
         2GFAFTDeNT6do40pif3yoFO3mMtF5OuQnI+9A1EWmAVeLQQoSWFfBmNsswjSIjOxSMO1
         polSjxHI7T6/X8np/8RpFFEopQJCMJYKZ2x3jD9aMAbyboD21CMeQ8eYH3LWFI3SGj+7
         uErWEwDdcU6h/P5SJ4BmIHCxtqHkJKcJqt3ienfXFH6H0IS5z3vAnnjXjG8Sa4DcAKPI
         ag/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlxlGijthZ2pPR4V9LQmQ/8s0KnE4avmlUFQUhxVTKJ/YTP05qIgq5r6/PCdm8gKi6npprIIQ7JyAdAnnSQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUNsSA+iV47o6F54bRRXZJdmozlWKrVFqfwwqZ0sA6Lf0GFj/+
	Z1wAFfN009gYZ5N6DbTUe4RHW6q7wvHJBvpiYH6F57FRhwXFSBHmoXv9dLPsc3s=
X-Gm-Gg: ASbGnct0RYNj3pjYcNbxWHgVo0zJe160IKN/3ijm2mGL1gNRAJsWrNtzXZ5gpq1vrZx
	PgTSPAcZtYS9wDN6tRzWtos/vzsu0dfPzFDwAa70UWnLEIhNPf+q1qEWnrQx7s9NTjsn9Oh4XzN
	a++pm+fvV7O8er1X1o2vb3yH4VRlg0uGAQER00i+BvGaHDGpbixVRkbfca1LlzUQXUWZ1OiqcB5
	3S0yDkmcfqtko26t47pCxnyz+/wgH03D2oH1Kl6CryPAPZf7LR456fJJ5KbFRO9
X-Google-Smtp-Source: AGHT+IE/1wk47T+YBogVHpi2dklAZot8YbzIIrliuB0Q46BizHw8aPtqwioCvHXYsjt1ulmmZpPd0w==
X-Received: by 2002:a17:902:ea08:b0:215:9894:5679 with SMTP id d9443c01a7336-21a83da498emr183024235ad.0.1736540779765;
        Fri, 10 Jan 2025 12:26:19 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm17091825ad.166.2025.01.10.12.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:26:18 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/3] virtio_net: Prepare for NAPI to queue mapping
Date: Fri, 10 Jan 2025 20:26:02 +0000
Message-Id: <20250110202605.429475-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110202605.429475-1-jdamato@fastly.com>
References: <20250110202605.429475-1-jdamato@fastly.com>
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
---
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

