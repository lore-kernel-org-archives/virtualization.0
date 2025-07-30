Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280B1D5AC6
	for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867799; cv=none; b=hMj+3aeYWNBJMCarCV4l1TTXlht7bQRgCZSADqqWfHm0Nyu1i6x5Ulj++wHHynmFYmtT2QE8+Qi9+39ts4ycsctSV34PeRgK0dTxlfhLzqldoPi4pxO1FDqn5WcYWx4e2nng0vWK8bQkllNh6Pwp6UdNHxn+tm9BA9Z/u7N9oWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867799; c=relaxed/simple;
	bh=fnvRP+SViXyCbSMzmsrKWpJn9OYHrE70YQgzPaCywJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WOfuZWiGkpuBEDlzGYJroiyUFH47W2LdKPyWsQlevMx9wFFXHif3oNlcdWYfrJDrYooJegpjZGnvaBgbqikDeWjb8cBUllQ7OwEwkQ2tw7efJ7WUxnfi6/+zaa0YXLkPiK8HMBfe5L0vvsWHFdWn8TPT8lkONJ/eKDNhUicMV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S3LK5kqX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3LK5kqX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f325c1bc1so1540911a91.1
        for <virtualization@lists.linux.dev>; Wed, 30 Jul 2025 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867797; x=1754472597; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0POlGKbEX0EvHYDWI2NptB2rFaQwWq9w/pBl23x/4k=;
        b=S3LK5kqX4GumaZpAfWswPtcya/ineHWvIY/6fgpQxHXg+I2KvGudSdj890poGFPJQS
         /1u83tmEvalAc1bpcCsJrIRxabwpeRlerb0+UekqKYf/qDbZSw1D+Wx4lKHGkiW6B6kH
         caPhw9SyKpp3012WaKACEmWFDg7QoxDiMK41mBk8XLVeeiqnRY22dVDiKYwMX6la1EZX
         V3v70VRQnyCRGGrlToHsxoRVWKOyohBq3zAYApthwHQOz3e+7XzS83sFu91/coWvjr6Z
         O6mv/DQRVG40Ew0ELnOVxvMhVR562q6sjct7wpUP7L/bEtzh0S/budkdQkZJNIswT00w
         z+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867797; x=1754472597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0POlGKbEX0EvHYDWI2NptB2rFaQwWq9w/pBl23x/4k=;
        b=o/ZkEAkWiUKY91xn+rnYkBfFMXKvzb0EeYtfRRDkriiJAKuAUj85/zAWF3Lp4rOsdA
         pvVO1X/8l7DW5tudKg/uZgQTCWnI8gJTvFJO3g4Iqx5dGigJLUpOalzZmDoM0XmrNuYf
         awCaSB2LJHw5DLg/bT88wGLbJ1VESrudpYbhmL4TcJTejRReZJDDPnqPNLra/FIEVU+5
         FT8WErvHfrOB8qYpTfHr6dMYXEPXcBR4KSpmZLggQjS6PrQJvbYUHDvfxwmdPt1IbGuk
         3aBMxmQJmdYh7lhyivAY6ApQ/I40JUWc5Snwmow9nY7dUg90KQnF+2hDml4Di5lT8pbA
         iy9g==
X-Forwarded-Encrypted: i=1; AJvYcCWk08I3oO9z3EJNU+nTBkWOora1gmywP7hcPDT/ay1kFWV+HelquurLqk+nDyeeLE2GcjDMDmhgcCgTF5fLFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU2IT+uTMQmaErREWHeYOAS2GoNF1ooG4Wpt+OhxC53G0lmYxe
	8bCWCkUVJJEZWyDnBZIKOoTrLaz/LowCDEtYSfYC+YMuFjsONNiE5lSTXqwW4MFV/mc=
X-Gm-Gg: ASbGncuwhZl6RN72xaseXsyJNflrylOkcUjeCtvkAdoEKmE73caka/OaOhIXni/LnQN
	A2Qe06WU48JscziF/NrPmTUPW2DluJHKzk34oaQvJiie4gGqB9hIN914ZPMhkZJvmTQnaIstn63
	uMdnn2OfykzWAbK+X1jYjor3Ulp6xANT2KncU7LQ62E4IEATWkRTgWu5Kum/SiXinl8lQByUiex
	gNMUtTsnKFzccGnQcPcdeQ2jwckSFkVRc634/xb1rQdeVIdutu6S3RMRajoeTL4BjN/TeWpfB8i
	gGw8L5lOVvwYi/+LxK6WrQtTOZEf959gPp8XgtRiGsUQNXyIxuT5yiCqK6z09hYEKG4pnklaCAN
	bAc1N8ytL0XLo9fBWEbh2glw=
