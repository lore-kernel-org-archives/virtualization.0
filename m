Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38E20103A
	for <virtualization@lists.linux.dev>; Sat, 21 Jun 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517474; cv=none; b=aa7JGPlsaeKAcws2wRyG1VqoE65Dich4Yz1FMZt87FEqcCEsuzIPUF3t8bYdAiYAOmAr6xqad7m39LRqlMWfhaN54pp47+4LbMN/88QmNx5NoN2uLDTxFcHGuf0KxBx+abKiyAcGkuOZ+oNhh+37/76b8ZVlOPaMswCo9SSOfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517474; c=relaxed/simple;
	bh=ia17Jc8KljfUY5LX34txi7oz/NXd5s4Mq/JQS8JpB7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ld8OYIYzyQqJm+XMd/TMRAn/+Fow45NgyR9d/88BQXUyAU/LJ4lhazYbn107DT4qWPzUt9AZcMN6JVQ4HaY2iSrw72W9ZPrsWNrhCbbSNxhPM1i7lDp6n5+bXUJ5e62IBmx9nUnz27lb3NnHBAI4lbi4KbI01nGFZYkAHCb9a0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsERBMgO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsERBMgO"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c7a52e97so2271595b3a.3
        for <virtualization@lists.linux.dev>; Sat, 21 Jun 2025 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750517472; x=1751122272; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3iFx7PXU29VvAkNai5SF5w5OP1DtkiEzyXPQbCXksko=;
        b=GsERBMgO876vlHv6PGsKGN4GP6wg4zERS8+AUSjuFAjAm/c7aYNm+gwkHLBsVV/vFZ
         VscUm38jXQXP6KcbohW4v9BgXpwakcaw1OHQgltPqQOSPy9rGAphXS4IO/WIp7oocGJN
         utyOj4mzMf5wgKHtTB1RYRylkDW7sd7LBqipjUWqAiKrDr0C3w85YLPwKv9ik0yD2a5O
         xTToEspYO1VMk43gfdK3V5Qxt8/53DmXyo3qxPiWkL5VRzDRPt6mrPlC7RztxpLIFErk
         ouKBO95qK8Bs31tZPWRY2erzoEdshNJ8CFUzrhWAS9YXidg9HHS8tCGH1Ce1yX8pRBfJ
         BycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750517472; x=1751122272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iFx7PXU29VvAkNai5SF5w5OP1DtkiEzyXPQbCXksko=;
        b=a6f6f80Cg3NarvrbHSy0ceItZHv1sFbFYozxK+zj/gEag4w8lSi/dvZQq7E1V4bJyW
         7CxzskGkZ6z+uwVpVhXz2pNih7fyJSmsmhWrzgv9N0bRz1tUTpVg6U+HRBdlx4dzEI8o
         XBPTw5CWvdhjDksHlewE4aAesCzgAhaEaAqBfjWIkIuJTaXjfPBW/2NDyNdH8dV77Ipg
         OeYPf6Kdc9DZwjwp7561ENe75mc2bNcHhpAYw+8FYQ+oPwYK8J9AyXVTZR7zPUvgmi/5
         ExRUuPhhGSDcpqUSYnFW8v635+tDnv/a85bsnuClAUsjpFLXCAC82b6OZkbdoSgzMuDo
         lMIw==
X-Forwarded-Encrypted: i=1; AJvYcCU0cdumTBNcvxd65Fm9RGIIgJIoUsxkIgHByO5acM6oN+lAeDigg7ZP5QQnDc10v0BWe8v7gWspVl0Fg7yC1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAPmu6UXDIE31y0/bwADeYWq3r2tHjmn4thQ2ChBEglssYLFtO
	AE85a+lviG/IxppPEZXLfz4Ld/eWe6WR2c/bUdWwcqel1RCfndSjFmiD
X-Gm-Gg: ASbGncvVINKKNSq9qKYmrdjwbYmzKQwGpVzP9EucV6pa4nCrkhyBWDAwuTfhgyZUNHg
	xcCQvFxIvZrfZgKmkbPi0mcoMKedDAucGW8HD/UjlestSwc1gIykvOKMCQ+Hf5HYwVyqgGAqdTO
	/8EkWaaVAODWiXBPo++b3X7sTkBxzHUMFckGhaepU263bndIiPaA++zEHofsfnuNwKfFq98mxgP
	04kRdSB0t3xX2Xysa4UM7t7NNmdZ/FEayTB+Aq5vcX04iPF5q3iYx0nAiZrbSfk9AGddejJD1d7
	GokJAXzm1NKjugPoPAgsadyqCDcgU69J/XHtqbZBiX219y+8GJtavYxtFrj9cIvmd9ng50ERgt5
	GDg==
X-Google-Smtp-Source: AGHT+IFuhiIhPgNz3xuopTzAVzt6+GxUMmMnJ9p90UmrmgAL4UiXbuo7pzh61wdir6s3OAAzbA4oEQ==
X-Received: by 2002:a05:6a20:a120:b0:220:105b:46dd with SMTP id adf61e73a8af0-22026fa9d88mr12058955637.36.1750517471900;
        Sat, 21 Jun 2025 07:51:11 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:fea9:d2f2:6451:ed3b])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a46acf4sm4493490b3a.11.2025.06.21.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 07:51:11 -0700 (PDT)
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
Subject: [PATCH net v2 0/2] virtio-net: xsk: rx: fix the frame's length check
Date: Sat, 21 Jun 2025 21:49:50 +0700
Message-ID: <20250621144952.32469-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series contains 2 patches for the zerocopy XDP receive path in virtio
net
- Patch 1: there is a difference between first buffer and the following
buffers in this receive path. While the first buffer contains virtio
header, the following ones do not. So the length of the remaining region
for frame data is also different in 2 cases. The current maximum frame's
length check is only correct for the following buffers not the first one.
- Patch 2: no functional change. The tricky xdp->data adjustment due to
the above difference is moved to buf_to_xdp() so that this helper contains
all logic to build xdp_buff and the tricky adjustment does not scatter
over different functions.

Version 2 changes:
- Patch 1: fix kdoc

Thanks,
Quang Minh.

Bui Quang Minh (2):
  virtio-net: xsk: rx: fix the frame's length check
  virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()

 drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

-- 
2.43.0

