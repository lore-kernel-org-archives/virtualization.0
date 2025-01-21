Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51B1F8AFB
	for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486679; cv=none; b=GdWj3SsKp4jlvv+xAybS5y6pXx93tIoG2y+M1XnqM0HXMj8lryTXzRs5aqJQkKvKgkDsYcVnPtN1mN94wvH7ed3cxbuTOYXx9qgn86GUJM6Y1U8A6RUy5ZOaUIVZ9KDKz3xXjg0rsA1QQ5ih/L8OfZ+ucXNIRrLk7gKbCY1f6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486679; c=relaxed/simple;
	bh=ps14zeISRQUrPp/FMjIu7GyzXnHtSdfWr0SOARpLgXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ti2HHiAyyKnFaRc6ApIEIbk5cOak22YVfwNdn5ozLPFUr9wFM9phgwsXyJ5q8J4Fdd/qN0M/vuMBrxob40cE6eJdvqUPPJmwUV/1lhg36EK28J7QR2XHNZxlOHnobTzjY9XhfWWRgActPA+0OAODM02uBlbyAA95okILtdSBQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=q1ci1ffj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="q1ci1ffj"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso5634190a91.0
        for <virtualization@lists.linux.dev>; Tue, 21 Jan 2025 11:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737486673; x=1738091473; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDWORuj0wvWXpxW0vCuhr9iAbZl0aXjuDP2zaKtZhzU=;
        b=q1ci1ffj3EMHP4RX9eebfkLZy9v+9/hnHwUR2fISfWemAwgTJMqvwZvf/Fs0R+nmEz
         vPHuzVUlhAIBaMRDbWp5AFIbWSx4uxmXkmBiQss+QZSRqRpUcgdcKCBXsCzfPIrD05UR
         RTCHn9YbHK2jOLDz8yAGQrH0MAsire1xBb41g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486673; x=1738091473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDWORuj0wvWXpxW0vCuhr9iAbZl0aXjuDP2zaKtZhzU=;
        b=XjnrUOO4WlfQIvTX5ui9Nd5/vr5XDXBzD0gnXO7K1usH0DezJ/0g+qiR4TKBzxak4v
         BfKwF5PlUOFn/uf/CueihtrfEhxLq+s+9HkcWReAWRvD1dqCsfL8JY8RT18g3NuZ4bCV
         1cXCCaAg8H6fgKRU4PNVz7hErdS5qw5HZcBl0AQ0g07z0Aom+1FmPBhqoEA4seklLYl+
         6hgmZFcNBDFTtahcV5DugUiPwWEXND9+MiPf5F1Mayg5VtPFTmTGJ5mK5gyce2y/wC2U
         Q0kZTpIxEuJg/XjNcSibtgm7ln7VyfNlzP0ObT3R3Y4qqintFhct/sdnhVc7YO2mb4PQ
         UVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnUi2gAqWj0zsEvks8HVKySD21jpY1UTU/cB35L30Jz1fUNy7cavSp2Hj0rj+AaFqwWt9wWoUNKa6iPO0uxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YygmkJ0z+Tg+KL5jo5tWxGtNEaUpJeAXi4xcTlZvaKc5E48dPFW
	sbhVT3VJTJLXvmRK2eAcHiUajt6iFZ/zN9QmNeUVzXLjWDAJeUjMlxgVGYDBv+4=
X-Gm-Gg: ASbGncv6bJCVdHoKqrmHSla/YhPh4bSn8FhmLLGAZNeJU1ADXhBcSeNv6exV2GUFRlZ
	hj57Oxel2XMTcbI798kBxYjOrs7UcIY07DAVJA6XGlu/ejlJj8YwEEJGqvrhxNgs3QC0P8NaPJf
	ZPbI6dB/80dskzh7E0UdP1A/Qyh2GN50NfwArozjSRKa0YWmypM9GmFXs0/GxcEqVRDlIIUSBL7
	KKKjVoTttDxYth5X1jlRWMiw8TXH/MF4CmV4duhyWdCXZOKpwt6IEWgJLYKwLWJWqdw2qfEJNi6
	vg==
X-Google-Smtp-Source: AGHT+IEb+ow9B8HMeKsPl0hXMsb+u+xhEKMUqjLwNXvMEkGNBJdrkESWe8cbHdWnNyIQHfkYMacpPA==
X-Received: by 2002:a17:90a:c888:b0:2f4:f7f8:fc8a with SMTP id 98e67ed59e1d1-2f782d8cd4emr28724895a91.33.1737486673632;
        Tue, 21 Jan 2025 11:11:13 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm1793440a91.26.2025.01.21.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:11:13 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	leiyang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 4/4] virtio_net: Use persistent NAPI config
Date: Tue, 21 Jan 2025 19:10:44 +0000
Message-Id: <20250121191047.269844-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121191047.269844-1-jdamato@fastly.com>
References: <20250121191047.269844-1-jdamato@fastly.com>
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
---
 rfcv3:
   - Added Xuan Zhuo's Reviewed-by tag. No functional changes.

 v2:
   - Eliminate RTNL code paths using the API Jakub introduced in patch 1
     of this v2.
   - Added virtnet_napi_disable to reduce code duplication as
     suggested by Jason Wang.

 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c120cb2106c0..e0752a856adf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6411,8 +6411,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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
2.25.1

