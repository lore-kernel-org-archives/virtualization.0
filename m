Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7F51FCDA
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068081; cv=none; b=q4vlK6/GtMnkOwGAia01PBZGdWdTM+q6UHNDHvrrg6QukhnlirrFdE2/zhddvPjKqEeRq6YNwjMwwBE6s1fXgcP3/XRv2q5FWykaZumBcFvkZ+t0znQAbBqz1uLBPC5yaNP3mdNHE/aO8yQuCpxGCQ33hCvo+nPbOm+7W+DRS8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068081; c=relaxed/simple;
	bh=ULFAxBtXFUyYxoYoJoEfrtH9PizTTVRo0tYPLbXLjgo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eWU7DEqvnpYHO7ysvmbKM/XIOYKyO1mUg9cnYxEE1+kZ1TP1ZliL4FZqfCTIn0HewbeLj8LZ2/wYfClQo7DVKKO86DmEDwn8YqhYaCDKSvUtmw5AKXYsHYpe64GGEU5EMOgi1pRHS9lfxDvAb2xGVEnl7klmsBdQyIZ0ilit7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIpn2tBr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIpn2tBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792068079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6+E5kAELX03rlqVLLUN+DuDipBZlXtEdhg/J6E2iFuo=;
	b=HIpn2tBrAY95ypcZVMIKk268vqtjZ4qJI8xEsLnd6ayxF6mWpENTS/8foKaXnm1E+/4m13
	RAztzDnJWEelQXgT4twAyhP+AIaeLylBn99AuSwhn1dNjxG12aFOWulkRb6Zfkm6Bf+Wo4
	aTG4Lg0KOsMVSm4MIblHTDOw3gXkusM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-6RV30dUNNeCKCadeLf8pWQ-1; Thu, 15 Oct 2026 12:41:18 +0000
X-MC-Unique: 6RV30dUNNeCKCadeLf8pWQ-1
X-Mimecast-MFC-AGG-ID: 6RV30dUNNeCKCadeLf8pWQ_1792068077
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49cdc4080ddso40706135e9.1
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 05:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068077; x=1792672877;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+E5kAELX03rlqVLLUN+DuDipBZlXtEdhg/J6E2iFuo=;
        b=mD39RbxTOTXvQPLWebx98O97Z/+QfiQb96wnBaEAnqBIs+l9AUsr+lT6Mr5zOi6EpO
         35bdaFKkL7s9xZxsCST9QnFR4Jfb08KZl/a5Zt4hYFxlWgT1JT2rHDbz8tqxcUBV8Qre
         DZnuH8OVmo0j03Td1vARW5XLlXRj4DDBnplhTnp0Yq1qf7a1dgGg97hRVaUfYBM60Drf
         40s5eZJW+lLUQMOnJAr2w1ojSP9v51zXwA+AhFbOspNSGvVDRGc6nLQBMO4Da15GXoTE
         87bavNiHxKXL5qsGBJW9assYAl/NucskLFC7XHgqrUapX6Smk/2wPkGsJk3sSuMpfM3/
         9SfA==
X-Forwarded-Encrypted: i=1; AKwUvByPBQURGHFSmHxvSrLZ2eLgNT0QJ45cBQWlO0dV/FYAlASMFn8zI2AwXupjp9nDNQTB9N07GCxpV+UkJP4VDw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIDa6+U1gqPgN4xh9pFITH0RyftNVomLBoATfsZvENcYs048jXo
	DhJ1Jdrsagh/lA+Y6mYeCF6EvSV5b/QgnrMlWnqMS0CA9eW9YQ8NBid3XeBJ0q73Yl5AMSqNfU2
	5CzsMExe6Cybn/bQ2fG0eoDt9HuMOIcT47x78PCmyornDNQEtchjjrlTklTtbpiGRMjAc
X-Gm-Gg: AYBFou2UpxcqivhS1IvxO/q02Fj64+RpozY2t6qBG9FCaUwPJRX+8R3SiIVeu9F0ipo
	7QDhaoNmv8sMb9aqOvrECXaIc6dyhO5QvyBARQx9G9u8FFMvzJya4hG1NRDVB1TTCyFlsagVDS2
	mTk7GT7aKuWFTa1Sm1taSnYZNgeBUYcpkVJf+JasFruXoEMqE/yEzqNBmzGxMXoRWPRCD9NiU8S
	knqTYvnz0q0C5hSfs8vxvrLz7b6GTjdFWEKR2Nz8qKRhTlcsjWz7Dti0Ks8WqvYm3cyXAXbHsu6
	o9Gn2p6naDC6ndMc9oc1hzOBKpgvptGO+25oCTHp6ag+6azxB/EoCTKDHNBOCGslCeNz0Q==
X-Received: by 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a18e447d8bmr371386935e9.2.1792068076536;
        Thu, 15 Oct 2026 05:41:16 -0700 (PDT)
X-Received: by 2002:a05:600c:a011:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4a18e447d8bmr371386275e9.2.1792068075878;
        Thu, 15 Oct 2026 05:41:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdc036a4sm78912855e9.11.2026.10.15.05.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:41:15 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:41:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>
Subject: [PATCH net-next v2 0/7] more virtio-net csum hardening
Message-ID: <cover.1792067836.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dk70ib8E7EgZqui0ZBYsabABLAQwusw_2LnlAQCOmXs_1792068077
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


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
  net: account for ingress-resolved virtio net hdr state
	- accounting, not the fix itself, dependency of the next one
  net: resolve uncommon partial checksums at ingress
	- fix itself
  net: add a sysctl to opt out of virtio net hdr checksum validation
	- reducing risk of the fix by adding a sysctl to disable it
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


Michael S. Tsirkin (7):
  net: account for ingress-resolved virtio net hdr state
  um: vector: honor virtio net hdr conversion failures
  um: vector: trim skbs before verifying the header
  net: resolve uncommon partial checksums at ingress
  net: add a sysctl to opt out of virtio net hdr checksum validation
  net: add ip4_parse()
  virtio_net: cleanup protocol calculation

 Documentation/admin-guide/sysctl/net.rst |  15 ++
 arch/um/drivers/vector_kern.c            |   6 +-
 arch/um/drivers/vector_transports.c      |   4 +-
 drivers/net/tap.c                        |   4 +-
 drivers/net/tun.c                        |  41 +++-
 drivers/net/virtio_net.c                 |   2 +-
 include/linux/ip.h                       |  24 +++
 include/linux/virtio_net.h               | 249 ++++++++++++++++++++++-
 include/net/netns/core.h                 |   1 +
 net/bridge/br_netfilter_hooks.c          |  15 +-
 net/core/dev.c                           |   6 +
 net/core/net_namespace.c                 |   1 +
 net/core/sysctl_net_core.c               |  54 +++++
 net/ipv4/ip_input.c                      |  13 +-
 net/ipv4/netfilter/nf_reject_ipv4.c      |  13 +-
 net/packet/af_packet.c                   |   4 +-
 16 files changed, 404 insertions(+), 48 deletions(-)

-- 
MST

