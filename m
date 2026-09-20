Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84CF475337
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933637; cv=none; b=Ipu23Rcu7xlJJfo5lK81RoxpOBpCw8PSSoDFucVy8/zJkE43EaTToVICMA6IbinFjUV7vgaVc5W/XmaZds9MPD2mign3siKlnk6b+oyEK167tnQBWpYpfgTN4DFlEN+3kaxlUsv7WzSfhZm41DTtnXrQj0hl5fxufjgcI17ouwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933637; c=relaxed/simple;
	bh=k//2B9OVyNb3LfKfZMQ5Ujz7TjjuUTfaf0JY99BJpE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHTGMM7iB1S2grHH2xeLeh3jLzXf5Bedm0bAYbqOvpAiHOYLUDkVXVeeEOTb5+lHgxBvMkxaii6uR4DVBzyILrkIzZnIRihtFlAWwV4s/LjMaDrTrw9lE7PVAaGr5o+MAvDH7+oyPg7Qn3Xa3132kHE4ecyJbcRGwe7A1uDQvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZrmPJmF; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZrmPJmF"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9ba73bee8so1674445a12.0
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933634; x=1790538434; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6GiF+RaRfkQVR72zMKUjo/mKJQNiAbemXLgy1Bp7FnY=;
        b=YZrmPJmFUrVunbE2L7Qoi2OGDhGzbGVmGOZ8yp7+CyUCVH8xJsPKunLvL8w/9XLnHv
         Xlr+iUVtNV5uSQ+vus0utBYUpZnfK/Pwk9OC0SlzKe1e6nqaYDkRPDwQpAEP37d6X0lm
         amT2zkoSlC14Ul244hGGybDNUmoZFeX0Lrhwf7hnrKMzT9hD9eDuPVtoAiVdyUGotLLS
         7bQtU7fHxjVh8zp+/j6MhL1hUYgfyIiLxuY8s3ZgS+ZpRfRpXV/RbduwMyA7/dUJRlkZ
         laS66PZdqaGsRxtBJQM5yB7q/FF2m4O5cnUfo0RJFnDviEKeOrKKQCJ5HmSQeqJjXjvC
         +7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933634; x=1790538434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6GiF+RaRfkQVR72zMKUjo/mKJQNiAbemXLgy1Bp7FnY=;
        b=iqtZKmB7Rr7Y6BR1P6Ymm0aHSir7JMGIKoRS9gWOYe6Icl6M8nIC0/AmPLQAOVnK+5
         Wbp2BInIvoB4IR3AzIdrC04zSTuS5hfSeH23u+JJdYX0OWwg7s3H6GwEpiy5IV+YKMBO
         1KDdOmY7jGpsUTzdbMO9ueIJneMbUXY7/g0+Bw8AJNhnKoRmyz4l3qj9LRty+cVwC3An
         FNx/JI9XoZTA9aUz0S24lNiJuFn4s9FVaCfmg+494HaHarmsR6rRv6Jy5P72d9red9Zp
         sGy9OIsqyVfT3Ka6HDqgZzk6GT/P+DSMq8wFjWvMLuo2EGXljBpmNO3/jOmGwXApcdtn
         +HVw==
X-Forwarded-Encrypted: i=1; AKwUvBx8T9QEaUa5trT5pqhSdO8locIZK4CoYe6E8/P64Ps7SWSHc3MBEmjVnnDy9wQLlBzkCKRTO0wfUD18mc7adQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k3qe4lpSrZ9p+F+FuEZCnJdvlvhiAsfHWoDR3iRlHxoErIggt3
	aIRldJPlh1oTRhMFXw7PwdPzURsnjV7HF/csi1cxCeQvCGjqjRN3/8uo
X-Gm-Gg: AYBFou3cACA9cZNG3hTzipKelw4TBjYQ9jMhP8mvqyQdD8M9UxypKGR5y7acGN7HpK5
	VQpXPRvpzIA6e2LLPpyQIP4PgtEXC7syMlpWZ/olp7QaVB0M5vui7vNH0iJmpcedIDvPHV9b6dz
	SrvbEkAfz1z7bCw3DHaFgg2V17nESNcNyE8S2uXHwH8tDeU6Xjeljlj7irXTKTwnsF56xl2Bz+5
	OiOIoPYNfCqozSUPreGaO2aE8cNzY6WJ9TpwITpT2mMUIPP/TuOfWPhZMNxSjVjVGpLrkQkPlWZ
	Sk/dib9LMTOfeRhcFC0y2k688kBH1U8/M/47xBOeaUzJtCwC1D8O+MjVqbSvBVHGAgxoY0NzwAt
	FAUeJbaao7nL5NbLHOY02CszWuqtLtJvj7oPXXYeg0R28aVysZZP9fsFAW1kIJTM2k2AhHa+GyD
	MShbEeq5qSTKvo51iKe3QCfCTKueR75FGDtbNA+ZtL25QKihO1FNbQoZYR540I9olJFLMvcHpQL
	grUvbNYcR3Gnv3VnLNyUISvAh2tkuY0pKUMQaNgA6mJ5JsgN+YKMnT6KWE=
X-Received: by 2002:a17:907:9616:b0:c29:d1b8:6c4b with SMTP id a640c23a62f3a-c2a16401446mr770255366b.4.1789933633593;
        Sun, 20 Sep 2026 12:47:13 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a358ff8edsm211768466b.61.2026.09.20.12.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:47:13 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 0/2] vsock: receive queue hint for io_uring
Date: Sun, 20 Sep 2026 20:47:08 +0100
Message-ID: <20260920194710.1114748-1-devnexen@gmail.com>
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
readable, and a negative result leaves the caller's hint untouched.

David Carlier (2):
  vsock: report pending receive data to io_uring
  vsock/test: cover receive queue hints

 net/vmw_vsock/af_vsock.c               |  39 +++
 tools/testing/vsock/vsock_uring_test.c | 367 +++++++++++++++++++++++++
 2 files changed, 406 insertions(+)


base-commit: cea851523034d83dc61d882b1a6a3ad273480f7b
-- 
2.55.0

