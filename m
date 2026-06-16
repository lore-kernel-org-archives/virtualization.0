Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F12D7DF8
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616944; cv=none; b=a8yPKM88R11dvYiMUD89lbi3zLrDG3QxOIBYUtMSePTJOICcaFgy9ThPPV9CgZOUT8uo2ZqGaLHHQ/fmX6dB/Y+Nvt3AEBIxtAanMMhb8p2tGdtAf3Jn7qN2gtxpVsZrdHZ1SXWTwcGT0U2YEo2xBtG8O++fqXRPxnZQMyQf3c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616944; c=relaxed/simple;
	bh=floBdjdCkfcczlUBmvJASMGyf5DyrXJjY+5qz4ctWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sYvKtOAbq9nfcs4pgZQyzqnRZCXWMqTbYCRamUSc9XG/Tk4gpSvMrCILdd0+XdSE1BEWnrNrKPQECwVS3sLgC5lIO3FHwDSvZHihjskB6EAqQp8h1lqMrQEEnSOR9T6f/xXiDkWVmbxcTsapY2feZ+13v6PXx1Dzm1SPBx/2yF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMYWd2db; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMYWd2db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781616942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
	b=FMYWd2dbyaF/Va9FGSYFHxAKCpEQHWhprGgrHpCcHqHgEBrrYZ03HnCkjv1VqnxxSZT/9A
	7aKqRhDynZ8vaUFxSLlNGprgb7hC7TPs6cEh7DnJlma+lMDbxomqYKx2zBYFHPacHRMN2K
	DYKj/Yc9vkotE9fFmxShGkDgrCYPOyw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-xqLARfhwPm2U4SUtn6X3qQ-1; Tue, 16 Jun 2026 09:35:40 -0400
X-MC-Unique: xqLARfhwPm2U4SUtn6X3qQ-1
X-Mimecast-MFC-AGG-ID: xqLARfhwPm2U4SUtn6X3qQ_1781616939
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b37e1f48so31427665e9.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 06:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616939; x=1782221739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMvcIb0SSmVD5ZpReBVCmF4OYpfrO6nfm5qCtnbjlbs=;
        b=V0b+YKnnre/x0QLQaCJlFGXyQ7pVfRwHJqhzwuKc8+IejBJtcwLGre5547oIjuo9rw
         EnPFthA7PQgC9IaPTr/PpcxV0zkqSoE4/DQ0QMZ+XFLM+JOtnphvmSkqndQQKhMFFhsb
         j/nN2gItrp7B0241dkm66zTRnG49QYFlmNNOsu8rhrrDvCTKFO/ZVNyQ2/aXQQmwHqJZ
         srYwdu7cKpM6eD6KCHmVjt9BqyW+1RZ3QE7bNK8bwOkR/EIR9skU0rnvqH+kLTlciz0a
         31gg7//epedlwxI1bHm2G3koTjH23aH7PgBi+HzHLIE9qk8XbF2fsjACR5mfwTaZFwAw
         BvOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+iTLXR+5m49Cb6V7HSOQAfuHTvySFzotBefphOqllBSNfWebJ6BjTGCyF0TRZol3hydBeHas89GlkHgcr05g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVU6qKzAviab4EVjtQck9VVakUbLEq1MEpSOr3QhH4d1jDrX6+
	/p6jioyIkYON+da9qxrciUWeOGGthn+fr3hNA3PuzCWF5kn0JCMCOf0M38d9ks55M9yfgRDpuF3
	y70s2ZurjCMSGYaDWP/3p4fRu1/bCbacGQMRCFOJ3kOBA7rCpPuwgmAOOyLIeRQ06n+yO
