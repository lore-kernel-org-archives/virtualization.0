Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741909;
	b=3E60NyKjqKQwMSC+hHmdP35r6Iu+YoCeBKPmXVVDHZ1njQ6wlxGYnsVmqpA4trLMuzuR
	 XNuDWSzHJpYgqr+dE/MRt10ygNc8yJwfzQkZI8mCo3lK7hnWMR4pVLTElwKYLmFjEv/5t
	 RITAFqmGnhYxoTFokqi/OfZcVRu66YE5Fh+mn7KchN7M+ZL65923lTt0uxGpGy61pkPt7
	 upLm80XFsujd8WnT2UEYEcD2FeFG3pHQE4aePlPyQfHq51V3kA7IXEXbRcuY7ZJ7DDKtV
	 zgAZr7loSHqBS+hUvLvrlWv685CksZ0CttvgfqSKcL6ak9HaG+VZwQfSsUBhpv/7g5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741909;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iUsPR0OCp370MJMknYypVXmwmCS7YSHmFpaJb7wjCuo=;
	b=LdoWl3lT/T1PG6RHtQB/M+keAytuaNHGB2hgj4/AeODF6wTnocUDTIgO9itd+XLCy9AK
	 2EDH5KEUdtYavB5CYhW/yKfG3EmW1lhiKrEbpfwOazGqOWCcDhNJOAset/qtDdysOhNxD
	 YzbdR3MEgjLP0wJpwnsp46cvEAXVpwrVi9cWIEw60ETymlPSvs3ScS/pEKRez3augpGAB
	 RFl+YPZ4+Yn+tp4U23qEk4OJpucuuIetNbmDFJP77YcLR/XsHYMFvYnD62JWeshDB11by
	 po8miK0tCmUbxp36AyAPWU/4izUuOY4fuGquqG1maGOS6PTLe5AIz5zRs1lwz3DsKRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="lQZg9z/V";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A47606A322
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 07:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A47606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lQZg9z/V
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9ae391a05so3483875ad.1
        for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741908; x=1793346708; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUsPR0OCp370MJMknYypVXmwmCS7YSHmFpaJb7wjCuo=;
        b=lQZg9z/VWsZ7sCQKZvuoNTWJYXfrh28L62mCtmUkp0nFxZgODe+fpJJGsdHUSA9Vwx
         ABeGQvliTI/7qgB8wQ/Qv/4DLAskhC1vhkJEyifkFhIRn7OImktBHvxIuFM/7EuW4uWa
         HdbVVn6TPdlI+Co5WNwttsTEc1AumxlTyBPqPbmsE6six9JnlS4qLDf6mYVrGstw3gs+
         FThP2B0+652ebLNclHU/Wm5VZL+WtkCBarfSA/KQVnc2AAC3OwTBVi/74ulNUyIASI32
         4M7xB7o1VpcikVvrvoDK5gWnTtg+WC9bVwAGvGTaxeOEuLFJ8Ar7h54u9GKQ2Ja+jpyp
         zsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741908; x=1793346708;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iUsPR0OCp370MJMknYypVXmwmCS7YSHmFpaJb7wjCuo=;
        b=F7Xx16KzKQNliKXCJtdP5MPebrw1BbVj/0hDm9umAnroM14cdg/B8o0dHjfa/oTPcI
         SXby0l9BvhDaaKpizcbrpnpiKsgCWQR9wmDpCYIMRasGuqiDbnmVAglCDgDY94qhHGQ+
         xhJqmXkVz1sVJV15rPSTADab9a0aAjIaPQEHngUJ9TsouBmdohn69AMA55vdWgpPW8Ge
         QguWg042I93f93r3wkZvhvckqoIFI6tSjdjmUMh5KS/YJ14AI3kuHM6avLb0qrLjciRo
         4jxJNlkqRNpZ4+ATiulsUeqFcmLsiaEbD34iLuC7xRCKBstJ/6JlLy/famrkrTMpY1q3
         fx2g==
