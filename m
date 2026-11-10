Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322371;
	b=oj3LKglf12Hty0CYt1rwXtCygofxuKaguTx5kGYA3XIn0oHTeuugQ9WfS2joli+P2KKA
	 949dkSILE3JU8JuPyP98CdHZr8hUNIemowFKw2WWf93FI1Jc1oyFmh5jDKoHbY17wiCE5
	 I1NoCiD2Dfm4OGE/QZA9049Er0OOqr0DgP6NKoP1WtkLspXKdKt5JwSwyWU0czURuNUZb
	 PF2VzMP6D+AYEMdJRF5itldiH5s9SZMrSsTh6VuhygIxNSBxtyenIJCNcZ+s+030H+Qvf
	 KkAeVx4dlBpkOY39WPX6KWkEZ5JeB8XUrUFqRlWmrcmPAXH49nMBiJEMDuZp362Z00g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322371;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6N4yimoRtRyrI1TQXjE1WplbXHKcJsyASw66CLWCFAw=;
	b=AF3qLY5S/bdx81pHvr/PJXpYLm0fmJL6pid09+MIXV+kCTkSpbmBPOsQ+J524Hs5O+8F
	 S1E/gNFuAlqXkjExEUppOOKM3RPdNNbImTgRyOY0oef8E53ou7dWVzcSHMMAAE5DMJlHp
	 ul2OmJtuwnc1/SSsuRR7ug+NlIaXXMF7r23cD6Ct0ss5651zLt63pWEZZwb+Ji0TdNG5k
	 mnGwWfN0MeLiVn0IXQj//X3lqZJ5yZjWG+ik8CBEVZKgbjs//v8bLs2/mMIJCswwQeIvg
	 NpWaLUiZmosBRLO5k3FLI0wPopAKlrVb2Q0rjSgikLQxvpVtg2evqBRL7Nt/qNFkjOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ggpvu9w/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E087E606A33F;
	Tue, 10 Nov 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggpvu9w/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281AC1F008A1;
	Tue, 10 Nov 2026 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322370;
	bh=6N4yimoRtRyrI1TQXjE1WplbXHKcJsyASw66CLWCFAw=;
	h=From:To:Cc:Subject:Date;
	b=ggpvu9w/K6Vk1WvmYnVI0Uq0KhIYEbmQ4aoArPEh+SzrR7qa/+hmDIsPvuAXPHUDw
	 /uif667CqhjMBKrR05NhTNtuq5x9jQoSGHUGnPIr+UbTdVUZ2CYwAKDe7HwF9AsjFZ
	 g+ABJ6YtaOaJSE7/Epg0NejhDm2SY8+fISKQn6uIyEud4FdNcPvNP9M3Xbtsn5wIec
	 z9uqdI2K0sm6pFIvvxXlM2j0+GvoZFegpt7UzK3vMOq7i/AD+hFEMYzdg+5dAKlrOJ
	 /3xCmBBbYUxi2vBAwaT5fbkmiZd3ygKqxr6nZdWKy8U3H3061+efX6INmUVacx9ht+
	 ePU/4xDjNviwg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 7194E198003A;
	Tue, 10 Nov 2026 09:52:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 10 Nov 2026 09:52:47 -0500
X-ME-Sender: <xms:vC_zamIrxbPFlMqmqdH87bJ8oVb5OH4j-5QKaD2odtGRa378W4aMGw>
    <xme:vC_zau7iG6U6GWcxc4P6mny-A7p4SJoQZrrZvLs_mDvoGLiGsjZdk7uYTCRpA3s_1
    1pDVm15b8ig9mTHOvvB25nR04H1HdRS1wor-wiM5JgX1_RSKuuh0TDA>
X-ME-Received: <xmr:vC_zaqiyHoZbN0j8GQiEZphmP5JdoK7rL96QJ0IeJMI6ShVZYYp7Y01GchU>
X-ME-Proxy-Cause: dmFkZTGWr3Bol1il49kOQEDKgAYHsyZ47Yj7fzpOlw8TiM0gPuvQ5jH8a26arj7fWVWo8c
    uYSQI4gF+J/q2fS951R4MAEK6NSyHihCKPc8gs/Smt0oEHe2/ZNkgA1wFpTMe1NCyEh3Js
    2sOQFQl2u0oaCfgohyCrCmhrDmMmEdzNJMC3F6GAOQKLThCibPUBlYSTA6wtUNMKpaxtaj
    dGOb/Rq6NmezBvNu+QpQUTiCikoSwAPnJ0sPDBsm+TwW/3NvGIqVnTQzL+rnl9P96FOaud
    9QVmodzVH6f2pAiYKwBUmVjS32P99W7X/ARoxC9GGJiRXhxnK3ET71I2aLak1E7ScHgDGB
    Br2DNeeEux/MRQtpQWpWckTmepF25FWbH2zpcxILcX3v8zdpDpYA0mKU3vXWDmGveVY8nP
    Jm3J83mZ9Lzll07xzIjyxfcPXPgd0/Nl+jFRI2+Ps8w1WUGCVSC+Ut/B8cfsovYNhH4FfM
    k/Da/LpZE9KdncQ/IkxzRgPzAfcg2vDaR6C/9iYGSWEekPdaxHtpQSOVK/9sa+vHbA7FJH
    s4s9wxDy2pCNAajnA0e1t+EjuXIj13ZxLczwVQd1kW2RXOeKrM2qibYR+HQPyAAkmPdBjS
    nHeTjt+6RUR2pf7R3gO/B/J8SGsz4FV0ldaAoXhphfAKjj/wvDFOSNFZBPAA
