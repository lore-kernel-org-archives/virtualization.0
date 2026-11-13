Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590167;
	b=PLDeOQNOY/rBmS7VRQsgHc9AFuXLDiC0k2e1+qfg+Zjq/Zu4+W1o2OvNavZ5GIPyVT4y
	 NeMaMHjYjES8DMu/3BoJTZ516ksTeX9to8mn4Q832hZqzISdqWenOqp32NhG4sCr2lDZZ
	 QtOhi3KZ0JqcMbJl9nYTk8gz7WFJliW/bbd4WXNbt6P3VMiQogSu8TJbkD/wOKLjEz7oT
	 /g0qqPeseAJ+48vLsoMEhv/AkG5ythsqMwd/9qlmN2pCVpYUXwesz9mXtohYrxJm4Pyjy
	 8xygTNRG/sTrMqfZHqC00X/B8IOH54DIuih4L73h/yLgNi/6l9zCePXZRuUzDbizKpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590167;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=84RgXKmSK/6kR3BtGZyphwm5qswS5TA7bZtJ3FBhypk=;
	b=QxgHOHodgX2IDATGqoKaHD2cZ5jHkQkM1T1C06OZWo7xQe6KboSqh9/gDGdmMIuU6VZg
	 wYvVoRmFvZd8k0+7x4JbaQRFY/BvJPugF4S7IAD1y6L0ex3ubGPoQEsJnkRXDvu+sGnTW
	 cwADDY8N3PXw3DoEo9D0S5NiBY/QQcHr6v4Nq3HH0zIyP4c+QZhim6ZHCQ79vv96faIIe
	 eYNPFYohq5pDGGcTBBLA0YXrdEmo6J7U1miZFxQ9c6QWfjW+PUt+pYM+1U2wmGPHa1KwF
	 EWhcRatOlGnR4gR3qlswM4QOQPtB30PW63ZaWzzFPY/uIl2ldjZ9ZIt4Qwgul3zrAXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K4EHDGWK;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF46606E22A
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DF46606E22A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K4EHDGWK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=84RgXKmSK/6kR3BtGZyphwm5qswS5TA7bZtJ3FBhypk=;
	b=K4EHDGWK0XFZfo6A+0+5+RaFM7KjhZZyOl1CrYXXf6YZTj3SYv3hcCKNU5txBrZhnQ4t3x
	wIGRVUgff0yFTreapAmlR2hPt9e4G/vSZq9SU0+hlIFADM9cDsKFqFwGiHYxDj2y+KyMcZ
	QbnXQgueh3I0V2TFI2SHFpgTe1c6d2s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-Dbvn_FJPO2S9SGd4GTyg5w-1; Fri, 13 Nov 2026 12:16:04 -0500
X-MC-Unique: Dbvn_FJPO2S9SGd4GTyg5w-1
X-Mimecast-MFC-AGG-ID: Dbvn_FJPO2S9SGd4GTyg5w_1794590163
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4b9fde3044dso8131505e9.0
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590163; x=1795194963;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=84RgXKmSK/6kR3BtGZyphwm5qswS5TA7bZtJ3FBhypk=;
        b=Z4HtyzBK6anJ3KnDsnz1RNKSwUGUcRlcNrwLHqKhNqf4PruPc8dIXrV1hXBLph8jDl
         OOMCOrD3FZ2so7hTI1y2tm8kQIB3YfTSiqsWu0PDMSPhcM9F4BW53YPKaNus0UkHWS1I
         ncWSxLF6/MPiUwim2QDwEJ97OxmADKXxrro+1so+FIlhIerBppKfXZZtxC0dUIp822MN
         fjpxF9m+JWtyVAcPx7AmQVVKU+x0MfqU91lsxg/vEV98Q6g0ulgH9//QQdeiS1+REPJH
         oUpcVKB91YrSr55r7l2RmJgYypUmsuROsDPGLS2bnMljsWgB+RToh3qzQkBwVBNYRYng
         dlqA==
