Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8853325483
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826817; cv=none; b=pOx3d4RvIGe3nzqEvI1y6EHX5X1gUsouwUAIevaEXFpaor2WQ+qautOlgWqWJym1bgZgvOeU+t8Prg36Ra5HV+ENaHkG8ecXQDefJ6l0AijwCrr6vif2i/MR178tpKoJQdxnpoYLIk4MK7kD7hzKHBCleYHByFstk9jNBsp580k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826817; c=relaxed/simple;
	bh=+uAe7+vHveJ9Xr7bLTlrloHySuIi1wTIpGjyEF60J/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Jvc/AhQ9o9sloRAxbgO01+bC9k/nP81fSuNbVyBdfWEQeXLLMvYsVb4Scxa6DJDcojcHGFu/6vwH/C7BPVXxjcKQOgBY87A4MIe7/y3GdMnzCDSMbDpEavxUwqZyFbQ7igupy1IdTXHOXyoM8L2hrRV52eNl3rMTx791/nGTF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPCN9JM1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPCN9JM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782826815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xOH8U/mrUVa3IrW9OZzzYZ2ne3D4EbewCYpfQEKTXKM=;
	b=KPCN9JM1hC5exUTTgdzYeK5aSKhJq123R06q3Mzi71pSEhrxn+FCArbW0smv5NG7lTL7mI
	YvoXA+gVQyerTrFynKGEgp6Ll8EYbBkMc9b6xYAd07HXE0Ae7Q2ihwL5JfSJQSQvWn9XM4
	4YdRtaNulhkZJo30Mc7txkTnof5MrDQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-mpaon7jwN4mltGAh1FowRg-1; Tue, 30 Jun 2026 09:40:13 -0400
X-MC-Unique: mpaon7jwN4mltGAh1FowRg-1
X-Mimecast-MFC-AGG-ID: mpaon7jwN4mltGAh1FowRg_1782826812
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-470cb859d96so2195595f8f.3
        for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 06:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782826812; x=1783431612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOH8U/mrUVa3IrW9OZzzYZ2ne3D4EbewCYpfQEKTXKM=;
        b=GaaXog2fxAbu+HLNgnbEsggJUk4oHc6ElrwFr0mJ0ZCO9bh5YVmGJrEHLkUfNdDZEm
         PV4Q4Wun7Q5uIgq2KGubjNacM3yz83gxIQzUOOcVrgQAduKYveNuklLQTNJVl7ilhYvX
         LGyWvFx24d5qXep/UY4PypCTCQgmt4LAKKQDPh3Qkbf/tVlv6oquqryyueifb2Zv1QNq
         LDDHf4bISzrGgX+JwFk+WdrAcSRVcraQTYeg5laSToqMZebhaCZaX0jT7IGOzdwojwso
         bojpgFBrALamHTNZfEmoDCKK+hUM7/h1qinvsgEJWHCrFOKYy3tFFNw+jaG7UA0fPv6/
         eBKg==
X-Forwarded-Encrypted: i=1; AHgh+RoPCSBqC2jQYrpvbKlNsAK92y2VTtRunnwD7+4aNLUpzXBfKqV3hMf1/B3Yw6W8w69T8+CJnGlC2TdLBBfXUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ60I02e4TMQXHdEg0TGXl4iYTE00Qqu6lvR3ACny5WDeRXJMG
	LhbDpuiks/hAOHeP7YkllnB/Ucz8Og0HTagzxeK+iQbOjENXOoJmCbViFL57KgD0FiFovNfJDzd
	D6E5B79PLzJyDilshSZQw5RS1uSm3iWNDbCsGcvdPubYucSVetwzSr3aW1qLVwLSQlxSC
X-Gm-Gg: AfdE7ckI4AV3SJ5HSG8YuA31xI1K1e44TPYMcSylbYv8xST2/XrFimWYh4yuC//IzJI
	KaYdlocAezPJfFfLpYq2yPZqpjfhwZnzncnNJ/mlNrhz4oIAyZjyeWCTEgKlBGIrbYTeA5s6HOI
	ojoNlbM0NndKpuy7W00eY3HCXq1eLk/XXqdPwL3/4Zi153chC1EBQEim+3fhrcsEI1nYSAZzTP6
	fNF2LSQsOTvDclLbYQtfFBVzrUrR2+NxW1R0Vxu/se3Lqfg8pSKNgf0wMEfSCunGFD1+6u6vr9h
	gm+9dhxGKTEcCqO9cG7sMkl1RkyTVb///OGBdLafMFBsYi9DSLifAVbK+8h/ozjmk2841niUSYu
	0nUKxxJ2adnv/z6XJoI+r4t4mxcHQ/woCIxsejIISFhsdaz+Abz/DwlaWo6BG
X-Received: by 2002:a05:6000:25c5:b0:475:f0f0:9ec6 with SMTP id ffacd0b85a97d-475f0f09f97mr2841835f8f.49.1782826812363;
        Tue, 30 Jun 2026 06:40:12 -0700 (PDT)
