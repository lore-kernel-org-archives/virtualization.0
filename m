Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4F1A9FAF
	for <virtualization@lists.linux.dev>; Sun,  1 Mar 2026 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772404690; cv=none; b=sQaLsoC5yoSn9V/WmLo1xtjN1/j/lCxPUMw/VTyGU3Yx8vmVpjOhtE+ttt++Wui4YD+ShCN05mTbn4bKqHS/bOzc5gYELFsS3DqLAwhKdM3evNENzZMhD4K5/LbQyjg1tyQI2E9IGrwh1Nb9sjd7lKzpRI65JB9IkX7o9XdBFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772404690; c=relaxed/simple;
	bh=HGNPxjZdXQ0CIKGWXj8Xf/gkL80A5tRaqqvffEvQZ9U=;
	h=Cc:Subject:From:Mime-Version:Content-Type:To:Message-Id:Date; b=lsYYW5xQh1WUY5/a0sEayF/sxLVoqM15Qq9cbxwTRhrOadnea7rGMbYsXXKoRoCrjsMZG+K2lhydLSkpNH16SOCpR//ztDDbVjxb3OA1M5XGYn63wuGjxgVKmTgw8Z0soyJ/GsjSwE+wIRM/PK1030UXRxEaM75wTuiR4TThpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunyoo.cc; spf=pass smtp.mailfrom=yunyoo.cc; dkim=pass (2048-bit key) header.d=yunyoo-cc.20200929.dkim.larksuite.com header.i=@yunyoo-cc.20200929.dkim.larksuite.com header.b=EQrGrWaT; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunyoo.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunyoo.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunyoo-cc.20200929.dkim.larksuite.com header.i=@yunyoo-cc.20200929.dkim.larksuite.com header.b="EQrGrWaT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=yunyoo-cc.20200929.dkim.larksuite.com; t=1772404599;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HGNPxjZdXQ0CIKGWXj8Xf/gkL80A5tRaqqvffEvQZ9U=;
 b=EQrGrWaTilohqNt2Vh1xjnci6xCRGHpfXASV+/rinRP6bM6x/mIJOtjDLHFN/EXAkCwlBy
 xE2MRijHzRIK4KzBBxQVjdpHFEvdt1LjvK67KjQE3haeMgFB1YorOuzQ5PIcNUgXJUpIb2
 Qezm/p/5iHmkt+ThAdbZs+IONi6lhFlGClnjPHf6195QAIDt7qe310HGLfEimsg6j19d1s
 CRFQRjzecJISHF2UymC56vPcIKmp+GUYaRBX+JF5aN4nUDNXJfcZdI7LcqiKMe8L/9SVm8
 LY3S8xObkwHKnyyhyIXpcVI/rHx1NpRj242Cy+LzRUaKFlgKXWKuziHvdOyMPg==
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [BUG] vhost_net: livelock in handle_rx() when GRO packet exceeds virtqueue capacity
From: "ShuangYu" <shuangyu@yunyoo.cc>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+169a4bf77+e484c9+lists.linux.dev+shuangyu@yunyoo.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>
Message-Id: <9ac0a071e79e9da8128523ddeba19085f4f8c9aa.decbd9ef.1293.41c3.bf27.48cdc12b9ce6@larksuite.com>
Date: Sun, 01 Mar 2026 22:36:39 +0000

Hi,

We have hit a severe livelock in vhost_net on 6.18.x. The vhost
kernel thread spins at 100% CPU indefinitely in handle_rx(), and
QEMU becomes unkillable (stuck in D state).
[This is a text/plain messages]

Environment
-----------
=C2=A0 Kernel:=C2=A0 6.18.10-1.el8.elrepo.x86_64
=C2=A0 QEMU: =C2=A0=C2=A0 7.2.19
=C2=A0 Virtio:=C2=A0 VIRTIO_F_IN_ORDER is negotiated
=C2=A0 Backend: vhost (kernel)

