Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146962;
	b=wY/gBOnhTWOMRNbXWIcggWENSNTsQ+6eJAbNPacOpsI8qjcTEK2xDbqdMtWR+ipVVlJN
	 KZqJw79bffBu5R+kfsU5c16IGMf7nH2Ho/oWBZ08E7bnXaUL0Xq4BPrnjuIw9GGzjXsKu
	 2mdJgZDCPY3mFhlp2B8PzM0QwRPKt+MoLhy0nIJFK6jlDsEKX/dCWjdP+1zF5m2bVLgqJ
	 kfxQHmBr7IA7VsSSC/0DN5J0zmhZJHJTsK5rB2nIcWhq19r0lZ/Ek/aSmzBmOx545a3xh
	 sr+/tjXd0bztbHZddnZP2nu0mB/prq20de81wq+Yzry+klSHU0HJGPPJrB+iEzBMhWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RC3g93Ua+9GSZsKYs8/u9wdNLwZ2Tw8mjMfWg5dLdcM=;
	b=bPdGNI4eF7U4jlIUOuNDJSwiRHsgFDWYb+r2K16PjQ7ldg/EVALhIWOf0MHPwYgIp6/B
	 KfxvQfbefrPdmDK8LDZ9GaE8g6uDmqGO5isDwIXURi8tqDaZ9FZo9+mmBfR41tGH4uFbe
	 q5hQPI3yNv0ScgjGGIafPzRPV0sd4FGkXndy24LfzzCWF7UIsuUNeq+Cet6NdCMzwotgo
	 LV8NG4NtltNRVMXHLlQJKSfPCihX/fITaqUMcupQK6l0myzLCRI3OCyLNvcOjxJIZDucd
	 lRWyKkp0lVQgzEjZsiuKF1YKhsu0WcgxDTc6f5mbXW4dj1Yn6qcyaxU0beERs34USwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xx/rCGYc";
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E8606A326
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 14:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475E8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xx/rCGYc
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b5e147f101so9784b3a.3
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 06:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794146961; x=1794751761; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RC3g93Ua+9GSZsKYs8/u9wdNLwZ2Tw8mjMfWg5dLdcM=;
        b=xx/rCGYcu62nF584QzWFV+XBUdN5nUWKj8x6dz4io6mghm27EUjSCKaI+b094nvQa7
         DHuVzeNkg33e3p3IxCTCoSeiEGoOdH+TNl/uC8tOtz2WhRihpaSODJt+gizp3lvNEnPo
         63j07P1cgM+6S/kRSW09NQoxBvJyQXQ5gPRQmmLEU1N2X4LO3uTxLsD66XL6gSf+eg2w
         iLFPY2O03hOdFtErMae8Q+O2OVAgZYd88nTXhT9+gRZrO/+K4Rwnwn5ZgQcZoeUjslm9
         nfKo9mIl+uDNsUUsP2LCj+lLXaLzmvCe8qcjc5UUBOR8WwWAbrsvPGC/rJWyuPgULq+g
         uI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794146961; x=1794751761;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RC3g93Ua+9GSZsKYs8/u9wdNLwZ2Tw8mjMfWg5dLdcM=;
        b=vWK0/+yCcDZVvgPP22B2jZsDZ6IlDDsqtEC94pIec7RYP9u2N/F1Z0X5gRlXXIC4S/
         vY9t0F0n2smvGsCxJtRKHet1posNyEdjBQ6HDTiMyHf6RbxwC895L63qYbfZkKRMV1Hh
         EBzaHm9fNGszHb7L1mmRiB+/AKHDg3ehKmrH7TOHLi4d3Rm0dCKSXpVmqFK1LHOwJj5T
         vTVAawe2q+9l3rtcBdKdvRajY/15PW82qPmdxPSQMXhOOMedwYv295EYh110edoP57N/
         2vbhac9bbColxP416AxFAGe5BpcZzvEAdLRcwU1wuOQNnz+SmBfazIsHrx1bvYevbc6E
         yT9A==
