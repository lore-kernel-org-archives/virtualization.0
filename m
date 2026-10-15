Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D703BED1F
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079035; cv=none; b=Vj0N//D9FHKqFQBIKlufeUBdVCCZiHNbfEYhZY+e/00xfPPIe9uPoNJqGniMKrpCsrNIVNURp5Bu/C37LMmzfDD8oaUIGdVhTzqhqmAXDXgHFqOvULmUTEyrm53TrqUgn3F1M5u4cXesI+nakSSTL60nlo3jbvrn8VpAwLKdVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079035; c=relaxed/simple;
	bh=G6IWS1Zxi1tU+lwJpiMqXpVXB0OLHXCMig/G7veIfHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5txOBhEBa9WrSgNRqiOUGwh8d4TmTzSkzySumaw4NLvXNHgJnBhm4oCv2IZ6/8/8yDWpojY8PH5gvTcf1KrvWe9+GyceivVrYPxnZJmla1wIOxN/DnO4pcn/OFynYKytmxgCsZKrdzr4TFywqy/hUI5GaBHDuzmQJSrJvItIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmfe45l6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmfe45l6"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df8fe8513so574778f8f.0
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792079019; x=1792683819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqgpHM/R08a+17QdyNzhk9UD0dnMaaklUgdhuosg/ak=;
        b=pmfe45l6Ep1B6YawUzmAlItjnYNpsRWHW8cpW2/L6UANKVO+H9sCUZuiDJKuPUTCXC
         8w8920OPkvirNjg5ZN6SWTA45gW8WysG5itNNnGDr9IpVvkMMuqBjPWhEPXY8orFgeNn
         6F4oPJwgG7ggtr6tQYsGVshJA71g0GttVTSBZNBQExZ2O9wePtdYsaXgCk6dAcrI7WK9
         01Z4wKSoISJ86KL37ctJuxDU3mtTLU4ofBqWvoyaiX5rTbkfUwq4EvCGvcpQaaljqtcc
         tbZ9IkBKgp2K0FGh35hD/++/op6ATZpHxDmXjLJPcihNZucveM62uvefWVIscfMmsaOW
         z08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792079019; x=1792683819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqgpHM/R08a+17QdyNzhk9UD0dnMaaklUgdhuosg/ak=;
        b=TpbWzU5ALv2qxglswjGUDNaG+W3QEQE5v0BAlx5s6NQCXk2us3gR0TNkKSqfLl3yvh
         xqGtmpNzgUvb5E30GpRtM52HjMYUc+Yj5NlrmX9KnEtnvA4ky8Mqc4Pygm/GKN1PQtRs
         CNLMcbxdsFhPnOZpwmwWK1Fy5PeTnA6ngkadbJaVRRQ3noa1HQjFMsV/2OWmOPrBkG1v
         JBYAgJJm48tn4MU9bDSM1T9XxoqSw1LiJX68T9p3jMGsDMeB9+zEVbXxNV1EBPtRBame
         8hXRcgej24lVuUDXCfFiKpU3SsaBhRt/7FTY6DSX+KU3RpHgItngnqVZg6/uCxHNq9ci
         ifXg==
X-Forwarded-Encrypted: i=1; AKwUvBx0DolgEJfZOrsY5IxIfLm2EoISerbt5U6gPSlSwxqZxW5O8xO48PPoIp5hoOsyy4dgBakPanCxjdDsght0mw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ7atVq1udPu9nTez6sC5ZvKf9dy8yFLCgKZ5gEGdGuKqBghw5H
	sGYV3+ayatFcbDMCh3OvrcS4pTqDvnj3vLB0PmqgoJLm5S9BbkOMUA5R
X-Gm-Gg: AYBFou3lucMaxJ3afChD/dfeFpDR2UnWgjl3JW1svvmxQucaWXr7QHkwntleDEo4cxW
	neotlIcYeOqgoJHl//+C5oH3izDYRFa7tGLiR9Ek+G15kmF9Tjv4i8NcHydAAGbxnZ2ek7ke5/w
	2zn55gGOLwJEuv/0Q/4ss19spcWag2FR6UT0YvlMCTrGG4nR2pN0GXAeSzfHPpRnC1+dUG+/Bj+
	6h2StGbtbazfOvXQ0+e97m6/lIyl5oGqvZ0/R4v4CooS6VqudiJIlm5Gh/6mzxL4z7q9e1iscLP
	TwYoyxje6A2+88bbr1M9b9HWE1v80oni3QNyVSZgs3a9HigtuOidKStl4G0ifwkHBmFr8RTVNP3
	9yw4JmV62Ev1/Sxcd/i7MqhyC0GCFE2mxBthljeprSLPiozTrc+KcQ2R0eBAYX/6tkO2EmCLOfA
	A5uk7KDk67SR9orDLZaSTd/3quT2gV2aMFuhVwFGhwJTkSlO+ECMCuqelMe4NdIU8N0L1BWnvpz
	ixEdaYTasT5Tu7SyAjamoF30BFcdFZEXLAB4phASQe7hMkko4fUJwTn+TM=
X-Received: by 2002:a05:600c:8a09:20b0:4a1:9687:bbd4 with SMTP id 5b1f17b1804b1-4a19687bdcamr244753945e9.31.1792079018628;
        Thu, 15 Oct 2026 08:43:38 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd640be0sm61940825e9.1.2026.10.15.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 08:43:38 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/2] vsock: SO_INQ for stream sockets
Date: Thu, 15 Oct 2026 16:43:32 +0100
Message-ID: <20261015154334.3217358-1-devnexen@gmail.com>
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
current packet only. Accepted sockets inherit the flag from the
listener, and the sockmap receive path does not report it.

Tested over loopback with vsock_test and vsock_uring_test.

v2:
 - move the SOL_SOCKET options to vsock_sol_socket_setsockopt(),
   with vsock_custom_sockopt() and a switch on optname (Stefano)
 - accepted sockets inherit SO_INQ from the listener, as TCP_INQ
   does (Stefano)
 - use || instead of | in recvmsg (Stefano)
 - test: check MSG_CTRUNC and the SCM_INQ cmsg length (Stefano)
 - test: cover inheritance by accepted sockets

v1: https://lore.kernel.org/netdev/20261012235524.41468-1-devnexen@gmail.com/

[1] https://lore.kernel.org/netdev/20260923184008.153541-1-devnexen@gmail.com/

David Carlier (2):
  vsock: support SO_INQ on stream sockets
  vsock/test: cover SO_INQ

 include/net/af_vsock.h           |   1 +
 net/vmw_vsock/af_vsock.c         | 111 ++++++++----
 tools/testing/vsock/vsock_test.c | 279 +++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+), 28 deletions(-)


base-commit: a4057f51efc2b74ddf46721e83f45e9efb13649d
-- 
2.55.0

