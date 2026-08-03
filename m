Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A41EB1AA;
	Tue,  4 Aug 2026 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808461; cv=none; b=YETIIXfSbG6b1qz5yXwRQzbZRqWeJX6YsXEAX35bg8gS0mN47K6StPg6wY2Ok6X8RlI10tKjk/PhIQytmQ/wAx7AICkRTb4gdGuP1mjm4rmd6PqeIx77qc6/PH8e4WRPfRpYLf+ZeI5lxzAUYnw4R2ks86XEMoguvdBA/oTeOyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808461; c=relaxed/simple;
	bh=8u6Ytzux7e29IHh1rVgVy4h0iCR1Phxn+96IFIqU04Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dQW4HoCvtnxDSWxCoOZOIUA8DMdIn7VvAwD6b36gnYXPWY8oCo5eLWpOOmG4z2gjQQnpV9/SGPxhlpfIAeb6HbKQtg8KPzImh3bEtO+D7KeSpzIUSGS3xNS5UBxa9/bIiyNXcOvP+NsF/+uyyN9NqtOK7MHybYjzfkuiyIatP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.. (tmo-075-57.customers.d1-online.com [80.187.75.57])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 673Iars6011387
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Aug 2026 20:36:53 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, brett@librecast.net, corbet@lwn.net,
        skhan@linuxfoundation.org, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH net-next v14 0/5] tun/tap & vhost-net: apply qdisc backpressure on full ptr_ring to reduce TX drops
Date: Mon,  3 Aug 2026 20:36:36 +0200
Message-ID: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series deals with tun/tap & vhost-net which drop incoming
SKBs whenever their internal ptr_ring buffer is full. Instead, with this
patch series, the associated netdev queue is stopped, but only when the
new IFF_BACKPRESSURE flag is set and a qdisc is attached. Without the
flag, or if no qdisc is present, the existing behavior is preserved. The
XDP transmit path is not affected. This patch series touches tun/tap and
vhost-net, as they share common logic and must be updated together.
Modifying only one of them would break the other.

By applying proper backpressure, this change allows the connected qdisc to
operate correctly, as reported in [1], and significantly improves
performance in real-world scenarios, as demonstrated in our paper [2]. For
example, we observed a 36% TCP throughput improvement for an OpenVPN
connection between Germany and the USA.

The previous version of this work was applied and then reverted in 7.2,
because the backpressure was unconditional: it caused a significant
throughput drop in an IPv6 multicast testcase with multiple iperf3 TCP
threads sending on Brett Sheffield's librecast testbed [3]. This version
therefore makes the behavior opt-in via IFF_BACKPRESSURE from the very
first patch, so that a tun/tap device which does not set the flag behaves
exactly as before.

The series is ordered so that no patch changes how packets are handled
unless the flag is set:

- Patch 1 adds the flag only. It has no effect yet: TUNSETIFF silently
  masks it off, as it does for any flag outside TUN_FEATURES, until
  patch 5 adds it there.
- Patches 2 and 3 add the consumer side, which wakes a stopped netdev
  queue. __tun_wake_queue() returns early unless IFF_BACKPRESSURE is set,
  and no queue is stopped at this point anyway.
- Patch 4 is a pure ptr_ring refactor required by patch 5.
- Patch 5 adds the queue stopping, gated on IFF_BACKPRESSURE, together
  with the wake needed when the flag is cleared again, and only there is
  the flag added to TUN_FEATURES.

That way no intermediate commit changes the behavior of an existing
tun/tap user beyond the added checks, and bisecting inside the series can
not hit the regression that led to the revert.

Thanks!

[1] https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
[2] https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
[3] https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/

---
Changelog:
v14:
Addressing the regression found by Sashiko:
- Move IFF_BACKPRESSURE from TUN_FEATURES in patch 1 to patch 5, so that
  TUNSETIFF only honours the flag once the implementation is complete.
- Patch 2: move the queue wake for the ntfile taking over the slot in
  __tun_detach() after synchronize_net() and tun_queue_purge(). Waking
  before the grace period could leave the subqueue stopped with no
  consumer left to wake it.
- Patch 2: only wake a subqueue if the tfile still owns its slot in
  tun->tfiles[], as a detached tfile keeps its queue_index.
- Patch 2: every place that wakes a queue now checks netif_running()
  under a ring lock that tun_net_close() takes, so none of them can undo
  its stop. tun_net_close() takes and releases both ring locks of every
  tfile before it stops the queues, so no wake can still be running.
- Patches 2 and 3: enforce the consumer_lock precondition with
  lockdep_assert_held() and document it on the declaration.
- Patch 4: document the return values of __ptr_ring_check_produce().
- Patch 5: use a separate ntfile in the tun_set_iff() wake loop.

v13: https://lore.kernel.org/netdev/20260730213639.726381-1-simon.schippers@tu-dortmund.de/
--> Apart from the three items below, the resulting code is identical to
    v12 plus the separate IFF_BACKPRESSURE patch [4]:
- tuntap.rst does not name a kernel version anymore.
- Add the IFF_BACKPRESSURE comment to tools/include/uapi/linux/if_tun.h
  as well (Sashiko).