X-Received: by 2002:a05:6000:25c5:b0:475:f0f0:9ec6 with SMTP id ffacd0b85a97d-475f0f09f97mr2841772f8f.49.1782826811836;
        Tue, 30 Jun 2026 06:40:11 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756797a8besm8461092f8f.35.2026.06.30.06.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 06:40:10 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:40:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 4/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <akO6tps94iFxCAWv@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260625155416.480669-5-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KL7CaCnb8XOlWkRuaMrigtn0GMmG7a37sA7kgh5-Nts_1782826812
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 25, 2026 at 06:54:16PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>RESET_OWNER keeps the guest CID hashed, so that connections survive. That
>leaves the device reachable by a lockless send/cancel path while the worker
>is being torn down: a concurrent vhost_transport_send_pkt() or
>vhost_transport_cancel_pkt() can call vhost_vq_work_queue() as
>vhost_workers_free() frees the worker.  That might cause a use-after-free
>of vq->worker.  In addition, any work queued onto the dying worker leaves
>VHOST_WORK_QUEUED stuck, stalling send_pkt_queue after resume.
>
>Fence the send/cancel paths around the teardown: send_pkt()/cancel_pkt()
>only kick the worker while the backend is alive.  And reset_owner() calls
>synchronize_rcu() after drop_backends() so in-flight send/cancel finish
>before the worker is freed.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 51 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 49 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 81d4f7209719..f0a0aa7d3200 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -318,7 +318,14 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		atomic_inc(&vsock->queued_replies);
>
> 	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
>-	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>+
>+	/* Skip the kick once the backend is gone (stop/RESET_OWNER); the skb
>+	 * stays queued and vhost_vsock_start() drains it. Pairs with the
>+	 * synchronize_rcu() in vhost_vsock_reset_owner().
>+	 */

Please explain better (as done by commit bb26ed5f3a8b ("vhost/vsock: 
Refuse the connection immediately when guest isn't ready") in the 
comment removed by this seris) why we can use vhost_vq_get_backend() 
without vq->mutex held.

>+	if (data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))
>+		vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX],
>+				    &vsock->send_pkt_work);

BTW I'm now confused about what we are preventing here. A better
explanation should be added both in the commit and in the comment,
because it's hard to understand what we're preventing.

That said, if there is a problem, perhaps it should be fixed in vhost.c,
because it seems more like a generic issue.

vhost_vq_work_queue() has `worker = rcu_dereference(vq->worker);` so
should already prevent UAF, no?

Or maybe vhost_workers_free() is missing a synchronize_rcu()?

>
> 	rcu_read_unlock();
> 	return len;
>@@ -346,7 +353,15 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 		int new_cnt;
>
> 		new_cnt = atomic_sub_return(cnt, &vsock->queued_replies);
>-		if (new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
>+
>+		/* Skip the kick once the backend is gone (stop/RESET_OWNER):
>+		 * vhost_poll_queue() would touch the worker which is being freed
>+		 * by teardown, e.g. on RESET_OWNER.  Pairs with the
>+		 * synchronize_rcu() in vhost_vsock_reset_owner().  The TX VQ is

Ditto about the comment.

>+		 * re-kicked by vhost_vsock_start().
>+		 */
>+		if (data_race(vhost_vq_get_backend(tx_vq)) &&
>+		    new_cnt + cnt >= tx_vq->num && new_cnt < tx_vq->num)
> 			vhost_poll_queue(&tx_vq->poll);
> 	}
>
>@@ -903,6 +918,36 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	return -EFAULT;
> }
>
>+static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)

Why returning int?

We are defining err as long here, also the caller vhost_vsock_dev_ioctl()
returns long, so it is not clear to me why here we are not just
returning long.

>+{
>+	struct vhost_iotlb *umem;
>+	long err;
>+
>+	mutex_lock(&vsock->dev.mutex);
>+	err = vhost_dev_check_owner(&vsock->dev);
>+	if (err)
>+		goto done;
>+	umem = vhost_dev_reset_owner_prepare();
>+	if (!umem) {
>+		err = -ENOMEM;
>+		goto done;
>+	}
>+	vhost_vsock_drop_backends(vsock);
>+
>+	/* Let in-flight send_pkt() callers stop touching the worker before the
>+	 * flush + free below. Pairs with the backend check in
>+	 * vhost_transport_send_pkt().

This is also paired with vhost_transport_cancel_pkt(), so please update
this comment.

>+	 */
>+	synchronize_rcu();
>+
>+	vhost_vsock_flush(vsock);
>+	vhost_dev_stop(&vsock->dev);
>+	vhost_dev_reset_owner(&vsock->dev, umem);
>+done:
>+	mutex_unlock(&vsock->dev.mutex);
>+	return err;
>+}
>+
> static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 				  unsigned long arg)
> {
>@@ -946,6 +991,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> 			return -EOPNOTSUPP;
> 		vhost_set_backend_features(&vsock->dev, features);
> 		return 0;
>+	case VHOST_RESET_OWNER:
>+		return vhost_vsock_reset_owner(vsock);
> 	default:
> 		mutex_lock(&vsock->dev.mutex);
> 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
>-- 
>2.47.1
>

