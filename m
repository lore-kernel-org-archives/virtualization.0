Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC721379C5E
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188825; cv=none; b=p6l0JG2vP+gwb1kF2agXzidUPVffQJgUugET4PLe/eVPBn+aWF1TSk1Slszy5tf0sDjL4ROkfz7FenCG1fehJUgD+qS7AiOztJzU4ul3qgt3WHL5UDYDHAeoxW3COgOnMTBT5V1x/O1qr71FfXGB/BYtIh0LmZnpLytyfewPe1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188825; c=relaxed/simple;
	bh=+kKmRSHAFbZ610bwi6FiHGuRD8TJDim0w7kTnt9xnMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nxiv2xjqnACuxUudIqXe8g0SnrsyFUPdp8HbDMca/CCwE7YKunZLKgtDt62l4ivhlUqwJHuTwGNToldHz+8t+KNbXSNps0AD8A2hKarfyIbKIO9XrmKZa/ABFH9DLPkeqg/Erpbdkwnt0LHjBnRMCNM5OzIwxfU5/86FZhFk7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIT99+uX; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIT99+uX"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaad1544b7so2037993a12.1
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 11:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188811; x=1790793611; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zqyJbHjr6LcXcdK9aE9i3DnVIewwpBEVNVy5+on1Af0=;
        b=AIT99+uXDtZB2Qj6SaPZ9ilwo8HC/upJV7Th+G0KiZD51OXp38C4r7ekMcmr8XqJ36
         zg2V2a0rexrVCvSDlqsna6fK6Fz65RHZStl7JBPsG1KulRINFTCBj8TkNz3rAkNKHwld
         boTATrI4i85+UK1yqprVYcGiptB5TrFmm9Ky/h28Y+kms1kx42dEoYypYezvU9yEX+k+
         /mw9p12j/yeR6QqIPwrhcEnEp5n0y8mQWfSAI+Ra7mI7djsl9oLtBoyzI1JgtbIeXrW4
         FjxcUJ4eDNYg6XMGRgemzQ9rn/yRswMLSaeK//dGvO/hPaKNANsLRY8816tFRhHn1BY0
         QP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188811; x=1790793611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqyJbHjr6LcXcdK9aE9i3DnVIewwpBEVNVy5+on1Af0=;
        b=u9RRhbmhAWSgnSy3isEybciTGHX9niZWEStDeheS63foR3saszBE/TTZpHTxkZpIiW
         7thG/P7ZKi6ZocNXmCoNTsCMntCOjzYKF7MPfQYosWKJBBa9rwXqiSTDafIkq0HiiVUi
         LHzMlb/Zg6vNiK7sTxNoCmVxafvyXe0DltuksK4sZdXfSfDbnWnajCphrfY0qfOXE/bx
         MFnC+uKi2NzOzICQFOGXPsA7LyprBfFM2pqXDg/eU2ktGW3QLfmRwYtnCqhVBKv+0UWx
         n8xIgle+p1EOIF84TFznb/pt72ELsIEOhIPvj+TpY5omSfNq9AWNXkODhhWJb62aNbXf
         ASFg==
X-Forwarded-Encrypted: i=1; AKwUvBzarrO2ovuHsKhUV+ESoo9UTamceOUYt+sGfggzTF6Nq4E3cEd6/iE4TjqBhnmRMMkqTBdCjN3phlLicVWc6g==@lists.linux.dev
X-Gm-Message-State: AFuF++klpK4toTuw7IDNKB0GsJVwd5Cor/heeBVRBlVAPaE0FYcWsd4U
	KS0WeRzGlotrIoz2meM/PPDHuoteHenX4Kex0gSA+HkMichCQ8TEmcb9
