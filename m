Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D926ACB
	for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750000466; cv=none; b=LTpA0Nav4f4JOZgxbxuaEyzBH/YXWQJdFQ+hb6D8/nQ7/RWlKGT5jyBofQbd2avG7VhygHyxa1Q6kLJnbHl22JxQHHjBw4HD92UbzD/dTlDHvfgms/tMfEE9igF4FiA7mgXdI/I480hPMIWw9RIIX+3WNNrUZcNhSMpuNSU7xA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750000466; c=relaxed/simple;
	bh=JXYf5ZbXaxd+pTT//xI/FT14s6VC8aqe+LnXcuWiUc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0oEZM7rfZ6Q9g1mqHQHaCXz7Xb8HYDL02q+nu6f5ZYsOm0oprcpkufTtvGTiuz/5ECzPG2aFyr0ELzbsZoI7ROZOeLQMrNmdNsN7+ZUGlSYIHYZQZWA0trV3p/mk+PCSFeGFNoV0yBQJsOp/Nq4KaA4JiLR9aCt9oUTkZre4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VocLRuc9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VocLRuc9"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74849e33349so3319896b3a.3
        for <virtualization@lists.linux.dev>; Sun, 15 Jun 2025 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750000464; x=1750605264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xeCjzQfkB1+ovbUpzeze8a4duFJQQau/6t5f8myV+mM=;
        b=VocLRuc9BcrhM/otkbVIvdjnA4WlooN0pEnPOs2F6VgXIbydwj5+v3VUVrrXMk4HUB
         cTwb0N5L3qHGCsUFmS+jItVAAG8HZTmM0ldS3pdY/ufBOoDCGmHMlXQWfGIbJOQvRTfB
         a9nccxShjx/SM6YENdARbHcjYjIlHFadWnDn4cQIaOtqn9vTLgcRh4ittHyvIcHDf8iD
         9hJOyl3kksW1qiQGNKehAczWYjVuQbYBnrUEjPGjxnjYYCJ6dG5OAWOQK5YUbMjLmEv8
         TCFw9AvR5FIgwYzQXOysKjXjssWTWUA1IEGb6yucGCAZ7hOE4C4/cJnlPwKqrRTJxehR
         Z1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750000464; x=1750605264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeCjzQfkB1+ovbUpzeze8a4duFJQQau/6t5f8myV+mM=;
        b=Ni+2r3/3hmqMsiXGsCiU0qSW32bKu0v5z5Aw22Y107vbpi+vZfYVf6n/L2I6/t0GS2
         ZglF34Knd2I3VpcPiQyEDxHWoNay3qWXKyu+xAjrmgVDHwuJAygHPxfS68zdA2/CnSYn
         G4WXyBCXcdHJIUb1IVh52TXFObaAIhnsyd0iebNywnZ/jJkxnUvmHSYPvz6gVqakbgiC
         RSDex14a0z+yE9/v2xgpeMtE0Qp/UYKr6C7XsB8yJS2hQ8ad0RyOrD/9KVWLNfEHUyok
         MPgtuOOw7KiL1N6LqNkmdKo0sacPMlrB2vpVFXlT6QtgFlgZJ7L6LxTykKLmC7q6OeO6
         WB3g==
X-Forwarded-Encrypted: i=1; AJvYcCVvW7QKcYFxGy4m5zYM8J4uFXXOs2Ifg4WrQVLKY4G/JTt8IWZmUC1e9CNJvn+j+FDH89ID7OofsRC1KCGKqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgSNyw6cmzhjEcwUL0TA9pB/eXK095KSqh03PG91BWx3Y87GYv
	w9iLrM286y7vo85kOTgzJcMUKqiV63AyBFnmjVVGBdWdWOpPKdm7S0on
X-Gm-Gg: ASbGncvgEqRbGJHABVQ7XF2gxztZASMp/wsqnmJ0zhWbzagHJVSK+COTb84u80NngrV
	sTIionm75RRnzN8bZfiaI0sJfC7yKXP3YzZc7F7r2RE+WA5faySMq3SWgskxHv0yoW79nocp9a5
	IzGGpFE7tgIQOcHh1/QDIcNIIfKTwD3bFpGrjPA7IqwE2T4maPma9lf0pZp1vnMzidQdfnOrTNq
	BJfYrWYQeMemVmCFMxcTZUAbbvPByl2uWqBN51jXYtEYvo+dh/tUMb0uZKjqplSS1sFGjTBmXUy
	FxRFwbdqu5j2qHT63t2Ogvl8hxzhB9w6fgB3lNcabpGt6fV62bbM6Z6k+3Hl6uP8vCh8oA/Phev
	oQw==
X-Google-Smtp-Source: AGHT+IE+Dh7qkuSto2XPVBxAku93xQd1vexdTf/BYTpDRoQLi3HYEYrUq311ENiBH5Hu3V/gp727VQ==
X-Received: by 2002:a05:6a00:99c:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-7489d02e3bfmr8658913b3a.18.1750000463919;
        Sun, 15 Jun 2025 08:14:23 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:482b:a929:1381:df12])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-748900b219csm4950022b3a.129.2025.06.15.08.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:14:23 -0700 (PDT)
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
Subject: [PATCH net 0/2] virtio-net: xsk: rx: fix the frame's length check
Date: Sun, 15 Jun 2025 22:13:31 +0700
Message-ID: <20250615151333.10644-1-minhquangbui99@gmail.com>
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

Thanks,
Quang Minh.

Bui Quang Minh (2):
  virtio-net: xsk: rx: fix the frame's length check
  virtio-net: xsk: rx: move the xdp->data adjustment to buf_to_xdp()

 drivers/net/virtio_net.c | 46 ++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

-- 
2.43.0

