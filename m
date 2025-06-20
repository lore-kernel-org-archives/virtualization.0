Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6813E30E857
	for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408344; cv=none; b=htTyI3Wc8xNLJjSxay0DVUCWllQKl0f2kBhAx9UQ5FIrrUDlvTuPPKCmsvOlI+mAvBY28h5lWWESpceSBLaCrTd9YYeORRcYyLkQNYQFsUrQ4je1e+WNFj4GHcohnBxMghnKC1gfK0QXDO7I8mvygpQzwoRs9tsmDqheCQTE1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408344; c=relaxed/simple;
	bh=5YOM2lPpH7PXWuJm9EXV7JiVObmQ3cui1GYbQMMQ0kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RIMe5+jX2JcW8A7uud1MXFKvkX1Er3dIlkoQW+DfD/3fFWqoaG2PXtKJsT1ZRepmMBQ7CW9/xROh4iFvuHz5ThcULzS758Mwv0KrLXQvC/zeVEutilYJbu0aZfUL3cgu31U4yUHqkSy+G76lwzy9pF+4FzjOHz3jcpKLhATw/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cP4nr17s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP4nr17s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750408341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EELna4tg5NHVDqDl5GH+k+fVb8iZXQcOHnkW1YCeC7k=;
	b=cP4nr17suy8/PRPPRHP9HArF3yEb43/p3sSMt3JsYswJziH+xsb+PLT+nxTyJuD1R71mMY
	oNQINvT4q+EUPrW4bUzsO5tE6FpTkposn1UQViVBXdMh4GxXQsHXBUUZdQzzgvNVRxaN93
	zAU7LEBC4KFkPqTheqOlQvXgCaz1B48=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316--yM1WZ3NO9eHx6OJ-MHniw-1; Fri, 20 Jun 2025 04:32:19 -0400
X-MC-Unique: -yM1WZ3NO9eHx6OJ-MHniw-1
X-Mimecast-MFC-AGG-ID: -yM1WZ3NO9eHx6OJ-MHniw_1750408339
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311b6d25163so1508981a91.0
        for <virtualization@lists.linux.dev>; Fri, 20 Jun 2025 01:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750408339; x=1751013139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EELna4tg5NHVDqDl5GH+k+fVb8iZXQcOHnkW1YCeC7k=;
        b=srF2/EFYSrJnLSMtFOvakXVBF1v7V/waUM///JO9PTJ3jNC6Ld3fqN/hEfSB4wBG8R
         B0Ifqjam5Sy7jYpn9oxtw69DQZpbNhInTHotflYNa9DHiMnAXUZ21mbtRVJk10CUZqV5
         wr+bk/50OrQj97ltsFuTRyEahoh5YYTrVGW7hIPbSXqVHS2/xZmzy0Hrnrev2ZUYAFd6
         rVuvpGhJ0nh7P9RlPeqlc4fQLNA5LcOMsOHtEX7IsIsHkElRDvTIMSDcBfglCAWs/rU+
         bepaUKaHwJkfLF79vqyMHA6X5vhHGxS3Mc2qctma275bQGA8QvLxGBUILOLPDVsBQwWL
         fIug==
X-Forwarded-Encrypted: i=1; AJvYcCU+uk2Y28DpyUZam/xjvrPhxCC3NBjj3vkMPDTJ9ShBh2eK6A5T9OL/WF3Ui/J6NnvB7YaaABHTsMkhBDOO1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzx2Ld3MRXi+JywaQKI98gcwLG8+xqUyuEHdzq7o8oPdEXzNat6
	UH/BjvIQT9qvxNRLP9w+l5e4nRguLplWkJ1Rc8D0uxTpBv9kx2CEiDE9l/FFw1SWv3pHWVJPKDd
	VFQui9jeBmGrpsZDS61151iDEOfi+7Ukeskg7Sk2485fXXY8yTx9KKgTHzns6Qp2PmOD3
