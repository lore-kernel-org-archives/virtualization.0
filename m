Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3B3AEF5F
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849332; cv=none; b=YD5cmFOHfUPZlzMAhCSBPKbdYXx7sgavjUn4DncboZ9NKyVAjjMMWb/hIvfytW/rjSnZmQrSz8lp+R6UIExsHE2VuTPY8arZvFl6lE5B62G6D3cmNFeEvPcnSzoX4fsmBZqYm5zsRmB2jVGSrkBaKdvpL8EDDOQNQ2R3NksXsYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849332; c=relaxed/simple;
	bh=1w1F988jNPgirGYn7lWZqWgUsbQey03z212sKRJwP10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ihe+Zu7ljTU20LJPtpgmtUCoF3GZ2sjurboOzwyCMdP7GDly2jwZox+BeD6nFsZhqEjKHCtcb/xN1td4mW14eM4alYw0PAKAq1pcKuesnAocwQpeGeETg40fYS/CJ7zjJMZuTC7iXZNQeBfR3jMLgq6mZ6Efn1hWuaajNxTOWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH3omFg4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH3omFg4"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c45111bebso1331249f8f.0
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 16:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791849330; x=1792454130; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/evjTB7G1IHnw2ZoU85Mql0h2mL/HYgEXMQE1oqOuN0=;
        b=lH3omFg4oFtm/gvgYt2CZhQE4vubVDo/KjpTtRlY/YA5rIsq5DpJTldR6f641Rdek3
         D5n12TvgoLYvMv76eO/Wx7O1PrPOaVdjeIn2jur7zwoL29jup+7pc9dSk9iMKeHHNHP7
         Wndp9iGGpdAElbAFvIEIxRRlAIYhHZtDswjOLDI6Dtrv8hVgSSeGO9y9R5rv9uM7I2ul
         Yzmct5QGF1brpz5OSbK4E+f7NHDQxc3tSgNuGGzmDapoUut7Yeo+VhtFfv1tOrxCow4P
         LbStTJSi+ipNUYwuucoYlumDL0NfoZJLznsO7JJ2DWi6n6dTqKO1oz2gLa1pQekwpQ7h
         2gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849330; x=1792454130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/evjTB7G1IHnw2ZoU85Mql0h2mL/HYgEXMQE1oqOuN0=;
        b=V2xkgIrGsQT3wbmfM2Mv7rKArWntFY+UuJLaT1SarnbV5NMGnwFvJ3K5+j7q9pZr/2
         GpGJNGBeMnqrMS7F0w4lswCo7ySX8YjcpK3pFZ0JLcHEiRd1O658+V5ql9a4pY6xPVJm
         4GLZszKIQdyuDdS7cmTgfr0woZhRQlmFvmzg4zmG9UaDXX0aOq568bF9fIw1wkxSQm9p
         FuRcaNUtVLbQGvmtpj5SV7qHqP3P5t4JeJK9nah3heL6bhvElzN7vmcr7tubTEePJJLW
         IZmdcExggYIHTuRbPVdv2Lo/NeL6uAxG4SEQl0nSW/ElEapw+3OqBrS6a8dP1i399xjb
         v+Jg==
X-Forwarded-Encrypted: i=1; AKwUvBwgN7z+ijWsE2frTTIZ45Ma5R/61YjEkswkj67hRVbK/w0HD5cUuUNDgKqGE84qHVzYwBSInetvAte9KHQZLA==@lists.linux.dev
X-Gm-Message-State: AFq9FYI9X5iANxKh9okh6t9x25ULuBvEjVznioHSLAbo329WgIOdxbKk
	HgPBO5exo9Rlwl7Wpa1WlXkdc7FXGPWopFmMpPft+HJoW2pi5HyZjqhI
X-Gm-Gg: AYBFou3R25bAmtWYpb5T6gRj9sGOdN4B/Up8a2Zz9ntpbVEj6a14uOTvcaci45uowX0
	Uu7/55BoukGrAzo0/oe3SYItNF7CRGRDYYBx1hVQyOVSsoWFW8OhvznwN6FQZMEJNKXBgJy7M66
	Hd8lJON1uuzlZXWn/8uWUFzpuoBJHqqRBSFK1wOR2d+DjvklqslAbXVgSRWoY+XCXSNNmal1RRT
	62JsZOWQr3tJzRCWa8EIglOBIidcvEquxOaBv9HR31yZM6weLCwY3d14o1KkcAMcWvQBeAYTQEE
	9WwYP7c7tbjkwf2SwXj8PIoGBVFnArV6FsvjIQoJGN6SnvGZ2HYXwszFXAyS6xjTSLB8xOA16NM
	7R5UV05NG6C6Pl4JQTVyiObbqj4bGUdByxTpYjfHGUi2HP9FjZo6i3oJ1Wgwl4DV5ukkbRgMPS1
	7GvW5FRNLqKDgARXkptbt7fx1spQR0iB9stT38V7BLZ7o0tWZ0fsRBw7vwA+Jb5xbrI9bzxGHG+
	L8C6iKY1N7OKzrsD6NppznUzw6lqV3GMwcigNI3Ljv2yMvC/RI4bN16RQY=
X-Received: by 2002:a5d:6b92:0:b0:48c:8126:a266 with SMTP id ffacd0b85a97d-48dbace9838mr16800523f8f.34.1791849329200;
        Mon, 12 Oct 2026 16:55:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm1933762f8f.3.2026.10.12.16.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 16:55:27 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 0/2] vsock: SO_INQ for stream sockets
Date: Tue, 13 Oct 2026 00:55:22 +0100
Message-ID: <20261012235524.41468-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the follow-up announced in the receive queue hint series [1]:
SO_INQ and SCM_INQ for AF_VSOCK stream sockets, as AF_UNIX has.

The value is the one SIOCINQ returns, so on Hyper-V it covers the
current packet only. The flag is per socket, is not inherited by
accepted sockets, and the sockmap receive path does not report it.

Tested over loopback with vsock_test and vsock_uring_test.

[1] https://lore.kernel.org/netdev/20260923184008.153541-1-devnexen@gmail.com/

David Carlier (2):
  vsock: support SO_INQ on stream sockets
  vsock/test: cover SO_INQ

 include/net/af_vsock.h           |   1 +
 net/vmw_vsock/af_vsock.c         |  41 +++++--
 tools/testing/vsock/vsock_test.c | 191 +++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+), 9 deletions(-)


base-commit: a4057f51efc2b74ddf46721e83f45e9efb13649d
-- 
2.55.0

