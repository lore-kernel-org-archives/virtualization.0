Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2E3FD969
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127271; cv=none; b=aOcajrOo9Wazw6Wxgj51O+TsBSW3e/Sg2WeKOGmKzpXkc9y2pHYdrtFGLGdY5jblY6017OOIBZc/OEmv95d7ZZteha8ByV7cDLkPhb8NZH/fEvYt4FvMqozqMUV3xTUk9T1K+gtw5YaLFy0tlE1ItaraGT2PgjfvOFxFF65BG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127271; c=relaxed/simple;
	bh=KhJExQqvLhBaMXF8UfYU6ZCaLYbHIyLRVAmEcmHRB+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mkCjK5VbPEeEMLBabYuHrnhVNFqCaVKiSEfOGQaK8HHXVIuE/NfCcm3YF4NInSOOZLjfDY+k6HjaJefPLm3MQ/HVrXHW4LsjjdK6SKY8JFNmgCYgA9y1nl+0IPrGg31pNc6ZTnVnUqIqULeFb1l1/HgiQRl6L6F+8qY1wSEF0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBKQn6Tu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBKQn6Tu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787127252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gk/y1sZo7O4/GSumr+W798rlzWHoDtcAKC9y2aG75mA=;
	b=eBKQn6Tu6whoazhXCKo0/j68SVx3Rk12pc6u+ImdbPfHjYEk8HyxjdVxGVO2rSsUNfpGfr
	jeP+C/2EK139ImwMJdQ6SnSd5UFYua+OnDURXhEFhY84K5ZCtuFAN+ZMtF7MT5Ru4g2ihY
	v0yLcjt4OS7hXOjP6cArBFP3a+UrQuw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-MH8JeadfPDGeMyvfFMW8pQ-1; Wed, 19 Aug 2026 04:14:09 -0400
X-MC-Unique: MH8JeadfPDGeMyvfFMW8pQ-1
X-Mimecast-MFC-AGG-ID: MH8JeadfPDGeMyvfFMW8pQ_1787127248
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-499913d1a79so5006345e9.0
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 01:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787127248; x=1787732048;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gk/y1sZo7O4/GSumr+W798rlzWHoDtcAKC9y2aG75mA=;
        b=PmGW+iv9fqrBASw1QVJHBufcGS6ZezDxyfHxn4Nefz7P98CDhTOviyKAfRv3pKtPdg
         1svctHTF/iMKuQ/myzAjVf1VFf5eYPMih+rW8rLwdSW4NAy1QoNnE4OfFww9w/jNyFk+
         4JpjiI9I3O7KDuB9xKLLCgMmM5MNVLC4LAToe5pmFulVx85fu6xdi43RVRxBbiZhLqnv
         pfYFcXEegJogCi2nA6jtwLOu2zE9h8EWY4yj6hyYUKNFz8xf0XEE8c54KJHQaQPsViCj
         6XevRWTc4lySZ3iu28DnDOk00ebX4UybL3iEU5d8DxbFU0JhCEHaakiLUd7q7co5ghHE
         kKrw==
X-Forwarded-Encrypted: i=1; AHgh+RrsMm+nP52bWW8Zl1yoWRZbcUnGjKmuDRzEXc0Jax+IAebLeFytHM6n5AsCMcZ6glIzM72vEauppQcH9PFF3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZpTaix8a3frOb/vlPaWXIKD9IJ9h/jIq9ZTuho6kgtCeqoXor
	dWbvDHxRtqJWs0TSgTB4Oyy1iU7n1LkMJN8uLsmvb1arQeiKYeAITgGCNWFVFci+jg+R8cLovz7
	keINkC0GM2t/bUikuAbAb6eOY2VC5h5fJtoHeDIf+bY//zDQW9vn5AjLTiPG8/T9Ho5AS
X-Gm-Gg: AR+sD1037IDvIX71NM2OaB3TPPSNQ6jijOLy+sEAyC38WtTG+Qa9/+rUICun8jDps3i
	VFCJnDMkGeSBfdIkJ0WJYiLUiNdj9gykV5NJ8uukniBlSUs/qcer/yGw4zsVpSHE4htQFRdjTGB
	uopMAC7qnlgx3vWo7mAFuJY80Qqk/HPS/c0QFxedap6fU2HEg65yTVmLRfTO0MFOJhyHjS2iQg+
	t8KW8Gm9t6/fASz+XBIvfStEuzCI3B3P6mM4ikw8Y03mftb2kzkwNY+Fjf+lgkMG8QlXJVjK0AK
	njtRUgYw7tKNb40coPFkNvCwFZ79nCxp7xvWN8cPEFobEE7rP4RvtdgyyzDJ+LCj4LT7w3g9qrF
	epGf54JOti2CoHTHYXxwZJ5tqWol0pZPXf5/xqrCiz0eDhGY/4QrI
X-Received: by 2002:a05:600c:c490:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-499aa143b7cmr46256415e9.3.1787127247887;
        Wed, 19 Aug 2026 01:14:07 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-499aa143b7cmr46255465e9.3.1787127247429;
        Wed, 19 Aug 2026 01:14:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa09b199sm38294085e9.0.2026.08.19.01.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:14:06 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:14:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, weiyj.lk@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Message-ID: <aoVkp0USmfvbmIy5@sgarzare-redhat>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
 <20260818042613.281125-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260818042613.281125-3-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AUxtv_mAoE5boRuVDSoTBGj3bULeJqo1UcC-lvhp-Co_1787127248
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 18, 2026 at 12:26:12PM +0800, Jia Jia wrote:
>Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
>Otherwise descriptor translation can continue to use mappings installed
>before the feature change.
>
>The common helper invalidates cached vring access and applies the
>transition even while a backend is attached. The backend remains attached,
>but userspace must configure the vring addresses for the new address mode
>after a successful live transition.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>

In v5 there weren't any blank lines there, why are you adding them?
Please remove them.

>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 9aaab6bb8061..77a5a6775c86 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -854,6 +854,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
> static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> {
> 	struct vhost_virtqueue *vq;
>+	int ret = -EFAULT;

This is a return value used only in the error path IIUC, better to call 
it `err` or something like that IMO.

> 	int i;
>
> 	if (features & ~VHOST_VSOCK_FEATURES)
>@@ -865,9 +866,12 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 		goto err;
> 	}
>
>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>-		if (vhost_init_device_iotlb(&vsock->dev))
>+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
>+		ret = vhost_init_device_iotlb(&vsock->dev);
>+		if (ret)

Is this change related to this fix?

Stefano

> 			goto err;
>+	} else {
>+		vhost_clear_device_iotlb(&vsock->dev);
> 	}
>
> 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
>@@ -883,7 +887,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>
> err:
> 	mutex_unlock(&vsock->dev.mutex);
>-	return -EFAULT;
>+	return ret;
> }
>
> static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
>

