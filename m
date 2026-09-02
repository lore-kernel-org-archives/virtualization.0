Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF87369D75
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390075; cv=none; b=mvHwm8ZYsnp/QDwj42M8T5Cvm9myRJ6NsCOZ47LT4W3j1zCulEmmZZEbviBm9Owa06geViU62sw62irE3plcQUgDL7kI7dk+SMLfC1JWCzUFoU1fT0h9Y3SdF7IHM6+bGw22x6yVA6yqsCSrO8CKG9A6BCKSl0UlZh1RTVASP3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390075; c=relaxed/simple;
	bh=S/34GgnpIisKNAJazB6aS6c0H4pLuTB5PSuj71c9luE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pMtcMJ6I+zPbp/zovdkU2OSkRlo3jkc+ix9LMRLjQKEGO78wBdzH1xz3Hhan3aSpKRorMlqkge78lFqjNQMArxNOQcW4sn6dbv1xD70PJAqaxtsvLs3oqKuGR5KrXws58qYg+3mpfhc9fQyUXCQg56m9jdqj4owJjAfnO4tZ7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXrHgJMV; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXrHgJMV"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4679f619d3bso1194102fac.1
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788390067; x=1788994867; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2/4BUiYwhmx8BTSrnAZKpKB6tkHSRMMIf9FbGNEl8BU=;
        b=pXrHgJMVBAVAf1Zi5fapN8BBYBJkSfz2tq/eq1VV02QDQGOo2pA8qldAaUZNmPS1lL
         baOAFgfOZ69A0HrdPOmw5d1JllkDIB1BdGGc8heEKF7WZzStab8CPBsRcn8TThzbyrO1
         PDz2jn4Mm+iQROhlKEdm2uNb09i1Uz/mylZO2cn0u0+tyzdJlLpGPPW9zQLHPPnj95hJ
         iZBuxwu1lwSAek1G2orAdu1MJeA+GeF0JlzGP6Mx0oAHizVpxm0J8nFNTAbTwuaVaaTw
         1tcO0ciAwYcDTId7menMsN30ztyVcd44Vp2sK/Id3xtXMrZrc7lUjtxIsWHa9RCfHLGq
         NRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390067; x=1788994867;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2/4BUiYwhmx8BTSrnAZKpKB6tkHSRMMIf9FbGNEl8BU=;
        b=bTrj1BnbHqzK4knfY7HKjpieLKFJkL2DWkfr8d1jWGmO8PDzBO/nGsEYOaSstLMydC
         AJGW33aLoBf6bdWsbyy/NopyxKdYaFScH8wT03g69CIrEVJ0HDjW83n5Q9zvqQfo8IAZ
         e4eFB/VUzoCBLSne8yAEOci1dRzmvt0HH0XqLXIpFyVzk6X6MyXFh7JlJDU+4r1bN8bi
         ZeNmPLwwEFT714u3WBtmzvm8e8L4RvjQwmH9jeEo0EiGYr5FipfzAWl0nfol2G5NMZKC
         cdfKwe7asRQ2I/HX7tAfTR+HcPJ2rPXe1Eoga8rxj2rlbO43uQ1Ea9+wqueCC3CULwr4
         drJg==
X-Gm-Message-State: AFuF++kRYpBZO/B6yARDoMbbmkpBKs92xQjkiiSACwzfLxa95LrsG9Io
	jBhEXc3QqypzTpIpHYxXbPq/2L00KbGJSmG6OFmQTaYBJ/WKakg8dtUg
