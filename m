Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B74F68C3
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979020; cv=none; b=YY7rZ2o+ajyr6TL5l8AAQkTzw2jPVtLEyv25hnTVL34K8lds2zMp4ZgtgkixWgNK1AeajSF97ojjCw47q43M88V43Q/esIiiGN3X/B1jmXKiBGq8gl48zwagxymawc8WZsgwJwBC9cxMXjKypRTDS33ZxFJBk5rfNiqGJcP5QB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979020; c=relaxed/simple;
	bh=Kmj3gvNqcRWiUzi3p2e9onO7+W4cGn1ZTReiUZtg+1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CZYDX/zmCp5zT/x6dIQMw6mtCRudgmY7P5g2dNdpv4iUrwP3aXhR4W+RF27k1s6QeJyQQVWR1WdQclbo8qSCZRVGhcsRof2Erte/uT4wrsOVtlwaR99Q++hpsGLKpKIPJj0d3BwA2qMOEN8YfwQpKGMVXe8M5dec8sJqhjgEW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtOvdwS6; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtOvdwS6"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc7cc8aafe6so1604761a12.3
        for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791979015; x=1792583815; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rr15BCmVfnFuCQIk5ywGtZF7ygFb9rIIxjBp0T94jf8=;
        b=ZtOvdwS6sX6I5JdtaHUp7uoQQDjkWPlaAlDL2uoEXlmulsd9D4iyT2rnlP420nB2Yv
         HBXh6veeoqBFk8TT5r7H40HgfagJxAxXKC9mxUnd6qo7RZg8reDBgIqXY3U5Jk+yyNgC
         T2QMGD7gRwzN0+tUUMGZewvkebDEQL0YL8euhDbne0qEtQ+Kppo4Xw8wrbpXFoCJky9F
         vr8pmBuRm5BYpVogA0jmRSaO81UOsL2edwWtuVBEGqzR34WIDHaKsmlSqrkfegLbhTSv
         gSaoWk4s8VjPgYBY5iP1b7a30xfT2llGKiR6bjlcDOqIO8B8hFlQKlXHTvgvazdY7lDT
         muNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791979015; x=1792583815;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rr15BCmVfnFuCQIk5ywGtZF7ygFb9rIIxjBp0T94jf8=;
        b=0lgQfdENpZmnQ9Fwxfi/sWEusjAEcFJcAlGYfC4uq6D+5dH81g6YFMZkz62NKniteP
         U+3zvUPJtkyfMVUh87IeJ10JhTiO0EYq9vlazOdUT5yOes2mwI8bXC+gr7vHFQO2JJZP
         kRlpI0LKr/Tbc6VnVlnU9jljfvMdc1hqdeO0IKuSphNrk1qJ1OLAYswfd3jkX6EtmExS
         FjDmpbGCqCQD8IFP+zWvm2joDOqVCzmWvSoR0vBIOQdO5+boQ5Joa2+bRV/5QGFT2/Rl
         iU+7LWRT/YFquEyjh7/ewXgDhdr+Pru9iMcgpxmTwvMsIhe+ZmNBm822j/4gR9Uo+5td
         CvXw==
X-Forwarded-Encrypted: i=1; AKwUvBzdZPnxtAqPe4J1MvAoIbWmqjtqOjehOZxb5Vvashw2E8Zc6D3OnPwT2+Ib6dVqHrIgYGmu+PPkaR3S4ru5kw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJXNYlAkCi6ZWsGcnjRxGLdj24Pb8lMSBsCxbvH1pVFHeV2VydW
	1Ymz016Xj+ukpVV3uN2sOZ/oL2wlGKncvlZ2Ap5KesMDlIvhH8k2YzsJ
X-Gm-Gg: AYBFou090LLfs+MOtxm7/uv0xQOGwTWnbCpJvMaWfgIkwf4NA1LEICVDpswI0SZTcU/
	6glh6OfLq969c/HlQWnlxCL4kZlX6kRXkShgPbFsakwhDB9rpXCWYCL1NIAobqiKyZE2Dyw+el1
	nQGDO8i5tYXoNZQz4D7cO1DV93oPaGd7M5XZCIdn5W03T3OWb9JGXwlN+BQ4KGpH6B7oJi/HNop
	yNmkJpbdvj0Dy1810zZOZPnTFHEKATER6D/gKEOEU8My0DTUdtzGQPAJiUzcu8AIVnpKJDlTPiw
	e8F4VffZNlaOlpT2YKTsuFsr01wfrp06ESQet9tzYdikmmzHgBoV4mNAlJLufvF5gblJsds1/Gi
	Pcx91fadWhzqibH0RA8g0OBs3F8OQptVY77KdAtBK7Ok3yEVHdwjIP3iz1cFEZEKV7YIGGR1Jjy
	Q3NK9tVoRpoPdk2hwm2OsodxQcscbQYKQ3XYh8FwsQcgkQ6u8PA1p4ke1vo1186cILM0xRkw==