X-Gm-Message-State: APuU4Z/qHsFHGppycgkeQcBBh3NratZ78JhLL/tJejyfTSRUXvVjZxY3
	Lp7z/QDs5o3xCaKP64zyfBBN5UG9mUenRquQRt8cYHeTHAAucajwwnoi/9W77+4LDMD0lQ==
X-Gm-Gg: AYBFou2PyPyLgCQsMPmH3jfDI9OFDy66uDr2iW8PrvN5EO6RFosvn2iSsfp3XX2t0az
	URAJWS8JkApJJkaQhJMlAV6u+ZSgjgOpNs2h12eehIVIcVUwDa+tVBDX4+/LMCF4fbfyRLe7tuF
	qf+lxSQ+EZowDgtnUezSqSz+dXd1OJFWtpnOmoWGcKieKUgszZEl8G6AbbS83/9fhZPuK9Cepv7
	ZfvWmnJXeSB0vcZpyyHTL2ugleY3+bE8s4gV6NHAQcrLIMhemmJIDICrt5HR0o1NcdSv52pxYV3
	PzKBIhDDG6TvRn3vZKjBrKzwpZYV7yYpj8SxgZTVz1HOIfWYIiPxmuAmvfqX+cTbU49pqpb7rMu
	3lQbRsFnw8KflczHb3spEVyNcRjjoAJwrpESY1R+Q/CYOsXSmyRCgSqggBTpbYH4+VtMBiWk4Zy
	1sNY9SBN12ccV3ny7HyPBt7XNwBwrUqYpBghM/ZgyDKOVQGoSe9JjcZk72DlBVkwfi4kO1QDXcB
	C309PFwOctV/OcVS/qDZ7TyYwMXwnzbvosF88SHs/qKYJ5cKFcvSjQdocInByL/wz8XdViMEEYK
	tJEvV22zjGAmRp7X8pe+/0fDQn72cgOLP1sunx8qD5x8IiXNfhAgCWm4dN+SsNdLBWvLYQuV3lG
	PYIKJEwCjFK5hkuVrfxGHq7o9
X-Received: by 2002:a17:90b:1c8f:b0:3ab:be66:ddc5 with SMTP id 98e67ed59e1d1-3b12d4cfcdamr2132665a91.6.1794146961392;
        Sun, 08 Nov 2026 06:09:21 -0800 (PST)
