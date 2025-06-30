Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C7211A27
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269132; cv=none; b=H5SYBNqhTCruj8uid5RMq2b/Y0EUePOBYYTM5xivrqPWodAaoRjDoP4ZT26MjKUTh1hbyb2qzgZ50jEVj/86L58Ao/In2cKlc1Fk43+p3FM1YEwqkihvT2gM6O83GHK5vNzh8vf6fhdQTmAQ8mhEaVC8PjDm3NfS3mVu0H34Sfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269132; c=relaxed/simple;
	bh=C1EHD1z59F2SyLvaExWmmS5+b7cLnftKwrKslD1pIe4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qCLQ14vZ4WNW+a8yY59Ur6T1t8TE5BT77xtTmw4waoNDL2Njr1ENEt94EV7d1XFBPdlJ4P24yZx2EE03UwBVOwkITEB++Pbeq6a8z3mmEMZnnuKtpJOH5s645fwCHtNCeiyBG0/3qCWku/nGbaGeuKUhfw63ZC9nWRrpmevYkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjvntr6t; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjvntr6t"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b34a71d9208so1320240a12.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751269130; x=1751873930; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMFps7gQrYkD6CPu+nOWqI3O3a/AKcYoOahC3/xHR+8=;
        b=hjvntr6tHpctGvZOT2cmMaWvRPy15pTUcDCz4coT38UcvWTS4tSllONVAO4TVT0fhJ
         i9cM/+27kbnu6U/W7S7qsUGDgK7cfpUr3wpI+VavKHg/QJ1J6uxy4hfpUe9eVV7/AJFF
         rs7NOoGwaC0QX5s9a6IMELJYDvl6f6hYzpIQow8a2N74cC23I3b1WjSUHQZFVqA/VSTh
         2sDHXoELxYoRsdXpJ36v/Il6E9McsgCFcD0B3S9pM+YVPVQ5+Bdj8r1KcHLwaLF6Pxlp
         bdIEy/vrGD7zWUQVMUNk8oBtd+tW/ByLDGM3EsSb/a07kGJyizOS5cWR4csv1mGxNMo8
         egQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751269130; x=1751873930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LMFps7gQrYkD6CPu+nOWqI3O3a/AKcYoOahC3/xHR+8=;
        b=u8shzg1m0DkWaA6bInVl2pHIAUmQV+PgEQNjehU7m1K6H+XcL1GkaNRlz+DfmMp+/f
         38qT0RehZAUey2+vJ9Mm3qtxdszGU4FYEzGnswr6xOaipqfDWCW7LtKVEwdzzRzJnsra
         AO57uKyAE8KwCfSvdImvILYi08ghIJGfEayox1tFBLhrZR2Oq42H/buFuDuepnS1M+pM
         +ZrXfaD00Q9GuPmRMLyJ0upiecbMvnPXc2SMbPvHgahkgGOWaKGPifDsO3wf6SpDeWyv
         bcIOgsWOx5X1HjuxzE7cAKsMCQh0CzyUuQ8t5BZWB82ZK/y5FqSnz0TlVp0ftyvhoudR
         w6tQ==
X-Gm-Message-State: AOJu0Yzu/EOVjisANcj030AzkoFDiDjWHCgxPhnjy8Tm1DTWeRHMFXVO
	lhCqInLY7KEEjyL5PeN8CLo+yR3LtE0c3W0fGKw1MJ9SME+UxUb9HHCG
X-Gm-Gg: ASbGnctotdX29Cu5uI1o3yZU24WOB4cYP7Qbp0Cr7SV6pTBYutLCVksGKwp1SUUaCC4
	BbWdcajS7C19+ZReW5IPFhcycIMiOuEqXkCRgMOdq6StQTJ3PPxADKPEY9BD5TQoWIqBt1oSgJF
	knnZZBxAtnqahL85TsX1GZYhDf4617uuFoSZJenpOgTXBMdEztddmrwvzkPmRKLnCbgj5SKqI+7
	KzXWTXyX08ci6a2Fl25Haz2rACLQk3Ows8tkcl0jYl1rVK+k0XCHwJWK7lYX9bwBGfmFhqu4bZf
	W6GkzISyEwZDsrd/GCut46miGmfurt2rvS2JG0L3wKVmJOQu59gaciG1tIqF1jVazLX7B3GsQFh
	MPC9wq2b1KeFcaZfCjek=
X-Google-Smtp-Source: AGHT+IEg5uwH/kF0lYf7Hq59I5MKkHWlSxwYXEhG/7GCgHeyClrt5UgqGkpLTI+EfuDwglRv5LlslA==
X-Received: by 2002:a05:6a21:4683:b0:220:245d:a30b with SMTP id adf61e73a8af0-220a17e9d75mr18242672637.38.1751269129983;
        Mon, 30 Jun 2025 00:38:49 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c8437sm8075175b3a.115.2025.06.30.00.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 00:38:49 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/3] vsock: Introduce SIOCINQ ioctl support
Date: Mon, 30 Jun 2025 15:38:24 +0800
Message-Id: <20250630073827.208576-1-niuxuewei.nxw@antgroup.com>
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

Xuewei Niu (3):
  hv_sock: Return the readable bytes in hvs_stream_has_data()
  test/vsock: Add retry mechanism to ioctl wrapper
  test/vsock: Add ioctl SIOCINQ tests

 net/vmw_vsock/hyperv_transport.c | 16 +++++--
 tools/testing/vsock/util.c       | 32 +++++++++----
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 12 deletions(-)

-- 
2.34.1

