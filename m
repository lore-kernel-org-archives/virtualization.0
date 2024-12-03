Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687A91BE251
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211069; cv=none; b=W90vic5Gq5FrzXqJpL46/yagZhTE6woDcp6tdinZoQPtpcXeR8KsjE84WuTYPCOli16rQpeQy6WBuxhaguI7SMDe2oRWHFMfMsYehAGAWtQuU2GtsEdhXf+Ky66bAG4dICQkMShfVC0715ldXqeRsPpIeC73tPKssE/JDmIRerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211069; c=relaxed/simple;
	bh=ONGQeGV/Lo+dvZaz/MxmBnTpy+k0yha3gjPk1y+HOIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfNG7tcXU9/XBu0IscT6lNMoeOnwzuqesTIs/iEFM3eefc1AuSr0GPOuXElxgnCNtuw98aAleV2z8haXjraDMbvruNVJu4wiXmOh6iFVmmmpcUErCL7M1WdxZClFwwbc0/auTW8DF25+1KzdPFV+vfg4XNI1Lx6QtoQ62VWg8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=og5pTrpR; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="og5pTrpR"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9213440624
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211065;
	bh=5NLMnu2Z46KkDgOBwjL355ay2S58qzCZBNzBIFOkdbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=og5pTrpRvLJr0XSW2GAPqyptSvzFiPq9P25nRwiD6RklmYc4qDy4rvVU9T3KAfj/x
	 Kof18ZoRu2x9ict/CHI2zJFFgFlnisNZJDC5EBmFIvzAp3IyH/I6AnGj6wQFPR8q1w
	 zbXemcHYEdDkJS1yXV2fTgikPPjukJndYPlIPy866fkR8/bemteoziajT0nGS1brC+
	 Ih4il8+C72+0fyb+YPTyc5qnsfMHHI4OkkyFX3QeTY3HbQ1wShBkEjDA58NiYyloHw
	 ng8xxkWAkYp3nJ7RNl8RLA7S/ixHNBID+0F0F7RXLwqWJMomQZt58oZk2zSkT7n41Y
	 fhH5R9zpnNlbA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-215b45a6e2aso9129415ad.2
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 23:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211063; x=1733815863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NLMnu2Z46KkDgOBwjL355ay2S58qzCZBNzBIFOkdbw=;
        b=sUKVfz7aVU3pMpIMGxB3Oi14U3aYsbyC0juc8OJIg3SAQXxUKUNh+dWqVFYaLhe1ey
         ehMGTGDuggPhwphA0O8G2/bF5X8Qqim56A/ju2o3/Y/i5yoghrpyCojp3FlE1ozK2aqE
         DWVetTn43R57zjXzWz11uNvn5Z8wzcSf7uykP0F08VRScXcxGAnP8GOaxf/tAJee83+k
         u2ZnlfNz6ICBoWsO/eA823LBsr9uFlBImsOMGYoJ0eMP7LeFMve476XyLHk7T3x1rj97
         X1VuDFx1OMvxPZa5sJuygYNbWFskWMsQi0K7TMHXcQo7Y3ngzIsg/cyuGSqul3XKp4G8
         pLwQ==
X-Gm-Message-State: AOJu0YyqZ8H1fup59VSWdERVRFJDTZRgqP7duT1EUPI4j7oyt9P5L938
	Q7Sw8Ik+Eeum/JiEemCTSQ2tj1VYZbUD7qXfecm5/Zhsdfm4r6fwDpPbQHvAhoDYasgjCyh1Ga9
	CPG2qkcBnEuK3+Zk86lVha5aOfTby6Jshb7Cf12fgCoKh3esy71u9kPJ2S4maveszEjJkG6JA0t
	xKZt7hTa7rHy4x
X-Gm-Gg: ASbGnctlTya4VdgcWNFUnaSA8H5jOeywaxFGxpu1LyY1lRCF3NK4nNxd06v2myjVGUo
	I4MK2+13cIKheWYQYLT9iR/bd83Dpd50SLxdcwpdSbwubqB7aty3VsvxiRaF2EUFNcZfWZz0KHx
	xNL8EEtIQdVdFQHZs0l6siZSG4O4JyMgYwkn8vOSUVAT9NQwR2RRoGgTGgGbhBV/5TG/Kg3EPbN
	u19bWxMp1g3zN6LJ8grTOmV1XdXBHlqyJp0vFH8zLT21pJ8Tj6kgZOe6pLoh14hTqgQ
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id d9443c01a7336-215bd25580bmr20893765ad.53.1733211063427;
        Mon, 02 Dec 2024 23:31:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeKLM2ys5e0Q3udqn6af/fNUMQYdUmFkZT/mCzd4RS2FR0h2mYZFsi+zEkr90jaY94M2UwGw==
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id d9443c01a7336-215bd25580bmr20893465ad.53.1733211063136;
        Mon, 02 Dec 2024 23:31:03 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:02 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 3/5] virtio_net: add missing netdev_tx_reset_queue() to virtnet_tx_resize()
Date: Tue,  3 Dec 2024 16:30:23 +0900
Message-ID: <20241203073025.67065-4-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, so DQL counters need to
be reset.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index df9bfe31aa6d..0103d7990e44 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3399,6 +3399,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, &flushed);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+	if (flushed)
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qindex));
 
 	virtnet_tx_resume(vi, sq);
 
-- 
2.43.0