X-Forwarded-Encrypted: i=1; AKwUvBx1v+qnvEzvClPhDMWhzOaxGYcCv2Oof3XXuo3H5Tl1jU8F6MmFGyudwi42DbWKd7UTFSlO95imK289w+tyjg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL8mq9F9a2F//LHYuAzGLhxLdg/o53FyQ8lh8gOK79U3C0afwcz
	nv78CTGyvPZq0LenKLSdZ+pNHymyv/RwECp1O1yEhKZmHGUrtBgrGbzA
X-Gm-Gg: AYBFou0JzA0o2Biid3piS/B4VJFanRodPDUAR7Al6xDPc6an6OEpOsFPZmz2aIMrraG
	BCC/ohNSM2+U040TUFv16EMSGmGh5i6qhx3vU1NpEnDWfsXZvZ+mhzoSwZwOJKNTND8au85WSkE
	gdqUxeKQ1nHuNn3QU/qowK+PV6bIGe7LRT48qgtkNS/Xg607zfLR/nB4YECJTqrG5/x2xiGANVA
	Mt15WEcU5FbhIFYGLPPo1Bxtd+4OXou9y5M/I7q1T7Cn9K24JSBDpwPecxj4pJiLA/GfzSLja0J
	lNkOTiofJLn8/dLkyTTViB2CZkErc6o3W7p4mmB3hCYfUiCg7Zv/1H0WdgQQVfHwosdGPql7AYz
	2a+brOaDQgJ9PGG/V1zfCpp9lrDoJgLI6uumZmKKwOFq35AelqtYFxZQzXPsbq67r1RQz/w/4xS
	O7lN/ZRs2X46uQqSfP/3ZJtHTKOct1PzR9ANSZU73HRYzpiJ4BwT6jAvBWawTyNKbYGtwg8P72b
	xkxlg+nmHnjBENu1Rg7TYTi0DeycT0/jU/gFKn+h7CkguE6l6wp09WhVA==
X-Received: by 2002:a17:902:c947:b0:2e5:debe:cb4b with SMTP id d9443c01a7336-2ea627e3aa7mr31156235ad.10.1792741907784;
        Fri, 23 Oct 2026 00:51:47 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea7b368c90sm7208265ad.29.2026.10.23.00.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:51:47 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: netdev@vger.kernel.org
Cc: stefanha@redhat.com,
	sgarzare@redhat.com,
	bobbyeshleman@meta.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 0/5] vsock/virtio: reduce RX per-packet socket overhead
Date: Fri, 23 Oct 2026 15:51:35 +0800
Message-Id: <20261023075140.9613-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series reduces per-packet socket overhead in the virtio-vsock RX
worker.

Patch 1: separate socket lookup from locked packet processing.

Patch 2: factor out the RX skb metadata-budget check.

Patch 3: keep one socket lock across a bounded run of established
STREAM/RW packets for the same native socket, and reuse the locked socket
for later same-flow packets.

Patch 4: coalesce default write-space notifications while that
lock is held.

Patch 5: defer the default readable callback until after the batch
unlocks.

Performance:

Tested on a single-stream vsock connection (one Guest receiver thread on
CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state, with 16
balanced AB/BA pairs per payload for each baseline/patchset comparison).
The host uses vhost-vsock.

For throughput, vsock_perf runs on the host as the
sender, with a custom single-threaded Guest receiver pinned to Guest CPU0
using blocking recv(). The fixed-64K table uses a 64K buffer; the matched
table uses the sender's request size. The virtio-vsock IRQ/RX worker is
pinned to Guest CPU1. To normalize run times across payloads into a
bounded, deterministic window and avoid long runs being skewed by host
background noise or virtualization scheduling jitter, transfer sizes scale
proportionally with the request size (64B/64M, 256B/256M, etc.), capped at
2G for 4K–64K. The custom receiver keeps the recv() size and count
explicit; vsock_perf's receiver uses poll()+read().

Latency uses a custom user-space vsock ping-pong tool.

The measurements below were collected for the RX batching series.

