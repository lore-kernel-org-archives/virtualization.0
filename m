Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591B2C9D
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772410212; cv=none; b=cYPdrMyCd4Hc35rYtQ8brkcTZFbGsDXv/akNfFu6xZL4vCMFKWWAVEV5IdwYApHbBCPB6QRZ1IQlEYZ4oxx1be4VOjzYAuyBrTcti5fhfNEZ4votkXInbwk8iMkDD1mgzCdKSyPu9QHofs8TKKZfvaXntM2mkYpuNGAwYBC3dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772410212; c=relaxed/simple;
	bh=d3go857C3XICc8MKrQoqnJS5JBMZD9L2ydEsTsmHHY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NRN2Pt7g77JqS9zhp/tGTyHnYunhuEXbbvXcjvHTiUSbfsYuQrpQBPe806icKLp6fwd3oHfKBK+vybrZgO8JcVyAgi1uvbhPC3+6wiSPSYmut858xpT+HFIXoW4rWpyQwvvb8qos+FesJ1GpYQvJ20HO/jvgxoPJq3jKC4mDWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxruV2Et; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxruV2Et"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772410209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpxCTRSJjeW1MLXWf2X8Dcr2BcSTB+ElcgetpkYQgRE=;
	b=JxruV2EtD+TTzdOO6A3UPzuUiy6FqJIZSodCGcBmx/sbafU3rtOitc0tHFX1IPIlfLHNOz
	tgeCuWeyTgCsaVlhnxg6BO7sot0xtcg1IPJNqI9ToYWZYrIuino35EIAWlKZeInV1UBGEC
	P8gAPD4dQTLi3R0SgSXv33uD5VnVePA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-dsYm-a5IPXawZdDAhzAscw-1; Sun, 01 Mar 2026 19:10:08 -0500
X-MC-Unique: dsYm-a5IPXawZdDAhzAscw-1
X-Mimecast-MFC-AGG-ID: dsYm-a5IPXawZdDAhzAscw_1772410207
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439b20722e3so288676f8f.0
        for <virtualization@lists.linux.dev>; Sun, 01 Mar 2026 16:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772410207; x=1773015007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpxCTRSJjeW1MLXWf2X8Dcr2BcSTB+ElcgetpkYQgRE=;
        b=alEtp9i/zVXIK4+EaI+/u2n5m/jztsNhKIZ39L6xyKwzHH1otpLgfvdRKfORr/3+3z
         iIMDUOdLYusxz+bSZ5Q1gAEKjj07HdSDR+VckIB63uAsYwuIf19cMdlTe5pYrQmGEyGS
         AUqDUFgB+xhJCWlHjtTPhHR6l3Hz5gd/aCLJlwr6qEpcSTn2wqrNe3DJ4fERAFoV2pQL
         t7g3JUuWMRHYxeOz4Lr+1pmZjHgvkRC2OUFjbv17XvPj8aIbgphb67fYsRohtJhOhXjr
         5ZBWCmaw1kMPrhamN2V1KQ3CJGM5PrpHj7b1B5az+wbqfXeSuM/SJ5ArGLPa24fZn2Wd
         AcBA==
X-Forwarded-Encrypted: i=1; AJvYcCV7RyBOIBgjrsCbnvtCWbo9XMRAR94LdQXAc6n2O41XDuymDHuU3R98PduGSGPAnYTu4EAMhwso9CeZsE+Wyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzksUtUbG+53kAmGCZxXoHbERwJuC4VBD3iVK31Y0HXs1PPn9YP
	VDSxDTI6yY8w8QmTttiXgmtS9ug3JXfQsb9lIk+r6VvH6KnENrDFL6Il4BbtrTbjuuseiQ4C+7Z
	fLzuLuyvik5cR68BxpbL0EYEFtetKkThMLY0VZPrvnXQc6uqROZHUCemb9oMDx9VHKLv0
