Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0401B3955
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014917; cv=none; b=pEm+NRXvXfZAHDtG51cf1pJQXrkvua6KzbBDgd0XVsy2b+sTN6R5siWbeo2Ig9yQWp+E2kvOcY7wqQhR6ENHNLcd28LZZiT1yy0gY7Epwc0tvfT5b+RnpHjqa5+tYD8q6VYiIpQdSluH6m4ELTR+Xmgr0Epba+eQTU7xoxzdJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014917; c=relaxed/simple;
	bh=+CC2205P/4QjZOTULtxLx/pTHHo7ousX5VpLNpbUGG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=EOT7DMq9pTLAEKyPhf7u12istAMXYzBWQLK7YsjGtJfo1cBCcHHDPSUj0V5d/v0zZ9wLqts4f3YRpOEgoPkQLnV0nGHiT4s48dPXJzNhfDfOcwaBeJOiW7svwg6KMqMeHJ8Bpdz1k3K3V3zlCe4+zeSZxNF954LMiq1wLItJLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=jjJzeaIS; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="jjJzeaIS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C8F46FA41
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OI4Z1oXYtvwR for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 08:08:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E41D36FA3F
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E41D36FA3F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=jjJzeaIS
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E41D36FA3F
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:08:32 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-21661be2c2dso10236295ad.1
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 00:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014912; x=1737619712; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvSgzzLjp0cbfCfki4o3Cp/OkRE34mhTHVsplAbYOvE=;
        b=jjJzeaISZmqAY7wNOSbBVW8SJZubsWPIrlqqY9cC4pNAHYsL4ZV4B5i62m/NoWdHsP
         EExeJSbRBKPEFNqGSJ+rkgRDsqHZZrZBkgqipanRr0IiHhVzSwlOaSsb4dSyzqFrodyQ
         8U7WRKwqi8gdX2MoQqCJW7T5JuwazlRiw3MYBHEzKcSKrtlQguzgq4S6HuYlxYPOPmaF
         W2Prkpo1ibm1hdr36M+DcWkZbKE+5UHZRbbPGZ6ttBLhOFQHThxO2RcPUn77MI8y0ZcW
         YEf8hEQXbBPN+T6ogO+RF+KN5jHNViQbt2RX7EAhA4eXedNgA5Rsi5gr7bec5n9gbZ6z
         XNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014912; x=1737619712;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvSgzzLjp0cbfCfki4o3Cp/OkRE34mhTHVsplAbYOvE=;
        b=OAkGoJHI+/z1ZhzrgX1tXSVYHZh/3YoekcgMJ/Dd69SZ5ieeaUAkcbj+xPkqVooaIv
         WTavc/yZJXSR3DO5THRMVUw1NVCORKaoFNbjvtHGZkaIadVJGEBgYvMze+tqKs8k8n+C
         8/YuZL+dBWcIFh+ElJAj72xitQ+rqUAz6WJUh40jvRzS19wSudGitjEJAwTbzEql8rm5
         ojFit6F1Uqjtu47zWnD6+fQbXjBlcfgVo6UN+pydZPkgAiyVhJSl1JQW8S1VX7OAYqBx
         G9+A3y2jiZ2PIeSlzOMnNN1h2L9/RG2EMdsuZ+Q6bc+7Cr2lR2n/Kh41QzIWcEZD6+IH
         Ez2g==
X-Forwarded-Encrypted: i=1; AJvYcCWopqz3IhIMX/PfUJdhU1hQnpMC4S/4xE0lehEPWAzykTcvexVu0HmTkB2EWcpPCh0jHjfd8en4pMRxxyxJJg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzJsK/Ukf0lKk+BKdwdmxY+8yyTI9FPNxX+FKtn2pb5VAiISs24
	NyZT+FtZv/M3ss8Xex6z47J2N52b6sEe5DRl4DEVGYGlktvDA+Mwhl/ND452arY=
X-Gm-Gg: ASbGncvFx2lFf+oXyN7iFqshIWdSpRbyI/rVzl+cV7tqUmNuz6EdSmVLwJAzo/MnIev
	mXTnoB+B4HyjJ/UzyWIgPmeutT//jhfW6D51Gw9mTpwYopms+bH3tNzU19DCu191ITYaqiatMIe
	LF52S2t1ULRYqCbUHxU9ZmDkMgAwz4AGcbYw607u6nThpopQdGHZWtySiq26y2sGVBYUJdZsPr6
	A7WJqJhSX/qQLZo4GI4BUhIk0rx25UgecyMnt+sFuBihJra2K+1OEgoGM4=
X-Google-Smtp-Source: AGHT+IFRLQCwktjyooiJq73WQ5ddpyLIN010dTt0KbqmXVNLbU3CCPmJHJQ7IqxozW/WCRUUVDqOaQ==
X-Received: by 2002:a05:6a20:6a25:b0:1e7:6f82:321f with SMTP id adf61e73a8af0-1e88d10749amr45114735637.17.1737014912054;
        Thu, 16 Jan 2025 00:08:32 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-a31de807786sm10985666a12.76.2025.01.16.00.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net v3 0/9] tun: Unify vnet implementation
Date: Thu, 16 Jan 2025 17:08:03 +0900
Message-Id: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGS+iGcC/1WPyw6CMBBFf8XM2pq+oMWV/2FYFDpKFxZtC4EQ/
 t2mbHR5Z+ac3NkgYnAY4XraIODsoht9DuJ8gn4w/onE2ZyBUy4ZF5SkyZO6RkaNbDraK8iX74A
 PtxTLHTwmaPNwcDGNYS3mmZVVllSUUV0kMyOU1MoqLTshhZI3a1bvlks/vopg5r9Qc0A8Q0Jrq
 2xluFbmD9qPLgE/U34kHYXaff8CSWeB7uYAAAA=
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

When I implemented virtio's hash-related features to tun/tap [1],
I found tun/tap does not fill the entire region reserved for the virtio
header, leaving some uninitialized hole in the middle of the buffer
after read()/recvmesg().

This series fills the uninitialized hole. More concretely, the
num_buffers field will be initialized with 1, and the other fields will
be inialized with 0. Setting the num_buffers field to 1 is mandated by
virtio 1.0 [2].

The change to virtio header is preceded by another change that refactors
tun and tap to unify their virtio-related code.

[1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
[2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Dropped changes to fill the vnet header.
- Splitted patch "tun: Unify vnet implementation".
- Reverted spurious changes in patch "tun: Unify vnet implementation".
- Merged tun_vnet.c into TAP.
- Link to v2: https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com

Changes in v2:
- Fixed num_buffers endian.
- Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com

---
Akihiko Odaki (9):
      tun: Refactor CONFIG_TUN_VNET_CROSS_LE
      tun: Avoid double-tracking iov_iter length changes
      tun: Keep hdr_len in tun_get_user()
      tun: Decouple vnet from tun_struct
      tun: Decouple vnet handling
      tun: Extract the vnet handling code
      tap: Avoid double-tracking iov_iter length changes
      tap: Keep hdr_len in tap_get_user()
      tap: Use tun's vnet-related code

 MAINTAINERS            |   2 +-
 drivers/net/Kconfig    |   1 +
 drivers/net/Makefile   |   3 +-
 drivers/net/tap.c      | 172 ++++++------------------------------------
 drivers/net/tun.c      | 200 +++++++------------------------------------------
 drivers/net/tun_vnet.c | 180 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/tun_vnet.h |  25 +++++++
 7 files changed, 260 insertions(+), 323 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

