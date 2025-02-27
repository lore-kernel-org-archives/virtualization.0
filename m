Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44126E96B
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682249; cv=none; b=Ea8CxsZ8Gl2ocuUXgkz4d2G9OHYhKeqaKK85vfhwDnLyUkLdOWPZOzc17hxoniE717MsUDIwLo4lmyDXE8AY/pz4LQh0TxmYis203FaNMIOWj5vskd7LRbBxQIsbBlarmJHv0qwqEa95UI5SLmn5ldHW3GI2bsyJS0kt36Cy0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682249; c=relaxed/simple;
	bh=+SIdCL906LeLrhIoYRKYJT9sFHmdHFgcMAfsYXihQ1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a20qY+bvnkzo5mcCZB+9q+r5eoYlUFXcT24LlyjGYRJgpk3/nHWl2ujOdh0uNj2+B/OSMM74G4a+gBwNSLE3Zgx7HtA4pN2e0Xbc2M8ggSRAlhm6gibE5aoa3k8/XRIQKreDqNs9L7He74xvA1bM3g4+OwYIsIf+pKAncVwsdNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=s3lxNv/h; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="s3lxNv/h"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22339936bbfso21832715ad.1
        for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740682247; x=1741287047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb0M0TRCtHIEHCHSiRXPcmJ/ChrocE4CL7Co5HwgWeE=;
        b=s3lxNv/h4hJ/Mq6QKDScvyy/7bdJpTV6AKVai3fwbFAiWeTXv4rNAmtvGCTWc3s3BS
         vmGz2Omqc7iISKKQ4GSL8NvnozVskKIIjNKgGvK5NEXVqmDOTX16cu/cD1qFH6L4Rnt9
         2ir36oz70+4hIVAM4sNit7ACOtqQVVPUpGmPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740682247; x=1741287047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb0M0TRCtHIEHCHSiRXPcmJ/ChrocE4CL7Co5HwgWeE=;
        b=B+V4ecB9m8YSbEBaL7tZ2SGsw65q6hkhn4aqGDLqDgp+GX+iblPu0KuqdwmJET/qk2
         b8dpVLipUtps+XxynF3QCLdWnMsirH+lXr1wzhMCFMu7wn8rAAcBKfdIGi0enJOLjvEH
         LCgm3ZRHqeYJYVinQkIVx9tS+TCyt+aknF4CmV/zSjfQLo5PgjvkvsKOOsyQ9EMi2GeQ
         gHEOPWvcXI7PzqAf3WZCTXlWnVDe6E/JbvGoI3gnIJwh93BKGAGD2mWFVN2T8EubmUkS
         4/HcumQq7dGI0wY9vvSe6UPsX6f4os3O8OWxH9NbbJAFVzkkrQmNAVtq7z0+s0pbr9Eg
         82Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWJgg+0//fziex1Vt/V8N7OM9BXP1uqh2dWo59CfxeW7UtGzuiCunzzoAvYtNiI/o0fRS5ipFPmdzZ46npkbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSv91QZmtlyihzcWpKr2cFl8flAey8Zb2G8up6OFu0Hcsq0DBz
	82ZDAtX7DyE86IuUpUhieD1Fq1XfbJxbHZZ/Rm4DBORsXsxzhtR86eR3ge/psIA=
X-Gm-Gg: ASbGncuIR9cuQolWYpKG8Qi6iFbMfEDRE4Gdbu6AtRhsOz6nRiTP9OhxICjq0X1ChzU
	vibzH/+M/vosQ5NjBgwwj609ycZK3da8GwRolxbq4g5V0XDT2qGULawdNmBfJrVDAqUt8XMVIP3
	Trmba23rRJYYYpEzsWkdtATlV1R9I5qzJznMb6dO0yX2dpxynsdCNrlA2M3EeiOuA5DSN2PRSDC
	hxJZ521cWd4HkvoRqjEmnsygIU+/3fubDAIGdNz+ZLYQDWAcj3WI63THXGWKTqqKV6u2ZXN6TqE
	2P0QWzD+6LoXXjxuU1NoU891fzGBdQ+K7Q==
X-Google-Smtp-Source: AGHT+IG09PRDodbXU23HoxlyyGWid4dyJeVF4PnAlwJOPsZe6tyJoXz4u2UsXV4jPCtXuFyfiaBoWQ==
X-Received: by 2002:a17:902:c951:b0:221:78a1:27fb with SMTP id d9443c01a7336-22368f72060mr3908095ad.11.1740682247418;
        Thu, 27 Feb 2025 10:50:47 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350503eb9sm18275985ad.193.2025.02.27.10.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:50:46 -0800 (PST)
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
Subject: [PATCH net-next v5 4/4] virtio_net: Use persistent NAPI config
Date: Thu, 27 Feb 2025 18:50:14 +0000
Message-ID: <20250227185017.206785-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227185017.206785-1-jdamato@fastly.com>
References: <20250227185017.206785-1-jdamato@fastly.com>
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
index 76dcd65ec0f2..8569b600337f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6447,8 +6447,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
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