X-Gm-Gg: ATEYQzzc/v8Zz6TPZjAZ+q3Qhjnu9Y3Zi+EBrj2DWqMCnWf9f6C0CbHA1TPRFOKQoxm
	C6JVC5KhPoR4bZctdbtSJDTrpufxzjdd/mvko5fVBuORRKo/pceLFP5q1NzFKPkzoRUrqTcxKOE
	7XGvrCLtGdYILD48CHOrsqLFVvr3oiorzkdCuhl9+itiIUlGamekhvWMaHVolboQMUd5vhgLbS3
	BUfR+rNdq7wAgDi3OyTSP/hYyQk/MyPNlznSMShO9DzXj6uwi1T6ETQK4ZVatGx/myfPbrzjIHD
	U/FsWNhLe7MowHyXTaopQk6QvDy4TsU/1FGOWPsfVF8Sk09Ixww589Ma0gFai0FckBZV7bTeoGM
	dza/Xn7BBX5KLbKhQc6rmj8MmBbWAD0/h7A4+O7dXWuDhaw==
X-Received: by 2002:a05:6000:1889:b0:439:afcc:8a2f with SMTP id ffacd0b85a97d-439afcc8ab6mr6991040f8f.18.1772410207233;
        Sun, 01 Mar 2026 16:10:07 -0800 (PST)
X-Received: by 2002:a05:6000:1889:b0:439:afcc:8a2f with SMTP id ffacd0b85a97d-439afcc8ab6mr6991008f8f.18.1772410206755;
        Sun, 01 Mar 2026 16:10:06 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a523sm23000888f8f.19.2026.03.01.16.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 16:10:05 -0800 (PST)
Date: Sun, 1 Mar 2026 19:10:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ShuangYu <shuangyu@yunyoo.cc>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [BUG] vhost_net: livelock in handle_rx() when GRO packet exceeds
 virtqueue capacity
