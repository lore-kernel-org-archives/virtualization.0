Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D321480D
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736405943; cv=none; b=tBkpjuPFu1LGd11CZMveUjVUck7tFzUSvQ+7mGhL13iQDyw4r9m1tEeNWTLxWF2zitqRZ+NTiIfZwlGSzPoqfgKYjjq8KVN5g2KDOG95VZ9Hoka5svvYaF1fKilxOeEh8tqawZxOcAqT2XN+p6nUmfqk8MRK+4I/tlxkr1fAgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736405943; c=relaxed/simple;
	bh=b4nGT7bzNP9cYs0RRg/GoDk6GVo5jtMW+D3RbTMnfIM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=j4oxDNPVhH8dkDGSG4eWhf7ENjeJSO8O7HecUTXENI+3cIkhXoaHyug0OW0SvakukzmisYqNuyydnU2uuV/JCk9j09cxzDUrXHVW6ZY6oCD8e+oY5axN/WELBMVFCOGrHnmsTp8CZuN+c3AR10mnmy0PKeRD4jWXl47vmR9Vke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=W8tr3Gcg; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="W8tr3Gcg"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB03980526
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-JwRdJVkvsb for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 06:59:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 56D1D804F5
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56D1D804F5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=W8tr3Gcg
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 56D1D804F5
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 06:58:59 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-216426b0865so8326285ad.0
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 22:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736405939; x=1737010739; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6t1qxwBoLWfejlGfA7U17j5uTd/JzY8q21mk1j72ew=;
        b=W8tr3GcgX/FRZDiwfD3BjNAzC4Sz5E8xA6Uy7e1o+YHt/RAC0uBURVM+rsXgc9HMbF
         OPvIPBhZGNTjAxcWc7DIdsqIbfyOiMnpmuyn9oyul1JAQKMyW7Lk/VmI2NSccMWbs8Tr
         Uo08H+sikooYQe3SnztMXrxS79hyVwTB/9SGxPcXn5BiXieYgLeG0GRPJaNPzV5EAzeW
         YJDP4miIJEpq1lxH7ArJWga2BBwSNnuEDLsSNiQJu/I6GntBYbFrhq/uMt9rHruTSZCP
         +4i1mNlVZ23Y0WwH8DijIcbmJ1EoVKcM63rHrmWc2eWkuSnIATLrhU3ykEvd3YxIjovt
         Ui7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736405939; x=1737010739;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6t1qxwBoLWfejlGfA7U17j5uTd/JzY8q21mk1j72ew=;
        b=KUKJd1OXR56zuG36nCB8+sIPWbxn585qgiaud8Ms9IATsZo6nNq0E6ooWedsLkTE6h
         J7LnpqZ69FSKTSZaqufnggDBa4FZP4Yuaixqq404YhYJnaIGu+Ur4QPct7ZECbw7Ntss
         rFe2Q31OAcgYUvfkhnATo8xx7KbBm/OiRJN5VpzGj5xTTDbN07oq1VaR6RtASMLL2fH5
         83ennZwkd5IpHdeEIpRGs0wnAx4M/ZchatAXnneztnZduGu2qisgFbWy7dGkVNUnuWC9
         YC1RGxi4mc+uDkwWUPoC99JSvaB+QC0VDcwNsC2IJJnxSyC/2dTInybfheVKJL61icdc
         cBcA==
X-Forwarded-Encrypted: i=1; AJvYcCUAypFWFicSwBHirt2PKkFA8YHMuHiYBihNGGis6Sue8H19UtrPfGDxTyjRoa9uM0m2ni2LD3vWHlwA+8RfhQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxyAS3Iz5k9hVPHQ0jiHwUGfKsjfvIs2+AS0fP4TinE/mmxSSLC
	1ZRb0nJEpZoXoIgxMJMbAszxXatUXGR3Aff1WcOGb9Cibkx6qC9hsbDtMh5T65Y=
X-Gm-Gg: ASbGncuvX0p447rf9/8/k9CApoSwVmJ4o4Y5CVmHFR6s1Z5pNv7+B6kPMKsEuG5hIwV
	fB5fQE+xcddtYpr9Vw5ZxJdfCVnP4cWR8/4Gn7SkyzOxJj47nRZDNElvuXTxPjER/ZEQsrTfBHG
	n8ionz1q/SRY6a2nV/a+/FIYxelx5j3GUeBLQleTsPsJFOvzYHvr1VZmrkmbdWHbmVh18jIEn3G
	btnQ3fmzKqmroOAmqkXMBgtG4wlVlpBcw3g13C7PPRHQdDEfjARXmBI9hI=
X-Google-Smtp-Source: AGHT+IFVrPaDE5bT1NedCIHg/BRb9M1axoVZQXe+QhCRKOheUBg8nZqyVlcuDTD0PULcei7AMQYLnw==
X-Received: by 2002:a17:902:e5c2:b0:215:6f5d:b756 with SMTP id d9443c01a7336-21a83f36e79mr79407695ad.7.1736405939214;
        Wed, 08 Jan 2025 22:58:59 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a91767f94sm5432205ad.40.2025.01.08.22.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 22:58:58 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/3] tun: Unify vnet implementation and fill full vnet
 header
Date: Thu, 09 Jan 2025 15:58:42 +0900
Message-Id: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKJzf2cC/y2OwQ6CMBBEf4Xs2ZptqRQ9+R+GA5RV9mDBFgiE9
 N8t6PFNZl5mg0CeKcAt28DTzIF7l0CdMrBd7V4kuE0MCpWWKkcxTk4UBUms9bVBayA1B09PXg7
 Lo0rccRh7vx7SWe7pvr+gxPLYz1KgKExrSt3kOjf63tar4+Vs+zdU8Wf09JnSnfGvjfELvQd+h
 qwAAAA=
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
Changes in v2:
- Fixed num_buffers endian.
- Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com

---
Akihiko Odaki (3):
      tun: Unify vnet implementation
      tun: Pad virtio header with zero
      tun: Set num_buffers for virtio 1.0

 MAINTAINERS            |   1 +
 drivers/net/Kconfig    |   5 ++
 drivers/net/Makefile   |   1 +
 drivers/net/tap.c      | 174 ++++++----------------------------------
 drivers/net/tun.c      | 214 +++++++++----------------------------------------
 drivers/net/tun_vnet.c | 191 +++++++++++++++++++++++++++++++++++++++++++
 drivers/net/tun_vnet.h |  24 ++++++
 7 files changed, 283 insertions(+), 327 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