X-Gm-Gg: AYBFou058hyTDs3UNbVGQgL+gkQVitlqlOVZK+pMEFai8M02AIm1/NqQg1b1zixCTks
	BdKZEYLhxr94farw0PZy3T5/DLKCzHb4ZkiYyjxs6gNz6YLouodxkmgTn5Z3kzgED+oXGAMvccj
	bJzC32yBzODDtW3SgGoisUwGy077WTF1FijUipvHYXqGCDZ2GImDFxYO+ia8y8sNwnsZ4C09ikj
	21T9ab0eZN3dRWUA2gBbWRlAGPLR/6Q17i6RpXmLcAzZ5bvKeoInDHQnK4SrL7IamDqd5wpiRMF
	A7cWJGRUNXlIMtkdbZ7kuok5sPPI/SfRet6bWdzIZjbbzTEgtyaNXwQkFY5x4UMYne9fLsOWfG7
	1mCLZ3WB6cydfLxopEMjMrWTBRtw1OE2GmHjB0bxCk1RoEryn/2q6rQaEkg9KVzkQ2n+PeKi99f
	SYJ3K/oyui68wuKEgnF7iGPAkyrx0s25/IIxxpdNmPjxLuideqbCUFdhoGIx+BWSTWBIerfo8fK
	ZaBhjfB/z7mls1VCfFaztHXXJEk7lzilC683MPz1W+kXXwyDvM+mB/uPyRPuQzZkWTFJA==
X-Received: by 2002:a17:907:3cc1:b0:c26:19de:9acf with SMTP id a640c23a62f3a-c2ac2338f7cmr4037366b.39.1790188811203;
        Wed, 23 Sep 2026 11:40:11 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae33faf4sm173417566b.3.2026.09.23.11.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:40:10 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next v2 0/2] vsock: receive queue hint for io_uring
Date: Wed, 23 Sep 2026 19:40:06 +0100
Message-ID: <20260923184008.153541-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_VSOCK stream receives never fill msghdr.msg_inq. io_uring initialises the
hint to -1 and treats that as "unknown", so it cannot set
IORING_CQE_F_SOCK_NONEMPTY, and it speculatively retries a multishot receive
after every completion, including when the queue is already empty.

Patch 1 fills the hint at the common exit of __vsock_connectible_recvmsg(),
reusing vsock_stream_has_data(), the transport callback that SIOCINQ already
uses. Following tcp_inq_hint(), it reports a terminal hint of 1 once the
connection is finished, so the caller still performs the receive that
observes EOF. Patch 2 adds selftest coverage.

Numbers come from a ping-pong over vsock loopback using io_uring multishot
receive, 4 KiB messages, the queue drained between messages, with kernel
receives counted by a kprobe. The baseline is the same tree with patch 1
reverted:

  entries per delivered message   1.97 -> 1.00       (5000 messages)
  receiver CPU time, median       1.640s -> 1.587s   (-3.2%)
  receiver wall time, median      3.260s -> 3.183s   (-2.4%)

Timing is 25 runs of 50000 messages per kernel; CPU gives Mann-Whitney
p=0.006, wall time does not separate from noise (p=0.12), as expected for a
latency-bound workload.

The hint is gated to SOCK_STREAM; seqpacket is untouched. SO_INQ and SCM_INQ
are deliberately left out: they need their own per-socket state and
ancillary-message semantics, and a byte-count contract would have to account
for transports reporting less than the whole queue. That can follow.

Testing: built and run under virtme-ng on loopback, where the new cases pass
and vsock_test still passes 41 of 41 with a clean dmesg. Other transports
were reviewed but not tested. Hyper-V reports the current packet rather than
the whole queue and can return -EIO; an undercount only understates what is
readable, and a negative result reports -1, the same "unknown" value io_uring
presets.

Changes in v2:
- vsock: rename the helper to vsock_stream_inq_hint(), fold the NULL
  transport check into the finished check, drop the int cast, assign
  msg_inq directly, and document why only SOCK_STREAM reports a hint
  (Stefano)
- vsock/test: move expect_res() to util.c, add uring to the SOCK_NONEMPTY
  helper name, skip instead of failing when SIOCINQ is not supported, and
  drop the redundant final barrier of the EOF test (Stefano)
- vsock/test: queue two chunks before arming the multishot receive and
  check SOCK_NONEMPTY is set on the first completion and clear on the
  second, so the test fails without patch 1 (Bobby)
- v1: https://lore.kernel.org/netdev/20260920194710.1114748-1-devnexen@gmail.com/

David Carlier (2):
  vsock: report pending receive data to io_uring
  vsock/test: cover receive queue hints

 net/vmw_vsock/af_vsock.c               |  35 +++
 tools/testing/vsock/util.c             |   9 +
 tools/testing/vsock/util.h             |   1 +
 tools/testing/vsock/vsock_uring_test.c | 391 +++++++++++++++++++++++++
 4 files changed, 436 insertions(+)


base-commit: cea851523034d83dc61d882b1a6a3ad273480f7b
-- 
2.55.0

