Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CB40E8F1
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823559; cv=none; b=Vms9awJU/ZY2mHfAqvE7bt2EV+T3qEnwqLW0F8FpoNSh7H9FtVTilohWZO7GcyCY0DXCeGpYBQYOgzSpLPfLulkcx7RCIbNkpb5VaQWu/9Ws1mQ5etbO8qVvGChLug8mzFEqtULLxYi7RN7nT5eITnK58fcDRlMSTw5tSiIVgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823559; c=relaxed/simple;
	bh=rnqTc9VcuxQmrucqXv/X4rxwWBjO4aintFdu4oYQwos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ba0K8NKWQrwaYdTM9M/l/ZQberHptoIzowrXxnQMNDjtmH0pOK2sh3VuAEAuvjsZklXeHFv2l+DZfCJqT2VigYDemsvLBgdGYePovPGdT4T/vDyTWOBYoyeQk/si7clTbXtYI8AinsZ3QiVgkthmijqFUopGy5EoPcTwmLoQVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgLFZ+Hr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgLFZ+Hr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782823557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9xE5wahl+eqalpRYfV0fnyzHdxALUWLBp0RetJPvoas=;
	b=CgLFZ+Hr8fIQYtn2Jh0UmS2QbVDnQ7a9OftiQWPo9H2npJbSOKjmZ9u5MBPrgKWSV7yesy
	xzcEx9AWKshqRGg00s3rjAv6njGcEISsFMtE/Kxp5WeiJeFSebCHGQBYlFuCbcEsAoqKAY
	oSnvuHIpOKEcdRTlxFBzcMzRNVrk3hU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-epWstTZxN_2rbQzvqqNpbA-1; Tue, 30 Jun 2026 08:45:53 -0400
X-MC-Unique: epWstTZxN_2rbQzvqqNpbA-1
X-Mimecast-MFC-AGG-ID: epWstTZxN_2rbQzvqqNpbA_1782823553
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47407691804so1241831f8f.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 05:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823552; x=1783428352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xE5wahl+eqalpRYfV0fnyzHdxALUWLBp0RetJPvoas=;
        b=Nbn8eHkjyQK7TX2TE6iqylyctkOcrFEkowV6jfk0NztFSuug4JdFkGdJ/EIr4436X8
         A3zd1YRQnEARHYAqyr5ohWh3avv/kG8WoSBgCvTJEHwvBIQzmHDe+PPNLRJOZuoVOs+c
         O34sZ6fdkcYfYdPiNRUXJUWKeki8h44FYsYv0BEnl1Z7HG/hq3fzWmxiF61MzYwXGONP
         YBNNqjJ3NL3lQZm2cisYci5I7BJQINtSyrHKF9fuvv66t0XzZarGCVJKggazuNjBmaUa
         npoWoFzUbNxrx/b9eOb60xclusmfJ8tIRAz5EhhYz3VhmFb3y6vLN2G8aS3o9yiLc+JN
         9pNQ==
X-Forwarded-Encrypted: i=1; AFNElJ82edEl8ztcPXcwPvtszgx2fublnzWvkrTwqxk4Yu/sjG/yYf06ZSp43fEOIwvuDPWLbiiUv7WJreWrBh57Tw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymZXZRQzBniXkELVN1431DWnu+kojIrqu9QsHml9UBpnlFrv+A
	z33v8po0Dw4+Ovg1AzqEnLW2cfEZ8T2d6SM/P1spTjIKsk75/Y976tI1oFPSRiaCRb23oLWCObo
	ebQE8pqTPMYZQlE6iJ7We+ZwheY2HjCxqSa+ZxJwiwqiT/wp6eilWqu9WwuYh1ZI0T8fm
X-Gm-Gg: AfdE7cn3M7q9uVh8P6nE74oJKQNeZuek3Yx6VB4VpMiIYC9phfMXosD+gogViz2M5jo
	8xHbiBSatuCcrhxhFQPS2xSk3kGbEpVqAmTxJXMmpxLS2IuQ/Ogr/UuqcNjJRT4RPD7ZO4a5roW
	oHUs6acfDeZGxJP7wmufcO5igqbIITDr6FaC7xTdsCg/OjMs8iEo9/R7Py4eENfHfMJiAKM4G5P
	pqUmuMfBEUMnMhuoZhdHmb9nffgLtv6k9u76/OS4XQeK3lrQ9L6SQfB8nZVMq25aDHWOTtUb8vD
	CKW4KjTo3UypRUa0nAzINO8ADomVdtzme/+R/xyEEtL0/9UKLJKqmvSBMBtr1CbB3EKZrgYKmuJ
	y6Nb+kTp49tgb8RYcGJO7ZUIeGxMhiMf+pOQSNQvdpI5TpLm1wVlg+KfA1w39
X-Received: by 2002:a05:600c:a086:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-493bda874famr6557675e9.33.1782823552468;
        Tue, 30 Jun 2026 05:45:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a086:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-493bda874famr6556975e9.33.1782823551880;
        Tue, 30 Jun 2026 05:45:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bb1bf712sm30233055e9.2.2026.06.30.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:45:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:45:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 3/4] vhost/vsock: re-scan TX virtqueue on device start
Message-ID: <akO5DNoEsjukV5az@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-4-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260625155416.480669-4-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nB6ZKEPeZNpko6tpLVybKSCmt25k8ehNkdYCN-rXXmk_1782823553
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jun 25, 2026 at 06:54:15PM +0300, Andrey Drobyshev wrote:
>During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
>keeps running while the host drops and later re-attaches vhost backends.
>If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
>while the backend is temporarily NULL (between vhost_vsock_drop_backends()
>and the next vhost_vsock_start()), then the kick is delivered to the
>vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
>kick signal is consumed.  The buffer is then left in the ring.
>
>Then upon device start vhost_vsock_start() only re-kicks the RX send
>worker, never the TX VQ, so the buffer is processed only if the guest
>happens to kick again.  But if the guest itself is now waiting for data
>from the host, it will never kick TX VQ again, and we end up in a
>deadlock.
>
>The issue itself is pre-existing, but it only manifests during a brief

Why "brief"? I mean, there's no limit, and the user process could stay
there forever, right?

>pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced

Again, please make it clear that VHOST_RESET_OWNER support will come
later, so this is in prepartion for it.

>during active host->guest socat data transfer under multiple consecutive
>CPR live-update's.
>
>To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>queue the TX vq poll so any buffers the guest enqueued while we were paused
>get scanned.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index bec6bcfd885f..81d4f7209719 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -646,6 +646,13 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	 */
> 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>
>+	/*
>+	 * Some packets might've also been queued in TX VQ.  That is the case
>+	 * during the brief device pause caused by VHOST_RESET_OWNER.  Re-scan

Ditto about "brief", I don't think is adding anything.

BTW the code LGTM.

Thanks,
Stefano

>+	 * the TX VQ here, mirroring the RX send-worker kick above.
>+	 */
>+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
>+
> 	mutex_unlock(&vsock->dev.mutex);
> 	return 0;
>
>-- 
>2.47.1
>

