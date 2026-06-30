Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B8402BAA
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823165; cv=none; b=oOPeKfGiuVDLbgOwFPWjovy+7XSJaoYY1i1swzFYkDZnRNZZ5ZTpIaqA5sjbXciPLprQEyVJMD/alAuMY1qsF/Jeaa7OrODaZPTva5JS/do3FJKD5Q4nl3HFRPj+qoLRLOeM9/NOVgerpK6MfqTEThq43PSj3pykmxwL7HCrISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823165; c=relaxed/simple;
	bh=VwYiaIOctNoh585NIztzC6xWPLmQ71URx+DbYZxb5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tTP7+JMI1xYGlgvohUyuEZg2jsFzVVS+nkvsLwt9t4TQ3nx0jAXZu9z4hrfP9+Wlm/CbRvPUF8XXjKeBEWjUZifTmXBu6HEedUXfrx8UkuwyNumM/JUzh5qySdFtTKJTRqNERRPlnaLlRWh2bwQ503icYwoKEAzgc0fHKkPX/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDHmd60r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDHmd60r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782823161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhYoswPadKQqsKhwI9bNhjFKctjkWor2chy9aJkH7jQ=;
	b=YDHmd60r20VA1gfh9sWWd7nXFEqN7lVxIqmJz02F7SeOx9l2bwA9VpzQh1qRmHfffFsLQg
	GiVfp0Xj3vM1AdjMBa3iOyJ0h4Bm5jTPKua1R1rV44e9fdMNqd53OjuWtslSkDvgAsD+l1
	DBC6yk77udI59fx/bA2bTmkYZJ+gocY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-x0Ti5x5YN8m_CUJtzIUT_Q-1; Tue, 30 Jun 2026 08:39:19 -0400
X-MC-Unique: x0Ti5x5YN8m_CUJtzIUT_Q-1
X-Mimecast-MFC-AGG-ID: x0Ti5x5YN8m_CUJtzIUT_Q_1782823158
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493a6fe9ebdso15236205e9.0
        for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 05:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823158; x=1783427958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhYoswPadKQqsKhwI9bNhjFKctjkWor2chy9aJkH7jQ=;
        b=p6fS0+LeEOnEIz66IvwoPnJefSsw0BB6uipO3G7UeBGKhr8lHVr2ik77iqhldiaOzp
         o8AKAYLnHIGd/t/9U2mN/S0gmx6UbHXa52g4BGy2wrfiWsIMfFi/AQlhY/hMA++s7gaQ
         SL2oC4HXYkqPokT9KcXq6NyiurP5oGf7DVcyAUcxfJ7RpabB8UbhkHW/tpEUNmAYKCAX
         T+QE0UT2nKwe9xReLQ3puefxFdeq7IRy0qHoaEqw0f80h/Z2g5JbEdDek2IfeliiUkEA
         bxlGpPSgNBchfFmnoBv25ZkfF++xZwMpsgmrEOE2RAi4+Vs0RBgpNqcT33cN2N1zeThj
         A7sw==
X-Forwarded-Encrypted: i=1; AFNElJ9Q2pn5PEttTCSBVm9hSQLMsnmRM6YOz/JtLJiDof0sAnsSRi6iAXqo6VNtWN4apDZnw/ohJ0CSeXihiPs5lQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtReEPwUrU2xSp7XW4bQklx0fKxBfk6EbjvVBUWGMaYNiwjoBT
	y1OBPweU8Orb4jDHz/61sj2DgrqAXkhiKc+6jl7pKprgP59olYyfRLDYAj3e//X+aJmJKo0Vhr2
	7eV8Oqrs02elXQgNEjoufeonLAUZ8fI8Btt5MO3MayIE+I9bgbKOfSVo1J4t6GB9S7C8Z
X-Gm-Gg: AfdE7cmKdKGQyhqw0GjbMgkjUiPjfI/YiNZLdQn86snN7QTe1XzJzo6f3tGd0tAmFOq
	qU2IPQV2mLffe7+lhneaxLCqBHR7mkZEZDvSf8pWD4Sb77JXRtl+AaEQ7mYZtWKehk0y14Bud1x
	ShHUwTc8iC5KbyJVByrfDvGK/pYnEMjbO7dAh+M4e4D/sQDwrO6Xxl5eEl3WFCDdBM7GA9Mum3Q
	nVKtAbrMpbdfKPKzuXPAR7PsCCASZkXHvWAs9GFboKPb76DgSQ+TH4MZjHmKFd+7C99CpHe/I81
	kJdJPKtY0sdVNQ5Fk+3WjL8KRNmppflrHfcDoZhkYeAf91vlEspHUxBeBpMqrsmNjCqGyZ2q8fo
	o/dIUS5OGsvTPXpZwUcg2Qs1lW28kWAXevo2gZWa6zsil/bdnVifrJdaGOwcv
