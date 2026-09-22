Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AF388881
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 03:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046198; cv=none; b=SwIXtWIZ7pBIrEqWyll5kQRRFu3/pbKdraHvSFAk+azSbkOQ4zAsFchxbceOED4DI4MsvhLpbW0giYRmOxzkW5gFjbUfZT5scIdkdPL92iyM2WXe3yo5JPaZ5us+NbjPXB+nrLouxcrKoQW5Hhx5GLOEk19BGs8HnE6WrCIRWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046198; c=relaxed/simple;
	bh=7SODR36kHYK1IakVc5HOz6krTaW3m9saxbK5Vnu7M34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1f7WdRnCR1xGiwtRwqR0mE8G3e1FYGgjZyaJdf9Psql9GrkeL+ugFPwpfUwen3igTtcgrhc6mPVS0n7odNjkrFevX2kZHuDcfrxlWqkM2Vh97c9YOTyZs5A1rt+ndyOV+4puAq/L0cMzpYDR51B8XzaH6e5W0CYm13nCbHRjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clmbFpQ1; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clmbFpQ1"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e50968489so3427082d50.0
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 20:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046196; x=1790650996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=;
        b=clmbFpQ1b3oFQG+eJ27xRA5YK2+SUZ7xj57wWVNOjlLnm/txW0ZuOkkkZMPqc46ldQ
         IAofaEcLb/XnJSLMuhj2e7VKQ38ooZlBtZUbmnlKMGp2CPshsqhiA98gSsIEQx+IFMvd
         WDjPPZRPjKTKbwdvSgnDVqeHeuMncJBOth4piOMoOYy278TUyKws/o2NUnm44CEsyUGE
         gXD1KbohWlBfWISgAdvsjmSCzezz47pB0rJCt/6VJwS1ob7GJoZUUFntYjXoiUlbf2hE
         PEy6NCqi+GY62lczkgX8dqsYjwWa4pLu9Qkd3rFFkRNijja352whffImgZbVkfiB1GMj
         Jlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046196; x=1790650996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ixt/Rxi4OM6LS0sSMn+Kn0k0Yx5XJM0PK6LzpYStkGc=;
        b=T32/CFD4JGf+/ck5J/gx2FvYOQ9eyeqz/99+qGSdzIr9U6FQzqPTmCaXf+JVo4hsIo
         qZekWelXc6znkUQeRaHL0I8iHZeMxni6PiRjTIpWjPJgeQRclK+VqEbIN/dIdnKV00cE
         MugoS4qf2yf1LNvbhOhPJ4dAYeD1EeNwloiIKh6NEc9UMj64Wo2eJG3SgwGrfeZp7lX5
         IbopmphyKiqVqkc5y2Z1oBEG0dzIk+N7xA49JKOaJQz0F8rGDwfRb9KtwiSuPqWg2BKm
         ympziyfEX5xTSZ4w9Tb5IQ+CSi3Oxjvwq7XEacdiM4NAE4sHmxB/IDjBV13y5eFd0WCi
         477g==
X-Forwarded-Encrypted: i=1; AKwUvBzlruH0fDvWp/AlR+2aQJvkdLS3lF81X+M8KcAkbiXfeZq5lcfAfc53cNOLUatvVHOZNXe3jfC78u+UAj0c0g==@lists.linux.dev
X-Gm-Message-State: AFuF++n4QACKAgsYiUYy0MG02/0ut0QmI9eOr2qY1uuSviO9H0Q77a43
	31YUkIusRjhm8fIXNcrKltwOczhWZL6C9T9n3JDxwM+PFeVlSJ29DoMP
