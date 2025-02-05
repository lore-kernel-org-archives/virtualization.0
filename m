Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E56D21E085
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736556; cv=none; b=jdpoQ6HGrLjR1aPfA/CFDytI85YjusMSdRJfDBrPe37S6TqVFEab9MIz3K0wTzQBlc07VeoVog/G5rh9sYn+PIiwzbJ24Z6JmjSz3MHn9ptKU2nVLfpgSCQJdGkwmW5ugbcPEfN+3ptgU54I0N1uYa401/634luDIg5F1fL2rXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736556; c=relaxed/simple;
	bh=8WDHU2a8o+TvYU7S89Oev00JE4W0USl7Pr/i42Ilkw8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t3CUUBi4WZkiOXM6VpaVz0C2ucH5d9cU9FbUSPnPQ2tc26WhkW83bQa0+VDAl/A4+qClxZhJY0fPkzuxDUJmODME1tIhRtoQfMu3PZaxq6UNwJm/APXX3x1HSae6hIqAjr94kAGrNW+FZl6xvvOHP0G3z0lR2ZDdHBzngRm1acM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=s9HMn8ci; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="s9HMn8ci"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2430882C7C
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNqD9MnavY70 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 06:22:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C8B9482C2E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8B9482C2E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=s9HMn8ci
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C8B9482C2E
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 06:22:33 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-21f0b5d6c6eso7147745ad.0
        for <virtualization@lists.linux-foundation.org>; Tue, 04 Feb 2025 22:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736553; x=1739341353; darn=lists.linux-foundation.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+wOXEQBExe63vCNTctnNxequJPweHzEdNjWgMgaz30k=;
        b=s9HMn8ciq90UEMFPEr3hOtkWQcjzqS1IipDPdhtltKmM748nVRHemVjSIfhUPddLCk
         HTi1JqF032GMKYhxZZV1GqWtmrLaO/hE/fdv0Q4CLSV9/eO48ol/8wq6oJZZRl9TkOAm
         Nrx9n3rTJ8tbgJC5zBuh4f9byN9vipCqNGAsDLA/RSaisZKycl1r6uADrVBnt7NJ0CfG
         LeDnRyNGaokb2BiQL2ibnMBBfLmwOpN90kYz8N+jeMMaitZgR+CbNJdc+ApKajoFgVu8
         dMGpDK+XGVS1ZBY6v0kyaCd1ScYvslIPBax5ME51TsBxXjbibv9kYazeMf/vrJ/yD1Gg
         dOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736553; x=1739341353;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wOXEQBExe63vCNTctnNxequJPweHzEdNjWgMgaz30k=;
        b=aqCg9XT3PDS2exVBBlgOQwjkUhcQAcB5x+Bd5uI48Zh8T8g/ivXoacWQT0tX1JIVRu
         kC9wqKV7OIfjKa4SkdFIJRuVkpnqg13AOgEi2dgK/NxXphspC5YDJl2oiraDBOQJm5T4
         TfysJwEtxxGZf9PL4m9rB3L8RTyPFyHnmATmdIUxEpb1Py7/R2hLRAE3qfadz0+pzNWz
         mTVAAvdkqNSAYtJaD77WZuN0T4sTkfzsGZf5W3b0wJqEYYTzFK6ZXRWlqpf/JXf7AWdW
         vr6crXEADK/7my3hknJ0Czs3oKWYt9xIfxwXk1iKLy/igLlo/G0D+j784gWNZXpI9aa2
         Xe2A==
X-Forwarded-Encrypted: i=1; AJvYcCVMeeoOU4xOaMYMmd2UZizMClQreIbRcSLXVxZ+4EhCTNb5EIzbboOMECVhLqy00zLb+EkU4sMNjATE3C0FVQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwZsNi+JxgL1Bmfg5pWjW+QRNdo/4/liL09YgWJoYWcLrSfZlTs
	baclxd4MQRRSRQmETow9AE/gk9SYmHIg89b8fUhm9AU5ZcPNXL7Q977T/l7mRSo=
X-Gm-Gg: ASbGncvOFzJXPX5BCrUkR6OBTVbRdmkGlA2mR0Z01OFOZtSACpb11exDpSSujH34LMF
	+3jL06X+Mux035Tkg8/B7RRWQAl46jwL2P9Tl7oU5TcS+txeAyiVc4BJzjAc8SUUv76tlGyz+jh
	CHiz++z4yb+M0+N9oaJVVIPyafIoKNekskk1Brl9uXAgnUPdVwRVAkKlGBYYaci9KEotA4ppdR3
	koSs5Ks7RU9E/t2LNGi6uQohdT2PVWvE7VXRg0g/O1MOLKNc6YIGKnm9LqSztEfcSYLtvLZ+ZUm
	PSkLJEpHwyxBD5KkMqo=
X-Google-Smtp-Source: AGHT+IG21WhSzoCJIvm+AnHNi/NgJ8H7PS8WPvT9Thipit8jAsTx6btg48nfdeJxttEXxjhIUHpDhw==
X-Received: by 2002:a17:902:da8a:b0:21d:90d0:6c10 with SMTP id d9443c01a7336-21f17adb5c1mr29744745ad.23.1738736551500;
        Tue, 04 Feb 2025 22:22:31 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21efe2eb4dfsm28940985ad.124.2025.02.04.22.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v5 0/7] tun: Unify vnet implementation
Date: Wed, 05 Feb 2025 15:22:22 +0900
Message-Id: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4Do2cC/2XQza7CIBAF4FcxrMXwV6Cu7nvcuKBlemUhVYqkx
 vTdncCmNy4nM99JzrzJAinAQs6HN0lQwhLmiEN3PJDx6uIf0OBxJoIJxYVkND8j1Ro4c6of2Gg
 IXt4TTGGtKb8kQqYR1kwuuLmGJc/pVeMLr3tM6hhntiYVThnVxhurBqmkUT/evWJYT+N8qwFF7
 FHfkEAkrfXGd05Y476Q3CGuG5KIRj3gPYfeTOYLqR0SrWhRiAAs994x6c30D22teoLHE/+WW//
 Ltn0AgPpSa1UBAAA=
X-Change-ID: 20241230-tun-66e10a49b0c7
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
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

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
Changes in v5:
- s/vnet_hdr_len_sz/vnet_hdr_sz/ for patch "tun: Decouple vnet handling"
  (Willem de Bruijn)
- Changed to inline vnet implementations to TUN and TAP.
- Dropped patch "tun: Avoid double-tracking iov_iter length changes" and
  "tap: Avoid double-tracking iov_iter length changes".
- Link to v4: https://lore.kernel.org/r/20250120-tun-v4-0-ee81dda03d7f@daynix.com

Changes in v4:
- s/sz/vnet_hdr_len_sz/ for patch "tun: Decouple vnet handling"
  (Willem de Bruijn)
- Reverted to add CONFIG_TUN_VNET.
- Link to v3: https://lore.kernel.org/r/20250116-tun-v3-0-c6b2871e97f7@daynix.com

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
Akihiko Odaki (7):
      tun: Refactor CONFIG_TUN_VNET_CROSS_LE
      tun: Keep hdr_len in tun_get_user()
      tun: Decouple vnet from tun_struct
      tun: Decouple vnet handling
      tun: Extract the vnet handling code
      tap: Keep hdr_len in tap_get_user()
      tap: Use tun's vnet-related code

 MAINTAINERS            |   2 +-
 drivers/net/tap.c      | 168 ++++++------------------------------------
 drivers/net/tun.c      | 193 ++++++-------------------------------------------
 drivers/net/tun_vnet.h | 184 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+), 316 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

