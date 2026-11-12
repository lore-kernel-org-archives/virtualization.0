Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502970;
	b=joNEDfctDt55ndNYKKsHQwZifYifzSkTZKoivJdfc0MAik/50RgY1voB0dqbUG72Tdm8
	 y+CUrLXegnCHjLdLxCvAtC453gZNomQpvSaLvsPAvXF0PZ1IhsJ1WF/+8jViFnKeo39AX
	 MeT7aQNf6GmL7udDvNolEQl5tLxSYToKCWVB72AnopwYyAowAiSB5+aHrun5AciNAdsxg
	 K9t6y5b2s9blmCBc9EVXxOVuHpsCtk2WuVxJBkio/Ez4LhUOoCI/L92rGZLEF/Xg+1Ry7
	 qQKshCrTqVQH4Q5DrCCwUD7YVHzJDy9WgsD8Mn35escgBCq0OHPowJ8cgJ/G345e5vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502970;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
	b=ZHDcTxYXnTpzTN/xFrq8IlIyfNnPfGb17hL5jWDTQYjqO8jsa5ZbC7rH6EUh8I40map/
	 i9DG+LwNdAd3YiQMHGl3P6Jsmv+cLruzOC96OUzF4zja6WprsYP7TTpXiTqzQRzldKDp2
	 aBr/e8XqrexW+G9FUImQJwrRrzSoA8JPCfjtl2HQjxZg7J6KZufkv6JNdfClRQ0sjAB7m
	 5zB57vQoSNE9rOSbRe1f+Szi/ogeC+2r9GLm/r0+nL8W/cJ+t1230p/pAZM1cVmFDNmu0
	 yO0ucDtHipWo31pNOWQ4sLcJWU7BXlf3iWPcgXBwQ5eRxvDilDUTjtL+oOXE0UjTKTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQ3lHNAj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B6606A32D
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 17:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3B6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UQ3lHNAj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794502968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
	b=UQ3lHNAjeOXsmCES4hWjxHOYer6q8c+25QErNO+A2n1KnP5/5APW2ESjNvPWYQc56JgQEN
	MZGJmmOZMVt05+xi0OZ8C8iW+paIyNhLJDRnWxxOJm0h/+h2YbWmcNVg9v9IkOfsSl1Fnb
	kudmPfuvFpNzGevPcZUjA7CKnZWu05k=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-6z-FMEx1O9SWIQ1-JjCUUg-1; Thu, 12 Nov 2026 12:02:46 -0500
X-MC-Unique: 6z-FMEx1O9SWIQ1-JjCUUg-1
X-Mimecast-MFC-AGG-ID: 6z-FMEx1O9SWIQ1-JjCUUg_1794502966
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-70b87b40030so4822532eaf.0
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502966; x=1795107766;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4SSAg38Nw3BE7JWsNPS6tFWOPRz76x2WFPMI2JzvcWc=;
        b=ROVlwjabJdxESLVROMrdnbVHi6EZ8ClNBcWLE4eLGISHPVQjwxV/NfJ7zblF6yUtLE
         ftQgn20DWNZ1eTySWJIQ0J7zjT/zNoV/eGmSSSvdkTwfjTCPzal+T1Wp0aCZL3zDWOHd
         6gziVWfxvbgv+e/7inZpJYZk76MntKfi0K8wu96hS/Z0eW0HC6bf4os4dcMI/rpga7aN
         nseEGXgT2m3EDGVdiZ6SrgBdr51Bhw/Z8yZHH1zHWnJt0znCrUyIwjJVdaF3tpsVZ7Ap
         IU8A67i4UoPfvEWgT7ie6VBWZFrV+JpiOf0PZrlchKE912iVzNTrKB7kPPizDJyxke3j
         F9LA==
X-Forwarded-Encrypted: i=1; AL+hErEgVD+KBjFB4K2E8h3+9Ip3y5kPh7dbKCWGdQwgLiYTmWgJJilBRZa38UTRp0AQAIkYETlyNWwCbMZGt884og==@lists.linux.dev
X-Gm-Message-State: APuU4Z/0IaQd2WNJQ8iZDoKH3C18Y+iR7yksVl3/CFpkjFbwlIiHBI+X
	aLw6mv6ig69lbG/1O9Np8EBqKplZ4q4UdWEQ6kdebG5cO+IEb6TFNi1YZw/8zlwHHJqTY+tlYCb
	NUXqEW99NQ5hcdfEc2E6/0ouAOnU9O3pXiINfa7tqHRsicK8lnS3v6Pdt/gkkQPYMoGr0
