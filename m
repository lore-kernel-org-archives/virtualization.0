Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755C199B8
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449111; cv=none; b=IWkN2EFsds9KGlKEr/fS+h1lbwqe9fQtp04QoK7PokCn9LKFJz8MS8+/61YGLVk7DauryHVAyWLQ3IBcQEbH6H8CTM4ioUN+jozTb4o2K+9NpeFdPGB8XCxna76pIwx/KSkCLu86kJXw0oUckykHU32So0SrGuaKzurV5HrAQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449111; c=relaxed/simple;
	bh=kHOkHvRodwcD3NttIpuOtmg3zPEBcl94jQ+MNSiumRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucjDFX9Z83FhBx85JZKZVOdDGUIrbb1UP3eEP1mMoGZzh637b/3/rw7AoKILNqVpa6ohaLGp+HtNMOpZvf8Mk2RORFaZvUGRgWh8a18kyc8BatOcIOS2Yk79clQqpMeQxzLOSpIB4XKIJgiPFyhQ+qk0fz9uVgf+H3Ap5NCLkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=MS/Q5Qzv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="MS/Q5Qzv"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22113560c57so17677025ad.2
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 18:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449110; x=1741053910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrEz6DL7nanR7o+Md6nJONj+JBnYNeVaOFzve6JT0bE=;
        b=MS/Q5QzvaZ8WnGgVZwxAObFXHClsuYCILaj5EyOyj9HKWERgJyn1yZtAGdPS7ynkHm
         mkDaastne7DdeVyBFftYEG/L0rzJclBmCYx4FxgSIDq7nkTSoKwIkmapEIBBt3w2WN77
         16h1goKHT5ci4KCEP1vZsKE3tPxXH74zJoZdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449110; x=1741053910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrEz6DL7nanR7o+Md6nJONj+JBnYNeVaOFzve6JT0bE=;
        b=BoEhkH1IG/B2MURnaGEDCUCmMU1JUsr74DHU8tu1ihDNatQgEn2pWauLle71xZtpSn
         sfIyqPVb8ysR1cX/oBNRSgZz+2cxwxQsQm41HD5zJNYkDUoqMfTuw7GnqiHe6up9eOdD
         sQiCADTxvBSKgjMIaA9Exnb1dozHEnJG8rCPzB/no5ZbueXUU1auS3HMoLqWwqvvFlFq
         QtL3BEt7EnuopYcYy3GPD6vlF8Y2kozfghJ3xO5PhbOddgCwZkGcpwJKOj/dvHDm9U7D
         pv965F68i1Pma36bM1ioGf0Ela9E5hAw4bAO9mvQbYh1trd0D/+ntqOAsm+y02yvsObS
         rOtg==
X-Forwarded-Encrypted: i=1; AJvYcCV1tVJ34uBajwm36FCbODeN8yM0Wsrikpl2YywodiRcFLdx5F1P4oM2J8qYgpd0bpK11v5wWXbpgbO2sXdv4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHEXU3w2mvbdodd3GBK49dZyWvbPokVVKOdMd/V4jK+zKNdvBN
	clA+g24FpFEZj73+bPSasZv+38M9yAPla3cijCwP9x+oGvpjmqEm5Wp4UgGXlew=
X-Gm-Gg: ASbGncvZmlkDxarSoCq5agTJ8WEQqFgukRuGpVO6Dag9XgejmpLy5UAxW6v9r6+4aCZ
	jZvfkkh+vaecEZpdDIZBZ+Ac+vjMuRrOnZ88GR31IchT0xXF2sP4aD8Jf1nuOIS3M5CCNXWxyj4
	T3vnxKsO8iEBlaKqyfr9jHhxNtbqpSogigB5LA0Cs+96t6he09rNSOzWhk6fD9U1pSwado/JsVz
	o6hqt99TReKOLe5SSNz2oBX+D9bcHn0cVNkRp3TmpAlLheblVITID0V0/E6CTqOr7IQ9clM++kL
	hKJMonAuibw2U0hVRFc9u2/W7mKv1ewYug==
X-Google-Smtp-Source: AGHT+IGWw8VZRuhBkwJIhpvAEi5veGPj66DpJjrWgGvII/XhNJTIzi7tYlWN7e+HTUnHvLTljSfU5Q==
X-Received: by 2002:a17:902:f712:b0:220:ef79:ac95 with SMTP id d9443c01a7336-221a1148b7bmr231152995ad.37.1740449109648;
        Mon, 24 Feb 2025 18:05:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS)
Subject: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
Date: Tue, 25 Feb 2025 02:04:47 +0000
Message-ID: <20250225020455.212895-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4.

Jakub recently commented [1] that I should not hold this series on
virtio-net linking queues to NAPIs behind other important work that is
on-going and suggested I re-spin, so here we are :)

This is a significant refactor from the rfcv3 and as such I've dropped
almost all of the tags from reviewers except for patch 4 (sorry Gerhard
and Jason; the changes are significant so I think patches 1-3 need to be
re-reviewed).

As per the discussion on the v3 [2], now both RX and TX NAPIs use the
API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
correctly elides the TX-only NAPIs (instead of printing zero) when the
queues and NAPIs are linked.

See the commit message of patch 3 for an example of how to get the NAPI
to queue mapping information.

See the commit message of patch 4 for an example of how NAPI IDs are
persistent despite queue count changes.

Thanks,
Joe

v4:
  - Dropped Jakub's patch (previously patch 1).
  - Significant refactor from v3 affecting patches 1-3.
  - Patch 4 added tags from Jason and Gerhard.

rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@fastly.com/
  - patch 3:
    - Removed the xdp checks completely, as Gerhard Engleder pointed
      out, they are likely not necessary.

  - patch 4:
    - Added Xuan Zhuo's Reviewed-by.

v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastly.com/
  - patch 1:
    - New in the v2 from Jakub.

  - patch 2:
    - Previously patch 1, unchanged from v1.
    - Added Gerhard Engleder's Reviewed-by.
    - Added Lei Yang's Tested-by.

  - patch 3:
    - Introduced virtnet_napi_disable to eliminate duplicated code
      in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
      refill_work as suggested by Jason Wang.
    - As a result of the above refactor, dropped Reviewed-by and
      Tested-by from patch 3.

  - patch 4:
    - New in v2. Adds persistent NAPI configuration. See commit message
      for more details.

v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fastly.com/

[1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
[2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/

Joe Damato (4):
  virtio-net: Refactor napi_enable paths
  virtio-net: Refactor napi_disable paths
  virtio-net: Map NAPIs to queues
  virtio_net: Use persistent NAPI config

 drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 27 deletions(-)


base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
-- 
2.45.2

