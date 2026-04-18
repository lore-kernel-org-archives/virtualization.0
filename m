Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55140DFC8
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776471221; cv=none; b=QXWNTGKmNQryV9crkkjaJVMdiWdJJSmV7+upiviRk9vxUWmcyQTEsQv4rWfVY8LY8ERGUjfHSL1syA6pEZ+HYiBPugonHpfvHN/MHDw2DKHbZ36mPQtsrpsp2tcj96t6KroDN3jrn/zQWzovN+WkTywEFwUnMRbwr9nrYRNeRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776471221; c=relaxed/simple;
	bh=t413uR2z+VC95wnVTYrHIk0J3dXWJAB9CuV5ei4kcJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tDXvHFYpaE2UXQ7pSKaISwK8Bac8iZp0pTlx6PYPfueR44lIaXnW9/d8cR+jrz9bYVa5xayS/UPLcZXjYedPsk8uiA4ufc9fDKK7pY6iy3VNJdeGZglgbiJfPndD8MaiOBgqeEKh79M1WxvCJqla7TtAelGkB3uNH8b8oPVODMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJn7zydr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJn7zydr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776471219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DLc6i5hTDljAXhin+tlCr4ec80GPJxXVTT+TZFT5DQo=;
	b=NJn7zydrZgkShAJqv3bt9FObmLpWlnDOafon91IILFTIatMKq4EhQ889wZa+cYrc60YNAy
	bsepouMmEYl37mGSzlrnu/g8DphC6xxAP2qFeEkCu6W44NIBe2VkbxorPywwqF+bdr3/7/
	a2ClKY4XKdJX5TZN2b7Y7P3za4IsLco=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-M1k_UgJGOmKlBS9JKhvkrg-1; Fri, 17 Apr 2026 20:13:37 -0400
X-MC-Unique: M1k_UgJGOmKlBS9JKhvkrg-1
X-Mimecast-MFC-AGG-ID: M1k_UgJGOmKlBS9JKhvkrg_1776471216
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d77286244so741206f8f.1
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 17:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776471216; x=1777076016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLc6i5hTDljAXhin+tlCr4ec80GPJxXVTT+TZFT5DQo=;
        b=NwAc2vn1PClfO9Xn9TY6X3v8wih8IzKABNDZylN7fjAury/SRb6G0SYTPMF8V9gFkQ
         9YRwzsyyAV3tHcpYcMpqjI7KGd8zjPxLb5tGByzBXWlxyJh68M5DB3kYeASRY6i1+GFZ
         KWgxaG3+Xerhkox/GEUjxqDlsFOrafQ8vpbPMG4i2FIW4gZqaolM4MKFreU9kJDWpSsM
         EeHU6aJj6R0WkRojMsuM//8rcKRfiKehpZX5XiGe7zKyXzpktlgIBncJFddk09kvO5W6
         0QfjY0j+1dKz4q51C1PKqlBIsRqTTowGgy/Vuwek0NvYLLtuZH12LhSUQSDdQOB+qiil
         vetw==
X-Forwarded-Encrypted: i=1; AFNElJ++VkHe7mIl24/GU5CH1dcQdJwH4IerfahDEpPGchaJDJfCRjbeKyXnSGes3Aml0P8w/Kjd70RZAkAdwq9Kvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA8WcjV2liQZShitPP7KyYG/S2cBQTxu51tkKJRMPMUaGTxH6R
	3VWFJqw7kqDWjMa6f8fj1sAU96+ukK52FdpqXz3HLPKQOAyUo1022HQitvGX5uk5OhTTdHeiAUe
	vASBjYlMml9/5G9zs5zbR9ng3Qpe54kjpe0Cy+uOsoFKMVCmqWDV3qP0pcEDGD8snWBxP
X-Gm-Gg: AeBDieu1v8BAtmZxg6R7SnGs9JfAAOmnDxpq+S1CpPqFf3AZBMDIVkXs2EJ3FRkZBFt
	lHRqhV9bGLaoYn08NDwDNT7J5lawSA7efcfFBxdiW4+7RgJeSmBG+peGudG/dlRoTvSppq7JeXt
	nqROz9XQd/cEiUgDR20UJl67vcMFWpC1iOwhdGt1/dS1TFoUQ1NokbVqXKffKlhHqfuYVuV0PX0
	wG0JZaKdvTXaEgWsb2e6Z7d+8LPcnXr0QV5RaHHuOG71KnqapEz5IZmFtkEiXnNjvJJxF4w4T8O
	MJ9oQTcIKR2TGXR3YIX+G1Xs27Tt2Of43Aj5sLtRIPnp4PlyQ1DoNuQh8ljJahfXeFs4jq9JvyS
	l6y2rdoCSmOVZORqRLl70qDYdcPGX29iqCwmlp/2R35SpT0GLUmmAUA==
