Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574187;
	b=zz1/nKjWKB0uPzUiVYFmMOjYHt1EaoNE54SYf3Ck5Ghz0hEovA+S3+kZIzd5yAGyLcV1
	 p7oq1KKtuqORhcR1AQ7AHxouXWameb9u1pTwMRnRXWVfmtI8N2D8d5jPycOko9YkpJrok
	 L7pccFxLmvqMCNM8ubJURc8la90FQ4OKS/pM0YA1mIGH4QfjLzsCeVJnBgRrXa6Y68Cab
	 6j/QsaQlqd+xQOQ1wzxojXtJfJ8RD2gUX6aylgVT6spi/z6FHwVUVNDlhNB5uRAcW1+Ci
	 leaJVSS8rmaCZvgcX6oaOwcapNeX6RrPZ1Tpph5ayheXuWBaoFztiDjy5ehBbkHaTEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574187;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=xuGzZpBSWxAktfUn8GwyedRb2Dbl/HlSNSopw3gGgAg=;
	b=2NwO3Mdl5YLfACoZsf0u4C/hxYMSUQ8s2upBOIfUOqpQc6M+qgs06pEzq9S+76xekM/c
	 MSkTTGpl99dfCnAXM67mYO7gC16/lDaRn0o6tihIAM5+BG/mK8W1VriQbvdanM6U1NYer
	 nJJ7vyquR4LkjJTxuB0kLglL7WFi9ZPCewSteGNPW9YWX81fmT9iIOMGGEIO2R7URWO1M
	 C5C1E9Y+Q371WL792ncHKDsaeHuVr47QPsMZ9sroH+XW+EHp0HErKVUe8WXbOrR+IESEL
	 L+0AQgV2ZM7RBxgtJXaM81/VyBrJGh5CU8lrMvQJn7vCZtSVu7fc/xFjK7VYgxDcPlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JbMwXhXQ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C37606A334
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 12:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C37606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JbMwXhXQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794574186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xuGzZpBSWxAktfUn8GwyedRb2Dbl/HlSNSopw3gGgAg=;
	b=JbMwXhXQSKgdlmlLXZFaVY6s+M/cm8v0BJ4DPu3zlNrkjZN68Co/Zi4dUkHbffRzQC2rqn
	+yzZlAwuggFUR8TEHgXLpdms3h5v8anKDKp19yzb3cC6vsvYzy85ohbm/oSGYyfqShUSpy
	JXPcwRdvH+GyNkuu9kEtIVsivk9ikiY=
X-MC-Rep: binary re single
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-jfDB2ltfMm2R5GwFP_dIWg-1; Fri, 13 Nov 2026 07:49:43 -0500
X-MC-Unique: jfDB2ltfMm2R5GwFP_dIWg-1
X-Mimecast-MFC-AGG-ID: jfDB2ltfMm2R5GwFP_dIWg_1794574182
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso497686f8f.3
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 04:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574182; x=1795178982;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xuGzZpBSWxAktfUn8GwyedRb2Dbl/HlSNSopw3gGgAg=;
        b=CB6kSswSwsNSsb6O8f8VirCOISnYZTniBAkDjQzSexncqnJeSOfinbHP4i93VLhvQX
         5iLMgus4sz5Nb3wU7GjpLSELCxtBgwUUBOeoRXNhSBdjQJJmGaOjdrDM4JZD9ceRdVzy
         mrJk3OaFUQige9aoEYLVhFV5yMWHxqXOlGpSFWFhdJTn/kA2Hh6inRNen80XNFO/11wt
         GCOvEL/W4ME0HEnTZ03Z+kcqN0dDCJopSvvnR1fFXxHCmgROqRJE77LviJZTBVKc+S1B
         MYr0Gq6DN4Ob8ANJAuCnodVsJckf83Q7L15dRYqf1ts1YNNNNn3vAGyIKII8QCeboBg9
         Z7Gw==
X-Gm-Message-State: APuU4Z/tL4ur9hllYzI4E6idxRsF9/UNYuP0v3yMKrV030LC7qf8+4DP
	Cic+DowExNwsBRVaU42bEzxsaO2CaeXgfF6muq5HvUpIt2addbK5XiAOBtYmcWxY9HDKwLlBPco
	3PUhnvR+wlTP7JupxJM+nKivsop+vcQH9GFMx/O0fWfHOuRjX23tVPOHIqG5N15Zy6JdZ
X-Gm-Gg: AYBFou0VEaF3+oU2e/ISFdyePQgFp18WmOtw9MdHWMdVTGYoQ0i1Z4lXiHDGTtlZSsW
	drHcWUIRSTDPeBiruFxHUtAX4rDl8ueIx6GTz6FdD2DwxrmhS+rLZM+OlFr/B2mkf1fETjIYhws
	hagY84+ot9pLNKV7NnvUEsTOeJwqMkQhIRZhRshhwY4ggqXNUpWg8jp5KGHgSPoOME0NcUGA+4U
	c0j+4+uwRmGw4RPx/RpuSrK5HVSScHxZNpm7DQZfow5GVjkxcjraRjQSifLFP+4Q095J38wQdH3
	8RiAGFOD2lbXpZN6KvqyIFmxJ/NAIuS/BXkrBEuOfUboG9USPjK4HOkBNawQjFRjNlRcr4872Wu
	E0FOeXWZg/jq6CU6qn1n5HvzH26WNO78OVV0/1LRuWqyeKP8Yt9HNxjG7wkl4Zq4cPZ0IhlSU2p
	hY2LWWOJXie/0=