Symptoms
--------
=C2=A0 - vhost-<pid> kernel thread at 100% CPU (R state, never yields)
=C2=A0 - QEMU stuck in D state at vhost_dev_flush() after receiving SIGTERM
=C2=A0 - kill -9 has no effect on the QEMU process
=C2=A0 - libvirt management plane deadlocks ("cannot acquire state change l=
ock")

Root Cause
----------
The livelock is triggered when a GRO-merged packet on the host TAP
interface (e.g., ~60KB) exceeds the remaining free capacity of the
guest's RX virtqueue (e.g., ~40KB of available buffers).

The loop in handle_rx() (drivers/vhost/net.c) proceeds as follows:

=C2=A0 1. get_rx_bufs() calls vhost_get_vq_desc_n() to fetch descriptors.
=C2=A0=C2=A0=C2=A0 It advances vq->last_avail_idx and vq->next_avail_head a=
s it
=C2=A0=C2=A0=C2=A0 consumes buffers, but runs out before satisfying datalen=
.

=C2=A0 2. get_rx_bufs() jumps to err: and calls
=C2=A0=C2=A0=C2=A0 vhost_discard_vq_desc(vq, headcount, n), which rolls bac=
k
=C2=A0=C2=A0=C2=A0 vq->last_avail_idx and vq->next_avail_head.

=C2=A0=C2=A0=C2=A0 Critically, vq->avail_idx (the cached copy of the guest'=
s
=C2=A0=C2=A0=C2=A0 avail->idx) is NOT rolled back. This is correct behavior=
 in
=C2=A0=C2=A0=C2=A0 isolation, but creates a persistent mismatch:

=C2=A0=C2=A0 =C2=A0=C2=A0 vq->avail_idx =C2=A0 =C2=A0=C2=A0 =3D 108=C2=A0 (=
cached, unchanged)
=C2=A0=C2=A0 =C2=A0=C2=A0 vq->last_avail_idx =3D 104=C2=A0 (rolled back)

=C2=A0 3. handle_rx() sees headcount =3D=3D 0 and calls vhost_enable_notify=
().
=C2=A0=C2=A0=C2=A0 Inside, vhost_get_avail_idx() finds:

=C2=A0=C2=A0 =C2=A0=C2=A0 vq->avail_idx (108) !=3D vq->last_avail_idx (104)

=C2=A0=C2=A0=C2=A0 It returns 1 (true), indicating "new buffers available."
=C2=A0=C2=A0=C2=A0 But these are the SAME buffers that were just discarded.

=C2=A0 4. handle_rx() hits `continue`, restarting the loop.

=C2=A0 5. In the next iteration, vhost_get_vq_desc_n() checks:

=C2=A0=C2=A0 =C2=A0=C2=A0 if (vq->avail_idx =3D=3D vq->last_avail_idx)

=C2=A0=C2=A0=C2=A0 This is FALSE (108 !=3D 104), so it skips re-reading the=
 guest's
=C2=A0=C2=A0=C2=A0 actual avail->idx and directly fetches the same descript=
ors.

=C2=A0 6. The exact same sequence repeats: fetch -> too small -> discard
=C2=A0=C2=A0=C2=A0 -> rollback -> "new buffers!" -> continue. Indefinitely.

This appears to be a regression introduced by the VIRTIO_F_IN_ORDER
support, which added vhost_get_vq_desc_n() with the cached avail_idx
short-circuit check, and the two-argument vhost_discard_vq_desc()
with next_avail_head rollback. The mismatch between the rollback
scope (last_avail_idx, next_avail_head) and the check scope
(avail_idx vs last_avail_idx) was not present before this change.

bpftrace Evidence
-----------------
During the 100% CPU lockup, we traced:

=C2=A0 @get_rx_ret[0]: =C2=A0 =C2=A0=C2=A0 4468052 =C2=A0 // get_rx_bufs() =
returns 0 every time
=C2=A0 @peek_ret[60366]: =C2=A0=C2=A0 4385533 =C2=A0 // same 60KB packet se=
en every iteration
=C2=A0 @sock_err[recvmsg]: =C2=A0 =C2=A0 =C2=A0=C2=A0 0 =C2=A0 // tun_recvm=
sg() is never reached

vhost_get_vq_desc_n() was observed iterating over the exact same 11
descriptor addresses millions of times per second.

Workaround
----------
Either of the following avoids the livelock:

=C2=A0 - Disable GRO/GSO on the TAP interface:
=C2=A0=C2=A0 =C2=A0 ethtool -K <tap> gro off gso off

=C2=A0 - Switch from kernel vhost to userspace QEMU backend:
=C2=A0=C2=A0 =C2=A0 <driver name=3D'qemu'/> in libvirt XML

Bisect
------
We have not yet completed a full git bisect, but the issue does not
occur on 6.17.x kernels which lack the VIRTIO_F_IN_ORDER vhost
support. We will follow up with a Fixes: tag if we can identify the
exact commit.

Suggested Fix Direction
-----------------------
In handle_rx(), when get_rx_bufs() returns 0 (headcount =3D=3D 0) due to
insufficient buffers (not because the queue is truly empty), the code
should break out of the loop rather than relying on
vhost_enable_notify() to make that determination. For example, when
get_rx_bufs() returns r =3D=3D 0 with datalen still > 0, this indicates a
"packet too large" condition, not a "queue empty" condition, and
should be handled differently.

Thanks,
ShuangYu