X-Received: by 2002:a5d:588f:0:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43fe3dfd4aemr7384210f8f.39.1776471216324;
        Fri, 17 Apr 2026 17:13:36 -0700 (PDT)
X-Received: by 2002:a5d:588f:0:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43fe3dfd4aemr7384180f8f.39.1776471215734;
        Fri, 17 Apr 2026 17:13:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm8364547f8f.8.2026.04.17.17.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:13:34 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:13:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH] hwrng: virtio: reject invalid used.len from the device
Message-ID: <20260417201129-mutt-send-email-mst@kernel.org>
References: <20260418000020.1847122-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260418000020.1847122-1-michael.bommarito@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IBNKYZCz2euoqHOK-oM_WUVI_taOiIEnBQj7Jf7tEpg_1776471216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2026 at 08:00:20PM -0400, Michael Bommarito wrote:
> random_recv_done() stored the device-reported used.len directly into
> vi->data_avail without validating it against the posted buffer size
> sizeof(vi->data) (SMP_CACHE_BYTES bytes, typically 32 or 64).  A
> malicious or buggy virtio-rng backend could set used.len beyond
> vi->data so that the subsequent copy_data() in virtio_read() issues
> memcpy() from vi->data + vi->data_idx past the end of the inline
> array, reading adjacent kmalloc-1k slab bytes into the hwrng core's
> buffer and from there into /dev/hwrng consumers and the kernel
> entropy pool.
> 
> Exploitable most clearly in threat models that do not trust the
> hypervisor (confidential-compute guests on SEV-SNP or TDX; vhost-user
> split backends).

Exploitable? I don't get it. How is reading this data into hwrng
a problem?


> KASAN confirms the OOB on a guest booted under a QEMU 9.0 whose
> virtio-rng backend has been patched to report used.len = 0x10000:
> 
>   BUG: KASAN: slab-out-of-bounds in virtio_read+0x394/0x5d0
>   Read of size 64 at addr ffff8880089c2220 by task hwrng/52
>   Call Trace:
>    __asan_memcpy
>    virtio_read+0x394/0x5d0
>    hwrng_fillfn+0xb2/0x470
>    kthread
>   Allocated by task 1:
>    probe_common+0xa5/0x660
>    virtio_dev_probe+0x549/0xbc0
>   The buggy address belongs to the object at ffff8880089c2000
>    which belongs to the cache kmalloc-1k of size 1024
>   The buggy address is located 0 bytes to the right of
>    allocated 544-byte region [ffff8880089c2000, ffff8880089c2220)
> 
> hwrng_fillfn is a kernel thread that runs as soon as the device is
> probed; no guest userspace interaction is needed.
> 
> Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in USB transport layer"),
> which hardened usb9pfs_rx_complete against unchecked device-reported
> length in the USB 9p transport.
> 
> With the added len-vs-sizeof(vi->data) clamp in place the same
> harness boots cleanly: the driver logs "bogus used.len" once and
> subsequent reads wait for a honest response.
> 
> Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  drivers/char/hw_random/virtio-rng.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 0ce02d7e5048..6cff480787ca 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -47,6 +47,18 @@ static void random_recv_done(struct virtqueue *vq)
>  	if (!virtqueue_get_buf(vi->vq, &len))
>  		return;
>  
> +	/*
> +	 * The device sets used.len; a malicious or buggy backend can
> +	 * report more bytes than we posted.  Clamp before it reaches
> +	 * copy_data() which indexes vi->data[].
> +	 */
> +	if (len > sizeof(vi->data)) {
> +		dev_err(&vq->vdev->dev,
> +			"bogus used.len %u > buffer size %zu\n",
> +			len, sizeof(vi->data));
> +		len = 0;
> +	}
> +
>  	smp_store_release(&vi->data_avail, len);
>  	complete(&vi->have_data);
>  }
> -- 
> 2.53.0