- Add a comment explaining the __ptr_ring_empty() check in
  __tun_detach() (MST).

- Include the IFF_BACKPRESSURE opt-in into the series instead of adding it
  as a follow-up fix, so that the series can not be bisected into the
  regression that got v12 reverted.
--> New patch 1 adds the flag on its own.
- Patch 2 carries the IFF_BACKPRESSURE check in __tun_wake_queue() from
  the start and introduces tun_force_wake_queue(), which is used by
  tun_attach() and tun_queue_resize().
- Patch 5 gates the queue stopping on IFF_BACKPRESSURE and calls
  tun_force_wake_queue() for the attached tfiles in tun_set_iff(), so
  clearing the flag can not leave a queue stopped.
- Dropped the pktgen numbers from patches 2 and 3, as they only measured
  the consumer side without any queue stopping.

[4] https://lore.kernel.org/netdev/20260709095511.168235-1-simon.schippers@tu-dortmund.de/

v12: https://lore.kernel.org/netdev/20260510151529.43895-1-simon.schippers@tu-dortmund.de/
Patch 1:
- Revert tun_queue_purge() to plain ptr_ring_consume() and instead
  explicitly wake the queue in __tun_detach() for the ntfile taking
  over the queue slot (if its ring is empty).
- Inlined tun_reset_cons_cnt(), because only tun_attach() uses it.

- Patches 2-4 and cover letter unchanged.
- Compiled and short pktgen test.

v11:
- Renamed __ptr_ring_produce_peek() to __ptr_ring_check_produce()
  (Sashiko)
- Add return code -EINVAL to __ptr_ring_check_produce() which lets
  tun_net_xmit() stop the queue only on -ENOSPC. (MST)
- Resolve race on tfile->queue_index by locking tx_ring.consumer_lock
  in __tun_detach(). (Sashiko)
- Wake the queue in tun_queue_resize() to avoid possible stalls.
- Other minor adjustments & reran the benchmarks.

v10: https://lore.kernel.org/netdev/20260506141033.180450-1-simon.schippers@tu-dortmund.de/
- Changed the term "Transmitted" to "Received" in the benchmarks,
  as correctly pointed out by MST, and reran the benchmarks.

Addressed the Sashiko AI review:
- Avoid a data race on tfile->cons_cnt by always locking.
- Correctly count the number of consumed packets for vhost-net.
- Corrected a typo in the commit message of commit 3.
- Added a missing barrier on the consumer side.
--> The barriers now follow the "store buffering" principle.
- No longer return NETDEV_TX_BUSY at all, because it is unsafe.
--> Result: There are still a few drops with multiple senders, which
            would be avoided by disabling LLTX.

V9: https://lore.kernel.org/netdev/20260428123859.19578-1-simon.schippers@tu-dortmund.de/
- Addressed minor nit by MST in patches 1 and 2.
- Rebased patch 3 because of commit d748047
  ("ptr_ring: disable KCSAN warnings").
- Documented the pair of the smp_mb__after_atomic() in tun_net_xmit()
  with tun_ring_consume().
  --> It simply pairs with the test_and_clear_bit() inside of
      netif_wake_subqueue().
- Use 1 ptr_ring consumer spinlock instead of 2.
- Ran pktgen benchmarks with pg_set SHARED for 50 iterations on
  latest kernel
  --> No significant performance difference noticed

V8: https://lore.kernel.org/netdev/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
- Drop code changes in drivers/net/tap.c; The code there deals with
  ipvtap/macvtap which are unrelated to the goal of this patch series
  and I did not realize that before
-> Greatly simplified logic, 4 instead of 9 commits
-> No more duplicated logics and distinction in vhost required
- Only wake after the queue stopped and half of the ring was consumed
  as suggested by MST
-> Performance improvements for TAP, but still slightly slower
- Better benchmarking with pinned threads, XDP drop program for
  tap+vhost-net and disabling CPU mitigations (and newer Ryzen 5 5600X
  processor) as suggested by Jason Wang

V7: https://lore.kernel.org/netdev/20260107210448.37851-1-simon.schippers@tu-dortmund.de/
- Switch to an approach similar to veth (excluding the recently fixed
variant), as suggested by MST, with minor adjustments discussed in V6
- Rename the cover-letter title
- Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason
Wang
- Rework __ptr_ring_consume_created_space() so it can also be used after
batched consume

...

Simon Schippers (5):
  tun/tap: add IFF_BACKPRESSURE flag
  tun/tap: add ptr_ring consume helper with netdev queue wakeup
  vhost-net: wake queue of tun/tap after ptr_ring consume
  ptr_ring: move free-space check into separate helper
  tun/tap & vhost-net: stop tail-drop when IFF_BACKPRESSURE is set

 Documentation/networking/tuntap.rst |  32 +++++
 drivers/net/tun.c                   | 182 ++++++++++++++++++++++++++--
 drivers/vhost/net.c                 |  21 +++-
 include/linux/if_tun.h              |   4 +
 include/linux/ptr_ring.h            |  26 +++-
 include/uapi/linux/if_tun.h         |   4 +
 tools/include/uapi/linux/if_tun.h   |   4 +
 7 files changed, 255 insertions(+), 18 deletions(-)


base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.43.0

