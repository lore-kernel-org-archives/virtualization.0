Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B736F405
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619531; cv=none; b=pMzJNHhUji2q6S3NgX8CaC7qRvGgosTPfHVgigdGK80+ajAOkt0Vh2ntul2C4a1OL8mSTWuI571fynJ3eKZCsaSQP2BGjlZRwMMrLgwgbg9oQsDdMsMI1t6C3jo9pu11NmNO/q0y+eA6sM1dbX/RTuUaSyy6gfmEN9MFzNBgmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619531; c=relaxed/simple;
	bh=vJqyvxeaNxfW6LxXVQpl4/4cnJSjsoFuDMk8hGTaUXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QosjLOASfKzI5XMv/KWWj5inJZu9MexshTOWsfi1PH7Xitzlhs2PVEogkdBV7f9Q0D8IJbwGKvSVWF4guCuyV7QiKN1EVV31QJEC14rr6zXQDSHsuXvad22ErsXqm96TNH2DXYjVRqHoX8D8AcJV5+lWZ9as29CFoCXrFyn/FUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUH5/hAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUH5/hAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWdtjwkPY2KPVnS0hOnG6u0xNpB/3YtZXJSrw+UYGyY=;
	b=MUH5/hAseDI1KUwkcASNAH3PHsg1Kp8hCUfXnLN3WxVr9I3/wcGPwmjAymX+Pp8QfR7dMZ
	aqgWxRAXupm09pZPdnm3BzE1Xr3aONmzj7A4WHxewM8XeEXIGbrmJH268HAGYzaFkgP/6Y
	AGzqd3RIvDABkXp3GgyKnu3Ml/8FFqo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-0bdEi2M9NMGtZq3JpwfnZw-1; Tue, 16 Jun 2026 10:18:45 -0400
X-MC-Unique: 0bdEi2M9NMGtZq3JpwfnZw-1
X-Mimecast-MFC-AGG-ID: 0bdEi2M9NMGtZq3JpwfnZw_1781619524
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b9318944so29559025e9.1
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 07:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619524; x=1782224324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWdtjwkPY2KPVnS0hOnG6u0xNpB/3YtZXJSrw+UYGyY=;
        b=LoY7YYaexpWZ68HHn0VEJvTFrS78O4/7wJsRyHQd7By30SIGotQ6/+LGQv3K5DMJYZ
         ha629G8alzUIjbLM560xXeP6J7vUf6H4PpGGkw0X1Jrm1eEpiKG+xAAfEPn3y8ymiLFS
         aYlE61MtK0pMf5XxFFRh48u/MUnzC/iRabwMthTW1rxQJW4djFcbWNb7EcltnkblqZiF
         YvieBS6F2XHrybUSAarQPNSCo17OGu4jOs4rlsEcfBMonRSbXcS2aY+PC8lVa6jJLOt/
         4i9jyY365DMisb/pjDRFpk67rjhz9e/NGN+/oV8AHVHxquBrKxRVkHBZVDeYwzwfcGT+
         jArw==
X-Forwarded-Encrypted: i=1; AFNElJ+ahfjvas4uFqOeAIEwsZ8L0vQPc2+bg6LN8Lw0vIeheY4idYSet2cl5qEweuLIWm3/KZ70HEq/zVO9biAFgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSMzId3fOF2AKyhNz7o5jtrqovLxtGJtZqsyNUVcHHeXfVYaOo
	dS4zenNV3RLxW3Di0jC2LYoHpVV5NcYFXs0ydjkNr+cNXVqWLJ51zIvRndYeAi+qN/wmXRljIHS
	YimhTpWktkhc+DmKlEjfwU08pMkCp0DOs2iFhe8InCJXX90l/faKkgrzQEIvU7Om91avqIkfJyM
	po
X-Gm-Gg: Acq92OF5QJ06zNru2ZXtaN58wWapSh3HtabOfQKH2Y0WvwvUNn3uWfNrkQr54Oz7lHM
	hLfMN/W/A/J+wlWoeR1nOI2x2Y5Mga00eqgP/oGDR9ePuurJU6FYOS7Z/9cKMoekj/2lCIaQJak
	YCYBMEA3WdbCiGf5PNyU3TzjpJDJR7xUJEj0M8C2EewWaxuhleelnwalJmrKmgTsNsKy6nqUSl3
	uxg2s4t7wOng1lcTkxoPJJcn4JziF2VwlX4mje0ByyWMk7ElLORCZllBhM9PmoQi+a1YmEAunO/
	fQ735AY7q/s/IGDsdkWecMNC0/9II+TbkBfvUwWiz/4GgtJAZF2BDtf6NKVDoO29eAYIrf9NMh2
	S28eiu2GfeS7fZ3n6Tn964hSLDfg5pwz6iGDCQpcKSHRNlSnYHJ3a6GAqMNVjUGgN7YGDmRg=
X-Received: by 2002:a05:600c:810b:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-4922ffb82d9mr60188325e9.28.1781619523765;
        Tue, 16 Jun 2026 07:18:43 -0700 (PDT)
