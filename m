Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585D16DEB1
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908665; cv=none; b=XWU0El6c1XYZ4Okv+iI24P9bD6z4pj8nIoNKdSv0vNCHmQkVhaFJVjTS7lIbtr2kjo60RdGLQ5vDH38g2iN/UykiXEZdICvLwKqS0TY2GFIFgnN9/9Amp1e/2k538aAaLVhVIdLA2WLsKy9jzRKgFSsvlaH6SnvKHKcqs7GHhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908665; c=relaxed/simple;
	bh=luM/U1QzNcfOEe8jQ4dOzHmGDvHwvg9P0neXpfs/o3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gYaesMHt8FfkhyY7ZcA2XdYgPl1lzpCFJsMxT089dhoOx4fx6nmgEnmqB7KqwPpJoPXc8XFNvlXgtM53U2TdssK4+F8aBcYn3hmTqAWapjDKoeeM9mZy09QxXI/Fvc6ztJpTcI3rkPS6drFqmzwGvIHnHe9vwTcjnpHul7D0bPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=atqE8d2U; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="atqE8d2U"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D65BE83661
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Xbqj3-wYAMo for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Feb 2025 06:11:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2AC01834F2
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AC01834F2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=atqE8d2U
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2AC01834F2
	for <virtualization@lists.linux-foundation.org>; Fri,  7 Feb 2025 06:11:01 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-21f4500a5c3so24630225ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 06 Feb 2025 22:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738908661; x=1739513461; darn=lists.linux-foundation.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne/1UeulZde6sbRY8ZM9PE1LYrjRUVoPX8w/HsO/eUQ=;
        b=atqE8d2UvxtlIuYD826lP48dxSWdZ8YmdPm3e4QuvCrClOLI8lLDU2isr4CMwlUwWw
         5vtbe+QYaVBh5jOEIhLVNXJ52X9BR7ekNruyNPjJ0ye86lLmIIYNHkFPZSzzl+prAo4C
         WIuNHp9HtT4i0YwCYMPemqqnQacK1JZo1+z7iNk5tjZX/46PZ7nzBZcoPLWKT4PfSXWa
         VdfiOKuX6W3RmDJ91cKpmmqyg/5eyT7ewkxwWbhBwzBPMTmvEINa7luNOVqyfae6kqFO
         EWJ0zkEzTM7dMKZioWgIBoI3gk9LS03/ZYLHvMGtFaDtb4jFFXwu3nIz0hV0Pajc2AmJ
         tuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908661; x=1739513461;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ne/1UeulZde6sbRY8ZM9PE1LYrjRUVoPX8w/HsO/eUQ=;
        b=joosctgITnGdHrgwkjQ+OvfCqPprFysHPCTI0R+92RL+97c/Z+vxgPwxgYAdNvXsu0
         z9Ocggbvmy8Cu+3us2ltdVxe4MJj51LBkFK4IOLvhNWSleHYTAb2yIj+eRlru11oVNFJ
         e71ZPIBb/M9Opf1BDdfMnQUyT2IFL5ySZV1p5A7m/yaSHpSX2RCeQMEDnnY+tO5vHHfh
         Xixs0gUqraS/fuQrlaFcJ+BqaOTrDm66sF8UvvSoypq3jE6jt5dNMwLIkphi+JYfKRlC
         xiL8IPTIPTeSFTnWenO/1Ki8vrivvmpldK/fldoBMNhhXklgqNP17zBKwXHfhWAQYAv2
         atwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXSlwGqtkJttXn3ViRZSWSIl7JHgm2w3HF0r6TMRjihIva7tU1npB8cpH1YnAyZ/h9q+flTOI38l0T/o/ihA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx3hqnXiD1/TLzDFQFkpFgkQSdUvmFNGGZF1n+Yq2zSrVjixaLQ
	Fdiy1QfPx5iBGXzOJoDl9SFJ8rOzc7O53NkmGWoE/XNjCVLd6ajpE9nfMZPFmBs=
X-Gm-Gg: ASbGnctagtfiCVa4SlGYdcMqt6/SqfpGxBDxSAy/00RPRAgJzLyc/8mnEC1kdWPiQbX
	HZ2FO0HeyyJPJMuXy/Bpxe1omut6Gi/0SG9zdnmu4y42pyLN7sPneJht0O2zbPBmJp8I+fpqp0Y
	lKC0ZQ9C5o2CkQujNUEvEfA+goVkuLyK1CMi/aOHfjqzxOhwQUUQXVrD5wzuelSlFJqg1MpHr5N
	rWkmQzOzgFXF+iJOMeYnKHjvKTIsftgC1TWXSpf5xaaPghT65Ifxa9S1twEsCfDFJyXSdMUIqwb
	dcUeGxxDGwQYvXmRYJI=
X-Google-Smtp-Source: AGHT+IEXXUlF+ji1IwGpl49YDsSy/JRDfposJyyxja2xvI3d3x3Tj/H8aRWRC3xeiJezmKd3w1sGvg==
X-Received: by 2002:a17:902:ce90:b0:216:2477:e4d3 with SMTP id d9443c01a7336-21f4e7f2c46mr34322025ad.51.1738908661173;
        Thu, 06 Feb 2025 22:11:01 -0800 (PST)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f365517desm22712045ad.86.2025.02.06.22.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 22:11:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v6 0/7] tun: Unify vnet implementation
Date: Fri, 07 Feb 2025 15:10:50 +0900
Message-Id: <20250207-tun-v6-0-fb49cf8b103e@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqjpWcC/2XQPW7EIBAF4KusqEPEPzhV7hFtgc04SxGcYBZ5t
 fLdM4IijlyOZr4neE+yQo6wkrfLk2SocY1LwsG8XMh08+kTaAw4E8GE4kIyWu6JGgOceTWMbLI
 EL78zzHFrKR8kQaEJtkKuuLnFtSz50eIrb3tM0owz15Iqp4waG6xTo1TSqvfgHylur9Py1QKqO
 KKhI4FIOhds0F44609IHhA3HUlEkxnxnsNgZ3tC6oBE/2hViAAcD8EzGex8QvoPCaY70oi4Dmy
 UApyd/z9v731l+Llj2aWXdt33X7frixuKAQAA
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
Changes in v6:
- Added an intermediate variable in tun_vnet_legacy_is_little_endian()
  to reduce a complexity of an expression.
- Noted that functions are renamed in the message of patch
  "tun: Extract the vnet handling code".
- Used clamp() in patch "tap: Keep hdr_len in tap_get_user()".
- Link to v5: https://lore.kernel.org/r/20250205-tun-v5-0-15d0b32e87fa@daynix.com

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
 drivers/net/tap.c      | 166 +++++-------------------------------------
 drivers/net/tun.c      | 193 ++++++-------------------------------------------
 drivers/net/tun_vnet.h | 185 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+), 317 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

