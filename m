Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6A265CC2
	for <virtualization@lists.linux.dev>; Mon, 19 May 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638423; cv=none; b=gIvFZjvxdn6mg7GNug5d6GXUnZmhvAJozXV62hpWtI8mVYQfj0G61iCBVoJpvu1PrZoB9XXl5qMYweuORVxGEts3KQjQDKKjyqni3LlUJhYNzepLUeM+OooGbgSqHctdjFJ2A0iu83uO3Mxs8qJBL9V7SKj6FpEe9gHEulcv6JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638423; c=relaxed/simple;
	bh=5lYdAnViKm8ZvLr7E7yBx5ATwm/YFLGHyRh1AvmTXmg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e7+U7vEqy73Ri+MMXh+daGAvnLUSV7SZOJHw9OP0R6LU5itkFOq2AYKHlxZ0pDCZd/3taWnTZWf2DfmE1qYP2yyOWgakbMYVLVkVS1Xm4Zysr5/0PsXo+Pa+wpbtPLcpVt7za9CBEqMuACMluRnipyj9TKX2gj6dnCoFKnCx38I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWhTIjTO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWhTIjTO"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso1460001b3a.3
        for <virtualization@lists.linux.dev>; Mon, 19 May 2025 00:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747638421; x=1748243221; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xs2BEGm0Er+d1dRSYQn4lykSzo7rxtonmxLe+6KSkkg=;
        b=XWhTIjTOT6bQjEVlFT9Heu95NH/JjrcyLGPljoAMG60EZ1Qkb9EXmuE5/4wnG7kDF6
         0BX3AyecZ92VSX6nV6uaiaAGUdyl1NRHINCcDwXt+mus/zIHjpzNbSgT5qyqA0PCUcOz
         dt6R7jPyJ+jkzTs+iJUCCltzk0R+G/XxUxIz+3kMbK9ej90YuMEavEPb+JmAz+xKrdXs
         Oy0cbqfe4xzZ0RptmKNoaFwBqz/tRwB733v9sHH0eeq44WW7a7EXUARUDxANQillA/Hj
         csJFwpm9yb8c1VaekS1V/EU3d3QaTdI8koXOnkL/t573YIqiaedvS0Q2sSn7Y1I9vog+
         7BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638421; x=1748243221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs2BEGm0Er+d1dRSYQn4lykSzo7rxtonmxLe+6KSkkg=;
        b=NmKLieWXNhOmmL9C8WJEb4zLnjjQOnwoZYIhyDLwN0lfmPYWfmeZpKhqwzexYLVI1Q
         p7GwMsz4uRsoLQzrbZXx8P4MhANogRuc2cDRYxq3w4j1lq8u2FHRSnmEIEyyicEbCXQH
         ADPzz750esk1VBXQiL+2ryWWoyYDG2Kl90XIYoCCII2w2Dwtx0tlI92+60SwvKaqe/nI
         BiEw+EDwUxc+j8lUdMcirbMR809C32jHl2i1jpA+Ru+l48GvoWd9zP7S6ebAZl5uu6Yd
         Apf5JwiOR/KyUcrS2UR2qIVtw42nPsi1FXrLRY4JOsWYGgFCv0tm5xp2Cij59oodLuYH
         8YLQ==
X-Gm-Message-State: AOJu0Ywp8b6maH3GCurh/v5OJ/GaBfEbs1606XI30L+sn9W78/M64psp
	3seiqaozeJEOeb2mugQx1EQG83+pWWPxnKuwCSPpbrHf+bHWUlyMSeG5
X-Gm-Gg: ASbGncvr81441SNFs/LRyP8I+pyZkc5opJVbrLZ3n2afTNe7PLoLH2TGsqArt/sEhtW
	zB++FidR/pOh9P+S4UWTl+QeqBlIOtg3i+capmpIdBeYzub3Ki3vgOH3UutYYfFHgJ6fDwBZhDw
	CwtArMNlM3ovRxCi9ytCCr9d+KHElYjzF/QFx8usLVidia9R+2nQDqOvDzBF+fSpW99aoR5OP8J
	uWbTFtdXl79pgou8QEGdT7nBj247EMcJ+/uOefMG1kc+WsN+bCCZpa5LZbt7E2i/sS3Psi0kwN6
	NjComKB0Ot6slTmibOjFf/yp8v0w34S78Wu6EAScPOEZea0jJK0raqykltpwEoezQgVG23QkmA=
	=
X-Google-Smtp-Source: AGHT+IHA8A2vT2UvBCutX6PgYTZMcsbF6MTlQsqWarY6LSxYLDm0eBIJO+c55zh4t9TegLcLV4EIcg==
X-Received: by 2002:a05:6a21:33a5:b0:216:20de:52d9 with SMTP id adf61e73a8af0-2162189f109mr18185129637.14.1747638421326;
        Mon, 19 May 2025 00:07:01 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a0120sm5574336a12.63.2025.05.19.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:07:00 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	fupan.lfp@antgroup.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	stefanha@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH 0/3] vsock: Introduce SIOCINQ ioctl support
Date: Mon, 19 May 2025 15:06:46 +0800
Message-Id: <20250519070649.3063874-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces SIOCINQ ioctl support for vsock, indicating the
number of unread bytes.

Similar to SIOCOUTQ ioctl, the information is transport-dependent. The
first patch introduces a new callback, unread_bytes, in vsock transport,
and adds ioctl support in AF_VSOCK.

The second patch implements the SIOCINQ ioctl for all virtio-based transports.

The last one adds two test cases to check the functionality. The changes
have been tested, and the results are as expected.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>

Xuewei Niu (3):
  vsock: Add support for SIOCINQ ioctl
  vsock/virtio: Add SIOCINQ support for all virtio based transports
  test/vsock: Add ioctl SIOCINQ tests

 drivers/vhost/vsock.c                   |   1 +
 include/linux/virtio_vsock.h            |   2 +
 include/net/af_vsock.h                  |   2 +
 net/vmw_vsock/af_vsock.c                |  22 +++++
 net/vmw_vsock/virtio_transport.c        |   1 +
 net/vmw_vsock/virtio_transport_common.c |  17 ++++
 net/vmw_vsock/vsock_loopback.c          |   1 +
 tools/testing/vsock/vsock_test.c        | 102 ++++++++++++++++++++++++
 8 files changed, 148 insertions(+)

-- 
2.34.1

