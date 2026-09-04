Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3333E9C17
	for <virtualization@lists.linux.dev>; Fri,  4 Sep 2026 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510773; cv=none; b=e2ZURSf6gWYHt1I9OWPIYCnM8ESyo5l5sxQKfU4eQ6FXxQ7kp9hqLpLBjE5dKOhMBLDHpRObG2E07XYVX5cM6vJzTy+sxDwOU7lAvbDqeZ89EkVjs8i23KPjxh49EKak2Ja3ruxGVZEa02gRUD4TkolqM+kyQWFsULFLVot8xwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510773; c=relaxed/simple;
	bh=Ahw6wBEKNtTlAzOtcfQNRATqLy2rhl407J4BvoOAfto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DI3IL2pZZsIBQHsO6BtxznzC8TMm3+hXS/QBCwK0UYRMrfCZmeDWN9r6U+xVFW0nhQ92mA+nATc0CQ8AYOTVMf7f+4ME9//7zFH/k8y1yUklSnWzHOoaM0cWPTs9WMhI52qoYtgfrju7EkqBkxtupsEkENnZrCCKc9OWHhScz9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdyjWnSd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdyjWnSd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788510763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo/JdE2qjgzdLPCSAqv7/9YfgLW5yQ3+SS/a1FYjyLo=;
	b=ZdyjWnSdE/0n6jjpaxOkoWVsgneqJgMgpW8gPYTn4TVzDVpT2C7e0Zc8nY7SWI53qzKfSM
	CEiv7qS+yER5D+MNKiJH6gP4Fh+c4BZa4AjhrwCBtRSDbdeYkPyp2LaTRmscuMiarAFhj4
	zd4MQWHfiqaWYHt+2+btNNJGuwnZuQA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-0EhBqcVSMeeVIjdlGbVA2A-1; Fri, 04 Sep 2026 04:32:39 -0400
X-MC-Unique: 0EhBqcVSMeeVIjdlGbVA2A-1
X-Mimecast-MFC-AGG-ID: 0EhBqcVSMeeVIjdlGbVA2A_1788510758
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f4bff865cso407701f8f.0
        for <virtualization@lists.linux.dev>; Fri, 04 Sep 2026 01:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510758; x=1789115558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Vo/JdE2qjgzdLPCSAqv7/9YfgLW5yQ3+SS/a1FYjyLo=;
        b=ny9fvsB+vuQpjFe3d5EOgM7xaKKTvK3VGal5Fbayydy0gVIvRCppQoOc5hZDI71OnQ
         eGJH81vtXd7pKJ+bgztTWzmrXq3bgdQlEsQdNuO9kpmTCiu75cIfWMO3rywoghWxsAac
         8UrqGBXmv59sb73a8XX5UrKVN9wuvrgarfyH8x4K5Ouc5hcLkVSROoK6M+1QuLUF0hT4
         ruLcsPKhpoWEOMfIV5WHZDdZPqwjviPEtA+bYzRyAGyu59iAOx1u1JC0soTgk+ZZFcJD
         E65Ux3fKa85cxVmNxG32cDkIrjNUoZwoa0Syrq+Ong0xSq2lvPiTYUp/rc/K+KYfpp2q
         yaPw==
X-Forwarded-Encrypted: i=1; AKwUvBzfI4fNhIs0MP5oqA9ZEcNqhPpnxp8eXcaiIjJV2jHKkZZh6LLkzwqekIQnB3z6Tx/QuzvkgHrEi2YQoxNOPw==@lists.linux.dev
X-Gm-Message-State: AFuF++mNSPKt+bS0ETGT8zqT+FGcYpo4cO6HoodSC4OO4EAZ4hJnQ41J
	I+k4yqUloyhw5drh/iKIqV5orSKkDkmWvyT1V923A47v3eGcrgTDL0ndTVzqXwOpN9UiKqPRFST
	O58Aaia8uLmLJ8cJn8RnuoauvMDMspEX9NVwgaj+zqyFdrzZEvvxh8IhFYKbDqeN/gDRD
