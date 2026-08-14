Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D4432BF1
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694558; cv=none; b=to7Ae60a8X1uqVMvv0z+1rL2qfneazD95RvdpxkQrIL0xdAqX3tmZfjY3FTrXriNDEp2FcB/l4o/zEkLNON57jRKnhQhlYutpy4sbyIacT5eXKDJkg/n2AcOJM0iX0Z2xVQbMDOONOfWLMSIe4R1RQLYWSpLVY4vaYXhvsA5yh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694558; c=relaxed/simple;
	bh=Vc1VdbJaZLwkkuXSzA3lP748RejM2wNnDWqBh3Asdxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vCG6m0S9CsPoxZ66ui168MIx92NmlcDVkggfiuDkhn426I7pjJrrKv9Q6r17llUAM3v7uhPN5s3/n7tMZPx0TZzAsP6wv7/yriJ0LzjkxKQq0FjNCU9e9iuUWExncdGR8NEy2APBoz4YU1O264IJqjIV0tYxVneClVFNfyXQu3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LkjP6JmQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkjP6JmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuTGLTHVcUVUR8K491MTuND5/r0LYsPN8mtppCx6Zuw=;
	b=LkjP6JmQ1X3aG60uDRgK46fRi9ozhdu9p/Ik8EHjwPfUOC4sFqePJGgqd072gJQ08JbqtT
	LNQVAAMHLKLpamVCQSRdeolLRsFSSfDbQSpgYNcLVJvG+pkpsaVCbo3BJXU4M2+5GuI3lE
	acP9+nA9Z7Xi1IueExU6eSXEynHWl1o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Nsn94-zLNxKTxsn5u8XKuQ-1; Fri, 14 Aug 2026 04:02:34 -0400
X-MC-Unique: Nsn94-zLNxKTxsn5u8XKuQ-1
X-Mimecast-MFC-AGG-ID: Nsn94-zLNxKTxsn5u8XKuQ_1786694553
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so7491195e9.1
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 01:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786694553; x=1787299353;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuTGLTHVcUVUR8K491MTuND5/r0LYsPN8mtppCx6Zuw=;
        b=K7ymFuF8H773pYAOscEmsFCYm9ECdKf3brDwGEWHaYfBxYj/P+cOCJZnIVokMIvUBQ
         J84ddhzwBsmAO58OnRQl043Ox9D4ulbWnqVs/HyrlyjeosYC9feF09T2Lieo/Vh1vj/p
         +bBz9mZGkme6ngCVMqF1s5M/2iIdrDdfpWQCbaSnaX4Eo1WD8DFi359vNaq0fRdZcV+N
         7S0PT1CzrYGeidn1jEW/SGMczhabXUZiDVIwyw40FZ4YM/5q5Cb8hKRaXnoh06K38wKc
         /cKCEDEqIfmxfIbLX+0QBVnRU7Dp8i4yeSLbGd+UY6mfKb33JRBN2XgUnwSTk8SpEv7S
         iZ0Q==
X-Forwarded-Encrypted: i=1; AHgh+RpIA9WCBrhEdCvQj8hmPskoN8XbbrhIPpAtjoK7ij0qCWTy1AYTMaITdDhWpa/SC4rHCL6Vt2izs+K60jbeEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd3Hd918MZOA+kucK2zI4ZnxbgC08fFJLP1ythe+kuZQKJMyKn
	GjcHVasmU5Q7cH17giVRDHPuEg0D3og9qn8JYCWQqeZteE6oAY0HEATfelFHDnta+snNYfZ/b/5
	62NlYJIxz8o5BO/dA171BvqBKa6Dhz4kcvVCUrgks2zpzPkFNwCw8PHdCyUyQAd5WX7dh
X-Gm-Gg: AR+sD11rB2kL5F+smtq+2RiDn7qCOf87rMJhFnLjlyVLlRCUIVLgWq/l8+dmOlL4l4S
	sI9atMVJt+tyAUtrMM60u/LhHOA7NNFzfUMAGCp3+lwDhgHGZyZ+UcZMFDOfHI3SB9+0+G+1NY6
	dWsw5jfj94i3kjB3fiQmShh7kRz6fxixDNlfrUBnEVFDjKRkqwAPlMOvKC0CQMev0Ya11XNwctZ
	O9WxW2NmWazXeia110S8Gj2cGGzohHXC7/O/SK3BaKsN2v4r2H/CW6LtqQn3edwV7k/E8ZKFXEF
	N/Yn4CQUsGmJvRjfjCa5zEw3rmXYgRxpOhcUwOvjJbjdow5L657CDVm5tbGAO8Cc4vu2SiZ1v2D
	rGnlsQgUk15dZqRCXEVGOSQKUm/8j4OQaClFZSFlKViXYT1VRqRna
X-Received: by 2002:a05:600c:3e15:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-49987999622mr51703125e9.17.1786694553399;
        Fri, 14 Aug 2026 01:02:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3e15:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-49987999622mr51702145e9.17.1786694552788;
        Fri, 14 Aug 2026 01:02:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988adfbd5sm33234215e9.1.2026.08.14.01.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:02:32 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:02:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Message-ID: <an7KyotZ5vZOURu2@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-4-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260814072903.124991-4-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: maPmx62Mp86a6AjUreBKpcS9CiFRLx2gAU6_CMdh2D0_1786694553
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Aug 14, 2026 at 03:29:03PM +0800, Jia Jia wrote:
>VHOST_SET_FEATURES is also used to update logging while a device is
>running. When ACCESS_PLATFORM stays enabled, allocating a new empty
>IOTLB on every call drops valid translations and forces avoidable
>misses.
>
>Initialize the device IOTLB only when one does not already exist.
>
>Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b69c260eaeff..9142fa1143b2 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -869,6 +869,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 	    vsock->dev.iotlb)
> 		vhost_clear_device_iotlb(&vsock->dev);
>

Ah, okay, now I see why you did it in the other patch, but if we move 
dev.iotlb checks in the functions we can still do that.

>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    !vsock->dev.iotlb) {
> 		if (vhost_init_device_iotlb(&vsock->dev))

IIUC vhost_init_device_iotlb() handles the case where dev.iotlb is 
already initialized and override it. Here we are preventing that.

Will we do the same in vhost-net? If yes, all the callers will call 
vhost_init_device_iotlb() with `dev.iotlb` NULL, so should we remove 
that behaviour and add the check we are adding here inside the 
vhost_init_device_iotlb()?

Or there is an use case where vhost_init_device_iotlb() is called with 
an already initialized dev.iotlb ?

Thanks,
Stefano

> 			goto err;
>-- 
>2.34.1
>

