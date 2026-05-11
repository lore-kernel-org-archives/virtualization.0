Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BF377567
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490661; cv=none; b=abemCo+krSAJVQ7TAG98dfjrLAogDAAlXsWQOHkTRnYQ8lSY/fqz2mL5ARYEBw/rQoOOY4rgD4E00VXhhDMMAfijKbIZaCQ8GjZqU/8W+Ib3BYy3rvMM9zEvpQXhrHUEd5CuCi3sDqqbpDevCFcWI5gKFZS/jsBrIlkh8j51C40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490661; c=relaxed/simple;
	bh=NOVPw0sRFmhs/549yezkhu2bnfPqQ2AHmr7i3bUMSWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=daR8ljJMFCsjXGRFQIKbTyB0UtJ3rRhBrHvKrWUFpZz704KZ9zAO1I4uDR9GkU/2iJ8VxVmeiONgOFof5AM/78NhYIjK+lK3qMBK5rFMCIpLvySVp3IpMinmxS79JfAf5BiS/ZETN7NaHyuIt597cBdIIJKE9bqAk5fte/t75sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWkYLsRP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWkYLsRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeXjhbPFcIE2xpoWydu6GqD8aKPwmV5ublK6KJ28nAc=;
	b=HWkYLsRPaoHz7KxJeITJVNyRa6E5WsVlc16ZlutllRZbbuFHen+MVD8JttVhcgSGaRIsiD
	oRldV0qbPj6xpMgD2PqQX1yaQ36fidiEJWTB28Th7UTondJ9eIpN+dJDJTK1UM2+lBlNO2
	0Ses0Vlabd6F+Vr88KrhAH0YGSTXECM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-DKndpRWoOPmCjgIl_Cu7rg-1; Mon, 11 May 2026 05:10:56 -0400
X-MC-Unique: DKndpRWoOPmCjgIl_Cu7rg-1
X-Mimecast-MFC-AGG-ID: DKndpRWoOPmCjgIl_Cu7rg_1778490656
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4518f777225so2690351f8f.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490656; x=1779095456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeXjhbPFcIE2xpoWydu6GqD8aKPwmV5ublK6KJ28nAc=;
        b=WYr5LVXXz8mVAUxDU8cLdPPGGsmHGmulYOFMIcX8Le8PdMEEdcc18zYtvkxC4D2tZY
         U/aliGD0QQVXn71LxvZpxiqETDY97vpf5XyyiF+p903T3GRITv/qnM9iNfXKi17U8z/m
         ZNBPVHul3L6VO2cvX5EOnS60iD+dfODFoMmYuuPmZarZHhK7rodX+G590neQKZ1uGSUV
         VraPuY4t7U+C6SeRuCbpLJN9/9dc/TZGWTjJkpVNVDJ4NlskinDooOHUCZdE+gFJIlhg
         rH/D6DYTZvShXEK9W5rU1LBRJreHh4DB6DjswHURsns+ZlGixtulZDUNcBo5PBC3iGh3
         xkhA==
X-Forwarded-Encrypted: i=1; AFNElJ/HyT05q3b5LNdkE/hFBf4ztMBMJ13Zzsc4FA7FfJhSvahBVjxKZekEpw9PI1esC9UqGCGs1/Jq/46fMRUqzA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0X6fEkIDfPvZU4CmumbedId0rSIfRxpYIaYM6plTEqsGkY6zj
	qsbCu9c0c/ani0FggKYTcm93eBeZ5AtFB2oJoSizAOT+FQa2ARktJRVVfo8gHWJpyd5PqrqNCEF
	Qv8XSqpobR0KdsIpewtfcB2r9HAnobEfLxOfoCU87J/dTI5ipNsRKB4LJZroFGXq6+mCE
X-Gm-Gg: Acq92OF81lNs6VxYU8a/fe2Y6YiQZwsStCw5jyqJudVZqsLJg3ff7rsg0tKnNnKL3Hv
	b0n154O03x7HvE4tHOwEtlcXrWKPghFoCpwD5xiv1rVJYtFha3oAztzwKRoABd9Os46txzNZNSz
	sbOIQFoe8KBH9f/HNWzGbM12mNQ6p/j1zWAd301pwY1WbLaYrK1H7+OsAb6yU8SXdQ4qvu5Lzms
	64XluiMhphGcKTiVw1vtE8W3uIfwyjZr2VhHKPwjmPumjdyCW2kfzZ0dDf1eqjfQAj3KzQaz5WR
	e7MK7wr+nS0zbQ+kcsKgW/vCgcz5IAZ67oU66e2XYSWkfUGUwXG9em9c2kQL0pR9vGOmqgFkV1U
	p6Zx47xxVn9zgo180qx8QRbNdDxVaXf/pFgNWDrZX
X-Received: by 2002:a05:600c:628d:b0:48e:82b4:b54 with SMTP id 5b1f17b1804b1-48e82b40ba4mr52289635e9.23.1778490655512;
        Mon, 11 May 2026 02:10:55 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:48e:82b4:b54 with SMTP id 5b1f17b1804b1-48e82b40ba4mr52288725e9.23.1778490654837;
        Mon, 11 May 2026 02:10:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db09cb6sm58109535e9.22.2026.05.11.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:10:54 -0700 (PDT)