X-Gm-Gg: AYBFou3RDM3zTHLsfLofDILs5YUAxI1X1Gby3skac0ku9+1l1+sF7eqIIjkwMhmKvHe
	UpH3wF05rPZf58RJu/HYgRitF99SIrp5E+vKLdicn2AIxvQA32GivQgSOBMag07kGJvYdbv+Kfd
	cWcQOQ5Fu2rboZEZKSjHDVBzAIazTRRcnsT+xC/0SyMY7JrpJ3quxu1nWIe0QcJIC0BwYj8/7Oc
	OqcyKGEUVQwv5lQk8Wa8vijAVP6MNZBvN92z3IFIscX9sLMWm6uDTElKVzKgXNJjflqH8t5ir/+
	1K/EXd1G1aVb8NtCdwrDSocuLGAd6GTJHvLNIGeqbGy2ymkr8dYNdLmkCl/G4X+SRzImak7xsWf
	zVYTxnSNyIkc6ulNvP3ClL5x8pqZyirc1S1AmSvd1lu1U9g==
X-Received: by 2002:a05:6000:29d9:b0:484:3310:710f with SMTP id ffacd0b85a97d-485872934dcmr6156595f8f.27.1788510758202;
        Fri, 04 Sep 2026 01:32:38 -0700 (PDT)
X-Received: by 2002:a05:6000:29d9:b0:484:3310:710f with SMTP id ffacd0b85a97d-485872934dcmr6156500f8f.27.1788510757635;
        Fri, 04 Sep 2026 01:32:37 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883bbcddsm4745418f8f.20.2026.09.04.01.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:32:37 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:32:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vhost/vsock: batch RX used-ring updates
Message-ID: <app1fIXbKd5xOFK3@sgarzare-redhat>
References: <20260904012537.503230-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260904012537.503230-1-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tYrlNLiWYRasQkOj3w6AMZzmI9-6E82j9pGsrplTLiM_1788510758
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 04, 2026 at 09:25:37AM +0800, Jia Jia wrote:
>vhost_transport_do_send_pkt() calls vhost_add_used() for every Guest RX
>buffer even though it delays the Guest signal until the worker finishes.
>Each call publishes one used entry and updates the used index separately.
>
>Collect the completed buffer heads in the arrays already allocated for the
>virtqueue and publish them with vhost_add_used_n().  Bound the batch by the
>ring size, array capacity, and worker packet budget.  Flush before
>re-enabling notifications or leaving the worker.
>
>Each used entry describes one completed RX buffer and keeps its actual used
>length, so set nheads to 1 for every entry.  This patch does not change
>negotiated features or compress multiple buffers into one used entry.
>
>This patch is limited to the current skb-based vhost-vsock RX path.
>
>Performance:

It's great to include the performance metrics in the commit, and thanks 
for that, but I don't think we need all this AI slop that follows, 
please summarize it.

>
>Tested with a QEMU/KVM guest on a host with 4 online CPUs, using 2 vCPUs
>pinned to host CPUs 2 and 3, QEMU 10.2.1, q35, 1536 MiB, and Linux
>7.2.0-rc3-next-20260713-next-debug-kasan.  The vhost-vsock source is based
>on linux-next master at 49362394dad7df66c274c867a271394c10ca2bb8.
>

e.g. from here...

>Current vhost-vsock does not implement VIRTIO_F_IN_ORDER or
>VIRTIO_F_RING_PACKED, so both configurations used packed=off and
>in_order=off:
>
>  baseline:                 RX batching=off
>  vhost-vsock RX batching:  RX batching=on

... to here, can be removed.

