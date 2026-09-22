Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D84F36C588
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039901; cv=none; b=WlR0e2/FcJVx7v3o/Vx9FUcsI3mmfsljVAzPqX1aSb/rv/FJSiyGQ+rfuD2F4I5/0AobgDF9dl8PISqUsIgivLTok3V/zp4SOus1KEDJnBnJMUnRRWFKJs3e9bkto1ss/82xIRA64y6q4UJkRMkb7JhVnoi74Sg3dOAntKukdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039901; c=relaxed/simple;
	bh=Acv7MgHBh1jAwi3D+fsQ8X/DzGRU/jGDl+ydMkOn+HM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WKjSrizRC9a+H/qC40XzW/IV2whHObuLZpf2Ou/xtGlBLW/VVGgTfMde9BfbR17teZoK/osdZEzg7JC1poydessvjhHLQPGmZkGUqmVow9mhlqtbQ8esLFxZQeZcMGhH1gqUGIQ6p6Np3U1k074p7kh9u2/ikYxkTRarMjb6g/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUPX00Ul; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUPX00Ul"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6a9aeaso1927300eaf.3
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 18:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039898; x=1790644698; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nc+AzR6lB3hdwq2cJ+qgIdPQ8/tOa9E8y0imH8XTesg=;
        b=WUPX00UlO0YmM9Ln4I+sR67CpfAR9ozomGz5AgTjQ4B1K579LhbUuYAtKqHMzf8Vrd
         EmG999nDP50CtNVdophR9eQxHuv/VCvx+KOzMlRUNJp32MtiYgusMV4ELlqsplBJOWWr
         7fXuAN5g7FZnblEiLo9mjKFghapUQLgAiuMfae66OkGWGFFNI95QwS5sLp9RAOQVNDKl
         mf122jkJMxTGAQDn5qrAU0x1r0jI0AWrQ5llp/YrUMkfLLEFL1ysPqSoFj59Rfslpq7t
         LfnLVYGcZKBgekjgif2eiOiB4F5r8a/wdMFQEt4Nl7AMPCb5n8JR7HIl/xaEiNuLqPIu
         8lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039898; x=1790644698;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nc+AzR6lB3hdwq2cJ+qgIdPQ8/tOa9E8y0imH8XTesg=;
        b=VGrL0W0fO7xsvTWo1NofBSBnOCPBpdTaD5d84fe7VKQhjCt6A37j20samwSGrosiop
         VyO+oCHjm/wGmnhiJmzGAQt/YKjLoXqe+mRIfUen8yaEGlq4vr6zwW2o1pLraNb3XJsy
         51HD7PzIKyClFxhxBK+V+HyN+HxdyKDzfkKzsQBuvTpnBVaAPcSPteUe2g03q5LorFyw
         VBY5l6BSY/WHXNK8MpBv2Qy23srqhfPwqDEaT7ozytzcubZd7wSerBZ48wiKW+fvQ4/J
         s0OJBXqMWd9623kzN3j9C9UEi71s0nvG0V21cQva350zQDzTVODFU9JVAcGHE0k7A6jR
         1ZZQ==
X-Gm-Message-State: AFuF++k3DvaQEtzp1eCBGB2nq9LRs7b7wTpL+wyUd/D00s1EqEXnDFVm
	X+SoeN/IaK3lN6Msz+RmDxQGLpRNVflbJ8si4SuQHPUqjkVOwRdvOHe8
X-Gm-Gg: AYBFou3D03p5GjFHD+igCimOBeTSOg06JYOHIlYSK3Hez0u9rySWNArVNMd5nWaJvZz
	mpJ9zliXnjNpJnkkQkNApx9Cy7vaMKZ2sQcgVlfV57EkRHge03YV9ntvTuGCiX11ncIhuBbjYmm
	/s1LVmOSxW840WpsfFUa9JaI1k/+2mq4EYykouTWebaEHGqmz3f+dARsy5ZU3I/4ZrbVDegWK7I
	2Qkumv3gDFBw5/2eA4a8Ug/WsGkKCaEyzWRdWjYI0dDzacr+g44kQkGGweVuWzt+SmTaUz3UeZ/
	rLt0fCvNT9WIPu9Pp7nNDKWKGk22Evu8TrzueNicUTuAkH1/TzJHMaB8EN4l838A7d3xiWKqkcc
	AzHgUkTM7HoM+Foj8Bl9OxJAQI39OP4tTxgYnSrtdMuD/hmqoASeuaS3CP4Gw4Urh8zQPnE/DHc
	BIQlEbdJjqrJcch6bINCViPTO1G+Wrx4cR7PTgtghy9dzcZKBTkODhJ7kU1EDA7tXwr9A=
