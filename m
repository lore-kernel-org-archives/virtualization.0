Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA963EC830
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344289; cv=none; b=CPaLYy1FAp9WArUQ7NIIg8EeggjWPTLziQGJRx8nvzVQ7epsVyf/2an+dEf3l2/q4aN0TL8kYwR0XJv5d5m9eiX63rce77h3hJ66gFky09SDpMqpPzS5cW7L4zlCWFn3QWdTQNuIWIkVlru9LArIiGIAK48y1+RhfZKJZSxUtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344289; c=relaxed/simple;
	bh=8fA89PK9z5I6GQoA8Pvaip9JaaozQM+Zq5pnMNviiqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=km04E+VyOVOgUqJjSsu7lwd84ALmWMGyL89A5fRv03PvQHNe21acO5Hk0Kp7fmaVsUZ1fGbNQP0/ZKI5+8kvcB2uC6wHwTdRWm7g/4N5epIuPjnEAFUBND9tRO/WeklgWp2HVqFtTzYxvq96B36ek2b/pzh34RwuNAjsgRcPXIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqFEdxxh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqFEdxxh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785344287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4349OjOM4tqMiVdkoifOGbiGi3KfrSh42jsIQcBbS9k=;
	b=FqFEdxxhNtxmWueoDpZ1nnDdlo8yT+4vCZQGQbUtw9GPBUQh6Z6xB5FdS/fvqaKvLJFUAp
	53j8EZ9cuNqzEqSfCBdlyEOQb588ZMLpq+/1XChgU7RXPyUvYIhwOyfob+swdPqdt6IUTo
	B0Kzg9wO+wRtFZKuDqoaykFpl03nv38=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-K-zP5E0GOPerZ4ltkAiukQ-1; Wed, 29 Jul 2026 12:58:03 -0400
X-MC-Unique: K-zP5E0GOPerZ4ltkAiukQ-1
X-Mimecast-MFC-AGG-ID: K-zP5E0GOPerZ4ltkAiukQ_1785344282
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f83a59e5aso1378216f8f.0
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 09:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344282; x=1785949082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4349OjOM4tqMiVdkoifOGbiGi3KfrSh42jsIQcBbS9k=;
        b=HTp4OjH9NsE3hNDr51cKGvDDgO0jnjKisEQfzR3hDQ9EKj+Q9p/fww+sCq4CYiH4fB
         22j/ljL2OTAu8na85LY9aM+rYP9EAiwdP9XZCjx+eL0xATxns1LmKq6h6Ji19bMLeX7J
         yoTXnFjzOvZCB0jnHJ6tJT++IaY5sf2siCH4M57SHIFh54EZ5lMx6Woj9RmD22BAsxff
         uI5k6VSg8Ix0TfDF+JKMXcyUrqhThzldUuVa/X4eqfRhBw+cJK1LzcB15Nvsslk/9yx9
         /t297OtkFQDFgiqxn2Xh/qnG2rLs6Mpce/5FZAnMPM8snYd8w5M8rxxtfjlv6+I8HW03
         0vAw==
X-Forwarded-Encrypted: i=1; AHgh+RqnbgsleeCYKGj6QjOxScwORFXLNqwv8AtGt/85y1dBqGEcEALzpMr5QTpYYLE6N5k9+BmHG5TlHyC8bBWlFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWz5OGLJDuFCyqwZyIobmLIxjkdYeK9BJNcc1FjJEXAvsj1fX7
	G1NzQpTLEq072uSb7kIHnYLIgmNbFtmuRrglG9SUKrwP+YfBIWmIY/xNoYBy2PlMV+uDPalRFK5
	Fv8Egg9QIoQ5MOe7BD9C3AQSNY70HBt2hkTqPIr1wY5IKeYBnP/v086PPZPzeYBeF1bJW
X-Gm-Gg: AR+sD12Le5CuumbAAUMCkloBOpoBuah6/9E4Zsq0QuUeE5kN5Eic6SOkr4Rs/WUJD67
	Hal7hbuQfeDga36ui1/PUc2vGkjpl7OPtmqFgLrzqnKinGumrSuaE3muF8PTqJCvjRg5i+gpLuZ
	thh0akvAicc1alHXE/f0CKD/JiOd4uC5aUjEr+ZJ+zy82GfC1mAa89zxg2OmJMevU10ywm8uYZ8
	R4Rxl9uhdbwK0UECQg+yZ1FOIPL3LYQxOYoNvRYaWn1JFwhsCIjwBDnI/V0x2624k4Al4GBre43
	Tf/aehIw0g7ibsmb8+sigQ1j3z7eZUfMsfARcaaRo7rbN0NEftujWUziuJtCg2Bq7zSbAC+MVKS
	GgOaFiHabjIV+2xJGUYpoZmHdDxXwBaXpAr8RL/ukwXk=
X-Received: by 2002:a5d:64c6:0:b0:47f:7427:8ce9 with SMTP id ffacd0b85a97d-47fb1ee75c5mr9353816f8f.51.1785344282015;
        Wed, 29 Jul 2026 09:58:02 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:47f:7427:8ce9 with SMTP id ffacd0b85a97d-47fb1ee75c5mr9353791f8f.51.1785344281535;
        Wed, 29 Jul 2026 09:58:01 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef1asm9778480f8f.19.2026.07.29.09.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:58:00 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:57:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <amow-BG29pG3eSCd@sgarzare-redhat>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260724114542.734623-6-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724114542.734623-6-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m1gaXMcZuLEm1wweaetixacaTnRADbnNixYK5NOiquE_1785344282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 24, 2026 at 02:45:42PM +0300, Andrey Drobyshev wrote:
>From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>
>This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>the guest with vhost-vsock device.  For this to work, we need to reset
>the device ownership on the source side by calling RESET_OWNER, and then
>claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>AF_VSOCK connection while this happens.
>
>To that end, unlike the release path, RESET_OWNER keeps the guest CID
>hashed: established connections survive, and host sends issued while
>the device is between owners simply stay on send_pkt_queue until the
>next device start drains them.
>
>Since the device stays reachable through the CID hash, the lockless
>send/cancel paths can race with the worker teardown in
>vhost_workers_free().  The previous commit ("vhost: synchronize with
>RCU readers when freeing workers") makes that safe.
>
>Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

I thought I had already reviewed this, but anyway:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

