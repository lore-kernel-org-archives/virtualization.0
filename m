Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793596;
	b=Mdce0I78RB7iXcCnHb5NKWallZETPSmhh/d86Icurx9/M6Y+Ux4VUwsSEbIROsQccvTY
	 REiNtoEXRO5+PwD0heCl+4ZEBHXGVjPMXlSRUAIIjEJ2o8kfY7naPvnng8i8InWDPEyXR
	 hqCBlMj99x0Yfle3FwNgOffeLR2nSNb2tampSF9pQnB5v2SIKbVRpFMdKbDYk7qhHcPRj
	 KCII1t9b+KT90k9zJDyvpVjk0S1N2ueqb9l0E5j/Eg4DnN2MJZZReu0B+PPQjgKlNdRre
	 34T9s3j8+d39SxMO0vhgB/dwA7+tqwc5y4SXFKVhuLEgSioVf/ddeUVaZgxWyLMpdWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793596;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 X-Mailer:X-Mutt-Fcc:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=dwKOL9tLsHkBpWEr8W9UBVIbsDSAVfWFuWgwO9Ic3d0=;
	b=oj/1EszdnrekDnr8F6g/7eZ1lLz4XfqMoPIKNg8CY63aVpgB369b8uCNCDyzBnSLfESc
	 n/ygV4gZWbHoYmjwIwFZ6KyLdJ7BU5xQ0qnMc/DCPAK2+rCv4y0El+66Wc0ahguycd5mK
	 QYtQCP0f733HD5UaP09+4P8ImAwJQkwVVbmXlRSsGMq1iptFUsH2CPF9OUcVtqAzkVkkq
	 tQriJMMYwB+x36Hq6UiWnq+MWNjFMnGQo4nEr4wCllXhLK7PffAQ6JdbQ/dxQRj+jKlxn
	 lz+7QkwWlC1j4ZDWdCFRrwg1fA8xBOzaRDEHqLGfx0MedGvJDeZN+P0EtVFpPom4fCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="G+kH8/X6";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BB606A328
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 11:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 059BB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G+kH8/X6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793793595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dwKOL9tLsHkBpWEr8W9UBVIbsDSAVfWFuWgwO9Ic3d0=;
	b=G+kH8/X6TORlxQKYzi1NDwt1geHVmQlvf/kBrRf/TikiXcdx+b3kKy2U3LRSunZyaBaMSv
	NrizF2WXqwlkTdqVKL5KuCwAMusLrc0sK4XvKDcmerbxRl99daWpINAYKq6YHvX8tgMFFr
	cdyvZ3ScWac//py1Fd3spTy7lWCzsZo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-4DTkU7j3O_GkNikO_2xe5Q-1; Wed, 04 Nov 2026 06:59:53 -0500
X-MC-Unique: 4DTkU7j3O_GkNikO_2xe5Q-1
X-Mimecast-MFC-AGG-ID: 4DTkU7j3O_GkNikO_2xe5Q_1793793593
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso4349625e9.3
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 03:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793793592; x=1794398392;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dwKOL9tLsHkBpWEr8W9UBVIbsDSAVfWFuWgwO9Ic3d0=;
        b=D4e9yBdwVg7vt/wWmYPCu/a9YDBC0uQJ5x7y+6q6/S2g1QRGUKpzMXvlii7mxsr2f7
         CXNx4DZ50qj5WLcKrIWyfqU7rYb0RdGC2Bk5R8UHR9Dc3HWtv7BA+YwSgh4zu/DVknUx
         lX6akLNL68bwh8es/L87EIy+v6xpwwNALZ84ZaQalaGC9zimSZIFt7W4ZJ6wpezkFk++
         eBrpjHylVciyb15cxu0d1lUDYbY2jB0C6vYV/rAjalCOhjVSDAIt/nSTQ1uaOqAaGwX/
         sf6i5oh0QOKYleDaTFn1Uk8wFb9flR6pqp+Z532wBMc0EE4p0bynvBCNUloqmCwhRbo1
         EIhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzF95uSa8VvwG5OJGEs2cR5CaVPNR4e4eMymcM9V+Jfc79GyhAExRA6xjDvVJdH6Bt6soGQ1+2fHqZzmwAWhg==@lists.linux.dev
X-Gm-Message-State: APuU4Z86tYarnnOXKSJ6n2JlCZvmPGbPfn2YcKff/PS/JakIP4fFCNNO
	nlFkzasSt3et0ZdUuR2h2xImd2rmr6L5zWKExwBVzQIe8VYDNyjHK/9OIwWI6n/X8u1XTflhlEf
	Ht4m/kObTZHK1DZHLDskJgqeas5ys+gNGbHmw7ZWXKfPWbf6Mqt3dxYLVUt0ZgogpDRo8
