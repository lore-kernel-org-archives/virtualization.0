Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368304;
	b=H3HTsmJpImj9wi3ag2VFmdn+2EM/NMPpICrvIzfhFNMbUweQN1GDeTKUXPvDqHtpPApw
	 KwGh2S8kvWhENKku/yt8BLeofU6KMhtF+M6YrR14yIAxAIGo5+hYUxlN0n6MmLUVjIxps
	 l5LJSLwDbqSXuvC7nWESUawIRrV3Wa7lWgOSsZsSaBi6pMgdDKqJMY/DBeep33V1am8Is
	 /BGbigUrGsfy5xQb8t4A3mkZIufp5v9ze6rBI/iMgopP2jboLvV3H9qYWLPHPobicvdmb
	 QaOkWJD+czoJ48QE9XZcyJXW2yd+6iEUHqONytyG/AMeHdVh5pb58UgzEzWXij6zI+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368304;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=szKIQcK4Y6tUERhcrUwO9hhUFFsNv+m6pizPQ1yqDLY=;
	b=a//MNuVgyB/jlWItyWkG/LzTr7ffS+gFp15LYU+fw3opQvWUYUXRBfTcsndDjn1Doxk0
	 Ia+8eVUCZpWQHlBNRLOB8P+MvDpGhALfoKn3SsTkdji7N3UF1oH4IuW5xjpOQn8+BbdEI
	 cjLiGgf9yM3phSp8pcvKR+0yO8BbwAdkVy2BtTvgXsKuEYRIikK16a47BEcBaY1mAIS3d
	 eG1STN/6PqxsPEtjmgBZPnGXR2lywEGUyJ5FIbbfU0v5EY7cat7q5AyJhl3+BoJQNSfZ6
	 u5e+Di3SRcO2GMt4rvZcSOV4XbpErZA8HujUPbj/g0x/hwFZSQVMI8a7mcN0j7pm9fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FMj5serz;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197160A2611
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 13:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4197160A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FMj5serz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793368297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=szKIQcK4Y6tUERhcrUwO9hhUFFsNv+m6pizPQ1yqDLY=;
	b=FMj5serzxDqBj9KR8LrACCvHjLvT9rr1e7Apz9BFwJZXFk9tRqbfjDLMGgldY8y1I71uUE
	2b1evTuwV55Q9Kcu5eWR6npqj/oTrj3WPIK3pWW3SpUopqdbzJNc/SBJLW1I6Gqc0f5FVj
	4q3W9vptWJ9pitfvgaHoO6NjVuj4XiM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-QOfXeAQuPX6aH__Om2RYcw-1; Fri, 30 Oct 2026 09:51:33 -0400
X-MC-Unique: QOfXeAQuPX6aH__Om2RYcw-1
X-Mimecast-MFC-AGG-ID: QOfXeAQuPX6aH__Om2RYcw_1793368293
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a2063be141so6636515e9.1
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 06:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368292; x=1793973092;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=szKIQcK4Y6tUERhcrUwO9hhUFFsNv+m6pizPQ1yqDLY=;
        b=EN0V4ybHYUbyUisrcv9IO2KiX36sim/SwB7/BYr2z83T3cZachMk1ni67TUkyZragd
         /MhLte/Ruzs8ns7Qur6UGxqp5DMRNJjMmb0MO/aG1vrgpN8/vQCvCl8gPibFwzZPThDd
         /Sk5XuwDlQ8t6BDf4gR1Pr0mpw1iKrOFH0mcqOvGMGNN+0q1iH2CFRgtdlNFApU3CcnF
         JV18GNsGwJye3mbN24Wz4C7jGF7+tJgU64tiSKWFY73/L2lKXF8INs/hBx3Ol0QP25jk
         3yJ2HluuZY6J6zwvAlPAzPfHOWOOeLpUhe+5Hzvm7Q3iZWivro67/2ZJNi+gsssvxQKp
         j/Wg==
X-Forwarded-Encrypted: i=1; AKwUvBwCEehZW4F8rgCspL1Nxk3rfWe52WaUkMbyAxRWZ0yCtfscIPNkHHXQphXE8wgtpZotvAXEQhaxYarXOwGvaw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLu3Ldwl7kwdQOcgQCvNPxOBDOwIjZYK/DXW/GyezKeRmcYaTCU
	WIJqbeU4SpXuKmBZL4k2zetgjntfXZr0BP+VonTXja/AzKRgks5VCmZVtxQNakSzKPuBLrcuptc
	roZtGKurkxB4oP/o9sp47PM4nAUmhyQVJ2dKNN4Dmen+v5gMOmTsH0/RKFbmKHvhRQ0WlrNjXh9
	po