This benchmark does not run vsock_perf on both ends. Instead, it uses
vsock_perf as the sender on the host (vhost-vsock) side and a custom
blocking recv() program without poll() on the Guest side, with the receiver
thread pinned to Guest CPU0 (and the virtio-vsock RX worker pinned to Guest
CPU1). Plain blocking recv() combined with strict core pinning gives
audit-level determinism for tracing a single-threaded TID.

With all patches applied:

End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):

  payload  baseline RX  PATCH RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B        0.1290       0.2489    +92.91% [+89.31%, +96.58%]
  256B       0.5780       0.9727    +68.29% [+66.14%, +70.48%]
  512B       1.1688       1.8316    +56.70% [+53.85%, +59.61%]
  1K         2.3059       3.3377    +44.75% [+43.39%, +46.12%]
  4K         3.8787       5.7310    +47.76% [+45.20%, +50.36%]
  8K         4.5983       5.4575    +18.68% [+16.42%, +20.99%]
  16K        5.0806       5.5615     +9.47% [ +8.05%, +10.90%]
  64K        5.4842       5.6423     +2.88% [ +1.13%,  +4.67%]

Fixed-syscall stress test (receiver recv() size = sender write size;
Gbit/s):

  payload baseline PATCH    throughput change (95% CI)    recv()
          RX       RX                                     (base/patch)
          (Gbit/s) (Gbit/s)
  64B      0.1384   0.2532   +82.99% [+74.19%, +92.24%]       1048577/1048577
  256B     0.4042   0.8983  +122.25% [+113.06%, +131.85%]    1048577/1048577
  512B     0.8056   1.6035   +99.05% [+89.34%, +109.26%]      1048577/1048577
  1K       1.6030   2.7158   +69.42% [+63.22%, +75.85%]       1048577/1048577
  4K       3.0194   4.9586   +64.22% [+58.43%, +70.23%]       536799/525225
  8K       3.8316   5.1255   +33.77% [+31.00%, +36.59%]       274864/263013
  16K      4.5702   5.3808   +17.74% [+14.87%, +20.67%]       144958/131332
  64K      5.4736   5.7118    +4.35% [ +2.79%,  +5.94%]        49039/32938

Request-response latency (Ping-Pong RTT, 10,000 requests):

  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
  64B      224.148                  224.151              +0.00%
                                                        [-2.26%, +2.32%]
  256B     222.037                  224.499              +1.11%
                                                        [-1.66%, +3.95%]
  4K       225.982                  227.026              +0.46%
                                                        [-1.15%, +2.10%]

Guest CPU1 aggregate cycles per received byte (fixed 64K receiver, with perf):

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B        65.282    57.843  -11.40% [-13.77%, -8.95%]
  256B       14.710    13.813   -6.10% [ -7.89%, -4.28%]
  512B        7.709     7.188   -6.75% [ -8.79%, -4.66%]
  1K          4.075     3.862   -5.23% [ -6.80%, -3.63%]
  4K          2.034     1.887   -7.21% [ -8.67%, -5.72%]
  8K          1.664     1.568   -5.78% [ -7.83%, -3.69%]
  16K         1.450     1.385   -4.48% [ -6.08%, -2.86%]
  64K         1.338     1.317   -1.51% [ -3.21%, +0.22%]

P1-P3 contribution:

  payload  baseline RX  PATCH RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B        0.1285       0.2462    +91.59% [+79.74%, +104.22%]
  256B       0.5909       0.9666    +63.59% [+61.03%, +66.19%]
  512B       1.1817       1.8350    +55.29% [+46.76%, +64.32%]
  1K         2.3252       3.3600    +44.50% [+38.93%, +50.30%]
  4K         3.8436       5.5661    +44.82% [+40.30%, +49.47%]
  8K         4.6609       5.4115    +16.10% [ +8.91%, +23.77%]
  16K        5.1196       5.6399    +10.16% [ +4.07%, +16.61%]
  64K        5.6095       5.7062     +1.72% [-3.19%, +6.89%]

