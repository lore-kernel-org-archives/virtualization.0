Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDA91F8EE9
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336462; cv=none; b=V79OxR6GyaSs/gaW+zt/IZ+q6EHyI087JaM7GoAPACQUNNUYOFUXdzuCNMnDX1ok8vH/CiNhx2qWHbtV5Mb+EL2c2Dgmc2eDgzGsstMQbVRuczc1oqgdEExlx5Kwv5DCVyJre+N5uKVr8CbYT1DgLuMhpz+pOZ/eQ+PZfioKCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336462; c=relaxed/simple;
	bh=lWV/O/UttiTJkLULUBKYE0bPmgRlaCXXqj66Zi3wY7Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=DEjliZ0qVJ3mFg7jDch0m72yN8aEDnE/1IR31/WRrFe9DTxnYXSUmBZd6pnTSUo1MuOA/q5SM4HoGcdAgfG5+cjD+s8+RS2IUooY1ZDeatymIk1OkOqaDTIzT41hXgGV9Ds2ooDv5Hgck0YconuYNxWhgo1OBzMUjPybmwb6JaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZVe0Vkp/; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZVe0Vkp/"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB20F403B6
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVyUJL6tdWsM for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 11:40:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3CAB3403A4
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CAB3403A4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ZVe0Vkp/
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3CAB3403A4
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 11:40:58 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-216401de828so232673255ad.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 03:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736336458; x=1736941258; darn=lists.linux-foundation.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjDlOhfFjHDP1GFg1z841jK8M5cnJcOZe4IzLR2+JLQ=;
        b=ZVe0Vkp/52igiVq+voHbR1oRmfDHRjsNb+TXz05K5fOAHEBfi4+FRf9LtJfA7ZkUKH
         n86Zsm4PdAZ1ajTA8PEdf2SnfW0yjKwG47/FbYct6rY+dl30H5QsCs1KlkPI/qpslx//
         7GTGMViks6kyEXZ11hVZHZe1KSblY9GzvygRis6w5i/EabNcc3Sj7Ht+zjf8QN1K0rq8
         +2kH1xlA7eQh5d9bnfkaI6OrthHW8MpgIPQ+EJhPuF7C/UH9ZEMPFyIOftjGcT9jIARv
         Fyo13sFS16nv7TnVlYY8q3yJM2q4WkKFZ4Ic6yvU3pXrLn63Qld1pHteS2vX6IFpNPLP
         rwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336458; x=1736941258;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjDlOhfFjHDP1GFg1z841jK8M5cnJcOZe4IzLR2+JLQ=;
        b=Wu+S8KmP488v2NhDgjZNTisi+iPohSg45BtnlFU1KoVTYIaOXNst+jlgsnIuHZlEZd
         AvTmMJzzsA9hPM7wp/KA+dxOEKrx4k3adjrOzPCZFmNK/Xws/j/Unr6KZ1M4rRhEOyRF
         xmD+B2cKbZaM2wyudNqKEc1fhVv0woSbokMB0eqVHMSFcyimE7NgqM8hek1e1Jw51DtQ
         yJ/eJPO4V4rikccbnnX+ORPjZqW+OkOf4eaT2UTC/rokXsDDhncJCBTrzxSdEg6RgK0E
         sY9EMncsi4Nr3k7Aa35lt7TXBLf8ki6dKF4hhza2HwXCG52e+feqgWA7D6RFDwwFqMK5
         1ZGg==
X-Forwarded-Encrypted: i=1; AJvYcCV5jbDWiAKjKiPCHGpJCVa7i/CBQb4KtpYUohKFaarpKfm7bjPcx8EAM7Sy0XfWkVE+gviGIu5C7+XZaLKg3w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzfHszC2bRh7VXmJuF9FzuOe2nWb7l2gzLRmV7Cpz8PB3QIuajq
	fBY+YHadgETQeCN63HmZexx2yvldK9buWVW3uVupZy8KWnEWZYMA/Lc8HppYMMY=
X-Gm-Gg: ASbGncvghNOAYWMNwkitUXCf4vibWtI1EDS4MZ72isJImsTUxeG7EbjbNdH+ipMkmln
	3qoQ5/xlzThaf1vBizMekhtMXkFCtnQ0PsaQhjIeV+XjMeni/6Km8UyvsXMMaSfnpMKvr+xODBx
	h7CBB0sRzNfHOH9bg3QRH8MaXacBUSec7UjpZOwkhIe7OlCOc3CR27md6BsHqrTHwRyjG/Io1k3
	Zv8O6fqBssQOzPRptygoSF24UYybigtixCps/I4Ofdw3Z8ret5CECi3hro=
X-Google-Smtp-Source: AGHT+IHFRNXARPASashVpP22bZbsPAi6fmuWW4IEFR4NWYNiuFbqTXoYAUP1T7En6RP96xLPSNA5Pg==
X-Received: by 2002:a17:902:e750:b0:216:5268:9aab with SMTP id d9443c01a7336-21a83fe4ba3mr38646875ad.46.1736336458432;
        Wed, 08 Jan 2025 03:40:58 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-219dc964b84sm325595705ad.50.2025.01.08.03.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 03:40:57 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/3] tun: Unify vnet implementation and fill full vnet
 header
Date: Wed, 08 Jan 2025 20:40:10 +0900
Message-Id: <20250108-tun-v1-0-67d784b34374@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABpkfmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI2MD3ZLSPF0zs1RDg0QTyySDZHMloMqCotS0zAqwKdGxtbUAGJ7vjVU
 AAAA=
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
Akihiko Odaki (3):
      tun: Unify vnet implementation
      tun: Pad virtio header with zero
      tun: Set num_buffers for virtio 1.0

 MAINTAINERS            |   1 +
 drivers/net/Kconfig    |   5 ++
 drivers/net/Makefile   |   1 +
 drivers/net/tap.c      | 174 ++++++----------------------------------
 drivers/net/tun.c      | 212 ++++++++-----------------------------------------
 drivers/net/tun_vnet.c | 191 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/tun_vnet.h |  24 ++++++
 7 files changed, 281 insertions(+), 327 deletions(-)
---
base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
change-id: 20241230-tun-66e10a49b0c7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>