X-Gm-Gg: AYBFou1S9JvEiR/SmXS7Kyx0v9ygdAZ5ZBYr+jr+I4UYFHmt1zkmbxnvnqDhZkow0WZ
	OKHPFier+GdTTj0PAMO8d6NuvfywY7xOtrrzL4lgz7dMqhc66toYdXxjmQQxlQPn89o67ncbozF
	I/5Hj1E1neALr3E6cAU1drL7y8py1PP/4hJxs/S5DAGXPHEcR3DOMBqo6ide5dGN0tiFOlzAZhG
	mo32sQP9RaY1eObGBJviiyCgbQdrNsjUEwgpcVoIQIlA6M5iy8Fzg0eQVufWFjF9lvlPrsNfHP5
	mCnRdDSxlPyKhpJmMYrYxaTLvF2y1TzNOTQt/Odt8mldzXOjhP1+8Fyh3nJH7G5V4T6/+kqWR1v
	SENXTLwbWZZlsU7c2PczhDYjcQ9yLYIz7ZQetrDGZjR4Q7FhzCXKCN9cLyuU8IT9Ex4GpcUIcXd
	rf8l3OFdIt341O8Jw=
X-Received: by 2002:a05:600c:8183:b0:4a1:f9e6:f418 with SMTP id 5b1f17b1804b1-4ac19802178mr43295555e9.34.1793368292579;
        Fri, 30 Oct 2026 06:51:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8183:b0:4a1:f9e6:f418 with SMTP id 5b1f17b1804b1-4ac19802178mr43295065e9.34.1793368292109;
        Fri, 30 Oct 2026 06:51:32 -0700 (PDT)
