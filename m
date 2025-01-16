Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB48D1991AE
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006813; cv=none; b=hs1M5M0nObhSTFzzvx2IcNm/ET+QYMkHaHD1th50imaICX4t63ENwFSXlvX/Ei+3cNeCV8pLU9fNyvIN2qMkx0hn7h/xeWo3dTrWFgAJflLFY+m/QH8zJ63pyyxLUSqKDYkpv4lny8TFfIsznPaSj3o6bfZiJag2N7G3xeH7UHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006813; c=relaxed/simple;
	bh=UXb3rPE/1GDUYX7xYJCycggz8UdX0ho9WDF1GZTuo+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpzKIIA+08GiUjBHVMTSg8REjgbbvv24clB8pYnV+71cBLJUQuwBT4xVenoiPivgPZoeCi05l330/2Akig7NsfszSg4pTB1CfEy+Zb75bY3RgLccfCho3pE6F/eCoO0eCS0/MAdVHBhUKRfG4BnpblcArSqM19nZi9pYODhVq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=r+m3yxJo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="r+m3yxJo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166651f752so10997775ad.3
        for <virtualization@lists.linux.dev>; Wed, 15 Jan 2025 21:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737006811; x=1737611611; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZtsz2Rtgk1xt8CSQNH2JM2w40RollK9oAaOdJJO1B8=;
        b=r+m3yxJo+nOuztsCr5WH2CNchrR1VH+54a/TCOdfV1EqWDlE3e7Rpw6ignc+vWdY1b
         wtD/nx0SmfPMfeKmjBI2o4zoHO0HHta/9iC6+FW7WTfRb1cSb772IxwEJuF4Iqgmm6qW
         HU4ivFWbzVd5XqF6xgbwI9PghtX0YSL77mMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737006811; x=1737611611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZtsz2Rtgk1xt8CSQNH2JM2w40RollK9oAaOdJJO1B8=;
        b=tiYlmx1ovxw8H8bXi2nTGVIeKRFVgPAsGb4nwNA+ogbrbdIL73BgunxXpo8bSe3wFp
         8D25g9eCGFePlFb98K5sIXv9rQ98ttOjT9BRCAmWYSpmWqnaYAtkcKCfn1dlI9AOp4mT
         srDrALaRpklDcp8vzjRsmkaKYCJ7ZpZghSV1Qz7wMcQ6Xb5ig4MfIMBcQZuqXw7Wi04O
         V7vMTqo5itKiUK2/s09Ns+FCtN3N120hCFPISFYXe9ddm94ta7JJv0mm3n80C+OEG9Gx
         EIzwkkHVVhkuJlQMiti0DkZdX6i6uZCVstDRuf3qOaX2lDBpvnlURorHsPDC2DcUzW1b
         eplA==
X-Forwarded-Encrypted: i=1; AJvYcCXSLsh3j4F2v28jTgqvaNoohW1lWgE8dA845wgNXKtkayLSMS62xVIyouzBYSoGwC5pHHW5UA1F1ByQFfOZJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlBqfmeV496F4dS2+IGVe4l+W+xooI2ShaAUOh5U5Ugxf8Jc+v
	cDSYflD9qU1cOgY7vAYffStSW6WphCsTM9GnJaxCA/gNOISqoEwNX9KdmSoOtws=
X-Gm-Gg: ASbGnctbGBTxQOunxptF5rAeSPcqOWa1x+a81+DYiY0E9bwVePWWozy+NsqqToStwxG
	lSsBA3jUbJEgB/c6go8OFHyY0UPoX2IEcUINKVPcBfd+JgySs+GFdLg/J/cs8DrP7Cx2+cEtbbF
	vml3yLG+wqDb5rpCuDUyRPbJSuz3HhGvAP/A/K8cpnXymqWHLK0v4dXu2FwyyENiUjznkTyu5S1
	5LUb5u6qb5UlKLlPzKR24MkID8s3fQ8RtNv2eYO+UCgUfVQ3F/cwAYbpElIGJrV
X-Google-Smtp-Source: AGHT+IGKQzp0gRosRVZZiRnTi2eKc0WyUMTIwNaRCmD8fTVjAZ/tLpnB9TpD79nfRxnZfUmc/GT8fg==
X-Received: by 2002:a17:902:dace:b0:216:4b5a:998b with SMTP id d9443c01a7336-21a83fe4c3bmr516333485ad.45.1737006811200;
        Wed, 15 Jan 2025 21:53:31 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22c991sm91249655ad.168.2025.01.15.21.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:53:30 -0800 (PST)
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
Subject: [PATCH net-next v2 4/4] virtio_net: Use persistent NAPI config
Date: Thu, 16 Jan 2025 05:52:59 +0000
Message-Id: <20250116055302.14308-5-jdamato@fastly.com>
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

Use persistent NAPI config so that NAPI IDs are not renumbered as queue
counts change.

$ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
Current hardware settings:
Combined:	4

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
---
 v2:
   - New in this v2. Adds persistent NAPI config so that NAPI IDs are
     not renumbered and napi_config settings are persisted.

 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c6fda756dd07..52094596e94b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6420,8 +6420,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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

