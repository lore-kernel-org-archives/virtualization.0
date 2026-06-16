Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0DD36D9F6
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619812; cv=none; b=Sx7boxf0toi+krx/H1ssHzBf3I5z5MSTogNDCOL0ljzzznZ/3taHCQsm8+Dh9gXcWotPmYghcB6auYBpVyXLVnWSXGEbM6t+OWROdCVQnNLaMm7Ddz5hwDg+4iPto6Z05hUw7j84lW9/aXngoWWizORg82VkMk0ZucU4Tr8GaEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619812; c=relaxed/simple;
	bh=Q/s4cDWwwN/dicrkzT22yRozV+e/TzvwUha5L7N8yA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RW2eoEtYNugpFk/pPGJaDUzyUUa4c0woP+opGNNrxAg3lalPknK7SNCjqdww2slvd3lGpVAZ5i7zk5nOgcQVZyeHGZ1caW+s50XTtX7UR/JPZIR/Ai8HRf13a4tsnUvBza2R+a6DRCGKd4zkrf4SLPoeP4jxeAVjIwF0YkJWfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5fV6wOl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5fV6wOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7mn5V4o1TPXbSAVtdGS76DREOft6jWX1FbZbmYVpiyU=;
	b=a5fV6wOlAnUvq9OcNiADJjYWaC/RfuuE8MXZYvqzxk3Ob++cp+2IYDs2Rxl/AZ6mXldtjk
	wJ+ojCJ6hFfasuac7wvGb6zIZuAmWV+1edHWe3FGrt0C0ImPYg48Gd4cZJsZt76y5S282L
	DJWirJ2GvsUam41qZa6ZtZsvzNssOfo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-cHOMbdtPPZG5QCAlj4Ci-w-1; Tue, 16 Jun 2026 10:23:29 -0400
X-MC-Unique: cHOMbdtPPZG5QCAlj4Ci-w-1
X-Mimecast-MFC-AGG-ID: cHOMbdtPPZG5QCAlj4Ci-w_1781619808
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490aadb1386so28154795e9.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 07:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619808; x=1782224608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mn5V4o1TPXbSAVtdGS76DREOft6jWX1FbZbmYVpiyU=;
        b=OtpSVfKscG+wOC3dlBuBYjID9zw72IUyfP35Nm1iND2xX6Rvb3yw8lpBFURCZtWuqr
         W9uen0XmCz9awtg5r2vbTDi5Bm6VB4EM063IJdN8nJQAgh2ie9bOqprxMYWFK4+KoyRq
         Y4XCsWGkcgfiBJpQAj3hmIWTkQuznw6fttKAmwqZMj5u2o+4vwk6P0uGzpJ9J3SjPPfI
         hExWf/4CyfokxO31uJ+HwoU8dgZYG3VHZwdWXKXI7QHkKvGq2DC9qF0s/ZuZK8XROYIb
         5p0XNT7WkvEpsmmJJFlb0Z3LI35OHhdRv/2nDGDx74TFiW7vMn+5Uee+lBJDWIkN2d7o
         RcFw==
X-Forwarded-Encrypted: i=1; AFNElJ/kplR5N/TQWxR6JJ77p40w/WdhWIeHnLXoQPDBjadZElFHB4X6Br1hycCifyox+VTR8Fi07l6wCPL46tsB4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBgO476D9Q1Rdyulzl0z8IdRNrAY2LMTftQ6RkhzDZOVoIZti2
	Sw6mm9XSP3JIWQqgH733S3+A80VBp0wTGhSaT75y1K+tGlStSqnEv0VA2sEdy2DlP5DQvtFAC53
	BzVgNWwrC7YZ20gwnTUC694y55DjiHyUj1R9XpR9nuv3eU2YihsPYo9NoIZDYXszfF6UI
X-Gm-Gg: Acq92OEeOW376Vs+haVMa2Cvvdt9zgo2gQFs7/H3pECfMlqryhIQl7okUnPd2d9SDcC
	CR6wqaj7SpwXo+7+YANzWdZ6CAMm9envgO53dgrbP0LPQkew0nnzNsBIrLn2HZ5VWCY81uqxVzw
	MCI4nnXv02/gY6r8SbRJ6yYedDLI/vfMhvFjjtah7LbhE6YFHGafEolrWtqNNyoDUsfeKFXLIp1
	T/zes/wim8fxaRtGYzqhMew3QI1erUoq79+2pOwq7NTWmHDqgvJASTde4rubIKAExz5VPcccKjm
	dA16G++zLSzSvcTpSS66Cmjc3o0TazKIWPA6CHBDe0QFlFr4n7MwyYjq/bbOvCY7kS7oWZ7mhmw
	1UtYaB9hGG8t3wIsGxYNTNoMOGuL7ef2XgxBvbiRGv5XvsucfLzQ5schaI4TdZubDYhGUvPk=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr58482915e9.3.1781619807812;
        Tue, 16 Jun 2026 07:23:27 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr58482265e9.3.1781619807299;
        Tue, 16 Jun 2026 07:23:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm243782055e9.2.2026.06.16.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:23:26 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:23:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 4/4] vhost/vsock: re-scan TX virtqueue on device start
Message-ID: <ajFbT6sDESh9FDOl@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M9ErwBCr3dZARk7cLL2DnfYv36BNtSFQR6FgurYiR7k_1781619808
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 07:57:18PM +0300, Andrey Drobyshev wrote:
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
>The deadlock is reproduced during active host->guest socat data transfer
>under multiple consecutive CPR live-update's.
>
>To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>queue the TX vq poll so any buffers the guest enqueued while we were paused
>get scanned.

Again, it seems like we're fixing an issue that existed before this 
series, but IIUC without support for VHOST_RESET_OWNER, this could never 
have happened, so the wording should be changed to make it clear that 
this is can happen only with the new VHOST_RESET_OWNER support.

In addition, this patch must also be applied before the 
VHOST_RESET_OWNER support or merged into it.

>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index bcaba36becd7..1fcfe71d18be 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -655,6 +655,12 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	 */
> 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>
>+	/*
>+	 * Some packets might've also been queued in TX VQ.  Re-scan it here,
>+	 * mirroring the RX send-worker kick above.
>+	 */

Can we also mention that this is related to VHOST_RESET_OWNER?

Thanks,
Stefano

>+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
>+
> 	mutex_unlock(&vsock->dev.mutex);
> 	return 0;
>
>-- 
>2.47.1
>

