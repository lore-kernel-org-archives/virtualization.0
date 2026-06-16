Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409C33C182
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617738; cv=none; b=nZKcgexRH0V/a6HXhl4SCWma+n/ll7R02V/yl9JGI+ty3iem8EcnOmBGtPtU98R6tuzOOg/RBjhc0Knhft+F9Sq5gSJ85/1UXL8s0xyUcI8wBXu6me2T14iPzJPadOUisB00C7ZOwrzbQGwJC7Ta6w2VXb8K6NdDf8sP96Yfw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617738; c=relaxed/simple;
	bh=5CR0/gNeuOc2zkbAwEj3QpPxqk48E1/i/BCv28UFb7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gwCX1uLVxPbWNbmdpW2HLh1smKvFYnKphf/tIiMPPbs1bNLwAwHaZDmlz5D/4QgcNmyzqAwdwRMzXjOA4lVLfrTHRpX6R8EO32GoyJ7UeGsDtzEoank8v6GwCV3nt2KRyP8v0/f0krkIRA6cNTFKGxEeYt/ZA/D0dkhhN9CFyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehMcBOEw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehMcBOEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781617736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPZnF8IEm/lwUVIdQCh7bqnFf280e66Awhk1O9lMvHM=;
	b=ehMcBOEwRDnXnYV0brWhuFv9OHrIgh8UK5IhnfTvfyT6SGIGTfm8NSosVTw6f1gBvRSjO8
	j0YmHtD9qY9Z1s0mUN675E67K0KeASoeCJbF8V+8RruNotfBIdSDrjqIhU+MrVxivJz9wJ
	p8t0Mbl+LolFSqB2EW7IPWmZ7/FlDSM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-JLzurJRKNsCmzhBWvbibYA-1; Tue, 16 Jun 2026 09:48:55 -0400
X-MC-Unique: JLzurJRKNsCmzhBWvbibYA-1
X-Mimecast-MFC-AGG-ID: JLzurJRKNsCmzhBWvbibYA_1781617734
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-461a15b1062so554322f8f.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 06:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617734; x=1782222534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPZnF8IEm/lwUVIdQCh7bqnFf280e66Awhk1O9lMvHM=;
        b=GQHjnwwt1VB4FaBdjIUcVtQ81gwgoWoC59gpB+uLFuRDaCZ0SNVLikVeaokh6YwPCY
         MphXbNVsqOPbKsu47H/usr03klq24b0mCyl7dNjaG+UP1qmTYmBw9yKv20Vcj7naP/0H
         Ri/r/ZQUUjY9JsQrfiH9NevXZWUYpezBHRu0B9jY3OOkyWTfoy4KxaJ2qXiyxNUrqUPU
         oalQGBtCIjuOhD3fzpnFW1HjCR393nGMAq1DF0ScDBfCGWmMNhrCcIaxVHIti6gnSJuS
         s/7RCJt1eCSf3sKWH3OI21RqCnVIDhCy1bbb5STpDW4H5zEB7qOeRX7EkqQToftxfVMn
         TjCg==
X-Forwarded-Encrypted: i=1; AFNElJ+wkbkpebr/lJs6rH85ALiQNU2GXtKc+xWtD1yLzL0Hl0oc7HEwXnGWIKq4C7E8+Snr8UYD3gurhBQRZiTAKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi2/HFKKDVTaDWzQj+jrg4iGqEZGd3Qm5AtZ9E5mMYuKcMgmEM
	BL/pa4u10NJXFk5E/ndwQSSDCRegamAkdyYHz1wcKP+PTHKAd+xHTu9GltqdUa0JCL5PyB8fMxh
	Tht9M3k/chPpt9R+tQWTVE7TJt+PYDEluhm+f6a41XlDemzusuy2wqEdHf7GwXpdmfLBH1+yDgt
	dF
X-Gm-Gg: Acq92OH3ulVtwkzXTPetEO0pCjm7IgdDxNMbKEGRmyjeQlnb03leO7ixrvxL5XLbQfV
	Gig1WiVSFyxTnAlIhLgmgkgJcjPdzPFKGvrNx8AabNheRcPKLsnuEc/Ge0YN1oqug+uECoxHlKm
	2rnFNGpJgOtm+FhjybC7L51Hb3DN7MKAEG4KpUzsFizqKRv1aaN9e7IACN93di4pvDwzDUd7PGn
	o/TcJFKWRv/St+7vu3Ln4pOtBHLq6AvfO3eNYBts3q6C/SLhxizC4PCwWpUsdISkPTB3KQMJPx0
	CniPWihJMB0KKSPtOlcgrdTJz1AsYXhbQiO0rWeRoBAIh68bVsXEZGJAmhiXhEJqBoZJVyiaUbP
	SsOd/CrW3/C6CWVST5VgVSTyPbsRJtbiFF10KmQPVIkmiwap0jXaPzuMlnQ77DQgJCn4ju9U=
X-Received: by 2002:a05:600c:4e01:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-4922ff992ffmr58825765e9.15.1781617734169;
        Tue, 16 Jun 2026 06:48:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4e01:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-4922ff992ffmr58824915e9.15.1781617733491;
        Tue, 16 Jun 2026 06:48:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a58becsm60905695e9.7.2026.06.16.06.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:48:52 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:48:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <ajFRRmA9req1muX6@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _ywe_IgKitlWtdC-ux2epPcEu01sGO0bFy2ofOHDN3A_1781617734
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 07:57:16PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b12221ce6faf..e629886e5cf8 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	return -EFAULT;
> }
>
>+static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
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
>+	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
>+	vsock_for_each_connected_socket(&vhost_transport.transport,
>+					vhost_vsock_reset_orphans);

In vhost_vsock_reset_orphans() we have:

	rcu_read_lock();

	/* If the peer is still valid, no need to reset connection */
	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))) {
		rcu_read_unlock();
		return;
	}

IIUC we are not removing the guest cid from the hash table, so this 
check will be always true, and nothing is done.

So, is this call really useful?

>+	vhost_vsock_drop_backends(vsock);
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
>@@ -937,6 +963,8 @@ static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
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