Received: from fayedeMacBook-Air.local ([14.150.132.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm6954683a91.0.2026.11.08.06.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 06:09:21 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 "Eugenio Perez" <eperezma@redhat.com>
Subject:
 Re: [PATCH] fuse: virtio-fs: don't process completions of aborted requests
In-Reply-To: <20261020135350.7751-1-q.h.hack.winter@gmail.com>
References: <20261020135350.7751-1-q.h.hack.winter@gmail.com>
Date: Sun, 08 Nov 2026 22:08:45 +0800
Message-ID: <179414692575.30170.3327784588587339913@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Sashiko,

Thanks for the review.  I did not extend that patch: tagging
completions was the wrong layer, and it introduced the sticky-state
problem you found in #2.  I replaced it with a v2 patch, which
prevents the request from becoming device-visible in the first place:

  [PATCH v2] fuse: virtio-fs: stop new requests before draining queues

One new per-vq flag, fsvq->aborting, is set by
virtio_fs_stop_new_requests() before the first drain in
virtio_fs_conn_destroy().  It is set per queue, not with a global
barrier, and that is enough: each queue is drained after its own flag
is set, and for a request that reaches the device, admission,
virtqueue_add_sgs() and the in_flight increment happen under the same
fsvq->lock.  During teardown a request therefore has only two
possible states:

  1. it observes aborting under fsvq->lock and is rejected with
     -ENOTCONN before virtqueue_add_sgs(); or
  2. it passes admission, is added to the virtqueue and is covered by
     in_flight - either incremented under the same lock on first
     submission, or already counted when it was queued - so the
     drain waits for it.

There is no state observable by the drain in which the request is
device-visible but not accounted for by in_flight.

FUSE_DESTROY is the one request intentionally submitted after the
first drain: it is the teardown request itself, issued with
args.force, and fuse_simple_request() waits for its completion before
fuse_chan_abort() is called, so its lifetime cannot overlap the
abort.

#1 (post-drain request -> DMA UAF; Sashiko's "in-flight at abort")

I agree the normal entry points cannot reach fuse_chan_abort() with an
in-flight request: virtio-fs has no userspace /dev/fuse fd, disables
fusectl (no_control), and sets no_force_umount.  The only path is
fuse_conn_destroy(), preceded by a drain.

That drain only covers requests counted when it starts.  A request
submitted after it returns is added to the virtqueue and counted, and
is then freed by fuse_chan_abort() while the device still owns the
descriptors:

  CPU0 (umount)                    CPU1
  drain returns (in_flight == 0)
                                   enqueue_req()
                                     virtqueue_add_sgs()
                                     inc_in_flight_req() -> 1
  fuse_conn_destroy()
    fuse_send_destroy()
    fuse_chan_abort()
      ends and frees the request
                                   device still DMA-writes into the
                                   freed request and argbuf

This is the reachable variant of #1, and what the patch closes.
Unpatched, I could land the post-drain submission in the virtqueue
and get a KASAN slab-use-after-free in
virtio_fs_requests_done_work(), with umount hanging afterwards;
patched, the same submission returns -ENOTCONN and umount completes.
(Full dmesg is in the reproducer.)

#2 (aborted never cleared, second mount's FUSE_INIT dropped)

The v2 patch has no aborted/completion-suppression state.  aborting is
reinitialized by virtio_fs_start_all_queues() on every mount, so it
cannot leak into a subsequent mount.  I verified mount/read/umount
across repeated remounts; FUSE_INIT completed normally.

#3 (queued_reqs not handled by abort/drain)

Requests on the dispatch queue are already accounted for by
in_flight, so the drain covers them even though they have not reached
the virtqueue.  If the dispatch worker retries after teardown starts,
aborting makes virtio_fs_enqueue_req() return -ENOTCONN before
virtqueue_add_sgs(); the retry passes in_flight=true, so it is not
counted twice, and flush_work(dispatch_work) then waits for the
worker to finish.

Measured with a forced -ENOSPC so the request really takes the queued
path:

  in_flight seen=1 after 2 ms
  VF_INV: q=requests.0 in_flight=0 queued=0 connected=1 aborting=1
  injected STATFS returned -107
  VF_INV: q=requests.0 in_flight=0 queued=0 connected=0 aborting=1

#4 (argbuf leak on aborted requests)

There is no skipped completion, so there is no new argbuf owner.
Rejected requests free argbuf in the existing error path of
virtio_fs_enqueue_req(), the same way the !connected path does, and
the stock abort path is untouched.

I also checked the two teardown interactions.  remove() only narrows
admission: connected=false is set under fsvq->lock before the
virtqueues are torn down, and enqueue_req() checks connected before
dereferencing fsvq->vq, so it cannot race into a cleaned-up
virtqueue.  For a new mount, sget_fc() keeps finding the extant
superblock until SB_DEAD is set, and SB_DEAD is set after kill_sb()
returns; conn_destroy() runs inside kill_sb(), so start_all_queues()
cannot clear aborting during teardown.  Both were confirmed by
running umount against unbind and against a concurrent mount.

Tested with KASAN, prove-locking, DEBUG_LIST, DEBUG_SPINLOCK and
DEBUG_MUTEXES: 23 mount/umount cycles with read/write load, the A/B
above, and the queued/remove/mount window tests; no WARN or KASAN
reports.  The tests used one normal request queue plus the
high-priority queue (nvqs=2); the multi-queue loop is the same
per-queue code but was not exercised.  The test kernels are
instrumented (injected STATFS, widened teardown window), so their
timings only show ordering.  A FUSE_DESTROY that is never answered
still blocks umount; that is pre-existing.

v2 also words the /dev/fuse point precisely: virtio-fs exposes no
userspace fd at all, and no_control disables fusectl.

Thanks,
Qihang
