Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C823496F
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270264; cv=none; b=kK8N3mWZrc+OKAt5wBN3D7XsrEajFw2xnPsGBJ3P0o9xsWdRXSUPi4WRf3S7BOwB1gskA8auUziRylGd0uJw5ZqvLDZ9H7uwcF0aGno6OP9JUx6QHHWiOJjCJpw4586/nghkXEXRm1aJ2NHNMYn01sBUfsmc7PKuX6Y2D6vHiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270264; c=relaxed/simple;
	bh=cV9kGGtSpuj9ayDd59Bcu0FzngJmMJQI55Uv93VBVqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D0RJ7WXuukFogXZ5xWZGxq9gbrcB0i/5NUaPsozNC74xYwt+FtZ76HQzQ8clQINmp6Kk6kEhGhvW+tEn85J94DM2vOWUIlKppEISwwdcLWCrBnZTjb4RaQFMoRkIq+w1H+cvgwPQKqWEhQ0tv81OH6IGTHMoM+dXQ9Hjg1n8N5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=io+sLVK9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io+sLVK9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4715965b3a.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751270262; x=1751875062; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bD+6aG4x+JD90CmHGtgHXlJ8LrN4y8VLK/JYbhDdraM=;
        b=io+sLVK90tub+Lzyk6WYEqSR8oofhz8Trs3jpMKPgAfj8Du8X2LntdCq7o+hkxz70m
         MhNb0cxCFs3hubOYcJ0fNtQ4UQwZA3WqQXXRcDrNUtbJH2Cub4PJNreSHGGGAFAeXzqL
         lg33STyX1MCPXBWdKoNlSM22EdHWm2c5ZWaTl9vYXWqaK513zGerULM8JlqwAS32JGzq
         H7R6/eGjXbytEaqKaSoRp9539IPvcAIol3PQRF7qk2Vl1oWeJ2XCpgrDz/ZRJ6B+o7lu
         34zicm80fPL67XYBMI2MPnyMVXcnY1GAjEaPm1KHvsvrzl5YSh0ZCcBd9OM6e9GBIgvv
         J4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270262; x=1751875062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bD+6aG4x+JD90CmHGtgHXlJ8LrN4y8VLK/JYbhDdraM=;
        b=R4/9QCmqt1kVnONFZIKdDFYmoTv9IyfVs3KkMQt7PqlDJP+u0wOTPyzjgnIWRigk6c
         YW4hNco5cJUKa57162Mqm+kJBZXENiYKtxCt0/wW3zky+v7AUoMogTajLg0kvdQgSwcc
         YCqDu/sjkr042MYEQmtaoZn8vLSrDogLItw0UtWcAsUcClpdMcEPFjHLptwLMOdYivba
         xrTajhdvuWgN0Mi0W83k87sIL+OP2bKReqCDWwwJET+4snP5teWOnx/foEtJ7szFN5RW
         ZpcKlkk5umYpUyF0hBc2bo1WPPG6WbgwmJ2JiMYuEChqKC16u8QHfiyj3wr3QEbA1x8a
         0+SA==
X-Gm-Message-State: AOJu0YyBRdhLzwGHciv7HPA1QeMk3VhLPDyb8Uz2mO8qiZoNGt9xn4+V
	aM2rPNW2qfhxcsN4OLqiB4mCPRhwi2F1El/1RQ8Svku2qIsaqnhD+vnX
X-Gm-Gg: ASbGnctVY4rSSqinZ0/48CkCZRqlWOTW0Llc2W7QlPGDmeMLix5QiS4UPxz1zw3DCRR
	zW5jKPEjukNcTaWEaJuV9rigWeIB8evOKFXBTa0QKwl1MeULX6fp/9BMtOIffpaHFhKzPAMDFER
	zsZ0T1WLvpeYYVI602cXNSjOvpKMhusTm/q0/ovKpQi2OG3rqpURQhV7gUklrkVmZashrxlYi1o
	dIV6K0l203rOyrJYvfpOMpxUIryapPZ2lcHkP0jfs1Zoenf++bzSThePMuYi09/nnVQJxwqZ6p/
	AydiD/c6tXIY/Iq5bhLfXDlS5/UZRbnH6LdpcW7Woy2HrRHOTId8qVXuOAycch43q5lrypvmNLn
	l4nUbF5LE
X-Google-Smtp-Source: AGHT+IEEvimpY6QSzTZmdL3WxdfP/MAUUSc9hilg6q/dGJ0NqSBc7Y1vD/GcdGQYhgCtqpN/c3inzg==
X-Received: by 2002:a05:6a20:9194:b0:1f5:7b6f:f8e8 with SMTP id adf61e73a8af0-220a127661amr20551081637.6.1751270262432;
        Mon, 30 Jun 2025 00:57:42 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31db02esm7414931a12.63.2025.06.30.00.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:57:42 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	stefanha@redhat.com,
	leonardi@redhat.com,
	decui@microsoft.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [RESEND PATCH net-next v4 0/4] vsock: Introduce SIOCINQ ioctl support
Date: Mon, 30 Jun 2025 15:57:23 +0800
Message-Id: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
bytes.

Similar with SIOCOUTQ ioctl, the information is transport-dependent.

The first patch adds SIOCINQ ioctl support in AF_VSOCK.

Thanks to @dexuan, the second patch is to fix the issue where hyper-v
`hvs_stream_has_data()` doesn't return the readable bytes.

The third patch wraps the ioctl into `ioctl_int()`, which implements a
retry mechanism to prevent immediate failure.

The last one adds two test cases to check the functionality. The changes
have been tested, and the results are as expected.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>

--

v1->v2:
https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
- Use net-next tree.
- Reuse `rx_bytes` to count unread bytes.
- Wrap ioctl syscall with an int pointer argument to implement a retry
  mechanism.

v2->v3:
https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
- Update commit messages following the guidelines
- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
- Move the tests to the end of array
- Split the refactoring patch
- Include <sys/ioctl.h> in the util.c

v3->v4:
https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
- Hyper-v `hvs_stream_has_data()` returns the readable bytes
- Skip testing the null value for `actual` (int pointer)
- Rename `ioctl_int()` to `vsock_ioctl_int()`
- Fix a typo and a format issue in comments
- Remove the `RECEIVED` barrier.
- The return type of `vsock_ioctl_int()` has been changed to bool

Xuewei Niu (4):
  vsock: Add support for SIOCINQ ioctl
  hv_sock: Return the readable bytes in hvs_stream_has_data()
  test/vsock: Add retry mechanism to ioctl wrapper
  test/vsock: Add ioctl SIOCINQ tests

 net/vmw_vsock/af_vsock.c         | 22 +++++++++
 net/vmw_vsock/hyperv_transport.c | 16 +++++--
 tools/testing/vsock/util.c       | 32 +++++++++----
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 12 deletions(-)

-- 
2.34.1