X-Gm-Gg: AYBFou1GO1u1TclNI2RF46xA+s2J7EtFtHUF/Ohp/bGUJkrHncDm44o9wbPepL2joJ7
	WUp6771scqbIsOWmv3HowD4DxEuzAKTAnEFr1uFSxA99ZXywp48tFlXLHI+o8+MSAHR8NxHbkxy
	AfCIjn+MLIINLCsp/sezn/GijZSaFuuaiALzuWBTqPuQDv7kM8ZKnp8ibxlxmAshrOt5neKiCAe
	vysqsdmfvrDfhaIa79bA9Hi5CFDwCsm0hpVMQPHe6AJyQEwIKT+IWZ9Al3kutW5oJEbnIOj5TYz
	F3sXnNt8MNpfRVBnYBeTHfC/UTqKqDTrZN0+KtjZf/lU3t6aTQZpFcX6CrRyyxtN5+t6bY8vIZh
	DKZ6/eggHEaUkJtpDKcAYWjEiKUeOdCI91mlwnOHwAg==
X-Received: by 2002:a05:600c:1d23:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4ac185bccfbmr364154555e9.13.1793793592222;
        Wed, 04 Nov 2026 03:59:52 -0800 (PST)
X-Received: by 2002:a05:600c:1d23:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4ac185bccfbmr364154215e9.13.1793793591720;
        Wed, 04 Nov 2026 03:59:51 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ecdasm74195465e9.5.2026.11.04.03.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:59:50 -0800 (PST)
Date: Wed, 4 Nov 2026 06:59:48 -0500
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
Subject: [PATCH RFC v7 0/5] more virtio-net csum hardening
Message-ID: <cover.1793276116.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: OQGTsxLflQLpAYF-zGdrO1bRTKFtjtFenaMri_xttr0_1793793593
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


Sending this one as an RFC: two issues are still open.

I'm going to be working on other things in the next couple of weeks,
but I thought I'd post this in case anyone wants to take this up.

Issues:

First, the general issue is not addressed 100%: if a tunnel inner packet
happens to have a valid header at inner_nh_offset, it will pass all
checks, but the transport header can in fact overlap e.g. the real TCP
header and the checksum will overwrite that.  I do not have a good idea
how to address this without either a heavy protocol-specific anchor
derivation or dropping well-formed offload.

Second, completing the checksum at input breaks nf/BPF programs that
might assume that the packet carries CHECKSUM_PARTIAL,
then tweak the payload of a packet in flight and rely on the checksum being
fixed up later.


The sysctl added in the last patch could serve as a work-around, but it
is a very blunt tool.

The issues were mostly found by code inspection, but all reproduced by
me in a VM.

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


Changes since v4:

net: account for ingress-resolved virtio net hdr state
  - count on tun only: dropped the tap, macvtap, ipvtap and
    virtio_net counters (Willem de Bruijn)
  - the driver side branches are in their final form here now,
    moved from "net: resolve uncommon partial checksums at
    ingress" (Willem de Bruijn)

net: resolve uncommon partial checksums at ingress
  - no longer touches the drivers (Willem de Bruijn)
  - a packet too small to be GSO: ignore the tunnel GSO request,
    same as plain GSO ones, and complete wild metadata in place
    (sashiko)
  - document the zero copy interaction (sashiko)
  - honor a preset skb->protocol on ethernet: the stack uses it,
    except on loopback which re-parses the frame (sashiko)

net: add a sysctl to opt out of virtio net hdr checksum validation
  - document the netns lifetime requirement (sashiko)

net: add ip4_parse()
  - pull the whole header, options included, so that the
    transport header offset is within the linear data
    (Willem de Bruijn)


Changes since v5:

net: resolve uncommon partial checksums at ingress
  - read both skb->protocol and the frame ethertype: do not
    validate when they disagree, instead of preferring the
    preset protocol; same check after the IP version inference
    where there is no L2 header (Willem de Bruijn)
  - pull the IPv4 options in the helper as introduced, with the
    transport header offset computed before the pull
    (Willem de Bruijn)
  - fold the trivial protocol calculation cleanup, formerly a
    separate patch, in (Willem de Bruijn)

net: add ip4_parse()
  - the options pull moved to the helper introduction in
    "net: resolve uncommon partial checksums at ingress"

Changes since v6:

all patches
  - rebased on the current net tree: v6 no longer applied
    (Jakub Kicinski)

net: resolve uncommon partial checksums at ingress
  - validate header before the tunnel metadata is installed (Willem de Bruijn)
  - some cosmetic tweaks

Tested: full suite on the final tree, tunnel included.
um part compiled only.

Michael S. Tsirkin (5):
  net: account for ingress-resolved virtio net hdr state
  um: vector: trim skbs before verifying the header
  virtio_net: parse tunnel csum_start little-endian
  net: resolve uncommon partial checksums at ingress
  net: add a sysctl to opt out of virtio net hdr checksum validation

 Documentation/admin-guide/sysctl/net.rst |  19 ++
 arch/um/drivers/vector_kern.c            |   6 +-
 arch/um/drivers/vector_transports.c      |   4 +-
 drivers/net/tap.c                        |   4 +-
 drivers/net/tun.c                        |  41 ++-
 drivers/net/virtio_net.c                 |   2 +-
 include/linux/virtio_net.h               | 319 ++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/core/dev.c                           |   7 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  50 ++++
 net/packet/af_packet.c                   |   4 +-
 12 files changed, 441 insertions(+), 17 deletions(-)

-- 
MST