X-Gm-Message-State: APuU4Z9jdEsSjdgf1+6MI85gpyLTUjac4NM/tJ8HuY+wnFWiRhX6WqjP
	kIB5wfvss+bc0xO7ui0cOo0fIK3plQc97zWnWdKm9pXQ9AcL9gVyWu2djlj1eFNE6LPAjOECwEi
	+yewnxGgxe1t1FjiakPy4PHZapYAj6ifNUuAIaPBrR4WbfAw8sWMvBhEHCqhO5/6jrh+S
X-Gm-Gg: AYBFou0mkuZm2p2U1CyCXhylEH64sG2LOI6BA7Uxbb00oSm7o6/ifmbPTMPpun9ATJ9
	oFFV+UDQ2ds41r2K9Fp89pmZedG5aCwuwa2hXTy+dFVmS5AEYZn08jpb/X+pyxxLLmbGIVdbptQ
	d5V5G11aHxYw0OjPp283AjwR5dLG3FCxUGdmnS/A3LMBhrMTVJGmpyshyFRaMJeKEsaz3sDQ4QU
	a6imbiVAR4o4SPjmCh+M4+/fwA0VGTlBAZqnhucJKXGDKTntYJ8jexjLYBO5Qp6v/ZGbA1nKIu2
	PaqfX4N4RG+ENmpb8R/v2scxNRfjfZ3peyRfbJfrXiiUAtW4lm6+wcIHLN3v1HdWvxEoMV92qOx
	Hp5L6GysGwsVns0rApYA6RWNYbzfoBQemt6rIfq2tJOFP3F+QrJ2epJ9WE6+3B7WVM9hOO3pJ4I
	zXD4/8yI/WmEE=
X-Received: by 2002:a05:600c:638e:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb5bf390e3mr37175635e9.31.1794590162700;
        Fri, 13 Nov 2026 09:16:02 -0800 (PST)
X-Received: by 2002:a05:600c:638e:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb5bf390e3mr37174515e9.31.1794590162207;
        Fri, 13 Nov 2026 09:16:02 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c7da37b19sm5811907f8f.5.2026.11.13.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:16:00 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Subject: [PATCH RFC v3 0/8] vsock: add datagram support to virtio and vhost
Date: Fri, 13 Nov 2026 18:15:40 +0100
Message-Id: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQqDMBAF4KuUWTeSxJ9IV0KhB+i2uIhx1FA0M
 rGhRbx7gxS6cfnmMd9bwSNZ9HA5rUAYrLduiiE9n8AMeuqR2TZmkFwWgkvFgnfmydqe9Mj8a54
 dLawoU50h19iggvg5E3b2vasPuN+uUMfjYP3i6LMvBbFXP7Q8RINgnGGWK9Mpg6jKytuJsNeJo
 34Xg/wrQqTHioxKo01nyrxRwmBF2A56SYwbod627Qv7XYPqAgEAAA==
