Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3919D06B
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363642; cv=none; b=vDHM51UXxSqhmbc5EJ0ayUtgcWdOUNckedr9pjBkD9isEt6ruHlcU75csRJtRI7AMT8LI5L3wvbsgY+i5LE8LWgff9LJq5ZeGneuTXY+L5zK/VjNlsyiNuNP9y4SyBrHjhVR2ZFABWRO8BjPR17PXsB7hdaLM7NdPwrDZHXwy6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363642; c=relaxed/simple;
	bh=qcajYeuzQqig2Pw2OjJksSWvVLoxEiTtaDCHiGYHL/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FiUJ4hBjrGoidcdpm9NWFdkk/1Y3+RRv+Z7cS8zgdXKXyrnvWRAP9c0talfyXX+9f6b2rBMBUteAemY0L/oWXho/LG9D0T1H0xS+gcJl5DKcFi96HeYKfyH8JJKzsnbLMqNwCwmlkLwexq5lYmlI/ztYqKOBi2+3gwtKqGok5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=1o8MsPW3; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="1o8MsPW3"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E04BA409BA
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8gboulfvGo3 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 09:00:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5A5CB4099F
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A5CB4099F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=1o8MsPW3
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A5CB4099F
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 09:00:38 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2166651f752so99338345ad.3
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 01:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737363637; x=1737968437; darn=lists.linux-foundation.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M73wUmCTBGNSLAfxRhHe8Rnzzifp0+HNyWyW7z7nYBg=;
        b=1o8MsPW30kAjC96i4Tyay3HITK6aR2Gp9sHUvx9l7SJHYq5QS7l1gahUDq5i6eGTSC
         JRxXhN7JdIrY82dkuHrbxYXqH6gG5NZOxJ5O7DZ3UIHVcGigsY9hVdpobMTspkSBMLDU
         KnRIVjAwcVeGjRGm/q09Z36aLCqR3iIH3JUw8pBpA26dkGByMsWZOfsN1jLKLbm9Xr0W
         6TPH1Td9SpP+M+SZ6bdfPIL8JSu6XzGH4VULqJV1S9hkkOh/4Zf/MG32Dk9Ln8nZ+fAo
         97CkMRaztGehriVbYPce4QIiJw6VnBEmWJ8/y1vO8AGUPMNK+6pG6J5efQDdh6bqasir
         G1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363637; x=1737968437;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M73wUmCTBGNSLAfxRhHe8Rnzzifp0+HNyWyW7z7nYBg=;
        b=Y7VwBw8SDx8gk3h67OGd5WTIzA4FzkPf/GF9GP23gq/F/FTwVxb6JpnYcQCkptUsDH
         tNVv7fJdDkoyo/KVG1QJPN1jJcsb/I+HhYfWbb7S7j1xQwY5ZRP5zKg68TVeFHLcu9vb
         uB0UfGk9v36r3Ml8eUog0mqV5+xtpEU7nEsxdrlatH0OmrcYnu6koHIBfO/LSroVdKbi
         gNuQ8FHeUZJRNc3VqtrdUOJRwBBc60dyVNLT5qe888zD6SAG3FV9cj9k9kDeQwJcDutW
         23YQbERU+GMWET5q0fF0FRcyiWClaqceMU5RX3NAYhE+kPD5Hi6w/WvI5LQphQBU0qYj
         98pA==
X-Forwarded-Encrypted: i=1; AJvYcCVUrFW8f4hkpR0eG1SF67uL6DKd6CKBQsB0muti5AH3X2ndMELNFtq9H9PKBDLW04rMr0TKwxejr31cmQ0PjQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzGBVtznaeKx7Me9fk12+O9f/mBeZ3jmjQUyQkJjtrHbwDopOuA
	BJ+tbTpEnkTsQ2w+AUeg8UTiS//mgW1xE/T67iKJAWSSOgnej5C6PEvA7JysUF4=
X-Gm-Gg: ASbGncvDhcNIvLdKl0yugcpZ5GHz3BfiHblTbVWn0S7md8lQWqWBceddNg8oJoByNFa
	CXUaA7H/1OJQWMCedHzZbPxLsbcFLsQj+pr4OQ36TTVv2FGCrowtW7JkdsYi542GJxeZITPxFgB
	ZzCK1vJTknWpmsz48uSMozy0VvCDfb1N0ftxg1mnS9uaSFGfbujCN4kjp+BI+dIJ33BwBKwRwHb
	VMsiPJeaftMo4vVSAyHKRaobMCLq07FkQtU+kF55PtD13zGvqwBwrcFcRHvgXpzUlCOn549
X-Google-Smtp-Source: AGHT+IE1pLyS0CRQUGICRpfL+cuS6Zd8b3NmmH3IRRXgasWGxiLbxjOpEsY6IBDF/xH/j3M5fZzgCw==
X-Received: by 2002:a05:6a00:802:b0:72a:a7a4:b4cd with SMTP id d2e1a72fcca58-72dafbb61bemr17694966b3a.21.1737363637519;
        Mon, 20 Jan 2025 01:00:37 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72daba44453sm6487254b3a.127.2025.01.20.01.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 01:00:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v4 0/9] tun: Unify vnet implementation
Date: Mon, 20 Jan 2025 18:00:09 +0900
Message-Id: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJkQjmcC/2WQyw6CMBBFf4V0bU1ftMWV/2FcFDpIFxYthWAM/
 +6kbDQub+6ck9x5kwlSgImcqjdJsIQpjBGDOlSkG1y8AQ0eMxFMKC4ko3mOVGvgzKmmZZ0hePl
 I0Ie1WC4kQqYR1kyu2AxhymN6Ff3CS4+mmnFmi2nhlFFtvLGqlUoadfbuFcN67MZ7ESziG2p2S
 CAkrfXG105Y4/4g+QVxvUMSoU63eM+hMb35gbZ9RYLnjC/I+5Trtn0AjlRLryABAAA=
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
 drivers/net/Kconfig    |   5 ++
 drivers/net/Makefile   |   1 +
 drivers/net/tap.c      | 172 ++++++------------------------------------
 drivers/net/tun.c      | 200 +++++++------------------------------------------
 drivers/net/tun_vnet.c | 184 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/tun_vnet.h |  25 +++++++
 7 files changed, 267 insertions(+), 322 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