X-Received: by 2002:a17:90b:2d06:b0:3a4:b8dd:1447 with SMTP id 98e67ed59e1d1-3ab3ac9fb08mr11499072a91.34.1791979015001;
        Wed, 14 Oct 2026 04:56:55 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24b74csm4795691a91.7.2026.10.14.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:56:54 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@gmail.com
Subject: [PATCH net-next v4 0/4] vsock/virtio: reduce RX per-packet socket overhead
Date: Wed, 14 Oct 2026 19:56:36 +0800
Message-Id: <20261014115640.184286-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series reduces per-packet socket overhead in the virtio-vsock RX
worker.

Patch 1: separate socket lookup from locked packet processing.

Patch 2: keep one socket lock across a bounded run of established
STREAM/RW packets for the same native socket, and reuse the locked socket
for later same-flow packets.

Patch 3: coalesce default write-space notifications while that
lock is held.

Patch 4: defer the default readable callback until after the batch
unlocks.

Performance:

Tested on a single-stream vsock connection (one Guest receiver thread on
CPU0, virtio-vsock IRQ on Guest CPU1, fresh QEMU Guest per state, 16
balanced AB/BA pairs per payload). The host uses vhost-vsock.

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

I think it is necessary to do further testing on the large I/O throughput
peak observed at 4K to find the root cause (and rule out anything
introduced by the measurement method). I used kprobe and temporary
trace_printk in the source for mechanism diagnostics. The diagnostic
data shows that lock wait time and contention at 4K both decrease strictly
monotonically as payload size increases;
wire-level tracing also confirms that 4K is split into two packets, and
that all sizes can reach the 64K batching limit.

The nature of the prominent 4K throughput gain most likely lies in it
sitting exactly at the end-to-end pipeline sweet spot between host and
guest:

Compared with 1K and smaller payloads: 4K halves the packet intensity, so
upstream host-side syscall and interrupt injection overhead is no longer
the bottleneck across the whole path, allowing the host to supply data
adequately.

Compared with larger 8K to 64K payloads: 4K keeps the payload size
moderate, and combined with the observed syscall reduction and cycle
improvement, the batch-draining benefit from notification coalescing is
fully realized.

As payload size increases further from 8K to 64K, the overall gain shrinks
smoothly, consistent with Amdahl's law, because system execution time
shifts toward page copying and VQ processing.

With all patches applied:

End-to-end RX throughput (64K Guest recv() size, SO_RCVLOWAT=1; Gbit/s):

  payload  baseline RX  PATCH RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B      0.1065       0.2503    +135.00% [+130.35%, +139.74%]
  256B     0.5722       1.0286     +79.76% [+75.40%, +84.23%]
  512B     1.1464       1.9779     +72.53% [+69.50%, +75.63%]
  1K       2.2714       3.6368     +60.12% [+56.92%, +63.37%]
  4K       3.9095       7.7160     +97.37% [+92.09%, +102.79%]
  8K       3.3436       5.3111     +58.84% [+53.49%, +64.38%]
  16K      3.8876       5.7456     +47.80% [+45.45%, +50.18%]
  64K      4.0056       5.3590     +33.79% [+29.37%, +38.36%]

Fixed-syscall stress test (receiver recv() size = sender write size;
Gbit/s):

  payload baseline PATCH    throughput change (95% CI)    recv()
          RX       RX                                     (base/patch)
          (Gbit/s) (Gbit/s)
  64B     0.1259   0.2651   +110.52% [+99.08%, +122.62%]  1048577/1048577
  256B    0.3790   0.9444   +149.20% [+134.70%, +164.60%] 1048577/1048577
  512B    0.7768   1.7009   +118.97% [+103.94%, +135.11%] 1048577/1048577
  1K      1.4886   2.9477   +98.02% [+84.82%, +112.17%]   1048577/1048577
  4K      2.1129   4.7331   +124.01% [+115.40%, +132.96%] 537436/525524
  8K      2.8698   5.3683   +87.06% [+80.96%, +93.37%]    276448/264109
  16K     3.5156   5.8463   +66.30% [+63.10%, +69.55%]    147849/132267
  64K     4.2459   5.8576   +37.96% [+35.26%, +40.71%]    48447/33144

Request-response latency (Ping-Pong RTT, 10,000 requests):

  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
  64B      221.968                  218.144              -1.72%
                                                        [-4.23%, +0.85%]
  256B     126.968                  124.541              -1.91%
                                                        [-3.35%, -0.45%]
  4K       130.362                  126.664              -2.84%
                                                        [-5.12%, -0.50%]

