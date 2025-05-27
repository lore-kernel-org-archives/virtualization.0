Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694227B500
	for <virtualization@lists.linux.dev>; Tue, 27 May 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362770; cv=none; b=pT085QEGve/pQMWp3zG0i/V06GNPx+G177x1vQnHos+VN5lGOZzJh9sQA5GO6a+g9/opSCKDaWlwRJhXjUZW/a3/tTp/Z2zVr+QitTovXUFR2y2Wgtdfob4eIkBq20IqYHerHcih9eTCxBbUkQfSDOiba2EONIK0KHHgMzR6kNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362770; c=relaxed/simple;
	bh=MYkd9moW5U5NY01cRCmj+VZ39AjPIlCw1sHRRMBFGIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOdHeQzavBcTadlSqKavzy6ZKr3B8Dwjj+0txSkUQY2sxSuS39Nqj4hf/g/3G+kShMGNpUE1naYTJk32YsLkCRYAhVym81LGiIm7vhZOvVjONVVFXrvE0gMW5BiVFaGSJvso9ACyVswddlkoj+wDUBvVHFr08F5U3YKTZ5sYa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpCmCFkz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpCmCFkz"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c5f3456fso2807083b3a.0
        for <virtualization@lists.linux.dev>; Tue, 27 May 2025 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748362769; x=1748967569; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbK8myrrInjlPOn0ULLUSRCNxSgmfdtmIhscGDFMnz4=;
        b=IpCmCFkzTgsCP1oo2PYXQHGr3iE6mMMAh5Ky09JzIWhi/sPtdvBMR3zE2YjC1zLGM5
         C/Cf6eLzhfVBaPRc1WQNEug7Y2LoaKDLl4a1MhU3VNNk7rndPNVfa/yShe2+0rkBRkDM
         msZ9mdql0LumasAlf8CwEF1j1UhZ8B3tOiM8Ei7ehO38+shJVb8saztttsoV3mLSgq2q
         NJSsYpAJwETFxarsW8fqvEhKrTrOTEVdQ100hUjLRfZxKW5I9EphMKLWhqwXOSpc9ydD
         Fm29wGtYL3T90lF4nXiPnywWAWAt7uB6NusLl8MciKFetJz6fpkJyBw0kWg7aDGf/OFC
         gTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362769; x=1748967569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbK8myrrInjlPOn0ULLUSRCNxSgmfdtmIhscGDFMnz4=;
        b=wVvsricSywR+yR82somCMl3OLvT8FtWafU3ueKEcZUDZioclyxy0+Hu2VINhQNxVEF
         0BNZnat07VTYUcuc7T0E0JK33cvf7tTjqd4e6QvzDY0Kq6KXdUH82Sg3ZOKkZ6V1Exhi
         dq0H1Bv1rYw/O2X7nlV6MNdy9vFcJKwD17+SAv6QuoD/5WRZONc2rdxrz0x9NFr86eYI
         OJXifqz/C8kR1xRZN9+TRNfGB+GtvB734jdj4ZHJV0upoNQuJvAfz8axP1A9mT8C3Q2e
         V7j2xecbiA9FFySxrT3B3GfexmoNpkWtHYRyQApKNRbc8PEqfUSizUmP52lJr9XL5425
         9d1g==
X-Forwarded-Encrypted: i=1; AJvYcCWuuYA6jGdn3lmW/ecTPAW8NcijkC234ugyzvctVg/r/tgVmX6NqhwbeCrpmnR+dOeRvuTC/AcWTuEgkkDOxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ82qRLWJXOeQr0G1zh/HF8g+MjXn2ceDneIBF2wKk23CKjb+K
	pD7WyR51fX4Z2xxkxav6NChjVLQ0Fg8lFpz1+4D8qvMAvfO7PAC3/B4j
X-Gm-Gg: ASbGncsTknz1FXuvFUkdcbAeNWsSzU9hl9jncffKeuHchVtnswO6f0GZyohfwYEnrNa
	G8zA4poNP1oK1tYQSfq0rHIxnElqm1ECIGmHUKd4ighqoLRtx3EY/oRZhOxaP8uVGIVY+2T0r/q
	yZDObQtpVxtMk1jfGP9J2MFGroqEDfPO6W3ED0dsSoMcIETJgrF9A8UWjWNmR/Dz12SML1FVbF8
	0eAGboU5Te7uFYAZ56Rz1GOPUaKT81BtIYSLaBBiV+Z7OJt08OohwX+6zl/emj5s66c7L9u6suF
	gIeZp4Uyq3wvshHWhQaeXMf07mU7edGIw1NEeFYfb8ENWeF0GenExu/VptjQJRBeSejsJXzuAod
	Uno80ok3jWYJI
X-Google-Smtp-Source: AGHT+IGKmD2Zh5VhkMaiEIal6sHXDxc0tkPGQBPjYF8Im8Ox4Lf/IgC3904Py2SWs7grtFnUZ9zcQQ==
X-Received: by 2002:a05:6a00:1747:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-745fdf4b8a4mr20489480b3a.12.1748362768405;
        Tue, 27 May 2025 09:19:28 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:52e0:fc81:ee8a:bb3f])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7462aefb414sm1118121b3a.34.2025.05.27.09.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:19:27 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [RFC PATCH net-next v2 0/2] virtio-net: support zerocopy multi buffer XDP in mergeable
Date: Tue, 27 May 2025 23:19:02 +0700
Message-ID: <20250527161904.75259-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, in zerocopy mode with mergeable receive buffer, virtio-net
does not support multi buffer but a single buffer only. This commit adds
support for multi mergeable receive buffer in the zerocopy XDP path by
utilizing XDP buffer with frags. This happens when the MTU of tap device
is set to 9000 so that a packet can exceed a single XDP buffer. As a
result, that packet will be split into multi buffer XDP.

This series also adds the test for virtio-net rx when an XDP socket is
bound to the interface. The test exercises both copy and zerocopy mode. We
can adjust the tap device's MTU to test both single buffer and multi
buffer XDP.

Changes in RFC v2:
- Return XDP_DROP when receiving multi-buffer XDP but BPF program does not
support it
- Add selftest
- Link to RFC v1: https://lore.kernel.org/netdev/20250426082752.43222-1-minhquangbui99@gmail.com/

Thanks,
Quang Minh.

Bui Quang Minh (2):
  virtio-net: support zerocopy multi buffer XDP in mergeable
  selftests: net: add XDP socket tests for virtio-net

 drivers/net/virtio_net.c                      | 123 +++---
 .../selftests/drivers/net/hw/.gitignore       |   3 +
 .../testing/selftests/drivers/net/hw/Makefile |  12 +-
 .../drivers/net/hw/xsk_receive.bpf.c          |  43 ++
 .../selftests/drivers/net/hw/xsk_receive.c    | 398 ++++++++++++++++++
 .../selftests/drivers/net/hw/xsk_receive.py   |  75 ++++
 6 files changed, 596 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/xsk_receive.bpf.c
 create mode 100644 tools/testing/selftests/drivers/net/hw/xsk_receive.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_receive.py

-- 
2.43.0