X-Gm-Gg: Acq92OFMPE/bl/wCrCUz0rUUlY2xXBJrrDk6UtyNRuMTjVFoTlJYwMpxtpdJ2uEiRKE
	26EUYQRYk9qhNfJi1jJvm6i5UaPMwpcL8F69We4qEVSUDoRupXFjOdF6HFHfaLjtVR3JPUEkQkf
	PhaCJ1IGAfLbzPvdBINarU7MD3YenHUEh4MWpqIj5zeZuomZmC3+17f8vQkPwJQgZwcRCTtWWEU
	8uNjwRTjJA7xZy1beEA8SzAb2jG/M1TN67qnW80N0KN90bDedbWxmDVoi78mpTjF2DtyVMlbUt3
	tAlXknLiL9SuygOKo8ezPDD37xzvze5mzabWnqBmnLKrC6T2SU9r2ffXmjCG4GnS2EBq6qnt+iW
	4F2Qa1gFzlArkgOrCvOaJd1H8bb3Nu90TwhMcNFQ5YzzRY8HOMtrQ4Ho65m28fm+6CtKr3SA=
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4921fcb3ffemr168841215e9.0.1781616938908;
        Tue, 16 Jun 2026 06:35:38 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c3:10b0:490:c024:2ec8 with SMTP id 5b1f17b1804b1-4921fcb3ffemr168840785e9.0.1781616938426;
        Tue, 16 Jun 2026 06:35:38 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa890d8sm89760905e9.10.2026.06.16.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:35:37 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:35:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
Message-ID: <ajFLvKcT-A0wvLYW@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OQeP5aFw1XQxxL0w5TO88tB5n46PJvhMZSQWaxgNTfg_1781616939
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Andrey,
thanks for the series!

On Fri, Jun 12, 2026 at 07:57:14PM +0300, Andrey Drobyshev wrote:
>Host<-->guest connections via AF_VSOCK sockets aren't supposed to
>outlive VM migration, since VM is moving to another host.  However
>there's a special case, which is QEMU live-update, or CPR
>(checkpoint-restore) migration.  In this case, VM remains on the same
>host, and we'd like such connections to persist.

In the spec we have VIRTIO_VSOCK_EVENT_TRANSPORT_RESET which is usually 
sent by the device after a migration.

IIUC the specs don't say this has to be done all the time, so we don't 
need to change anything in the specs, right?

We just need to avoid sending it (which I think is what we're doing 
here... I still need to look at the patches).

>
>For this to work, we need to be able to transfer device ownership from
>source QEMU to dest QEMU.  Namely, source needs to reset ownership by
>issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
>calling VHOST_SET_OWNER.
>
>Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
>such implementation (patches 1-2).  Also fix regression introduced by
>the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).

If it's a regression, should we fix it separately?

Or is it related to this series?

>
>There's a complementary series for QEMU [0] adding support of vhost-vsock
>devices during CPR migration.
>
>NOTE: this series needs to be applied on top of Michael's vhost/linux-next
>tree as it contains relevant commit [1], not yet present in master branch.
>
>I've tested this (patched QEMU + patched kernel) approximately as follows:
>
>  * Run listener in the guest:
>  socat -u VSOCK-LISTEN:9999 - >/tmp/recv.bin
>
>  * Run data transfer from host to guest:
>  socat -u FILE:/root/bigfile.bin VSOCK-CONNECT:CID:9999
>
>  * Perform CPR migration during transfer (either cpr-exec or cpr-transfer)
>  * Check that file hash sum matches
>
>[0] https://lore.kernel.org/qemu-devel/20260612165110.431376-1-andrey.drobyshev@virtuozzo.com
>[1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=bb26ed5f3a8b
>
>Andrey Drobyshev (1):
>  vhost/vsock: re-scan TX virtqueue on device start
>
>Denis V. Lunev (1):
>  vhost/vsock: suppress EHOSTUNREACH fast-fail during CPR pause
>
>Pavel Tikhomirov (2):
>  vhost/vsock: split out vhost_vsock_drop_backends helper
>  vhost/vsock: add VHOST_RESET_OWNER ioctl
>
> drivers/vhost/vsock.c | 80 +++++++++++++++++++++++++++++++++++++------
> 1 file changed, 69 insertions(+), 11 deletions(-)
>
>-- 
>2.47.1
>

