Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE9381BA
	for <virtualization@lists.linux.dev>; Tue,  8 Jul 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956611; cv=none; b=sM362F5cM85Xi80cKOxA827banHgDLupG84W2lWEzxqOy6EjmRw3GPzs+XQ+WoiVZfZIobPYV/8xPUQ2exqDtVHq1ewA3/EJY8Aqqgzto3RnjdDmfX6YoMC491ZLr9BV6XILKsN76mELZVU+SgU4EZaRXTVqkUJdinzJiini3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956611; c=relaxed/simple;
	bh=Wv2kT9Ln8pLYeJZZzZEW3fma7QpVSKp+868WRyuBk30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D320qzQGbAzWG9ylcz6vDAIGfh7GT4V826VMTvNrqW/NC7INExsgtZwbpvGZxlKRVyuo/Sskx8OJaI0g5VHwbiQlGK3+YOHavJaEONZLPBc8SPca2ehqiRNjiUnznhNh+34Z4pLD7JpguZpAjiKhFdafhjn5Tl4VwW+hh8lzmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=huxvKL5E; arc=none smtp.client-ip=115.124.28.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="huxvKL5E"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751956603; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	bh=aKt2ISTj4W3hvabaV4qI8Q34/Ft6hEq9xsElq9goj8M=;
	b=huxvKL5Es8NgkJ1zzlWpO6zkREKCZN7SUQrd2XTVP8sqVp2wZAe7NJXjS5vBSJC8cyjWJj2nsPpCWPl2tJi8iAfXN6rNvuoxtLuiun7C8RFvSeITGmBTJokzkPeaO7mhOnWUQ5huWUoDi37/e4NqMqzDlCYG0ckOwfwkyOCBsmk=
Received: from 127.0.0.1(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhGPAOy_1751956592 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:36:41 +0800
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v6 0/4] vsock: Introduce SIOCINQ ioctl support
Date: Tue, 08 Jul 2025 14:36:10 +0800
Message-Id: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFq8bGgC/z2NQQ6CMBBFr0Jmbc0EbKGuvIdhgWWEWdhCWxsM6
 d1tiHH58l/e3yGQZwpwrXbwlDiwswXUqQIzD3YiwWNhqLGW2GIjimDYrkJTrbHVje5QQbEXT0/
 ejtIdLEVhaYvQl2XmEJ3/HBdJHvuvpv61JAWKbsSHVkPXXpS8DTZO3r2Xs3Ev6HPOX+D/ni6rA
 AAA
X-Change-ID: 20250703-siocinq-9e2907939806
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, niuxuewei97@gmail.com
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

v5->v6:
https://lore.kernel.org/netdev/20250706-siocinq-v5-0-8d0b96a87465@antgroup.com/
- Correct the author
- Fix a typo in hyper-v fix

---
Dexuan Cui (1):
      hv_sock: Return the readable bytes in hvs_stream_has_data()

Xuewei Niu (3):
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

