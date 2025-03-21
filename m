Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C71E0E15
	for <virtualization@lists.linux.dev>; Fri, 21 Mar 2025 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539738; cv=none; b=ttkO3iPLJFuR3sQy9o9C2/PbtzwrXVc9ZCeOgDq4/xuQ1gq5ZBSacb7DIvgEJvch1WGYLi9GpS0vpymgF0gxQFxfxWyv3jrloTNYsS6FG+m4x2gIvvD905KanwJ7/0mSg344chhbtDsdK+CfsTQdrQKvWztQDHMZXjS9wKkec2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539738; c=relaxed/simple;
	bh=6ooNQLxhxbt4lgKABXvAXiZ/H/pTs90ea2703VP/jEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dfavb7vobHL+xzEKoUvIoQ6d9pVrzGJ3TXW4ac+Xfd5ygc3wEyXKXiNRNTgi5GOEsu6DNgUdSMaB2yRjYEYRVr/kC8AI8QqQmMaADxxqFFXfFReZaFzejzTJPCUiqyvZGpGyzOiK8VL8H/2IKgvqQK0uqzK5riKPbqH6lImZsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=FOb5JFtd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="FOb5JFtd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22403cbb47fso30336205ad.0
        for <virtualization@lists.linux.dev>; Thu, 20 Mar 2025 23:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742539735; x=1743144535; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvaePu+Lf34WSmuwJtyngfui9U5LFP1ldzJala5s8u4=;
        b=FOb5JFtdAzjiPbEXluja8TwM6wNhtXKIBnEeSytG0RyBSreO1owTc7DtvNd8ln9KdS
         N3LF+fDyTlGNu/5oETYmfZDwz0w/Rj6CdSDQ1P9GqVGqAZIcFpSq00wXFAXy1Dcv0UL+
         nIeUGveXWLilKEGOKwZX6HUJ5gcEGWbxCkt3D9g9ycJmzKd5NbMXWA8eITLE8uJM9B/q
         BdMS3RGrVH0hvP7JwRAqlAq9BXm6XgisGYKWfzxprmORtcQNttgvpcJ9JoCXDPuAmP45
         lJy7EYxJhi15KatZYSBFmPKWwz2eh0z44TxgEqe8ziSOQQlPDyinL2ovgLCLByvUodQQ
         SaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742539735; x=1743144535;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvaePu+Lf34WSmuwJtyngfui9U5LFP1ldzJala5s8u4=;
        b=kKGUI28aji+oZQ5MmBEjOwEnW3eNtBMP0n+A+XHzthk64alCYCmruvrtE8bY/rlDea
         BWqugrZfwMENwhkf39jY8P2ih4FM36oojI8cZSiJl077G2aZycL6hBG7DN+ICNyi6XlO
         43kmjT0EYPgOXruJ+XpfLAcq1/K8n3kXBfIJ0a3+iKXq7SoLfJJHSeOVGmxQMHQulrSF
         mZCs89G+j42HoVNAQ+Z2XsGBK1L2qZRFHrePGSDtanzUIZdGrU7WEwlxdPft2DIZNF1Q
         KbnDVrNRquUWWFbzQYovZwt6w2YxcX1GAZEapGngImREp1E3J3Ovn4DDBWCG7QE31ZOI
         y1Ig==
X-Gm-Message-State: AOJu0YzbASe2xsaLeC4U6OwLjPIoBZG+a11LficD1cmUkM1698fQdMW0
	W6AATF0UqzZ4WKNHGfb7fsUZr+TYVqGJYwzW0mlpaExwWLpnkWBxrIZpauNJXlo=
X-Gm-Gg: ASbGncsubsCoGse8rYXywJhOpCg9IalW3toAd5n3eIG75fOpIKTydTk0sTX6fVLsaWX
	sUoRid1imm5A/FWaBIbPMXY2CrSaINygVKzfTtbO4fnOZSxmsYLqF92F4RyJTFKuuOJ6KlXnGqE
	w8qEdFEFKCaGJgVU38h3OEfe9VIUeioE27KqAo9AQ7k4VdUCh2PnAASzdWPP/T2JuADF8L206E6
	TEG6ywvnptRCux9ncmocQDzdZN4spu3b7Y/HrcxY2JcSRE/VJPrrH/K7UxK4TuQs0+8VSymPhxV
	fmO8DK1Z2rO+Z7BFH1bormWtqRdqzIQDUrSM2ZDkObjDUr+8
X-Google-Smtp-Source: AGHT+IEyVWiZuBU3HVprj4u07XVS4jJc8dBw9lWctyOdahYf8tAomFSkVNJplBNroBXKEAuEtsPI3A==
X-Received: by 2002:a05:6a00:2e90:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-7390599eb4emr3733783b3a.12.1742539735464;
        Thu, 20 Mar 2025 23:48:55 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73905faa5d3sm1087092b3a.15.2025.03.20.23.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 23:48:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
Date: Fri, 21 Mar 2025 15:48:31 +0900
Message-Id: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8L3WcC/12NOw6DMBAFr4K2jiN/wIFUuUdEQdglbBE7si0Lh
 Hz3WJQpR/M074BIgSnCvTkgUObI3lXQlwbmdXJvEoyVQUvdSaN6kTkk9sJ23YB2UP0NX1DH30A
 Lb2foCY6ScLQlGKtZOSYf9vMhq9P/x7ISUpi2nafFGIuID5x2x9t19h8YSyk/X5p7iacAAAA=
X-Change-ID: 20250318-virtio-6559d69187db
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.15-dev-edae6

Jason Wang recently proposed an improvement to struct
virtio_net_rss_config:
https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com

This patch series implements it and also fixes a few minor bugs I found
when writing patches.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Replaced kmalloc() with kzalloc() to initialize the reserved fields.
- Link to v1: https://lore.kernel.org/r/20250318-virtio-v1-0-344caf336ddd@daynix.com

---
Akihiko Odaki (4):
      virtio_net: Split struct virtio_net_rss_config
      virtio_net: Fix endian with virtio_net_ctrl_rss
      virtio_net: Use new RSS config structs
      virtio_net: Allocate rss_hdr with devres

 drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
 include/uapi/linux/virtio_net.h |  13 +++++
 2 files changed, 56 insertions(+), 76 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250318-virtio-6559d69187db

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

