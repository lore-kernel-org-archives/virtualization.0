Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E115ADB4
	for <virtualization@lists.linux.dev>; Sun,  6 Jul 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776629; cv=none; b=NDULEmeKdcB3Xez8DcvB3ftLAW/gYFQLMMPxEW181ybdeRTgA/3lrkYVyrW3gRkNQLh2t9eMH+PS90V1o9OmpGX652wQkfW7yldfXwJQLt4xnlV1OMoHQYfCV0sPTi5TUImoZutbDRknX/DRDw9hC9M00P1G2s8yXVlynKZWfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776629; c=relaxed/simple;
	bh=RB96hsETxyFhkCY3Rf/ba9ONKkbVHSSjgVT5eGABabk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vz1QKALa8gfR/BsKF+i56i661VXxtrEgBDqyAFCFJi/kiEpKZ+KPyskpLNLkmMD90AvLYPkbZ3JFwjRr5frQeWwdLXI8BSVAmjN9klGYrx7YzGwCYBS5QSOen9fGBA+MWVR/uNn1c626N9POJY+KXJFhX6h5Q2QlLK4A2teEsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdJPed74; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdJPed74"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1073055b3a.0
        for <virtualization@lists.linux.dev>; Sat, 05 Jul 2025 21:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776627; x=1752381427; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDDm71p/LyQ0DztRLcG3POrUg3Q40Pul2j5qon54l58=;
        b=MdJPed74dpvIRDMiJ8FNFkUSF9feSWYPfn54lzzu3p/IFiJvhSkGRnUx5XqSL7gIhM
         +jP9vgQl3Oa5HMImBInkkOQltFKTvFKQuVHcAlX/yPvl4MJOk/hoB3NjcVb7qOX1Ts+8
         B4srgmmNAFyp6rjU7HUPqpbPLFkUIw3rTKCdQb0r5wcVvXLm8nQoRIttU1jLJPko5Btq
         8o6ew/n1z8s4AkZMZogrVxnGPHLXTluoF9dOXEk/+VEspPUEsCpLfnt+H8wB+saz6OqS
         e79toNBcvjf1mfJVvJQ89Hm9dciS5Uh1NB+Wxth0LSw8FNl1ROH9jJMFgfOm7AlCrLCl
         1ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776627; x=1752381427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDDm71p/LyQ0DztRLcG3POrUg3Q40Pul2j5qon54l58=;
        b=JQn1dw6K4f26YdQwKOVN6jeHDb73ddJMhVdt8NLwkQB5Sw2G/Q3FJC4cDQCIkEwQFw
         cP7bTxfzhkP7lGBEOfTejq5RuVvZKmR5eB2sCv3W5qndhNWVSTxNjndR5P4rsP7HWsbO
         bX0yS3kO3ac6YY/Qg1GgR0w2I29f3Thj/37aKd6NnJL7MhwNaeLxkdYeTCd6IBf28hGL
         +uFBEHP+yGppfFOnvk6lU5QRL+2DjhXfhx3ekb44fUkNH3lxd/AKEdk/xobxeGtGXk/L
         SEUfv4Ii/5T9JHE1f0mmi3SrOw2DCD4yV8KdKNpLMEyY/g1BbHtZRuToO97ot5AtnO5V
         GZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg5a6XCKxyB2Uwr9qIVvq8n+D+IJXn+osRqgAxdCvAcydYzOVJYp82+7adcN80lOsSp2e6FGeYCGyLzg/6pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq8a1UBoYGfGpLRUXUtCauIHJ4usPmlzPqUW9OhkwnX8U/1dLK
	ly2v7j3jy2xw7GR8CmuflL74OghmvvIstJqvXT9Rq0IC5wBiU7QqvbWL
X-Gm-Gg: ASbGncuBK9XHVUTk7VxkpFRQ5QsW9/eW/S0x7EUvH27HQUo2svAE4pWYAVT/cHtH/F8
	N21+gSXRVF7yA3vFIU2I2PNFRxwh3NxHFBxfZ2Vzw37b04gU4aJA9YW54A8oUorAKs3pjYQDEYE
	maGMjGoyk6Y5vWYm+kQkwHFNSUgOjy3pjDWYF2TYCH3IqICaeZQU/fo3O/9dGeITDFCy7wpaqIm
	3EnDXZUWcmjZbrjvEYLZk9EKRtsZyy9p9b2UXywtWK3tAqOm37DcBEnvmAAeX1yijXYO0EOV+qi
	TqTyheeYlRC+w3f4fe+jxTbKfWZRabNqX7i8wHHNzAgYsJZIe+0Pjp7q0hUU0YrlRw==
X-Google-Smtp-Source: AGHT+IFrSnC8xZNgvCqQZwnhSbar6h72ees0YA62Gk1LYF6Q/EVgY/OklZdSIQbVWRaludW1bdB8hA==
X-Received: by 2002:a05:6a21:6f09:b0:216:6108:788f with SMTP id adf61e73a8af0-2260ba7221emr12156252637.35.1751776626886;
        Sat, 05 Jul 2025 21:37:06 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:06 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v5 0/4] vsock: Introduce SIOCINQ ioctl support
Date: Sun, 06 Jul 2025 12:36:28 +0800
Message-Id: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEz9aWgC/x3MMQqAMAxA0atIZguhUrVeRRykRs0StRUpFO9uc
 Pzw+AUSRaYEQ1Ug0sOJD9FwdQVhn2Ujw4s2WLQOO2yMgsByGU/WY+cb32MLqs9IK+f/NILQbYT
 yDdP7fmU+x+FjAAAA
X-Change-ID: 20250703-siocinq-9e2907939806
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
X-Mailer: b4 0.14.2

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

v4->v5:
https://lore.kernel.org/netdev/20250630075727.210462-1-niuxuewei.nxw@antgroup.com/
- Put the hyper-v fix before the SIOCINQ ioctl implementation.
- Remove my SOB from the hyper-v fix patch.
- Move the `need_refill` initialization into the `case 1` block.
- Remove the `actual` argument from `vsock_ioctl_int()`.
- Replace `TIOCINQ` with `SIOCINQ`.

---
Xuewei Niu (4):
      hv_sock: Return the readable bytes in hvs_stream_has_data()
      vsock: Add support for SIOCINQ ioctl
      test/vsock: Add retry mechanism to ioctl wrapper
      test/vsock: Add ioctl SIOCINQ tests

 net/vmw_vsock/af_vsock.c         | 22 +++++++++++
 net/vmw_vsock/hyperv_transport.c | 17 +++++++--
 tools/testing/vsock/util.c       | 30 ++++++++++-----
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 12 deletions(-)
---
base-commit: 5f712c3877f99d5b5e4d011955c6467ae0e535a6
change-id: 20250703-siocinq-9e2907939806

Best regards,
-- 
Xuewei Niu <niuxuewei.nxw@antgroup.com>