X-Gm-Gg: ASbGnctSp1KFRg3yvvxGt31OYstjnF4pI05Sm1NubNZEQNJ4HiDxKuJFhrBVW++0wpU
	2Z37NJyci+zgqQ/jGQDVkOO/OOfXydesF40EEMdsXMkaKxga5C2oqLFAEKPMJBpF/V0eUsgXjcE
	EQzICvUAatVpjcKRLI8p3LlZvNzlbvtR07cznszrezw5UaARsVQ7IHa09DJykqP+6AMANnoTIKq
	TE4Lgx6oSkn/jXCaGsqbwWN69JDWhqPOdxIc1FtR0qUdu5nGPqHfPqTdz6VFHl0J3ZmChJOo4mG
	q9MJoxEl4/Q/3OFDxqA1eHvfELUO
X-Received: by 2002:a17:90b:51c3:b0:313:17ec:80ec with SMTP id 98e67ed59e1d1-3159d8dc9a8mr2836312a91.26.1750408338649;
        Fri, 20 Jun 2025 01:32:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpEPY7m8XnpO27bAGr683g+jQ02JBIyUY70+ykZ6RPi1orD37Zz6VwI1lcx8EihVOJArcpTg==
X-Received: by 2002:a17:90b:51c3:b0:313:17ec:80ec with SMTP id 98e67ed59e1d1-3159d8dc9a8mr2836275a91.26.1750408338174;
        Fri, 20 Jun 2025 01:32:18 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.182.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8614baesm12447485ad.137.2025.06.20.01.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 01:32:17 -0700 (PDT)
Date: Fri, 20 Jun 2025 10:32:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] vsock: Fix transport_{h2g,g2h} TOCTOU
Message-ID: <r2ms45yka7e2ont3zi5t3oqyuextkwuapixlxskoeclt2uaum2@3zzo5mqd56fs>
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
 <20250618-vsock-transports-toctou-v1-1-dd2d2ede9052@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250618-vsock-transports-toctou-v1-1-dd2d2ede9052@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h_lYvr7s2er_SDM5aZrI7C0zmM0vSliarffaLXnfHbk_1750408339
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 18, 2025 at 02:34:00PM +0200, Michal Luczaj wrote:
>Checking transport_{h2g,g2h} != NULL may race with vsock_core_unregister().
>Make sure pointers remain valid.
>
>KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>Call Trace:
> __x64_sys_ioctl+0x12d/0x190
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 2e7a3034e965db30b6ee295370d866e6d8b1c341..047d1bc773fab9c315a6ccd383a451fa11fb703e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2541,6 +2541,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
>
> 	switch (cmd) {
> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>+		mutex_lock(&vsock_register_mutex);
>+
> 		/* To be compatible with the VMCI behavior, we prioritize the
> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
> 		 */
>@@ -2549,6 +2551,8 @@ static long vsock_dev_do_ioctl(struct file *filp,
> 		else if (transport_h2g)
> 			cid = transport_h2g->get_local_cid();
>
>+		mutex_unlock(&vsock_register_mutex);


What about if we introduce a new `vsock_get_local_cid`:

u32 vsock_get_local_cid() {
	u32 cid = VMADDR_CID_ANY;

	mutex_lock(&vsock_register_mutex);
	/* To be compatible with the VMCI behavior, we prioritize the
	 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
	 */
	if (transport_g2h)
		cid = transport_g2h->get_local_cid();
	else if (transport_h2g)
		cid = transport_h2g->get_local_cid();
	mutex_lock(&vsock_register_mutex);

	return cid;
}


And we use it here, and in the place fixed by next patch?

I think we can fix all in a single patch, the problem here is to call 
transport_*->get_local_cid() without the lock IIUC.

Thanks,
Stefano

>+
> 		if (put_user(cid, p) != 0)
> 			retval = -EFAULT;
> 		break;
>
>-- 
>2.49.0
>

