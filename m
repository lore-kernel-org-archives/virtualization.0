Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569033;
	b=L1FE4M4KxE8tAYLlRhLGSglTKJXqeqtwcGibxNZbvNXtVv54hTGyGv3tCyEfC24+d2pP
	 3YXguG1/4x0asXxMgWtduBdpqVm1r+fXhNwwo925UybJgLErjko6raVRbJCsBtJDTR9nx
	 n+YkCNb5CNoUmLMgYP1mVLvtgD2SAZ+zTw4MyN2bJyJQz8Lm4OW0lVG6N+7HI3I07q6zB
	 yIBw7yLFPtGGgz0ndpsoWZ4DcPuA/nmbpjOq7bbvL+1528Cnc1HV/PcXx3QmZP29pNnpq
	 5WckVY9j+uAUZz7bjUW1PrwZrXiTXuAsAdtTyS+ygu6theNeqZn785ZB3xTekLrcJiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569033;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=7Dqv2gwj0/nv5UbdQEd7aSrqQef4tqCqRf4kiR9t/Hk=;
	b=gcRMV8sCj06tc8WI1xSK1eigLzmvDN/QweaWSdpTyJeLuGTub5lhorNJObTCOhIg1Rla
	 VhXkw2kV1xR6vR7Mr7CmvU9hjV/PJwN0FvKJulGNDgofMkizpgtEqnT6B8IcUJoEf1qHe
	 6vrYneo0l8LcEBj5CZU1JLXTmpWdlHcbH1U83BbNfia7AEKX4JqOvGrGxEX84A5GVxNyU
	 c2ROS6vASHeTvDcQpJkWszCog+tmOvb/8miRL3i6uM2Pvg4PUFk6E+hAejpNWai/xkUHm
	 26oPcIoz37L9x9356Nyxw5DnexM8POVRyBSIK9mnbepj0oAgqXTDa/DyZwc5PM9uCeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5wRbpWD;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B61606A31B
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B61606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5wRbpWD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792569027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Dqv2gwj0/nv5UbdQEd7aSrqQef4tqCqRf4kiR9t/Hk=;
	b=K5wRbpWDIy4Zwef3t4dNZ0POIUDIlwSCrrDyz19IWw3dobn0/ah/1WhDNjPR3F2It0wN0W
	qgpV9c5AmRWF2XjnX14rYRcd3h6O4IypUnimAqGJFJ2TRv9QkQ1RDrTqhCBxO6apbUUfHW
	aVYNjPdoOQmJku67dFYawEW+vONuArk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-dzRUV86bPz2nLBPJkG20rQ-1; Wed, 21 Oct 2026 07:50:25 +0000
X-MC-Unique: dzRUV86bPz2nLBPJkG20rQ-1
X-Mimecast-MFC-AGG-ID: dzRUV86bPz2nLBPJkG20rQ_1792569024
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c4445512dso361749f8f.2
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792569024; x=1793173824;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Dqv2gwj0/nv5UbdQEd7aSrqQef4tqCqRf4kiR9t/Hk=;
        b=gy/Yaz6/cHHKuwC2i11029UvGcibs3uEjr7HhRT7xwb1LLnxjWnWq9mW17nnDbxFWL
         gx1zJHONymiPlAYs8vrI7ezQWzmnZ5hBRHAWltjFfWCGsGoZqqZl/ynNK6ywOT0uGCv+
         JLRcWhGlnNuzuf1de7IX0ixkMILBfSozsvMnhPC2zW9JQgKioozCQprRTJp3NCWyg97J
         5YRSUHEWLZQnlvGwJKd828hCQ/XNPv0c04z8HOwFKlzMo83jm7/7iGaQ+m7BfZSxBCS9
         tSD98XVyBjl0jy6n3Ii+ZeeSZYC9Kj9WgHtA0qcJf1KNQSCYnws62IFBOx9PWi1QwZ1j
         bHoA==
