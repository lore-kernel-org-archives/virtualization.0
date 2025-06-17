Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2C2264CA
	for <virtualization@lists.linux.dev>; Tue, 17 Jun 2025 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750136043; cv=none; b=AK+3qN54oCNKtykD08a+kmydYEjkDUbImjUholTfvYJbgNt8X8gy3tXAGJnsoAmUaT/40dGkcYb6DSyRTH/Ebh8aaw/tc8AonAjAgDGx5je6YD6NSJ8cHj9mW8ACVbcHqTc2hDBRICSZSo08OEl5eSxtq2gUDwkr/VB66Ld/DJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750136043; c=relaxed/simple;
	bh=kMm7lgYQCIkhpkVmH9clHM0HFhSUZpxy/D1RGQ/mP4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p9VaPGz0ckkN7WNTsu4UsjCQTp3O37UAEji609CJA0l9BYmDXTptsA/SKzlUJR2Ak5kjvwyXtV4R0f7e3Mb2FY/g8eE+egXtRQ4ewKzT6JIzJenAdQTgF/jYK2SZAMJVbnJ2onMfXW0CnANqpEC1IRGV6jl95ZHvRkxMpgQt2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koNQohA4; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koNQohA4"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748c3afd0dbso824274b3a.0
        for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 21:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750136041; x=1750740841; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ux2aPBTIrlfQIKX8kOjNghDVGII2fwjUeeGrkzAJB28=;
        b=koNQohA4+1VHM5uIry8ewpcaQTbUEX64loKfy54qKy3TPVUZVZ3WRsPoVU0vuli9V7
         RjLuaAW/HYKl/yUp+wmKhzT9tqsPTitRUATkEp2lopscvybjNIOwoiMlRzn9u5UF4gRJ
         Q+78ogod0rlbKfnTnR9VlyVhcJjr/0W1tyLtOBU/q7Q+khZQrIa7iHaRHzgbECWoHqrO
         mlH+7p0mvm/378qXHm6vLrCpObii/UuPV/ls6FCg9wHxOM8yCDEDvY2ivyK88GBDUl9p
         aSfTWCPgqOmNb9WPdpLGk7xohs3jrVeJ4HiH9MHnqqvnKAJcXzRcObE1HjYNQGp20/uU
         M+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750136041; x=1750740841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ux2aPBTIrlfQIKX8kOjNghDVGII2fwjUeeGrkzAJB28=;
        b=l3oK3blkOCtp1fz3+LZmBNy2Ptnx8Zyoap3+LYN0n0bPUjDicbKIM0yd1h0FvtnXOO
         rPcI/cLYu8JYUdl7W3zd2fTbnff1T4O9xvPpCVRcRPted6mvx0PEevcFgISzdzGun6Vw
         jPSFCMLWDhdwJ7jYG5cXY0qZyvj2mTHcD02aGOwNyevLQBnTx4UtdekXwd4KJsVygwbt
         J9yW48gEEoKb2GDcby9KWhZyTj6bEsuMdVD39gJdUu8knIMkB3Qny7cmYzJhse51f5bx
         lx2IiltmJDtIkXKyZb+BvpWwuDOvYMJ1YH1SXQP/fb5iBimhfA7PNavxM2/Y0tqcKEYo
         QuBA==
X-Gm-Message-State: AOJu0Yxm61bbVK4VHWFg7WRj22yTgY4AisxE4/cf/ogjvaf2JdICgLTA
	4QVeaBg3VMLXZktYXPqo4X18I7QGKVzW9g51Yx6vNDljyAqaKwNLl/DI
X-Gm-Gg: ASbGncvj5YfLa3/CXjB32l+3DKEUeUoa7QLvLM/pFrit4agQ5vbCQ3OabsIwZQLIF8d
	KaXoU4Nsn1EJojFnU8TkJw5NyakNdAPxNH+D87y55bBioOs+oWUiEnj8NJs5ZtJ19Nh1QC9cooL
	OtFaWGHjAibSr0RlCwd9dBiV04k0aNppMyvHnj5qK2VS2xSjZ+7IPu3Ux2bROHw2+mrJq2Bb3F6
	OxanW+C+Qc05c4thA8iLUbg+rBPRIxz1SxBbHO9i6KUVBObG29yzau9t5bcC1vHfTxGR7+CpwWv
	cR1waRjXu15NqQWeg3SinOkALwyCzsFGgxqzpwW9RofDjBLRw4EQHBwgKmjOs5VFlkHSj0xyGri
	32PRRpreS
X-Google-Smtp-Source: AGHT+IEL2/Y3YEJoexZQiqPz6UZhDVycLFbjekKweKWb+g9AdWGm8CY4Beq+i2yz4rRVpeHFYam8DA==
X-Received: by 2002:a05:6a00:1823:b0:737:9b:582a with SMTP id d2e1a72fcca58-7489cfdb64bmr18949764b3a.24.1750136041147;
        Mon, 16 Jun 2025 21:54:01 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890005f47sm8132852b3a.51.2025.06.16.21.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:54:00 -0700 (PDT)
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
	leonardi@redhat.com
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fupan.lfp@antgroup.com,
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v3 0/3] vsock: Introduce SIOCINQ ioctl support
Date: Tue, 17 Jun 2025 12:53:43 +0800
Message-Id: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
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

The second patch wraps the ioctl into `ioctl_int()`, which implements a
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

Xuewei Niu (3):
  vsock: Add support for SIOCINQ ioctl
  test/vsock: Add retry mechanism to ioctl wrapper
  test/vsock: Add ioctl SIOCINQ tests

 net/vmw_vsock/af_vsock.c         | 22 +++++++++
 tools/testing/vsock/util.c       | 37 ++++++++++----
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 82 ++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.34.1

