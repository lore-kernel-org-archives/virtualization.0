Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A888188CD8
	for <virtualization@lists.linux.dev>; Fri,  7 Mar 2025 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309949; cv=none; b=c4rycPJnoEsk1+JzSHEZxm5upxvGayUrFOJsLm2eshG7o0aZfYOGdCKQOrv7qyQLaLz7jqXqp6V4gA14TgIU80m93r2EtpADMzTJuMJW+1MHqPeL1UIEAb0FkYUoAMztRDB0YIoOi1X9ytcsDrq3VEa6UZ4JsEUkbHh0KoiAhss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309949; c=relaxed/simple;
	bh=NRQvfEmcLOdbXMa3vkDoUqv3L83HRqj8sSJXVTmzeH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPOPKrjNLFdFUQECmUFOfmnyR1IZxs/CxCKyHSo1k4pcElf4d7ZlzFzJ1rw0UTWkiP1a2IY4Tpl7gc933js7xnrthVIjDElfbNOZUVP1C56Upxy70DmkwPqKRn0dnB0q3KIfP7KGLf+Hb/setMquwf79XOdUKDrwew8HR4x4Urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=BVLaDG3h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="BVLaDG3h"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239f8646f6so25004635ad.2
        for <virtualization@lists.linux.dev>; Thu, 06 Mar 2025 17:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741309947; x=1741914747; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXXMV7POf8zFLVgsmU4lqm240SOUGeBUlbPBBPUwDdE=;
        b=BVLaDG3hfDlJEJ2Vaa8IMrniJkzPBCpXP7jES95i3QwmGJIDb1lWfROFTXDWhyp2r/
         EaT9xJk2D5iEfvPN/qM7976yMTSLzrHq/AZUGJxqy7CIgnAgjLkao9KMpD3SeBcSBLcu
         1mZ30ZKWv7DJ+TOy/pa7XOTQXvQxA5X4K5qkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309947; x=1741914747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXXMV7POf8zFLVgsmU4lqm240SOUGeBUlbPBBPUwDdE=;
        b=tC0MfLQ8GJwA5aweegTkyNCr110yf+CBpT2ijomFRtKLtntHWiqseuYKhOzIjzXo4F
         39fJUua5TSAoI3i4j5fmVqXt2KtXOwc+YVhHKtNhswWyMnxCG9JjZUPxsxwvjlEaiY0k
         zJyPxSqlvLzQpI07OypP5hGj6zDl6CmfzN8mNAer15S88wo7k5vqdDDU87phsyenu79Y
         xjM7JJ76Ixs3W4KrKYbs90NHAJaiVdRBrIXbgWjx/0WrwnzLMf0IlXG7g0e2/3I85kUl
         AVZsiU2vxkpWSN4dvqYM2MHIQvOho9uKVVDwiYOJfVCcF0IXRtzTIgVjHpUSKjk1L8im
         fHEg==
X-Forwarded-Encrypted: i=1; AJvYcCUXrsT9yOmE0zE1LWn55TxGffp5EvYioENa4HjjnDYMgVxqO2OVMMrlXwlcNOkjWkQdjbDVe18QC71tlWFiGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTeyo7CyeKn8kc7fC0uHMcLJqqyqmsm/AOa13RFdD++JSL9fZD
	Nn4MRpYWzunN7bnewD8jaDpknnkCZUUFt4HRSV2Kkvjm9ACtrnx0MD+guI+DT/Q=
X-Gm-Gg: ASbGncvKz+rCmZzdlXiOR66XsHJhArQzHVidjduBJm86rozmXRDnXO/4wrY9JVRxndx
	8Qj5IhBsFhfjGeffQnZu6JdQSUcxbl0OzG78rHFY7WrQv1ygcmM8G5mJgfHOZ5s7Mm+SVB+yZ9w
	UE0KxYAmKP8uxPa5p2PcEr/HCVt39Y8t5e69F1g0oWkR/Mj7+g3UT3iHpuTHOstt4J5ZiZ5D+US
	/zbAiGqxpZXZSVZTXb6iGx9Jd4jV64W4UpKk+ydxraZsbfVcMMBUrBo24A+V1txiTo3iP8fhe+8
	03XGCoQm19dZTAvGEYbui7fK1Js5o3BWF2SwhPEq27MVBF2MQgqV
X-Google-Smtp-Source: AGHT+IFK3bB+IzKnnw66OCX8SvIqCP/r2HrOrRFyFYXEFX5hk5hRRIZRcJqImQVh7tFSujAdQgGJ9A==
X-Received: by 2002:a17:903:32c6:b0:224:13c0:58e3 with SMTP id d9443c01a7336-22428bf1976mr19677025ad.51.1741309946772;
        Thu, 06 Mar 2025 17:12:26 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410abc816sm18749685ad.258.2025.03.06.17.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:12:26 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	mst@redhat.com,
	leiyang@redhat.com,
	Joe Damato <jdamato@fastly.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 4/4] virtio_net: Use persistent NAPI config
Date: Fri,  7 Mar 2025 01:12:12 +0000
Message-ID: <20250307011215.266806-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307011215.266806-1-jdamato@fastly.com>
References: <20250307011215.266806-1-jdamato@fastly.com>
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7bd63a677123..34cec2b11b74 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6455,8 +6455,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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

