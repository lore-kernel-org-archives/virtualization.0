Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203498;
	b=NiymIS6x6zki7IHFAfdQ9Y9tjtznGFkK+oE4B+FuH4VU/gRyYgtNCWNmGgrr/3ySF+p6
	 T/OiShrJFw3ItZL5l6AQaagwzyNw0c7X1Pgyzw4MashJDwvq5abK6ZjYD/0hpauQouV11
	 iCKin4gCyzybr3MhYDLul1bnKdJXnP4FYE9DiM1GELoIrk9zTaFGl3gYTrON5rdQGdv0i
	 wIV9QVIFgPTxo2d5hDeOxlaCNP8iMH1kRn4a3ApdYlaDrhwXpiGgd4mqhR0ZMQ1ZWKQ9t
	 G5HwlwesVF/Or2ejhw+LRIzpxh3NVYqsZHZYU8ktKTw07gN91gKleetvXh0iIwWI/tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203498;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
	b=JTjqbAFxB/ZIU51VHQGgn6y3XfsU3xwXCLdYZyHOoIy1os/rSDs71doPuAMOUgRbyUMf
	 Cq3qcHymPsc9+8TLRDKbqSM9czMzwLxvf60WuFIJ1uYmr+bzAPvM7IVEyNfLbbJw6I/zA
	 rhR70VDmfPP6XI7x5sYKTOw2UCCwtlMZdnpg0KHEnve8vCKHBVi74vj11DhJoQmQSb0mb
	 HWddsu/7z5AkHfL19TJU/4l3yG8S/dw6vrI/iwhJiOzfjGeIoFHvZmNzq5CjKESShp0F2
	 OUpSFGKTBIIeaXEwdKF6rQMI8WyPW0N2Zmtwzw+b74Jy3IDKVdqjQU59VXUThlNealQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SE2MOMJ8;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90D7606A31E
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 16:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C90D7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SE2MOMJ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
	b=SE2MOMJ8GtTZYwl8gdBY1XQxw+fF2I9X8o+liPYqtC70Ib6WpcexzfDMgXamxfiTL4svoi
	e7WtDA5Gv9ZXZLM9EV0WKQ9YkGQNKkfjlasmc7hCW/pXQDqZPuKi/mUbtAhNP/LIwKx3cT
	8JYHMCPbMHlMOLQs60Baqn1WgKMEVc4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-khgCYGlBNkWtgEEqxuG28w-1; Wed, 28 Oct 2026 12:04:55 -0400
X-MC-Unique: khgCYGlBNkWtgEEqxuG28w-1
X-Mimecast-MFC-AGG-ID: khgCYGlBNkWtgEEqxuG28w_1793203494
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c25501f4aa2so155391466b.1
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 09:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203494; x=1793808294;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
        b=b+ymhDcDjxhLEjeGHGn3Nk8z1hcP4J5Me4NN706EwYjHwCtFbV1IlMsSrAJ334BDqY
         sryJvxpGaIvEEC5QR9c6MtY8EmBwncMpfCaVbBuIQvNuVEwwREUDF7w2o43ZNBwMXg8l
         hD3USViblfHC45YjHV3RPLeBc6yR/qf7r4sBHox4JP3B4ZYhJO2vPMbifJCK8KTYR1Es
         dvUdVPNLANv8s2ihAfE6ayuM4iVicw0jMYNioeSV4cUZO6ca5Q+FMSb81mBhZVdaCIGe
         A1nOO1bK/+U3dxvT+0oeAqJCpXUVoWAx/n/mIynbdaN9rJcD8JfQvP/9QbmkWZqX+Qoe
         1dSQ==
X-Gm-Message-State: AFq9FYJ4k7lREC8qj4PqjY7C06vfcM///czoSsPSQvOfpmSL63PpIMVQ
	vVRw53y+BU5UPqt6cnB/ATM/qE3fLNO3JCq8Y91NWuhv2UaGewYmgV+LRTmXOrSvo+AMf/2A5oq
	GEGglkvukMuZHLX/YQAnBkrkUY4SbDCry9VMSmKeToA5R0HgSsVOU6DV4mO1Ucnr5CASm
X-Gm-Gg: AYBFou0vMA15dyHUjdmkhbDGjdJQHIO+2W8ef8H+ZQMZAFKTdM3BVdIzNOy85rthukj
	DKHZEdmtN1LxK14sBmqyv+1AR1Snhx3N9izhUeoAyO6uEksccOyxceeMTWaQMiibZm0l+nsya7p
	CafV0YQQWdU7VTciDFU8A7XhdXYldENRkC5rqeeQMOJUT/Dv3gdA+YyRkSZaAoVd3khBkd/Xz6M
	AETtWrxk0AeVcG1mvHpoGL7+SJnUtBN057T1ILuLWPfO3Z8ivoLJp0Q1yJsk9CNNrS21o1rDVTf
	dNoS2Tzz4UKRcrtdUmX7aoFKCqiNhwTIxIa6/4r/cRV3IBuhX5oKuSUfHt5Cr8CywTTLzeQwGn5
	iblEd0bS0bFQU1353FVpVoEum7js55BwJKytv2G794/qMJOt+nPCSG5HRUiLRxZw5z0B/Q1WSqk
	OBqbp/frKFW8w=
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c49a742b50cmr551014766b.24.1793203493709;
        Wed, 28 Oct 2026 09:04:53 -0700 (PDT)
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c49a742b50cmr551001466b.24.1793203492607;
        Wed, 28 Oct 2026 09:04:52 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:51 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Subject: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
