Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5543DB636
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711703; cv=none; b=XXNGLgla9A+XGfPuOesgfiIylZahv2iINzdDrjc8EAHFQJvY5aq9z3jmK1mD2MkJRPUKS3uB/YiBn/8xC4tQHnlsE3EjFMR0qcJpz4cqtliYN9rSS8I82bb1aM8rNlbRx08nDtRBoeMzSWs/lLiELokj+V+a8xZDIPdG1lv7pMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711703; c=relaxed/simple;
	bh=ij0mEyGqqpAB+MTW4VTiY1ayxaymUfWl8B5riM+q6+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LUSV/EetIuIW6IAE4loffFPIUN70hdMlcEI3X3UhxGMXWo26nQobBeyvntH61hk39ZJCrUtcHCkqNJU66y89X7RQS5yz5p5h006bsMsxNJCoAh9eyiAbAz60TdqZzoviC4lpt+txoz7CVp3ENQuHHkqelFq9GqL/aCeL7Hn6Lgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDXmR97/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDXmR97/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784711699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIWmYsirlfTwtwLrg8PTuYInqgKC4lp7bGK8C3SZZwk=;
	b=bDXmR97/02T5m9tfQoKol8Ijy7/iXiPZPZd8sBTNeu/rkeyfr9MMw5YZvNu1mcaW+hDXnE
	aDNGzg3v7A8Nkn7NMjPFkmzjW0DTmU0GOzQTAyH04hfA2BDtoi1um5BDp9aHe8/ODhTiJ1
	/+oVJr/PSCgWzh+acSGsP84UW8grTEE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-f5bfDF-wOOmAPeqwtH3y1Q-1; Wed, 22 Jul 2026 05:14:58 -0400
X-MC-Unique: f5bfDF-wOOmAPeqwtH3y1Q-1
X-Mimecast-MFC-AGG-ID: f5bfDF-wOOmAPeqwtH3y1Q_1784711697
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f84ac1990so443803f8f.2
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 02:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711697; x=1785316497;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HIWmYsirlfTwtwLrg8PTuYInqgKC4lp7bGK8C3SZZwk=;
        b=MtV50kKJo1Lp6fLMPuCClmmXFU23+fYDJffiQIpwetDLk0ue2R4B/6uUe8HjzE9XZr
         7gdGoo+7Ps4+6q/oCY8UWXRnIxHWK1pXvLmKXlgUgfYkupyv9CWB83g5CEcrSi1oYi9N
         s/aXjog8Z1JrWseKY3nH8b34by0c944TQI9XMvVShNR4L6ehbJ0sBiTsWnQeT2BMUgnR
         jFz9goi3xYCrrC8Isy7V3O0cuwEZETzfoFM/pDv2UfWEmtG6+0BVmLngG26FHsnazrCY
         kz5U/hAkyuQuDHa48L4qLi5kZ1N79q65DOP4dEmdxVDxuAbGGg7zOZ6aZDOUtnVF2pl7
         sgSA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0AhJqXPJIvoFEGEsF7c49pFuuF1SNQv/Y4Zy61VLYAUxZF8xmYQvyacbTZejrA2HXtgAp43e3enXbpqQc9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwY3l3qkvT95Mw3bJ7v2XAsweKiCigcXjue0GeCXLD+XB6XhFkD
	zrWYdXEvv14Ey23aenNSLYwuOLD3LRD4dhZayuBkgXTMVRSPX6IzFSb1dXRJ7xBoxmoJVg28hYu
	xs83y7Mr+yChglR+YY9qC+jONWjPzFIl5ttQrfxRthdpkqVmPALIYPlZ6f2/bhJAb7ETU
X-Gm-Gg: AR+sD13eDbwcxu8xaYM4k+dmGM8eIkhZkLMPU1xhkKF/t0gD0WvJZiLquPrbOg4hXqC
	kbF6ksmKMyIm/03xAjdWtZIE3sTGzFCOYn7EM0yF+MYBGuEpMZq0cbIMCQs/QluJ8XmGHYQG7y4
	fT6ld6b9nT34ztD6pRBMMDtyuXyMl+eFLgLg5jC59awBBmifAEHRcZ+k3NDOXutlj7wTnkXQGDC
	2jhDmRc/xQQbkl1vqKFafGqkKV9fP4TSTF7egSfJIKm3n4jBmG7l9yfjXF1HhWhV52T6Bsvla8a
	PqVSGCRjW/7iyWiUAQJMYJlPZSu25BDiG9wWZfKvpVpN0DOZbw1gf5d2nPJ2jjs+4yKIk/MotUf
	CGffKedy3Zp1NHbTxc6uEvMM7DevZq2s6A9k/AS6+gU6YviXhkQ==
X-Received: by 2002:a05:6000:178c:b0:47f:71dc:d848 with SMTP id ffacd0b85a97d-47f71dcd8d9mr16850984f8f.12.1784711696926;
        Wed, 22 Jul 2026 02:14:56 -0700 (PDT)
X-Received: by 2002:a05:6000:178c:b0:47f:71dc:d848 with SMTP id ffacd0b85a97d-47f71dcd8d9mr16850922f8f.12.1784711696414;
        Wed, 22 Jul 2026 02:14:56 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm4619604f8f.7.2026.07.22.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:14:55 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:14:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 3/5] vhost/vsock: re-scan TX virtqueue on device start
Message-ID: <amCKAp08S68JWXRf@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-4-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260720102241.371610-4-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6eBKKeqX1x1e0wfT3ie760IkS06j8YlSckWisPWwlwY_1784711697
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 20, 2026 at 01:22:39PM +0300, Andrey Drobyshev wrote:
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
>The issue itself is pre-existing, but it only manifests during a device
>pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced
>during active host->guest socat data transfer under multiple consecutive
>CPR live-update's.
>
>To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>queue the TX vq poll so any buffers the guest enqueued while we were paused
>get scanned.
>
>The VHOST_RESET_OWNER ioctl itself is implemented in the following
>patch, thus this patch is a preparation to support VHOST_RESET_OWNER.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 7 +++++++
> 1 file changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