Message-ID: <20260301190906-mutt-send-email-mst@kernel.org>
References: <9ac0a071e79e9da8128523ddeba19085f4f8c9aa.decbd9ef.1293.41c3.bf27.48cdc12b9ce6@larksuite.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9ac0a071e79e9da8128523ddeba19085f4f8c9aa.decbd9ef.1293.41c3.bf27.48cdc12b9ce6@larksuite.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7dBIRMbWU05tO-vnTG9m7CptwsgMXtp8nWNMghVv64Q_1772410207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Mar 01, 2026 at 10:36:39PM +0000, ShuangYu wrote:
> Hi,
> 
> We have hit a severe livelock in vhost_net on 6.18.x. The vhost
> kernel thread spins at 100% CPU indefinitely in handle_rx(), and
> QEMU becomes unkillable (stuck in D state).
> [This is a text/plain messages]
> 
> Environment
> -----------
>   Kernel:  6.18.10-1.el8.elrepo.x86_64
>   QEMU:    7.2.19
>   Virtio:  VIRTIO_F_IN_ORDER is negotiated
>   Backend: vhost (kernel)
> 
> Symptoms
> --------
>   - vhost-<pid> kernel thread at 100% CPU (R state, never yields)
>   - QEMU stuck in D state at vhost_dev_flush() after receiving SIGTERM
>   - kill -9 has no effect on the QEMU process
>   - libvirt management plane deadlocks ("cannot acquire state change lock")
> 
> Root Cause
> ----------
> The livelock is triggered when a GRO-merged packet on the host TAP
> interface (e.g., ~60KB) exceeds the remaining free capacity of the
> guest's RX virtqueue (e.g., ~40KB of available buffers).
> 
> The loop in handle_rx() (drivers/vhost/net.c) proceeds as follows:
> 
>   1. get_rx_bufs() calls vhost_get_vq_desc_n() to fetch descriptors.
>     It advances vq->last_avail_idx and vq->next_avail_head as it
>     consumes buffers, but runs out before satisfying datalen.
> 
>   2. get_rx_bufs() jumps to err: and calls
>     vhost_discard_vq_desc(vq, headcount, n), which rolls back
>     vq->last_avail_idx and vq->next_avail_head.
> 
>     Critically, vq->avail_idx (the cached copy of the guest's
>     avail->idx) is NOT rolled back. This is correct behavior in
>     isolation, but creates a persistent mismatch:
> 
>       vq->avail_idx      = 108  (cached, unchanged)
>       vq->last_avail_idx = 104  (rolled back)
> 
>   3. handle_rx() sees headcount == 0 and calls vhost_enable_notify().
>     Inside, vhost_get_avail_idx() finds:
> 
>       vq->avail_idx (108) != vq->last_avail_idx (104)
> 
>     It returns 1 (true), indicating "new buffers available."
>     But these are the SAME buffers that were just discarded.
> 
>   4. handle_rx() hits `continue`, restarting the loop.
> 
>   5. In the next iteration, vhost_get_vq_desc_n() checks:
> 
>       if (vq->avail_idx == vq->last_avail_idx)
> 
>     This is FALSE (108 != 104), so it skips re-reading the guest's
>     actual avail->idx and directly fetches the same descriptors.
> 
>   6. The exact same sequence repeats: fetch -> too small -> discard
>     -> rollback -> "new buffers!" -> continue. Indefinitely.
> 
> This appears to be a regression introduced by the VIRTIO_F_IN_ORDER
> support, which added vhost_get_vq_desc_n() with the cached avail_idx
> short-circuit check, and the two-argument vhost_discard_vq_desc()
> with next_avail_head rollback. The mismatch between the rollback
> scope (last_avail_idx, next_avail_head) and the check scope
> (avail_idx vs last_avail_idx) was not present before this change.
> 
> bpftrace Evidence
> -----------------
> During the 100% CPU lockup, we traced:
> 
>   @get_rx_ret[0]:      4468052   // get_rx_bufs() returns 0 every time
>   @peek_ret[60366]:    4385533   // same 60KB packet seen every iteration
>   @sock_err[recvmsg]:        0   // tun_recvmsg() is never reached
> 
> vhost_get_vq_desc_n() was observed iterating over the exact same 11
> descriptor addresses millions of times per second.
> 
> Workaround
> ----------
> Either of the following avoids the livelock:
> 
>   - Disable GRO/GSO on the TAP interface:
>      ethtool -K <tap> gro off gso off
> 
>   - Switch from kernel vhost to userspace QEMU backend:
>      <driver name='qemu'/> in libvirt XML
> 
> Bisect
> ------
> We have not yet completed a full git bisect, but the issue does not
> occur on 6.17.x kernels which lack the VIRTIO_F_IN_ORDER vhost
> support. We will follow up with a Fixes: tag if we can identify the
> exact commit.
> 
> Suggested Fix Direction
> -----------------------
> In handle_rx(), when get_rx_bufs() returns 0 (headcount == 0) due to
> insufficient buffers (not because the queue is truly empty), the code
> should break out of the loop rather than relying on
> vhost_enable_notify() to make that determination. For example, when
> get_rx_bufs() returns r == 0 with datalen still > 0, this indicates a
> "packet too large" condition, not a "queue empty" condition, and
> should be handled differently.
> 
> Thanks,
> ShuangYu

Hmm. On a hunch, does the following help? completely untested,
it is night here, sorry.


diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f2c45d20883..aafae15d5156 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
 static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 {
 	__virtio16 idx;
+	u16 avail_idx;
 	int r;
 
 	r = vhost_get_avail(vq, idx, &vq->avail->idx);
@@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
 	}
 
 	/* Check it isn't doing very strange thing with available indexes */
-	vq->avail_idx = vhost16_to_cpu(vq, idx);
-	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
+	avail_idx = vhost16_to_cpu(vq, idx);
+	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
 		vq_err(vq, "Invalid available index change from %u to %u",
 		       vq->last_avail_idx, vq->avail_idx);
 		return -EINVAL;
 	}
 
 	/* We're done if there is nothing new */
-	if (vq->avail_idx == vq->last_avail_idx)
+	if (avail_idx == vq->avail_idx)
 		return 0;
 
+	vq->avail_idx == avail_idx;
+
 	/*
 	 * We updated vq->avail_idx so we need a memory barrier between
 	 * the index read above and the caller reading avail ring entries.

