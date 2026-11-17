Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927202;
	b=b7kwwGXVLAoqQ9NbOLGBApw6fa2JoD3aqA58m+ELqc46glXQkah05NtAsJvr1tj86NVT
	 wBhDGY9kRRCLW9D0/X3/EzX/4/RgFQgsi42NZsgsnzFS4DTJoAx5oPbvW9iLgrKvleLAA
	 +fd0y3iFqGtjYMCsBHHTJy9dgyAAC+OfezehPlffv7o3j254urBmlTPlPygJ/j0nwRFI6
	 8gb2+ly8kd4vuh3FXXe9t8V0EdGRdmD3P1csxLdiv44MQMXk9yU8RofwgRgiugGRBqZa1
	 Pr0K/y8GxXCuo6/DEua+e58K3LMSEj60T5Xxzo/bt21Dhd1HTZj/lQps/oTO3rJx/qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LAxy3goky0t3VPjV6FUpbe6k2gJl15O6ptslh5cvBS4=;
	b=vtmQyLbwgiqjU9tgHYvSBmQjdSVUtyscuIYY2j2sfu7ccpgE3Hg7zRrZJes6RzCcYqZf
	 Su/8gDhuKydUuDRknVJlrh7itYYRgK2eZKWbmDVuzQabMd1AmT9NfbrBCOMCYq53Wd/aU
	 3Kbs1Vid0uentFy3GPTggre4Jvzg1O6fmt/NSEbkCWVhzkjk1oEJwKpuk0nGtjlgbgWlQ
	 Oe8QMajaoBXt9rfUT2xJ0Qnuu4C4xiOqsBoCK9qR8TipIkdkSOMmwAir0JJYtVGny7BFg
	 /6C2hJd+KkVhdRCCH5GjAuQp9H8OqUtJwwFFIs3ah7AyQc4QoTrif2CFGi/+xgLEbnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0FblvoP;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A24606A33A
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 14:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49A24606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0FblvoP
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso2357172a91.3
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794927202; x=1795532002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LAxy3goky0t3VPjV6FUpbe6k2gJl15O6ptslh5cvBS4=;
        b=C0FblvoPqe2Xt6053R76s2vFtWJQhoSiKBGRpPRlNnCPkaq9z6gdTkvKr+U383RFMD
         w8+WSsx7Y2YbGJJ4YT89bN0JhQ/lJFmROXrjsTT2EvaCn1k0TAbQwyFYy5K7Z8rJ63sT
         1mXbHnC14JZc3MVoftdn3B7RH9mJuzqjZAR69Vqe7BpRzYkgGu6CR+6jV8Uzwo7BkA9n
         zmjRTDNW+IixH4FpEzU+X8o0N31ir7outF8BwQhINFdeclxO1xi6QLeEMRL0UxI4PBet
         TMjIawETFch+Amr4aILIXxxcQ8WwaviIgcCzrsvJAdx3PeE5mkMlrMaPKJhfmhDkfRsq
         2SSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927202; x=1795532002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LAxy3goky0t3VPjV6FUpbe6k2gJl15O6ptslh5cvBS4=;
        b=bMSd89aqP5wKXO6YSgE2ltBTdE7H7BCOrIFIzoO7XDkdljm7s9dLp6EY2OQDQR318T
         z0vXfTTJrefVN60di8HIEFz4t7p6IEKGYZENglNAMBoi8EpcqTa0wmuyo1VM2JoTwDrx
         +nj4KVMv55SHZ/gtCLKk0gDhMfK4/f4Vzn7cwmUjFG37l6QBo2MJ8LPAiiL6eyFeInog
         f/xaxPT0Du3LAC+Htssc1avgFyYJchcXo+uS3j7oQtn2cwA+Pvmw+MGOrfA53nF238Ga
         ZXyFshxfGe2amz3g96pixLfgdoszF2uPBHRHgW4jklbsOnoCP0tln5T0M/xKaj7Xlp3I
         y6KQ==
X-Forwarded-Encrypted: i=1; AL+hErG65VchK6iOH7700qf+fHG6K4IWELlt1Rk1rp/iQAhExsFoRqA2Yb6kNbj7HJ8Zvu3pg2wR7hyb6Q0kOHh6dg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9MijTgvt5vn/mcVtoJCKWSGnta20YydIbY+XAsSMhpAg4dA9/J
	iwNunAgY07BOaBUeIGZ6gapQaNvkP6V2I8JWNaUfMWNwX6BU1eCQMKKl
