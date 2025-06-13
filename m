Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A324DCF9
	for <virtualization@lists.linux.dev>; Fri, 13 Jun 2025 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784329; cv=none; b=Bn3MUCvfAZovhsopxUSdX0sAOwdJsamhcolkRbYwQyHppNdkfoyOrl7gNN+BY1rtvK9A8W8y96rBlOo4L0cw6ZzzjnGwSXZPCvUbCKzI5+UwCpnbYDjzBLXANdKzYUOYvdnECnS2QxRFv0Fx5qQ1kL4DChhhYq9a9up3PYh+pc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784329; c=relaxed/simple;
	bh=8vDZCrVqGSpvB+A9Uufa93gUzdJNJe6C92j12YvonB4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LzLOx+iZQiItC+YXi8DhfwBVM99+yNiC+3WLIImypOAfsJyVqVHj3P/W8/MApgoBdoMuGW6/5m8YxIrToP2IsOCrTgKsfl8tS3RUc3xqeMxHEDtSG8ej3NYya3S6VPPmXxltHMy7KkAUwNTcTbyABgSIGidt6lKPBl9T9t5ezf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXt05ks5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXt05ks5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2351227b098so13882675ad.2
        for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 20:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749784327; x=1750389127; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvQMCmLVoexZEbAMVw+cxcVxwTbZmJeFmGnASyg8vqY=;
        b=AXt05ks571Dw1zfJGL5ROCdzrOwUpGscapHc+RnruWSfHZ+Z+0mVcosep2kRjlMgI1
         yJfc3yvog6F/SMO3hPEY9heXbPvxlULvhlDnlbup+7GSBh8dVC4VsF8mTDfLbiwcqaDH
         3XRD7opV40ABJgjtV+cuphnLbz2qcu/Ek4yGJTgYajOJzEzBj33vPAQ7/VKg9CwWMHep
         OmiyC+7flkA9KnxhBeZQQRVYe0JW6fJ8HUdRwCuOIZPmo5yobXBRZ/cGl4yvzANFZWBy
         7lfMkMaz+JUZGuBWdnwvmPFSogYPyntJ7M7js1O7zXZ4jsiVXxnfEOF59PaCH60ABkTY
         3ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749784327; x=1750389127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvQMCmLVoexZEbAMVw+cxcVxwTbZmJeFmGnASyg8vqY=;
        b=H/AnXycIG5+XatY3KFXRQ8Dgo2tk9owwSMLMpQxnjVwvwUch5YC/hSuEM5KYVjH3Hk
         NsXvuNbXkoguQJ1eFyEcV7t2Y9pTt358FhbLeL2cTGBk2WisaLHFsY2R62duDRL6g1cG
         R0BbFkE/eEaAv6htxsWhYM0LZ6sxwfXyjyybiqmKgz+lH1WOvrsAaZKZCkWFKKBPsseN
         0jqW84FdsegWtXtS2f51IJQMfat53dAt6+vO8BKzHyKt/Y9at2mOcZ3y3M16MfyyR6hx
         HNAaUN6Vylfn08MExgbobYjEAE9Y8+OrrnYRtl8vtjVYSZ/81Ws6mGrKOYyGf+JMcBl6
         u5OA==
X-Gm-Message-State: AOJu0YxQ0bMWom6oHXrybt6i9EQtXP3ISyiFzanelXSrBqmCPwq2H6ST
	JmgiWUR8Qy+e3uUlwyDa1L4P624pPbuDOK1f2On2R4Bo6g7DY1cMCowS
X-Gm-Gg: ASbGncve1pmILVoLUA705zbrlj1kBH2IhoCfpVIb/4L7swJIn9lEN/DrAQJPP8CiX8N
	0kOULNxNiafqpVh/g2dN6oHvpqL08+6+6NprM2vbafQdv35RC+T8ZMb4UKWHGGogztt7Gj19TFU
	CWXgaTVZ4T82IeiurDN4mY4fV8SSY1/qcI/mvAMrGTsJyNEPphwNSt3QzHRX/P1iXjxjtgLosb5
	ufKhAx/7Yfv9Fuh0LpNPVe/HLP8CHS2xukT8M0Lji8HjtAO0yoriA/dqykBzupuwPgRiONA5Jqk
	36KYJgq/JxeSfup9y+cqNKQmZj1LMOuJCGZVjh5uXksSBDzcbOodyx2Bf4KB/n2yyMnPwfB2DCW
	Qr0saM9KS
X-Google-Smtp-Source: AGHT+IEWDr4/2rO+qFnFyPkG4l6WRFZhlQHqkd8lc3GlzWs2YR06IinaIb5kW1nJVC9KS1xMri1Yyw==
X-Received: by 2002:a17:902:e547:b0:234:a734:4ab1 with SMTP id d9443c01a7336-2365d886a50mr18462605ad.3.1749784326668;
        Thu, 12 Jun 2025 20:12:06 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bcbb39sm2291801a91.8.2025.06.12.20.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 20:12:06 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v2 0/3] vsock: Introduce SIOCINQ ioctl support
Date: Fri, 13 Jun 2025 11:11:49 +0800
Message-Id: <20250613031152.1076725-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces SIOCINQ ioctl support for vsock, indicating the
length of unread bytes.

Similar with SIOCOUTQ ioctl, the information is transport-dependent.

The first patch introduces a new callback, unread_bytes, in vsock
transport, and adds ioctl support in AF_VSOCK.

The second patch implements the SIOCINQ ioctl for all virtio-based transports.

The last one adds two test cases to check the functionality. The changes
have been tested, and the results are as expected.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>

--

v1->v2:
https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
- Use net-next tree.
- Reuse `rx_bytes` to count unread bytes.
- Wrap ioctl syscall with an int pointer argument to implement a retry
  mechanism.

Xuewei Niu (3):
  vsock: Add support for SIOCINQ ioctl
  vsock/virtio: Add SIOCINQ support for all virtio based transports
  test/vsock: Add ioctl SIOCINQ tests

 drivers/vhost/vsock.c                   |  1 +
 include/linux/virtio_vsock.h            |  1 +
 include/net/af_vsock.h                  |  2 +
 net/vmw_vsock/af_vsock.c                | 22 +++++++
 net/vmw_vsock/virtio_transport.c        |  1 +
 net/vmw_vsock/virtio_transport_common.c | 13 ++++
 net/vmw_vsock/vsock_loopback.c          |  1 +
 tools/testing/vsock/util.c              | 36 ++++++++---
 tools/testing/vsock/util.h              |  2 +
 tools/testing/vsock/vsock_test.c        | 83 ++++++++++++++++++++++++-
 10 files changed, 152 insertions(+), 10 deletions(-)

-- 
2.34.1

