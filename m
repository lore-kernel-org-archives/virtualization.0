Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC6156F57
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449118; cv=none; b=kUQwaj87lA33n5s6GQ/lfi+pbhtDr9/NmTNRBtnm0VxBTabm99dqdkk66OuaACkLzq954MHa6wivkrDwYxs/3Sd/PQ+Kv6MC/ssac8SegvKT/bORE5ZayjdENGBBoTaCPE4OLAZl4inH8XF/ILZXLmLl9NxxVDfqT7dcYPXV8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449118; c=relaxed/simple;
	bh=sqHw+hydx5+J+3nTg7GiF/z4kDtuYCJJCVEcYQMUN3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VioV/4FFyHMHG25LSpmGvXeM9eGmApLS/OICgd621eSxUYb49NV2kyS3pjpCgt4SVh78TudDfz0JelAYTdmThLU65ykx67FneSS0HTRRYnrn+TB3YIyZTxTXe+3aOpfmSndB2FPb3G1F8LAJ+dlrKdh3nDpBamIjmASUHf5Y6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=mJdlvzek; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="mJdlvzek"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so7894291a91.2
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 18:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449116; x=1741053916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jTrPXbJae2NFrVRDORH6UMqB3L+3yI0Uf5GqI0AUQw=;
        b=mJdlvzekf7eZ6PtV5kVsZWbm1gED9mqot/dCRAcKsnpT8WIPYjq/IH58yevKoGoPOf
         fgY/h5BrO/Tc22KEPpTjtQbGwdKicYUgiM3agPzzJSBcuzdHNCQ2TiEHeLtIUGsNjvBv
         oHk5bTLkE0iZ1L8K0E1Z28314YPs/v51Ww7uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449116; x=1741053916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jTrPXbJae2NFrVRDORH6UMqB3L+3yI0Uf5GqI0AUQw=;
        b=PFK1cwwPWyW8+7d9jYqQ35GTsA/HAMvwZOTCkhC8t/h8ONfLOZefcgdBg2VRLAgDib
         rEOkvudL18f9zWSnBxkQqSXY+o+UsMmR7FKSQ59i/+xFR+QnWh7hyrSwb24s8hcqSj0q
         u5NpZvI0hsQ/ncDB5DMQ18j6OO0byKlfmn5vUEIhl7O2aDNO/j7fhmsjKjl6JHd9Rg4o
         tHQEg3Q9ZBE0P49y9sbQVKn3NeiOO/kjbXeWHhYumcb57pGxnYdpxoT5i9u4Z71RtoKV
         0U4oyQiidtidCv1CUQCB7c+l6OnZBfa6ni3v2p1YHASGiCdjIxHDPA4CBMcP6HHYp9Sy
         eUsw==
X-Forwarded-Encrypted: i=1; AJvYcCVme1Idq0glTeaBsPIvICsQtPljRBiulEXSh4afTUczpEYwhHuxZF8Opf9qTyGClSFYziBYIH3JGeBMVyjlTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzM+14eqGB5nOUJhrLXIAzB3v9Hug9TgcG/twWH5z3TJG+rJWJk
	glp5bi5diaEasw4ydcT+DdiSyRtWXsP2FEzk7Xvjrv/mWgcLaTNlzSFq5u+zk98=
X-Gm-Gg: ASbGncsa9PjVA0vi4PxZ7r8T3fQdw7J+DwbcnDxT/Ku609tsO2yVuzicuppq4qG8Lg1
	LDc1PndtiIqjPUAJrak1wqFuEbP9SVymrDLyFQs5QfVb+4JweDEouXWkSC9L03tcs9HPE8NiUZ8
	8ErBz/NBiXWaCzc7xgM9mJFIahaqQCAoGiW3Vp4LTSYzjPx23juXf978s0X7TMIo7M2MAK1MO9B
	ZO7i2snK2Wp7Uj9c0Z9FIF2YKliSOeZTEhpbwAmvC20FwPnzOkIUJKISPWAsEYxZNiL6nw9KUxN
	w1jQ5oCspm9usAFr1bu7fcwRC21SPRJcoQ==
X-Google-Smtp-Source: AGHT+IGbedvJQbC1f3rBktTR2fDXpQeCE8dIxMRlL1M+qlTRLacNZdzhniWMjgESJ1sAs0pz8D4XNA==
X-Received: by 2002:a17:90b:4a41:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2fe68cf3fc4mr2493123a91.24.1740449116365;
        Mon, 24 Feb 2025 18:05:16 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:16 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 4/4] virtio-net: Use persistent NAPI config
Date: Tue, 25 Feb 2025 02:04:51 +0000
Message-ID: <20250225020455.212895-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
References: <20250225020455.212895-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use persistent NAPI config so that NAPI IDs are not renumbered as queue
counts change.

$ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
Current hardware settings:
Combined:       4

$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Now adjust the queue count, note that the NAPI IDs are not renumbered:

$ sudo ethtool -L ens4 combined 1
$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'}]

$ sudo ethtool -L ens4 combined 8
$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
 [...]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 13bb4a563073..186030693eeb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6454,8 +6454,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
-		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
-				      napi_weight);
+		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
+				      i);
+		vi->rq[i].napi.weight = napi_weight;
 		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
-- 
2.45.2