X-Received: by 2002:a05:600c:810b:b0:490:9df1:f0d5 with SMTP id 5b1f17b1804b1-4922ffb82d9mr60187355e9.28.1781619523017;
        Tue, 16 Jun 2026 07:18:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96b47sm56484875e9.13.2026.06.16.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:18:42 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:18:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during
 CPR pause
Message-ID: <ajFUk7quPhbI7Te-@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TTUo02YnYw40vOKnZzC7zN9Sj-gOXMhZD5rEpg88e7k_1781619524
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 07:57:17PM +0300, Andrey Drobyshev wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>Earlier commit ("ms/vhost/vsock: Refuse the connection immediately when

Please follow 
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes 
on how to refer to a commit.

>guest isn't ready") added a fast-fail in vhost_transport_send_pkt().  It
>rejects every host send with -EHOSTUNREACH until the destination calls
>SET_RUNNING(1).  The fast-fail condition checks whether device's backends
>are dropped, and if they're, the guest is considered to be not ready.

Okay, so it's not a regression, I mean without this series that patch is 
not adding any regression, no?

If it's the case, I'll change the wording in the cover letter.

>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

Please add this change before starting to support VHOST_RESET_OWNER 
ioctl in vhost-vsock, otherwise we are breaking the bisectability.

>
>Add a cpr_paused flag set inside vhost_vsock_drop_backends() when the
>backend was previously live, cleared by vhost_vsock_start(). When set,
>vhost_transport_send_pkt() queues the skb instead of fast-failing; the
>existing kick of send_pkt_work in vhost_vsock_start() drains it on
>resume. A device that has never run keeps cpr_paused == false and the
>boot-time fast-fail behaviour is preserved.
>
>Pair the cpr_paused store with the backend store using an
>smp_wmb()/smp_rmb() pair so a concurrent sender on a weakly-ordered
>architecture never observes (NULL backend, !paused):
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>---
> drivers/vhost/vsock.c | 22 +++++++++++++++++++---
> 1 file changed, 19 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index e629886e5cf8..bcaba36becd7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -61,6 +61,7 @@ struct vhost_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+	bool cpr_paused;	/* between stop and next start */
> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 	 * the mutex would be too expensive in this hot path, and we already have
> 	 * all the outcomes covered: if the backend becomes NULL right after the check,
> 	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>+	 *
>+	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
>+	 * The kick in vhost_vsock_start() will drain them on resume.
> 	 */
> 	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>-		rcu_read_unlock();
>-		kfree_skb(skb);
>-		return -EHOSTUNREACH;
>+		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
>+		if (!READ_ONCE(vsock->cpr_paused)) {

Can we avoid this which is not really readable and maybe add a single 
variable to control the fast-fail at all?

I mean replacing both cpr_paused + backend-pointer with a single 
`started` flag: set it to false at open, true on start via 
smp_store_release(), back to false on normal stop, and leave it true 
during CPR pause.

The reader in send_pkt can do just:

     if (!smp_load_acquire(&vsock->started))
         return -EHOSTUNREACH;

WDYT?

>+			rcu_read_unlock();
>+			kfree_skb(skb);
>+			return -EHOSTUNREACH;
>+		}


That said claude here is reporting a potential issue that I think we 
should consider:
     After VHOST_RESET_OWNER, the guest CID stays in the hash, so 
     vhost_transport_send_pkt() can still find the vsock, skip the 
     fast-fail (cpr_paused=true), and call vhost_vq_work_queue() while 
     vhost_workers_free() is freeing workers without a synchronize_rcu() 
     — risking a use-after-free. Also, any send_pkt_work queued between 
     the last flush and worker teardown gets its VHOST_WORK_QUEUED bit 
     stuck (the vhost task exits without draining), deadlocking 
     host→guest traffic after restart.

     A synchronize_rcu() in vhost_workers_free() between the 
     rcu_assign_pointer(NULL) loop and the destroy loop would close the 
     use-after-free, and reinitializing send_pkt_work via 
     vhost_work_init() after vhost_dev_reset_owner() returns would clear 
     the stuck QUEUED bit.


> 	}
>
> 	if (virtio_vsock_skb_reply(skb))
>@@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 		mutex_unlock(&vq->mutex);
> 	}
>
>+	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>+	WRITE_ONCE(vsock->cpr_paused, false);
>+
> 	/* Some packets may have been queued before the device was started,
> 	 * let's kick the send worker to send them.
> 	 */
>@@ -671,6 +681,11 @@ static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
>
> 	lockdep_assert_held(&vsock->dev.mutex);
>
>+	if (vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
>+		WRITE_ONCE(vsock->cpr_paused, true);
>+		smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>+	}

Why here and not in vhost_vsock_reset_owner()?

Also having this here will set it to true also with 
VHOST_VSOCK_SET_RUNNING(0), is that right?

Thanks,
Stefano

>+
> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> 		vq = &vsock->vqs[i];
>
>@@ -728,6 +743,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>+	vsock->cpr_paused = false;
>
> 	atomic_set(&vsock->queued_replies, 0);
>
>-- 
>2.47.1
>