>
>The test used vsock_perf.  The Guest receiver was started with:
>
>  vsock_perf --port PORT --buf-size 64M --vsk-size 64M --rcvlowat 1
>
>The Host sender was started with:
>
>  vsock_perf --sender 3 --port PORT --bytes BYTES \
>      --buf-size SEND_BUF --vsk-size 64M
>
>Each workload transferred BYTES=1 GiB.  The SEND_BUF values were 256 B
>(SEND_BUF=256), 512 B (SEND_BUF=512), 4 KiB (SEND_BUF=4K), and 64 KiB
>(SEND_BUF=64K).

Put `1 GiB` directly after --bytes, no?

About SEND_BUF values, use SEND_BUF in the table header, and remove the
text here.

>Each state used a fresh Guest.  Each workload uses 20 paired runs, with 10
>runs in each order.  The reported values are
>Guest RX throughput in Gbits/s.  The baseline and batching columns are the
>geometric means over the 20 runs; change is batching / baseline - 1,
>computed from the unrounded values:

Ditto, summarize or remove (e.g. Gbits/s can be put in the table 
header).

>
>  workload   baseline RX    batching RX   change   faster
>  256 B      0.0795724      0.0831509      +4.497%  20/20
>  512 B      0.1194885      0.1210297      +1.290%  14/20
>  4 KiB      0.7208273      0.7242053      +0.469%  11/20
>  64 KiB     2.1712797      2.1951941      +1.101%  13/20
>

What about the latency?

>For reference, the table below gives the 95% normal-approximation intervals
>obtained from the 20 paired log(batching / baseline) values:
>
>  workload   paired 95% interval
>  256 B      +3.985% to +5.011%
>  512 B      +0.206% to +2.385%
>  4 KiB      -1.442% to +2.416%
>  64 KiB     -1.474% to +3.745%
>
>All transfers passed byte-count checks, and no kernel errors were observed
>in the logs.  The 256-byte workload improved in every pair.  The 512 B
>workload was faster in 14 of 20 pairs, with a small gain.  The 4 KiB and
>64 KiB workloads showed no material throughput change; the difference
>between their results may be due to scheduling and execution variation.

All this text can be removed, it's clear from the table, no?

>
>The Guest RX throughput results above are the primary performance
>measurement. For additional Host-side context, I measured the vhost
>worker thread servicing the vhost-vsock RX queue in a separate set of
>10 paired runs, with five runs in each AB/BA order. Counters were
>normalized by the verified transferred GiB and summarized using
>geometric means. Worker cycles/GiB improved by 3.846%, 2.162%, and
>4.109% for 256 B, 4 KiB, and 64 KiB, respectively. The corresponding
>worker instructions/GiB improvements were 2.548%, 2.084%, and 4.637%.
>The patched implementation used fewer cycles in 10/10, 8/10, and
>10/10 paired runs, respectively, and fewer instructions in 10/10
>paired runs for all three workloads. This measures the complete vhost
>worker thread during the transfer, rather than an individual helper
>function, and is supplementary to the Guest RX throughput results.

Please, summarize.

>
>Link: https://lore.kernel.org/r/20181214082146-mutt-send-email-mst@kernel.org

You put this link, but you didn't explain why...

>Link: https://lore.kernel.org/r/20220901055434.824-4-qtxuning1999@sjtu.edu.cn

Ditto.

>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>Acked-by: Eugenio Pérez <eperezma@redhat.com>
>---
>Changes in v3:
>- Add supplementary Host-side perf measurements for the complete
>  vhost worker thread during the transfer.
>---
> drivers/vhost/vsock.c | 53 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 51 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..9e72c67c287f 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -103,12 +103,35 @@ static bool vhost_transport_has_remote_cid(struct vsock_sock *vsk, u32 cid)
> 	return found;
> }
>
>+static bool vhost_vsock_flush_used(struct vhost_virtqueue *vq,
>+				   unsigned int used_count)
>+{
>+	if (!used_count)
>+		return false;
>+
>+	vhost_add_used_n(vq, vq->heads, vq->nheads, used_count);
>+	return true;
>+}
>+
>+static void vhost_vsock_add_used(struct vhost_virtqueue *vq,
>+				 unsigned int used_count,
>+				 unsigned int head, unsigned int len)
>+{
>+	struct vring_used_elem *used = &vq->heads[used_count];
>+
>+	used->id = cpu_to_vhost32(vq, head);
>+	used->len = cpu_to_vhost32(vq, len);
>+	vq->nheads[used_count] = 1;
>+}