Diagnostic Guest CPU1 system-wide cycles (fixed-64K receiver, with perf):

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B      62.032            52.370          -15.58% [-17.16%, -13.96%]
  256B     15.287            13.630          -10.84% [-12.51%, -9.14%]
  512B      7.306             6.611           -9.51% [-10.92%, -8.08%]
  1K        3.811             3.458           -9.25% [-10.96%, -7.50%]
  4K        1.850             1.669           -9.75% [-11.78%, -7.67%]
  8K        1.504             1.363           -9.36% [-12.97%, -5.60%]
  16K       1.321             1.210           -8.37% [-10.61%, -6.07%]
  64K       1.342             1.227           -8.57% [-10.87%, -6.21%]

Patch-scope measurements and attribution:

The series was tested cumulatively in two ranges, using the same
single-stream setup and paired AB/BA runs. The table below shows results
from patches 1–2 only, before the notification changes in patches 3–4.

  payload  baseline RX  PATCH RX  throughput change (95% CI)
           (Gbit/s)      (Gbit/s)
  64B      0.1211       0.2534    +109.26% [+106.34%, +112.23%]
  256B     0.5671       0.9989     +76.15% [+70.63%, +81.85%]
  512B     1.1334       1.9000     +67.64% [+64.64%, +70.69%]
  1K       2.2650       3.5610     +57.22% [+50.91%, +63.79%]
  4K       3.8331       7.2888     +90.15% [+83.46%, +97.09%]
  8K       4.8244       7.6636     +58.85% [+53.71%, +64.16%]
  16K      5.4979       8.2469     +50.00% [+45.57%, +54.57%]
  64K      3.8875       4.7588     +22.41% [+17.77%, +27.24%]

Fixed-syscall stress test (receiver recv() size = sender write size;
no perf; Gbit/s):

  payload baseline PATCH    throughput change (95% CI)    recv()
          RX       RX                                     (base/patch)
          (Gbit/s) (Gbit/s)
  64B     0.1397   0.2646   +89.40% [+80.92%, +98.27%]    1048577/1048577
  256B    0.3960   0.9516   +140.34% [+117.48%, +165.60%] 1048577/1048577
  512B    0.7541   1.6496   +118.74% [+101.42%, +137.55%] 1048577/1048577
  1K      1.4903   2.8793   +93.21% [+77.06%, +110.82%]   1048577/1048577
  4K      2.9466   6.2284   +111.37% [+97.52%, +126.20%]  538192/525220
  8K      4.0043   6.9249   +72.94% [+60.18%, +86.71%]    276313/263852
  16K     4.8981   7.5599   +54.34% [+49.77%, +59.06%]    147576/131600
  64K     5.9294   7.7897   +31.37% [+27.18%, +35.70%]    50207/33014

Ping-Pong RTT (10,000 requests; no perf):

  payload  baseline mean RTT (us)  PATCH mean RTT (us)  change (95% CI)
  64B      119.688                  119.739              +0.04%
                                                        [-2.61%, +2.77%]
  256B     120.603                  124.485              +3.22%
                                                        [-0.44%, +7.01%]
  4K       121.921                  122.491              +0.47%
                                                        [-3.51%, +4.61%]

Guest CPU1 system-wide aggregate cycles (fixed-64K receiver, with perf;
cycles/byte):

  Buffer size  baseline cycles/B  PATCH cycles/B  cycles change (95% CI)
  64B      66.838             60.012           -10.21% [-13.03%, -7.30%]
  256B     13.446             12.305            -8.49% [-11.23%, -5.66%]
  512B      6.833              6.317            -7.54% [ -9.52%, -5.52%]
  1K        3.558              3.434            -3.48% [ -6.02%, -0.87%]
  4K        1.806              1.686            -6.64% [ -8.69%, -4.54%]
  8K        1.457              1.403            -3.73% [ -5.64%, -1.78%]
  16K       1.295              1.279            -1.24% [ -5.21%, +2.89%]
  64K       1.214              1.198            -1.30% [ -4.06%, +1.53%]

The split-patch tests show that PATCH 2 mainly contributes to the
improvement in I/O Throughput, while PATCH 3 and PATCH 4 mainly contribute
to the improvements in cycles and RTT latency (although PATCH 2 shows no
obvious regression here).

---
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

Jia Jia (4):
  vsock/virtio: split socket lookup from locked RX processing
  vsock/virtio: amortize RX socket locking for stream packets
  vsock/virtio: coalesce RX write-space notifications in lock batches
  vsock/virtio: defer RX notifications until batch unlock

 include/linux/virtio_vsock.h            |  13 ++
 include/net/af_vsock.h                  |   6 +
 net/vmw_vsock/af_vsock.c                |   2 +
 net/vmw_vsock/virtio_transport.c        |  29 ++-
 net/vmw_vsock/virtio_transport_common.c | 353 ++++++++++++++++++++++++++------
 5 files changed, 341 insertions(+), 62 deletions(-)

base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
-- 
2.53.0
