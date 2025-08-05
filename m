Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBFB1FDD
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430554; cv=none; b=Zi5nV9NOmOKNKr9hfObIwjq21siQUemb3tco9Z4VOm2bPndmTnTxoco1tga1NevE5+VCJRZJarmu0BLJYdCJIAYi0A9monOO/0swVwmMAe5YWGqwRYZ2HunyFCkQJo9jdlqp2uzCh9r4xS0QsPpORsjPsUs/gUWkEtU/7T+cWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430554; c=relaxed/simple;
	bh=5amThN1CJRrgPNrznq6HeBCLd3EXk0AUMQmTakrmFS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YI4vU+/WNMFr36n1ivhNKOgsncOSc58SNoCGXPodydCe0mDoxf4/aFy2oLJfcntNqsMXU9juy5R3EgcXL5AsH5H/0JuGKA05u3YjmJ4KQHuZVaG7I5Z0k5shnVdms2ZQrdzErzXozo5hKSowxf1jJt0BbadNfFX5I8Crf9G1WP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1UyLpEj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1UyLpEj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23dc5bcf49eso87803415ad.2
        for <virtualization@lists.linux.dev>; Tue, 05 Aug 2025 14:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430552; x=1755035352; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzpQQaAdEkqc6PJGR97Pgj4iP11MU5Km1VO5qnSbY1g=;
        b=M1UyLpEjUqAETeR+di0rkSP4tum+4RGOvFpwqAGcOXmIz/jzacV1Cv6WWBWG0djRe3
         VZvzIfl9ucP4B8XEIBzakL1Gyo7hNQ0d4LXS3zvqX2bsGOerSob4YpEPe5jDLrn4i5we
         uLbeCppZEwHOO7vwE6xdiLBExk9MU5MvTZWQkH5OJPipOzgLkZCVJRPRzR0SiaSqruon
         BTjjbRHXw2ttD83VG+FcWUc26KEkGAbgOF8JO9gl8AufxM7JGtPULa2KuOdoHk9bQJRw
         xDCnHefWvBlMUd02qnzG5ImVYDt6ISJYTjXMYswO3ZozwV8WrNmS+JWyWQLvbHAAhRnF
         DjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430552; x=1755035352;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzpQQaAdEkqc6PJGR97Pgj4iP11MU5Km1VO5qnSbY1g=;
        b=OdXOxDFG1GP7SzgG18SG9PXhEXi4NH4vOO1j53lJpkl6tFX8eRfe1wNewWa42KmDR5
         xh/Q1govAYJQfMfRD1De1qKhAkEXiaF9HK0Dg6d6Pon0Bf9eWRyNqCHnZzbiqS7KkBVh
         iHWTfXcKJNFFH+cPok8rhdmSbuaWudBAOlUGBWzBXqx84zPaPZaVNfpqSo2f7LagCcKw
         06vUkPbA+rBUAsy+y+iKddRCgjPbF5E5EuocL6YhL/ymzjvqac9fjSgv5MPO4T4VENxx
         lva+fqTBfXMorI+WaLWlKJwnFM8MRoESWsK5+ucUStNp7qfqHA6SOKsh/BMdx6OOgDyq
         Y35Q==
X-Gm-Message-State: AOJu0YylTti4JrpY2Cb6d45x42lQDg7fpQ4851L199uv+VfL1/ecDqV6
	dNh5gE7RefNtoy/j8v7YAW7VbX0hAu43hXd97oZpLLmXwqMlv/k2Pqrr
X-Gm-Gg: ASbGncsbEd8B2z4VakMMSMTfwSGLsWxDepOAlbnQHb28zat21gyQJV4Aa7hdBNNlNkv
	Qufpuk1XtNrAdQUAmp6lyRQgeGMn+yj0e3fn9491WAq8+O/PIQU0HaSmieBn86EpEP/148PRMrL
	Ac49CiZ2DbGoYCMK99d3yrY6KMnwQIzdp3W2H30u7zCAaZtcs7KIH9BqueZpOUYHPMjsMlL21oQ
	/46lUvcjtmOfKUXmZPlopDPKpnrHTJHgjv+5Q7n2uBsF0j/Lpdei2OLoaAx5WH2udYSXinM4NM0
	PcqXyWO0/kGzjkV1TOsg+bBJCIQVXajuFUddMRZZ9+HTx9ZgmsQGD38qry2wBZSlk4j0DodZj8X
	muV0Y51pHdIcd4i5IEp/8
X-Google-Smtp-Source: AGHT+IGiqlg4Mkv+7YnA4J3F4JbEGMlMQTWSudUpXeN+yNO2Gn2gG5RTaKZbxq9UamzI/wIjFVuDig==
X-Received: by 2002:a17:902:ea09:b0:240:7265:1cdf with SMTP id d9443c01a7336-2429f44b3admr6945235ad.23.1754430552430;
        Tue, 05 Aug 2025 14:49:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24244f5c1c0sm97386455ad.45.2025.08.05.14.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH RFC net-next v4 00/12] vsock: add namespace support to
 vhost-vsock
