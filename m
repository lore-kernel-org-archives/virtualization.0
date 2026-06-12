Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9331ED8B
	for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271063; cv=none; b=pv+TMsqbY6/ywuhK1eArURRW4ovPySR6Zvm941F44gLLy22/5YzwD+I8kyXcc8ih+rnzHvbCa9mpryhnyS278RKxetPoIWSC05voRWmvz2OhuS5nzlSgTBEC/3znK/81Ye5VPe7GAhCPlno45Xtk9TyvwAOibH9L2ioaHyijp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271063; c=relaxed/simple;
	bh=o6C89312xo3o8VBjH1GVjeqa52tCtDyhVrUewQ/dMSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=barBixVAOFCu6O0KhoBiuhjalXBZxZKyWtwfV3hZJZXnG5cTwJCOvNDd/9B8IFyLukkIE5Ledh4g72RUVvvM+ZLOPHFj3Ow3pDN7gdxREJTylETe3gKhLGNh81C1nk00Qb/CaFYsPzYmpwhMFCJLnzNyyGq8VZJD0XcfD4xFobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOfZli7D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOfZli7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781271061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6C89312xo3o8VBjH1GVjeqa52tCtDyhVrUewQ/dMSU=;
	b=KOfZli7DNFOBj3HMRxgWQRYPoCVU2IQVMj9uAdT4RwZBgwABMyovkT1TBm0tytexGcYFWf
	4vnOm5uh2qIv9ERai8ha03n5zM9a4nFX9/eCvxLG4xgrkuWqq9G+VUx8pfQEC3I3ns1cnt
	GjudmrCnzXNfozsoH34R/etI4Mgw1II=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-RtWKgRgANZijd486fmDt_Q-1; Fri, 12 Jun 2026 09:30:59 -0400
X-MC-Unique: RtWKgRgANZijd486fmDt_Q-1
X-Mimecast-MFC-AGG-ID: RtWKgRgANZijd486fmDt_Q_1781271058
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b2f22ea2so9023615e9.1
        for <virtualization@lists.linux.dev>; Fri, 12 Jun 2026 06:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271058; x=1781875858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6C89312xo3o8VBjH1GVjeqa52tCtDyhVrUewQ/dMSU=;
        b=l1Rusjs09T+gjn7n7hrUd0abwMGFcpP0ttnzvilXkRtPHraMxMQiqRvHaZZstrVxlB
         7FD+3CfK5D0Tqvhz9T1vQn6W4uRFZTxomzkcr09dT5izIRMXAQN97HWYgVK79Md9Jc0y
         bV8a60/PgPD7ojXCLL19XzKb6EvAXHtHP4UT6mMpMLnh2mtlLra9x6/CuC+8TTRrocrR
         8rJw8RFJ+iNeTf90rnGC2NTUWhzCBWb7VFWBWGEBql8Z80S2/uVLGhWlHHcvWcudJo8l
         tZNo/ykAWmXK5H/Op0bw0R2Ci4aJLWO/xj/JhI2Segep2m2+Vd3mnm4PvK9UQlCGRRSt
         eSMg==
X-Forwarded-Encrypted: i=1; AFNElJ9HMeaiSYVmyhqeCgsaspC9REcJlxU/JHjxnnP/oA5/uItV3dOKi3vDuRZU6jPglemKn72sIXmUqm+HUxvrCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTn7tRfvyJMwow9OR+T40URv0xpyjFMKpLMmaMKbwNZ3onvBnc
	f7URCH/l9+7vDfimmHjUOePvfEAKmnSisqw+caX7ov3QiZeuUki+ZEZgluG0Dg22w5/c07SPkm5
	9mEqH0alKHXlpTFS6w9SlIxgPYfdSl0E2edCWZ3hgtwGwi7dOV7y4QMC8VgLHH2ATe/z1
X-Gm-Gg: Acq92OEvYYJ4RA6Or5/yb+JIbs34ooOgveGdfEjSBPYxrHJRY7dEmg00FZ8aw3zqBP2
	0dOonVtIqfzyvfjLcORh6R/3Oi6xZraJCHoNSLwUa2cSJlvNN21qQHoM7yXWnvJbfOZ0aE1UgY0
	uRimTswa3k57OBRaIfVnnMQw74RPvkBfmbINxHxdBhGgLA3xMbsvB6uLMosHo4vjdJlfQDiA0Lx
	hi75HAiYvGeeoYDPMeC0UkaACusFkscCqPicYy0b8zZRao8HBEU+uPwmYU4IuoeehhQ07xNVDmC
	msPsK9jfiaM/GuNGcmH78QRXYBKv1ggNWiZalvKfELzGYpuhQgnS05sbcmLW0/M3HC2YclgP6Dx
	XTKIHhrQLxvcuHxqb7wYirIAORVwRXbFCENwANxnfdkx6ww0x1uP797tv4iQ=
X-Received: by 2002:a05:600d:6413:10b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-490ec4b5a6dmr29663715e9.3.1781271057719;
        Fri, 12 Jun 2026 06:30:57 -0700 (PDT)
X-Received: by 2002:a05:600d:6413:10b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-490ec4b5a6dmr29662925e9.3.1781271057178;
        Fri, 12 Jun 2026 06:30:57 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c0960sm60228985e9.3.2026.06.12.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:30:56 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:30:54 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	bobbyeshleman@gmail.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock: introduce
 vsock_pending_to_accept() helper
Message-ID: <aiwJ96DvyETyJ_IB@leonardi-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260612045216.105796-2-rafdog35@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nwnqhsc2juOldP0ywnVo7qoF4hxqFK8LWRL11EJubyc_1781271058
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jun 12, 2026 at 04:52:13AM +0000, Raf Dickson wrote:
>Add vsock_pending_to_accept() to move a socket directly from the
>pending list to the accept queue in a single operation, avoiding
>the sock_put/sock_hold dance and the sk_acceptq_removed()/
>sk_acceptq_added() pair that would otherwise be needed when
>calling vsock_remove_pending() followed by vsock_enqueue_accept().
>
>Use it in vmci_transport_recv_connecting_server() where a completed
>handshake transitions the socket from pending to accept queue.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

