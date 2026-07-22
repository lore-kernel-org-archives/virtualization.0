Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4773DB636
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711674; cv=none; b=CNvbevHuthB1RkdMVaHFhwCelgixlfBorsnHAtYQHlFAKbNPx+J5Vys5gUTSX+reT9FKx53fcK2VwTRJcV4PmMTqbe3ItEV3rzyOF7sZE6dahzIIwxiLON8iK9rSIcHxLN8g9xhhfGyvmcQedgbIXpdTRvFvHbSWLSJ/0tEH2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711674; c=relaxed/simple;
	bh=sHMU9orKt+3dFz7svwzy6sHxokwx9yHspoPZi9pCSqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=etyGdyut8H7UHG/NofLbbVem+VoFT4WYfrfquBsqRBwI1qIcW6ejKSzzCF7M2uXr7kiPhANeHWm64Dru4BnfziFv5M+MkEnUpz7lKk0yjq8j/j7xEa6ZSxWdOlViJLj9zK8XFFQ52f3jhTZiwekPH6XqxPwOAF7gYhYPulIRT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWoqrEje; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWoqrEje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784711670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=COubnejOb/3v47cpwE+v+WjurVSix4Lp7TgAJigf9YY=;
	b=OWoqrEjezHL3Tj8vluIiW5nbZ2c4syPaDnUMa/welSn2ixzN3Lhm84b8jtZUBfjyP1O93T
	IrsV2oyL7jGSCbANWMIyuT0g+wQCj4pP0wsT3p0Dwx0ByujfHtYP5IRAPG6ltyBcgyOfEz
	pt+7jhgzjXuGih2f3giBIrEfmzBDahA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-ckhOygCcOPmy46dsCp6bsg-1; Wed, 22 Jul 2026 05:14:28 -0400
X-MC-Unique: ckhOygCcOPmy46dsCp6bsg-1
X-Mimecast-MFC-AGG-ID: ckhOygCcOPmy46dsCp6bsg_1784711667
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47485fde05aso7331512f8f.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 02:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711667; x=1785316467;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COubnejOb/3v47cpwE+v+WjurVSix4Lp7TgAJigf9YY=;
        b=etUwxR4wJMasvkai3rEZ3CrJB/ndAX30HI2yyBVybRw3jI1PUHLY4MfG9pw/TguewJ
         bJy6CKJ3Kjw+ZidoF4B244OWLKBmEQRaVCNFC8smomWQubgrY8KUyuB111vW3ieBN0e3
         XDWPrevGWg2Rx6YjLgq9Vuizo9FDb2qB2LkpMvwgB+9xKmXB4X9RyIoZTkz2XKFXplh8
         3UEHBh43rZ8N5t6DA+vBDqdTX4xwocG0VH/pxV4TyGBskrY14GJX2qMbZueHbr5OhAEa
         xRJT6dl6ym6v+sW9kCX5p6sura7Bi1+Fr35hGRvsnr4sTtsu6FPax1yO8bPEl+qqCf//
         xUAQ==
X-Forwarded-Encrypted: i=1; AHgh+RoInjdcIPy2bW5ROB1hHydR0osFIrBP6ZZtuEvDn1F5g+RvsgaV9BuxbeK7XGBIJ9BAroW1i3UuzKpu5ux6gg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4uaabZvlX+1S+W8JnXIJ6Fg2gKtPl1BkkKIwXGmYUWvEr678W
	mQKfswWmlII1Tbw5FQGGmg842bu4qtIj47lgLmGNaOcKpf4GGdbiEPA+/FncJ24etx+mBp3EiDm
	abylMGsEmYuK2r4+FbPcIxsM5yntImIyGUymoU+k3ET6XupKEbT/k6FIeHtK355JwxPDh
X-Gm-Gg: AR+sD10dB80qc5+sbJwzygmIrglxcnaOY615jjPBrgH1dR5dL5ytCADFkjxw1Dv6YDW
	w72SgZao90EW+ewELQBT3IsTW4gXMY4Z6z1riFQne+7NeCflFUdFGkG+k2kJXd+PvGR3pBJzv/y
	UwajLZS+Jp4xDzMJzGLlE7Hx5KdVGV14+zB2qUZlDGOf7yRGP0hQ4EzFJyLNXbZ0M547UBe/v+J
	by5waC8e5XhokVOzT0yEQHIwr53Tdq8dppQy4IL3H55prs+lNISM/8l+ssctVYiubGasXUbihNo
	M3unHwq7M4gufRwdQ76CnQzeqJKYMtGydIeSwGa1PhCFRdIc5AbIDrHJeNHomKlHhB2C0V525r1
	Kbj6+JyOrpjiyByZiwPKArfYP61EkgmbDAYqhj/kmfk3qg/mvsg==
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr15702375f8f.3.1784711667398;
        Wed, 22 Jul 2026 02:14:27 -0700 (PDT)
X-Received: by 2002:a05:6000:402c:b0:47f:7759:89df with SMTP id ffacd0b85a97d-47f77598aeamr15702319f8f.3.1784711666793;
        Wed, 22 Jul 2026 02:14:26 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f8635c8d7sm3212686f8f.21.2026.07.22.02.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:14:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:14:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 2/5] vhost/vsock: suppress EHOSTUNREACH fast-fail
 during CPR pause
Message-ID: <amCJ4x8EGtHjVRM7@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-3-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260720102241.371610-3-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -oWUfc3DADeX_nVYXY8RSiEIXMf_13ej2Gc9Eh754ps_1784711667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 20, 2026 at 01:22:38PM +0300, Andrey Drobyshev wrote:
>Earlier commit bb26ed5f3a8b ("vhost/vsock: Refuse the connection
>immediately when guest isn't ready") added a fast-fail in
>vhost_transport_send_pkt().  It rejects every host send with -EHOSTUNREACH
>until the destination calls SET_RUNNING(1).  The fast-fail condition checks
>whether device's backends are dropped, and if they're, the guest is
>considered to be not ready.
>
>However, there might be other reasons for backends to be nulled.  In
>particular, when QEMU is performing CPR (checkpoint-restore) migration,
>device ownership is being RESET and SET again, which leads to backends
>drop and reattach.  If we end up connecting during this window, an
>AF_VSOCK client gets -EHOSTUNREACH, which is wrong.
>
>Add an 'ever_started' flag which is set once in vhost_vsock_start() and is
>never cleared.  The behaviour changes to:
>
>  * When device was never started -> flag is unset -> no listener can
>    exist yet -> fast-fail;
>  * Once the device starts -> flag is set -> we don't fast-fail ->
>    we queue and preserve during any later stop / CPR pause.
>
>The VHOST_RESET_OWNER ioctl is implemented in a following patch, and
>without RESET_OWNER the problem we fix here isn't manifesting - thus
>this patch is a preparation to support RESET_OWNER.
>
>Important caveat: after the first start, a connect during any stopped
>window is queued instead of fast-failed.  That was the behaviour before
>the patch bb26ed5f3a8b, and we're restoring it now.  However we still
>keep the behaviour originally intended by that commit (i.e. fast-fail if
>there's no real listener yet) while fixing the CPR path.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 22 ++++++++++++----------
> 1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