X-Gm-Gg: AYBFou2GzkW2gJw9/cQAKPw2ZNKwIYXYdjueA7BpFOiNUorwN+b7TLhc22cL7lyhshy
	tn/6OZ1P9IVENS3bumSaT63hfy+thlb+yxTYx+ODOt6VdA+TSIzriLvSHtpGk+fmqLBIWA0UItU
	MtLqoHmQCmrP2tPDe2xl2ZrFA2SHhbW0gdYIHG5pIWfjBPjjLCxQEiM2wPJhrtuN7LwGHjfzUIO
	cw66xdW4wF/lZ5r2tT06u5mxP7ALc7FRDbyF47SPETZRPwDrrJH93sZGcvFT90hAW9wPrqq3le4
	xodyGLdc63BQQphFrvUKVVlcm6Z1s1kUNhdEsv11ngynTlohdKrYbserz8HD3jMJga0n+AfHYZL
	J+2eFFvNe7dyCgob31ViBPEWuQBskcIypAfldiuUycHcY3thldr3Q
X-Received: by 2002:a05:6820:83c2:10b0:6dc:e1c3:b2ac with SMTP id 006d021491bc7-7191798a171mr2797274eaf.73.1794502965985;
        Thu, 12 Nov 2026 09:02:45 -0800 (PST)
X-Received: by 2002:a05:6820:83c2:10b0:6dc:e1c3:b2ac with SMTP id 006d021491bc7-7191798a171mr2797227eaf.73.1794502965373;
        Thu, 12 Nov 2026 09:02:45 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6a1c7sm5433524fac.6.2026.11.12.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:02:44 -0800 (PST)
Date: Thu, 12 Nov 2026 18:02:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v4] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Message-ID: <avXxFnqVLMgBMjBP@sgarzare-redhat>
References: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pS013iM9U06JmZUzebvIir0lH95mOM5VXipQ_iE4NZg_1794502966
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Nov 09, 2026 at 08:39:24PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>virtio_vsock_vqs_del() frees the virtqueues but leaves vsock->vqs[]
>pointing at them. If virtio_vsock_restore() then fails, the driver
>stays bound with a dangling vqs[], and the next freeze or unbind
>passes a freed virtqueue to virtqueue_detach_unused_buf():
>
>  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
>   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
>   virtio_vsock_remove
>  Freed by task ...:
>   vp_del_vqs
>   virtio_vsock_freeze
>
>Clear vqs[] after del_vqs() and when virtio_find_vqs() fails. Return
>early from virtio_vsock_vqs_del() when vqs[] is empty: the detach
>loops would pass NULL to virtqueue_detach_unused_buf(), and a second
>del_vqs() would free virtio-mmio's IRQ again, which only WARNs in
>free_irq() ("Trying to free already-free IRQ").
>
>Found with the help of Anthropic's Claude and reproduced on virtio-pci
>and virtio-mmio by failing the restore with failslab, without other
>kernel changes; the virtio-mmio WARN was found by the netdev Sashiko
>review and reproduced with v1 of this patch. With this patch neither
>report appears on virtio-pci or virtio-mmio guests, and the vsock
>vmtest.sh single-VM tests pass. A find_vqs() failure after some
>virtqueues were set up was not exercised.
>
>Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
>Changes in v4:
>- Say why the early return is needed: the detach loops would pass NULL
>  to virtqueue_detach_unused_buf() (answering Stefano).
>- Say in the message and the comment that freeing virtio-mmio's IRQ
>  again only WARNs (Stefano).
>- Move the send queue purge before virtio_reset_device() (Stefano).
>- Message: the use-after-free also reproduces on virtio-mmio.
>- Rebase onto current net; rebuilt and retested on virtio-pci and
>  virtio-mmio, and the vmtest.sh single-VM tests rerun on this version.
>  The moved purge ran with an empty send queue only; the ns_* tests of
>  vmtest.sh were not run (they need root on the host). The reproducers
>  are available on request.
>- Link to v3: https://patch.msgid.link/20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de
>---
> net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