Fixed-syscall stress test (receiver recv() size = sender write size;
no perf; Gbit/s):

  payload baseline PATCH    throughput change (95% CI)    recv()
          RX       RX                                     (base/patch)
          (Gbit/s) (Gbit/s)
  64B      0.1446   0.2540   +75.71% [+63.67%, +88.62%]       1048577/1048577
  256B     0.4211   0.9061  +115.18% [+72.13%, +169.00%]     1048577/1048577
  512B     0.7980   1.6112  +101.90% [+95.30%, +108.72%]     1048577/1048577
  1K       1.4965   2.6986   +80.33% [+68.93%, +92.49%]       1048577/1048577
  4K       2.9384   4.8590   +65.36% [+60.17%, +70.72%]       539544/524982
  8K       3.8170   5.1887   +35.94% [+27.66%, +44.75%]       274857/262991
  16K      4.6856   5.5996   +19.51% [+15.36%, +23.81%]       147518/131351
  64K      5.5182   5.8800    +6.56% [-0.83%, +14.49%]        48492/32910

Guest CPU1 aggregate cycles per received byte (fixed 64K receiver, with perf):

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B        66.728    61.220  -8.25% [-18.99%, +3.91%]
  256B       14.363    14.515  +1.06% [ -4.22%, +6.64%]
  512B        7.792     7.578  -2.74% [ -6.55%, +1.23%]
  1K          3.988     4.032  +1.09% [ -1.64%, +3.88%]
  4K          2.063     1.973  -4.38% [ -8.23%, -0.37%]
  8K          1.702     1.667  -2.06% [ -7.99%, +4.25%]
  16K         1.473     1.475  +0.17% [ -5.06%, +5.68%]
  64K         1.385     1.358  -1.96% [-10.61%, +7.53%]

P4-P5 contribution (combined):

End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):

  payload  P1-P3 RX  P1-P5 RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B        0.2449       0.2463    +0.55% [-3.86%, +5.17%]
  256B       0.9649       0.9931    +2.93% [+0.83%, +5.07%]
  512B       1.8205       1.8260    +0.30% [-4.27%, +5.10%]
  1K         3.3431       3.3420    -0.03% [-2.15%, +2.12%]
  4K         5.6541       5.8428    +3.34% [+1.10%, +5.63%]
  8K         5.4280       5.3364    -1.69% [-15.55%, +14.46%]
  16K        5.5935       5.6701    +1.37% [-1.41%, +4.23%]
  64K        5.6917       5.8351    +2.52% [-0.20%, +5.31%]

Fixed-syscall stress test (receiver recv() size = sender write size;
Gbit/s):

  payload P1-P3 P1-P5    throughput change (95% CI)    recv()
          RX       RX                                     (P1-P3/P1-P5)
          (Gbit/s) (Gbit/s)
  64B      0.2553   0.2575   +0.87% [-3.68%, +5.63%]          1048577/1048577
  256B     0.9069   0.9183   +1.26% [-3.96%, +6.76%]          1048577/1048577
  512B     1.6048   1.6459   +2.56% [+0.98%, +4.18%]          1048577/1048577
  1K       2.6939   2.7357   +1.55% [-1.35%, +4.54%]          1048577/1048577
  4K       4.9168   4.9678   +1.04% [-1.84%, +4.00%]          524965/525283
  8K       5.1476   5.2005   +1.03% [-4.02%, +6.34%]          262926/263156
  16K      5.5964   5.6609   +1.15% [-2.86%, +5.33%]          131311/131475
  64K      5.9439   5.9073   -0.62% [-3.00%, +1.83%]          32875/32937

Guest CPU1 aggregate cycles per received byte (fixed 64K receiver, with perf):

  payload     P1-P3     P1-P5  change (95% CI)
  64B        60.281    58.258  -3.36% [-8.74%, +2.35%]
  256B       14.242    13.648  -4.17% [-9.81%, +1.82%]
  512B        7.547     7.211  -4.45% [-9.73%, +1.13%]
  1K          3.987     3.853  -3.35% [-8.52%, +2.12%]
  4K          1.983     1.880  -5.17% [-7.97%, -2.27%]
  8K          1.665     1.620  -2.75% [-9.03%, +3.96%]
  16K         1.409     1.346  -4.52% [-10.94%, +2.37%]
  64K         1.322     1.281  -3.11% [-6.49%, +0.38%]