X-Gm-Gg: AYBFou3luiJfiU5ttJ54ntwA48a5Up972afAAE1RSmDfARfex+8iJbMOspB5jChTbgX
	XGg9Ehr9d4BFdCklU7XSynDM3QpSuu2fRSoHaDzZ+cXqTXDuMSJwEJGNFvSySnbOeZ211K9KwOD
	/OHnbDYtvrdeKlc3N2/sV5A0MAgLgA79I+3/2Ugg8OJD92BSK6hCqH6hpkJsnwmEgeFry8Tu/PW
	lPpjZylcH8COtP/liv2nGKnqTi3kL0C609a3o1X2/sD2/2nzj9/yXMxmw2U3pJwFrOPuJuwQsR1
	0m6uQJnvbs8n16Mi02Jr3YXX3SfirlrssAo4z1pxfwgHBIPXVtFEXy9iahfcWsgHPVKZEKZAXe5
	puwM8QSoF/iDGod01TwOlE9LYRZDRDiV5FIIToZt5MfqJX7OJJXpWdk3FPUIBqnSVQ5a88vRJO2
	UdsK8RPve3yDr76PIQCciTxCwlykhk0GuZ7Q41iRBpjhRQMtmSNIJtIBTN7HWUhPrslGZSbiA4A
	JnqqF7TtP5e4mw4ZsgiRo1zY1+ScYq8YbhYUVBeXQZRX6ITwHXa+PvoBVvJbTzmUVDStldl
X-Received: by 2002:a05:690e:1181:b0:671:70d2:527b with SMTP id 956f58d0204a3-6717fd6a661mr4352075d50.62.1790046196312;
        Mon, 21 Sep 2026 20:03:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:155:4200:2c80:2875:43a3:e345:710c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a2c1b02abdsm1471447b3.17.2026.09.21.20.03.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 20:03:15 -0700 (PDT)
From: Paulos Yibelo <habte.yibelo@gmail.com>
To: netdev@vger.kernel.org
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	razor@blackwall.org,
	idosch@nvidia.com,
	dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-um@lists.infradead.org,
	virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 0/2] net: prevent partial checksums from modifying network headers
Date: Mon, 21 Sep 2026 23:03:08 -0400
Message-ID: <20260922030310.8684-1-habte.yibelo@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A virtio-net header can supply CHECKSUM_PARTIAL metadata whose checksum
start resolves inside a network header. Software checksum completion can
then modify bytes the stack has already parsed.

Patch 1 checks the data-relative L3 origin in the virtio-net conversion
paths. Patch 2 checks the parsed header length before checksum completion
in IPv4 and IPv6 fragmentation paths.

Changes in v6 address Michael S. Tsirkin's review of v5:
- Name the Ethernet-only L3 parser accordingly.
- Derive the AF_PACKET L3 offset and protocol from the actual Ethernet
  frame, including inline VLAN tags on an ETH_P_IP raw socket.
- Use the IPv6 base-header minimum for IPv6 checksum-only packets,
  including IFF_TUN before skb->protocol is set.
- Restore Assisted-by: LLM on both patches. Patch 2's code is unchanged.

Validation: focused x86 allmodconfig and UML defconfig W=1 object builds,
strict checkpatch, and application of the exact mail series to the stated
base. No runtime regression reproducer was run.

Link: https://lore.kernel.org/netdev/20260921025341.44846-1-habte.yibelo@gmail.com/

Paulos Yibelo (2):
  net: validate virtio checksum start after network header
  ip: reject partial checksums covering network headers

 arch/um/drivers/vector_transports.c        | 13 +++-
 drivers/net/tun_vnet.h                     | 52 ++++++++++++-
 drivers/net/virtio_net.c                   | 10 ++-
 include/linux/virtio_net.h                 | 87 ++++++++++++++++++----
 net/bridge/netfilter/nf_conntrack_bridge.c | 21 ++++--
 net/ipv4/ip_output.c                       | 23 ++++--
 net/ipv6/ip6_output.c                      | 12 ++-
 net/ipv6/netfilter.c                       | 12 ++-
 net/packet/af_packet.c                     | 24 +++++-
 9 files changed, 214 insertions(+), 40 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.46.0

