Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B947ECC1
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713444; cv=none; b=GY12Bbsb6j2UFePA+/zN1d0PiBiUpeeVIpMgwIQV3B1fpEAe7HjDpMVWqFPulniOKA2Y/OeVIkNF/qWdGwEdvI0eAs6T8A/3crCVAmhMVPKyyspd8WW7wRKcnrW3x26mcukBvC4Vl6C2urWPSBdyWmqooVePbt3ehdAkIRoDWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713444; c=relaxed/simple;
	bh=lOwARzZKfPn8sQ+Z5RWIh2PjsWgxiRWHG5/38qBJEHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H4ZGCtdOgtnn4SIP0U/bxRjwIOiSQRxb5ZCFqE/XVqgmx8RT5KWA50cpazGNdrVr4o60eDPK0Sjmf1mz/Yp3e8TnpvkJcYBdchfTRYtZovi3q5FJaxaVmhczqIa23ueb3DHaGvQE85aG6ofFxyqH4qFrmY/hB8lIClkoZ6txuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJHzf7c6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJHzf7c6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784713441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P6FuAEzBLuYs8iPbKk5rWp3C26BiKFrVufL8wR17fYA=;
	b=VJHzf7c6yekDNRsgQSSBWL4IjKMuoaMJNM7i5dHIC4tec5B/n51cThSGeBLLWVW9r9boIm
	CJMC82+mUXASJtg0B50LzAhjzwwssJAhphqLNwpSm6rRkphlxTP2/2VjDqHTDbfd/U36ED
	Ystvfnsr6o0z8HKltRO5mWOCQ0jBAJk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-Tdb8wW5sMi-TH0nc8Of8QQ-1; Wed, 22 Jul 2026 05:43:59 -0400
X-MC-Unique: Tdb8wW5sMi-TH0nc8Of8QQ-1
X-Mimecast-MFC-AGG-ID: Tdb8wW5sMi-TH0nc8Of8QQ_1784713438
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955edc851aso17747665e9.2
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 02:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713438; x=1785318238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P6FuAEzBLuYs8iPbKk5rWp3C26BiKFrVufL8wR17fYA=;
        b=p67Ar+OeiSavGB4hxzNzM4NItpk8tOeqTY+SlVqJEO4fUVfET1SaGMgidhYIaX1UNW
         ws8PMIc01MhfW2VuKv28iggIq4rLaihHetMMHTrdQ3c/vtrd67COva8vnPYUsp9weFqb
         xrlegOWNdKxgWJtFiGMBznyF+d9rp0G4NnhHnnBuT7yDMYezDEcpBXynVyXQhSmRhSlr
         DtaNMnCoe9ZdOOSERKCtrwp4UQyXeYwAlshD6CTw8JxoPFxdcTwVl838uz8rV9lBe7R9
         Q5HXoMzlqenSGX9qD4Z/Oy7sEr7YA32NsmdiJVpG/JeEoqYD3HMMxd9gPGP8mEshSogw
         A1Dg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4kRozc0VOADpSzLlYh6Zkn8kox1yeHOJqNfFZMbrHdQnGPsqinLUb2EKww9OO5fzpWfc93GbvPmMfgG0F5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwgNBDXH3W5A6Mf98vrdMRzbO2XOEXi+hUpOzmvLVSWhFnn5Gd
	X8vQ8r8hRKwJ4QeVwYrqdlFHEr0criVV8PmvFfRBy14jStPXwwrJv17du1ntd/aunses0BEy7oS
	NQevk8ZHpZxrStAlxvJ2QwR94xoq9EFQlanf4n3LwpRCXXMtC+H+3e/R1t0c3JN78UBH8
X-Gm-Gg: AR+sD10MyzdZY7G0y4RWgPjoit88jsygTsaY8EOHVrj/cCT8mExfy0Y6MoniPd3JUi4
	Ia96pIB6gDQGJ1bJRNsufRA2gFVCuxfmmUoDT+CjJHsOPUpYhvkvbXLTRDrgVkPkGoZ9X0jszID
	BvzlbFTLOT5OKbU95y19Ino8KujaHSDNfQ7tig79evg1aEJtrmEMEaXMJhij1zRaI4lekxO6W7v
	8I+y7Nmw7ZSMMLiOsVuDlF7HPRMBZwhAj7Uvu53xORwlqSqcSOGdBieP32VYHliInLGwzHkC/CR
	IMV3QsdEYhjM1SpKyJlRJTOhVChebrikMJHdLkEYfYif0AXWtRE8VrlkOmap2xWYtjIHCh6T4IM
	z6POACvsLY7f8ndsMe0lBshD2Qs3cAVB+y0cHGBwz3Ckj7yHCZQ==
X-Received: by 2002:a05:600c:d4:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4954a3dc3admr173160685e9.14.1784713438315;
        Wed, 22 Jul 2026 02:43:58 -0700 (PDT)
X-Received: by 2002:a05:600c:d4:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4954a3dc3admr173160315e9.14.1784713437719;
        Wed, 22 Jul 2026 02:43:57 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c6besm124593995e9.8.2026.07.22.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:43:57 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:43:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 5/5] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <amCQyzvUwdy9KLzj@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-6-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260720102241.371610-6-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: isvvgnDiRvFtTsiKtQFiihEg0gXKeHOLhkCixbfJ2L8_1784713438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 20, 2026 at 01:22:41PM +0300, Andrey Drobyshev wrote:
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
> drivers/vhost/vsock.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

