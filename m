Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67F4B0E42
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873088; cv=none; b=EGdT6xuHfMBjcJNfXb9caBP+3bXAVF1aKKqBk1rxzW++l1H7k0QyeG/nl+dexGN8VcFLSrFU4nONIAWKCXW1/Op75nNyRIiPcGg9BKdD0y6XudHnQobp8CTbVyO/HAu0Sr6wZvOzJTC2GkBwZwjk4UzE+s+S+VMyyxrTs3T/zAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873088; c=relaxed/simple;
	bh=bHnS6JjDuQfRdGNzP3Opq5HRutuiNewLNgfvWXk7tZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ddJH9hD3myCiNnePJ8khJA6qYPub0ixAjR8R+VQJCjHeqpAoHb84aLKlJJ062AYBnMClV/3SQLuP7VZ6JqyMWpx5n03ujSaExipAwhUosR+WxfoW0w6Iqk2ysAK+tPb6X3waYRy69/HRWz2nhrWMc41SxGRrdY5X2WFbinswrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAh0QZlT; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAh0QZlT"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so1384433eec.1
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791873085; x=1792477885; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UoJXd2Abc6HDFA6vzYwQCdunzjasHt51XqLN6wS2ME=;
        b=VAh0QZlTLfqVo5Xgn1+ypM9YjbMoQuYcJxKRwcquutA5TDoACId3KW3Xei1nrXkAzC
         +6Um7/0XILMXgtvM7PZ+aUXQSfuEG0P3/DmICNztjk7iXHfr1uNPFhg3eD+ipJn6VRrc
         D5Awmvy7+83SrnRE1ce1YYFpUOQxA4znyoGovqDdintAO2IQuh7UqIauUr1jtSuAih6i
         anc8fmXHR4CoFnjwo4siF+KI8yErj7TUJQL8GHzmLu4aRrM0+eF3sCVrXhBsHenThNKI
         EkRyKQMzFQjx6yxE6r3t0FjoB3BTFnZID9EdGr57gBs1Yer4mew8Xd5DutON8vydflM1
         FDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791873085; x=1792477885;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9UoJXd2Abc6HDFA6vzYwQCdunzjasHt51XqLN6wS2ME=;
        b=2S3S2825toZ2evcqOvm5f8n4lbuK9F0U/6vhQ7pEsT/qu+1lXOG63J6cD1cW/ruVBF
         ug/ygcLgTIc6ho8B7RPTOPQzmvUYqpaQqTQHglZvnNPnXbT/5SwLNGMOcxYKwNtQL6Wk
         6wHVZLGz3L6+ntocuBv1Q5fygtAg2Sa4pTXs3wsovumWqzYICwrCSOaLByVbgoUPfErH
         oHCjD+Im4PFSNhX8Zy5ehFmiv1z3RUB/rZRI/yJCmOXAsdpMSZafvkNYjPVYAXQjuT+l
         v+p3Qhg34VgVNbN8bqUSRXV4HOQMIy6dQ6wwuO+qpQjpOA+MtTM587oOH4OLXOGnAzxY
         VvTw==
X-Forwarded-Encrypted: i=1; AKwUvBzbjDkXtmXoLhC5oNFHPgOsoGtexDtg4E20xwX7RQWqYZ1ILhzut48O4k3Px8ACXmQfqaqUPvEytGIBJmGD/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYJwE21oNbv+xehoFQbodhm2pdU7ZC2NVg+GJLM2FOjkA4Jk00No
	QXx11tg41ojLpejLeCXGtRs8PErVu/RfY8HNi8QyPADc4k3xFpE5vKY2/Z8u9Q==
X-Gm-Gg: AYBFou1X9ictHq0j5VrOzFnwgxgxTz4rFy7EP+hI4BhjpyhfEKj2U/C6Ky3unOwkf93
	9t48iZzs3URrImz2L9o7UArw7dtO1sTd42c+VGrY8O4wsRuPY+mqDPNDZj8U9aLtMHlbYUjlSIQ
	5X6EP9FJUVqCp4lf+t4HECvCXw0l5sC7Xay6Xqpeb5GNLGXQtQyFlRrdT6ooLIYeYM1JpeEObB3
	uvETDY9rKv1N7SRfdIOtsn4gqFCH/Df9MnEoo9FSWpCqyuZ6HITVHKEwU0y0QlmnldXc65wz0zV
	ntnhcAP6kh5UvdtrE2iiAraU9/fuJLOoFKjDaEUNyfYgeA7up8fi47vCVtqsZ7XYczHh3jbv1BV
	C2RjlwSafOww7s7VfPtpBAyndgga16AwN0iBZWOA+oBgkHHLePosF38HQt5UGtJdq6MKsVj36TO
	AvHjdCUYcO07HFt9TB93VltWOfC/xBPrSFvVPuwwM9WwLylAW2j5jzHumDCjC1oH4V/OKCwQ==
X-Received: by 2002:a05:693c:41d1:10b0:35a:a5c6:40e6 with SMTP id 5a478bee46e88-35aa5c656f8mr6507438eec.9.1791873084994;
        Mon, 12 Oct 2026 23:31:24 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1ba7esm39622657eec.7.2026.10.12.23.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 23:31:24 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] vsock/virtio: reduce RX per-packet socket overhead
Date: Tue, 13 Oct 2026 14:31:08 +0800
Message-Id: <20261013063112.168321-1-physicalmtea@gmail.com>
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
  vsock/virtio: defer RX readable notifications until batch unlock

 include/linux/virtio_vsock.h            |  13 +
 include/net/af_vsock.h                  |   3 +
 net/vmw_vsock/af_vsock.c                |   2 +
 net/vmw_vsock/virtio_transport.c        |  29 +-
 net/vmw_vsock/virtio_transport_common.c | 335 +++++++++++++++++++-----
 5 files changed, 321 insertions(+), 61 deletions(-)

base-commit: 8df0638138d3e0344fd1fb36cf2d1ca1cf5028f0
-- 
2.53.0