X-Forwarded-Encrypted: i=1; AKwUvBw4SYswHtlySAUWgMSsmbNha07ij3sr74/e6rrfMiWYMzvmHQyhw+sdCPKaZu0G8FqAdhW7C2SHMlep8T7UdA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIkUAQ8N7C4sE/PKpCGQgr0ieSLMUXXxwn1+IH8+uGCiyvKe2sB
	IPkhY/i5yjeHQQJqfw9whtPaf7GkPnh3xaK5EQZhuAeLuorpX0/xC1P+GqmUR3EkYenjpbonML8
	wqh2Q2uUBoZxUetykAwLkvz/nIs7NR84IjP99aXY1eJZvwkVoC8p3neIGCR567zxekKL5
X-Gm-Gg: AYBFou3o/+1yW3HQWHviobxsXoHoWYqwQjtpKUtguHsnwEK0efZCD1E34WksS1SiTeO
	vHtwrOi2Kxo3BxhhF9aoVOFQzmzwRtlAOU8C0je+JXbW3eXhOtOmV/4BGuVVQGV8rGIA08O9b6v
	C4R3+OWWT3Ryl1OUsPn1IvdpFcWPycUqlbkdCcTLBokLhXsOzs/BjJm9Do8S38KES3TRZuiWXHv
	A69Wb3EclIrMXMUMwf980Inky2ZjVEklEBZttVKYoZyrpBCpqL7S9oHTkY9Fq9PKOum5ybbBkk8
	DZlrYnPIJSlSdQJbhLuoX5BDFHXaPFpBY+QfEHzf7qdpUBaJXfKtlGnhC7gJj7Gjx8KbVw==
X-Received: by 2002:a05:600c:3f0c:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-4a1fdd3bdeamr20884015e9.31.1792569024107;
        Wed, 21 Oct 2026 00:50:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0c:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-4a1fdd3bdeamr20883545e9.31.1792569023605;
        Wed, 21 Oct 2026 00:50:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d324f8sm121013585e9.6.2026.10.21.00.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:50:22 -0700 (PDT)
Date: Wed, 21 Oct 2026 03:50:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH net v4 0/7] more virtio-net csum hardening
Message-ID: <cover.v4.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nJBNN5nghWKvei2QWWBVkc-CjcZCA_NYRdOqqVyIPFQ_1792569024
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

v4 and I'm pretty tired of this family of issues.

Willem suggested more cleanups, but I don't think I will
be able to dedicate much more time to this, there's a pile of
fixes I queued that need to get tested and go into rc2, and a bunch
of qemu features that need review.

Hopefully if any changes are required this can be done by patches on
top, or if someone wants to take over this, very welcome.

------

As reported first by Paulos Yibelo <habte.yibelo@gmail.com> (after which
others, credited below, found more ways the bug can affect users):

allowing untrusted hardware to specify csum start/offset for
CHECKSUM_PARTIAL was not a good idea, because, if it edits the packet
outside the actual checksum, and depending on the setup, the networking
stack could be looking at the packet both before and after the edit, and
seeing different results.