X-Gm-Gg: AYBFou0ilmXvP05SRsZlU6uErPpV8Lt4xE1MrJRKLy7sfb3mq44rpZ3Af2L82uDreXW
	elPyXqdKQnTp8SEYiOAT3MxYY6A/QXp42L4ik74dc90giXYJUVCz2fZoBrkFw8BFGH3ya9xG529
	w3qR0k/2Olehgqfr6W35Cu0tb62PHqSkWdFtlogZA7YmjiKpqPcX9JMEPbOvcI61nIXzbX+yGj6
	KgifspkFoHlkLUprtq/mW4NXVPD8Iayj4u4nF0FJNSPv4ytzLDikgq+29qtY4/oFy9MYH6DKz0L
	VSW++tO1qgRDddTI/4Te5FZuvZqZonhKps+370lj/9DB33Uyh/kqs0aJQp5oENIfKo7fbUp2oI8
	9YJMHjOvBCGLDQy88TgtE88/TDZXcWjh2J7Lq4xAscoEjvOlsvBOz+0eiXOtjX5C1EwrEZdgIsX
	xoXq0fkT7qSRBxjgE+a9xgP5+mWsFzMYEZihjSGEk2xtyPL/BkXBbXZKeh
X-Received: by 2002:a05:6871:368b:b0:456:4c3f:7e03 with SMTP id 586e51a60fabf-46f87b8e5c6mr7802048fac.18.1788390067079;
        Wed, 02 Sep 2026 16:01:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f32f87146sm5619656fac.13.2026.09.02.16.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 16:01:06 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/6] vsock: assign the guest vsock device to a
 network namespace
Date: Wed, 02 Sep 2026 16:00:46 -0700
Message-Id: <20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKGqmGoC/x3MQQqDMBAF0KsMf+1AYtu05Cqli2BGGwpjyUQRx
 LsLvgO8HSa1iCHSjiprsTIrIvmOMHyTTsIlIxJ61wf3unlebR5+PC1ijdU4u5DG+8PnFJ7oCP8
 qY9mu8A2Vxipbw+c4TlagUtRqAAAA
X-Change-ID: 20260831-vsock-guest-ns-d06af451da67
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

vsock network namespaces let a host put each VM in a namespace of its
own. A guest has no equivalent yet. It has a single G2H device that
cannot be assigned to a network namespace.

This series lets a guest move that device into a network namespace. A
new ioctl on /dev/vsock, IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS, assigns the
device to the namespace of the calling process. The namespace's existing
ns_mode then decides who may use it: a "global" namespace shares the
device with every other global namespace, and a "local" namespace keeps
the host connection to itself. The device starts out in the initial
namespace, so until the ioctl is issued nothing has moved and no mode
has changed. There is no explicit unassign as assigning the device back
to the initial namespace is equivalent.

The ioctl requires CAP_NET_ADMIN in the initial user namespace.

Connections that can no longer reach the device after a move are reset,
so that a namespace which has lost access cannot keep using a socket it
opened while it still had access. Following netdevs, the device returns
to the initial namespace when the namespace it was moved to is deleted.

Transports opt in through a new netns_assign_allow callback. Only
virtio-vsock implements it here.

Patch 1 is just a const cleanup that patch 2 needs. The remaining
patches are actual implementation and tests.

Based off of Stefano's original series:
https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (6):
      vsock: constify the transport in vsock_for_each_connected_socket()
      vsock: add IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS
      vsock/virtio: support guest device network namespace
      selftests/vsock: add a helper to assign the g2h device to a netns
      selftests/vsock: test the guest vsock device network namespace
      selftests/vsock: test the assign ioctl privilege checks

 Documentation/admin-guide/sysctl/net.rst           |  18 +
 include/linux/virtio_vsock.h                       |   2 +
 include/net/af_vsock.h                             |   9 +-
 include/uapi/linux/vm_sockets.h                    |   6 +
 net/vmw_vsock/af_vsock.c                           | 200 ++++++++-
 net/vmw_vsock/virtio_transport.c                   |  28 +-
 net/vmw_vsock/virtio_transport_common.c            |  28 +-
 tools/testing/selftests/vsock/.gitignore           |   1 +
 tools/testing/selftests/vsock/Makefile             |   3 +-
 tools/testing/selftests/vsock/config               |   1 +
 tools/testing/selftests/vsock/vmtest.sh            | 461 ++++++++++++++++++++-
 .../selftests/vsock/vsock_assign_g2h_netns.c       |  45 ++
 12 files changed, 774 insertions(+), 28 deletions(-)
---
base-commit: d0ec95a8a4e79f2fd6063fc8932415db8c227689
change-id: 20260831-vsock-guest-ns-d06af451da67

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