Received: from sgarzare-redhat (ip190-139-192-82.pool-bba.aruba.it. [82.192.139.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80ecbsm3458621f8f.35.2026.10.30.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:51:31 -0700 (PDT)
Date: Fri, 30 Oct 2026 14:51:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Message-ID: <auSZtMqcTz3r1nRk@sgarzare-redhat>
References: <20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _KaUYT7n5MjvwZsqmhffogw8v5wPJdgfgtwKOhsXKlQ_1793368293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 28, 2026 at 07:22:43PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>virtio_vsock_vqs_del() frees the virtqueues via del_vqs() but never
>clears vsock->vqs[]. If a later virtio_vsock_restore() fails to
>reallocate them (its error path is a bare "goto out" that only unlocks
>and returns), the driver is left bound with a dangling vqs[]. The next
>virtio_vsock_vqs_del() - on a second freeze or on remove/unbind - then
>passes a freed vring_virtqueue to virtqueue_detach_unused_buf(), a slab
>use-after-free. KASAN on a guest with a virtio-vsock device on
>virtio-pci, after a restore made to fail by fault injection:
>
>  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>  Read of size 4 at addr ... by task repro
>   virtqueue_detach_unused_buf
>   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
>   virtio_vsock_remove
>   virtio_dev_remove
>   ... unbind_store
>  Freed by task ...:
>   kfree
>   vp_del_vqs
>   virtio_vsock_freeze          <- the preceding freeze freed the vq
>  Allocated by task 1:
>   vring_create_virtqueue
>   virtio_vsock_vqs_init
>   virtio_vsock_probe           <- original allocation at probe
>
>That second virtio_vsock_vqs_del() also repeats del_vqs(), which not
>every transport tolerates. virtio-mmio's vm_del_vqs() always ends in
>free_irq(), but after the failed vm_find_vqs() the device no longer
>holds its IRQ, so on virtio-mmio the second call also warns:
>
>  Trying to free already-free IRQ 51
>  WARNING: kernel/irq/manage.c:1894 at free_irq+0x23e/0x840
>   vm_del_vqs
>   virtio_vsock_vqs_del
>   virtio_vsock_remove          (or virtio_vsock_freeze)
>
>virtio-pci's vp_del_vqs() is idempotent, so the PCI case shows only
>the use-after-free.
>
>Clear vsock->vqs[] after del_vqs() and when virtio_find_vqs() fails in
>virtio_vsock_vqs_init(), and treat an empty vqs[] as "no virtqueues
>are live": virtio_vsock_vqs_del() then still resets the device
>(virtio_dev_remove() expects a reset device) and purges the send
>queue, but skips the detach loops and del_vqs(). find_vqs() cleans up
>after itself on failure, so skipping the second del_vqs() leaks
>nothing. Clearing the stale pointers follows virtio_blk
>commit 0739c2c6a015 ("virtio_blk: NULL out vqs to avoid double free on
>failed resume").
>
>The use-after-free was found with the help of an LLM coding assistant
>(Anthropic's Claude); the free_irq() warning on virtio-mmio was reported
>by the netdev Sashiko AI review of an earlier version of this patch.
>
>Testing: on a private VM with a KASAN fuzz kernel, over virtio-pci and
>over virtio-mmio (QEMU microvm). The restore allocation failure was
>forced with CONFIG_FAILSLAB steered by the fault-injection stacktrace
>filter to the virtio-vsock restore path only; a guest-root program
>drives a pm_test=devices freeze/restore cycle (so .restore returns
>-ENOMEM) and then unbinds the device, or runs a second freeze/restore
>cycle. Without a fix (v7.3-rc5 based) the PCI run reports the
>slab-use-after-free above. With only the vqs[] clearing (v1 of this
>patch, on net 363c8c79220d) the MMIO runs report the free_irq warning on
>remove and on the second freeze. With this patch on the same base,
>restore still fails with -ENOMEM on both transports and neither report
>appears; the device works again after a second, successful
>freeze/restore cycle and after unbind/bind, and a normal freeze/restore
>and unbind/bind still leave a working device. A find_vqs() failure after
>some virtqueues were set up was not exercised (each restore attempt
>failed at its first allocation, before any virtqueue was set up); that
>clear is covered by code reading only. The three single-VM tests of
>tools/testing/selftests/vsock/vmtest.sh (vm_server_host_client,
>vm_client_host_server, vm_loopback; 44 vsock_test cases each) pass on
>this tree, as on net; on both kernels the host-side runs skip the SO_INQ
>cases (SO_INQ not supported by the host kernel). The ns_* tests of
>vmtest.sh were not run (they need root on the host). checkpatch.pl
>--strict is clean and the fuzz-config build is warning-free. The

Do we really need to write in a commit message that checkpatch.pl 
--strict is clean?

Descriptive commits are great, but we're going a bit too far here. 
Please include only the relevant information; for example, I think the 
part after "Testing:" could be summarized in a few lines or removed 
altogether.

>reproducer needs guest root, CONFIG_FAILSLAB with
>CONFIG_FAULT_INJECTION_DEBUG_FS and
>CONFIG_FAULT_INJECTION_STACKTRACE_FILTER, and CONFIG_HIBERNATION with
>CONFIG_PM_DEBUG for pm_test; it is available on request.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>The use-after-free was found with the help of Anthropic's Claude; the
>virtio-mmio warning comes from the netdev Sashiko review.

This is already in the commit description, no?

>
>Changes in v2:
>- Skip the detach loops and del_vqs() in virtio_vsock_vqs_del() when no
>  virtqueues are live, so the teardown after a failed restore does not
>  free virtio-mmio's IRQ a second time (Sashiko review).
>- Use an empty vqs[] as the 'no live virtqueues' marker instead of v1's
>  per-loop NULL checks, and purge the send queue before the early
>  return.
>- Commit message: cite only virtio_blk 0739c2c6a015; drop the wrong
>  virtio_rtc and virtio_console references (Sashiko review). Drop the
>  commit ID from the code comment.
>- Tested on virtio-mmio (QEMU microvm) as well as virtio-pci.
>- Drop the Assisted-by trailer (removed upstream); tool use is
>  disclosed above instead.
>- Link to v1: https://patch.msgid.link/20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de
>---
> net/vmw_vsock/virtio_transport.c | 24 +++++++++++++++++++++---
> 1 file changed, 21 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 4f9aa9c4c3aa..bba594b7fc14 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -714,8 +714,14 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> 	atomic_set(&vsock->queued_replies, 0);
>
> 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
>-	if (ret < 0)
>+	if (ret < 0) {
>+		/* On failure virtio_find_vqs() can leave freed virtqueues or
>+		 * error pointers in vsock->vqs[]. Clear it: an empty vqs[]
>+		 * tells virtio_vsock_vqs_del() that no virtqueues are live.
>+		 */
>+		memset(vsock->vqs, 0, sizeof(vsock->vqs));

Should we move this in the virtio_find_vqs() ?

Maybe not for this patch, but for long term it could be a good idea IMO.

> 		return ret;
>+	}
>
> 	virtio_vsock_update_guest_cid(vsock);
>
>@@ -781,6 +787,15 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> 	 */
> 	virtio_reset_device(vdev);
>
>+	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>+
>+	/* No virtqueues are live, e.g. after a failed restore: they were
>+	 * already deleted, and a second del_vqs() is not safe on every
>+	 * transport (virtio-mmio would free its IRQ again).
>+	 */
>+	if (!vsock->vqs[VSOCK_VQ_RX])
>+		return;
>+
> 	mutex_lock(&vsock->rx_lock);
> 	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
> 		kfree_skb(skb);
>@@ -791,10 +806,13 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> 		kfree_skb(skb);
> 	mutex_unlock(&vsock->tx_lock);
>
>-	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>-
> 	/* Delete virtqueues and flush outstanding callbacks if any */
> 	vdev->config->del_vqs(vdev);
>+
>+	/* The virtqueues are freed: clear the stale pointers, so that a
>+	 * virtio_vsock_vqs_del() after a failed restore skips them.
>+	 */
>+	memset(vsock->vqs, 0, sizeof(vsock->vqs));

Same above, should we introduce a virtio_del_vqs() to do both and call 
it in all drivers?

Or skip del_vqs() if vdev->vqs is empty.

I guess this issue could be spread around virtio drivers, so would be 
nice to add common API in the virtio core to be used in all of them.

That said, for a fix, this patch LGTM, my comments were more for a long 
term work.

With a fixed commit message I can give my R-b.

Thanks,
Stefano

> }
>
> static int virtio_vsock_probe(struct virtio_device *vdev)
>
>---
>base-commit: 363c8c79220d0db4d65dcd570529ddda15067cb5
>change-id: 20261001-vsock-restore-uaf-send-1fc7396fa1bd
>
>Best regards,
>--
>Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>