Date: Wed, 28 Oct 2026 17:04:29 +0100
Message-Id: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3bLi/ORs3ZT0osRc3eLSgoL8ohJdMwvjRJNUg8TUpFRzJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAP47zmGoAAAA=
X-Change-ID: 20261027-vsock-dgram-support-683a4e0aebe7
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
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
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3196; i=slp@sinrega.org;
 h=from:subject:message-id; bh=IAsDh8eAGF2GwPL8C87LSOoOWcUAY+hEvje7pI2yfrQ=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0ayuzqJP9Rcnuf3cdPX7iTWVlDw8ysZGp8Z
 wGNuM7AzKqJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdGgAKCRD0aSeNLwwC
 NZFHD/99IaYlGVSilyovjaYh2x2j+28+Keg9pElFi2ecT8gYqUy06MR1kFmZOrZsoqHy7pYwssH
 V4esQeAgESGZQtmvBNjEYuJ+SvP+jxLEqWzkQ7r0RzpIRxnGb+YjcYrTZu4HDNzFxBwL64Wmn02
 8ajh2a9t7wNNH/rvCNCpGt0V3zBKlQTB76xmObSCX5LfXENqL+fkV40PShUObL9gFOh6lwDQbkm
 qaHV0S7DGuhCDKFx+bOHBcI1WPuv+TVqoambXNF/El5GBreBkVoRFTzO4RaSLa2YK4yYsXjGdoN
 T4z1quggOJHvkITVGN/GItwaAFEOf6Bq8jQZ7QjAixm96Pi5OTxx/GeCmlV78mrHFPJe2gvOy/g
 WO+59N02oABNlSNaS8u+RQGwPigjgXYNDrITmaZePAtwTHi19KyDSVtI1RUhuTpM0kax/tdgUaV
 +HtPuC0HnrBXjNsU8UMvsi3soX4qOp3udDj312ClRvwBLneCo83BNxkTIImVlxCYfVCefkaaI22
 pNdV/ATqALFUZ54VVwWAVjzTvFx+1P/2plUbjAvLPEVGAWqFJGfvWF62xj2IsgkQ5AIMMZX8XBR
 /jnziV7xCe4LIWvGgd17vYzux4WMnxHqSRgiv/xLo+Ur85IEENwWIklCMJecGG/MYbEJZzl6omK
 7+lvOZABr5ugX2g==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: upqC9ZNAYZ0WTbirKnx1R-pCJKSdYgfF2zKN0lRJ82I_1793203494
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series implements SOCK_DGRAM support for virtio-vsock and
vhost-vsock, allowing applications to exchange connectionless messages
through the existing AF_VSOCK datagram API.

Support is negotiated through VIRTIO_VSOCK_F_DGRAM. Each datagram uses
a single VIRTIO_VSOCK_TYPE_DGRAM packet, supporting payloads from zero
bytes through 64 KiB. Pending sends are bounded by the socket send
buffer rather than peer credits, with queue accounting and poll
readiness reflecting pending output.

Datagrams use destination-based routing across guest-to-host,
host-to-guest and loopback transports while retaining the socket's
transport state. VMCI keeps priority as the dedicated datagram
transport.  Guest RX buffers accommodate complete messages when
datagrams are negotiated, preserving message boundaries.

The patches first expose the core port allocator and add datagram
queue reporting, then implement the common data path, guest and host
feature negotiation, directional routing and RX buffer handling. The
final patch extends vsock_test with local and host/guest datagram
coverage, including peer filtering, route changes, message boundaries
and queue ioctls.  Unsupported cases skip automatically.

Tested using QEMU with a patch that exposed the VIRTIO_VSOCK_F_DGRAM
feature:

https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html

Code was written and reviewed both manually and assisted by Codex
(GPT-6.1-Sol) and Claude (Opus 4.6).

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Sergio Lopez (8):
      vsock: expose the core port allocator to transports
      vsock: report datagram receive and send queue state
      vsock/virtio: implement the datagram data path
      vsock/virtio: negotiate datagram support on the guest
      vhost/vsock: negotiate datagram support with guests
      vsock: allow datagrams to use directional transports
      vsock: preserve host-to-guest datagram boundaries
      vsock: add datagram tests to vsock_test

 drivers/vhost/vsock.c                   |  37 +-
 include/linux/virtio_vsock.h            |   6 +
 include/net/af_vsock.h                  |  14 +-
 include/uapi/linux/virtio_vsock.h       |   2 +
 net/vmw_vsock/af_vsock.c                | 206 ++++++--
 net/vmw_vsock/hyperv_transport.c        |   4 +
 net/vmw_vsock/virtio_transport.c        |  71 ++-
 net/vmw_vsock/virtio_transport_common.c | 197 +++++++-
 net/vmw_vsock/vmci_transport.c          |  10 +
 net/vmw_vsock/vsock_bpf.c               |   3 +-
 net/vmw_vsock/vsock_loopback.c          |   1 +
 tools/testing/vsock/Makefile            |   3 +-
 tools/testing/vsock/README              |  23 +-
 tools/testing/vsock/util.c              |  62 +--
 tools/testing/vsock/util.h              |  10 +
 tools/testing/vsock/vsock_test.c        | 154 +++++-
 tools/testing/vsock/vsock_test_dgram.c  | 809 ++++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h  |  26 +
 18 files changed, 1545 insertions(+), 93 deletions(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261027-vsock-dgram-support-683a4e0aebe7

Best regards,
-- 
Sergio Lopez <slp@sinrega.org>