Would it be better to move these functions to vhost.c?
(not a strong opinion)

>+
> static void
> vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			    struct vhost_virtqueue *vq)
> {
> 	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
> 	int pkts = 0, total_len = 0;
>+	unsigned int used_count = 0;
>+	unsigned int used_limit;
> 	bool added = false;
> 	bool restart_tx = false;
>
>@@ -120,6 +143,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 	if (!vq_meta_prefetch(vq))
> 		goto out;
>

Can you add a comment whith the reason of this limit?

>+	used_limit = min_t(unsigned int, vq->num,
>+			   min_t(unsigned int, vq->dev->iov_limit,
>+				 vq->dev->weight));

Why adding `vq->dev->weight` in the limit, the loop is already limited
by that, no?

(this is why a comment here is needed...)


>+	if (unlikely(!used_limit))
>+		goto out;
>+
> 	/* Avoid further vmexits, we're already processing the virtqueue */
> 	vhost_disable_notify(&vsock->dev, vq);
>
>@@ -134,9 +163,20 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		u32 offset;
> 		int head;
>
>+		if (used_count == used_limit) {
>+			if (vhost_vsock_flush_used(vq, used_count)) {
>+				added = true;
>+				used_count = 0;
>+			}
>+		}

Can we move this in the vhost_vsock_add_used() or just after calling it?
IMO, it's easier to read: add something, check if I've reached the
limit, then flush.

>+
> 		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
>
> 		if (!skb) {
>+			if (vhost_vsock_flush_used(vq, used_count)) {
>+				added = true;
>+				used_count = 0;
>+			}

Why you need this, if after the loop we are calling
vhost_vsock_flush_used() in any case?

> 			vhost_enable_notify(&vsock->dev, vq);
> 			break;
> 		}
>@@ -153,6 +193,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			/* We cannot finish yet if more buffers snuck in while
> 			 * re-enabling notify.
> 			 */

Move the comment or update it explaining why we are flushing.

>+			if (vhost_vsock_flush_used(vq, used_count)) {
>+				added = true;
>+				used_count = 0;
>+			}
> 			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
> 				vhost_disable_notify(&vsock->dev, vq);
> 				continue;
>@@ -230,8 +274,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		 */
> 		virtio_transport_deliver_tap_pkt(skb);
>
>-		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
>-		added = true;
>+		vhost_vsock_add_used(vq, used_count, head,
>+				     sizeof(*hdr) + payload_len);
>+		used_count++;
>
> 		VIRTIO_VSOCK_SKB_CB(skb)->offset += payload_len;
> 		total_len += payload_len;
>@@ -264,6 +309,10 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			virtio_transport_consume_skb_sent(skb, true);
> 		}
> 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));

Please leave a blank line here.

>+	if (vhost_vsock_flush_used(vq, used_count)) {
>+		added = true;
>+		used_count = 0;

Why setting this here that we are going to exit?

IMO this can be simplified in:
	added |= vhost_vsock_flush_used(vq, used_count);

or you can collapse this in the check for the vhost_signal:

	if (vhost_vsock_flush_used(vq, used_count) || added)
		vhost_signal(&vsock->dev, vq);

>+	}

Please leave a blank line here.

Stefano

> 	if (added)
> 		vhost_signal(&vsock->dev, vq);
>
>-- 
>2.34.1
>