Date: Tue, 05 Aug 2025 14:49:08 -0700
Message-Id: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFV8kmgC/13RwU7EIBAG4FfZcBbDzABtPZmY+ABejQdKp7tkb
 WtKQ9Zs+u4iFyvHn8z3TybcReQ1cBRPp7tYOYUYljkH/XAS/uLmM8sw5CxQoVGERqa4+KtM08Z
 xkz05hAFBoUeRydfKY7iVunfx9vry+zbzJme+beIjh0uI27J+l3UJylhp1qD+NyeQIEcyroXB9
 V3rn8+TC5+PfplKUcIjbiqMGVOnwGFDBNzWmA4Y2wpTxtCCGy1YGolrrP+wUfVmnbFldF2DFv1
 ga2wOGKjCJmPNjfHaaeO5r7E94uorks24cyN4rzDfro543/cfCn6TpOoBAAA=
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

This series adds namespace support to vhost-vsock. It does not add
namespaces to any of the guest transports (virtio-vsock, hyperv, or
vmci).

The current revision only supports two modes: local or global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

Future may include supporting a mixed mode, which I expect to be more
complicated because socket lookups will have to include new logic and
API changes to behave differently based on if the lookup is part of a
mixed mode CID allocation, a global CID allocation, a mixed-to-global
connection (allowed), or a global-to-mixed connection (not allowed).

Modes are per-netns and write-once. This allows a system to configure
namespaces independently (some may share CIDs, others are completely
isolated). This also supports future mixed use cases, where there may be
namespaces in global mode spinning up VMs while there are
mixed mode namespaces that provide services to the VMs, but are not
allowed to allocate from the global CID pool.

Thanks again for everyone's help and reviews!

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eugenio Pérez <eperezma@redhat.com>
To: K. Y. Srinivasan <kys@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
To: Bryan Tan <bryan-bt.tan@broadcom.com>
To: Vishnu Dasa <vishnu.dasa@broadcom.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: berrange@redhat.com

Changes in v4:
- removed RFC tag
- implemented loopback support
- renamed new tests to better reflect behavior
- completed suite of tests with permutations of ns modes and vsock_test
  as guest/host
- simplified socat bridging with unix socket instead of tcp + veth
- only use vsock_test for success case, socat for failure case (context
  in commit message)
- lots of cleanup

Changes in v3:
- add notion of "modes"
- add procfs /proc/net/vsock_ns_mode
- local and global modes only
- no /dev/vhost-vsock-netns
- vmtest.sh already merged, so new patch just adds new tests for NS
- Link to v2:
  https://lore.kernel.org/kvm/20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com

Changes in v2:
- only support vhost-vsock namespaces
- all g2h namespaces retain old behavior, only common API changes
  impacted by vhost-vsock changes
- add /dev/vhost-vsock-netns for "opt-in"
- leave /dev/vhost-vsock to old behavior
- removed netns module param
- Link to v1:
  https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com

Changes in v1:
- added 'netns' module param to vsock.ko to enable the
  network namespace support (disabled by default)
- added 'vsock_net_eq()' to check the "net" assigned to a socket
  only when 'netns' support is enabled
- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/

---
Bobby Eshleman (12):
      vsock: a per-net vsock NS mode state
      vsock: add net to vsock skb cb
      vsock: add netns to af_vsock core
      vsock/virtio: add netns to virtio transport common
      vhost/vsock: add netns support
      vsock/virtio: use the global netns
      hv_sock: add netns hooks
      vsock/vmci: add netns hooks
      vsock/loopback: add netns support
      selftests/vsock: improve logging in vmtest.sh
      selftests/vsock: invoke vsock_test through helpers
      selftests/vsock: add namespace tests

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   48 +-
 include/linux/virtio_vsock.h            |   12 +
 include/net/af_vsock.h                  |   59 +-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   21 +
 net/vmw_vsock/af_vsock.c                |  204 +++++-
 net/vmw_vsock/hyperv_transport.c        |    2 +-
 net/vmw_vsock/virtio_transport.c        |    5 +-
 net/vmw_vsock/virtio_transport_common.c |   14 +-
 net/vmw_vsock/vmci_transport.c          |    4 +-
 net/vmw_vsock/vsock_loopback.c          |   59 +-
 tools/testing/selftests/vsock/vmtest.sh | 1088 ++++++++++++++++++++++++++-----
 13 files changed, 1330 insertions(+), 191 deletions(-)
---
base-commit: dd500e4aecf25e48e874ca7628697969df679493
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