X-Change-ID: 20261027-vsock-dgram-support-683a4e0aebe7
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 linux-doc@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7564; i=slp@redhat.com;
 h=from:subject:message-id; bh=5TbAjGF4FfegO7dSKLQA2BNs4Bg65brL6KogvY7Caro=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90XGOGgBFRHRHfVkVGgCHSYYfCPwDaTI/9+KT
 dyk8bQpnHWJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdFxgAKCRD0aSeNLwwC
 NeusD/9yHQVTYzFerpOIXY5zPzkK6mhT3QpdS+j8gW9zYS3hE3Rt0JEF1NewA0GwZUL380zwdJA
 Gt1XS5D+c5+cRGu5VFOYe2ScPZy83rpdFGCTLSDignPHHMSJJYZ2gejtodURHXsj3ILpOPJkF+l
 Cd/S+Gvukv1VdG0seRc1Iy5s0UvxrazOAW8HJHD88Gh8AJYTzTuclart3DMo7B2goebR7QEP5p2
 MvRUsMY/P6EBGOINvSxmRWzrPi8dSM8ltDDPKYtriEocwo31XeDa0h+vYEMaeBW36tI6FNwuYCa
 VUppc7t3ce4ZJmz7rQbTq7rMIY4PE1oa4An8mWAHCmDw+lEB7oEcYtDXF0BhLGIytF7+LZBGF2S
 sAM+AhaqEK+uxHoFnBYDWmeqCuYdl1J++AhpJcMAqXed9IrczqE/b8jzRDNAFOvLjBM2aDCsDhu
 +rXaTf2W2B1Bcij/Bs179tVk7bE189KVlFmdSH/cgvzkeAzOCIx5yVH/a3UW45v2bneqtW1MuMD
 +3qV95brQ+e5mtDBJ/EB2c1fFbTnokFfYX5n2C+KbjP/wuUmw8RnXDbjV+/mXRj9K6V2y1lqKje
 EZWMsgF0BTZW4a9c/Kkh/oxtbAhiTPkuDwaybDcQbtKI146jW6xp5OAdIrTQ2u7NRwTpUs5DbtD
 obXehSJf3gbdvRw==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EKZmnEKzgyD4BBf_eM9VSkuuMOfgvWntZhzYA-SRElw_1794590163
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This RFC adds SOCK_DGRAM support to virtio-vsock and vhost-vsock through
the existing AF_VSOCK API. It is intended for guest and host services
that exchange independent requests, responses, or events and need message
boundaries and sender addresses without a stream connection or application
framing.

VIRTIO_VSOCK_F_DGRAM gates virtio traffic in both directions. Each virtio
send carries zero to 64 KiB of payload in one VIRTIO_VSOCK_TYPE_DGRAM
packet. On the RX virtqueue, the device may split a datagram across
page-sized guest buffers.
START and EOM delimit the message; the guest reassembles at most 64
fragments and 64 KiB before delivering it to a socket. Invalid or
incomplete messages are discarded. Datagram delivery is best effort:
there are no peer credits, acknowledgements, or retransmissions. Send
admission uses the socket send-memory limit, and SIOCOUTQ reports charged
send memory.

Datagram sockets have a separate port space from stream and seqpacket
sockets. The latter two continue to share their port space. Datagram
routes are chosen per destination among guest-to-host, host-to-guest, and
loopback transports, with VMCI as a fallback. VMCI still owns its socket
handle when it is present; loopback works without a directional transport.
Hyper-V continues to reject datagram sockets.

The Sashiko review of v2 also reported that a VMCI datagram bind in a
local-mode network namespace creates a receive handle in VMCI's global
port space, so a sender outside the namespace can deliver datagrams
across the namespace isolation boundary. The issue predates this series
and it's getting addressed in a separate patch:

https://lore.kernel.org/all/20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com

Within this series, local-mode namespaces bind datagrams only in the
core table and never create a VMCI handle.

Bobby Eshleman and Amery Hung explored this feature in their v6 series
and v7 work-in-progress branch. This series is a fresh implementation
against the current vsock code. It follows the separate datagram port
space, per-destination routing, and VMCI fallback requirements discussed
there. For guest receive buffers, it uses bounded fragmentation and
reassembly rather than full-message buffers or the earlier drop/error
queue approach:

https://lore.kernel.org/r/20240710212555.1617795-1-amery.hung@bytedance.com
https://github.com/ameryhung/linux/tree/vsock-dgram-v7

A corresponding virtio specification update has been drafted separately.
The wire format and feature negotiation still need specification review
before this series can be considered for merging.

The first patches expose the core port allocator and add datagram queue
reporting, then implement the common data path, guest and host feature
negotiation, routing, and RX fragmentation. The last patch extends
vsock_test with local and peer tests for message boundaries, routing,
connected peers, port sharing, queue accounting, and delayed reads.

Testing used QEMU with the F_DGRAM property patch below, an x86-64
KASAN/lockdep kernel, paired guest tests, and a nested Linux vhost-vsock
backend. The tested paths include 64 KiB messages, delayed-read bursts,
feature-disabled ingress, stream and seqpacket controls, and header-only
guest RX buffers. A temporary userspace backend still fails stream test
21 on both the series base and tip; that case passes with Linux vhost.
VMCI's host personality was exercised in a QEMU guest, including
coexistence with virtio and self-send without loopback. A VMware VMCI guest
device and Hyper-V hardware were not exercised.