---
This rerun used a stable host with a single Guest running and no background
workload. The baseline throughput is higher and more stable than in v4, and
the previous anomalous 4K throughput spike was not reproduced, confirming it
was an artifact of host-side scheduling jitter. Consequently, while the
absolute throughput numbers differ due to the cleaner host environment, the
relative CPU cycle savings and syscall reductions remain consistent and
robust.

v5:
  - split the former batching patch into a metadata-budget helper (patch 2)
    and the batching policy itself (patch 3)
  - retain write-space coalescing and deferred data-ready handling as
    separate patches (patches 4 and 5)
  - document why a connected lookup type mismatch returns to the regular
    receive path, which sends the reset
  - restore reverse-Christmas-tree declaration order in the batch helpers
  - add the requested cap rationale, guest-virtio-only scope explanation,
    and cumulative performance results to patch 3
  - add cumulative full-series performance results to patch 5 and identify
    the P4/P5 result as a combined measurement
  - use AF_VSOCK helpers for native callback access and save native
    callbacks before socket publication
  - serialize callback/protocol/psock eligibility checks with
    sk_callback_lock at every notification batch boundary
  - make the callback timing dependency explicit: patch 4 retains the
    under-lock context and patch 5 moves both notification types after
    release_sock()
  - share the receive low-watermark predicate between the ordinary and
    deferred data-ready paths
  - clarify the caller-provided network namespace and locking contract in
    the preparatory lookup split
v4:
  - use only the connected socket lookup for batch admission and return
    misses to the normal receive path
  - read packet-specific addresses from the skb in the locked receive
    helper and use the matched socket namespace for reset replies
  - remove the extra address and network namespace arguments from the
    locked receive helper
v3:
  - restrict RX batching to sockets using the original protocol and
    data-ready/write-space callbacks
  - exclude sockets carrying the psock marker published before sockmap
    protocol/callback replacement, and recheck it at each packet boundary
  - preserve existing sockmap update return values; an attach racing a
    native batch makes the next packet end the batch without queued-skb
    handoff
  - remove a leftover blank line after an opening brace
  - remove callback handoff work and attach/detach kicks, preserving the
    existing per-packet behavior for sockmap and other non-native sockets
  - avoid making this series drain queued or partially consumed skbs when a
    socket is added to or removed from a sockmap
  - clarify that Patch 1 prepares for batching and intends no functional
    change
  - inline address decoding and receive tracing, simplify the socket lookup
    helper, and pass locked receive arguments directly
  - fold same-flow lookup reuse into Patch 2 and match packets against the
    locked socket state, reducing the series from five patches to four
v2:
  - stop a batch after it consumes the last skb metadata slot, sharing the
    admission predicate with virtio_transport_inc_rx_pkt()
  - move replacement-callback handoff into vsock, process queued skbs one
    at a time, and trigger the handoff from vsock_bpf_update_proto() on
    attach and detach
  - reduce the packet-context diff in the locked receive helper
  - keep RX batch counters in the batch state and reset them in the finish
    path
  - use the vsock/virtio subject prefix and add the requested measurements
v1: https://lore.kernel.org/virtualization/20261002074551.318789-1-physicalmtea@gmail.com/

Jia Jia (5):
  vsock/virtio: split socket lookup from locked RX processing
  vsock/virtio: factor RX skb metadata budget check
  vsock/virtio: amortize RX socket locking for stream packets
  vsock/virtio: coalesce native RX write-space notifications
  vsock/virtio: defer native RX readiness notifications until batch
    unlock

 include/linux/virtio_vsock.h            |  26 ++
 include/net/af_vsock.h                  |  11 +
 net/vmw_vsock/af_vsock.c                |  45 ++-
 net/vmw_vsock/virtio_transport.c        |   7 +-
 net/vmw_vsock/virtio_transport_common.c | 440 +++++++++++++++++++++---
 5 files changed, 471 insertions(+), 58 deletions(-)


base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
-- 
2.34.1