Previously, commit 6785011f8b16 ("ipv4: validate checksum_start before
completing checksum") validated all known instances where this
causes the most grief, but the real fix is to make sure
that either only actual checksum fields are ever edited,
or the checksum is completed before the net stack looks at it,
so it is always consistent.


This basically goes back to
what we did before f43798c27684 ("tun: Allow GSO using virtio_net_hdr"),
except in a narrow list of specified known good cases.


Summary of the patchset:

These are probabably net material (and seem to be too big for stable,
or I would recommend backporting there, too):

  net: account for ingress-resolved virtio net hdr state
	- accounting, not the fix itself, dependency of the fix
  um: vector: trim skbs before verifying the header
	- fixes the um receive path: without it the checksum would be
	  completed over the unreceived tail of the buffer
  virtio_net: parse tunnel csum_start little-endian
	- bugfix, a dependency of validating the header
  net: resolve uncommon partial checksums at ingress
	- fix itself
  net: add a sysctl to opt out of virtio net hdr checksum validation
	- reducing risk of the fix by adding a sysctl to disable it

These are cleanups, can be deferred to net-next, too:

  net: add ip4_parse()
  virtio_net: cleanup protocol calculation
	- cleanup resulting code duplication
	 (kept separate to simplify backporting)

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")

Changes since v1:
	- reorder patches to fix bisectability, addressing
	  a comment by Björn Töpel.
	- code refactoring, different patch splitup,
	  a sysctl knob to disable as suggested by Willem de Bruijn.
	- fix a bunch of minor issues spotted by LLMs


Changes since v2:

virtio_net: parse tunnel csum_start little-endian
  - new patch. correctly parsing the header is a dependency
    of validating it, otherwise i do not know what to validate

net: account for ingress-resolved virtio net hdr state
  - make rx_csum_sw counter 64 bit so it won't wrap
    (spotted by LLM review)

net: resolve uncommon partial checksums at ingress
  - tunnel fixes to bugs noticed by Willem de Bruijn and
    Chris Arges
  - restore the csum_offset checks as suggested by Willem

net: add a sysctl to opt out of virtio net hdr checksum validation
  - the knob is no longer writable by root inside a user
    namespace: changing it now requires capable(CAP_NET_ADMIN)
    suggested by Willem de Bruijn

net: add ip4_parse()
  - comment converted to kernel-doc format (Willem de Bruijn)

um: vector: trim skbs before verifying the header
  - new patch, found by code review


Changes since v3:

net: account for ingress-resolved virtio net hdr state
  - um: vector: honor virtio net hdr conversion failures
    folded in (Björn Töpel)
  - count on tap and virtio_net, too (Willem de Bruijn)

net: resolve uncommon partial checksums at ingress
  - walk the frame on loopback, too: loopback_xmit() runs
    eth_type_trans() on it (Willem de Bruijn)
  - return the mismatch handling directly, GSO is implied in
    the tunnel path so drop there outright, and fold the helper
    into its one remaining caller (Willem de Bruijn)
  - read the IP version through struct iphdr (Willem de Bruijn)
  - document the ipv6_find_hdr() flags choice

net: add a sysctl to opt out of virtio net hdr checksum validation
  - renamed to virtio_net_hdr_validate, in case more validation
    is gated by the same knob later (Willem de Bruijn)
  - point .data at the value like the neighboring entries,
    the per-netns registration rebases it, and the handler reads
    the value directly - no ctl_table copy (Björn Töpel,
    Willem de Bruijn)
  - check the opt-out before parsing: with the knob off, packets
    the parser cannot handle were still dropped (Willem de Bruijn)
  - include virtio_net.h in net/core/dev.c so the static key
    definition sees its declaration (build warning reported by
    Jakub Kicinski)

net: add ip4_parse()
  - add the missing kernel-doc Return: section
    (Jakub Kicinski)

Tested: full suite on the final tree, tunnel included.
um part compiled only.


Michael S. Tsirkin (7):
  net: account for ingress-resolved virtio net hdr state
  um: vector: trim skbs before verifying the header
  virtio_net: parse tunnel csum_start little-endian
  net: resolve uncommon partial checksums at ingress
  net: add a sysctl to opt out of virtio net hdr checksum validation
  net: add ip4_parse()
  virtio_net: cleanup protocol calculation

 Documentation/admin-guide/sysctl/net.rst |  19 +++
 arch/um/drivers/vector_kern.c            |   6 +-
 arch/um/drivers/vector_transports.c      |   4 +-
 drivers/net/ipvlan/ipvtap.c              |  36 ++++
 drivers/net/macvtap.c                    |  36 ++++
 drivers/net/tap.c                        |   8 +-
 drivers/net/tun.c                        |  41 ++++-
 drivers/net/virtio_net.c                 |  14 +-
 include/linux/if_tap.h                   |   1 +
 include/linux/ip.h                       |  30 ++++
 include/linux/virtio_net.h               | 279 ++++++++++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/bridge/br_netfilter_hooks.c          |  15 +-
 net/core/dev.c                           |   7 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  50 ++++++
 net/ipv4/ip_input.c                      |  13 +-
 net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
 net/packet/af_packet.c                   |   4 +-
 19 files changed, 533 insertions(+), 45 deletions(-)

-- 
MST