Date: Mon, 11 May 2026 05:10:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v12 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
Message-ID: <20260511051037-mutt-send-email-mst@kernel.org>
References: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P8EZAxkvx5h2O3o6mUbvOjxp9-UpuTHzUffW1mfJI_o_1778490656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 10, 2026 at 05:15:25PM +0200, Simon Schippers wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped - but only when a
> qdisc is attached. If no qdisc is present the existing behavior is
> preserved. The XDP transmit path is not affected. This patch series
> touches tun/tap and vhost-net, as they share common logic and must be
> updated together. Modifying only one of them would break the other.
> 
> By applying proper backpressure, this change allows the connected qdisc to 
> operate correctly, as reported in [1], and significantly improves
> performance in real-world scenarios, as demonstrated in our paper [2]. For 
> example, we observed a 36% TCP throughput improvement for an OpenVPN 
> connection between Germany and the USA.
> 
> Synthetic pktgen benchmarks indicate a slight regression, and packet
> loss is reduced to near zero. Pktgen benchmarks are provided per commit,
> with the final commit showing the overall performance.

at v12, time to merge this.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Thanks!
> 
> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> 
> ---
> Changelog:
> v12:
> Patch 1: 
> - Revert tun_queue_purge() to plain ptr_ring_consume() and instead
>   explicitly wake the queue in __tun_detach() for the ntfile taking
>   over the queue slot (if its ring is empty).
> - Inlined tun_reset_cons_cnt(), because only tun_attach() uses it.
> 
> - Patches 2-4 and cover letter unchanged.
> - Compiled and short pktgen test.
> 
> v11:
> - Renamed __ptr_ring_produce_peek() to __ptr_ring_check_produce()
>   (Sashiko)
> - Add return code -EINVAL to __ptr_ring_check_produce() which lets
>   tun_net_xmit() stop the queue only on -ENOSPC. (MST)
> - Resolve race on tfile->queue_index by locking tx_ring.consumer_lock
>   in __tun_detach(). (Sashiko)
> - Wake the queue in tun_queue_resize() to avoid possible stalls.
> - Other minor adjustments & reran the benchmarks.
> 
> v10: https://lore.kernel.org/netdev/20260506141033.180450-1-simon.schippers@tu-dortmund.de/
> - Changed the term "Transmitted" to "Received" in the benchmarks,
>   as correctly pointed out by MST, and reran the benchmarks.
> 
> Addressed the Sashiko AI review:
> - Avoid a data race on tfile->cons_cnt by always locking.
> - Correctly count the number of consumed packets for vhost-net.
> - Corrected a typo in the commit message of commit 3.
> - Added a missing barrier on the consumer side.
> --> The barriers now follow the "store buffering" principle.
> - No longer return NETDEV_TX_BUSY at all, because it is unsafe.
> --> Result: There are still a few drops with multiple senders, which
>             would be avoided by disabling LLTX.
> 
> V9: https://lore.kernel.org/netdev/20260428123859.19578-1-simon.schippers@tu-dortmund.de/
> - Addressed minor nit by MST in patches 1 and 2.
> - Rebased patch 3 because of commit d748047
>   ("ptr_ring: disable KCSAN warnings").
> - Documented the pair of the smp_mb__after_atomic() in tun_net_xmit()
>   with tun_ring_consume().
>   --> It simply pairs with the test_and_clear_bit() inside of
>       netif_wake_subqueue().
> - Use 1 ptr_ring consumer spinlock instead of 2.
> - Ran pktgen benchmarks with pg_set SHARED for 50 iterations on
>   latest kernel
>   --> No significant performance difference noticed
> 
> V8: https://lore.kernel.org/netdev/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
> - Drop code changes in drivers/net/tap.c; The code there deals with
>   ipvtap/macvtap which are unrelated to the goal of this patch series
>   and I did not realize that before
> -> Greatly simplified logic, 4 instead of 9 commits
> -> No more duplicated logics and distinction in vhost required
> - Only wake after the queue stopped and half of the ring was consumed
>   as suggested by MST
> -> Performance improvements for TAP, but still slightly slower
> - Better benchmarking with pinned threads, XDP drop program for
>   tap+vhost-net and disabling CPU mitigations (and newer Ryzen 5 5600X
>   processor) as suggested by Jason Wang
> 
> V7: https://lore.kernel.org/netdev/20260107210448.37851-1-simon.schippers@tu-dortmund.de/
> - Switch to an approach similar to veth (excluding the recently fixed 
> variant), as suggested by MST, with minor adjustments discussed in V6
> - Rename the cover-letter title
> - Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason 
> Wang
> - Rework __ptr_ring_consume_created_space() so it can also be used after 
> batched consume
> 
> ...
> 
> ---
> 
> Simon Schippers (4):
>   tun/tap: add ptr_ring consume helper with netdev queue wakeup
>   vhost-net: wake queue of tun/tap after ptr_ring consume
>   ptr_ring: move free-space check into separate helper
>   tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> 
>  drivers/net/tun.c        | 109 ++++++++++++++++++++++++++++++++++++---
>  drivers/vhost/net.c      |  21 +++++---
>  include/linux/if_tun.h   |   3 ++
>  include/linux/ptr_ring.h |  20 ++++++-
>  4 files changed, 139 insertions(+), 14 deletions(-)
> 
> -- 
> 2.43.0

