Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C0C1442F7;
	Mon,  5 Aug 2024 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838632; cv=none; b=XM4L+cQtbIwhXw9Gk0jRK93F9pSgfJ/WBwglv+o1DV2nPFZKGvRGHW17ndP51glcbocpAkJp+lAZrODIWBSGvy/u8171GNXjHc9gwGUtitp3PSVrPpTGA8C5K8sFI6aEu9kHwG7J2T/uFqCdDr6PqUIlJLNB3B5tXVKARt9Tsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838632; c=relaxed/simple;
	bh=ZjgDYjq7powx6dku1RjeF1PGGwTeU3pln+4TmeKsj4w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oJN17daE/3pmlDaFXy/xC5Bz5kNUOZ8ckF0PV2d0i3GgwSKXur9IneIwoOqrdqMGyCRdgGPHr+z2CSimAjJBe7wn+VdP6Nil5FhuuXZIgxtL5Q7oKu6s1HFKUsU3b51A4H+yiGxBBhrH2zZabGTVTPHQxYxfpTWEm3nHPIw9tSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csYKHGs/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csYKHGs/"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so4839273a12.2;
        Sun, 04 Aug 2024 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722838630; x=1723443430; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZjgDYjq7powx6dku1RjeF1PGGwTeU3pln+4TmeKsj4w=;
        b=csYKHGs/FGscfc1TUEfklE7YKGTtz3Gim0xcFKfYFOi8oqq0Ps19RJrrPh0w5Po23V
         5XtT+3Wa55PrEFG8Tx/nb9AeKX2qKv/Gg3ezpCJpXkNCEg7uDnWM5RIQR9F5kHWenJFp
         yG29oZ4/VSfj2WrrnZLQZCybtd+kcRmfbkm3u9s5Us1Fx2u16UXdhIBspiKMKB3lJc/h
         zaipXmWWUnZ+HVBj/mpAPnqR0QXsFMrvJwztjSGIzu4w9Mj3ZZPBBtliTwd/7HVO71C8
         oE5Rss5hw7XmI5u2dw+EARRaKV+GXQxlO4cZ2cKP158quyjuJIm7Fe47H1BhRsneVXUN
         mN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722838630; x=1723443430;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjgDYjq7powx6dku1RjeF1PGGwTeU3pln+4TmeKsj4w=;
        b=W4cpkT+S4BvmcKp+Qulo5ssDBNAbI+NLVG39J42XIfnXrAx4GvUM2M5wabB0TD/FWz
         wcErW9pXIZxtmr3tssmL4Vzbm3xblXL+DGw8vUe7pC8kUz8fC5SzQMgf9IJb7kcw3G9Z
         kg86nAFmqaeqlAz0WExDyAlhPqSvD/ygjkkdJMHBPht/phAY3eDmUpPJzlN6BOHsD1Do
         nBqE79pF6vkD/ib+CKpwIg3dZy1KEARVxP+DuAwzpAI3Ka68VRmq/HvTVlBCwZjBDmpb
         KuQVoEk0ZNCALKYdKsgcBdixi+gLFtTlRGJPNc7Zs3+q7dGK+geJ6x9xHCGv+NEHF78W
         JyUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0x8sbgRIjtuLR+18vUptI3NQjKVGFD27pMPAQTVvJcytKafSQE5hxen+l8nvQYJgwHFxdIW1WPly9WJu8r/b7D6rVeJv7MAJawUYh3gSBqs85vBGyzU5fDEMrp2/1jHVt2sFPkmwZf7hUg==
X-Gm-Message-State: AOJu0Ywi+ERXgurBWuTDMyHNqBjRhhU0n4t0TvyTJIwWcq4H1S/1A0LW
	NfTk1FqTXs0qYmeobKa4Q6RN9lIvlkV/IUyR8tmeZaAI8fj3rhnApCTFhujW/IR95tOzDdemgSg
	WG48SOtBamZgOr21TilhwNwxkP/I=
X-Google-Smtp-Source: AGHT+IH2X+IzhQIlgRtIy+23FBJcyC76pAnuCJKL1BEcOA5ltqEPwE/yzKrKToEs9l3ENoVBbVuHzWjyCgNPj4ajEAM=
X-Received: by 2002:aa7:c50e:0:b0:5a2:87d3:6ee6 with SMTP id
 4fb4d7f45d1cf-5b7f57f41f4mr7296865a12.32.1722838629097; Sun, 04 Aug 2024
 23:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Blake Sperling <breakingspell@gmail.com>
Date: Mon, 5 Aug 2024 01:16:32 -0500
Message-ID: <CAGRfhun+pAYRjS8p9066HYV+wjyvCWoLtK03Nr0GXmYHzFDPpA@mail.gmail.com>
Subject: [REGRESSION] [PATCH v2] net: missing check virtio
To: arefev@swemel.ru
Cc: edumazet@google.com, eperezma@redhat.com, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, mst@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I noticed a regression from v.6.6.43 to v6.6.44 caused by this commit.

When using virtio NIC with a QEMU/KVM Windows guest, network traffic
from the VM stalls in the outbound (upload) direction.This affects
remote access and file shares most noticeably, and the inbound
(download) direction does not have the issue.

iperf3 will show consistent results, 0 bytes/sec when initiating a
test within the guest to a server on LAN, and reverse will be full
speed. Nothing out of the ordinary in host dmesg or guest Event Viewer
while the behavior is being displayed.

Crucially, this only seems to affect Windows guests, a Ubuntu guest
with the same NIC configuration works fine in both directions.
I wonder if NetKVM guest drivers may be related, the current latest
version of the drivers (v248) did not make a difference, but it is
several months old.

Let me know if there are any further tests or info I can provide, thanks!
