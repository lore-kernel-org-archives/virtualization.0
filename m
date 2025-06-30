Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80728CF70
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294565; cv=none; b=KGKUFqoec/Djpm8e8o32jjCsTc+SZnaoNhNhv0wyajXMGhJdCqnJFVGBKr79RMVlzxrxvMXWOfjCuQQ6rlOnZpokHYCudzeBg6lzjF4YMevqWyBAFCaMOGU9D0+pGMSZQy9WvnYyZfSYQY6svt3tcRd4TKzztFBYg27JDcuvpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294565; c=relaxed/simple;
	bh=6qMdcAVrzLINFWGhEHKx2bOfsr29+z1VuJLunXEJhWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BneZ/4pCdU92QHq7RRTtRp+E2Wl8oM0rDBPz39nxP7mgEZF7wL9SURpoYBpQNUAZB+aBt13JGkk+zmDr0cFJh0L+aOU2u7NkDcTGPbhbkEtfsH2dQiYjcUHBsBadyDmYipnl4bLg8uesqyFtyJ74RQ51jPPHlXHd0AJDNvOhvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/CmAtl4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/CmAtl4"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so3632129a91.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751294563; x=1751899363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5aofoMvYrH1y9lMP9RzucrOBhds6qNg3gudKz2Vjufs=;
        b=e/CmAtl4zoTjSMAzfKkvCdL6av9X+q3T6vTx4sRt0lW3y98f3J/oCcoIIiT6klzezi
         x8U2V6NurQ5G3c05jMMZioOZ5/P4Sq2jOSc+NNepTQAnbXgDLr0mI4Vz/VfPrPmwQuHu
         +eGzuVa+Y6kuN0JPuy2ci1fD97htEzAhn8m+oUQOWJG7XzI9TbnP3X6vmk2VCcRk3hng
         pjhEt40kj7NNHGndxkvUL2FjbVdMKng+nSuRcv8dG3koO0hh61jhUK4W7rqXY/5iaDpJ
         3S/TE/dto6MSly0kiuYli06QGxEEcl6JRAECaymP3mu56MsMJsmu8PWRzRvu7ZFrH7cD
         Xsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294563; x=1751899363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aofoMvYrH1y9lMP9RzucrOBhds6qNg3gudKz2Vjufs=;
        b=wuTkyZW9w/NjGnpxsZ4/kYkmo4ogt6dPqzHfiMKQUq5Me3idc0qEFwODq0VmQwzCT6
         CmDKbjOT4cOScNfF3uQoKQ+w1YUMFaRVGAPiI++2B4ivoOaaG2hppOd7lNzp8Jc7ZSX5
         3/nxXoHBhlpvaqM/OrBRgP5XPO4S0okI9w1kvVTzwO8HOgxjm9nVPv4Ag5RY+/eR9G27
         0wXwr6b5MGXnvNysWxQV8PQetuPYBhwIEBMutuPtPIUTQQUF7aRqvUTyvgSk6+lgzxTo
         DA0PDfPgnquSPGkJMYeZ7FYfcdj7VBdIiDbs0lPanaAoADgd1mlOGiD4P9uXF4da6XWP
         CWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUykEXWpdaysnDztsqH6dN74+lyVkV3iNrvTUWom8+vy70b/CGQ+pd+63y7d1EnxqA9MkvvAJwj01H6MRo3SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5w55pVDsT10lgzGqn8Dz3xe3m1xr8ZHXzAcxyvyFbsMV2O+Wn
	HxrsbWyL4iGBUbU9Bm+csyuz/YDqKczpQ1c/Mq6wFEckFP8lgQW3w1qr
X-Gm-Gg: ASbGncuL9RyUm9WzuxwmgTcjYHzDWWDZI8Lfs6H3sJf4G/JJyjPc/kaIp/mk98huxxH
	rg50jmM2PsJmBUPMilYwNicuJYHPQ6RmOolteJy5dXABSld6UOGvyOVwI8JYR7fPEDXfL7mj+Wk
	uiPeLClXW4ptYFmBhUypa/dDaJioX74JiAdz+6iMGoJd83CEd/lg8g7x1pw7r4I0fAVW6wWCbcV
	UinNWwvTzridpNO2uMA3So8w7499/8OFrF6VHLqG1nddvaZkjETSvGtVr0fFjTfUcl6+wIUcwE6
	hC+yW/zq0g5hLYIxNUhR3AU/hT++F8epUul9zXsQPmh1+3AMHFxm05Rz+tbqYXgPSnadTx9Dfec
	G
X-Google-Smtp-Source: AGHT+IH7KkUfeVZi1PbvFQWZ5RQ3dxQDhFjmunArM3SrATO1+z5mke2EDZHIxwCOZsltxOQabz5ffA==
X-Received: by 2002:a17:90b:3f0b:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-318c926ca4emr23469190a91.33.1751294562884;
        Mon, 30 Jun 2025 07:42:42 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2f51:de71:60e:eca9])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-318c13a270csm9170017a91.16.2025.06.30.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:42:42 -0700 (PDT)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 0/3] virtio-net: fixes for mergeable XDP receive path
Date: Mon, 30 Jun 2025 21:42:09 +0700
Message-ID: <20250630144212.48471-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series contains fixes for XDP receive path in virtio-net
- Patch 1: add a missing check for the received data length with our
allocated buffer size in mergeable mode.
- Patch 2: remove a redundant truesize check with PAGE_SIZE in mergeable
mode
- Patch 3: make the current repeated code use the check_mergeable_len to
check for received data length in mergeable mode

Version 2 changes:
- Move the check_mergeable_len helper definition to the patch 1.
- Remove patch 4.

Thanks,
Quang Minh.

Bui Quang Minh (3):
  virtio-net: ensure the received length does not exceed allocated size
  virtio-net: remove redundant truesize check with PAGE_SIZE
  virtio-net: use the check_mergeable_len helper

 drivers/net/virtio_net.c | 75 ++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

-- 
2.43.0