X-Received: by 2002:a05:600c:c493:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493b82b6360mr51871245e9.32.1782823157949;
        Tue, 30 Jun 2026 05:39:17 -0700 (PDT)
X-Received: by 2002:a05:600c:c493:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493b82b6360mr51870825e9.32.1782823157370;
        Tue, 30 Jun 2026 05:39:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8c8d92dsm71175085e9.0.2026.06.30.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:39:16 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:39:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 2/4] vhost/vsock: suppress EHOSTUNREACH fast-fail
 during CPR pause
Message-ID: <akOUbsbSdNzfNnSR@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260625155416.480669-3-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xnObB8ySQRsxAHRvrHHGx6KYrrLxwTqCOLUQ2b9ppcE_1782823158
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 25, 2026 at 06:54:14PM +0300, Andrey Drobyshev wrote:
>Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
>immediately when guest isn't ready") added a fast-fail in
>vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
>until the destination calls SET_RUNNING(1).  The fast-fail condition checks
>whether device's backends are dropped, and if they're, the guest is
>considered to be not ready.
>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.

nit: IMO we should make it clear that this behavior has not yet been 
implemented, so this patch is a preparation patch to support RESET. In 
this way it is clear that it is not a fix to be backported.

>
>Add a 'started' flag which is set once in vhost_vsock_start() and is
>never cleared.  The behaviour changes to:
>
>  * When device was never started -> flag is unset -> no listener can
>    exist yet -> fast-fail;
>  * Once the device starts -> flag is set -> we don't fast-fail ->
>    we queue and preserve during any later stop / CPR pause.
>
>Important caveat: after the first start, a connect during any stopped
>window is queued instead of fast-failed.  That was the behaviour before
>the patch bb26ed5f3a8b, and we're restoring it now.  However we still
>keep the behaviour originally intended by that commit (i.e. fast-fail if
>there's no real listener yet) while fixing the CPR path.
>

Suggested-by tag is nice to use in this case.

>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b12221ce6faf..bec6bcfd885f 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -61,6 +61,7 @@ struct vhost_vsock {
>
> 	u32 guest_cid;
> 	bool seqpacket_allow;
>+	bool started;		/* set on first SET_RUNNING(1); never cleared */

`started` was my initial proposal when I was thiking we should have to
set it to false when the device is stopped.

Now I think this name is confusing, so what about `ever_started` to be
reused in the future, or just `fast_fail` since this is what that
variable is controlloing right now.

The rest LGTM.

Thanks,
Stefano

> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -302,17 +303,12 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
> 		return -ENODEV;
> 	}
>
>-	/* Fast-fail if the guest hasn't enabled the RX vq yet. Queuing the packet
>-	 * and making the caller wait is pointless: even if the guest manages to init
>-	 * within the timeout, it'll immediately reply with RST, because there's no
>-	 * listener on the port yet.
>-	 *
>-	 * vhost_vq_get_backend() without vq->mutex is acceptable here: locking
>-	 * the mutex would be too expensive in this hot path, and we already have
>-	 * all the outcomes covered: if the backend becomes NULL right after the check,
>-	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>+	/* Fast-fail until the guest first enables the device (SET_RUNNING(1)).
>+	 * Before that there is no listener, so queuing is pointless. 'started'
>+	 * is never cleared, so once we're up we keep queuing across later
>+	 * stop / CPR-pause windows.
> 	 */
>-	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>+	if (unlikely(!READ_ONCE(vsock->started))) {
> 		rcu_read_unlock();
> 		kfree_skb(skb);
> 		return -EHOSTUNREACH;
>@@ -640,6 +636,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 		mutex_unlock(&vq->mutex);
> 	}
>
>+	/* Set 'started' flag on the first start; never cleared, so send_pkt
>+	 * keeps queuing (instead of fast-failing) on later stop / CPR pauses.
>+	 */
>+	WRITE_ONCE(vsock->started, true);
>+
> 	/* Some packets may have been queued before the device was started,
> 	 * let's kick the send worker to send them.
> 	 */
>@@ -728,6 +729,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>+	vsock->started = false;
>
> 	atomic_set(&vsock->queued_replies, 0);
>
>-- 
>2.47.1
>

