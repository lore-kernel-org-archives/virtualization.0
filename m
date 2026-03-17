Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAB36214A
	for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785385; cv=none; b=GmxC9Y6ZvnyWIkHiejc4suZDDono5lF7uwW+iSom8Kr/t5fwCkrKbzvRdwJpEJNXl+Qvi2QGrIWOwNTXaYVYmX6JjpeL6lngzY2P0oY7NulZlqm4sAPBOCH/UTQeC0+T91SYpe+E+NNt/oEEy6ruT5qKMO1MmoeyJ8UGpj3vqRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785385; c=relaxed/simple;
	bh=ccqpQikEVGKBGw0ltsN2mllZ0nk/M9oUDNdcseB61A4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ukj+An2aZuGH0WCor2hokI87FgBqRsaFydoyDPMHsBd59bQt5JpFcRB8dUYgeoQhFf8S8WpE9KUdm31aJOH0sJgPSEjt8bMe4pcTeF11dm/VphvOnuxx11VxW2cLs7MthJqESL2i6zw9KfvKzxVwROIjZh5+GjBj1yj171OEZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QstGYSWa; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QstGYSWa"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7986e0553bdso53495927b3.2
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773785383; x=1774390183; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XDkvz71rFjofuSbw40JV4KJk/HAj2618RlBdKEjDpw=;
        b=QstGYSWacgXW6Lrzkds3ClTpwkpBT1mIQ2dhTpPXxx/he2UaDrQrLXL2MSjncSzthv
         RCVPLfy5Yku7GLc1lqMS4bPyBqg1oXEBL2X8bJ0M5wQA4nmlpCTjJyJtLerhrIqshmZ/
         NYfqcv61hzEbzSp3g2ZCIk0S7z8/e9nszzoJlcwlMh9rwxekwPW/ClTIifE8u5Ytd/iq
         wsDEZC674C42uPzEUqiB8UgH8ilC+vHJgqRty5asnOv5Zn+awE1gkjfMi55uYpYIUpPY
         TXuqLUJcUTCE54MjhZKjmJWvCCLWtswAvYmrt2q9DaYgwwjpxxTmP9nm6brBqD6zOHoN
         Q61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773785383; x=1774390183;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XDkvz71rFjofuSbw40JV4KJk/HAj2618RlBdKEjDpw=;
        b=Y6UhhYesgJHdlkF6tbmlfIuDPsKS0vtgFjyew31feDXwORNfmA8NpxF2ZOFYqSgSOD
         58/Q/ZJttZhXg0uKTcIuqxcQQNYPsbdV9sCdwXM9RhLPCgzB+SMusHVn06x2MV7tEiLR
         QHb+O7GstbcZdnEXAyjV32y4q2RM4paSz73CSuNvwJwEJjyuI82O7h78527LAuUUfsZj
         6UbWRz+REzTtXKu2wMZ448Z21xi40gtm4ZQuFMzkm9Sj3bA8LQq+RS1j5W0jJkpHCemH
         Egji/8P01XigOKdH4j476R7JBMEwRTbVWVZ7gpnwq9S2OAeqfOlYsKMe17jSPZTTO/bs
         DYww==
X-Gm-Message-State: AOJu0YyaICYohXFV/vm3ITKn6Ea/4w/CotzULfnZEdStaIQDXVA3RPjv
	JWHLvF57QAZqz4S0BA8Gbjxb6sNN97/LtW9gyUeadBwESMt+im3zGt2c
X-Gm-Gg: ATEYQzyKmMTx268fcsKWY/yHfG0b83IwOXZUaqTZp3DQ1ktTS6+m3FCQ4D7ypifUSLm
	3hMbRW4CokyCtmU1gMIDmpuXujQkPSQB4CSN0In/QUSIKRj/0aeumn9SMvDSKAwAl2vR64123ke
	4wGtY8292fiZxizzqo/uTnpFXOdbCNEnNCuIFaoTt1xuvTjzUI160zp3QVMzUkYeAvTCj1vLJA9
	TDFqerptlGfK7zdeUNtcRue0RU/6RRfG/+k+lvWXyzUBabnCIKQKUUgoZL14eDzKSdwMm46SHx6
	Nf/U4EidmonalsPn8k0VWRnrIPBH36ukV+DDCufxzq3TdiyhEXxgLfn8d7hekOEKc2SrG+Lyzbq
	gQtTwkoAMsY5hBrvQxT2cH+mBRBmUWp+4ehtEOvMkHkqfxbj8rH5acFl4oAdXKuOxINyzmHYlby
	HvdmlotueMnDVpTN7brEdIug==
X-Received: by 2002:a05:690c:6d81:b0:798:4fa4:c6a3 with SMTP id 00721157ae682-79a71dbae09mr11240077b3.62.1773785383515;
        Tue, 17 Mar 2026 15:09:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a713d1d29sm5642337b3.14.2026.03.17.15.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:09:43 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 0/2] selftests/vsock: support nested VM runner
 for vmtest.sh
Date: Tue, 17 Mar 2026 15:09:34 -0700
Message-Id: <20260317-vsock-vmtest-nested-fixes-v2-0-0b3f53b80a0f@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB/RuWkC/42NSwrCMBQArxLeuk/yKdVm5T2ki5K82iBNJC+ES
 sndxZ7A9QwzBzDlQAxWHJCpBg4pghW6E+DWOT4JgwcrQEs9SKMMVk7uhXUrxAUjcSGPS9iJcVS
 3xffezOOgoBPwznQCsOIBkX72XmDqBKyBS8qfc1rVyf/oV4USvaRBX3tn1GjuG5X54tIGU2vtC
 5rA4hLLAAAA
X-Change-ID: 20260313-vsock-vmtest-nested-fixes-918fd4d3a961
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series fixes a few issues trying to launch vmtest.sh in a nested VM
environment and were discovered when trying to prepare the tests for
netdev CI/CD.

When taken together these patches make vmtest.sh work both on bare metal
and in nested VMs, regardless of the outer VM's user, coincidental path
overlaps, or filesystem settings.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Address shellcheck warnings (Paolo)
- Link to v1: https://lore.kernel.org/r/20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com

---
Bobby Eshleman (2):
      selftests/vsock: fix vmtest.sh for read-only nested VM runners
      selftests/vsock: fix vsock_test path shadowing in nested VMs

 tools/testing/selftests/vsock/vmtest.sh | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)
---
base-commit: 8f921f61005450589c0bc1a941a5ddde21d9aed9
change-id: 20260313-vsock-vmtest-nested-fixes-918fd4d3a961

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

