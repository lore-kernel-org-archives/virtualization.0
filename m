Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B3126C03;
	Mon, 22 Jun 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136369; cv=none; b=hs0h96843aWUSPZepJMpvnYQg/lDN4Aqxx9rN/F/bbUpEOCGCaS7LClgWsfXre+aJazGTF0nbUrHAT8bCxm0Oy90OxnMklpOr8GKYOy8gGsM7w9hKPUZ7h/xyF8VPIuaNalnms34Q4Y+tFxP/lbh61jcoPGQ99dCRceh24BTbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136369; c=relaxed/simple;
	bh=i+4PIa9nnKr5zRuvdtKsaOE4IYUgiH16+VsHNMTmpVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEBjfJmru6NwFWJt7c57wmKaxXrd4POZZxzBmzGva25lyarbpXRD+sQCbz/ECKUVnHX76y4ZbqHisz1RKkNFxNerobU1tO3lvChJE0lExuYwwAFGKdt2VEdTEo5q6HOwbYjcoRDeBPx2RAZwpcYGz/5ZC595cU+a4P42JBl2sDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=openvz.org; spf=fail smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=gOKEZpvo; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gOKEZpvo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=ZzZhJjzPCf1evsfs7pcOY6+sEtdZrAbcbbddDBPWbyU=; b=gOKEZpvo3wac
	FkKBFDxz2DTf2yFzCfTxpP4a/1J3ptGqn7HIAgacaSZMucg0TbXo70hnxY9AI7B1Ok9UpqY/SFe32
	YNMrfa3DzoSZiT0Kg2V6uhfTxhncHeFKAwFc0lBQFNQOrsTH4cN/zZSmcJtHzgOHVxT3OEriQ8MBe
	o0bSuKYKGQ5BUYH9mPQuxq+l/JLRIBjuVITI+L8UGBs9F2X01+Ykd26TSH52BA22nBYZppPdO1rr1
	ntahlZyhaE44wZzKpF7/pI6a3TxRD7xeku5NGGQkMAliLAcPzlZZoAwJGjLd9lZgpTgkH4LZEDfGx
	91S5MXHkpbNjDGmDenPSuw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <den@openvz.org>)
	id 1wbepI-00FfsX-0M;
	Mon, 22 Jun 2026 15:37:07 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 0/2] virtio_balloon: quiesce balloon work on device shutdown
Date: Mon, 22 Jun 2026 15:37:13 +0200
Message-ID: <20260622133715.3707707-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()") the virtio bus breaks and resets every virtio device
during device_shutdown(), i.e. on reboot and kexec. virtio_balloon has no
.shutdown of its own, so that generic path runs while the balloon's
asynchronous work is still armed: the free page reporting worker, the
inflate/deflate and stats workers, the OOM notifier and the free page
shrinker.

Once the device has been broken, virtqueue_add_inbuf() in
virtballoon_free_page_report() returns -EIO and trips its WARN_ON_ONCE().
On a kernel booted with panic_on_warn that turns an ordinary reboot into a
fatal panic in the middle of device_shutdown(), so the machine never
reaches the new kernel. The inflate/deflate and OOM paths do not warn but
are no better off: they call wait_event(vb->acked, ...) and would block
forever on a queue that can no longer complete.

This was hit in the field as an intermittent failure of a virtualization
cluster upgrade: guest storage nodes were rebooted via kexec into the new
kernel, and the ones whose free page reporting happened to run during
device_shutdown() panicked (the guests run with panic_on_warn) and never
came back, stalling the rolling upgrade. The crash dump showed the WARN at
virtio_balloon.c:216 in a page_reporting kworker, with all the balloon
virtqueues already broken.

Patch 1 factors the teardown out of virtballoon_remove() into a
virtballoon_quiesce() helper (no functional change). Patch 2 adds a
virtio_balloon .shutdown handler that quiesces via that helper while the
device is still alive, then breaks and resets it the way the generic
virtio_dev_shutdown() would.

Relaxing the single WARN_ON_ONCE() instead was considered and rejected: it
would silence the panic but leave the inflate/deflate and OOM paths
hanging on the broken device. The device has to be quiesced, not just kept
quiet.

Validated by churning balloon inflate/deflate from the host while
kexec-rebooting the guest in a loop under panic_on_warn: the unpatched
module reproduces the WARN within a couple of cycles, while the patched
module survives many consecutive kexec cycles cleanly (12/12 in the final
run, 0 WARNs). checkpatch is clean on both patches.

Denis V. Lunev (2):
  virtio_balloon: factor out virtballoon_quiesce()
  virtio_balloon: quiesce balloon work before device shutdown

 drivers/virtio/virtio_balloon.c | 37 ++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

-- 
2.53.0