X-Received: by 2002:a05:600c:3b91:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4bb55a3e29cmr53767575e9.7.1794574182325;
        Fri, 13 Nov 2026 04:49:42 -0800 (PST)
X-Received: by 2002:a05:600c:3b91:b0:4a3:59c9:a744 with SMTP id 5b1f17b1804b1-4bb55a3e29cmr53766935e9.7.1794574181890;
        Fri, 13 Nov 2026 04:49:41 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm151135805e9.15.2026.11.13.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:49:40 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Subject: [PATCH RFC v2 0/8] vsock: add datagram support to virtio and vhost
Date: Fri, 13 Nov 2026 13:47:33 +0100
Message-Id: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQrCMBBEf0X27Eoaa1M8CYIf4FV6iOk2DWJTd
 mtQSv/dUDx6fDPMmxmEOJDAcTMDUwoS4pBBbzfgejt4wtBmBq10VShtMEl0D2w92yfKaxwjT1j
 Ve1uSsnQnA3k5MnXhvVpvcL2coclhH2SK/FmfUrFWP2n9V5oKVEjlwbjOOCJTnyQMTN7uIntol
 mX5AsLE5oG9AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6171; i=slp@redhat.com;
 h=from:subject:message-id; bh=ky1aXYvyF1guKqM4c6+Bd9gJT95CCp8BgqXs0H6uWDk=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq9wdYvNEPhbQZpSreuD768+vZB/evKyKThMruj
 3GQGZIenCqJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavcHWAAKCRD0aSeNLwwC
 NQZoEAC0NUajSl5WwiI1RBq2VAObU5vpb2jsW2vCn0sHxLYw5IsOYg71SQmBRpIHD5N/xRD+zrv
 S3kXHYETZS+/IcfcpF8buUnB3PKsJ0+FMbP8Cwy5L/WmLnjeDfhoyUsPppTPBU6WH88FufbBNgs
 vvPUGmD30HFAJs1NqOWb0yb0leWLP5NjWHdrIorX+LmhGwjSlFE6Wx05A8sXeHgXGANhqFEHd62
 29HxwUaNA+t83v/OOkhbJWpucTmrkx8KNQVEtYUttOG81unRaQh1Ln/JQHTtGP/H2xpVAxDLU5G
 Gxgi4lAdnP/nxPzQCy43Or7f8T0MKyJIOe/snOsqdngGxLML+rOSMi1ojKk7m6/rFvS1blulGXV
 dsCNg3vjG6kUKk9u1lFwtU1xPPbJsRAWSgiZpvctfLJCfM+csO7+VrCetvsyEtcdKnz3YQ9D65n
 NdxXoFS9NoxUgUrmOHtGcpZdTZg3AWeG0zFw1ZMjWOdFMwnmNWKmcG1G4vKTUf12ML3eaiRRwi+
 EeuiKdlUePfQVqk5cu9F0PLorRr/qgky62Kqq7loPYgFwD5cediDgx51ZYMiiHFJJ/udb0PGZc1
 g1+bH3NmC57nLLdBzzQVEMCZtHzFd44xnd+yRMX8YVH1Jm6a+1CKyW+j2ExRpKb0McAFwJAsi39
 8K9ABE3kpr35RJg==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aOsREt1tJhA67F61xHWOuedjD0-at246Ba16VlGvy1U_1794574182
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
Real VMCI and Hyper-V hardware were not exercised.

https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html

Code was written and reviewed both manually and assisted by Codex
(GPT-6.1-Sol) and Claude (Opus 4.6).

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
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
 include/linux/virtio_vsock.h             |    9 +-
 include/net/af_vsock.h                   |   30 +-
 include/uapi/linux/virtio_vsock.h        |   10 +
 net/vmw_vsock/af_vsock.c                 |  459 +++++++++++---
 net/vmw_vsock/hyperv_transport.c         |   11 +-
 net/vmw_vsock/virtio_transport.c         |  167 ++++-
 net/vmw_vsock/virtio_transport_common.c  |  164 ++++-
 net/vmw_vsock/vmci_transport.c           |  115 ++--
 net/vmw_vsock/vsock_bpf.c                |    3 +-
 net/vmw_vsock/vsock_loopback.c           |    2 +-
 tools/testing/vsock/Makefile             |    3 +-
 tools/testing/vsock/README               |   31 +-
 tools/testing/vsock/util.c               |   62 +-
 tools/testing/vsock/util.h               |   10 +
 tools/testing/vsock/vsock_test.c         |  175 +++++-
 tools/testing/vsock/vsock_test_dgram.c   | 1000 ++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h   |   29 +
 19 files changed, 2066 insertions(+), 273 deletions(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261027-vsock-dgram-support-683a4e0aebe7

Best regards,
-- 
Sergio Lopez <slp@redhat.com>