X-Gm-Gg: AZFdTZdt3sa4PbKRZuYntzdOOunu0INYcSRlzN8oa6Hl21jGUypZ2cr15GRLMvwzJ+y
	N3kFAoxkuOJpyGW/O70+LCxxW80fPIXDdLqUVuLFgRQqGVCchrwYAz3OC5RetO41xKGWW+HXIt4
	FUgTYH+3Vb/3PFc50Ys5W/cVC4Qls37ps9AQvjmltCILFMUuLI9KIfkswnfFuYnz9AkyXn9J/Zu
	gvtxmITZ1fEEOmP8vAYQ5AM6fLDiFbx4N3G2PN8PVYJndNuPro3fIIAMFV/DG3mu7btUY1wvYLO
	sqMumj5xIQRtN1uFw+dUxgDO+Sgrzy9Si6qLy+LoavDscdvGE4pbdL32m27bvV+NH7YN8ZpdxJA
	1LJJlDkx0S1pUDlMhCRxf58QqI3Ggumxif984pzNZQ1ZlYmTqC/CnNygEyYCrUgOiqnyDwwBOqW
	fwErpWnM5HgksqfhnPuclHuxuzWIJBuBA1FnueIeWnVcrDoKunUpAH41haV/mNEiQSEvk4MmQao
	fc/4tVKInIBp+AGBK7vHCl2KZEMcgXf8qSgcmEsiD3Idv0D6gQprfWNmPcrn2YqFulzXZD3dwDy
	4VfQY0a0pf0bCemCbi237WSel2A57aIcTWDFV+N8lXaZEnnX+j7rqPfe4cSXr+woEBgxnc+boNg
	URG4WZVawUj0joXgHDoHlxKWHtFVEn3VdqsphJleg
X-Received: by 2002:a17:90b:3a0c:b0:3b1:7329:a121 with SMTP id 98e67ed59e1d1-3b1b0a0e800mr12479951a91.12.1794927201457;
        Tue, 17 Nov 2026 06:53:21 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18a2191sm6056636a12.21.2026.11.17.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:53:20 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: synchronize worker freeing on vhost-net teardown
Date: Tue, 17 Nov 2026 22:53:14 +0800
Message-Id: <20261117145314.1092372-1-shunsheng1218@gmail.com>
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
Content-Transfer-Encoding: 8bit

vhost_workers_free() only waits for RCU readers when sync is true.  Both
vhost-net teardown paths pass false, relying on the assumption recorded
when the sync parameter was introduced (5efd97e6f0c7) that "net and scsi
stop their virtqueues before the workers are freed".

That assumption does not hold when a tap queue is detached while the
socket is still attached.  __tun_detach() runs tun_queue_purge() on the
detaching thread, so skb_queue_purge() releases the zerocopy skbs and
vhost_zerocopy_complete() -> vhost_poll_queue() runs there rather than on
the vhost worker.  The vhost_dev_flush() calls in vhost_net_flush() and
vhost_dev_stop() only wait for the vhost workers, so the queueing can
still be in flight when vhost_dev_cleanup() frees the worker, and
vhost_worker_queue() then dereferences freed memory.

Pass sync=true from vhost_net_release() and vhost_net_reset_owner() so a
grace period and a flush are observed before the workers are released,
matching the vsock RESET_OWNER path.  Both are slow paths, and the extra
grace period buys back the races described above.

Testing: QEMU/KVM guest with KASAN and CONFIG_VHOST_NET, zerocopy enabled
via vhost_net.experimental_zcopytx=1.  A second thread detaches one of
the tap queues and frees the queued skb, and vhost_worker_queue() is
delayed with a fault-injection module so that the close() or the
VHOST_RESET_OWNER ioctl completes in between.  The delay only widens an
existing window; the detach, the purge and the teardown are all
unmodified upstream behaviour.

Both teardown paths reproduce the use-after-free on this base, and both
are clean with this change while the injection is still taken.  The same
injection reproduced on the earlier base where the analysis was done.

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Prepared against v7.4-rc1-1969-g666539eecdf4.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.

Test details.  The guest runs a KASAN kernel with vhost_net built in and
zerocopy enabled through vhost_net.experimental_zcopytx=1.  The trigger
attaches a tap queue to a vhost-net socket, queues a zerocopy skb, and
detaches the queue from a second thread while the owning process closes
the vhost fd (or issues VHOST_RESET_OWNER).  The second thread is the one
that reaches vhost_zerocopy_complete() and then vhost_worker_queue().
The fault-injection module resolves vhost_worker_queue.part.0 from
/proc/kallsyms and spins only when the caller is that detaching thread,
which makes the window deterministic; kasan_multi_shot is used so the
remaining reports are not lost.

Results on 666539eecdf4, one run per teardown path: the close path
reports slab-use-after-free in vhost_worker_queue() four times, and the
RESET_OWNER path likewise four times, with the free stack going through
vhost_dev_cleanup() and vhost_dev_reset_owner() respectively.  With this
change both paths complete without a report and the injected hit counter
shows the delay was taken (1 of 5 probes for vhost_worker_queue(),
the other four being callers outside the detaching thread).  A control
run that closes mid-test without the delay is clean.

The same injection reported on three consecutive runs on 776b6be748eb,
which is where the analysis was originally done; the reproduction above
is the confirmation on the base of this patch.
---
 drivers/vhost/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 4570a4ffbab2..631855064b3d 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1452,7 +1452,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_cleanup(&n->dev, false);
+	vhost_dev_cleanup(&n->dev, true);
 	vhost_net_vq_reset(n);
 	if (tx_sock)
 		sockfd_put(tx_sock);
@@ -1661,7 +1661,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
-	vhost_dev_reset_owner(&n->dev, umem, false);
+	vhost_dev_reset_owner(&n->dev, umem, true);
 	vhost_net_vq_reset(n);
 done:
 	mutex_unlock(&n->dev.mutex);
-- 
2.34.1