https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html

Code was written and reviewed both manually and assisted by Codex
(GPT-6.1-Sol) and Claude (Opus 4.6).

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Changes in v3:
- Preserve Hyper-V stream routing and prefer virtio for guest CID_HOST
  datagrams (thanks to Sashiko AI bot).
- Bind explicit non-VMCI CIDs and local-mode sockets without a VMCI
  handle, resolve wildcard destinations, and retain VMCI self routes
  (thanks to Sashiko AI bot).
- Recheck bound addresses after receive takes the socket lock and set
  TO_HOST only for forwarded guest sources (thanks to Sashiko AI bot).
- Probe negotiated virtio datagrams and numeric local CIDs before running
  dependent tests; cover wildcard and VMCI coexistence (thanks to Sashiko
  AI bot).
- Link to v2: https://lore.kernel.org/r/20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com

Changes in v2:
- Keep guest RX buffers page-sized; add START/EOM framing and bounded
  datagram reassembly (thanks to Alexei Starovoitov and Bobby Eshleman).
- Preserve stream and seqpacket data when an RX buffer has no payload
  room.
- Separate datagram and connection-oriented port spaces, and share
  receive metadata and queueing (thanks to Alexei Starovoitov).
- Check negotiated support and destination CID on ingress, and require
  an exact connected peer CID and port (thanks to Sashiko AI bot).
- Select a capable route for each destination, retain VMCI as fallback,
  and support loopback-only sockets (thanks to Alexei Starovoitov).
- Preserve the connected peer address across temporary parent fallback
  (thanks to Sashiko AI bot).
- Use socket write-memory accounting for datagram SIOCOUTQ instead of
  separate transport counters (thanks to Alexei Starovoitov).
- Extend selftests for fragmentation, delayed reads, port sharing,
  connected peers, and capability-based skips; fix the test build and
  README entries (thanks to Alexei Starovoitov, Bobby Eshleman,
  and Sashiko AI bot).
- Link to v1: https://lore.kernel.org/r/20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org

---
Sergio Lopez (8):
      vsock: expose the core port allocator to transports
      vsock: report datagram receive and send queue state
      vsock/virtio: implement the datagram data path
      vsock/virtio: negotiate datagram support on the guest
      vhost/vsock: negotiate datagram support with guests
      vsock: allow datagrams to use directional transports
      vsock: fragment datagrams across receive buffers
      vsock: add datagram tests to vsock_test

 Documentation/admin-guide/sysctl/net.rst |    8 +-
 drivers/vhost/vsock.c                    |   51 +-
 include/linux/virtio_vsock.h             |    8 +-
 include/net/af_vsock.h                   |   31 +-
 include/uapi/linux/virtio_vsock.h        |   10 +
 net/vmw_vsock/af_vsock.c                 |  526 +++++++++++----
 net/vmw_vsock/hyperv_transport.c         |   11 +-
 net/vmw_vsock/virtio_transport.c         |  167 ++++-
 net/vmw_vsock/virtio_transport_common.c  |  172 ++++-
 net/vmw_vsock/vmci_transport.c           |  124 ++--
 net/vmw_vsock/vsock_bpf.c                |    3 +-
 net/vmw_vsock/vsock_loopback.c           |    2 +-
 tools/testing/vsock/Makefile             |    3 +-
 tools/testing/vsock/README               |   33 +-
 tools/testing/vsock/util.c               |   62 +-
 tools/testing/vsock/util.h               |   10 +
 tools/testing/vsock/vsock_test.c         |  175 ++++-
 tools/testing/vsock/vsock_test_dgram.c   | 1061 ++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h   |   30 +
 19 files changed, 2195 insertions(+), 292 deletions(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261027-vsock-dgram-support-683a4e0aebe7

Best regards,
-- 
Sergio Lopez <slp@redhat.com>