X-Received: by 2002:a05:6820:61b:b0:6b7:83c5:fe00 with SMTP id 006d021491bc7-6ca9d147147mr11628526eaf.65.1790039897801;
        Mon, 21 Sep 2026 18:18:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d1dbd52475sm117155eaf.1.2026.09.21.18.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 0/6] vsock: assign the guest vsock device to a
 network namespace
Date: Mon, 21 Sep 2026 18:18:03 -0700
Message-Id: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzXsWoC/13NQQqDMBBA0auEWTslidUaV71HcZHqqKGYlEwaL
 OLdC1l2/eH9A5iiI4ZeHBApO3bBQy90JWBcrV8I3QS9AC11K7taYeYwvnD5ECf0jJNs7Xxt1GT
 bG1QC3pFmtxfwAZ4SetoTDJWA1XEK8VtOWZVeUCP1P5oVSjTGNHVXk7Hd875RspcxbDCc5/kDv
 f1HJLUAAAA=
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
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

vsock network namespaces let a host put each VM in a namespace of its
own. A guest has no equivalent yet. It has a single G2H device that
cannot be assigned to a network namespace.

This series lets a guest move that device into a network namespace. A
new generic netlink family, "vsock", supports the command
VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace the
request was sent from. The namespace's existing ns_mode then decides who
may use it: a "global" namespace shares the device with every other
global namespace, and a "local" namespace keeps the host connection to
itself. The device starts out in the initial namespace, so until the
command is issued nothing has moved and no mode has changed. There is no
explicit unassign as assigning the device back to the initial namespace
is equivalent.

The command requires CAP_NET_ADMIN in the initial user namespace, so
that an unprivileged user namespace cannot claim the device.

Connections that can no longer reach the device after a move are reset,
so that a namespace which has lost access cannot keep using a socket it
opened while it still had access. Following netdevs, the device returns
to the initial namespace when the namespace it was moved to is deleted.

Transports opt in through a new netns_assign_allow flag. Only
virtio-vsock sets it here, because it is the only guest transport
that I am able to test against.

Based off of Stefano's original series:
https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Replace the IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS ioctl with the "vsock"
  genl family and VSOCK_CMD_DEV_NETNS_SET
- RST the peer from the reset sweep, v1 only set TCP_CLOSE locally, so
  the peer waited on a connection the guest had abandoned (Stefano)
- Drop the vsock_assign_g2h_netns helper patch, the tests use ynl cli.py
- Note why only virtio-vsock opts in (Stefano)
- Add a getter to the uAPI
- Various fixes (see individual patch change list for more details)
- Link to v1: https://lore.kernel.org/r/20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com

---
Bobby Eshleman (6):
      vsock: constify the transport in vsock_for_each_connected_socket()
      vsock: rename the vsock pernet operations
      vsock: add a netlink command to assign the g2h device to a netns
      vsock/virtio: support guest device network namespace
      selftests/vsock: test the guest vsock device network namespace
      selftests/vsock: test the netns assign privilege checks

 Documentation/admin-guide/sysctl/net.rst |  23 ++
 Documentation/netlink/specs/vsock.yaml   |  68 +++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |   6 +-
 include/linux/virtio_vsock.h             |   3 +
 include/net/af_vsock.h                   |  19 +-
 include/uapi/linux/vsock.h               |  28 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 374 ++++++++++++++++++++++--
 net/vmw_vsock/virtio_transport.c         |  24 +-
 net/vmw_vsock/virtio_transport_common.c  |  27 +-
 net/vmw_vsock/vsock_nl_gen.c             |  36 +++
 net/vmw_vsock/vsock_nl_gen.h             |  20 ++
 tools/net/ynl/Makefile.deps              |   1 +
 tools/testing/selftests/vsock/config     |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 473 ++++++++++++++++++++++++++++++-
 16 files changed, 1060 insertions(+), 47 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260831-vsock-guest-ns-d06af451da67

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