X-ME-Proxy: <xmx:vC_zas-vjmx1sNJQtDUEDCM8_lWziIyZYE-z3yUvQdabh6AxgB9Tag>
    <xmx:vC_zasfIDq80AsPowkfGGXRBwH16uZwrkWAbUbUZRtxhVWFNuI1ChA>
    <xmx:vC_zagltlF42Dg5urBmLLPqDKIpm3LcoDVOkzIAZZ9nRyQsHR1qlxQ>
    <xmx:vC_zamyEB-uOy-v3wawnd3EFx3P_SgwV_COkCOJlzzDK6HB-7NVFeg>
    <xmx:vS_zalEVfRoL663tcZdP2A-__TD09DaIKUUbjs8zEKw0ZUSkCtuNvFAc>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 09:52:44 -0500 (EST)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amit Shah <amit@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/4] splice: remove pipe buffer stealing
Date: Tue, 10 Nov 2026 14:52:35 +0000
Message-ID: <20261110145241.536019-1-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->try_steal() lets the consumer of a pipe buffer take its page instead
of copying the data.  Two consumers use it:

  - fuse, when a server splices a read reply into /dev/fuse with
    SPLICE_F_MOVE: the page goes into the fuse file's page cache;
  - virtio_console, which passes the page to the host.

The page can come from the page cache of another file, from a write()
into the pipe, or from vmsplice(SPLICE_F_GIFT).  Stealing it takes page
cache folios out of their files, and turns pages into page cache folios
and back.  That gets in the way of reading the page cache without folio
references [1] and of telling folios apart with a PG_folio flag.  It
works only on pages that nothing else holds, for fuse only on clean,
unmapped, order-0 ones, and it has needed fixes again and again:

  32f98877c57b ("fuse: don't check refcount after stealing page")
  b89ecd60d38e ("fuse: ignore PG_workingset after stealing")
  712a951025c0 ("fuse: fix page stealing")
  59ba47b6be9c ("fuse: Check for large folio with SPLICE_F_MOVE")
  15c20483d915 ("fuse: validate folio state before pipe_buf_try_steal() in fuse_try_move_folio()")

Linus and David suggested removing it [2].  Both consumers already copy
when a steal fails; with this series they always do.  vmsplice() and
splice() still accept SPLICE_F_GIFT and SPLICE_F_MOVE, and fuse still
advertises FUSE_SPLICE_MOVE, so that servers which ask for it mount as
before.

Miklos, Amit: do you know of users of the fuse move, or of virtio_console
splice, that depend on the copy being avoided?

Without ->try_steal(), nosteal_pipe_buf_ops is the same as
default_pipe_buf_ops, and the last patch keeps only the latter.

Tested on x86_64 with a FUSE server that answers reads by splicing the
page cache pages of a backing file into /dev/fuse with SPLICE_F_MOVE.  On
v7.4-rc1 how much moves depends on folio sizes: with order-0 folios on
both sides, one read of a 16M fuse file took 3968 of the backing file's
4096 pages out of its page cache.  With the series nothing moves, and the
data read through fuse is the same, also when the server reads its
requests with splice().  A virtio-serial port fed by splice() from a pipe
and from a file, and vmsplice(SPLICE_F_GIFT), SPLICE_F_MOVE, tee() and
AF_UNIX socket splice checks also give the same data before and after.

[1] https://lore.kernel.org/all/20261104130118.2507513-1-kas@kernel.org/
[2] https://lore.kernel.org/all/CAHk-=whhp=Q8qR+wPoM9+mxYPQ_OXMOEoKmT7J0JZikFZusuqw@mail.gmail.com/

Kiryl Shutsemau (Meta) (4):
  virtio_console: copy pipe buffers in splice_write()
  fuse: don't move pipe buffers into the page cache
  splice: remove pipe buffer stealing
  splice: replace nosteal_pipe_buf_ops with default_pipe_buf_ops

 drivers/char/virtio_console.c |  39 ++++-----
 fs/fuse/args.h                |   1 -
 fs/fuse/dev.c                 | 146 +---------------------------------
 fs/fuse/file.c                |   1 -
 fs/fuse/fuse_dev_i.h          |   1 -
 fs/pipe.c                     |  43 ----------
 fs/splice.c                   | 104 ++----------------------
 include/linux/pipe_fs_i.h     |  38 ---------
 kernel/watch_queue.c          |   4 -
 mm/shmem.c                    |   7 --
 net/core/skbuff.c             |   2 +-
 11 files changed, 26 insertions(+), 360 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.54.0