X-Google-Smtp-Source: AGHT+IF4uc5aZmco6mwIQFVn7igbRT3lJPHP6Dmmwr2upZelWkrrgq0JOAt0HEgC+nPLPHXlqWICLw==
X-Received: by 2002:a17:90b:5103:b0:313:f6fa:5bb5 with SMTP id 98e67ed59e1d1-31f5de54a99mr4185193a91.18.1753867797096;
        Wed, 30 Jul 2025 02:29:57 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee4f42sm1477362a91.23.2025.07.30.02.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:29:56 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [RFC PATCH  0/6] virtio: Add support for Virtio message transport
Date: Wed, 30 Jul 2025 14:59:29 +0530
Message-Id: <cover.1753865268.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This RFC series introduces support for a new Virtio transport type:
"virtio-msg", as proposed in [1]. Unlike existing transport types like
virtio-mmio or virtio-pci, which rely on memory-mapped registers, virtio-msg
implements transport operations via structured messages. Those messages can be
transported through different mechanisms such as mailboxes, shared memory based
FIFO or specific protocols such as FF-A on Arm.

This series includes:
- Core virtio-msg transport support.
- Two message transport bus implementations:
  - virtio-msg-ffa: based on ARM's Firmware Framework for Arm (FF-A).
  - virtio-msg-loopback: a loopback device for testing and validation.

The code is available here for reference: [2] and virtio-msg loopback and FF-A
test setups are explained here: [3] and [4].

This series is based on v6.16 and depends on commit [5].


### Memory Mapping and Reserved Memory Usage

The first two patches enhance the reserved-memory subsystem to support attaching
struct device`s that do not originate from DT nodes — essential for virtual or
dynamically discovered devices like the FF-A or loopback buses.

This reserved-memory region enables:
- Restricting all DMA-coherent and streaming DMA memory to a controlled range.
- Allowing the remote endpoint to pre-map this memory, reducing runtime overhead.
- Preventing unintentional data leaks, since memory is typically shared at page
  granularity.
- For the loopback bus, it restricts the portion of kernel memory that can be
  mapped into userspace, improving safety.

Device association with reserved-memory regions is based on DT node naming
conventions, such as vmsglb@ or vmsgffa@, similar to the remoteproc framework’s
approach.

Feedback on the design, API, and approach is welcome.

--
Viresh

[1] https://lore.kernel.org/all/20250620224426.3923880-2-bill.mills@linaro.org/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git virtio/msg-rfc-v1
[3] https://linaro.atlassian.net/wiki/spaces/HVAC/pages/30104092673
[4] https://linaro.atlassian.net/wiki/spaces/HVAC/pages/29657792513
[5] From linux-next: 5be53630b4f0 virtio-mmio: Remove virtqueue list from mmio device


Viresh Kumar (6):
  of: reserved-memory: Add reserved_mem_device_init()
  of: reserved-memory: Add of_reserved_mem_lookup_by_name
  virtio: Add support for virtio-msg transport
  virtio-msg: Add optional userspace interface for message I/O
  virtio-msg: Add support for FF-A (Firmware Framework for Arm) bus
  virtio-msg: Add support for loopback bus

 MAINTAINERS                          |   7 +
 drivers/of/of_reserved_mem.c         |  91 +++-
 drivers/virtio/Kconfig               |  34 ++
 drivers/virtio/Makefile              |   5 +
 drivers/virtio/virtio_msg.c          | 655 +++++++++++++++++++++++++++
 drivers/virtio/virtio_msg_ffa.c      | 505 +++++++++++++++++++++
 drivers/virtio/virtio_msg_internal.h |  88 ++++
 drivers/virtio/virtio_msg_loopback.c | 323 +++++++++++++
 drivers/virtio/virtio_msg_user.c     | 140 ++++++
 include/linux/of_reserved_mem.h      |  13 +
 include/uapi/linux/virtio_msg.h      | 213 +++++++++
 include/uapi/linux/virtio_msg_ffa.h  |  94 ++++
 include/uapi/linux/virtio_msg_lb.h   |  22 +
 13 files changed, 2166 insertions(+), 24 deletions(-)
 create mode 100644 drivers/virtio/virtio_msg.c
 create mode 100644 drivers/virtio/virtio_msg_ffa.c
 create mode 100644 drivers/virtio/virtio_msg_internal.h
 create mode 100644 drivers/virtio/virtio_msg_loopback.c
 create mode 100644 drivers/virtio/virtio_msg_user.c
 create mode 100644 include/uapi/linux/virtio_msg.h
 create mode 100644 include/uapi/linux/virtio_msg_ffa.h
 create mode 100644 include/uapi/linux/virtio_msg_lb.h

-- 
2.31.1.272.g89b43f80a514

